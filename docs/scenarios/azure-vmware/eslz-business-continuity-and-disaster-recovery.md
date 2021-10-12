---
title: Enterprise-scale BCDR for Azure VMware Solution
description: Learn how this enterprise-scale scenario can improve business continuity and disaster recovery (BCDR) of Azure VMware Solution.
author: mhenry
ms.author: janet
ms.date: 09/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-azure-vmware
---

# Business continuity and disaster recovery (BCDR) for Azure VMware Solution enterprise-scale scenario

[Azure VMware Solution](/azure/azure-vmware/) provides one or more [private clouds](/azure/azure-vmware/concepts-private-clouds-clusters) that contain vSphere clusters. These clusters are built from dedicated bare-metal Azure infrastructure. The solution provides a minimum of three ESXi hosts, up to a maximum of 16 hosts per cluster. Up to 96 hosts can be run in one private cloud. vCenter Server, vSAN, vSphere, and NSX-T are all provided as part of the private cloud solution. To learn about the SLA for Azure VMware Solution, see [SLA for Azure VMware Solution](https://azure.microsoft.com/support/legal/sla/azure-vmware/v1_1/). You'll still want to consider other BCDR factors.

:::image type="content" source="../_images/eslz-bcdr-1.png" alt-text="Diagram that shows a BCDR flow chart." border="false" Lightbox="../_images/eslz-bcdr-1.png":::

## Business continuity design considerations

- Choose a validated backup solution for the VMware virtual machines (VMs), such as [Microsoft Azure Backup Server (MABS)](/azure/backup/backup-azure-backup-server-vmware?context=/azure/azure-vmware/context/context) or from our [backup partners](/azure/azure-vmware/ecosystem-back-up-vms).

  > [!NOTE]
  > vCenter and NSX-T configurations for private clouds are on an hourly backup schedule. Backups are kept for three days.

- VMware vSAN storage policies on Azure VMware Solution are implemented with storage availability in mind. When the cluster has between three and five hosts, the number of host failures to tolerate without loss of data equals one. When the cluster has between 6 and 16 hosts, the number of host failures to tolerate before data loss can occur equals two. VMware vSAN storage policies can be applied on a per-VM basis. While these policies are the default, you can amend the policy used for VMware VMs to suit custom requirements. For more information, see [Azure VMware Solution storage concepts](/azure/azure-vmware/concepts-storage).
- VMware High Availability (HA) is enabled by default on Azure VMware Solution. The HA admittance policy ensures a reservation of the compute and memory capacity of a single node. This reservation ensures sufficient reserve capacity to restart workloads in another node in an Azure VMware Solution cluster.
- Currently, MABS doesn't support restoring backups to a secondary Azure VMware Solution private cloud. See the [disaster recovery section](./eslz-business-continuity-and-disaster-recovery.md#disaster-recovery-design-considerations) when cross Azure VMware Solution recovery is required.

## Business continuity design recommendations

- Use MABS to back up the Azure VMware Solution private cloud. For more information, see [Back up VMware VMs with MABS](/azure/backup/backup-azure-backup-server-vmware?context=/azure/azure-vmware/context/context).

- Deploy the Azure Backup Server in the same Azure region as the Azure VMware Solution private cloud. This deployment method reduces traffic costs, eases administration, and keeps the primary/secondary topology. See the [Azure regions decision guide](/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions) for Azure region deployment best practices.

- MABS can be deployed as an Azure infrastructure as a service (IaaS) VM or within the Azure VMware Solution private cloud. It's highly recommended to deploy it outside of the Azure VMware Solution private cloud in an Azure virtual network. This virtual network is connected to the same ExpressRoute to reduce vSAN consumption, as vSAN is a *limited capacity* resource within the Azure VMware Solution private cloud.

  :::image type="content" source="../_images/eslz-bcdr-2.png" alt-text="Diagram that shows the MABS backup server deployed as an Azure IaaS VM.":::

  :::image type="content" source="../_images/eslz-bcdr-3.png" alt-text="Diagram that shows the MABS backup server deployed as an Azure VMware Solution VM.":::

- To restore from a backup for Azure VMware Solution platform components like vCenter, NSX Manager, or HCX Manager, [create an Azure Support request](/azure/azure-portal/supportability/how-to-create-azure-support-request).

## Disaster recovery design considerations

- Align business requirements with recovery time, capacity, and point objectives for applications and VM tiers. Plan and design accordingly to achieve them using the most appropriate replication technology. Application-native, like SQL Always On availability group, or non-native like VMware Site Recovery Manager (SRM) and [Azure Site Recovery](/azure/site-recovery/).

- Make a decision as to what the target disaster recovery site for the Azure VMware Solution private cloud will be. This site influences which disaster recovery tooling is suitable to the environment.

- Migration from third-party locations into Azure VMware Solution has support through Site Recovery Manager through scale.

- You can use VMware Site Recovery Manager to provide disaster recovery for your Azure VMware Solution private cloud to a secondary Azure VMware Solution private cloud.

- You can use Azure Site Recovery as a disaster recovery solution for Azure VMware Solution private cloud to Azure IaaS. For more information, see [Prepare Azure Site Recovery resources for disaster recovery of Azure VMware Solution VMs](/azure/site-recovery/avs-tutorial-prepare-azure).

  :::image type="content" source="../_images/eslz-bcdr-4.png" alt-text="Diagram that shows a high-level example of Azure Site Recovery.":::

- You can use the [Azure Site Recovery Deployment Planner](/azure/site-recovery/site-recovery-deployment-planner) to begin planning disaster recovery to Azure native services.

- When planning the workloads to start after Azure Site Recovery failover, include the correct startup order for workloads in the recovery plan.

- Partner solutions like JetStream Software and [HCX](/azure/azure-vmware/deploy-disaster-recovery-using-vmware-hcx) also support disaster recovery scenarios for Azure VMware Solution.

- Analyze and decide which set or subset of Azure VMware Solution workloads require protection if there's a disaster recovery event. Consider protecting only those workloads critical to business operations to control the costs associated with the disaster recovery implementation.

- Set up functional domain roles, like Active Directory domain controllers, in the secondary environment.

- To enable disaster recovery between Azure VMware Solution private clouds in distinct Azure regions, you need to enable ExpressRoute Global Reach between both back-end ExpressRoute circuits. These circuits create primary to secondary private cloud connectivity when required for solutions like VMware SRM and VMware HCX for disaster recovery.

- When working with disaster recovery, you can use the same IP address spaces from the primary Azure region in the secondary Azure region. However, it requires engineering more overhead incorporation into the solution foundation.

  - **Retain the same IP addresses:** You can use the same IP addresses on the recovered VM as the ones allocated to the Azure VMware Solution VMs. For this method, create isolated VLANs or segments in the secondary site and ensure none of these isolated VLANs or segments is connected to the environment. Modify your disaster recovery routes to reflect that the subnet has moved to the secondary site and new IP address locations. While this method works, it also creates engineering overhead when aiming for minimal interaction.

  - **Use different IP addresses:** You can also use different IP addresses for recovered VMs. If the VM is moved to a secondary site, the recovery plan within the VMware Site Recovery Manager will detail the custom IP map. Select this map for the change of IP address. If you're using Azure Site Recovery, a defined virtual network is chosen for the new IP allocation.

- Understand partial and full disaster recovery solutions:

  - When you work with Azure Site Recovery, know how to prepare for full disaster recovery. Specifically, how to fail over from Azure VMware Solution into an Azure native environment.

  - You can use VMware SRM for partial and full disaster recovery. When running Azure VMware Solution in region 1 and region 2, you can fail some or all the VMs from primary to secondary regions.

  - The requirement for VM recovery and the IP address retention requirements dictate if partial versus full disaster recovery is possible.

  - Maintain the IP address and achieve a partial disaster recovery in SRM by moving the gateway of the subnet to the secondary Azure VMware Solution.

  > [!NOTE]
  > Active-standby disaster recovery doesn't require L2 stretching.

## Disaster recovery design recommendations

- Use VMware Site Recovery Manager when working with Azure VMware Solution in both primary and secondary sites. Primary and secondary sites are also known as protected and recovery sites, respectively. The first diagram shows a high-level overview of continuous vSphere replication. The second diagram shows the primary and secondary site components in detail.

  :::image type="content" source="../_images/eslz-bcdr-5.png" alt-text="Diagram that shows a high-level example of continuous vSphere replication between two Azure VMware Solution sites.":::

  :::image type="content" source="../_images/eslz-bcdr-6.png" alt-text="Diagram that shows a detailed example of continuous vSphere replication between two Azure VMware Solution sites." border="false":::

- Use Azure Site Recovery if Azure IaaS is the disaster recovery target for the Azure VMware Solution private cloud.

- Minimize manual input by using automated recovery plans within each of the respective solutions. These plans are helpful when working with either VMware Site Recovery Manager or Azure Site Recovery to provide disaster recovery for the Azure VMware Solution private cloud. A recovery plan gathers machines into recovery groups for failover. It then helps to define a systematic recovery process by creating small independent units that can fail over.

- We recommend using the geopolitical region pair as the secondary disaster recovery environment for proximity of regions and cost reductions.

- Keep address spaces different. For example, use `192.168.0.0/16` for region 1 and `10.0.0.0/16` for region 2. This difference reduces the risk of IP address overlap.

- Use ExpressRoute Global Reach connectivity between the primary and secondary Azure VMware Solution private clouds. See more networking considerations and recommendations in the [relevant design area](./eslz-network-topology-connectivity.md).

## Next steps

Learn about considerations and recommendations for the initial deployment of Azure VMware Solution and guidance for operational automation.

> [!div class="nextstepaction"]
> [Platform automation for Azure VMware Solution](./eslz-platform-automation-and-devops.md)
