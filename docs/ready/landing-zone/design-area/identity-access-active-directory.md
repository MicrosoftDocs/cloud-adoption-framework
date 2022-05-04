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

Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server, Azure AD Domain Services (Azure AD DS), or both.

Most Azure environments will use at least Azure AD for Azure fabric authentication and AD DS local host authentication and group policy management.

## Design Considerations

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone [Centralize management operations CAF](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/centralize-operations).

- Applications that rely on domain services and use older protocols might be able to use [Azure AD DS](https://docs.microsoft.com/azure/active-directory-domain-services)

- There's a difference between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs and understand and document the authentication provider that each one will be using. Then plan for all applications. Visit this link for more information [Compare Active Directory to Azure Active Directory](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad) and [Identity decision guide - CAF](https://review.docs.microsoft.com/azure/cloud-adoption-framework/decision-guides/identity/?branch=main).

- Evaluate scenarios involving the set up of external users, customers, or partners to secure access to resources. Determine whether these scenarios involve B2B or B2C configuration. For more information, consult this link [External-identities in Azure](https://docs.microsoft.com/azure/active-directory/external-identities/external-identities-overview).

- For Azure Application Proxy, consider not using intranet access for the application since it could add latency to the user experience. For other considerations regarding Azure AD Application Proxy [Considerations-before-configuring-azure-ad-application-proxy](https://docs.microsoft.com/azure/active-directory/app-proxy/application-proxy-deployment-plan%23important-considerations-before-configuring-azure-ad-application-proxy).

## Design Recommendations

- Use centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements.

- The following types of privileged operations require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the necessary diligence:

    o Creating service principal objects

    o Registering applications in Azure AD

    o Procuring and handling certificates or wildcard certificates

- If an organization has a scenario where an application that uses on-premises authentication must be accessed remotely through Azure AD, consider using [Azure AD Application Proxy](https://docs.microsoft.com/azure/active-directory/app-proxy/application-proxy).

- Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD DS.

- Ensure your network design allows resources that require AD DS on Windows Server for local authentication and management can access the appropriate domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.

- When deploying Azure AD Domain Services or integrating on-premises in Azure, consider locations within Availability Zones for redundancy.

- Deploy Azure AD Domain Services within the primary region because this service can only be projected into one subscription. Azure Active Directory Domain Service can be expanded to further regions with replica sets.

- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft.

## Next steps

Learn about Identity and Platform Access.

> [!div class="nextstepaction"]
> [Platform](identity-access-platform-access.md)