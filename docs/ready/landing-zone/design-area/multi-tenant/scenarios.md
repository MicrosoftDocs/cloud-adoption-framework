---
title: Scenarios for multiple Microsoft Entra tenants
description: Learn about the scenarios for multiple Microsoft Entra tenants, and learn when they're required in Azure landing zones.
author: jtracey93
ms.author: jatracey
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: think-tank
---

# Scenarios for multiple Microsoft Entra tenants

There are a few reasons why an organization might need, or might want to investigate, multiple Microsoft Entra tenants. The most common scenarios are:

- [Mergers and acquisitions](#mergers-and-acquisitions)
- [Regulatory or country/region compliance requirements](#regulatory-or-countryregion-compliance-requirements)
- [Business unit or organizational isolation and autonomy requirements](#business-unit-or-organizational-isolation-and-autonomy-requirements)
- [Independent software vendor (ISV) delivering SaaS applications from Azure](#independent-software-vendor-isv-delivering-saas-applications-from-azure)
- [Tenant level testing / Microsoft 365 testing](#tenant-level-testing--microsoft-365-testing)
- [Grassroots / Shadow IT / start-ups](#grassroots--shadow-it--start-ups)

## Mergers and acquisitions

As organizations grow over time, they might acquire other companies or organizations. These acquisitions are likely to have existing Microsoft Entra tenants already established that host and provide services, such as Microsoft 365 (Exchange Online, SharePoint, OneDrive, or Teams), Dynamics 365, and Microsoft Azure, to the company or organization.

Typically, in an acquisition, the two Microsoft Entra tenants are consolidated into a single Microsoft Entra tenant. This consolidation reduces the management overhead, improves the collaboration experience, and presents a single brand identity to other companies and organizations.

>[!IMPORTANT]
> A custom domain name (for example, `contoso.com`) can only be associated with one Microsoft Entra tenant at a time. So, consolidating tenants is preferred because a single custom domain name can be used by all identities when a merger or acquisition scenario occurs.

Because of the complexities of consolidating two Microsoft Entra tenants into one, sometimes the tenants are left alone and remain separate for an extended or indefinite period of time.

This scenario can also occur when the organizations or companies want to remain separate because other organizations might acquire their company in the future. If an organization keeps the Microsoft Entra tenants isolated and they don't consolidate them, there's less work if there's a future merger or acquisition of a single entity.

## Regulatory or country/region compliance requirements

Some organizations have strict regulatory or country/region compliance controls and frameworks (for example, UK Official, Sarbanes Oxley (SOX), or NIST). Organizations might create multiple Microsoft Entra tenants to meet and comply with these frameworks.

Some organizations that have offices and users around the globe with stricter data residency regulations might also create multiple Microsoft Entra tenants. But this particular requirement is usually addressed within a single Microsoft Entra tenant using features, such as [Microsoft 365 Multi-Geo](/microsoft-365/enterprise/microsoft-365-multi-geo).

Another scenario is when organizations require [Azure Government (US Government)](/azure/azure-government/documentation-government-welcome) or [Azure China (operated by 21Vianet)](/azure/china/overview-operations). These national Azure cloud instances require their own Microsoft Entra tenants. The Microsoft Entra tenants are solely for that national Azure cloud instance and are used for the Azure subscriptions identity and access management services within that Azure cloud instance.

>[!TIP]
> For more information about Azure national/regional cloud’s identity scenarios, see:
>
> - [Azure Government Identity](/azure/azure-government/documentation-government-plan-identity#identity-scenarios-for-subscription-administration-in-azure-government)
> - [Azure China Cross-border connectivity and interoperability](/azure/china/overview-connectivity-and-interoperability)
> - [Microsoft Entra authentication & national/regional clouds](/entra/identity-platform/authentication-national-cloud)

Like in the previous scenarios, if your organization has a regulatory or country/region compliance framework to comply with, you might not require multiple Microsoft Entra tenants as the default approach. Most organizations can comply with the frameworks within a single Microsoft Entra tenant by using features, such as [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) and [Administrative units](/entra/identity/role-based-access-control/administrative-units).

## Business unit or organizational isolation and autonomy requirements

Some organizations might have complex internal structures across multiple business units, or they might require a high level of isolation and autonomy between parts of their organization.

When this scenario occurs, and the tools and guidance in [Resource isolation in a single tenant](/entra/architecture/secure-single-tenant) can't provide the required level of isolation, you might have to deploy, manage, and operate multiple Microsoft Entra tenants.

In scenarios like this, it’s more common that there are no centralized functions that are responsible for deploying, managing, and operating these multiple tenants. Instead, they're handed over in full to the separated business unit or part of the organization to run and manage. A centralized architecture, strategy, or CCoE style team might still provide guidance and recommendations on best practices that must be configured in the separate Microsoft Entra tenant.

>[!WARNING]
> Organizations that have operational roles and responsibilities creates challenges between teams that operate the organization’s Microsoft Entra tenant. Azure should prioritize creating and agreeing upon a clear RACI between the two teams. This action ensures that both teams can work and deliver their services to the organization and provide value back to the business in a timely manner.
> 
> Some organizations have cloud infrastructure and development teams that use Azure. The organizations rely on an identity team that has control over the corporate Microsoft Entra tenant for service principal creation or group creation and management. If there isn’t an agreed RACI, there’s often a lack of process and understanding between the teams, which leads to friction between the teams and across the organization. Some organizations believe that multiple Microsoft Entra tenants is the only way to overcome this challenge.
> 
> But multiple Microsoft Entra tenants creates challenges for end users, increases complexity in securing, managing, and governing multiple tenants, and potentially increases licensing costs. Licenses, such as Microsoft Entra ID P1 or P2, don't span multiple Microsoft Entra tenants. Sometimes, [Microsoft Entra B2B](/entra/external-id/what-is-b2b) usage can alleviate licensing duplication for some features and services. If you plan to use Microsoft Entra B2B in your deployment, review each feature and service's licensing terms and supportability for Microsoft Entra B2B eligibility.
> 
> Organizations in this situation should resolve the operational challenges to ensure that teams can work together in a single Microsoft Entra tenant rather than create multiple Microsoft Entra tenants as a workaround.

## Independent software vendor (ISV) delivering SaaS applications from Azure

ISVs that deliver their SaaS (software as a service) products to their customers might benefit from having multiple Microsoft Entra tenants for their Azure usage. 

If you’re an ISV, you might have separation between your corporate Microsoft Entra tenant, including Azure usage, for your business-as-usual activities, such as e-mail, file sharing, and internal applications. You might also have a separate Microsoft Entra tenant where Azure subscriptions host and deliver the SaaS applications that you provide to your end customers. This approach is common and sensible because it protects you and your customers from security incidents.

For more information, see [Independent software vendor (ISV) considerations for Azure landing zones](../../isv-landing-zone.md).

## Tenant level testing / Microsoft 365 testing

Some activities and features in the Microsoft Cloud products, services, and offerings can only be tested in a separate Microsoft Entra tenant. Some examples are:

- Microsoft 365 – Exchange Online, SharePoint, and Teams
- Microsoft Entra ID – Microsoft Entra Connect, Microsoft Entra ID Protection Risk Levels, and SaaS applications
- Testing scripts that use the Microsoft Graph API and can effect and make changes to production

When you want to perform testing like the previous scenarios, a separate Microsoft Entra tenant is your only option.

But the separate Microsoft Entra tenant is **not** for hosting Azure subscriptions that contain workloads, regardless of the environment, for example dev/test. Even dev/test environments should instead be contained in your regular "production” Microsoft Entra tenant.

>[!TIP]
> For information about how to handle testing Azure landing zones and Azure workloads or resources within Azure landing zones environments, see:
>
> - [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?](../../../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture)
> - [Testing approach for Azure landing zones](../../../enterprise-scale/testing-approach.md)

## Grassroots / Shadow IT / Start-ups

If a team wants to innovate quickly, they might create a separate Microsoft Entra tenant to help them move as quickly as possible. They might, intentionally or unintentionally, avoid the central/platform team's process and guidance for getting access to an Azure environment to do their innovation.

This scenario is common in start-ups where they set up their own Microsoft Entra tenant to run, host, and operate the business and services from. It's typically to be expected, but when start-ups are acquired, the extra Microsoft Entra tenant creates a decision point where the acquiring organization’s IT teams decide what to do going forward.

For more information about how to navigate this scenario, see the [Mergers and acquisitions](#mergers-and-acquisitions) and [Independent software vendor (ISV) delivering SaaS applications from Azure](#independent-software-vendor-isv-delivering-saas-applications-from-azure) sections in this article.

>[!IMPORTANT]
> We highly recommend platform teams have an easily accessible and efficient process to give teams access to an Azure sandbox subscription or subscriptions that are homed in the corporate or primary Microsoft Entra tenant for the organization. This process prevents Shadow IT scenarios from occurring and prevents challenges in the future for all parties involved.
>
> For more information about sandboxes, see [Management groups guidance within the resource organization design area](../resource-org-management-groups.md).

## Summary

As detailed in the scenarios, there are several reasons why your organization might require multiple Microsoft Entra tenants. But when you create multiple tenants to meet the requirements within these scenarios, it adds complexity and operational tasks to maintain the multiple tenants and potentially adds costs for licensing requirements. For more information, see [Considerations and recommendations for Azure landing zones in multitenant scenarios](considerations-recommendations.md).

## Next steps

> [!div class="nextstepaction"]
> [Considerations and recommendations for multitenant Azure landing zone scenarios](considerations-recommendations.md)
