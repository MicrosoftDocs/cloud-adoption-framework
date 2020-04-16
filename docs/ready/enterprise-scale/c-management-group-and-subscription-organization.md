---
title: "Management Group and Subscription Organization"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF NorthStar landing zone - Management Group and Subscription Organization
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# C. Management Group and Subscription Organization

[![Management Group Hierarchy](./media/sub-org.png "Management Group Hierarchy")](./media/sub-org.png)

Figure 5 – Management Group Hierarchy

## 1. Define Management Group Hierarchy

Within an AAD tenant, Management Group structures help to support organisational mapping and must therefore be appropriately considered when planning Azure adoption at-scale.

***Design Considerations***

- Management groups can be used to aggregate Policy and Initiative assignments.

- There is a limit of 7 levels in any nested Management Group structure.

***Design Recommendations***

- Keep the Management Group hierarchy reasonably flat with ideally no more than 3-4 levels.

- Use Resource Tags, which can be enforced or appended through Azure Policy, to query and horizontally navigate across the Management Group tree, which is more flexible when compared to using a rigid vertical Management Group and Subscription hierarchy.

- Create a top-level “Sandboxes” Management Group to allow users to immediately experiment with Azure. Place user-based test subscriptions within this “Sandbox” Management Group and apply requisite security policies to keep these sandbox subscriptions isolated and disconnected from dev/test/prod environments.

- Assign the User Access Administrator AAD role at root Management Group scope (/) to allow access assignments and resource visibility in any Subscription or Management Group in the directory.

- Establish a dedicated “Management” Subscription within the top-level/root Management Group to support global management capabilities such as Log Analytics workspaces, automation runbooks, and custom RBAC definitions.

- Limit the number of Azure Policy assignments made at the root Management Group scope to avoid managing through exclusions at inherited scopes.

<!-- -->

- Do not transpose the organisational structure into a deeply nested management group hierarchy.

- Do not create any Subscriptions under the “root” Management Group.

## 2. Subscription Organization and Governance

Subscriptions are a unit of management and scale within Azure, and therefore play a critical role when designing for large-scale Azure adoption. This section strives to help readers capture customer subscription requirements and design target subscriptions based on critical factors, such as environment type, ownership and governance model, organizational structure and application portfolios.

***Design Considerations***

- Subscriptions serve as a policy boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance, and this additional overhead does not need considered holistically if a separate subscription is used.

- Subscriptions serve as a scale unit so that component workloads can scale within platform [subscription limits](/azure/azure-subscription-service-limits).

- Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns.

- There is a manual process (planned future automation) which can be conducted to limit an AAD tenant to only consider Enterprise Enrolment Subscriptions.

    - Prevents creation of MSDN subscriptions at the root Management Group scope

***Design Recommendations***

- Treat subscriptions as a democratised unit of management aligned with business needs and priorities

- Make subscription owners aware of their roles and responsibility, which are as follow:

    - Perform an access review in AAD PIM, either quarterly or twice a year, to ensure there is no proliferation of privileges as users move within the customer organization.

    - Take full ownership of budget spending and resource utilization.

    - Ensure policy compliance and perform remediation when required.

- Use the following principals when identifying requirements for new subscriptions

    - **Scale limits** – Subscriptions serve as a scale unit so that component workloads are able to scale within platform subscription limits. For example, large specialized workloads such as HPC, IoT or SAP are better suited to separate subscriptions to avoid limits (e.g. there is a limit of 50 ADF integrations).

    - **Management Boundary** – Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns. For example, different environments such as development, test and production are often isolated from a management perspective.

    - **Policy Boundary** – Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance, and this additional overhead does not need considered holistically if a separate subscription is used. Similarly, development environments may have more relaxed policy requirements relative to production environments.

    - **Target Network Topology** – Virtual Networks cannot be shared across subscriptions, but they can be connected using different technologies, such as Virtual Network peering or ExpressRoute. Hence, it is important to consider network composition and which workloads must communicate with one another when deciding if a new subscription is required.

- Group subscriptions under Management Groups aligned within the Management group structure and policy requirements at scale.

- Establish a dedicated “Management” Subscription within the top-level/root Management Group to support global management capabilities such as Log Analytics workspaces, automation runbooks, and custom RBAC definitions.

<!-- -->

- Avoid prescriptive and rigid subscription models, opting instead for a set of criteria to flexibly structuring subscriptions across the organisation, ensuring that as new workloads and business units are considered, subscriptions do not become limiting.

    - One size does not fit all for subscriptions; what works for one business unit may not work for another. Some applications may coexist within the same “landing zone” subscription while others may require their own subscription(s).

## 3. Configure Subscription Quota and Capacity

Azure is ultimately comprised of a finite set of resources, so when considering enterprise scale Azure adoption involving large resource quantities, it is essential that attention be given to ensure sufficient capacity and SKUs are available, and that attained capacity can be understood and monitored.

***Design Considerations***

- Platform limits and quotas within the Azure platform for services.

- Availability of required SKUs within chosen Azure regions.

- Subscription quotas are not capacity guarantees and are applied on a per region basis.

***Design Recommendations***

- Leverage subscriptions as scale units, scaling out resources and subscriptions as required.

- Use reserved instances to prioritize reserved capacity in required regions.

- Establish a dashboard with custom views to monitor utilized capacity levels. Setup alerts if capacity utilization is reaching critical levels (e.g. 90% CPU utilization).

- Raise support requests for quota increase as a part of subscription provisioning (e.g. total available VM cores within a subscription).

- Ensure required services and features are available within the chosen deployment regions.

## 4. Establish Cost Management

Cost transparency across a technical estate is a critical management challenge faced by every large enterprise organization. This section will there explore key aspects associated with how cost transparency can be achieved across large Azure environments.

***Design Considerations***

- Potential need for chargeback models where shared PaaS services are concerned, such as ASE and AKS which may need to be shared to achieve higher density.

- Shutdown schedule for non-prod workloads to optimise costs.

- Azure Advisor provides cost optimisation recommendations.

***Design Recommendations***

- Use Azure Cost Management for the first level of aggregation and make it available to application owners.

- Use Azure Resource Tags for cost categorization and resource grouping, aligning with subscription isolation for effective chargeback calculations.

## Next steps

Suggested design for [Network Topology and Connectivity](./D-Network-Topology-and-Connectivity.md)

> [!div class="nextstepaction"]
> [Network Topology and Connectivity](./D-Network-Topology-and-Connectivity.md)