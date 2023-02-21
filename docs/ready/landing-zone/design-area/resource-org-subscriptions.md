---
title: Subscription considerations and recommendations
description: Learn about the critical role that subscriptions play as units of management, billing, and scale in Azure.
author: martinekuan
ms.author: martinek
ms.date: 6/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Subscription considerations and recommendations

Subscriptions are a unit of management, billing, and scale within Azure. They play a critical role when you're designing for large-scale Azure adoption. This article can help you capture subscription requirements and design target subscriptions based on critical factors, which are based on:

- environment type
- ownership and governance model
- organizational structure
- application portfolios

> [!TIP]
> We discussed this topic in a recent YouTube video: [Azure Landing Zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

>[!NOTE]
>  You should review the subscription limits as documented in [Billing accounts and scopes in the Azure portal](/azure/cost-management-billing/manage/view-all-accounts). This guidance is primarily aimed at customers using Enterprise Agreements, Microsoft Customer Agreements (Enterprise) or Microsoft Partner Agreements (CSP).

## Subscriptions considerations

The following sections contain considerations to help you plan and create subscriptions for Azure.

### Organization and governance design considerations

- Subscriptions serve as boundaries for Azure Policy assignments.

  - For example, secure workloads like Payment Card Industry (PCI) workloads typically require other policies in order to achieve compliance. Instead of using a management group to collate workloads that require PCI compliance, you can achieve the same isolation with a subscription, without having too many management groups with a few subscriptions.

    - If you need to group together many subscriptions of the same workload archetype, create them under a management group.

- Subscriptions serve as a scale unit so component workloads can scale within platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Make sure you consider subscription resource limits as you design your workloads.

- Subscriptions provide a management boundary for governance and isolation that clearly separates concerns.

- Create separate platform subscriptions for management (monitoring), connectivity, and identity when they're required.
    - Establish a dedicated management subscription in your platform management group to support global management capabilities like Azure Monitor Log Analytics workspaces and Azure Automation runbooks.
      - Establish a dedicated identity subscription in your platform management group to host Windows Server Active Directory domain controllers when needed.
      - Establish a dedicated connectivity subscription in your platform management group to host an Azure Virtual WAN hub, private Domain Name System (DNS), ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all your foundation network resources are billed together and isolated from other workloads.
      - Use subscriptions as a democratized unit of management aligned with your business needs and priorities.

- Use manual processes to limit Azure AD tenants to only Enterprise Agreement enrollment subscriptions. Using a manual process prevents the creation of Microsoft Developer Network subscriptions at the root management group scope.
  - For support, submit an [Azure Support ticket](https://azure.microsoft.com/support/create-ticket/).

- See the [Azure subscription and reservation transfer hub](/azure/cost-management-billing/manage/subscription-transfer) for subscription transfers between Azure billing offers.

### Quota and capacity design considerations

Azure regions might have a finite number of resources. As a result, available capacity and SKUs should be tracked for Azure adoptions involving a large number of resources.

- Consider [limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) within the Azure platform for each service your workloads require.

- Consider the availability of required SKUs within your chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources like VMs can be different from one region to another.

- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

  - For virtual machine capacity reservations, see [On-demand capacity reservation](/azure/virtual-machines/capacity-reservation-overview).

- Consider re-using unused or decommissioned subscriptions as per the guidance in [Should we create a new Azure Subscription every time or can we, and should we, re-use Azure Subscriptions? - Azure landing zones FAQ](../../enterprise-scale/faq.md#should-we-create-a-new-azure-subscription-every-time-or-can-we-and-should-we-re-use-azure-subscriptions)

### Tenant transfer restriction design considerations

Each Azure subscription is linked to a single Azure AD tenant, which acts as an identity provider (IdP) for your Azure subscription. The Azure AD tenant is used to authenticate users, services, and devices.

The Azure AD tenant linked to your Azure subscription can be changed by any user with the required permissions. This process is detailed in the following articles:

- [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)
- [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription)

> [!NOTE]
> Transferring to another Azure AD tenant is not supported for Azure Cloud Solution Provider (CSP) subscriptions.

With Azure landing zones, you can set requirements to prevent users from transferring subscriptions to your organization's Azure AD tenant. Review the process in [Manage Azure subscription policies](/azure/cost-management-billing/manage/manage-azure-subscription-policy).

Configure your subscription policy by providing a list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users). Exempted users are permitted to bypass restrictions set in the policy.

> [!IMPORTANT]
> An exempted users list is not an [Azure Policy](/azure/governance/policy/overview).

- Consider whether users with [Visual Studio/MSDN Azure subscriptions](https://azure.microsoft.com/pricing/member-offers/credit-for-visual-studio-subscribers/) should be allowed to transfer their subscription to or from your Azure AD tenant.

- Tenant transfer settings are only configurable by users with the Azure AD [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) role assigned. These users and must have [elevated access](/azure/role-based-access-control/elevate-access-global-admin) to change the policy.

  - You can only specify individual user accounts as [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users), not Azure AD groups.

- All users with access to Azure can view the policy defined for your Azure AD tenant.

  - Users can't view your [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users) list.

  - Users can view the global administrators within your Azure AD tenant.

- Azure subscriptions transferred into an Azure AD tenant are placed into the [default management group](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group) for that tenant.

- If approved by your organization, your application team can define a process to allow Azure subscriptions to be transferred to or from an Azure AD tenant.

### Establish cost management design considerations

Cost transparency is a critical management challenge every large enterprise organization faces. This section of the article explores key aspects of achieving cost transparency across large Azure environments.

- Chargeback models, like Azure App Service Environment and Azure Kubernetes Service, might need to be shared to achieve higher density. Shared platform as a service (PaaS) resources can be affected by Chargeback models.

- Use a shutdown schedule for nonproduction workloads to optimize costs.

- Use [Azure Advisor](/azure/advisor/) to check recommendations for optimizing costs.

- Establish a charge back model for better distribution of cost across your organization.

- Implement policy to prevent the deployment of resources not authorized to be deployed in your organization's environment.

- Establish a regular schedule and cadence to review cost and right size resources for workloads.

## Subscriptions recommendations

The following sections contain recommendations to help you plan and create subscriptions for Azure.

### Organization and governance recommendations

- Treat subscriptions as a unit of management aligned with your business needs and priorities.

- Make subscription owners aware of their roles and responsibilities.
  - Do a quarterly or yearly access review for Azure AD Privileged Identity Management to ensure that privileges don't proliferate as users move within your organization.
  - Take full ownership of budget spending and resources.
  - Ensure policy compliance and remediate when necessary.

- Reference the following principles as you identify requirements for new subscriptions:
  - **Scale limits:** Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. Large specialized workloads like high-performance computing, IoT, and SAP should use separate subscriptions to avoid running up against these limits.
  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, allowing a clear separation of concerns. Different environments, such as development, test, and production, are often removed from a management perspective.
  - **Policy boundary:** Subscriptions serve as a boundary for the Azure Policy assignments. For example, secure workloads like PCI typically require other policies in order to achieve compliance. The other overhead doesn't get considered if you use a separate subscription. Development environments have more relaxed policy requirements than production environments.
  - **Target network topology:** You can't share virtual networks across subscriptions, but you can connect them with different technologies like virtual network peering or Azure ExpressRoute. When deciding if you need a new subscription, consider which workloads need to communicate with each other.

- Group subscriptions together under management groups, which are aligned with your management group structure and policy requirements. Grouping subscriptions ensures that subscriptions with the same set of policies and Azure role assignments all come from a management group.

- Establish a dedicated management subscription in your `Platform` management group to support global management capabilities like Azure Monitor Log Analytics workspaces and Azure Automation runbooks.

- Establish a dedicated identity subscription in your `Platform` management group to host Windows Server Active Directory domain controllers when necessary.

- Establish a dedicated connectivity subscription in your `Platform` management group to host an Azure Virtual WAN hub, private Domain Name System (DNS), ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all your foundation network resources are billed together and isolated from other workloads.

- Avoid a rigid subscription model. Instead, use a set of flexible criteria to group subscriptions across your organization. This flexibility ensures that as your organization's structure and workload composition changes, you can create new subscription groups instead of using a fixed set of existing subscriptions. One size doesn't fit all for subscriptions, and what works for one business unit might not work for another. Some applications might coexist within the same landing zone subscription, while others might require their own subscription.

  - For more information, see [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture?](../../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture).

### Quota and capacity recommendations

- Use subscriptions as scale units, and scale out resources and subscriptions as required. Your workload can then use the required resources for scaling out without hitting subscription limits in the Azure platform.

- Use reserved instances to manage capacity in some regions. Your workload can then have the required capacity for high demand resources in a specific region.

- Establish a dashboard with custom views to monitor used capacity levels, and set up alerts if capacity is approaching critical levels (90 percent CPU usage).

- Raise support requests for quota increases under subscription provisioning, such as for total available VM cores within a subscription. Ensure that your quota limits are set before your workloads exceed the default limits.

- Ensure that any required services and features are available within your chosen deployment regions.

### Automation recommendations

- Build a Subscription vending process to automate the creation of Subscriptions for application teams via a request workflow as described in [Subscription vending](subscription-vending.md).

### Tenant transfer restriction recommendations

- Configure the following settings to prevent users from transferring Azure subscriptions to or from your Azure AD tenant:

  - Set **Subscription leaving Azure AD directory** to `Permit no one`.

  - Set **Subscription entering Azure AD directory** to `Permit no one`.

- Configure a limited list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - Include members from an Azure PlatformOps (platform operations) team.
  - Include break-glass accounts in the list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

## Next steps

[Adopt policy-driven guardrails](../../enterprise-scale/dine-guidance.md)
