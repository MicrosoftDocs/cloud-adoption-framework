---
title: Define Azure Active Directory tenants
description: Understand how to setup Azure Active Directory tenants.
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

- Multiple Azure AD tenants can function in the same enrollment.
- Azure Lighthouse only supports delegation at the subscription and resource group scopes.

**Design recommendations:**

- Base using Azure single sign-on on the selected [planning topology](/azure/active-directory/hybrid/plan-connect-topologies).

- If your organization doesn't have an identity infrastructure, start by implementing an Azure-AD-only identity deployment. Deployment with [Azure AD Domain Services](/azure/active-directory-domain-services) and [Microsoft Enterprise Mobility + Security](/mem/intune/fundamentals/what-is-intune) provides end-to-end protection for SaaS applications, enterprise applications, and devices.

- [Azure AD multifactor authentication](/azure/active-directory/authentication/concept-mfa-howitworks) provides another layer of security and authentication. For more security, also enforce [conditional access policies](/azure/active-directory/conditional-access/overview) for all privileged accounts.

- Plan for [emergency access](/azure/active-directory/users-groups-roles/directory-emergency-access) or break-glass accounts to prevent tenant-wide account lockout.

- Use [Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to manage identities and access.

- Avoid creating multiple Azure AD tenants. For further information, see [Testing approach for enterprise scale](../../enterprise-scale/testing-approach.md) and [Cloud Adoption Framework Azure best practices guidance to standardize on a single directory and identity](/secure/security-top-10.md#9-architecture-standardize-on-a-single-directory-and-identity).

- Use [Azure Lighthouse](/azure/lighthouse/overview) to grant third parties/partners access to Azure resources in customer Azure AD tenants and centralized access to Azure resources in multitenant Azure AD architectures.

