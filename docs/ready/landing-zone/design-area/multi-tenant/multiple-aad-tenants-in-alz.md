---
title: Multiple Azure AD Tenants in ALZ - Overview
description: Understand how multiple Azure AD Tenants work within the context of Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Multiple Azure AD Tenants in ALZ - Overview

Azure landing zones at its core are built upon [Management Groups](/azure/governance/management-groups/overview) to which [Azure Policies](/azure/governance/policy/overview) are assigned to and Subscriptions placed into the Management Groups to provide the required governance controls that an organization needs to meet its security and compliance needs.

>[!TIP]
> Checkout the guidance available in [Security control mapping with Azure landing zones](/azure/cloud-adoption-framework/ready/control-mapping/security-control-mapping) to learn how you can use Azure landing zone and Azure Policy to help achieve your organizations security, compliance and regulatory needs.

All of these resources are deployed inside of a single Azure Active Directory (AD) Tenant. And today, Management Groups and most other Azure resources, like Azure Policy etc., only support operating within a single Azure AD Tenant. Furthermore, An Azure Subscription has a trust relationship with Azure AD Tenant. A Subscription trusts Azure AD Tenant to authenticate users, services, and devices.

Multiple Subscriptions can trust the same Azure AD Tenant. Each Subscription can only trust a single Azure AD Tenant. Read more on the relationship between an Azure Subscription and an Azure AD Tenant here in, [Add an existing Azure subscription to your tenant.](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)

>[!NOTE]
> This article only covers the scope of Azure in detail. It does not include, or cover, guidance for Microsoft 365 or other Microsoft Cloud offerings, such as Dynamics 365 or Power Platform in the same level of detail.

## What does this mean for Azure landing zones?

No Azure landing zones architecture is understood, we can bring this back to what this means for Azure landing zones.

[![Diagram of single Azure AD Tenant with Azure Landing Zones deployed](media/alz-multi-tenant-1.png)](media/alz-multi-tenant-1.png#lightbox)

As shown in the diagram above Management Groups, Azure Policies and Azure Subscriptions are deployed, following the [Azure landing zones conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture), inside of a single Azure AD Tenant.

Your organization might be required to use multiple Azure AD Tenants for many reasons, that will be covered later in this article, and therefore guidance on how to deploy and manage the Azure landing zone deployment into each of these tenants is required alongside recommendations and considerations for handling these multiple Azure AD Tenants.

The rest of this document will detail the scenarios for multiple Azure AD Tenants we commonly see for organizations as well as recommendations and considerations for Azure landing zone deployment and operations.

## Why not one?

It is recommended to use your existing corporate Azure AD tenant for Azure subscriptions for the best productivity and collaboration experience across the platform.

Within a single tenant, development teams and application owners can be granted least privileged roles to create non-production instances of Azure resources and trusted apps, as well as test apps, test users and groups, and test policies for those objects. The following article describes how to delegate administration with a single tenant: [Resource isolation in a single tenant to secure with Azure Active Directory.](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant)

You should only create more Azure AD tenants when clear requirements arise that can't be met using the corporate Azure AD tenant.

The “corporate” Azure AD tenant is generally the first tenant provisioned in the organization (with Microsoft 365). This tenant is used for corporate application access, Microsoft 365 services and supports the collaboration within an organization.  The primary reason to start with this existing tenant is because the work to provision, manage, secure, lifecycle of the identities is already established. This makes the task of onboarding new apps, resources, subscriptions easier, as it’s a mature, understood environment with established process, procedures, and controls.

Creating a new Azure AD tenant requires extra work to be done to provision, manage and secure and govern the identities. Extra work is also required to establish the required policies and procedures. Collaboration is always best in a single Azure AD tenant, moving to a Multi-Tenant model creates a boundary, which can result in user friction, management overhead, increase the surface area for risk, and complicate product scenarios and limitations. Some examples include:

- Multiple identities for users and administrators for each tenant – If [Azure AD B2B](/azure/active-directory/external-identities/what-is-b2b) isn’t utilized then the user, administrator has multiple sets of credentials to manage. ([see the considerations and recommendations](multiple-aad-tenants-in-alz-handling-c-r.md))
- Azure services limitations in supporting multiple Azure AD tenants – Azure workloads that only support identities homed in the tenant to which it's bound to. (see [the Azure Products & Services AAD Integration section in Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-c-r.md#azure-products--services-aad-integration) for more info)
- No centralized configuration or management for Azure AD tenants – Multiple security policies, management policies, configuration, portals, APIs, JML (Joiners, Movers, Leavers) processes.

For these reasons, organizations need to be clear on why they're deviating from the corporate Azure AD tenant model, to ensure the extra overhead and complexity is justified in meeting the requirements. There are valid scenarios where our customers feel this is the case and these are documented in the [scenarios article](multiple-aad-tenants-in-alz-scenarios.md).

Another concern that customers flag to us, is around the power of the Global Administrator (Global Admin) role. The Global Admin role does provide the keys to the kingdom and in the context of Azure, any Global Admin is able to assume control of any Azure subscription linked to the AAD tenant.

The ownership of this role across internal teams/department can provide a challenge as the “Identity” team and the “Azure” team are often in different teams, departments, org structures.

The Azure teams are responsible for Azure services and rightfully want to ensure the security of the services of which they manage, and this can result in a level of nervousness when individuals outside of that team have roles with the power to, potentially, access their environments.

Azure AD does provide controls that help mitigate this problem on a technical level (but it should be noted this is also a people and process discussion), see the [recommendations.](multiple-aad-tenants-in-alz-handling-c-r.md#recommendations)

>[!IMPORTANT]
> Multiple Azure AD Tenants **are not the recommend** approach for most customers, instead a single Azure AD Tenant, normally the “corporate” Azure AD Tenant, is recommended for most as it can provide the required separation requirements.
> 
> This is documented in the following pieces of guidance:
> - [Define Azure AD tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-ad-define)
> - [Azure security best practices](/azure/cloud-adoption-framework/secure/security-top-10#9-architecture-standardize-on-a-single-directory-and-identity)
> - [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)
> - [Introduction to delegated administration and isolated environments](/azure/active-directory/fundamentals/secure-with-azure-ad-introduction)
> - [Resource isolation in a single tenant](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant)
> - [Step 1. Your Microsoft 365 for enterprise tenants](/microsoft-365/solutions/tenant-management-tenants)

## Next steps

> [!div class="nextstepaction"]
> [Multiple Azure AD Tenants in ALZ - Scenarios](multiple-aad-tenants-in-alz-scenarios.md)