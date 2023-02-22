---
title: Considerations and recommendations for multi-tenant Azure landing zone scenarios
description: Learn about the considerations and recommendations when handling multiple Azure Active Directory tenants with Azure landing zones.
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Considerations and recommendations for multi-tenant Azure landing zone scenarios

The article, [Azure landing zones and multiple Azure Active Directory tenants](overview.md), describes how management groups and Azure policy and subscriptions interact and operate with Azure Active Directory tenants. The article describes the limitation of these resources operating only within a single Azure Active Directory tenant. Under these conditions, if multiple Azure Active Directory tenants exist, or are required for an organization, the Azure landing zones must be deployed into each of the Azure Active Directory tenants separately.

## Topology of Azure landing zones with multiple Azure Active Directory tenants

[![Diagram of multiple Azure Active Directory tenants with Azure landing zones deployed.](media/contoso-multi-tenant.png)](media/contoso-multi-tenant.png#lightbox)

The previous diagram shows an example of the Contoso Corporation, which has four Azure Active Directory tenants due to mergers and acquisitions as the corporation has grown over time.

| Azure Active Directory tenant `*.onmicrosoft.com` domain | Usage notes                                                                                                                                                                                        |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `contoso.onmicrosoft.com`                  | Primary corporate Azure Active Directory tenant that's used by the Contoso Corporation. Azure and Microsoft 365 services are used in this tenant.                                                                                |
| `fabrikam.onmicrosoft.com`                 | Primary Azure Active Directory tenant that's used by Fabrikam. Azure and Microsoft 365 services are used in this tenant. This tenant has remained separated since the acquisition by the Contoso Corporation.                                 |
| `tailwind.onmicrosoft.com`                 | Primary Azure Active Directory tenant that's used by Tailwind. Azure and Microsoft 365 services are used in this tenant. This tenant has remained separated since the acquisition by the Contoso Corporation.                                 |
| `contoso365test.onmicrosoft.com`           | Azure Active Directory tenant that's used by the Contoso Corporation for testing Azure Active Directory and Microsoft 365 services and configuration **only**. All Azure environments live within the `contoso.onmicrosoft.com` Azure Active Directory tenant. |

The Contoso Corporation originally started out with one Azure Active Directory tenant of `contoso.onmicrosoft.com`. Over time, they made multiple acquisitions of other companies and brought these companies into the Contoso Corporation.

These acquisitions of Fabrikam (`fabrikam.onmicrosoft.com`) and Tailwind (`tailwind.onmicrosoft.com`) brought with them existing Azure Active Directory tenants in which Microsoft 365 (Exchange Online, SharePoint, OneDrive) and Azure services are used within. These companies, and associated Azure Active Directory tenants, are kept separated because parts of the Contoso Corporation and its companies might be sold in the future.

The Contoso Corporation also has a separate Azure Active Directory tenant for the sole purpose of testing Azure Active Directory and Microsoft 365 services and features. But no Azure services are tested in this separate Azure Active Directory tenant. They're tested in the `contoso.onmicrosoft.com` Azure Active Directory tenant.

>[!TIP]
> For more information about testing Azure landing zones and Azure workloads and resources within Azure landing zones environments, see: 
>    - [How to handle "dev/test/production" workload landing zones in Azure landing zone architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture) 
>    - [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

>[!NOTE]
> Azure landing zones is deployed within a single Azure Active Directory tenant. If you have multiple Azure Active Directory tenants that you want to deploy Azure resources within, and you want to control, govern and monitor them by using Azure landing zones, you must deploy Azure landing zones within each of those tenants individually.

## Considerations and recommendations for Azure landing zones in multi-tenant scenarios

This section explains key considerations and recommendations about Azure landing zones and Azure Active Directory multi-tenant scenarios and usage.

### Considerations

- Start with a [single tenant approach](overview.md#why-a-single-azure-active-directory-tenant-is-sufficient) to your Azure Active Directory tenant design.
  - The single tenant is typically the organization's corporate Azure Active Directory tenant, where the user's identities exist and a service, like Microsoft 365, is running.
  - Only create more Azure Active Directory tenants when there are requirements that can't be met by using the corporate Azure Active Directory tenant.
- Consider using Azure Active Directory [administrative units](/azure/active-directory/roles/administrative-units) to manage the segregation and isolation of users, groups, and devices (for example, different teams) within a single Azure Active Directory tenant. Use this resource instead of creating multiple Azure Active Directory tenants.
- Consider using sandbox subscriptions for the initial application workload development and investigation. For more information, see [How to handle "dev/test/production" workload landing zones in Azure landing zone architecture](https://aka.ms/alz/dtp).
- Migrating Azure subscriptions between Azure Active Directory tenants is complex and requires pre and post migration activities to be completed to enable a migration. For more information, see [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription).
  - It's easier to rebuild the application workload in a new Azure subscription in the destination tenant. It gives you more control over the migration.
- Consider the [complexities](overview.md#complexities-with-multiple-azure-active-directory-tenants) of managing, governing, configuring, monitoring, and securing multiple Azure Active Directory tenants.
  - A single Azure Active Directory tenant is easier to manage, govern, and secure.
- Consider your JML (joiners, movers, and leavers) process, workflows, and tooling.
  - Can these support and handle multiple Azure Active Directory tenants?
- Consider the impact to end users having to manage, govern, and secure multiple identities for themselves.
- Consider the impact on cross-tenant collaboration, especially from an end user's perspective, when choosing multiple Azure Active Directory tenants.
  - The Microsoft 365 collaboration experience and support between users within a single Azure Active Directory tenant is optimal.
- Consider the impact to auditing and regulatory compliance checks across multiple Azure Active Directory tenants before choosing an approach.
- Consider the increase in licensing costs when multiple Azure Active Directory tenants are used.
  - Licenses for products like Azure Active Directory Premium P1/P2 or Microsoft 365 services don't span across Azure Active Directory tenants.
- A single Enterprise Agreement enrollment can support and provide subscriptions to multiple Azure Active Directory tenants by setting the authentication level on the enrollment to work and school account cross-tenant. For more information, see [Azure EA portal administration](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant).
- A single Microsoft Customer Agreement can support and provide subscriptions to multiple Azure Active Directory tenants. For more information, see [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants).
- Consider the limitations that might be introduced and brought to the forefront for application teams and developers when opting for an Azure Active Directory multi-tenant architecture. Be aware of limitations in Azure Active Directory integration for Azure products and services, such as Azure Virtual Desktop, Azure Files, and Azure SQL.
  - For more information, see [Azure products and services Azure Active Directory integration section](#azure-products--services-azure-active-directory-integration).
- Consider using [Azure Active Directory B2B](/azure/active-directory/external-identities/what-is-b2b) to simplify and enhance user experience and administration when your organization has multiple Azure Active Directory tenants.
- Consider using the Microsoft identity platform, with Azure Active Directory with B2B and B2C capabilities, to enable developers to create applications in a single Azure subscription, and within a single tenant, to support users from many identity sources.
  - For more infomation, see [Multi-tenant apps](/azure/active-directory/develop/application-model#multi-tenant-apps) and [Architect multi-tenant solutions on Azure](/azure/architecture/guide/multitenant/overview).
- Consider using the features available for multi-tenant organizations. For more information, see [What is a multi-tenant organization in Azure Active Directory?](/azure/active-directory/multi-tenant-organizations/overview)
- Consider [keeping your Azure landing zone up to date](/azure/cloud-adoption-framework/govern/resource-consistency/keep-azure-landing-zone-up-to-date).

#### Azure products and services Azure Active Directory integration

Many Azure products and services don't support Azure Active Directory B2B as part of their native Azure Active Directory integration. There are several services that support Azure Active Directory B2B authentication as part of their Azure Active Directory integrations. It's safer for the service’s default to not support Azure Active Directory B2B as part of their Azure Active Directory integration.

Services that provide a native integration with Azure Active Directory, such as Azure Storage, Azure SQL, Azure Files, and Azure Virtual Desktop, use a "one-click" or "no-click" style approach to integrate. They require [authentication and authorization](/azure/active-directory/develop/authentication-vs-authorization) scenarios as part of their service. This is typically supported against the “home tenant” while some services might enable support for Azure Active Directory B2B/B2C scenarios. For more information about the Azure subscription's relationship to Azure Active Directory, see [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory).

It's important to carefully consider which Azure Active Directory tenant your Azure subscriptions are associated with. This relationship dictates which products and services, and their features, are used by application or workload teams that need to support the identities and from which tenant the identities are from. Typically, identities are in the corporate Azure Active Directory tenant.

If multiple Azure Active Directory tenants are used to host all Azure subscriptions, it hinders the application workload teams from taking advantage of some Azure products and services Azure Active Directory integrations. If the application workload teams have to develop their applications around these imposed limitations, the authentication and authorization posture becomes more complex and less secure.

This problem can be avoided if you use a single Azure Active Directory tenant as the home for all your Azure subscriptions. Application workload teams can take advantage of the best approach for authentication and authorization for their application or service. The application workload team has a simple architecture to manage, govern, and control, and it removes potential constraints.

For more information, see [Resource isolation in a single tenant to secure with Azure Active Directory](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant).

### Recommendations

- Use a single Azure Active Directory tenant, usually the corporate Azure Active Directory tenant and only create more Azure Active Directory tenants when clear and justified requirements arise that can't be met using the corporate Azure Active Directory tenant.
  - Utilize sandbox subscriptions to provide application teams safe, controlled and isolated development environments within the same single Azure Active Directory tenant, as documented here in [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?](https://aka.ms/alz/dtp)
- Use Azure Active Directory multi-tenant applications, were possible, when creating integrations from operational tooling, such as ServiceNow, when connecting them to multiple Azure Active Directory tenants, as per the [guidance here](/azure/active-directory/fundamentals/secure-with-azure-ad-best-practices#operational-tools)
- If you're an ISV review this specific guidance [Independent software vendor (ISV) considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone)
- Utilize Azure Lighthouse where possible, to simplify cross-tenant management experiences. [See Azure Lighthouse usage in ALZ multi-tenant](lighthouse.md)
- Create Account Owners, Invoice Section Owners, Subscription Creators on your Enterprise Agreement Enrollments or Microsoft Customer Agreements that are homed in the destination Azure Active Directory tenant for the Subscriptions they'll create to avoid having to [Change Directories on Azure Subscriptions](/azure/role-based-access-control/transfer-subscription) once created.
  - [Azure EA portal administration](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant)
  - [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants)
- Review the [Azure Active Directory security operations guide](/azure/active-directory/fundamentals/security-operations-introduction)
- Keep the number of Global Administrator Accounts to a minimum (ideally <5).
- Enable [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) for all Admin accounts to ensure no standing privilege and provide JIT access.
- Require approval in PIM to activate critical roles such as the Global Administrator Role.
  - Consider making approvers from multiple teams approve Global Administrator usage.
- Enable monitoring/notifications on Global Administrator role activation to all required stakeholders.
- Ensure that the "Access management for Azure resources" setting on Global Administrators is set to `No` were it's not required.
- Enable and configure the following Azure Active Directory services and features to simplify the mutli-tenant experiences for administration and users within your organization:
  - [B2B collaboration](/azure/active-directory/external-identities/what-is-b2b)
  - [B2B direct connect](/azure/active-directory/external-identities/b2b-direct-connect-overview)
  - [Cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-overview)
  - [Cross-tenant synchronization (preview)](/azure/active-directory/multi-tenant-organizations/cross-tenant-synchronization-overview)
- If you are an organization with Azure Active Directory tenant in multiple Microsoft Clouds, like Microsoft Azure commercial cloud, Microsoft Azure China 21Vianet, Microsoft Azure Government, configure [Microsoft cloud settings for B2B collaboration (Preview)](/azure/active-directory/external-identities/cross-cloud-settings) to simplify users experiences when collaborating across tenants
- Application teams and developers should review the following resources when constructing applications and services for multi-tenancy
  - [Multi-tenant apps in Azure Active Directory](/azure/active-directory/develop/application-model#multi-tenant-apps)
  - [Architect multitenant solutions on Azure](/azure/architecture/guide/multitenant/overview)

## Next steps

> [!div class="nextstepaction"]
> [Automating Azure landing zones across multiple tenants](automation.md)