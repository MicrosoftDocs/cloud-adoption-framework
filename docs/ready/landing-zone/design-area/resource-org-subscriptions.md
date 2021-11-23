---
title: Resource organization - subscriptions - design area
description: Overview for the resource organization and subscriptions design area
author: DominicAllen
ms.author: doalle
ms.date: 10/11/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Subscriptions

Subscriptions are a unit of management, billing, and scale within Azure. They play a critical role when you're designing for large-scale Azure adoption. This section helps you capture subscription requirements and design target subscriptions based on critical factors. These factors are environment type, ownership and governance model, organizational structure, and application portfolios.

## Subscriptions considerations

### Subscription organization and governance design considerations

- Subscriptions serve as boundaries for assigning Azure policies.

  - For example, secure workloads such as Payment Card Industry (PCI) workloads typically require additional policies to achieve compliance. Instead of using a management group to group workloads that require PCI compliance, you can achieve the same isolation with a subscription. This way, you don't have too many management groups with a small number of subscriptions.

    - However, creating a management group for these types of landing zone archetypes, if a larger amount of subscriptions are to be created, is a recommended approach.

- Subscriptions serve as a scale unit so that component workloads can scale within the platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Make sure to consider subscription resource limits during your workload design sessions.

- Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns.

- There's a manual process, planned future automation, that can be conducted to limit an Azure AD tenant to use only Enterprise Agreement enrollment subscriptions. This process prevents creation of Microsoft Developer Network subscriptions at the root management group scope.
  - To do this, reach out via an [Azure Support ticket](https://azure.microsoft.com/support/create-ticket/)

- Review the guidance in [Azure subscription and reservation transfer hub](/azure/cost-management-billing/manage/subscription-transfer) for information around supported transfers of subscriptions between Azure billing offers.

### Subscription quota and capacity design considerations

Each Azure region contains a finite number of resources. When you consider an Azure adoption that involves large resource quantities, ensure that sufficient capacity and SKUs are available and that the attained capacity can be understood and monitored.

- Consider [limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) within the Azure platform for each service that your workloads require.

- Consider the availability of required SKUs within chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources such as VMs might be different from one region to another.

- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

  - See [On-demand capacity reservation (preview)](/azure/virtual-machines/capacity-reservation-overview) for virtual machine capacity reservations.

### Subscription tenant transfer restrictions design considerations

Each Azure subscription is linked to a single Azure AD tenant, this acts as the identity provider (IdP) for the Azure subscription which it will trust to authenticate users, services and devices.

However, the Azure AD tenant that an Azure subscription is linked to can be changed by a user with the required permissions that also exists in more than one Azure AD tenant, again, with the required permissions. This process is detailed in the following articles:

- [Associate or add an Azure subscription to your Azure Active Directory tenant](/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory)
- [Transfer an Azure subscription to a different Azure AD directory](/azure/role-based-access-control/transfer-subscription)

> [!NOTE]
> For Azure Cloud Solution Provider (CSP) subscriptions, transferring to another Azure AD tenant is not supported.

When this is considered in the context of Azure landing zones, you may decide to restrict and prevent users from being able to either transfer Azure subscriptions out of your organization's Azure AD tenant or transfer Azure subscriptions into your organization's Azure AD tenant. This can be done by following the process detailed in [Manage Azure subscription policies](/azure/cost-management-billing/manage/manage-azure-subscription-policy).

As part of the subscription policy you can configure, you can also provide a list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users) who are permitted to bypass what's set in the policy.

> [!IMPORTANT]
> This is not an [Azure Policy](/azure/governance/policy/overview).

- Consider whether users with [Visual Studio/MSDN Azure subscriptions](https://azure.microsoft.com/pricing/member-offers/credit-for-visual-studio-subscribers/) should be allowed to transfer their subscription to or from the Azure AD tenant.

- These settings are only configurable by users with the Azure AD [Global Administrator](/azure/active-directory/roles/permissions-reference#global-administrator) role assigned and they must have [elevated their access](/azure/role-based-access-control/elevate-access-global-admin) to be able to change the policy.

  - Only individual user accounts can be specified as [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users). Azure AD groups are not supported at this time.

- All users with access to Azure will be able to view the policy defined for the Azure AD tenant.

  - They will not be able to view the [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - They will be able to view the global administrators within the Azure AD tenant.

- Azure subscriptions transferred into an Azure AD tenant will be placed into the [default management group](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group) for that tenant.

- Define a process to allow Azure subscriptions to be transferred to or from an Azure AD tenant, if it's deemed necessary by the application team and approved by the organization.

### Establish cost management design considerations

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section explores key aspects associated with how cost transparency can be achieved across large Azure environments.

- There could be a need for chargeback models where shared platform as a service (PaaS) resources are concerned, such as Azure App Service Environment and Azure Kubernetes Service, which might need to be shared to achieve higher density.

- Use a shutdown schedule for nonproduction workloads to optimize costs.

- Use Azure Advisor to check recommendations for optimizing costs.

## Subscriptions recommendations

### Subscription organization and governance recommendations

- Treat subscriptions as a unit of management aligned with business needs and priorities.

- Make subscription owners aware of their roles and responsibilities:
  - Perform an access review in Azure AD Privileged Identity Management quarterly or twice a year to ensure that privileges don't proliferate as users move within the customer organization.
  - Take full ownership of budget spending and resource utilization.
  - Ensure policy compliance and remediate when necessary.

- Use the following principles when identifying requirements for new subscriptions:
  - **Scale limits:** Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. For example, large, specialized workloads such as high-performance computing, IoT, and SAP are all better suited to use separate subscriptions to avoid limits (such as a limit of 50 Azure Data Factory integrations).
  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, which allows for a clear separation of concerns. For example, different environments such as development, test, and production are often isolated from a management perspective.
  - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance. This additional overhead doesn't need to be considered holistically if a separate subscription is used. Similarly, development environments might have more relaxed policy requirements relative to production environments.
  - **Target network topology:** Virtual networks can't be shared across subscriptions, but they can connect with different technologies such as virtual network peering or Azure ExpressRoute. Consider which workloads must communicate with each other when you decide whether a new subscription is required.

- Group subscriptions together under management groups aligned within the management group structure and policy requirements at scale. Grouping ensures that subscriptions with the same set of policies and Azure role assignments can inherit them from a management group, which avoids duplicate assignments.

- Establish a dedicated management subscription in the `Platform` management group to support global management capabilities such as Azure Monitor Log Analytics workspaces and Azure Automation runbooks.

- Establish a dedicated identity subscription in the `Platform` management group to host Windows Server Active Directory domain controllers, when necessary.

- Establish a dedicated connectivity subscription in the `Platform` management group to host an Azure Virtual WAN hub, private Domain Name System (DNS), ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all foundation network resources are billed together and isolated from other workloads.

- Avoid a rigid subscription model, and opt instead for a set of flexible criteria to group subscriptions across the organization. This flexibility ensures that as your organization's structure and workload composition changes, you can create new subscription groups instead of using a fixed set of existing subscriptions. One size doesn't fit all for subscriptions. What works for one business unit might not work for another. Some applications might coexist within the same landing zone subscription while others might require their own subscription.

  - See [How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture?](/azure/cloud-adoption-framework/ready/enterprise-scale/faq#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture) for further guidance regarding this point. **LINK WILL NEED UPDATING ONCE FAW PR MERGED #2676**

### Subscription quota and capacity recommendations

- Use subscriptions as scale units, and scale out resources and subscriptions as required. Your workload can then use the required resources for scaling out, when needed, without hitting subscription limits in the Azure platform.

- Use reserved instances to prioritize reserved capacity in required regions. Then your workload will have the required capacity even when there's a high demand for that resource in a specific region.

- Establish a dashboard with custom views to monitor used capacity levels. Set up alerts if capacity utilization is reaching critical levels (for example, CPU utilization pf 90 percent).

- Raise support requests for quota increase as a part of subscription provisioning (for example, total available VM cores within a subscription). This approach ensures your quota limits are set before your workloads require going over the default limits.

- Ensure required services and features are available within the chosen deployment regions.

### Subscription tenant transfer restriction recommendations

- Prevent all users, by default, from being able to transfer Azure subscriptions to or from the Azure AD tenant by configuring the following settings:

  - **Subscription leaving Azure AD directory** set to `Permit no one`.

  - **Subscription entering Azure AD directory** set to `Permit no one`.

- Configure a limited set of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - This would ideally be members of an Azure PlatformOps (platform operations) team.

  - Include break-glass accounts in the list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).
