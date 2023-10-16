---
title: 'Finance HPC Azure identity and access management'
description: Use identity and access management design considerations and recommendations to deploy an HPC application on Microsoft Azure for the financial industry.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/11/2022
---

# Finance HPC Azure identity and access management

This article builds on considerations and recommendations that are defined in the Azure landing zone article [Azure landing zone design area for identity and access management](../../../ready/landing-zone/design-area/identity-access.md). Following the guidance in this article helps you use the identity and access management design considerations and recommendations to deploy a high-performance computing (HPC) application on Microsoft Azure for the financial industry.

## Design considerations

Keep the following design considerations in mind when you deploy your HPC application:

- Determine the Azure resource administration that's required by various members of the team. Consider providing those team members with elevated Azure resource administration access in a non-production environment.
  - For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role.
  - You can also give team members partially elevated administration access like a partial Virtual Machine Contributor role in a production environment. Both options achieve a good balance between separation of duties and operational efficiency.
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

- Consider the Microsoft service that you use—Azure CycleCloud, Azure Batch, or a hybrid environment with HPC VMs in the cloud.

## Recommendations

- If you use Azure CycleCloud, there are three methods of authentication: a built-in database with encryption, Microsoft Entra ID, or Lightweight Directory Access Protocol (LDAP). For more information, see [User authentication](/azure/cyclecloud/how-to/user-authentication). For more information about service principals in Azure CycleCloud, see [Using service principals](/azure/cyclecloud/how-to/service-principals?view=cyclecloud-8&preserve-view=true).
- If you use Batch, you can authenticate with Microsoft Entra ID by way of two different methods: integrated authentication or a service principle. For more information about how to use these different approaches, see [Azure Batch authentication](/azure/batch/batch-aad-auth). If you use the [user subscription mode](/azure/batch/best-practices#pool-configuration-and-naming) and not the Batch service mode, grant access to Batch so that it can access the subscription. For more information, see [Allow Azure Batch to access the subscription](/azure/batch/batch-account-create-portal#allow-azure-batch-to-access-the-subscription-one-time-operation).
- If you want to extend your on-premises capabilities to a hybrid environment, you can authenticate through Active Directory with a read-only domain controller that's hosted in Azure. This approach minimizes traffic across the link. This integration provides a way for users to use their existing credentials to sign in to services and applications that are connected to the managed domain. You can also use existing groups and user accounts to help secure access to resources. These features provide a smoother lift and shift of on-premises resources to Azure.

For more information, see [design recommendations for platform access](../../../ready/landing-zone/design-area/identity-access-platform-access.md#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](../../../ready/landing-zone/design-area/identity-access-landing-zones.md).

## Next steps

The following articles provide guidance for various stages of the cloud adoption process. These resources can help you succeed in adopting finance sector HPC environments for the cloud.

- [Azure billing offers and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
