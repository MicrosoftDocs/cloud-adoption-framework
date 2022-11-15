---
title: 'Manufacturing HPC Azure Identity and Access Management | Microsoft Docs'
description: 'This article builds on a number of considerations and recommendations defined in the Azure landing zone article Azure landing zone design area for identity and access management in manufacturing environments.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Azure Identity and Access Management for Manufacturing HPC

This article builds on a number of considerations and recommendations defined in the Azure landing zone article [Azure landing zone design area for identity and access management](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). Following the guidance in this article will help examine design considerations and recommendations that relate to identity and access management specific to the deployment of an HPC application designed for the manufacturing industry on Microsoft Azure.

[Azure Active Directory](/azure/active-directory-domain-services/overview) Domain Services (Azure ADD) can be employed to make use of managed domain services such as domain join, group policy and access to legacy authentication protocols such as lightweight directory access protocol (LDAP) and Kerberos/NTLM authentication. Azure AD DS integrates with your existing Azure AD tenant. This integration lets users sign into services and applications connected to the managed domain using their existing credentials in Azure AD. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure, especially for a hybrid environment.

For more details, refer to [design recommendations for platform access](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access#design-recommendations-for-platform-access) and [Azure identity and access for landing zones](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones).

## HPC Design Considerations:

Depending on the chosen HPC Compute Resource Orchestrator, different types of authentication methods are supported:

 - Azure [CycleCloud](/azure/cyclecloud/overview?view=cyclecloud-8&preserve-view=true) – offers [three methods of authentication](/azure/cyclecloud/how-to/user-authentication?view=cyclecloud-8&preserve-view=true): a built-in database with encryption, Active Directory, or LDAP.
 - [Azure Batch](/azure/batch/batch-technical-overview) - Batch account access supports [two methods of authentication](/azure/batch/security-best-practices): Shared Key and Azure Active Directory (Azure AD).
 - Microsoft [HPC Pack](/azure/cyclecloud/hpcpack?view=cyclecloud-8&preserve-view=true) - Currently all HPC Pack nodes must be joined into an Active Directory Domain. If you are deploying the HPC Pack cluster in a virtual network which has a Site-to-Site VPN or ExpressRoute connection with your corporate network, typically there is already an existing Active Directory Domain. If you don't have an AD domain in your virtual network yet, you can choose to create a new AD domain by promoting the head node as domain controller.



:::image type="content" source="../media/reference-architecture-with-azure-cycle-cloud.png" alt-text=" Diagram that shows Manufacturing Reference Architecture design with Azure CycleCloud.":::

***Figure 1: Reference Architecture with Azure CycleCloud***

:::image type="content" source="../media/reference-architecture-with-azure-batch.png" alt-text="Diagram showing Manufacturing Reference Architecture design with Azure Batch.":::

***Figure 2: Reference Architecture with Azure Batch***

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
