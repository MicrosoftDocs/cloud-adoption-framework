---
title: Azure Landing Zones and multiple Azure Active Directory tenants
description: Understand how multiple Azure Active Directory tenants work within the context of Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure Landing Zones and multiple Azure Active Directory tenants

Azure landing zones are built upon [Management Groups](/azure/governance/management-groups/overview) to which [Azure Policies](/azure/governance/policy/overview) are assigned to and Subscriptions placed into the Management Groups to provide the required governance controls that an organization needs to meet its security and compliance needs.

>[!TIP]
> Review the guidance available in [Security control mapping with Azure landing zones](/azure/cloud-adoption-framework/ready/control-mapping/security-control-mapping) to learn how you can use Azure landing zone and Azure Policy to help achieve your organizations security, compliance and regulatory needs.

All of these resources are deployed within a single Azure Active Directory (AAD) tenant. And today, Management Groups and most other Azure resources, like Azure Policy, only support operating within a single Azure Active Directory tenant. Furthermore, An Azure Subscription has a trust relationship with Azure Active Directory tenant. A Subscription trusts an Azure Active Directory tenant to authenticate users, services, and devices against the Azure Resource Manager (ARM) for control plane operations and some Azure services, like Azure Storage, for data plane operations.

Multiple Subscriptions can trust the same Azure Active Directory tenant. Each Subscription can only trust a single Azure Active Directory tenant. Read more on the relationship between an Azure Subscription and an Azure Active Directory tenant here in, [Add an existing Azure subscription to your tenant.](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)

[![Diagram of single Azure Active Directory tenant with Azure Landing Zones deployed](media/contoso-single-tenant.png)](media/contoso-single-tenant.png#lightbox)

As shown in the diagram above Management Groups, Azure Policies and Azure Subscriptions are deployed, following the [Azure landing zones conceptual architecture](/azure/cloud-adoption-framework/ready/landing-zone/#azure-landing-zone-conceptual-architecture), within a single Azure Active Directory tenant.

Your organization might be required to use multiple Azure Active Directory tenants for many reasons, that is detailed [here](scenarios.md), and therefore guidance on [how to deploy and manage](automation.md) the Azure landing zone deployment into each of these tenants is required alongside [considerations and recommendations](considerations-recommendations.md) for handling these multiple Azure Active Directory tenants.

>[!NOTE]
> This article only covers the scope of Azure in detail. It does not cover guidance for Microsoft 365 or other Microsoft Cloud offerings, such as Dynamics 365 or Power Platform in the same level of detail.
>
> It also focuses on the platform rather than applications that are built on top of the platform, see [platform vs. application landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-vs-application-landing-zones), in regards to tenants. If you are looking for guidance around application architecture and multiple Azure Active Directory tenants then review the following resources:
>
> - [Multi-tenant apps in Azure Active Directory](/azure/active-directory/develop/application-model#multi-tenant-apps)
> - [Architect multitenant solutions on Azure](/azure/architecture/guide/multitenant/overview)

## Why a single Azure Active Directory tenant is sufficient

Before understanding the reasons you might require multiple Azure Active Directory tenants, it's first important to understand why a single Azure Active Directory tenant is normally sufficient and should be the default starting point for all organizations.

It is recommended to use your existing corporate Azure Active Directory tenant for Azure subscriptions for the best productivity and collaboration experience across the platform.

Within a single tenant, development teams and application owners can be granted least privileged roles to create non-production instances of Azure resources and trusted apps, as well as test apps, test users and groups, and test policies for those objects. The following article describes how to delegate administration with a single tenant: [Resource isolation in a single tenant to secure with Azure Active Directory.](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant)

You should only create more Azure Active Directory tenants when clear requirements arise that can't be met using the corporate Azure Active Directory tenant.

The “corporate” Azure Active Directory tenant is generally the first tenant provisioned in the organization (with Microsoft 365). This tenant is used for corporate application access, Microsoft 365 services and supports the collaboration within an organization.  The primary reason to start with this existing is because the work to provision, manage, secure, lifecycle of the identities is already established. This makes the task of onboarding new apps, resources, subscriptions easier, as it’s a mature, understood environment with established process, procedures, and controls.

### Complexities with multiple Azure Active Directory tenants

Creating a new Azure Active Directory tenant requires extra work to be done to provision, manage and secure and govern the identities. Extra work is also required to establish the required policies and procedures. Collaboration is always best in a single Azure Active Directory tenant, moving to a multi-tenant model creates a boundary, which can result in user friction, management overhead, increase the attack surface area and therefore also the security risk, and complicate product scenarios and limitations. Some examples include:

- Multiple identities for users and administrators for each tenant – If [Azure Active Directory B2B](/azure/active-directory/external-identities/what-is-b2b) isn’t utilized then the user has multiple sets of credentials to manage. ([see the considerations and recommendations](considerations-recommendations.md))
- Azure services limitations in supporting multiple Azure Active Directory tenants – Azure workloads that only support identities homed in the tenant to which it's bound to. (see [the Azure Products & Services Azure Active Directory Integration section in Considerations & Recommendations](considerations-recommendations.md#azure-products--services-azure-active-directory-integration) for more info)
- No centralized configuration or management for Azure Active Directory tenants – Multiple security policies, management policies, configuration, portals, APIs, JML (Joiners, Movers, Leavers) processes.

For these reasons, organizations need to be clear on why they're deviating from the corporate Azure Active Directory tenant model, to ensure the extra overhead and complexity is justified in meeting the requirements. There are valid scenarios where our customers feel this is the case and these are documented in the [scenarios article](scenarios.md).

Another concern is around the power of the Global Administrator (Global Admin) role. The Global Admin role does provide the highest level of permissions available within an Azure Active Directory tenant and in the context of Azure, any Global Admin is able to assume control of any Azure subscription linked to the Azure Active Directory tenant, as documented [here](/azure/role-based-access-control/elevate-access-global-admin).

>[!IMPORTANT]
> [Azure Active Directory Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) should be used to help protect this, and other privileged, roles within Azure Active Directory and Azure.

The ownership of this role across internal teams/department can provide a challenge as the Identity team and the Azure team are often in different teams, departments, org structures.

The teams that operate Azure, as detailed [here](/azure/cloud-adoption-framework/organize/#understand-required-cloud-functions), are responsible for Azure services and rightfully want to ensure the security of the services of which they manage, and this can result in a level of nervousness when individuals outside of that team have roles with the power to, potentially, access their environments.

Azure Active Directory does provide controls that help mitigate this problem on a technical level (but it should be noted this is also a people and process discussion), see the [recommendations.](considerations-recommendations.md#recommendations)

>[!IMPORTANT]
> Multiple Azure Active Directory tenants **are not the recommend** approach for most customers, instead a single Azure Active Directory tenant, normally the “corporate” Azure Active Directory tenant, is recommended for most as it can provide the required separation requirements.
> 
> This is documented in the following pieces of guidance:
> 
> - [Define Azure Active Directory tenants](/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-ad-define)
> - [Azure security best practices](/azure/cloud-adoption-framework/secure/security-top-10#9-architecture-standardize-on-a-single-directory-and-identity)
> - [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)
> - [Introduction to delegated administration and isolated environments](/azure/active-directory/fundamentals/secure-with-azure-ad-introduction)
> - [Resource isolation in a single tenant](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant)
> - [Step 1. Your Microsoft 365 for enterprise tenants](/microsoft-365/solutions/tenant-management-tenants)

## Next steps

> [!div class="nextstepaction"]
> [Scenarios for multiple Azure Active Directory tenants](scenarios.md)