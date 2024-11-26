---
title: Identity and Access Management for Azure HPC
description: Learn about identity and access management for high-performance computing (HPC) using this scenario that builds on the Azure landing zone design area.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/15/2024
---

# Identity and access management for Azure HPC

This article builds on considerations and recommendations that are described in the article [Azure identity and access management design](../../ready/landing-zone/design-area/identity-access.md). It can help you examine design considerations for identity and access management that are specific to the deployment, on Azure, of HPC applications.

[Microsoft Entra Domain Services](/azure/active-directory-domain-services/overview) (Microsoft Entra Domain Services) provides managed domain services like domain join and Group Policy. It also provides access to legacy authentication protocols like lightweight directory access protocol (LDAP) and Kerberos/NTLM authentication. Microsoft Entra Domain Services integrates with your existing Microsoft Entra tenant. This integration enables users to sign in to services and applications connected to the managed domain by using their existing credentials in Microsoft Entra ID. You can also use existing groups and user accounts to help secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure, especially for hybrid environments.

For more information, see [design recommendations for platform access](../../ready/landing-zone/design-area/identity-access-platform-access.md#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](../../ready/landing-zone/design-area/identity-access-landing-zones.md).

## Design considerations

HPC deployment uses the Azure landing zone infrastructure setup for security identity and access management needs. Keep the following design considerations in mind when you deploy your HPC application:

- Determine the Azure resource administration that's required by various members of the team. Consider providing those team members with elevated Azure resource administration access in a non-production environment.
  - For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role.
  - You can also give team members partially elevated administration access, like a partial Virtual Machine Contributor role in a production environment.
  
  Both options achieve a good balance between separation of duties and operational efficiency.
- Review the Azure administration and management activities that you require your teams to do. Consider your HPC on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

  Here are the common Azure activities for administration and management.

  | Azure resource | Azure resource provider | Activities |
  |--|--|--|
  | Virtual machine (VM) | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, and resize VMs. Manage extensions, availability sets, and proximity placement groups. |
  | VMs | Microsoft.Compute/disks | Read and write to disk. |
  | Storage | Microsoft.Storage | Read and make changes on storage accounts, for example, a boot diagnostics storage account. |
  | Storage | Microsoft.NetApp | Read and make changes on NetApp capacity pools and volumes. |
  | Storage | Microsoft.NetApp | Take Azure NetApp Files snapshots. |
  | Storage | Microsoft.NetApp | Use Azure NetApp Files cross-region replication. |
  | Networking | Microsoft.Network/networkInterfaces | Read, create, and change network interfaces. |
  | Networking | Microsoft.Network/loadBalancers | Read, create, and change load balancers. |
  | Networking | Microsoft.Network/networkSecurityGroups | Read network security groups. |
  | Networking | Microsoft.Network/azureFirewalls | Read firewalls. |
  | Networking | Microsoft.Network/virtualNetworks | Read, create, and change network interfaces. <br><br> Consider the relevant access that's needed for the resource group of the virtual network and related access if it's different from the resource group of the VMs. |

- A typical HPC setup includes a front end for submitting jobs, a job scheduler or orchestrator, a compute cluster, and shared storage. The jobs can be submitted from on-premises and/or in the cloud. Identity and access management considerations for users and visualization devices might vary depending on the enterprise standards.

- Consider the Microsoft service that you use—Azure CycleCloud, Azure Batch, or a hybrid environment with HPC VMs in the cloud. Depending on the HPC compute resource orchestrator that you use, various authentication methods are supported, as described here.

  - [Azure CycleCloud](/azure/cyclecloud/overview?view=cyclecloud-8&preserve-view=true). CycleCloud provides [three authentication methods](/azure/cyclecloud/how-to/user-authentication?view=cyclecloud-8&preserve-view=true): a built-in database with encryption, Active Directory, and LDAP.
  - [Azure Batch](/azure/batch/batch-technical-overview). Batch account access supports [two authentication methods](/azure/batch/security-best-practices): Shared Key and Microsoft Entra ID.
  - [HPC Pack](/azure/cyclecloud/hpcpack?view=cyclecloud-8&preserve-view=true). Currently, all HPC Pack nodes must be joined into an Active Directory domain. If you're deploying the HPC Pack cluster in a virtual network that has a site-to-site VPN or Azure ExpressRoute connection to your corporate network (and firewall rules allow access to Active Directory domain Controllers), there's typically already an Active Directory domain. If you don't have an Active Directory domain in your virtual network, you can choose to create one by promoting the head node as domain controller. Another option would be to utilize Microsoft Entra Domain Services to allow the HPC Pack nodes to be domain joined to this service vs. on-premises Active Directory domain controllers. If the Head Nodes will be deployed in Azure, it's important to determine if remote users on-premises will be submitting jobs. If remote users are submitting jobs, it would be recommended to use Active Directory as this will allow a better experience and allow certificates to be used properly for authentication. Otherwise, if Active Directory isn't utilized and Microsoft Entra Domain Services is used instead, the remote clients will need to use the REST API service to submit jobs. 
  - If you want to extend your on-premises capabilities to a hybrid environment, you can authenticate through Active Directory with a read-only domain controller that's hosted in Azure. This approach minimizes traffic across the link. This integration provides a way for users to use their existing credentials to sign in to services and applications that are connected to the managed domain. You can also use existing groups and user accounts to help secure access to resources. These features provide a smoother lift and shift of on-premises resources to Azure.

For more information, see [Design recommendations for platform access](../../ready/landing-zone/design-area/identity-access-platform-access.md#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](../../ready/landing-zone/design-area/identity-access-landing-zones.md).

### Design considerations for the energy industry 

In addition to the preceding considerations, take these considerations into account.

Two common deployment types in oil and gas industry workloads are *cloud only* and *hybrid cloud* models. While it's less complex to have all of your compute, storage, and visualization resources in the cloud, our customers sometimes use a hybrid model due to multiple business constraints for seismic and reservoir-simulation HPC workloads.

Both the cloud only and hybrid cloud models might have their own unique identity and access needs that affect which type of active directory solution to adopt.

Workloads in the cloud only deployment model use Microsoft Entra ID for Azure service fabric authentication, while the HPC hybrid cloud model uses the [Microsoft Entra hybrid identity solution](/azure/active-directory/hybrid/choose-ad-authn) for authentication. Regardless of the deployment type, Linux clients and POSIX-compliant storage solutions require legacy active directory support through Microsoft Entra Domain Services.

### Design considerations for the manufacturing industry 

The following diagram shows a manufacturing reference architecture that uses CycleCloud for authentication:

:::image type="content" source="../media/hpc-identity-access-management-cyclecloud.png" alt-text="Diagram that shows a manufacturing reference architecture, which uses Azure CycleCloud." lightbox="../media/hpc-identity-access-management-cyclecloud.png":::

This diagram shows a manufacturing architecture that uses Batch for authentication: 

:::image type="content" source="../media/hpc-identity-access-management-batch.png" alt-text="Diagram that shows a manufacturing reference architecture, which uses Azure Batch." lightbox="../media/hpc-identity-access-management-batch.png":::

## Next steps

The following articles provide guidance for various stages of the cloud adoption process. These resources can help you succeed in adopting HPC environments for the cloud.

- [Azure billing offers and Microsoft Entra tenants](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc/azure-hpc-landing-zone-accelerator.md)

**Manufacturing**

These resources apply specifically to the manufactuing industry.

- [Management for HPC in the manufacturing industry](./management.md)
- [Manufacturing HPC network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in the manufacturing industry](./platform-automation-devops.md)
- [Manufacturing HPC resource organization](./resource-organization.md)
- [Azure governance for manufacturing HPC](./security-governance-compliance.md)
- [Security for HPC in manufacturing industries](./security.md)
- [Manufacturing HPC storage](./storage.md)
 
**Energy**

These resources apply specifically to the energy industry. 

- [Management for Azure HPC in energy](./management.md)
- [Network topology and connectivity for Azure HPC in energy](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in energy](./platform-automation-devops.md)
- [Resource organization for HPC in the energy industry](./resource-organization.md)
- [Governance for HPC in energy industries](./security-governance-compliance.md)
- [Security for Azure HPC in energy](./security.md)
- [Compute large-scale HPC application workloads in Azure VMs](./compute.md)
- [Storage for HPC energy environments](./storage.md)
