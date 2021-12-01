---
title: Define Azure Active Directory tenants
description: Understand how to set up Azure Active Directory tenants.
author: jtracey93
ms.author: jatracey
ms.date: 08/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Define Azure AD tenants

An Azure AD tenant provides identity and access management, which is an important part of your security posture. An Azure AD tenant ensures that authenticated and authorized users only access the resources to which they have permissions. Azure AD provides these services to applications and services deployed in and outside of Azure (such as on-premises or third-party cloud providers).

Azure AD is also used by software as a service (SaaS) applications such as Microsoft 365 and Azure Marketplace. Organizations already using on-premises Azure AD can integrate it with their current infrastructure and extend cloud authentication. Each Azure AD directory has one or more domains. A directory can have many subscriptions associated with it but only one Azure AD tenant.

Ask basic security questions during the Azure AD design phase, such as how your organization manages credentials and how it controls human, application, and programmatic access.

**Design considerations:**

- An Azure subscription can only trust one Azure AD tenant at a time, further information can be found at [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)

- Multiple Azure AD tenants can function in the same enrollment.

- Azure Lighthouse only supports delegation at the subscription and resource group scopes.

- The `*.onmicrosoft.com` domain name created for each Azure AD tenant must be globally unique as per the [terminology section in what is Azure Active Directory?](/azure/active-directory/fundamentals/active-directory-whatis#terminology)
  
  - The `*.onmicrosoft.com` domain name for each Azure AD tenant cannot be changed once created.

- Review [Compare self-managed Active Directory Domain Services, Azure Active Directory, and managed Azure Active Directory Domain Services](/azure/active-directory-domain-services/compare-identity-solutions) to fully understand the differences between all the options and how they relate

- Explore the [authentication methods offered by Azure Active Directory](/azure/active-directory/hybrid/choose-ad-authn) as part of your Azure Active Directory tenant planning

- If using [Azure Government](/azure/azure-government/documentation-government-welcome) review the guidance around Azure AD tenants in [Planning identity for Azure Government applications](/azure/azure-government/documentation-government-plan-identity)

- If using Azure Government, Azure China 21Vianet, Azure Germany ([closed on October 29, 2021](https://www.microsoft.com/cloud-platform/germany-cloud-regions)) then review [National clouds](/azure/active-directory/develop/authentication-national-cloud) for further guidance around Azure AD

**Design recommendations:**

- Add one or more custom domains to your Azure AD tenant as per [Add your custom domain name using the Azure Active Directory portal](/azure/active-directory/fundamentals/add-custom-domain)

  - Review [Azure AD UserPrincipalName population](/azure/active-directory/hybrid/plan-connect-userprincipalname) if planning to or using Azure AD Connect to ensure custom domain names are reflected in you on-premises Active Directory Domain Services environment.

- Define your Azure single sign-on strategy, using Azure AD Connect, based on one of the supported [topologies](/azure/active-directory/hybrid/plan-connect-topologies).

- If your organization doesn't have an identity infrastructure, start by implementing an Azure AD only identity deployment. Deployment with [Azure AD Domain Services](/azure/active-directory-domain-services) and [Microsoft Enterprise Mobility + Security](/mem/intune/fundamentals/what-is-intune) provides end-to-end protection for SaaS applications, enterprise applications, and devices.

- [Azure AD Multi-Factor Authentication](/azure/active-directory/authentication/concept-mfa-howitworks) provides another layer of security and authentication. For more security, also enforce [conditional access policies](/azure/active-directory/conditional-access/overview) for all privileged accounts.

- Plan for [emergency access](/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.

- Use [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to manage identities and access.

- Send all Azure AD diagnostic logs to a central Azure Monitor Log Analytics workspace following the guidance here: [Integrate Azure AD logs with Azure Monitor Logs](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics)

- Avoid creating multiple Azure AD tenants. For further information, see [Testing approach for enterprise-scale](../../enterprise-scale/testing-approach.md) and [Cloud Adoption Framework Azure best practices guidance to standardize on a single directory and identity](/secure/security-top-10.md#9-architecture-standardize-on-a-single-directory-and-identity).

- Use [Azure Lighthouse](/azure/lighthouse/overview) to grant third parties/partners access to Azure resources in customer Azure AD tenants and centralized access to Azure resources in multitenant Azure AD architectures.
