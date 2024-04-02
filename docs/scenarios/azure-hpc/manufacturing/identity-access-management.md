---
title: Azure identity and access management for HPC in manufacturing
description: This article describes considerations and provides recommendations for identity and access management in manufacturing HPC environments.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/09/2022
---

# Azure identity and access management for HPC in manufacturing

This article builds on considerations and recommendations that are described in the article [Azure identity and access management design](../../../ready/landing-zone/design-area/identity-access.md). It can help you examine design considerations for identity and access management that are specific to the deployment, on Azure, of HPC applications designed for the manufacturing industry.

[Microsoft Entra Domain Services](/azure/active-directory-domain-services/overview) (Microsoft Entra Domain Services) provides managed domain services like domain join and Group Policy. It also provides access to legacy authentication protocols like lightweight directory access protocol (LDAP) and Kerberos/NTLM authentication. Microsoft Entra Domain Services integrates with your existing Microsoft Entra tenant. This integration enables users to sign in to services and applications connected to the managed domain by using their existing credentials in Microsoft Entra ID. You can also use existing groups and user accounts to help secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure, especially for hybrid environments.

For more information, see [design recommendations for platform access](../../../ready/landing-zone/design-area/identity-access-platform-access.md#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](../../../ready/landing-zone/design-area/identity-access-landing-zones.md).

## HPC design considerations

Depending on the HPC compute resource orchestrator that you use, various authentication methods are supported, as described here.

 - [Azure CycleCloud](/azure/cyclecloud/overview?view=cyclecloud-8&preserve-view=true). CycleCloud provides [three authentication methods](/azure/cyclecloud/how-to/user-authentication?view=cyclecloud-8&preserve-view=true): a built-in database with encryption, Active Directory, and LDAP.
 - [Azure Batch](/azure/batch/batch-technical-overview). Batch account access supports [two authentication methods](/azure/batch/security-best-practices): Shared Key and Microsoft Entra ID.
 - [HPC Pack](/azure/cyclecloud/hpcpack?view=cyclecloud-8&preserve-view=true). Currently, all HPC Pack nodes must be joined into an Active Directory domain. If you're deploying the HPC Pack cluster in a virtual network that has a site-to-site VPN or Azure ExpressRoute connection to your corporate network (and firewall rules allow access to Active Directory domain Controllers), there's typically already an Active Directory domain. If you don't have an Active Directory domain in your virtual network, you can choose to create one by promoting the head node as domain controller. Another option would be to utilize Microsoft Entra Domain Services to allow the HPC Pack nodes to be domain joined to this service vs. on-premises Active Directory domain controllers. If the Head Nodes will be deployed in Azure, it is important to determine if remote users on-premises will be submitting jobs. If remote users are submitting jobs it would be recommended to use Active Directory as this will allow a better experience and allow certificates to be used properly for authentication. Otherwise, if Active Directory is not utilized and Microsoft Entra Domain Services is used instead, the remote clients will need to use the REST API service to submit jobs. 

The following diagram shows a manufacturing reference architecture that uses CycleCloud:

:::image type="content" source="./media/hpc-identity-access-management-cyclecloud.png" alt-text="Diagram that shows a manufacturing reference architecture, which uses Azure CycleCloud." lightbox="./media/hpc-identity-access-management-cyclecloud.png":::

This diagram shows a manufacturing architecture that uses Batch: 

:::image type="content" source="./media/hpc-identity-access-management-batch.png" alt-text="Diagram that shows a manufacturing reference architecture, which uses Azure Batch." lightbox="./media/hpc-identity-access-management-batch.png":::

## Next steps

The following articles provide guidance that you might find helpful at various points during your cloud adoption process. They can help you succeed in your cloud adoption scenario for manufacturing HPC environments.

- [Manufacturing HPC Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Management for HPC in the manufacturing industry](./management.md)
- [Manufacturing HPC network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in the manufacturing industry](./platform-automation-devops.md)
- [Manufacturing HPC resource organization](./resource-organization.md)
- [Azure governance for manufacturing HPC](./security-governance-compliance.md)
- [Security for HPC in manufacturing industries](./security.md)
- [Manufacturing HPC storage](./storage.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
