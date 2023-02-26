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

## Azure landing zones with multiple Azure Active Directory tenants

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
> Azure landing zones are deployed within a single Azure Active Directory tenant. If you have multiple Azure Active Directory tenants that you want to deploy Azure resources within, and you want to control, govern, and monitor them by using Azure landing zones, you must deploy Azure landing zones within each of those tenants individually.

## Considerations and recommendations for Azure landing zones in multi-tenant scenarios

This section explains key considerations and recommendations about Azure landing zones and Azure Active Directory multi-tenant scenarios and usage.

### Considerations

- Start with a [single tenant approach](overview.md#why-a-single-azure-active-directory-tenant-is-sufficient) to your Azure Active Directory tenant design.
  - The single tenant is typically the organization's corporate Azure Active Directory tenant, where the user's identities exist and a service, like Microsoft 365, is running.
  - Only create more Azure Active Directory tenants when there are requirements that can't be met by using the corporate Azure Active Directory tenant.
- Consider using Azure Active Directory [administrative units](/azure/active-directory/roles/administrative-units) to manage the segregation and isolation of users, groups, and devices (for example, different teams) within a single Azure Active Directory tenant. Use this resource instead of creating multiple Azure Active Directory tenants.
- Consider using sandbox subscriptions for the initial application workload development and investigation. For more information, see [How to handle "dev/test/production" workload landing zones in Azure landing zone architecture](https://aka.ms/alz/dtp).
- Migrating Azure subscriptions between Azure Active Directory tenants is complex and requires pre and post migration activities to be completed to enable a migration. For more information, see [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription). It's easier to rebuild the application workload in a new Azure subscription in the destination tenant. It gives you more control over the migration.
- Consider the [complexities](overview.md#complexities-with-multiple-azure-active-directory-tenants) of managing, governing, configuring, monitoring, and securing multiple Azure Active Directory tenants. A single Azure Active Directory tenant is easier to manage, govern, and secure.
- Consider your JML (joiners, movers, and leavers) process, workflows, and tooling. Ensure that these resources can support and handle multiple Azure Active Directory tenants.
- Consider the effect on end users when they manage, govern, and secure multiple identities for themselves.
- When choosing multiple Azure Active Directory tenants, consider the effect on cross-tenant collaboration, especially from an end user's perspective. The Microsoft 365 collaboration experience and support between users within a single Azure Active Directory tenant is optimal.
- Consider the effect on auditing and regulatory compliance checks across multiple Azure Active Directory tenants before choosing an approach.
- Consider the increase in licensing costs when multiple Azure Active Directory tenants are used. Licenses for products like Azure Active Directory Premium P1/P2 or Microsoft 365 services don't span across Azure Active Directory tenants.
- A single Enterprise Agreement enrollment can support and provide subscriptions to multiple Azure Active Directory tenants by setting the authentication level on the enrollment to work and school account cross-tenant. For more information, see [Azure EA portal administration](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant).
- A single Microsoft Customer Agreement can support and provide subscriptions to multiple Azure Active Directory tenants. For more information, see [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants).
- When opting for an Azure Active Directory multi-tenant architecture, consider the limitations that might occur for application teams and developers. Be aware of limitations in Azure Active Directory integration for Azure products and services, such as Azure Virtual Desktop, Azure Files, and Azure SQL. For more information, see the [Azure products and services Azure Active Directory integration](#azure-products--services-azure-active-directory-integration) section in this article.
- Consider using [Azure Active Directory B2B](/azure/active-directory/external-identities/what-is-b2b) to simplify and enhance user experience and administration when your organization has multiple Azure Active Directory tenants.
- Consider using the Microsoft identity platform, with Azure Active Directory with B2B and B2C capabilities, so developers can create applications in a single Azure subscription and within a single tenant. This method supports users from many identity sources. For more information, see [Multi-tenant apps](/azure/active-directory/develop/application-model#multi-tenant-apps) and [Architect multi-tenant solutions on Azure](/azure/architecture/guide/multitenant/overview).
- Consider using the features available for multi-tenant organizations. For more information, see [What is a multi-tenant organization in Azure Active Directory](/azure/active-directory/multi-tenant-organizations/overview).
- Consider [keeping your Azure landing zone up to date](/azure/cloud-adoption-framework/govern/resource-consistency/keep-azure-landing-zone-up-to-date).

#### Azure products and services Azure Active Directory integration

Many Azure products and services don't support Azure Active Directory B2B as part of their native Azure Active Directory integration. There are only a few services that support Azure Active Directory B2B authentication as part of their Azure Active Directory integrations. It's safer for the service default to not support Azure Active Directory B2B as part of their Azure Active Directory integration.

Services that provide a native integration with Azure Active Directory, such as Azure Storage, Azure SQL, Azure Files, and Azure Virtual Desktop, use a "one-click" or "no-click" style approach to integrate. They require [authentication and authorization](/azure/active-directory/develop/authentication-vs-authorization) scenarios as part of their service. This approach is typically supported against the “home tenant”, and some services might enable support for Azure Active Directory B2B/B2C scenarios. For more information about the Azure subscription's relationship to Azure Active Directory, see [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory).

It's important to carefully consider which Azure Active Directory tenant your Azure subscriptions are associated with. This relationship dictates which products and services, and their features, the application or workload teams use that need to support the identities and from which tenant the identities are from. Typically, identities are in the corporate Azure Active Directory tenant.

If multiple Azure Active Directory tenants are used to host all Azure subscriptions, application workload teams can't take advantage of some Azure products and services Azure Active Directory integrations. If the application workload teams have to develop their applications around these imposed limitations, the authentication and authorization process becomes more complex and less secure.

Avoid this problem by using a single Azure Active Directory tenant as the home for all your Azure subscriptions. A single tenant is the best approach for authentication and authorization for your application or service. This simple architecture gives the application workload team less to manage, govern, and control, and it removes potential constraints.

For more information, see [Resource isolation in a single tenant](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant).

### Recommendations

- Use a single Azure Active Directory tenant, which is usually the corporate Azure Active Directory tenant. Only create more Azure Active Directory tenants when there are requirements that can't be met by using the corporate Azure Active Directory tenant.
- Use sandbox subscriptions to provide application teams safe, controlled, and isolated development environments within the same single Azure Active Directory tenant. For more information, see [How to handle "dev/test/production" workload landing zones in Azure landing zone architecture](https://aka.ms/alz/dtp).
- Use Azure Active Directory multi-tenant applications when you create integrations from operational tooling, such as ServiceNow, and connect them to multiple Azure Active Directory tenants. For more information, see [Best practices for all isolation architectures](/azure/active-directory/fundamentals/secure-with-azure-ad-best-practices#operational-tools).
- If you're an ISV, see [Independent software vendor (ISV) considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone).
- Use Azure Lighthouse to simplify cross-tenant management experiences. For more information, see [Azure Lighthouse usage in Azure landing zones multi-tenant scenarios](lighthouse.md).
- On your Enterprise Agreement enrollments or Microsoft Customer Agreements that are homed in the destination Azure Active Directory tenant, create account owners, invoice section owners, and subscription creators. Assign the owners and creators to the subscriptions they create to avoid having to [change directories on Azure subscriptions](/azure/role-based-access-control/transfer-subscription) once created. For more information, see [Add an account from another Azure AD tenant](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant) and [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants).
- See the [Azure Active Directory security operations guide](/azure/active-directory/fundamentals/security-operations-introduction).
- Keep the number of Global Administrator accounts to a minimum, less than 5 is preferred.
- Enable [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) for all admin accounts to ensure no standing privilege and to provide JIT access.
- Require approval in PIM to activate critical roles, such as the Global Administrator role. Consider creating approvers from multiple teams to approve Global Administrator usage.
- Enable monitoring and notifications to all required stakeholders about the Global Administrator role activation.
- Ensure that the "Access management for Azure resources" setting on Global Administrators is set to **No** where it's not required.
- Enable and configure the following Azure Active Directory services and features to simplify the multi-tenant experience for administration and users within your organization:
  - [B2B collaboration](/azure/active-directory/external-identities/what-is-b2b)
  - [B2B direct connect](/azure/active-directory/external-identities/b2b-direct-connect-overview)
  - [Cross-tenant access settings](/azure/active-directory/external-identities/cross-tenant-access-overview)
  - [Cross-tenant synchronization (preview)](/azure/active-directory/multi-tenant-organizations/cross-tenant-synchronization-overview)
- For organizations with an Azure Active Directory tenant in multiple Microsoft clouds, like Microsoft Azure Commercial cloud, Microsoft Azure China 21Vianet, Microsoft Azure Government, configure [Microsoft cloud settings for B2B collaboration (preview)](/azure/active-directory/external-identities/cross-cloud-settings) to simplify user's experiences when collaborating across tenants.
- Application teams and developers should review the following resources when constructing applications and services for multi-tenancy:
  - [Multi-tenant apps in Azure Active Directory](/azure/active-directory/develop/application-model#multi-tenant-apps)
  - [Architect multi-tenant solutions on Azure](/azure/architecture/guide/multitenant/overview)

## Next steps

> [!div class="nextstepaction"]
> [Automate Azure landing zones across multiple tenants](automation.md)