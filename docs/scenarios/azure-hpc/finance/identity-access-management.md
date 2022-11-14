---
title: Finance HPC Azure identity and access management | Microsoft Docs
description: Learn how to use the identity and access management design considerations and recommendations to deploy an HPC application on Microsoft Azure for the financial industry.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/11/2022
---

# Finance HPC Azure identity and access management

This article builds on considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Following the guidance in this article helps you use the identity and access management design considerations and recommendations to deploy an HPC application on Microsoft Azure for the financial industry.

## Design considerations

The following are design considerations for deploying your HPC application.

 - Determine the Azure resource administration required by various members of the team, and consider providing them with elevated Azure resource administration access in a non-production environment.
    - For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role.
    - You can also give team members partially elevated administration access like partial Virtual Machine Contributor in a production environment. Both options achieve a good balance between separation of duties and operational efficiency.
 - Review the Azure administration and management activities you require your teams to do. Consider your HPC on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

    Here are the common Azure activities for administration and management.

    | Azure resource | Azure resource provider | Activities |
    |--|--|--|
    | Virtual machine | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, resize, extensions, availability sets, proximity placement groups |
    | Virtual machines | Microsoft.Compute/disks | Read and write to disk |
    | Storage | Microsoft.Storage | Read, change on storage accounts (for example, boot diagnostics) |
    | Storage | Microsoft.NetApp | Read, change on NetApp capacity pools and volumes |
    | Storage | Microsoft.NetApp | ANF snapshots |
    | Storage | Microsoft.NetApp | ANF Cross-region replication |
    | Networking | Microsoft.Network/networkInterfaces | Read, create, change network interfaces |
    | Networking | Microsoft.Network/loadBalancers | Read, create, change load balancers |
    | Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
    | Networking | Microsoft.Network/azureFirewalls | Read firewall |
    | Networking | Microsoft.Network/ virtualNetworks | Read, create, change network interfaces <br><br> Consider relevant access needed for RG of the virtual network and related access if it's different from the RG of the virtual machines |

 - Consider the Microsoft service you're using – Cycle Cloud, Azure Batch, or a hybrid environment with HPC VMS in the cloud.

## Recommendations

 - If you're using Azure CycleCloud, there are three methods of authentication, a built-in database with encryption, Azure Active Directory, or LDAP. For more information, see [user authentication](/azure/cyclecloud/how-to/user-authentication). For more information on service principals in Azure CycleCloud, see [service principals](/azure/cyclecloud/how-to/service-principals?view=cyclecloud-8&preserve-view=true).
 - If you're using Azure Batch, you can authenticate with Azure Active Directory by way of two different methods - integrated authentication or a service principle. For more information on how to use these different approaches, see [Azure Batch authentication](/azure/batch/batch-aad-auth). If you're using [user subscription mode](/azure/batch/best-practices#pool-configuration-and-naming) (compared to Batch service mode), be sure to grant access to Azure Batch so it can access the subscription. For more information, see [Allow Azure Batch to access the subscription](/azure/batch/batch-account-create-portal#allow-azure-batch-to-access-the-subscription-one-time-operation).
 - If you want to extend your on-premises capabilities to a hybrid environment, you can authenticate through Active Directory with a Read Only domain controller hosted in Azure. This approach minimizes traffic across the link. This integration lets users sign into services and applications connected to the managed domain using their existing credentials. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure.

For more information, see [design recommendations for platform access](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones).

## Next steps

The following articles provide guidance on each step in the cloud adoption journey for energy HPC environments.

- [Azure billing offers and Active Directory tenants for finance HPC](./azure-billing-active-directory-tenant.md)
- [Management for manufacturing HPC](./management.md)
- [Network topology and connectivity for manufacturing HPC](./network-topology-connectivity.md)
- [Platform automation and DevOps for manufacturing HPC](./platform-automation-devops.md)
- [Resource organization for manufacturing HPC](./resource-organization.md)
- [Azure governance for manufacturing HPC](./security-governance-compliance.md)
- [Security for manufacturing HPC](./security.md)
- [Storage for manufacturing HPC](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)

