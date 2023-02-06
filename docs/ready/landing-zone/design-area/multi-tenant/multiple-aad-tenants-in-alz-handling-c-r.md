---
title: Handling ALZ across Multiple Azure Active Directory tenants - Considerations & Recommendations
description: Review the considerations and recommendations when handling multiple Azure Active Directory tenants alongside Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Handling ALZ across Multiple Azure Active Directory tenants - Considerations & Recommendations

As per the outlined information, in this [article](multiple-aad-tenants-in-alz.md), on how Management Groups, Azure Policy and Subscriptions interact and operate with Azure Active Directory tenants and the limitation of these operating only within a single Azure Active Directory tenant, this means that if multiple Azure Active Directory tenants exist or are required for an organization then Azure landing zones must be deployed into each of the Azure Active Directory tenants separately.

## Topology of Azure landing zones with multiple Azure AD tenants

[![Diagram of multiple Azure Active Directory tenants with Azure Landing Zones deployed](media/alz-multi-tenant-2.png)](media/alz-multi-tenant-2.png#lightbox)

The above diagram shows an example of the Contoso Corporation, which has four Azure Active Directory tenants due to mergers and acquisitions as the corporation has grown over time.

| Azure Active Directory tenant `*.onmicrosoft.com` Domain | Usage Notes                                                                                                                                                                                        |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `contoso.onmicrosoft.com`                  | Primary Corporate Azure Active Directory tenant used by Contoso Corporation. Azure & Microsoft 365 services are used in this tenant.                                                                                |
| `fabrikam.onmicrosoft.com`                 | Primary Azure Active Directory tenant used by Fabrikam. Azure & Microsoft 365 services are used in this tenant. This has remained separated since Acquisition by Contoso Corporation.                                 |
| `tailwind.onmicrosoft.com`                 | Primary Azure Active Directory tenant used by Tailwind. Azure & Microsoft 365 services are used in this tenant. This has remained separated since Acquisition by Contoso Corporation.                                 |
| `contoso365test.onmicrosoft.com`           | Azure Active Directory tenant used by Contoso Corporation for testing Azure Active Directory & Microsoft 365 services and configuration **only**. All Azure environments live within the `contoso.onmicrosoft.com` Azure Active Directory tenant. |

The above diagram shows an example of the Contoso Corporation who originally started out with one Azure Active Directory tenant of `contoso.onmicrosoft.com`. However, over time they made multiple acquisitions of other companies and brought these companies into the Contoso Corporation.

These acquisitions of Fabrikam (`fabrikam.onmicrosoft.com`) and Tailwind (`tailwind.onmicrosoft.com`) brought with them existing Azure Active Directory tenants in which both Microsoft 365 (Exchange Online, SharePoint, OneDrive) and Azure services are used within. It was decided to keep these companies, and associated Azure Active Directory tenants, separated as there's a potential for parts of Contoso Corporation and its companies to be sold in the future.

Finally, the Contoso Corporation also has a separate Azure Active Directory tenant for the sole purpose of testing Azure Active Directory and Microsoft 365 services and features; however, no Azure services are tested in this separate Azure Active Directory tenant, they're instead tested in the `contoso.onmicrosoft.com` Azure Active Directory tenant.

>[!TIP]
> Please review the following guidance for handling testing of Azure landing zones and Azure workloads/resources within Azure landing zones environments:
>
> - [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture)
> - [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

>[!NOTE]
> Azure landing zones is deployed within a single Azure Active Directory tenant. This means if you have multiple Azure Active Directory tenants that you wish to deploy Azure resources within that you wish to control, govern and monitor using Azure landing zones, you must deploy Azure landing zones within each of those tenants individually.

## Considerations and Recommendations for Azure Landing Zones in multi-tenant Scenarios

This section details key considerations and recommendations relating to Azure landing zones and Azure Active Directory multi-tenant scenarios and usage.

### Considerations

- Always start with a [single tenant approach](multiple-aad-tenants-in-alz.md#why-a-single-azure-active-directory-tenant-is-sufficient) to your Azure Active Directory tenant design
  - This is typically the organizations corporate Azure Active Directory tenant, where the users identities exist and service like Microsoft 365 are running in.
  - Only create more Azure Active Directory tenants when clear requirements arise that can't be met using the corporate Azure Active Directory tenant.
- Consider utilizing Azure Active Directory [Administrative Units](/azure/active-directory/roles/administrative-units) to provide management segregation and isolation of users, groups, and devices (for example different teams) within a single Azure Active Directory tenant, instead of creating multiple Azure Active Directory tenants
- Consider the extra [complexities](multiple-aad-tenants-in-alz.md#complexities-with-multiple-azure-active-directory-tenants) in managing, governing, configuring, monitoring and securing multiple Azure Active Directory tenants
  - A single Azure Active Directory tenant is simpler to manage, govern and secure
- Consider your JML (Joiners, Movers, Leavers) process, workflows and tooling
  - Can these support and handle multiple Azure Active Directory tenants?
- Consider the impact to end-users having to manage, govern and secure multiple identities for themselves
- Consider the impact on cross-tenant collaboration, especially from an end-users perspective, before deciding on multiple Azure Active Directory tenants
  - The Microsoft 365 collaboration experience and support between users within a single Azure Active Directory tenant is optimal
- Consider the impact to auditing and regulatory compliance checks across multiple Azure Active Directory tenants before choosing an approach
- Consider the increase in licensing costs when multiple Azure Active Directory tenants are used
  - Licenses for products like Azure Active Directory Premium P1/P2 or Microsoft 365 services don't span across Azure Active Directory tenants
- A single Enterprise Agreement Enrollment can support and provide Subscriptions to multiple Azure Active Directory tenants by setting the Auth level on the enrollment to Work and School Account Cross tenant, see: [Azure EA portal administration](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant)
- A single Microsoft Customer Agreement can support and provide Subscriptions to multiple Azure Active Directory tenants, see: [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants)
- Consider the limitations that might be introduced and brought to the forefront for application teams and developers when opting for an Azure Active Directory multi-tenant architecture relating to limitations for Azure Active Directory Integration for Azure products and services, such as Azure Virtual Desktop, Azure Files, Azure SQL etc.
  - See [Azure Products & Services Azure Active Directory Integration section](#azure-products--services-aad-integration) detailing this topic further.

#### Azure Products & Services Azure Active Directory Integration

Today many, if not all Azure products & services don't support Azure Active Directory B2B as part of their native Azure Active Directory integration and there are only several services that support Azure Active Directory B2B authentication as part of their Azure Active Directory integrations. it's safer to that by default services don't support Azure Active Directory B2B as part of their Azure Active Directory integration.

To summarize the challenge, for services that provide a native integration with Azure Active Directory, such as Azure Storage, Azure SQL, Azure Files, Azure Virtual Desktop, they provide a "one-click", or "no-click", style approach to integrate with Azure Active Directory where they require [authentication and authorization](/azure/active-directory/develop/authentication-vs-authorization) scenarios as part of their service or offering. However, this is commonly only supported against the “home tenant” (the Azure Subscription relationship to Azure Active Directory is detailed further [here](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)), while only some services might enable support for Azure Active Directory B2B/B2C scenarios.

Taking the above into consideration it's important to carefully consider to which Azure Active Directory tenant your Azure Subscriptions will be associated to, as this will dictate as to which products/services, and their features, are able to be used by application/workload teams that need to support the identities and from which tenant; normally identities in the corporate Azure Active Directory tenant.

If multiple Azure Active Directory tenants were used to host all Azure Subscriptions, then this could hinder and limit the application workload teams from being able to take advantage of some Azure products and services Azure Active Directory integrations. Leaving the application workload teams to have to develop their applications around these imposed limitations that could lead to a more complex and less secure authentication and authorization posture.

This can be avoided if you utilize a single Azure Active Directory tenant as the home for all your Azure Subscriptions. This then enables application workload teams to take advantage of the best approach for authentication and authorization for their application/service without having any constraints imposed on them by an architecture choice that they can't control whilst also keeping a simple architecture to manage, govern and control.

>[!TIP]
> Review this documentation [Resource isolation in a single tenant to secure with Azure Active Directory](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant)

### Recommendations

- Use a single Azure Active Directory tenant, usually the corporate Azure Active Directory tenant and only create more Azure Active Directory tenants when clear and justified requirements arise that can't be met using the corporate Azure Active Directory tenant.
- Use Azure Active Directory multi-tenant applications, were possible, when creating integrations from operational tooling, such as ServiceNow, when connecting them to multiple Azure Active Directory tenants, as per the [guidance here](/azure/active-directory/fundamentals/secure-with-azure-ad-best-practices#operational-tools)
- If you're an ISV review this specific guidance [Independent software vendor (ISV) considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone)
- Utilize Azure Lighthouse were possible, to simplify cross-tenant management experiences. [See Azure Lighthouse usage in ALZ multi-tenant](multiple-aad-tenants-in-alz-handling-lighthouse.md)
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

## Next steps

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple Azure Active Directory Tenants - Automation Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-automation.md)