---
title: Handling ALZ across Multiple AAD Tenants - Considerations & Recommendations
description: Review the considerations and recommendations when handling multiple Azure AD Tenants alongside Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Handling ALZ across Multiple AAD Tenants - Considerations & Recommendations

As per the outlined information, in this [article](multiple-aad-tenants-in-alz.md), on how Management Groups, Azure Policy and Subscriptions interact and operate with Azure AD Tenants and the limitation of these operating only within a single Azure AD Tenant, this means that if multiple Azure AD Tenants exist or are required for an organization then Azure landing zones must be deployed into each of the Azure AD Tenants separately. As shown in the diagram below.

[![Diagram of multiple Azure AD Tenants with Azure Landing Zones deployed](media/alz-multi-tenant-2.png)](media/alz-multi-tenant-2.png#lightbox)

The above diagram shows an example of the Contoso Corporation which has 4 Azure AD Tenants due to mergers and acquisitions as the corporation has grown over time.

| ID  | Azure AD Tenant `*.onmicrosoft.com` Domain | Usage Notes                                                                                                         |
| --- | ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- |
| 1   | `contoso.onmicrosoft.com`                  | Primary “Corporate” AAD Tenant used by Contoso Corporation. Azure & Microsoft 365 services are used in this Tenant. |
| 2 | `fabrikam.onmicrosoft.com` | Primary AAD Tenant used by Fabrikam. Azure & Microsoft 365 services are used in this Tenant. This has remained separated since Acquisition by Contoso Corporation. |
| 3 | `tailwind.onmicrosoft.com` | Primary AAD Tenant used by Tailwind. Azure & Microsoft 365 services are used in this Tenant. This has remained separated since Acquisition by Contoso Corporation. |
| 4 | `contoso365test.onmicrosoft.com` | AAD Tenant used by Contoso Corporation for testing Azure AD & Microsoft 365 services and configuration **only**. All Azure environments live within the `contoso.onmicrosoft.com` Azure AD Tenant. |

The above diagram shows an example of the Contoso Corporation who originally started out with 1 Azure AD Tenant of `contoso.onmicrosoft.com` (ID 1 in the table above). However, over time they made multiple acquisitions of other companies and brought these into the Contoso Corporation. 

These acquisitions of Fabrikam (`fabrikam.onmicrosoft.com`) and Tailwind (`tailwind.onmicrosoft.com`) brought with them existing Azure AD Tenants in which both Microsoft 365 (Exchange Online, SharePoint, OneDrive) and Azure services are used within. It was decided to keep these companies, and associated Azure AD Tenants, separated as there is a potential for parts of Contoso Corporation and its companies to be sold in the future as part of other merger and acquisition activity.

Finally, the Contoso Corporation also has a separate Azure AD Tenant for the sole purpose of testing Azure AD and Microsoft 365 services and features; however, no Azure services are tested in this separate Azure AD Tenant, they are instead tested in the `contoso.onmicrosoft.com` Azure AD Tenant.

>[!TIP]
> Please review the guidance below for handling testing of Azure landing zones and Azure workloads/resources within Azure landing zones environments:
>
> - [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture)
> - [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

>[!NOTE]
> Azure landing zones is deployed within a single Azure AD Tenant. This means if you have multiple Azure AD Tenants that you wish to deploy Azure resources within that you wish to control, govern and monitor using Azure landing zones, you must deploy Azure landing zones within each of those tenants individually.

## Considerations and Recommendations for Azure Landing Zones in Multi-Tenant Scenarios

This section details key considerations and recommendations relating to Azure landing zones and Azure AD multi-tenant scenarios and usage.

### Considerations

- Always start with a ["why not one?" approach](multiple-aad-tenants-in-alz.md#why-not-one) to your Azure AD Tenant design
  - This is typically the organizations corporate Azure AD Tenant, where the users identities exist and service like Microsoft 365 are running in.
  - Only create additional Azure AD Tenants when clear requirements arise that cannot be met using the corporate Azure AD Tenant.
- Consider utilizing Azure AD [Administrative Units](/azure/active-directory/roles/administrative-units) to provide management segregation and isolation of users and groups (for example different teams) within a single Azure AD Tenant, instead of creating multiple Azure AD Tenants
- Consider the additional complexities in managing, governing, configuring, monitoring and securing multiple Azure AD Tenants
  - A single Azure AD Tenant is simpler to manage, govern and secure
- Consider your JML (Joiners, Movers, Leavers) process, workflows and tooling
  - Can these support and handle multiple Azure AD Tenants?
- Consider the impact to end-users having to manage, govern and secure multiple identities for themselves
- Consider the impact on cross-tenant collaboration, especially from an end-users perspective, before deciding on multiple Azure AD Tenants
  - The collaboration experience and support between users inside a single Azure AD Tenant is best
- Consider the impact to auditing and regulatory compliance checks across multiple Azure AD Tenants before choosing an approach
- Consider the increase in licensing costs when multiple Azure AD Tenants are used
  - Licenses for products like Azure AD Premium P1/P2 or Microsoft 365 services do not span across Azure AD Tenants
- A single Enterprise Agreement Enrolment can support and provide Subscriptions to multiple Azure AD Tenants by setting the Auth level on the enrolment to Work and School Account Cross Tenant, see: [Azure EA portal administration](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant)
- A single Microsoft Customer Agreement can support and provide Subscriptions to multiple Azure AD Tenants, see: [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants)
- Consider the limitations that might be introduced and brought to the forefront for application teams and developers when opting for an Azure AD Multi-Tenant architecture in regards to limitations for Azure AD Integration for Azure products and services, such as Azure Virtual Desktop, Azure Files, Azure SQL etc.
  - See below [section](#azure-products--services-aad-integration) detailing this topic further.

#### Azure Products & Services AAD Integration

Today many, if not all Azure products & services do not support Azure AD B2B as part of their native AAD integration and there are only several services that support AAD B2B authentication as part of their AAD integrations. It is safer to that by default services do not support Azure AD B2B as part of their Azure AD integration.

To summarize the challenge, for services that provide a native integration with Azure AD, such as Azure Storage, Azure SQL, Azure Files, Azure Virtual Desktop, etc. they provide a “one-click”, or "no-click", style approach to integrate with AAD where they require [AuthN/AuthZ](/azure/active-directory/develop/authentication-vs-authorization) scenarios as part of their service or offering. However, this is commonly only supported against the “home tenant” (the Azure Subscription relationship to AAD is detailed further [here](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)) from day 1 and then over time, some might enable support for AAD B2B/B2C scenarios.

Taking the above into consideration it is important to carefully consider to which Azure AD Tenant your Azure Subscriptions will be associated to, as this will dictate as to which products/services and their features are able to be used by application/workload teams that need to support the identities and from which tenant; normally identities in the corporate Azure AD Tenant.

If multiple Azure AD Tenants where used to host all Azure Subscriptions then this could hinder and limit the application workload teams from being able to take advantage of some Azure products and services Azure AD integrations. Leaving the application workload teams to have to develop their applications around these imposed limitations which could lead to a more complex and less secure AuthN/AuthZ posture.

This can be avoided if you utilize a Single Azure AD Tenant as the home for all your Azure Subscriptions. This then enables application workload teams to take advantage of the best approach for AuthN/AuthZ for their application/service without having any constraints imposed on them by an architecture choice that they cannot control whilst also keeping a simple architecture to manage, govern and control.

>![TIP]
> Review this documentation [Resource isolation in a single tenant to secure with Azure Active Directory](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant)

### Recommendations

- Use a single Azure AD Tenant, usually the corporate Azure AD Tenant and Only create additional Azure AD Tenants when clear requirements arise that cannot be met using the corporate Azure AD Tenant.
- Use Azure AD multi-tenant applications, where possible, when creating integrations from operational tooling, such as ServiceNow, when connecting them to multiple Azure AD tenants, as per the [guidance here](/azure/active-directory/fundamentals/secure-with-azure-ad-best-practices#operational-tools)
- If you are an ISV review this specific guidance [Independent software vendor (ISV) considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone)
- Utilize Azure Lighthouse where possible, to simplify cross-tenant management experiences. [See below]()
- Create Account Owners, Invoice Section Owners, Subscription Creators on your Enterprise Agreement Enrolments or Microsoft Customer Agreements that are homed in the destination Azure AD Tenant for the Subscriptions they will create to avoid having to [Change Directories on Azure Subscriptions](/azure/role-based-access-control/transfer-subscription) once created.
  - [Azure EA portal administration](/azure/cost-management-billing/manage/ea-portal-administration#add-an-account-from-another-azure-ad-tenant)
  - [Manage tenants in your Microsoft Customer Agreement billing account](/azure/cost-management-billing/microsoft-customer-agreement/manage-tenants)
- Review the [Azure Active Directory security operations guide](/azure/active-directory/fundamentals/security-operations-introduction)
- Keep the number of Global Administrator Accounts to a minimum (ideally <5).
- Enable [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) for all Admin accounts to ensure no standing privilege and provide JIT access.
- Require approval in PIM to activate critical roles such as the Global Administrator Role.
  - Consider making approvers from multiple teams approve Global Administrator usage.
- Enable monitoring/notifications on Global Administrator role activation to all required stakeholders.
- Ensure that the "Access management for Azure resources" setting on Global Administrators is set to `No` where it is not required.

## Next steps

> [!div class="nextstepaction"]
> [TBC](TBC.md)