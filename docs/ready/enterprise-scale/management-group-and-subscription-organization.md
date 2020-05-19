---
title: XX
description: XX
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management group and subscription organization

![Management Group Hierarchy](./media/sub-org.png)

_Figure 5: Management group hierarchy._

## 1. Define management group hierarchy

Within an Azure AD tenant, management group structures help to support organizational mapping and must therefore be appropriately considered when planning Azure adoption at-scale.

**Design considerations:**

- Management groups can be used to aggregate policy and initiative assignments.
- A management group tree can support up to [six levels of depth](https://docs.microsoft.com/azure/governance/management-groups/overview#hierarchy-of-management-groups-and-subscriptions). This limit doesn't include the root level or the subscription level.

**Design recommendations:**

- Keep the management group hierarchy reasonably flat with ideally no more than 3-4 levels.

  This reduces management overhead and complexity.

- Avoid duplicating your organizational structure into a deeply nested management group hierarchy. Management groups should be used for policy assignment purposes, **`NOT`** for billing purposes.

  This facilitates the use of management groups for its intended purpose in an enterprise-scale architecture, which is to provide Azure policies for workloads that requrie the same type of security and compliance under the same management group.

- Create management groups under your root level management group that represent the types of workloads (archetype) that you will host, based on their security, compliance, connectivity, and feature needs.

  This allows you to have a set of Azure policies applied at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- Use resource tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the management group hierarchy.

  This faciliates grouping resources for search needs without having to use a complex management group hierarchy.

- Create a top-level **Sandboxes** management group to allow users to immediately experiment with Azure.

  This allows users to experiment with resources that might not yet be allowed in production environments, and provides isolation from your development, test and production environments.

- Use a dedicated service principal (spn) to execute management group management operations, subscription management operations, and role assignment.

  This reduces the number of users who have elevated rights, following least privilege guidelines.

- Assign the user access administrator Azure AD role at the root management group scope () to grant the spn mentioned above access at the root level. After the spn is granted permissions, the user administrator access role can be safely removed.

  This ensures only the spn is part of the user administrator access role.

- Assign the spn mentioned above **Contributor** permission at the root management group scope () to allow tenant level operations.

  This ensures the spn can be used to deploy and manage resources to any subscription within your organization.

- Create a **Platform** management group under the top-level (root) management group to support common platform policy and RBAC assignment.

  This ensures that different policies can be applied to the subscriptions used for your Azure foundation, and that the billing for common resources is centralized in one set of foundational subscriptions.

- Limit the number of Azure Policy assignments made at the root management group scope.

  This minimizes debugging inheritted policies in lower level management groups.

- Do not create any subscriptions under the "root" management group.

  This ensures that subscriptions do **`NOT`** inherited just the small set of Azure policies assigned at the root level management group, which are not representative of a full set necessary for any given workload.

## 2. Subscription organization and governance

Subscriptions are a unit of management, billing, and scale within Azure, and therefore play a critical role when designing for large-scale Azure adoption. This section helps capture customer subscription requirements and design target subscriptions based on critical factors such as environment type, ownership and governance model, organizational structure, and application portfolios.

**Design considerations:**

- Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads, such as PCI workloads, typically require additional policies to achieve compliance. Instead of using a management group to group workloads that require PCI compliance, you can achieve the same isolation by using a subscription.

  This ensures you do not have too many management groups with a small number of subscriptions.

- Subscriptions serve as a scale unit so that component workloads can scale within the platform [subscription limits](https://docs.microsoft.com/azure/azure-subscription-service-limits).

  Make sure to consider subscription resource limits during your workload design sessions.

- Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns.

- There is a manual process (planned future automation) which can be conducted to limit an Azure AD tenant to only use enterprise enrollment subscriptions.

  Prevents creation of MSDN subscriptions at the root management group scope.
  <!--
  We need to follow up with uday on what this process is, and where it is documented.
  -->

**Design recommendations:**

- Treat subscriptions as a democratized unit of management aligned with business needs and priorities.

  This minimizes the management overhead created when a subcription is broken down into many resources groups that are then managed by different teams. And provides a better billing mechanism for workloads that is not linked only to tagging.

- Make subscription owners aware of their roles and responsibility, which are as follows:

  - Perform an access review in Azure AD PIM, either quarterly or twice a year, to ensure there is no proliferation of privileges as users move within the customer organization.

  - Take full ownership of budget spending and resource utilization.

  - Ensure policy compliance and perform remediation when required.

- Use the following principals when identifying requirements for new subscriptions

  - **Scale limits:** Subscriptions serve as a scale unit so that component workloads are able to scale within platform subscription limits. For example, large specialized workloads such as hpc, IoT or SAP are better suited to use a separate subscription each to avoid limits (e.g. There is a limit of 50 adf integrations).

  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns. For example, different environments such as development, test and production are often isolated from a management perspective.

  - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance, and this additional overhead does not need to be considered holistically if a separate subscription is used. Similarly, development environments may have more relaxed policy requirements relative to production environments.

  - **Target network topology:** Virtual networks cannot be shared across subscriptions, but they can be connected using different technologies, such as virtual network peering or ExpressRoute. Therefore, it is important to consider which workloads must communicate with one another when deciding if a new subscription is required.

- Group subscriptions under management groups aligned within the management group structure and policy requirements at scale.

  This ensures subscriptions that have the same set of needed policies and RBAC assignments can inherit those from a amangement group, avoiding duplication of assignments.

- Establish a dedicated **Management** subscription in the **Platform** management group to support global management capabilities such as Log Analytics workspaces, and automation runbooks.

- Establish a dedicated **Identity** subscription in the **Platform** management group to host Windows Server Active Directory domain controllers when necessary.

- Establish a dedicated **Connectivity** subscription in the **Platform** management group to host the virtual WAN hub, Azure Private DNS, ExpressRoute circuit, and other networking resources.

  This ensures all foundation network resources are billed together, and isolated from any other workloads.

- Avoid a rigid subscription model, opting instead for a set of flexible criteria to group subscriptions across the organization

  This ensures that as your organization structure and workload composition changes, you are able to create new groups of subscriptions instead of using a fixed set of existing subscriptions.

  - One size does not fit all for subscriptions; what works for one business unit may not work for another. Some applications may coexist within the same **Landing Zone** subscription while others may require their own subscription.

## 3. Configure subscription quota and capacity

Every Azure region contains a finite set of resources at any given time. So when considering an enterprise scale Azure adoption involving large resource quantities, it is essential to ensure that sufficient capacity and SKUs are available, and that attained capacity can be understood and monitored.

**Design considerations:**

- Limits and quotas within the Azure platform for each service your workloads require.

- Availability of required SKUs within chosen Azure regions.

  For example, new features might be available only in certain regions. And availability of certain SKUs for a given resources (such as VMs) might be different from one region to another.

- Subscription quotas are not capacity guarantees and are applied on a per region basis.

**Design recommendations:**

- Use subscriptions as scale units, scaling out resources and subscriptions as required.

  This ensures that your workload can use the required resources for scaling out, when needed, without hitting subscription limits in the Azure platform.

- Use reserved instances to prioritize reserved capacity in required regions.

  This ensures that your qorkload will have the required services, even if there is a high demand for that resource in a given region at any time.

- Establish a dashboard with custom views to monitor utilized capacity levels. Setup alerts if capacity utilization is reaching critical levels (e.g. 90% CPU utilization).

  This ensures you can plan for capacity before your workloads require scaling out.

- Raise support requests for quota increase as a part of subscription provisioning (e.g. Total available VM cores within a subscription).

  This ensures your quota limits are set before your qorkloads require to go over the default limits.

- Ensure required services and features are available within the chosen deployment regions.

  This ensures your workload can run as expected in those regions.

## 4. Establish cost management

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section will there explore key aspects associated with how cost transparency can be achieved across large Azure environments.

**Design considerations:**

- Potential need for chargeback models where shared PaaS services are concerned, such as ASE and AKS which may need to be shared to achieve higher density.

- Using a shutdown schedule for nonproduction workloads to optimise costs.

- Using Azure Advisor to check cost optimization recommendations.

**Design recommendations:**

- Use Azure Cost Management for the first level of aggregation and make it available to application owners.

<!-- Need to ask Uday or anyone else what this actually means
-->

- Use Azure resource tags for cost categorization and resource grouping.

  This allows your to have a chargeback mechanism for workloads that share a subscription, or for a given workload that span multiple subscriptions.
