---
title: Azure Identity and Access to IaaS Resources
description: Understand considerations and recommendations when granting access to IaaS resources.
author: anlucen
ms.author: anais.lucena
ms.date: 04/29/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Hosting infrastructure as a service (IaaS) identity solution design considerations

- For scenarios where on-premises AD is integrated with Azure, evaluate which options satisfy the organization requirements by [Integrate on-premises AD with Azure](https://docs.microsoft.com/azure/architecture/reference-architectures/identity/).

- The authentication process can occur in the Cloud + on-premises or only on-premises. Explore the authentication methods offered by Azure Active Directory as part of your identity planning. [Authentication for Azure AD hybrid identity solutions](https://docs.microsoft.com/azure/active-directory/hybrid/choose-ad-authn?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Fbread%2Ftoc.json).

- Password hash Synchronization can be used as a backup if you have AD FS because you require sign-in across multiples Identity Providers. Seamless SSO is not supported in Active Directory Federation Services.

- Validate the right Synchronization tool for your Identity on the cloud [Hybrid identity design - directory sync](https://docs.microsoft.com/azure/active-directory/hybrid/plan-hybrid-identity-design-considerations-directory-sync-requirements)

- Are there applications that are partly hosted on-premises and partly hosted in Azure?

## Hosting infrastructure as a service (IaaS) identity solution design recommendations

- For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario.  

- See the following guidance for [deploying Active Directory Domain Services](https://docs.microsoft.com/azure/architecture/reference-architectures/identity/adds-extend-domain) in Azure.  

- If you have Active Directory Federation Services, it is recommended to move to the cloud since it could reduce costs. However, in the case that ADFS is still part of your Identity solution it is highly recommended installing Connect Health.

# Prerequisites for a landing zone - design considerations

## Role-based access control (RBAC) design considerations

- For built-in RBAC roles you can you the free version of Azure Active Directory, but for custom roles Azure AD Premium P1 is required. [Overview of Azure Active Directory role-based access control (RBAC)](https://docs.microsoft.com/azure/role-based-access-control/overview#:~:text=Azure%20role-based%20access%20control%20%28Azure%20RBAC%29%20helps%20you,that%20provides%20fine-grained%20access%20management%20of%20Azure%20resources.)

- Limits exist for the number of custom roles and role assignments that you must consider when you lay down a framework around IAM and governance. For more information, see [Azure RBAC service limits](https://docs.microsoft.com/azure/role-based-access-control/troubleshooting).

    o There's a limit of 4,000 role assignments per subscription.

    o There's a limit of 500 role assignments per management group.

    o A maximum of 30 Azure AD custom roles can be created in an Azure AD organization.

## Managed Identities - design considerations

- Evaluate using Managed Identities for Azure resources that don’t need to manage credentials. There are two options: system-assigned or user-assigned managed identity. See this link for more information [Managed identities for Azure resources](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview)

- Consider reading this [guidance](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/managed-identity-best-practice-recommendations) for choosing the right identities (user- assigned or system-assigned) option based on your scenario.

- Verify which Azure resources are supported by this feature [Azure Services with managed identities support](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/managed-identities-status).

- Managed Identity can be used by applications that need to be authenticated against an Azure service. Verify which services support Azure AD authentication [Azure Ad auth Services](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/services-azure-active-directory-support).

- Which tasks and functions should the organization control with managed identities?

- System-assigned is part of the solution that can be configured to login into a VM using Azure Ad authentication. See this link for more information [VM Sign-in Azure](https://docs.microsoft.com/azure/active-directory/devices/howto-vm-sign-in-azure-ad-windows)

- Service Principal with Managed Identities can be easy to confuse in how is used getting access to Azure Resources. See this article for further analysis [SP vs MSI](https://devblogs.microsoft.com/devops/demystifying-service-principals-managed-identities/)

- Transferring resources to another Azure AD Subscriptions, for user-assigned or system-assigned cannot be updated automatically. It needs to move this manually.

- Which tasks and functions should the organization control with managed identities?

- Which services or applications within your landing zone support Azure Active Directory authentication?

> [!div class="nextstepaction"]
> [Platform](identity-access-landing-zones.md)
