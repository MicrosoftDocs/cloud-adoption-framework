---
title: Enterprise-scale BCDR for Azure VMware Solution
description: Use this enterprise-scale scenario to improve business continuity and disaster recovery (BCDR) for Azure VMware Solution.
author: sonmitt
ms.author: martinek
ms.date: 10/18/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Business continuity and disaster recovery for Azure VMware Solution

This enterprise-scale scenario helps improve business continuity and disaster recovery (BCDR). [Azure VMware Solution](/azure/azure-vmware) provides [private clouds](/azure/azure-vmware/concepts-private-clouds-clusters) that contain VMware vSphere clusters built from dedicated bare-metal Azure infrastructure. The solution provides a minimum of three ESXi hosts, up to a maximum of 16 hosts per cluster. All provisioned private clouds have VMware vCenter Server, VMware vSAN, VMware vSphere, and VMware NSX-T Data Center. To learn about the service level agreement (SLA) for Azure VMware Solution, see [SLA for Azure VMware Solution](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/).

Whether you have an on-premises or Azure VMware Solution, you should consider various BCDR factors to prepare for a disaster. A robust BCDR plan aims to protect a company from data loss, financial loss, and downtime if there's a disruptive event. The following decision tree shows various BCDR options available for Azure VMware Solution.

:::image type="content" source="../_images/eslz-bcdr-1.png" alt-text="Diagram that shows a flow chart for business continuity and disaster recovery." border="false" Lightbox="../_images/eslz-bcdr-1.png":::

 > [!NOTE]
 >A pilot light environment is set up with a minimal configuration, with only core components to support a critical set of applications. However, it can scale out and spawn more hosts to take the bulk of the load if a failover occurs.
 > For disaster recovery of compute and memory intensive Azure VMware solution workloads, the same amount of storage is required at the secondary site.

## Business continuity design considerations

- VMware vSAN storage policies on Azure VMware Solution are implemented with storage availability in mind. When the cluster has between three and five hosts, the number of host failures that can be tolerated without data loss equals one. When the cluster has between 6 and 16 hosts, the number of host failures to tolerate before data loss can occur equals two. VMware vSAN storage policies can be applied on a per-VM basis. While these policies are the default, you can amend the policy to suit custom requirements. For more information, see [Azure VMware Solution storage concepts](/azure/azure-vmware/concepts-storage).

- vSphere high availability is enabled by default on Azure VMware Solution. The high availability admittance policy reserves compute and memory capacity for a single node. This reservation ensures sufficient capacity to restart workloads in another node in an Azure VMware Solution cluster.

- High availability with stretch cluster: With Azure VMware Solution, ESXi hosts deployed in a standard vSphere cluster traditionally reside in a single Azure availability zone and are protected by vSphere high availability. However, workloads aren't protected against an availability zone failure. To protect against failure, a single vSAN cluster can span two separate availability zones, called a vSAN stretched cluster. For more information, see [Deploy vSAN stretched clusters](/azure/azure-vmware/deploy-vsan-stretched-clusters).

- Choose a validated backup solution for the VMware vSphere virtual machines (VMs), such as [Microsoft Azure Backup Server](/azure/backup/backup-azure-backup-server-vmware?context=/azure/azure-vmware/context/context) or a [partner backup solution](/azure/azure-vmware/ecosystem-back-up-vms).

- For information about supported features in partner backup solutions, refer to the respective partner documentation.

  > [!NOTE]
  > vCenter Server and NSX-T Data Center configurations for private clouds are backed up hourly, and backups are kept for three days.

- Azure VMware Solution components such as vCenter Server, NSX-T Manager, or HCX Manager are managed services for which backup is managed by Azure. To restore from a backup, [create an Azure Support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

## Business continuity design recommendations

- Use Azure Backup Server to back up the Azure VMware Solution private cloud. For more information, see [Back up VMware vSphere VMs with Azure Backup](/azure/backup/backup-azure-backup-server-vmware?context=/azure/azure-vmware/context/context). Supported deployment topologies include [MARS Agent](/azure/backup/backup-architecture#architecture-direct-backup-of-on-premises-windows-server-machines-or-azure-vm-files-or-folders) and [Data Protection Manager](/azure/backup/backup-architecture#architecture-back-up-to-dpmmabs). Each deployment topology has its own support matrix, constraints, and limitations.

- Deploy the Azure Backup Server in the same Azure region as the Azure VMware Solution private cloud. This deployment method reduces traffic costs, eases administration, and keeps the primary/secondary topology. See the [Azure regions decision guide](../../migrate/azure-best-practices/multiple-regions.md) for Azure region deployment best practices.

- Azure Backup can be deployed as an Azure infrastructure as a service (IaaS) VM or within the Azure VMware Solution private cloud. It's highly recommended to deploy it outside of the Azure VMware Solution private cloud. Deploy Backup in an Azure virtual network and ensure this virtual network is connected to the same ExpressRoute that's connected to the Azure VMware Solution private cloud. Running Backup Server outside of Azure VMware Solution private cloud helps to reduce vSAN consumption, since vSAN is a *limited capacity* resource within the Azure VMware Solution private cloud.

  *Azure Backup Server deployed as an Azure IaaS VM.*

  :::image type="content" source="../_images/eslz-bcdr-2.png" alt-text="Diagram that shows Azure Backup Server deployed as an Azure IaaS VM.":::

  *Azure Backup Server deployed as an Azure VMware Solution VM.*

  :::image type="content" source="../_images/eslz-bcdr-3.png" alt-text="Diagram that shows Azure Backup Server deployed as an Azure VMware Solution VM.":::

- Use the [application performance requirements checklist](/azure/virtual-machines/premium-storage-performance#application-performance-requirements-checklist) to arrive at the right capacity and disk type, such as HDD, SSD, or Ultra. Consider the Azure IaaS VM SKU that supports the [disk type and capacity](/azure/virtual-machines/disks-performance) for backup operations.

- Use [Azure Backup Server capacity planner](https://www.microsoft.com/download/details.aspx?id=54301) to determine number of servers, storage, and IOPS requirements for each of them. When providing "Total Size of the Workload (GB)*” value in capacity planner, use median value between "used storage" and “allocated storage” of all VMs in vCenter you want to backup.

- Use [storage pools](/azure/backup/backup-mabs-add-storage) with Azure Backup Server for enhanced disk IOPS/throughput. Use [tiered storage](https://techcommunity.microsoft.com/t5/system-center-blog/achieve-faster-backups-using-tiered-storage-with-dpm-and-mabs/ba-p/1596069) on Backup Server for enhanced operations. Set [DisableWriteAutoTiering](https://learn.microsoft.com/system-center/dpm/add-storage?view=sc-dpm-2019&tabs=SimpleTieredVolume#disable-write-auto-tiering-at-file-system-level) config value to 1 on MABS volume so that the entire performance tier is available to store ReFS metadata.

- Identify the number of parallel backup jobs and restore operations to run on Azure Backup server. Currently, 8 parallel backup jobs are supported. Measure the amount of time taken to backup and restore mission-critical workloads over multiple runs. Validate that backup and restore times meet RPO and RTO requirements for Azure Backup server. Ensure than AVS vSAN datastore has enough capacity to hold restored backup.

- Add necessary Antivirus exceptions for Azure Backup Server files and folders as documented [here](/system-center/dpm/run-antivirus-server) if any Antivirus/Antimalware software runs on Azure Backup Server. When using DPM protection agent on any Azure VMware Solution VM for application backup(e.g. SQL, Sharepoint, etc.), disable realtime monitoring of *dpmra.exe*.

- Configure appropriate NSG (Network Security Group) rules on subnet hosting Azure Backup Server to allow network communication from DPM protection agent running on protected VM in Azure VMware Solution. DPM protection agent communicates with Azure Backup Server on any dynamic port [between 1024 and 65535](/system-center/dpm/configure-firewall-settings-for-dpm).

- Currently, Azure Backup Server doesn't support cross-region restore for Azure VMware Solution private cloud. Refer to [partner backup solutions](/azure/azure-vmware/ecosystem-back-up-vms) and [disaster recovery section](./eslz-business-continuity-and-disaster-recovery.md#disaster-recovery-design-considerations) when cross-region Azure VMware Solution recovery is required.

## Disaster recovery design considerations

- Align business requirements with recovery time objectives (RTO), capacity, and recovery point objectives (RPO) for applications. Plan and design accordingly to achieve these objectives using the most appropriate replication technology. For example, natively replicate SQL databases using SQL Always On availability group, or use a disaster recovery tool such as VMware Site Recovery Manager.

- Determine the target disaster recovery site for the protected Azure VMware Solution private cloud. This site influences which disaster recovery tooling is suitable for the environment. For example, if you want to recover Azure VMware Solution workloads to Azure native IaaS virtual machines, you can consider [Azure Site Recovery](/azure/site-recovery/avs-tutorial-prepare-azure) or [Zerto](/azure/azure-vmware/deploy-zerto-disaster-recovery#scenario-3-azure-vmware-solution-to-iaas-vms-cloud-disaster-recovery).

- Determine which subset of Azure VMware Solution workloads requires protection if there's a disaster recovery event. Consider categorizing the workloads based on priority: P0 for business-critical workloads, and P1, P2, P3 for other workloads that are important but not as critical for the business to operate. The customer's business continuity plan defines the priority levels, which helps to control the costs associated with disaster recovery implementation.

- In most cases, non-production environments such as dev, test, or UAT don't need to fail over to a secondary site. You should run the pilot light at the secondary site with reduced capacity for production and critical workloads to save on costs. For more capacity, you can scale out to add ESXi hosts to the cluster during the disaster recovery event.

- For pilot light deployments especially, ensure that you've secured all the host quota needed in the secondary site so that you don't have to wait for the required capacity during full scale out. See [Request host quota for Azure VMware Solution](/azure/azure-vmware/request-host-quota-azure-vmware-solution).

- Set up functional domain roles, like Active Directory domain controllers, in the secondary environment.

- Solutions from partners like [JetStream](/azure/azure-vmware/deploy-disaster-recovery-using-jetstream) and Zerto are generally available and validated on Azure VMware Solution. They support most disaster recovery scenarios and can provide faster recovery with near-zero RPO.

- VMware Site Recovery Manager, Jetstream, and Zerto support migration from third-party locations into Azure VMware Solution.

- [VMware HCX](/azure/azure-vmware/deploy-disaster-recovery-using-vmware-hcx) is also a cost-effective disaster recovery solution. However, it's not recommended for large production workloads due to manual orchestration.

- For disaster recovery between Azure VMware Solution private clouds in different Azure regions, you need to enable ExpressRoute Global Reach between both backend ExpressRoute circuits. These circuits create primary-to-secondary private cloud connectivity when required for solutions like VMware SRM and VMware HCX.

- For disaster recovery between Azure VMware Solution private clouds in the same Azure region, you need to enable [Azure VMware Solution Interconnect](/azure/azure-vmware/connect-multiple-private-clouds-same-region). It creates a routing link between the management and workload networks of the Azure VMware Solution private clouds for communication between the clouds. Ensure that routed IP address space in each private cloud is unique and doesn't overlap.

- When working with disaster recovery, you can use the same source IP address space in the primary Azure region and the secondary Azure region. However, it requires extra design and engineering efforts.

  - Retain the same IP addresses: The virtual machines at the secondary Azure VMware Solution site can be recovered using the same source IP address as the primary site. For this method, create isolated VLANs or NSX-T segments in the secondary site and ensure that none of these isolated VLANs or segments are connected to the environment. Modify your disaster recovery routes to reflect that the subnet has moved to the secondary site and the new IP addresses location. While this method works, it also creates engineering overhead when aiming for fully automated disaster recovery.

  - Use different IP addresses: You can also use different IP addresses for recovered VMs. If the VM is moved to a secondary site, the recovery plan within the VMware Site Recovery Manager details the custom IP map. Select this map for the change of IP address. VMs are brought up in the new NSX-T segments and new IP addresses are assigned. The tooling can differ for different disaster recovery solutions.

- **Important factors for partial and full disaster recovery scenarios:**

  - VMware Site Recovery Manager supports partial recovery, which recovers only a subset of virtual machines, and full disaster recovery. Between two Azure VMware Solution sites in region 1 and region 2, all or some of the VMs can fail over.

  - The requirement of source IP address retention for recovered VMs dictates whether partial versus full disaster recovery is possible.

  - In order to maintain the source IP address while performing partial disaster recovery in Site Recovery Manager, the subnet gateway needs to move to the secondary site.

  > [!NOTE]
  > Active-standby disaster recovery doesn't require Layer 2 stretching.

## Disaster recovery design recommendations

- Use [VMware Site Recovery Manager](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager) when working with Azure VMware Solution in both primary and secondary sites. Primary and secondary sites are also known as protected and recovery sites, respectively.

  *High-level overview of continuous vSphere replication.*

  :::image type="content" source="../_images/eslz-bcdr-5.png" alt-text="Diagram that shows a high-level example of continuous vSphere replication between two Azure VMware Solution sites.":::

  *Detailed example of continuous vSphere replication between primary and secondary sites.*

  :::image type="content" source="../_images/eslz-bcdr-6.png" alt-text="Diagram that shows a detailed example of continuous vSphere replication between two Azure VMware Solution sites.":::

- For business-critical applications, Zerto and JetStream are available as disaster recovery solutions for Azure VMware Solution private cloud. JetStream and Zerto are built on the foundation of continuous data protection (CDP), using VMware vSphere API for I/O filtering (VAIO) framework, which enables minimal or close to no data loss. It also enables cost-effective disaster recovery by using minimal resources.

- Use [Azure Site Recovery](/azure/site-recovery/avs-tutorial-prepare-azure) or [Zerto](/azure/azure-vmware/deploy-zerto-disaster-recovery#scenario-3-azure-vmware-solution-to-iaas-vms-cloud-disaster-recovery), if Azure IaaS virtual machines are the disaster recovery target for the Azure VMware Solution private cloud.

- Minimize manual input by using automated recovery plans within each of the respective disaster recovery solutions. These plans are helpful when working with either VMware Site Recovery Manager or partner solutions. A recovery plan gathers machines into recovery groups for failover. It then helps to define a systematic recovery process by creating independent units that can failover.

- Set up smoke tests or disaster recovery drills at least once a year to ensure recovery plans work as expected. The level of effort running these drills is determined by the orchestration capabilities of the chosen disaster recovery tool.

- Use [geopolitical regional pairs](/azure/availability-zones/cross-region-replication-azure) as the secondary disaster recovery environment. Some of the benefits of regional pairs are prioritized region recovery, sequential updates, physical isolation, and data residency.

- Keep address spaces different to avoid overlapping IP addresses between the two sites. For example, you can use `192.168.0.0/16` for region 1 and `10.0.0.0/16` for region 2.

- Use ExpressRoute Global Reach connectivity between the primary and secondary private clouds in different regions. See more networking considerations and recommendations in the [relevant design area](./eslz-network-topology-connectivity.md).

## Next steps

Learn about considerations and recommendations for the initial deployment of Azure VMware Solution and guidance for operational automation.

> [!div class="nextstepaction"]
> [Platform automation for Azure VMware Solution](./eslz-platform-automation-and-devops.md)
