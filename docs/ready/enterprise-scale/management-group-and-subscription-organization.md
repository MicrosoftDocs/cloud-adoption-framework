---
title: Management group and subscription organization
description: Management group and subscription organization.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready 
---

# Management group and subscription organization

![Management group hierarchy](./media/sub-org.png)

_Figure 1: Management group hierarchy._

## Define a management group hierarchy

Management group structures within an Azure Active Directory (Azure AD) tenant support organizational mapping and must be considered thoroughly when an organization plans Azure adoption at scale.

**Design considerations:**

- Management groups can be used to aggregate policy and initiative assignments via Azure Policy.
- A management group tree can support up to [six levels of depth](https://docs.microsoft.com/azure/governance/management-groups/overview#hierarchy-of-management-groups-and-subscriptions). This limit doesn't include the tenant root level or the subscription level.

**Design recommendations:**

- Keep the management group hierarchy reasonably flat with no more than three to four levels, ideally. This reduces management overhead and complexity.

- Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Management groups should be used for policy assignment versus billing purposes. This necessitates using management groups for their intended purpose in enterprise-scale architecture, which is providing Azure policies for workloads that require the same type of security and compliance under the same management group level.

- Create management groups under your root-level management group to represent the types of workloads (archetype) that you'll host and ones based on their security, compliance, connectivity, and feature needs. This allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- Use resource tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the management group hierarchy. This facilitates grouping resources for search needs without having to use a complex management group hierarchy.

- Create a top-level sandbox management group to allow users to immediately experiment with Azure. This allows users to experiment with resources that might not yet be allowed in production environments and provides isolation from your development, test, and production environments.

- Use a dedicated service principal name (SPN) to execute management group management operations, subscription management operations, and role assignment. This reduces the number of users who have elevated rights, following least-privilege guidelines.

- Assign the `User Access Administrator` Azure RBAC role at the root management group scope (`/`) to grant the SPN mentioned above access at the root level. After the SPN is granted permissions, the `User Access Administrator` role can be safely removed. This ensures only the SPN is part of the `User Access Administrator` role.

- Assign `Contributor` permission to the SPN mentioned above at the root management group scope (`/`), which allows tenant-level operations. This ensures that the SPN can be used to deploy and manage resources to any subscription within your organization.

- Create a `Platform` management group under the root management group to support common platform policy and role-based access control (RBAC) assignment. This ensures that different policies can be applied to the subscriptions used for your Azure foundation, and that the billing for common resources is centralized in one set of foundational subscriptions.

- Limit the number of Azure Policy assignments made at the root management group scope (`/`). This minimizes debugging inherited policies in lower-level management groups.

- Do not create any subscriptions under the root management group. This ensures that subscriptions don't only inherit the small set of Azure policies assigned at the root-level management group, which don't represent a full set necessary for a workload.

## Subscription organization and governance

Subscriptions are a unit of management, billing, and scale within Azure, and they play a critical role when designing for large-scale Azure adoption. This section helps you capture subscription requirements and design target subscriptions based on critical factors such as environment type, ownership and governance model, organizational structure, and application portfolios.

**Design considerations:**

- Subscriptions serve as boundaries for assigning Azure policies. For example, secure workloads such as payment card industry (PCI) workloads typically require additional policies to achieve compliance. Instead of using a management group to group workloads requiring PCI compliance, you can achieve the same isolation with a subscription. This ensures that you don't have too many management groups with a small number of subscriptions.

- Subscriptions serve as a scale unit so that component workloads can scale within the platform [subscription limits](https://docs.microsoft.com/azure/azure-subscription-service-limits). Make sure to consider subscription resource limits during your workload design sessions.

- Subscriptions provide a management boundary for governance and isolation, creating a clear separation of concerns.

- There is a manual process (planned future automation) which can be conducted to limit an Azure AD tenant to use only enterprise agreement (EA) enrollment subscriptions. This prevents creation of MSDN subscriptions at the root management group scope.

**Design recommendations:**

- Treat subscriptions as a democratized unit of management aligned with business needs and priorities.

- Make subscription owners aware of their roles and responsibilities:

  - Perform an access review in Azure AD Privileged Identity Management quarterly or twice a year to ensure that privileges don't proliferate as users move within the customer organization.

  - Take full ownership of budget spending and resource utilization.

  - Ensure policy compliance and remediate when necessary.

- Use the following principles when identifying requirements for new subscriptions:

  - **Scale limits:** Subscriptions serve as a scale unit for component workloads to scale within platform subscription limits. For example, large specialized workloads such as high-performance computing, IoT, and SAP are all better suited to use separate subscriptions to avoid limits (such as a limit of 50 Azure Data Factory integrations).

  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns. For example, different environments such as development, test, and production are often isolated from a management perspective.

  - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance, and this additional overhead doesn't need to be considered holistically if a separate subscription is used. Similarly, development environments may have more relaxed policy requirements relative to production environments.

  - **Target network topology:** Virtual networks can't be shared across subscriptions, but they can connect with different technologies such as virtual network peering or ExpressRoute. Therefore, it's important to consider which workloads must communicate with each other when deciding if a new subscription is required.

- Group subscriptions together under management groups aligned within the management group structure and policy requirements at scale. This ensures that subscriptions with the same set of policies and RBAC assignments can inherit them from a management group, avoiding duplicate assignments.

- Establish a dedicated management subscription in the `Platform` management group to support global management capabilities such as Azure Monitor Log Analytics workspaces and Azure Automation runbooks.

- Establish a dedicated identity subscription in the `Platform` management group to host Windows server Active Directory domain controllers, when necessary.

- Establish a dedicated connectivity subscription in the `Platform` management group to host an Azure Virtual WAN hub, private DNS, ExpressRoute circuit, and other networking resources. This ensures that all foundation network resources are billed together and isolated from other workloads.

- Avoid a rigid subscription model, opting instead for a set of flexible criteria to group subscriptions across the organization. This ensures that as your organization's structure and workload composition changes, you're able to create new subscription groups instead of using a fixed set of existing subscriptions. One size doesn't fit all for subscriptions; what works for one business unit may not work for another. Some apps may coexist within the same landing zone subscription while others may require their own subscription.

## Configure subscription quota and capacity

Each Azure region contains a finite number of resources. When considering an enterprise-scale Azure adoption involving large resource quantities, ensure that sufficient capacity and SKUs are available and the attained capacity can be understood and monitored.

**Design considerations:**

- Consider limits and quotas within the Azure platform for each service that your workloads require.

- Consider the availability of required SKUs within chosen Azure regions. For example, new features might be available only in certain regions. The availability of certain SKUs for given resources such as VMs may be different from one region to another.

- Consider that subscription quotas aren't capacity guarantees and are applied on a per-region basis.

**Design recommendations:**

- Use subscriptions as scale units, and scale out resources and subscriptions as required. This ensures that your workload can use the required resources for scaling out, when needed, without hitting subscription limits in the Azure platform.

- Use reserved instances to prioritize reserved capacity in required regions. This ensures that your workload will have the required capacity even when there's a high demand for that resource in a specific region.

- Establish a dashboard with custom views to monitor used capacity levels. Set up alerts if capacity utilization is reaching critical levels (for example, 90 percent CPU utilization).

- Raise support requests for quota increase as a part of subscription provisioning (for example, total available VM cores within a subscription). This ensures your quota limits are set before your workloads require going over the default limits.

- Ensure required services and features are available within the chosen deployment regions.

## Establish cost management

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section will explore key aspects associated with how cost transparency can be achieved across large Azure environments.

**Design considerations:**

- Potential need for chargeback models where shared platform as a service (PaaS) resources are concerned, such as Azure App Service Environment and Azure Kubernetes Service, which may need to be shared to achieve higher density.

- Use a shutdown schedule for nonproduction workloads to optimize costs.

- Use Azure Advisor to check cost optimization recommendations.

**Design recommendations:**

- Use Azure Cost Management and Billing for cost aggregation and make it available to application owners.

- Use Azure resource tags for cost categorization and resource grouping. This allows you to have a chargeback mechanism for workloads that share a subscription or for a given workload that spans across multiple subscriptions.
