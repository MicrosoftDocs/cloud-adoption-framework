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

# C. Management group and subscription organization

![Management group hierarchy](./media/sub-org.png)
_Figure 5: Management group hierarchy_

## 1. Define management group hierarchy

Within a Microsoft Azure Active Directory (AD) tenant, management group structures help to support organizational mapping and must be considered when planning Azure adoption at scale.

**Design considerations:**

- Management groups can be used to aggregate policy and initiative assignments.

- There is a limit of seven levels in any nested management group structure.

**Design recommendations:**

- Keep the management group hierarchy reasonably flat with no more than three to four levels.

- Use resource tags, which can be enforced or appended through Azure Policy to query and horizontally navigate across the management group tree. This approach is more flexible than using a rigid vertical management group and subscription hierarchy.

- Create a top-level "sandboxes" management group to allow users to experiment with Azure immediately. Place user-based test subscriptions within this "sandbox" management group and apply requisite security policies to keep these sandbox subscriptions isolated and disconnected from dev/test/prod environments.

- Assign the user access administrator Azure AD role at root management group scope (/) to allow access assignments and resource visibility in any subscription or management group in the directory.

- Establish a dedicated "management" subscription within the top-level/root management group to support global management capabilities such as Log Analytics workspaces, automation runbooks, and custom role-based access control definitions.

- Limit the number of Azure Policy assignments made at the root management group scope to avoid managing through exclusions at inherited scopes.

<!-- -->

- Do not transpose the organizational structure into a deeply nested management group hierarchy.

- Do not create any subscriptions under the "root" management group.

## 2. Subscription organization and governance

Subscriptions are a unit of management and scale within Azure and play a critical role when designing for large-scale Azure adoption. This section strives to help readers capture customer subscription requirements and design target subscriptions based on critical factors, such as environment type, ownership and governance model, organizational structure, and application portfolios.

**Design considerations:**

- Subscriptions serve as a policy boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance, and this additional overhead does not need considered holistically if a separate subscription is used.

- Subscriptions serve as a scale unit so that component workloads can scale within platform [subscription limits](/azure/azure-subscription-service-limits).

- Subscriptions provide a management boundary for governance and isolation, allowing clearly separated concerns.

- There is a manual process (planned future automation) which can be conducted to limit an Azure AD tenant to only consider enterprise enrollment subscriptions. This prevents the creation of Visual Studio subscriptions at the root management group scope.

**Design recommendations:**

- Treat subscriptions as a democratized units of management aligned with business needs and priorities.

- Make subscription owners aware of their roles and responsibilities:

  - Either quarterly or twice a year, perform an access review in Azure AD Privileged Identity Management to ensure that privileges don't multiply as users move within the customer organization.

    - Take full ownership of budget spending and resource utilization.

    - Ensure policy compliance and perform remediation when required.

- Use the following principles when identifying requirements for new subscriptions:

  - **Scale limits:** Subscriptions serve as a scale unit so that component workloads are able to scale within platform subscription limits. For example, large specialized workloads such as hpc, IoT or SAP are better suited to separate subscriptions to avoid limits (e.g., there is a limit of 50 adf integrations).

  - **Management boundary:** Subscriptions provide a management boundary for governance and isolation, allowing for a clear separation of concerns. For example, different environments such as development, test, and production are often isolated from a management perspective.

    - **Policy boundary:** Subscriptions serve as a boundary for the assignment of Azure policies. For example, secure workloads such as PCI typically require additional policies to achieve compliance, and this additional overhead does not need considered holistically if a separate subscription is used. Similarly, development environments may have more relaxed policy requirements relative to production environments.

    - **Target network topology** Virtual networks can't be shared across subscriptions, but they can be connected using different technologies such as virtual network peering or ExpressRoute. It is important to consider network composition and which workloads must communicate with one another when deciding if a new subscription is required.

- Group subscriptions under management groups aligned within the management group structure and policy requirements at scale.

- Establish a dedicated "management" subscription within the top-level/root management group to support global management capabilities such as Log Analytics workspaces, automation runbooks, and custom role-based access control definitions.

<!-- -->

- To keep subscriptions from becoming limiting while new workloads and business units are evaluated, avoid prescriptive and rigid subscription models and opt for a set of criteria to flexibly structure subscriptions across the organization. 

  - One size does not fit all for subscriptions; what works for one business unit may not work for another. Some applications may coexist within the same "landing zone" subscription while others may require their own subscriptions.

## 3. Configure subscription quota and capacity

Since Azure is comprised of a finite set of resources, it's critical to ensure sufficient capacity and SKUs and to understand and monitor attained capacity when considering enterprise-scale Azure adoption with large resource quantities. 

**Design considerations:**

- Platform limits and quotas within the Azure platform for services

- Availability of required SKUs within chosen Azure regions

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

- They may be a potential need for chargeback models such as Azure App Service Environment and Azure Kubernetes Service where shared PaaS services are concerned; they may need to be shared to achieve higher density.

- Shut down the schedule for nonproduction workloads to optimize costs.

- Azure Advisor provides cost optimization recommendations.

**Design recommendations:**

- Use Azure Cost Management for the first level of aggregation and make it available to application owners.

- Use Azure resource tags to categorize costs, group resources, and aligning with subscription isolation for effective chargeback calculations.

## Next steps

Suggested design for [network topology and connectivity](./d-network-topology-and-connectivity.md).

> [!div class="nextstepaction"]
> [Network topology and connectivity](./d-network-topology-and-connectivity.md)
