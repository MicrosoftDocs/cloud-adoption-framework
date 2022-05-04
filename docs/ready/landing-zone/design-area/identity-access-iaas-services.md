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

> [!div class="nextstepaction"]
> [Platform](identity-access-landing-zones.md)
