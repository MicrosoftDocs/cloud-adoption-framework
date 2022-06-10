---
title: Active Directory and Hybrid Identity Considerations
description: Understand Active Directory and Hybrid Identity considerations and recommendations
author: anlucen
ms.author: doalle
ms.date: 06/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure Active Directory and Hybrid Identity

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend a current on-premises identity domain into Azure or to create a brand new one.

Most Azure environments will use Azure AD for Azure fabric authentication and for on-premises use AD DS local host authentication and group policy management

## Design Considerations

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone [Centralize management operations CAF](/azure/cloud-adoption-framework/manage/centralize-operations).

- Applications that rely on domain services and use older protocols might be able to use [Azure AD DS](/azure/active-directory-domain-services)

- There are differences between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs. You can do the application reviews by first understanding and documenting the authentication provider that each one will be using. Use the reviews to help plan which flavor of Active Directory your organization should utilize. Use these links: [Compare Active Directory to Azure Active Directory](/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad) and [Identity decision guide - CAF](/azure/cloud-adoption-framework/decision-guides/identity/?branch=main).

- Evaluate scenarios involving the set up of external users, customers, or partners to secure access to resources. Determine whether these scenarios involve [B2B](/azure/active-directory/external-identities/what-is-b2b) or [B2C](/azure/active-directory-b2c/overview) configuration. For more information, consult this link: [External-identities in Azure](/azure/active-directory/external-identities/external-identities-overview).

- For Azure Application Proxy, consider not using intranet access for the application since it could add latency to the user experience. For other considerations regarding Azure AD Application Proxy, please visit these links: [Azure AD Application Proxy Planning](/azure/active-directory/app-proxy/application-proxy-deployment-plan#plan-your-implementation) and [Azure AD Application Proxy Security](/azure/active-directory/app-proxy/application-proxy-security) considerations

## Design Recommendations

- Use centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements. [CAF Best Practices](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/best-practices)

- The following types of privileged operations require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the necessary diligence:

    - Creating service principal objects

    - Registering applications in Azure AD

    - Procuring and handling certificates or wildcard certificates

- If an organization has a scenario where an application that uses on-premises authentication must be accessed remotely through Azure AD, consider using [Azure AD Application Proxy](/azure/active-directory/app-proxy/application-proxy).

- Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD DS.

- Ensure your network design allows resources that require AD DS on Windows Server for local authentication and management can access the appropriate domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.

- When deploying Azure AD Domain Services or integrating on-premises in Azure, consider locations with [Availability Zones](/azure/availability-zones/az-overview) for increased availability.

- Deploy Azure AD Domain Services within the primary region because this service can only be projected into one subscription. Azure Active Directory Domain Service can be expanded to further regions with [replica sets](/azure/active-directory-domain-services/concepts-replica-sets).

- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft. [Managed Identity Identities](/azure/active-directory/managed-identities-azure-resources/overview)

## Hosting infrastructure as a service (IaaS) identity solution design considerations

- For scenarios where on-premises AD is integrated with Azure, evaluate which options satisfy the organization requirements by [Integrate on-premises AD with Azure](/azure/architecture/reference-architectures/identity/).

- The authentication process can occur in the Cloud + on-premises or only on-premises. Explore the authentication methods offered by Azure Active Directory as part of your identity planning. [Authentication for Azure AD hybrid identity solutions](/azure/active-directory/hybrid/choose-ad-authn?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Farchitecture%2Fbread%2Ftoc.json).

- Password hash Synchronization can be used as a backup if you have AD FS federation with Azure AD. Seamless SSO is not supported in Active Directory Federation Services.

- Validate the right Synchronization tool for your Identity on the cloud [Hybrid identity design - directory sync](/azure/active-directory/hybrid/plan-hybrid-identity-design-considerations-directory-sync-requirements)

- Are there applications that are partly hosted on-premises and partly hosted in Azure?

## Hosting infrastructure as a service (IaaS) identity solution design recommendations

- For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario.  

- See the following guidance for [deploying Active Directory Domain Services](/azure/architecture/reference-architectures/identity/adds-extend-domain) in Azure.  

- If you have Active Directory Federation Services (AD FS), it is recommended to move to the cloud; the main benefit is to have centralized the identity and reduce operational effort. However, in the case that ADFS is still part of the Identity solution, it is highly recommended to install [Connect Health](/azure/active-directory/hybrid/whatis-azure-ad-connect).

## Next steps

Learn about Identity and Platform Access.

> [!div class="nextstepaction"]
> [Platform Access](identity-access-platform-access.md)
