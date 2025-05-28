---
title: Subscription considerations and recommendations
description: Learn about the critical role that subscriptions play as units of management, billing, and scale in Azure.
author: Zimmergren
ms.author: pnp
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Subscription considerations and recommendations

Subscriptions are a unit of management, billing, and scale within Azure. They play a critical role when you design for large-scale Azure adoption. This article helps you capture subscription requirements and design target subscriptions based on critical factors that vary depending on:

- Environment types
- Ownership and governance models
- Organizational structures
- Application portfolios
- Regions

> [!TIP]
> For more information about subscriptions, see the YouTube video: [Azure landing zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

>[!NOTE]
> If you use Enterprise Agreements, Microsoft Customer Agreements (Enterprise), or Microsoft Partner Agreements (CSP), review the subscription limits in [Billing accounts and scopes in the Azure portal](/azure/cost-management-billing/manage/view-all-accounts).

## Subscription considerations

The following sections contain considerations to help you plan and create subscriptions for Azure.

### Organization and governance design considerations

- Subscriptions serve as boundaries for Azure Policy assignments.

  For example, secure workloads like Payment Card Industry (PCI) workloads typically require other policies in order to achieve compliance. Instead of using a management group to collate workloads that require PCI compliance, you can achieve the same isolation with a subscription, without having too many management groups with a few subscriptions.

    If you need to group together many subscriptions of the same workload archetype, create them under a management group.

- Subscriptions serve as a scale unit so component workloads can scale within platform [subscription limits](/azure/azure-resource-manager/management/azure-subscription-service-limits). Make sure you consider subscription resource limits as you design your workloads.

- Subscriptions provide a management boundary for governance and isolation that clearly separates concerns.

- Create separate platform subscriptions for management (monitoring), connectivity, and identity when they're required.
  - Establish a dedicated management subscription in your platform management group to support global management capabilities like Azure Monitor Logs workspaces and Azure Automation runbooks.
  
  - Establish a dedicated identity subscription in your platform management group to host Windows Server Active Directory domain controllers when needed.
  - Establish a dedicated connectivity subscription in your platform management group to host an Azure Virtual WAN hub, private Domain Name System (DNS), Azure ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all your foundation network resources are billed together and isolated from other workloads.
  - Use subscriptions as a democratized unit of management that aligns with your business needs and priorities.

- Use manual processes to limit Microsoft Entra tenants to only Enterprise Agreement enrollment subscriptions. When you use a manual process, you can't create Microsoft Developer Network (MSDN) subscriptions at the root management group scope.
  
  For support, submit an [Azure support ticket](https://azure.microsoft.com/support/create-ticket/).

  For information about subscription transfers between Azure billing offers, see [Azure subscription and reservation transfer hub](/azure/cost-management-billing/manage/subscription-transfer).

### Multiple region considerations

>[!IMPORTANT]
> Subscriptions aren't tied to a specific region, and you can treat them as global subscriptions. They're logical constructs to provide billing, governance, security, and identity controls for Azure resources that are contained within them. Therefore, you don't need a separate subscription for each region.

- You can adopt a multiregion approach at the single workload level for scaling or geo-disaster recovery or at a global level (different workloads in different regions).

- A single subscription can contain resources from different regions, depending on the requirements and architecture.
- In a geo-disaster recovery context, you can use the same subscription to contain resources from primary and secondary regions because they're logically part of the same workload.
- You can deploy different environments for the same workload in different regions to optimize costs and resource availability.
- In a subscription that contains resources from multiple regions, you can use resource groups to organize and contain resources by region.

### Quota and capacity design considerations

Azure regions might have a finite number of resources. As a result, you should track the available capacity and SKUs for Azure adoptions with several resources.

- Consider [limits and quotas](/azure/azure-resource-manager/management/azure-subscription-service-limits) within the Azure platform for each service that your workloads require.

- Consider the availability of required SKUs within your chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources like virtual machines (VMs) can vary from one region to another.

- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

  For virtual machine capacity reservations, see [On-demand capacity reservation](/azure/virtual-machines/capacity-reservation-overview).

- Consider reusing unused or decommissioned subscriptions. For more information, see [Create or reuse Azure subscriptions](../../enterprise-scale/faq.md#should-we-create-a-new-azure-subscription-every-time-or-should-we-reuse-azure-subscriptions).

### Tenant transfer restriction design considerations

Each Azure subscription is linked to a single Microsoft Entra tenant, which acts as an identity provider (IdP) for your Azure subscription. Use the Microsoft Entra tenant to authenticate users, services, and devices.

When any user has the required permissions, they can change the Microsoft Entra tenant that's linked to your Azure subscription. For more information, see:

- [Associate or add an Azure subscription to your Microsoft Entra tenant](/entra/fundamentals/how-subscriptions-associated-directory)
- [Transfer an Azure subscription to a different Microsoft Entra directory](/azure/role-based-access-control/transfer-subscription)

> [!NOTE]
> You can't transfer to a different Microsoft Entra tenant for Azure Cloud Solution Provider (CSP) subscriptions.

For Azure landing zones, you can set requirements to prevent users from transferring subscriptions to your organization's Microsoft Entra tenant. For more information, see [Manage Azure subscription policies](/azure/cost-management-billing/manage/manage-azure-subscription-policy).

Configure your subscription policy by providing a list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users). Exempted users are permitted to bypass restrictions that are set in the policy.

> [!IMPORTANT]
> An exempted users list isn't an [Azure Policy](/azure/governance/policy/overview).

- Consider whether you should allow users that have [Visual Studio or MSDN Azure subscriptions](https://azure.microsoft.com/pricing/member-offers/credit-for-visual-studio-subscribers/) to transfer their subscription to or from your Microsoft Entra tenant.

- Only users with the Microsoft Entra [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator) can configure tenant transfer settings. These users must have [elevated access](/azure/role-based-access-control/elevate-access-global-admin) to change the policy.

  - You can only specify individual user accounts as [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users), not Microsoft Entra groups.

[!INCLUDE [global admin warning](../../../includes/global-admin-warning.md)]

- All users with access to Azure can view the policy that's defined for your Microsoft Entra tenant.

  - Users can't view your [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users) list.

  - Users can view the global administrators within your Microsoft Entra tenant.

- Azure subscriptions that you transfer into a Microsoft Entra tenant are placed into the [default management group](/azure/governance/management-groups/how-to/protect-resource-hierarchy#setting---default-management-group) for that tenant.

- If your organization approves, your application team can define a process to allow Azure subscriptions to be transferred to or from a Microsoft Entra tenant.

### Cost management design considerations

Every large enterprise organization has the challenge of managing cost transparency. This section explores key aspects to achieve cost transparency across large Azure environments.

- You might need to share chargeback models, like App Service Environment and Azure Kubernetes Service (AKS), to achieve higher density. Chargeback models can affect shared platform as a service (PaaS) resources.

- Use a shutdown schedule for nonproduction workloads to optimize costs.

- Use [Azure Advisor](/azure/advisor/) to get recommendations for optimizing costs.

- Establish a chargeback model for better distribution of cost across your organization.

- Implement policy so that users can't deploy unauthorized resources in your organization's environment.

- Establish a regular schedule and cadence to review cost and rightsize resources for workloads.

## Subscription recommendations

The following sections contain recommendations to help you plan and create subscriptions for Azure.

### Organization and governance recommendations

- Treat subscriptions as a unit of management that aligns with your business needs and priorities.

- Inform subscription owners of their roles and responsibilities.
  - Do a quarterly or yearly access review for Microsoft Entra Privileged Identity Management (PIM) to ensure that privileges don't proliferate when users move within your organization.
  
  - Take full ownership of budget spending and resources.
  - Ensure policy compliance and remediate when necessary.

- When you identify requirements for new subscriptions, reference the following principles:
  - **Scale limits**: Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. Large specialized workloads, like high-performance computing, IoT, and SAP, should use separate subscriptions to avoid running up against these limits.
  
  - **Management boundary**: Subscriptions provide a management boundary for governance and isolation, which allows a clear separation of concerns. Various environments, such as development, test, and production environments, are often removed from a management perspective.
  - **Policy boundary**: Subscriptions serve as a boundary for the Azure Policy assignments. For example, secure workloads like PCI workloads typically require other policies in order to achieve compliance. The other overhead doesn't get considered if you use a separate subscription. Development environments have more relaxed policy requirements than production environments.
  - **Target network topology**: You can't share virtual networks across subscriptions, but you can connect them with different technologies like virtual network peering or ExpressRoute. When you decide if you need a new subscription, consider which workloads need to communicate with each other.

- Group subscriptions together under management groups, which are aligned with your management group structure and policy requirements. Group subscriptions to ensure that subscriptions with the same set of policies and Azure role assignments come from the same management group.

- Establish a dedicated management subscription in your `Platform` management group to support global management capabilities like Azure Monitor Logs workspaces and Automation runbooks.

- Establish a dedicated identity subscription in your `Platform` management group to host Windows Server Active Directory domain controllers when necessary.

- Establish a dedicated connectivity subscription in your `Platform` management group to host a Virtual WAN hub, private DNS, ExpressRoute circuit, and other networking resources. A dedicated subscription ensures that all your foundation network resources are billed together and isolated from other workloads.

- Avoid a rigid subscription model. Instead, use a set of flexible criteria to group subscriptions across your organization. This flexibility ensures that as your organization's structure and workload composition changes, you can create new subscription groups instead of using a fixed set of existing subscriptions. One size doesn't fit all for subscriptions, and what works for one business unit might not work for another. Some applications might coexist within the same landing zone subscription, while others might require their own subscription.

  For more information, see [Handle dev/test/production workload landing zones](../../enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture).

### Multiple regions recommendations

- Create additional subscriptions for each region only if you have region-specific governance and management requirements, for example data sovereignty or to scale beyond quota limits.

- If scaling isn't a concern for a geo-disaster recovery environment that spans multiple regions, use the same subscription for the primary and secondary region resources. Some Azure services, depending on the business continuity and disaster recovery (BCDR) strategy and tools that you adopt, might need to use the same subscription. In an active-active scenario, where deployments are independently managed or have different life cycles, we recommend that you use different subscriptions.
- The region where you create a resource group and the region of the contained resources should match so they don't affect resilience and reliability.
- A single resource group shouldn't contain resources from different regions. This approach can lead to problems with resource management and availability.

### Quota and capacity recommendations

- Use subscriptions as scale units, and scale out resources and subscriptions as required. Your workload can then use the required resources for scaling out without reaching subscription limits in the Azure platform.

- Use capacity reservations to manage capacity in some regions. Your workload can then have the required capacity for high demand resources in a specific region.

- Establish a dashboard that has custom views to monitor used capacity levels, and set up alerts if capacity approaches critical levels, such as 90% CPU usage.

- Raise support requests for quota increases under subscription provisioning, such as for total available VM cores within a subscription. Ensure that your quota limits are set before your workloads exceed the default limits.

- Ensure that any required services and features are available within your chosen deployment regions.

### Automation recommendations

- Build a subscription vending process to automate the creation of subscriptions for application teams via a request workflow. For more information, see [Subscription vending](subscription-vending.md).

### Tenant transfer restriction recommendations

- Configure the following settings to prevent users from transferring Azure subscriptions to or from your Microsoft Entra tenant:

  - Set *Subscription leaving Microsoft Entra directory* to `Permit no one`.

  - Set *Subscription entering Microsoft Entra directory* to `Permit no one`.

- Configure a limited list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

  - Include members from an Azure platform operations team.
  
  - Include break-glass accounts in the list of [exempted users](/azure/cost-management-billing/manage/manage-azure-subscription-policy#exempted-users).

## Next step

[Adopt policy-driven guardrails](../../enterprise-scale/dine-guidance.md)
