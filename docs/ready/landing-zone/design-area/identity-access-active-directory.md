---
title: Active Directory Considerations
description: Understand Active Directory considerations and recommendations
author: anlucen
ms.author: anais.lucena
ms.date: 04/29/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure Active Directory Design

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend a current on-premises identity domain into Azure or to create a brand new one.

Most Azure environments will use Azure AD for Azure fabric authentication and for on-premises use AD DS local host authentication and group policy management. Policy management in the cloud is handled differently depending on your Active Directory strategy. If you are using on premises domain controllers, use the on-premises group policy management. If you are using Azure AD Domain Services, administer Group policy from the cloud by following the instructions at this link: [Administer Group Policy in an Azure Active Directory Domain Services managed domain](https://docs.microsoft.com/zure/active-directory-domain-services/manage-group-policy)

## Design Considerations

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone [Centralize management operations CAF](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/centralize-operations).

- Applications that rely on domain services and use older protocols might be able to use [Azure AD DS](https://docs.microsoft.com/azure/active-directory-domain-services)

- There are differences between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs. You can do the application reviews by first understanding and documenting the authentication provider that each one will be using. Use the reviews to help plan which flavor of Active Directory your organization should utilize. Use these links: [Compare Active Directory to Azure Active Directory](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad) and [Identity decision guide - CAF](https://review.docs.microsoft.com/azure/cloud-adoption-framework/decision-guides/identity/?branch=main).

- Evaluate scenarios involving the set up of external users, customers, or partners to secure access to resources. Determine whether these scenarios involve [B2B](https://docs.microsoft.com/azure/active-directory/external-identities/what-is-b2b) or [B2C](https://docs.microsoft.com/azure/active-directory-b2c/overview) configuration. For more information, consult this link: [External-identities in Azure](https://docs.microsoft.com/azure/active-directory/external-identities/external-identities-overview).

- For Azure Application Proxy, consider not using intranet access for the application since it could add latency to the user experience. For other considerations regarding Azure AD Application Proxy, please visit these links: [Azure AD Application Proxy Planning](https://docs.microsoft.com/azure/active-directory/app-proxy/application-proxy-deployment-plan#plan-your-implementation) and [Azure AD Application Proxy Security](https://docs.microsoft.com/azure/active-directory/app-proxy/application-proxy-security) considerations

## Design Recommendations

- Use centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements. [CAF Best Practices](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/best-practices)

- The following types of privileged operations require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the necessary diligence:

    - Creating service principal objects

    - Registering applications in Azure AD

    - Procuring and handling certificates or wildcard certificates

- If an organization has a scenario where an application that uses on-premises authentication must be accessed remotely through Azure AD, consider using [Azure AD Application Proxy](https://docs.microsoft.com/azure/active-directory/app-proxy/application-proxy).

- Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD DS.

- Ensure your network design allows resources that require AD DS on Windows Server for local authentication and management can access the appropriate domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.

- When deploying Azure AD Domain Services or integrating on-premises in Azure, consider locations with [Availability Zones](https://docs.microsoft.com/azure/availability-zones/az-overview) for increased availability.

- Deploy Azure AD Domain Services within the primary region because this service can only be projected into one subscription. Azure Active Directory Domain Service can be expanded to further regions with [replica sets](https://docs.microsoft.com/azure/active-directory-domain-services/concepts-replica-sets).

- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft. [Managed Identity Identities](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview)

## Hosting infrastructure as a service (IaaS) identity solution design considerations

- For scenarios where on-premises AD is integrated with Azure, evaluate which options satisfy the organization requirements by [Integrate on-premises AD with Azure](https://docs.microsoft.com/azure/architecture/reference-architectures/identity/).

- The authentication process can occur in the Cloud + on-premises or only on-premises. Explore the authentication methods offered by Azure Active Directory as part of your identity planning. [Authentication for Azure AD hybrid identity solutions](https://docs.microsoft.com/azure/active-directory/hybrid/choose-ad-authn?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Fbread%2Ftoc.json).

- Password hash Synchronization can be used as a backup if you have AD FS federation with Azure AD. Seamless SSO is not supported in Active Directory Federation Services.

- Validate the right Synchronization tool for your Identity on the cloud [Hybrid identity design - directory sync](https://docs.microsoft.com/azure/active-directory/hybrid/plan-hybrid-identity-design-considerations-directory-sync-requirements)

- Are there applications that are partly hosted on-premises and partly hosted in Azure?

## Hosting infrastructure as a service (IaaS) identity solution design recommendations

- For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario.  

- See the following guidance for [deploying Active Directory Domain Services](https://docs.microsoft.com/azure/architecture/reference-architectures/identity/adds-extend-domain) in Azure.  

- If you have Active Directory Federation Services (AD FS), it is recommended to move to the cloud; the main benefit is to have centralized the identity and reduce operational effort. However, in the case that ADFS is still part of the Identity solution, it is highly recommended to install [Connect Health](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect).

## Next steps

Learn about Identity and Platform Access.

> [!div class="nextstepaction"]
> [Platform](identity-access-platform-access.md)