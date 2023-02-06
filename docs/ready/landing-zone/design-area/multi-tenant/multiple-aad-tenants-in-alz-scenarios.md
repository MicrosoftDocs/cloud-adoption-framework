---
title: Multiple Azure Active Directory tenants in ALZ - Scenarios
description: Understand the scenarios when Multiple Azure Active Directory tenants could be required in relation to Azure Landing Zones
author: jtracey93
ms.author: jatracey
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Multiple Azure Active Directory tenants in ALZ - Scenarios

There are a few reasons that an organization might justify multiple Azure Active Directory tenants or investigate whether they need multiple Azure Active Directory tenants. The most common scenarios are:

- [Mergers and Acquisitions](#mergers-and-acquisitions)
- [Regulatory or Country Compliance Requirements](#regulatory-or-country-compliance-requirements)
- [Business Unit or Organizational Isolation and Autonomy Requirements](#business-unit-or-organizational-isolation-and-autonomy-requirements)
- [Independent Software Vendor (ISV) Delivering SaaS Applications from Azure](#independent-software-vendor-isv-delivering-saas-applications-from-azure)
- [Tenant Level Testing / Microsoft 365 Testing](#tenant-level-testing--microsoft-365-testing)
- [Grass Roots / Shadow IT / Start-ups](#grass-roots--shadow-it--start-ups)

## Mergers and Acquisitions

As organizations grow over time, it's common that they might acquire other companies or organizations as they expand. These acquisitions are highly likely to have existing Azure Active Directory tenants already established hosting and providing services to the company or organization like, Microsoft 365 (Exchange Online, SharePoint, OneDrive, Teams, etc.), Dynamics 365 and Microsoft Azure.

Usually as part of the acquisition there is a project to consolidate the two Azure Active Directory tenants into a single Azure Active Directory tenant to reduce the management overhead and also improve the collaboration experiences as well as presenting a single brand identity to other companies and organizations.

>[!IMPORTANT]
> A custom domain name (for example, `contoso.com`) can only be associated to one Azure Active Directory tenant at a time. Hence a common goal to consolidate tenants so that a single custom domain name can be used by all identities when a merger or acquisition scenario has occurred.

However, due to the complexities of such a consolidation of two Azure Active Directory tenants into one, sometimes the tenants are left alone and remain separate for an extended or indefinite period of time.

This scenario can also occur when the organizations or companies wish to remain separate as individual entities so that they might be acquired again in the future by other organizations. Therefore, by keeping the Azure Active Directory tenants isolated and not performing a consolidation of them, there's less work to perform in the event of a future merger or acquisition of a single entity.

## Regulatory or Country Compliance Requirements

Some organizations are in scope of strict regulatory or country compliance controls and frameworks (for example UK Official, Sarbanes Oxley (SOX) or NIST) that leads to organizations creating multiple Azure Active Directory tenants to meet and comply with these frameworks.

Another similar scenario is when an organization has offices and users around the globe, some of which fall into stricter data residency regulations. Although this particular requirement is usually addressed within a single Azure Active Directory tenant utilizing features such as [Microsoft 365 Multi-Geo](/microsoft-365/enterprise/microsoft-365-multi-geo).

Furthermore, an additional scenario for this is when organizations require the use of [Azure Government (US Government)](/azure/azure-government/documentation-government-welcome) or [Azure China (operated by 21Vianet)](/azure/china/overview-operations). These national Azure cloud instances require their own Azure Active Directory tenants. These Azure Active Directory tenants are solely for that national Azure cloud instances and are used for the Azure Subscriptions identity and access management services within that Azure cloud instance.

>[!TIP]
> More information on Azure national cloud’s identity scenarios can be found below:
>
> - [Azure Government Identity](/azure/azure-government/documentation-government-plan-identity#identity-scenarios-for-subscription-administration-in-azure-government)
> - [Azure China Cross-border connectivity and interoperability](/azure/china/overview-connectivity-and-interoperability)
> - [Azure Active Directory authentication & national clouds](/azure/active-directory/develop/authentication-national-cloud)

However, for the above scenarios it's not to say that if your organization has a regulatory or country compliance framework to comply with that you require multiple Azure Active Directory tenants as the default approach. Most organizations in this scenario can comply with the frameworks within a single Azure Active Directory tenant by utilizing features such as [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) and [Administrative Units](/azure/active-directory/roles/administrative-units).

## Business Unit or Organizational Isolation and Autonomy Requirements

Some organizations might have complex internal structures across multiple business units or might require a high level of isolation and autonomy between differing parts of their organization.

When this scenario occurs and it's deemed that the tools and guidance provided in [Resource isolation in a single tenant](/azure/active-directory/fundamentals/secure-with-azure-ad-single-tenant) can't provide the level of isolation that is required you might then have to deploy, manage and operate multiple Azure Active Directory tenants.

However, it's more common in scenarios like this, that there are no centralized functions that are responsible for deploying, managing, and operating these multiple tenants and instead they're handed over, in full, to the separated business unit or part of the organization to run and manage. Whilst potentially, a centralized architecture, strategy or CCoE style team might still provide guidance and recommendations on best practices that must be configured within the separate Azure Active Directory tenant.

>[!WARNING]
> Organizations that have operational roles and responsibilities challenges between different teams that operate the organizations Azure Active Directory tenant and Azure should prioritize creating and agreeing upon a clear RACI between the two teams. This ensures that both teams can work and deliver their services to the organization and provide value back to the business in a timely manner.
> 
> In organizations where the cloud infrastructure and development teams using Azure have a reliance on an identity team that have control over the corporate Azure Active Directory tenant for the organization, for things like Service Principal creation or Group creation and management, and do not have an agreed RACI between these teams often show a lack of process and understanding between them, which ultimately leads to friction between the teams and across the organization. This sometimes leads to the belief that multiple Azure Active Directory tenants is the only way to overcome this challenge.
> 
> However, this creates challenges for end-users, increases complexity in securing, managing, and governing multiple tenants, and potentially increases licensing costs for the organizations as licences such as Azure Active Directory Premium do not span multiple Azure Active Directory tenants.
> 
> We encourage organizations in this situation to resolve the operational challenges to ensure teams can work together in a single Azure Active Directory tenant rather than creating multiple Azure Active Directory tenants as a workaround.

## Independent Software Vendor (ISV) Delivering SaaS Applications from Azure

ISVs delivering their SaaS (Software as a Service) products to their customers, might benefit from having multiple Azure Active Directory tenants for their Azure usage. 

Having separation between the ISVs corporate Azure Active Directory tenant, including Azure usage, for their business-as-usual activities such as e-mail, file sharing, internal applications etc. and a separate Azure Active Directory tenant where the Azure Subscriptions are for hosting and delivering the SaaS applications the ISV provides to their end customers is a very common and sensible approach to protecting both themselves and their customers from security incidents etc.

This is already detailed in the Azure landing zones guidance here in: [Independent software vendor (ISV) considerations for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/isv-landing-zone).

## Tenant Level Testing / Microsoft 365 Testing

There are some activities and features within the Microsoft Cloud products, services and offerings that dictate the only way to test them is in a separate Azure Active Directory tenant. Some examples of this are:

- Microsoft 365 – Exchange Online, SharePoint, Teams
- Azure Active Directory – Azure Active Directory Connect, Azure Active Directory Identity Protection Risk Levels, SaaS applications.
- Testing scripts that utilize the Microsoft Graph API and could impact and make changes to production.

When you're wanting to perform testing that matches or is similar to the scenarios above a separate Azure Active Directory tenant is your only option and therefore this is recommended.

However, this separate Azure Active Directory tenant is **not** for hosting any Azure Subscriptions that contain any workloads; regardless of environment, for example dev/test. To be clear, even dev/test environments should instead be contained in your regular “production” Azure Active Directory tenant.

>[!TIP]
> Please review the guidance below for handling testing of Azure landing zones and Azure workloads/resources within Azure landing zones environments:
>
> - [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture)
> - [Testing approach for Azure landing zones](/azure/cloud-adoption-framework/ready/enterprise-scale/testing-approach)

## Grass Roots / Shadow IT / Start-ups

In some organizations there might be teams that are looking to innovate quickly that might lead to this team creating a separate Azure Active Directory tenant to help them move as quickly as possible whilst, intentionally or unintentionally, avoiding central/platform team's process and guidance for getting access to an Azure environment to be able to do their innovation.

This is also common where start-ups are created and they setup their own Azure Active Directory tenant to run, host and operate the business and services from. Normally this is to be expected however, when start-ups are acquired the additional Azure Active Directory tenant creates a decision point for the acquiring organizations IT teams to decide what to do going forward.

For more information review the [Mergers and Acquisitions](#mergers-and-acquisitions) and [Independent Software Vendor (ISV) Delivering SaaS Applications from Azure](#independent-software-vendor-isv-delivering-saas-applications-from-azure) sections on this page to help your organization decide on what to do if you are faced with this scenario.

>[!IMPORTANT]
> We highly encourage platform teams to have an easily accessible and efficient process for giving teams access to an Azure Sandbox Subscription/s that are homed within the corporate/primary Azure Active Directory tenant for the organization to help shadow IT scenarios from occurring and creating challenges in the future for all parties involved.
>
> Review the [Management groups guidance within the Resource organization design area](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) for more information on Sandboxes.

## Summary

As detailed in the scenarios there are multiple reasons that might lead your organization to require multiple Azure Active Directory Tenants. However, when creating multiple tenants to meet the requirements within these scenarios it's important to understand that the additional complexity and operational tasks that will be required to maintain multiple tenants across an organization as well as the potentially increased costs from additional licensing requirements. For more information, [Considerations and Recommendations for Azure Landing Zones in multi-tenant Scenarios](multiple-aad-tenants-in-alz-handling-c-r.md) for more information.

## Next steps

> [!div class="nextstepaction"]
> [Handling ALZ across Multiple Azure Active Directory tenants - Considerations & Recommendations](multiple-aad-tenants-in-alz-handling-c-r.md)
