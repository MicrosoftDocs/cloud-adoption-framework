---
title: Azure Active Directory and hybrid identity
description: Understand Azure Active Directory (Azure AD) and hybrid identity considerations and recommendations.
author: anlucen
ms.author: doalle
ms.date: 06/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure Active Directory (Azure AD) and hybrid identity

A critical design decision for enterprise organizations adopting Azure is whether to extend current on-premises identity domains into Azure or to create new identity domains.

Most Azure environments use Azure Active Directory (Azure AD) for Azure fabric authentication. On-premises environments use Active Directory Domain Services (AD DS) local host authentication and group policy management.

## Azure AD, Azure AD DS, and AD DS on Windows Server

When evaluating which type of Active Directory solution to adopt, understand the capabilities and differences of Azure AD, Azure AD Domain Services (Azure AD DS), and AD DS on Windows Server.

### Design considerations

- Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone. For more information, see [Centralize management operations](../../../manage/centralize-operations.md).

- Applications that rely on domain services and use older protocols might be able to use [Azure AD Domain Services (Azure AD DS)](/azure/active-directory-domain-services).

- Evaluate your application needs by understanding and documenting the authentication provider that each application uses. Use the reviews to help plan the type of Active Directory your organization should use. For more information, see [Compare Active Directory to Azure Active Directory](/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad) and [Identity decision guide](../../../decision-guides/identity/index.md).

- Evaluate scenarios that involve setting up external users, customers, or partners to secure access to resources. Determine whether these scenarios involve [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) or [Azure AD B2C](/azure/active-directory-b2c/overview) configurations. For more information, see [Azure AD External Identities](/azure/active-directory/external-identities/external-identities-overview).

- If you use [Azure AD Application Proxy](/azure/active-directory/app-proxy/application-proxy), consider not using intranet access, because it could add latency to the user experience. For more information about Azure AD Application Proxy, see [Azure AD Application Proxy planning](/azure/active-directory/app-proxy/application-proxy-deployment-plan#plan-your-implementation) and [Azure AD Application Proxy security considerations](/azure/active-directory/app-proxy/application-proxy-security).

### Design recommendations

- Use centralized and delegated responsibilities based on role and security requirements to manage resources inside the landing zone. For more information, see [Establish operational management practices in the cloud](../../../manage/best-practices.md).

- The following types of privileged operations require special permissions. Consider which users will be handling such requests, and how to adequately secure and monitor their accounts.

  - Creating service principal objects.
  - Registering applications in Azure AD.
  - Procuring and handling certificates or wildcard certificates.

- To access applications that use on-premises authentication remotely through Azure AD, use [Azure AD Application Proxy](/azure/active-directory/app-proxy/application-proxy).

- Evaluate the compatibility of workloads for Azure AD DS and for AD DS on Windows Server.

- Make sure to design your network so resources that require AD DS on Windows Server for local authentication and management can access their domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.

- When you deploy Azure AD DS or integrate on-premises environments into Azure, use locations with [Availability Zones](/azure/availability-zones/az-overview) for increased availability.

- Deploy Azure AD DS within the primary region, because you can only project this service into one subscription. You can expand Azure AD DS to further regions with [replica sets](/azure/active-directory-domain-services/concepts-replica-sets).

- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft. For more information, see [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview).

## Azure and on-premises hybrid identity

For hosting infrastructure as a service (IaaS) hybrid identity solutions, evaluate the following considerations and recommendations:

### Design considerations

- For options to meet organizational requirements when integrating on-premises Active Directory with Azure, see [Integrate on-premises AD with Azure](/azure/architecture/reference-architectures/identity).

- Authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the authentication methods Azure AD offers. For more information, see [Authentication for Azure AD hybrid identity solutions](/azure/active-directory/hybrid/choose-ad-authn?toc=/azure/architecture/toc.json&bc=/azure/architecture/bread/toc.json).

- If you have Active Directory Federation Services (AD FS) federation with Azure AD, you can use password hash synchronization as a backup. AD FS doesn't support seamless single sign-on (SSO).

- Determine the right synchronization tool for your cloud identity. For more information, see [Determine directory synchronization requirements](/azure/active-directory/hybrid/plan-hybrid-identity-design-considerations-directory-sync-requirements).

### Design recommendations

- For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario. For more information, see [Deploy AD DS in an Azure virtual network](/azure/architecture/reference-architectures/identity/adds-extend-domain).

- If you have AD FS, move to the cloud to centralize identity and reduce operational effort. If AD FS is still part of your identity solution, install and use [Azure AD Connect](/azure/active-directory/hybrid/whatis-azure-ad-connect).

## Next steps

> [!div class="nextstepaction"]
> [Identity for Azure platform resources](identity-access-platform-access.md)
