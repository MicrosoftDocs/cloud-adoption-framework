---
title: Subscription considerations and recommendations
description: Learn about the critical role that subscriptions play as units of management, billing, and scale in Azure.
author: DominicAllen
ms.author: doalle
ms.date: 6/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Subscription considerations and recommendations

Subscriptions are a unit of management, billing, and scale within Azure. Subscriptions play a critical role when you're designing for large-scale Azure adoption. This article helps you capture subscription requirements and design target subscriptions based on critical factors.

## Subscriptions considerations

Design considerations for subscriptions are based on the following factors:

- Organization and governance
- Quota and capacity
- Tenant transfer restrictions
- Establish cost management

### Subscription organization and governance design considerations

Keep the following organization and governance factors in mind:

- Subscriptions serve as boundaries for assigning Azure policies.

  For example, secure workloads, such as Payment Card Industry (PCI) workloads, typically require other policies to achieve compliance. Instead of using a management group to collate workloads that require PCI compliance, you can achieve the same isolation with a subscription. With this approach, you don't have too many management groups with a few subscriptions.

  If you need to group together several subscriptions that are of the same workload archetype, create them under a management group.

- Subscriptions serve as a scale unit. Component workloads can scale within the platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Make sure that you consider subscription resource limits during your workload design.

- Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns. Create separate platform subscriptions for management (monitoring), connectivity, and identity when these elements are required.

  - Establish a dedicated management subscription in the platform management group to support global management capabilities such as [Log Analytics in Azure Monitor](/azure/azure-monitor/logs/log-analytics-overview) workspaces and [Azure Automation](/azure/automation/overview) runbooks.

  - Establish a dedicated identity subscription in the platform management group to host Windows Server Active Directory domain controllers, when necessary.

  - Establish a dedicated connectivity subscription in the platform management group to host an [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) hub, private DNS, [Azure ExpressRoute](/azure/expressroute/) circuit, and other networking resources. A dedicated subscription ensures that all foundation network resources are billed together and isolated from other workloads.
  
- Use subscriptions as a democratized unit of management, aligned with business needs and priorities.

- Use the manual process to limit an [Azure Active Directory](/azure/active-directory/) (Azure AD) tenant to only Enterprise Agreement enrollment subscriptions. This process prevents creation of Microsoft Developer Network subscriptions at the root management group scope.

  For support, create an [Azure Support ticket](https://azure.microsoft.com/support/create-ticket/).

See the [Azure subscription and reservation transfer hub](/azure/cost-management-billing/manage/subscription-transfer) for transfers of subscriptions between Azure billing offers.

### Subscription quota and capacity design considerations

Azure regions might have limited resources. You can track the available capacity and SKUs for Azure adoptions that have a large number of resources.

- Consider [limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) within the Azure platform for each service that your workloads require.

- Consider the availability of required SKUs within chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources, such as virtual machines, might differ from one region to another.

> [!NOTE]
>
> Subscription quotas aren't capacity guarantees and are applied on a per-region basis. For virtual machine capacity reservations, see [On-demand capacity reservation (preview)](/azure/virtual-machines/capacity-reservation-overview).

### Subscription tenant transfer restrictions design considerations

Each Azure subscription is linked to a single Azure AD tenant, which acts as an identity provider (IdP) for the Azure subscription. The Azure AD tenant is used to authenticate users, services, and devices.

The Azure AD tenant linked to the Azure subscription can be changed by a user with the required permissions. For more information, see these articles:

- [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)
- [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription)

> [!NOTE]
> For Azure Cloud Solution Provider (CSP) subscriptions, transferring to another Azure AD tenant is not supported.

With Azure landing zones, you can set requirements to prevent users from transferring subscriptions to your organization's Azure AD tenant. Review the process in [Manage Azure subscription policies](/azure/cost-management-billing/manage/manage-azure-subscription-policy).

Configure the subscription policy by providing a list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users). Exempted users are permitted to bypass what's set in the policy.

> [!IMPORTANT]
> This is not an [Azure Policy](/azure/governance/policy/overview).

Consider whether users with [Visual Studio/MSDN Azure subscriptions](https://azure.microsoft.com/pricing/member-offers/credit-for-visual-studio-subscribers/) should be allowed to transfer their subscription to or from the Azure AD tenant.

Only users who have the Azure AD [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) role assigned and have [elevated their access](/azure/role-based-access-control/elevate-access-global-admin) can configure these settings.

Only individual user accounts can be specified as [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users). Azure AD groups aren't supported.

All users with access to Azure can view the policy defined for the Azure AD tenant.

- Users can't view the [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

- Users can view the global administrators within the Azure AD tenant.

Azure subscriptions transferred into an Azure AD tenant are placed in the [default management group](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group) for that tenant.

The application team might define a process to allow Azure subscriptions to be transferred to or from an Azure AD tenant, if approved by the organization.

### Establish cost management design considerations

Cost transparency is a critical management challenge faced by every large enterprise organization. These key aspects are associated with how cost transparency can be achieved across large Azure environments:

- Chargeback models, such as [Azure App Service Environment](/azure/app-service/environment/) and [Azure Kubernetes Service](/azure/aks/), might need to be shared to achieve higher density. Shared platform as a service (PaaS) resources might be affected by chargeback models.

- Use a shutdown schedule for nonproduction workloads to optimize costs.

- Use [Azure Advisor](/azure/advisor/) to check recommendations for optimizing costs.

- Establish a chargeback model for better distribution of cost across organization.

- Implement policy to prevent deploying resources not authorized to be deployed in your organization environment.

- Established regular schedule and cadence to review cost and right size resources for workloads.

## Subscriptions recommendations

Consider the following recommendations for creating and using subscriptions.

### Subscription organization and governance recommendations

Consider the follow recommendations for organization and governance:

- Treat subscriptions as a unit of management that's aligned with your business needs and priorities.

- Make subscription owners aware of their roles and responsibilities:

  - Do an access review in Azure AD [Privileged Identity Management](/azure/active-directory/privileged-identity-management/) on a quarterly or yearly basis. This review ensures that privileges don't proliferate as users move within the customer organization.
  - Take full ownership of budget spending and resources.
  - Ensure policy compliance and remediate when necessary.

- Use the following principles when identifying requirements for new subscriptions:

  - **Scale limits:** Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. Large specialized workloads, such as high-performance computing, IoT, and SAP, should use separate subscriptions to avoid limits.
  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, which allows for a clear separation of concerns. Different environments, such as development, test, and production, are often removed from a management perspective.
  - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads, such as PCI, typically require other policies to achieve compliance. The other overhead isn't considered if a separate subscription is used. Development environments have more relaxed policy requirements than production environments.
  - **Target network topology:** Virtual networks can't be shared across subscriptions but they can connect with different technologies such as virtual network peering or Azure ExpressRoute. Consider which workloads must communicate with each other when deciding if a new subscription is required.

- Group subscriptions together under management groups, which are aligned with the management group structure and policy requirements. Grouping ensures that subscriptions with the same set of policies and Azure role assignments come from a management group.

- Establish a dedicated management subscription in the platform management group to support global management capabilities, such as Azure Monitor Log Analytics workspaces and Azure Automation runbooks.

- Establish a dedicated identity subscription in the platform management group to host Windows Server Active Directory domain controllers, when necessary.

- Establish a dedicated connectivity subscription in the platform management group to host an Azure Virtual WAN hub, private DNS, ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all foundation network resources are billed together and isolated from other workloads.

- Avoid a rigid subscription model. Opt for a set of flexible criteria to group subscriptions across the organization. The flexibility ensures that as your organization's structure and workload composition changes, you can create new subscription groups instead of using a fixed set of existing subscriptions.

  One size doesn't fit all for subscriptions. Something that works for one business unit might not work for another. Some applications might coexist within the same landing zone subscription, while others might require their own subscription.

  For more information, see [Workload landing zones in enterprise-scale architecture](../../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture).

### Subscription quota and capacity recommendations

Consider the following recommendations for quota and capacity:

- Use subscriptions as scale units. Scale out resources and subscriptions, as required. Your workload might then use the required resources for scaling out without hitting subscription limits in the Azure platform.

- Use reserved instances to manage capacity in some regions. Your workload might then have the required capacity for high demand resources in a specific region.

- Establish a dashboard with custom views to monitor used capacity levels. Set up alerts if capacity is reaching critical levels, 90 percent CPU usage.

- Raise support requests for quota increases under subscription provisioning. For example, total available virtual machine cores within a subscription. You might then ensure that your quota limits are set before your workloads exceed the default limits.

- Ensure that your required services and features are available within the chosen deployment regions.

### Subscription tenant transfer restriction recommendations

Consider the following recommendations for tenant transfer restrications:

- Configure these settings to help prevent users from transferring Azure subscriptions to or from the Azure AD tenant:

  - **Subscription leaving Azure AD directory** set to `Permit no one`.
  - **Subscription entering Azure AD directory** set to `Permit no one`.

- Configure a limited set of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - Include members from an Azure PlatformOps (platform operations) team.
  - Include break-glass accounts in the list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

## Next steps

[Adopt policy-driven guardrails](../../enterprise-scale/dine-guidance.md)
