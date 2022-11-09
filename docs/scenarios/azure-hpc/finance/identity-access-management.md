---
title: 'Finance HPC Azure identity and access management | Microsoft Docs'
description: 'This article builds on a number of considerations and recommendations defined in the Azure landing zone article Azure landing zone design area for identity and access management.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Azure identity and access management for finance HPC

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Following the guidance in this article will help examine design considerations and recommendations that relate to identity and access management specific to the deployment of an HPC application designed for the financial industry on Microsoft Azure.

## Design considerations:

 - Determine the Azure resource administration required by various members in the team, and consider providing them with elevated Azure resource administration access in a non-production environment. For example, give them a [Virtual Machine Contributor](/azure/role-based-access-control/built-in-roles#virtual-machine-contributor) role. You can also give them partially elevated administration access like partial Virtual Machine Contributor in a production environment. Both options achieve a good balance between separation of duties and operational efficiency.
 - Review the Azure administration and management activities you require your teams to do. Consider your HPC on Azure landscape. Determine the best possible distribution of responsibilities within your organization.

    Here are common Azure admin activities involved in administration and management.

    | Azure resource | Azure resource provider | Activities |
    | -- | -- | -- |
    | Virtual machine | Microsoft.Compute/virtualMachines | Start, stop, restart, deallocate, deploy, redeploy, change, resize, extensions, availability sets, proximity placement groups |
    | Virtual machines | Microsoft.Compute/disks | Read and write to disk |
    | Storage | Microsoft.Storage | Read, change on storage accounts (for example boot diagnostics) |
    | Storage | Microsoft.NetApp | Read, change on NetApp capacity pools and volumes |
    | Storage | Microsoft.NetApp | ANF snapshots |
    | Storage | Microsoft.NetApp | ANF Cross-region replication |
    | Networking | Microsoft.Network/networkInterfaces | Read, create, change network interfaces |
    | Networking | Microsoft.Network/loadBalancers | Read, create, change load balancers |
    | Networking | Microsoft.Network/networkSecurityGroups | Read NSG |
    | Networking | Microsoft.Network/azureFirewalls | Read firewall |
    | Networking | Microsoft.Network/ virtualNetworks | Read, create, change network interfaces <br><br> Consider relevant access needed for RG of the virtual network and related access if it is different from the RG of the virtual machines |

 - The Microsoft service you are using – Cycle Cloud, Azure Batch or a hybrid environment with HPC VMS in cloud.

## Recommendations

 - If you're using Azure CycleCloud, there are three methods of authentication, a built-in database with encryption, Active Directory, or LDAP. You can learn more on how to use these different types, here. Learn more about using service principal in Azure Cycelcloud [here](/azure/cyclecloud/how-to/service-principals?view=cyclecloud-8&preserve-view=true).
 - If you're using Azure Batch, authentication is supported via Azure Active Directory and there are two methods - integrated authentication, or using a service principle. You can learn more on how to use these different types, [here](/azure/batch/batch-aad-auth). If you are using [User subscription mode](/azure/batch/best-practices#pool-configuration-and-naming) (compared to Bath service mode) ensure that you grant access to allow Azure batch to access the subscription. You can learn more on how to do this [here](/azure/batch/batch-account-create-portal#allow-azure-batch-to-access-the-subscription-one-time-operation).
 - If it is a hybrid environment where you want to extend your on-prem capabilities, authentication can be done through Active Directory with a Read Only domain controller hosted in Azure to minimize traffic across the link, This integration lets users sign into services and applications connected to the managed domain using their existing credentials. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure.

For more details, refer to [design recommendations for platform access](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones).

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
