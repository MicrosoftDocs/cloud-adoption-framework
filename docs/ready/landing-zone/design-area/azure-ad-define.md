---
title: Define Microsoft Entra tenants
description: Understand how to set up Microsoft Entra tenants.
author: jtracey93
ms.author: jatracey
ms.date: 01/04/2022
ms.topic: conceptual
ms.custom: think-tank, UpdateFrequency.5
---

# Define Microsoft Entra tenants

A Microsoft Entra tenant provides identity and access management, which is an important part of your security posture. A Microsoft Entra tenant ensures that authenticated and authorized users only access the resources to which they have permissions. Microsoft Entra ID provides these services to applications and services deployed in and outside of Azure (such as on-premises or third-party cloud providers).

Microsoft Entra ID is also used by software as a service (SaaS) applications such as Microsoft 365 and Azure Marketplace. Organizations already using on-premises AD can integrate it with their current infrastructure and extend cloud authentication. Each Microsoft Entra directory has one or more domains. A directory can have many subscriptions associated with it but only one Microsoft Entra tenant.

Ask basic security questions during the design phase, such as how your organization manages credentials and how it controls human, application, and programmatic access.

>[!TIP]
> If you have multiple Microsoft Entra tenants, review [Azure landing zones and multiple Microsoft Entra tenants](multi-tenant/overview.md) and its associated content.

**Design considerations:**

- An Azure subscription can only trust one Microsoft Entra tenant at a time, further information can be found at [Associate or add an Azure subscription to your Microsoft Entra tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)

- Multiple Microsoft Entra tenants can function in the same enrollment. Review [Azure landing zones and multiple Microsoft Entra tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/multi-tenant/overview)

- Azure Lighthouse only supports delegation at the subscription and resource group scopes.

- The `*.onmicrosoft.com` domain name created for each Microsoft Entra tenant must be globally unique as per the [terminology section in what is Microsoft Entra ID?](/azure/active-directory/fundamentals/active-directory-whatis#terminology)
  
  - The `*.onmicrosoft.com` domain name for each Microsoft Entra tenant cannot be changed once created.

- Review [Compare self-managed Active Directory Domain Services, Microsoft Entra ID, and managed Microsoft Entra Domain Services](/azure/active-directory-domain-services/compare-identity-solutions) to fully understand the differences between all the options and how they relate

- Explore the [authentication methods offered by Microsoft Entra ID](/azure/active-directory/hybrid/choose-ad-authn) as part of your Microsoft Entra tenant planning

- If using [Azure Government](/azure/azure-government/documentation-government-welcome) review the guidance around Microsoft Entra tenants in [Planning identity for Azure Government applications](/azure/azure-government/documentation-government-plan-identity)

- If using Azure Government, Azure China 21Vianet, Azure Germany ([closed on October 29, 2021](https://www.microsoft.com/cloud-platform/germany-cloud-regions)) then review [National/Regional clouds](/azure/active-directory/develop/authentication-national-cloud) for further guidance around Microsoft Entra ID

**Design recommendations:**

- Add one or more custom domains to your Microsoft Entra tenant as per [Add your custom domain name using the Microsoft Entra admin center](/azure/active-directory/fundamentals/add-custom-domain)

  - Review [Microsoft Entra UserPrincipalName population](/azure/active-directory/hybrid/plan-connect-userprincipalname) if planning to or using Microsoft Entra Connect to ensure custom domain names are reflected in your on-premises Active Directory Domain Services environment.

- Define your Azure single sign-on strategy, using Microsoft Entra Connect, based on one of the supported [topologies](/azure/active-directory/hybrid/plan-connect-topologies).

- If your organization doesn't have an identity infrastructure, start by implementing a Microsoft Entra-only identity deployment. Deployment with [Microsoft Entra Domain Services](/azure/active-directory-domain-services) and [Microsoft Enterprise Mobility + Security](/mem/intune/fundamentals/what-is-intune) provides end-to-end protection for SaaS applications, enterprise applications, and devices.

- [Microsoft Entra multifactor authentication](/azure/active-directory/authentication/concept-mfa-howitworks) provides another layer of security and authentication. For more security, also enforce [conditional access policies](/azure/active-directory/conditional-access/overview) for all privileged accounts.

- Plan for [emergency access](/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.

- Use [Microsoft Entra Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to manage identities and access.

- Send all Microsoft Entra diagnostic logs to a central Azure Monitor Log Analytics workspace following the guidance here: [Integrate Microsoft Entra logs with Azure Monitor Logs](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics)

- Avoid creating multiple Microsoft Entra tenants. For further information, see [Testing approach for enterprise-scale](../../enterprise-scale/testing-approach.md) and [Cloud Adoption Framework Azure best practices guidance to standardize on a single directory and identity](../../../secure/security-top-10.md#9-architecture-standardize-on-a-single-directory-and-identity).

- Use [Azure Lighthouse](/azure/lighthouse/overview) to grant third parties/partners access to Azure resources in customer Microsoft Entra tenants and centralized access to Azure resources in multitenant Microsoft Entra architectures.
