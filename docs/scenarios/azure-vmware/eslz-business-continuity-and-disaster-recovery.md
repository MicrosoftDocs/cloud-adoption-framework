---
title: Enterprise-scale BCDR for Azure VMware Solution
description: Learn how this enterprise-scale scenario can improve business continuity and disaster recovery (BCDR) of Azure VMware Solution.
author: sonmitt
ms.author: janet
ms.date: 10/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-azure-vmware
---

# Business continuity and disaster recovery (BCDR) for Azure VMware Solution enterprise-scale scenario

[Azure VMware Solution](/azure/azure-vmware/) provides you with [private clouds](/azure/azure-vmware/concepts-private-clouds-clusters) that contain VMware vSphere clusters built from dedicated bare-metal Azure infrastructure. The solution provides a minimum of three ESXi hosts, up to a maximum of 16 hosts per cluster. All provisioned private clouds have VMware vCenter Server, VMware vSAN, VMware vSphere, and VMware NSX-T Data Center. Azure VMware management tools (vCenter Server and NSX Manager) will be available at least 99.9% of the time. To learn about the SLA for Azure VMware Solution, see [SLA for Azure VMware Solution](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/). 
You'll still want to consider other business continuity and disaster recovery factors because whether it’s on-premises or Azure VMware Solution, one must maintain business continuity and have systems in place to be prepared for a disaster. A robust BCDR plan aims to protect a company from data loss, financial loss and downtime if there is a disruptive event. This decision tree navigates through various BCDR options available for AVS.

:::image type="content" source="../_images/eslz-bcdr-1.png" alt-text="Diagram that shows a BCDR flow chart." border="false" Lightbox="../_images/eslz-bcdr-1.png":::

 > [!NOTE]
 >The Pilot light environment is set up with a minimal configuration. The setup has only the necessary hosts running to support only a minimal and critical set of applications. But can scale out and spawn more hosts to take bulk of the load if a failover occurs.
 > For disaster recovery of compute and memory intensive Azure VMware solution workloads, same amount of storage is required at the secondary site.

## Business continuity design considerations

- VMware vSAN storage policies on Azure VMware Solution are implemented with storage availability in mind. When the cluster has between three and five hosts, the number of host failures to tolerate without loss of data equals one. When the cluster has between 6 and 16 hosts, the number of host failures to tolerate before data loss can occur equals two. VMware vSAN storage policies can be applied on a per-VM basis. While these policies are the default, you can amend the policy used for VMware vSphere VMs to suit custom requirements. For more information, see [Azure VMware Solution storage concepts](/azure/azure-vmware/concepts-storage).

- VMware High Availability (HA) is enabled by default on Azure VMware Solution. The HA admittance policy ensures a reservation of the compute and memory capacity of a single node. This reservation ensures sufficient reserve capacity to restart workloads in another node in an Azure VMware Solution cluster.

- High Availability with Stretch Cluster - With Azure VMware Solution, ESXi hosts deployed in a standard vSphere cluster traditionally reside in a single Azure Availability Zone (AZ) and are protected by vSphere high availability (HA). However, it doesn't protect the workloads against an Azure AZ failure. To protect against an AZ failure, a single vSAN cluster can be enabled to span two separate availability zones, called a vSAN stretched cluster. For more information and stretch cluster configuration, see [Deploy vSAN stretched clusters](/azure/azure-vmware/deploy-vsan-stretched-clusters).

- Choose a validated backup solution for the VMware vSphere virtual machines (VMs), such as [Microsoft Azure Backup Server (MABS)](/azure/backup/backup-azure-backup-server-vmware?context=/azure/azure-vmware/context/context) or from our [partner backup solutions](/azure/azure-vmware/ecosystem-back-up-vms).

- For information on the supported features of the partner backup solutions, please refer to respective partner documentation.

  > [!NOTE]
  > vCenter Server and NSX-T Data Center configurations for private clouds are on an hourly backup schedule. Backups are kept for three days.

- Azure VMware Solution platform components such as vCenter Server, NSX-T Manager, or HCX Manager are managed services for which backup is managed by Azure. To restore from a backup for Azure VMware Solution platform components, [create an Azure Support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

## Business continuity design recommendations

- Use Microsoft Azure Backup Server(MABS) to back up the Azure VMware Solution private cloud. For more information, see [Back up VMware vSphere VMs with MABS](/azure/backup/backup-azure-backup-server-vmware?context=/azure/azure-vmware/context/context). Familiarize with supported deployment topologies with MABS (for example, [MARS Agent](/azure/backup/backup-architecture#architecture-direct-backup-of-on-premises-windows-server-machines-or-azure-vm-files-or-folders), [DPM](/azure/backup/backup-architecture#architecture-back-up-to-dpmmabs), etc.). Each deployment topology has its own support matrix, constraints and limitations.

- Deploy the Microsoft Azure Backup Server(MABS) in the same Azure region as the Azure VMware Solution private cloud. This deployment method reduces traffic costs, eases administration, and keeps the primary/secondary topology. See the [Azure regions decision guide](../../migrate/azure-best-practices/multiple-regions.md) for Azure region deployment best practices.

- Microsoft Azure Backup Server(MABS) can be deployed as an Azure infrastructure as a service (IaaS) VM or within the Azure VMware Solution private cloud. It's highly recommended to deploy it outside of the Azure VMware Solution private cloud. Deploy MABS in an Azure virtual network and ensure this virtual network is connected to the same ExpressRoute which is connected to the Azure VMware Solution private cloud. Running MABS server outside of Azure VMware Solution private cloud helps to reduce vSAN consumption, as vSAN is a *limited capacity* resource within the Azure VMware Solution private cloud.

  :::image type="content" source="../_images/eslz-bcdr-2.png" alt-text="Diagram that shows the MABS backup server deployed as an Azure IaaS VM.":::

  :::image type="content" source="../_images/eslz-bcdr-3.png" alt-text="Diagram that shows the MABS backup server deployed as an Azure VMware Solution VM.":::

- Use [Application performance requirements checklist](/azure/virtual-machines/premium-storage-performance#application-performance-requirements-checklist) to arrive at right disk type (HDD, SSD, Ultra, etc.) and capacity. Consider the Azure IaaS VM SKU that supports the [disk type and capacity](/azure/virtual-machines/disks-performance) for backup operations. Use [MABS Capacity Planner](https://www.microsoft.com/download/details.aspx?id=54301) for determining number, storage and IOPS requirements for MABS server.

- Use [Storage Pools](/azure/backup/backup-mabs-add-storage) with MABS Server for enhanced disk IOPS/throughput. Use [Tiered Storage](https://techcommunity.microsoft.com/t5/system-center-blog/achieve-faster-backups-using-tiered-storage-with-dpm-and-mabs/ba-p/1596069) on MABS server for enhanced backup operations.

- Currently, MABS doesn't support cross region restore for AVS private cloud. Refer [partner backup solutions](/azure/azure-vmware/ecosystem-back-up-vms) and [disaster recovery section](./eslz-business-continuity-and-disaster-recovery.md#disaster-recovery-design-considerations) when cross region Azure VMware Solution recovery is required. 

## Disaster recovery design considerations

- Align business requirements with recovery time objectives (RTO), capacity, and recovery point objectives (RPO) for applications. Plan and design accordingly to achieve these objectives using the most appropriate replication technology. For example, natively replicate SQL Database using SQL Always On availability group, or you can use disaster recovery tool such as VMware Site Recovery Manager (SRM).

- Determine the target disaster recovery site for the protected Azure VMware Solution private cloud. This site influences which disaster recovery tooling is suitable to the environment. For example, If you want to recover Azure VMware Solution workloads to Azure native IaaS virtual machines, Zerto is the only possible solution.

- An analysis and decision should be made to determine which subset of AVS workloads require protection if there is a DR event. Consider categorizing the workloads based on priority, P0 for Business Critical workload and P1, P2, P3 for other workloads, which are important but not so critical for business to be operational (this is usually defined in the customer Business Continuity Plan with well defined SLAs). It will help to control the costs associated with the DR implementation. 

- In most of the cases it's not required to fail over non-production environments (dev, test, UAT, etc.) to secondary site. Hence, it's advised to run pilot light AVS private cloud at the secondary site with reduced capacity for production and critical workloads to save on costs. For additional capacity, you can scale out to add ESXi hosts to the cluster during the DR event. 

- Especially for pilot light deployments, ensure that you have already secured all the host quota needed for Azure VMware Solution in the secondary site so that during full scale out you don't have to wait for the required capacity. See [Request host quota for Azure VMware Solution](/azure/azure-vmware/request-host-quota-azure-vmware-solution).

- Set up functional domain roles, like Active Directory domain controllers, in the secondary environment.

- Partner Solutions like JetStream Software and Zerto are GA and validated on Azure VMware Solution. They support most of the disaster recovery scenarios and can provide faster recovery with near zero RPO (recovery point objective). 

- Migration from third-party locations into Azure VMware Solution has support through VMware Site Recovery Manager, Jetstream and Zerto at scale.

- [VMware HCX](/azure/azure-vmware/deploy-disaster-recovery-using-vmware-hcx) is also a cost-effective disaster recovery solution. But due to manual orchestration HCX isn't recommended for large and production workloads. 

- To enable disaster recovery between Azure VMware Solution private clouds in distinct Azure regions, you need to enable ExpressRoute Global Reach between both back-end ExpressRoute circuits. These circuits create primary to secondary private cloud connectivity when required for solutions like VMware SRM and VMware HCX for disaster recovery.

- To enable disaster recovery between Azure VMware Solution private clouds in same Azure regions, you need to enable [AVS Interconnect](/azure/azure-vmware/connect-multiple-private-clouds-same-region). It creates a routing link between the management and workload networks of the AVS private clouds to enable network communication between the clouds. Ensure that routed IP address space in each AVS private cloud is unique and doesn't overlap.

- When working with disaster recovery, you can use the same source IP address space from the primary Azure region to the secondary Azure region. However, it requires additional design and engineering efforts.

  - **Retain the same IP addresses:** The virtual machines at the secondary AVS site can be recovered using the same source IP address as the primary site. For this method, create isolated VLANs or NSX-T segments in the secondary AVS site and ensure that none of these isolated VLANs or segments are connected to the environment. Modify your disaster recovery routes to reflect that the subnet has moved to the secondary AVS site and the new IP addresses location. While this method works, it also creates engineering overhead when one is aiming for fully automated DR orchestration.

  - **Use different IP addresses:** You can also use different IP addresses for recovered VMs. If the VM is moved to a secondary site, the recovery plan within the VMware Site Recovery Manager will detail the custom IP map. Select this map for the change of IP address. VMs will be brought up in the new NSX-T segments and new IP addresses will be assigned. The tooling can differ for different DR solution.

- **Important factors for Partial and full disaster recovery scenarios:**

  - VMware Site Recovery Manager (SRM) supports partial (recovering only a subset of virtual machines) and full Disaster Recovery. This means that between two AVS sites in region 1 and region 2, we can fail over some or all of the VMs. 

  - The requirement of source IP address retention for recovered VMs will dictate whether partial versus full disaster recovery is possible or not.

  - In order to maintain the source IP address while performing partial disaster recovery in SRM, it's required to move the gateway of the subnet to the secondary AVS site.

  > [!NOTE]
  > Active-standby disaster recovery doesn't require L2 stretching.

## Disaster recovery design recommendations

- Use [VMware Site Recovery Manager](/azure/azure-vmware/disaster-recovery-using-vmware-site-recovery-manager) when working with Azure VMware Solution in both primary and secondary sites. Primary and secondary sites are also known as protected and recovery sites, respectively. The first diagram shows a high-level overview of continuous vSphere replication. The second diagram shows the primary and secondary site components in detail.

  :::image type="content" source="../_images/eslz-bcdr-5.png" alt-text="Diagram that shows a high-level example of continuous vSphere replication between two Azure VMware Solution sites.":::

  :::image type="content" source="../_images/eslz-bcdr-6.png" alt-text="Diagram that shows a detailed example of continuous vSphere replication between two Azure VMware Solution sites." border="false":::

- For business critical applications [Zerto](/azure/azure-vmware/deploy-zerto-disaster-recovery#scenario-3-azure-vmware-solution-to-iaas-vms-cloud-disaster-recovery) and [JetStream](/azure/azure-vmware/deploy-disaster-recovery-using-jetstream) are available as disaster recovery solution for AVS private cloud. JetStream and Zerto are built on the foundation of Continuous Data Protection (CDP), using VMware vSphere API for I/O filtering (VAIO) framework, which enables minimal or close to no data loss.  It also enables cost-effective DR by using minimal resources at the DR site.

- Use [Zerto](/azure/azure-vmware/deploy-zerto-disaster-recovery#scenario-3-azure-vmware-solution-to-iaas-vms-cloud-disaster-recovery) if Azure IaaS virtual machines are the disaster recovery target for the Azure VMware Solution private cloud.

- Minimize manual input by using automated recovery plans within each of the respective DR solutions. These plans are helpful when working with either VMware Site Recovery Manager or partner solutions to provide disaster recovery for the Azure VMware Solution private cloud. A recovery plan gathers machines into recovery groups for fail over. It then helps to define a systematic recovery process by creating independent units that can fail over. 

- We recommend setting up smoke tests or DR drills at least once a year to ensure recovery plans are working as expected. The level of effort running these drills will be determined by the orchestration capabilities of the chosen DR tool.

- Use [geopolitical regional pair](/azure/availability-zones/cross-region-replication-azure) as the secondary disaster recovery environment. Some of the benefits of regional pairs are prioritized region recovery, sequential updates, physical isolation and data residency.

- Keep address spaces different to avoid overlapping IP addresses between the two sites. For example, you can use `192.168.0.0/16` for region 1 and `10.0.0.0/16` for region 2. 

- Use ExpressRoute Global Reach connectivity between the primary and secondary Azure VMware Solution private clouds in different regions. See more networking considerations and recommendations in the [relevant design area](./eslz-network-topology-connectivity.md).

## Next steps

Learn about considerations and recommendations for the initial deployment of Azure VMware Solution and guidance for operational automation.

> [!div class="nextstepaction"]
> [Platform automation for Azure VMware Solution](./eslz-platform-automation-and-devops.md)