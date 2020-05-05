---
title: "Management group and subscription organization"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Management Group and Subscription Organization
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

<!-- cSpell:ignore rkuehfus CAF -->

# C. Management group and subscription organization

[![Management group hierarchy](./media/sub-org.png "management group hierarchy")](./media/sub-org.png)

Figure 5 – management group hierarchy

## 1. Define management group hierarchy

Within an Azure AD tenant, management group structures help to support organizational mapping and must therefore be appropriately considered when planning Azure adoption at scale.

**Design considerations:**

- Management groups can be used to aggregate policy and initiative assignments.

- There is a limit of seven levels in any nested management group structure.

**Design recommendations:**

- Keep the management group hierarchy reasonably flat with ideally no more than three to four levels.

- Use resource tags, which can be enforced or appended through Azure Policy to query and horizontally navigate across the management group tree; this is more flexible when compared to using a rigid vertical management group and subscription hierarchy.

- Create a top-level "sandboxes" management group to allow users to immediately experiment with Azure. Place user-based test subscriptions within this "sandbox" management group and apply requisite security policies to keep these sandbox subscriptions isolated and disconnected from dev/test/prod environments.

- Assign the user access administrator Azure AD role at root management group scope (/) to allow access assignments and resource visibility in any subscription or management group in the directory.

- Establish a dedicated "management" subscription within the top-level/root management group to support global management capabilities such as Log Analytics workspaces, automation runbooks, and custom RBAC definitions.

- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

<!-- -->

- Do not transpose the organizational structure into a deeply nested management group hierarchy.

- Do not create any subscriptions under the "root" management group.

## 2. Subscription organization and governance

Subscriptions are a unit of management and scale within Azure and play a critical role when designing for large-scale Azure adoption. This section strives to help readers capture customer subscription requirements and design target subscriptions based on critical factors, such as environment type, ownership and governance model, organizational structure, and application portfolios.

**Design considerations:**

- Subscriptions serve as a policy boundary for the assignment of Azure policies. For example, secure workloads such as pci typically require additional policies to achieve compliance, and this additional overhead does not need considered holistically if a separate subscription is used.

- Subscriptions serve as a scale unit so that component workloads can scale within platform [subscription limits](/azure/azure-subscription-service-limits).

- Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns.

- There is a manual process (planned future automation) which can be conducted to limit an Azure AD tenant to only consider enterprise enrollment subscriptions.

  - Prevents creation of MSDN subscriptions at the root management group scope.

**Design recommendations:**

- Treat subscriptions as a democratized unit of management aligned with business needs and priorities

- Make subscription owners aware of their roles and responsibilities, which are:

  - Perform an access review in Azure AD PIM, either quarterly or twice a year, to ensure there is no proliferation of privileges as users move within the customer organization.

    - Take full ownership of budget spending and resource utilization.

    - Ensure policy compliance and perform remediation when required.

- Use the following principals when identifying requirements for new subscriptions

  - **Scale limits:** Subscriptions serve as a scale unit so that component workloads are able to scale within platform subscription limits. For example, large specialized workloads such as hpc, IoT or SAP are better suited to separate subscriptions to avoid limits (e.g., there is a limit of 50 adf integrations).

  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns. For example, different environments such as development, test, and production are often isolated from a management perspective.

    - **Policy boundary** – subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as pci typically require additional policies to achieve compliance, and this additional overhead does not need considered holistically if a separate subscription is used. Similarly, development environments may have more relaxed policy requirements relative to production environments.

    - **Target network topology** – virtual networks cannot be shared across subscriptions, but they can be connected using different technologies, such as virtual network peering or ExpressRoute. Hence, it is important to consider network composition and which workloads must communicate with one another when deciding if a new subscription is required.

- Group subscriptions under management groups aligned within the management group structure and policy requirements at scale.

- Establish a dedicated "management" subscription within the top-level/root management group to support global management capabilities such as Log Analytics workspaces, automation runbooks, and custom RBAC definitions.

<!-- -->

- Avoid prescriptive and rigid subscription models, opting instead for a set of criteria to flexibly structure subscriptions across the organization, ensuring that as new workloads and business units are considered, subscriptions do not become limiting.

  - One size does not fit all for subscriptions; what works for one business unit may not work for another. Some applications may coexist within the same "landing zone" subscription while others may require their own subscriptions.

## 3. Configure subscription quota and capacity

Azure is ultimately comprised of a finite set of resources, so when considering enterprise scale Azure adoption involving large resource quantities, it is essential that attention be given to ensuring sufficient capacity and SKUs, and for attained capacity to be understood and monitored.

**Design considerations:**

- Platform limits and quotas within the Azure platform for services.

- Availability of required SKUs within chosen Azure regions.

- Subscription quotas are not capacity guarantees and are applied on a per region basis.

**Design recommendations:**

- Leverage subscriptions as scale units, scaling out resources and subscriptions as required.

- Use reserved instances to prioritize reserved capacity in required regions.

- Establish a dashboard with custom views to monitor utilized capacity levels. Set up alerts if capacity utilization is reaching critical levels (e.g., 90 percent CPU utilization).

- Raise support requests for quota increase as a part of subscription provisioning (e.g., total available VM cores within a subscription).

- Ensure required services and features are available within the chosen deployment regions.

## 4. Establish cost management

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section will there explore key aspects associated with how cost transparency can be achieved across large Azure environments.

**Design considerations:**

- Potential need for chargeback models where shared PaaS services are concerned, such as ASE and AKS, which may need to be shared to achieve higher density.

- Shut down schedule for nonproduction workloads to optimize costs.

- Azure Advisor provides cost optimization recommendations.

**Design recommendations:**

- Use Azure Cost Management for the first level of aggregation and make it available to application owners.

- Use Azure resource tags for cost categorization and resource grouping, aligning with subscription isolation for effective chargeback calculations.

## Next steps

Suggested design for [Network topology and connectivity](./d-network-topology-and-connectivity.md)

> [!div class="nextstepaction"]
> [Network topology and connectivity](./d-network-topology-and-connectivity.md)
