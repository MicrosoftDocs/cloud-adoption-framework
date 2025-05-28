---
title: Approaches to digital estate planning
description: Understand the characteristics and requirements of top-down workload-driven, asset-driven, or incremental approaches to digital estate planning.
author: Zimmergren
ms.author: pnp
ms.date: 08/29/2022
ms.topic: conceptual
ms.custom: internal
---

# Approaches to digital estate planning

Digital estate planning takes several forms depending on the desired outcomes and size of the existing estate. There are various approaches that you can take. It's important to set expectations regarding the approach early in planning cycles. Unclear expectations often lead to delays associated with other inventory-gathering exercises. This article outlines three approaches to analysis.

## Workload-driven approach

The top-down assessment approach evaluates security aspects. Security includes data categorization (high, medium, or low business impact), compliance, sovereignty, and security risk requirements. This approach assesses high-level architectural complexity. It evaluates aspects such as authentication, data structure, latency requirements, dependencies, and application life expectancy.

The top-down approach measures the operational requirements of the application, such as service levels, integration, maintenance windows, monitoring, and insight. When these aspects have been analyzed and considered, the resulting score reflects the relative difficulty of migrating this application to each cloud platform: IaaS, PaaS, and SaaS.

The top-down assessment evaluates the financial benefits of the application, such as operational efficiencies, TCO, return on investment, and other appropriate financial metrics. The assessment also examines the seasonality of the application (such as whether there are certain times of the year when demand spikes) and overall compute load.

It also looks at the types of users it supports (casual or expert, always or occasionally logged on), and the required scalability and elasticity. Finally, the assessment concludes by examining business continuity and resiliency requirements, and dependencies for running the application if a disruption of service should occur.

> [!TIP]
> The workload-driven approach requires interviews and anecdotal feedback from business and technical stakeholders. Availability of key individuals is the biggest risk to timing. The anecdotal nature of the data sources makes it more difficult to produce accurate cost or timing estimates. Plan schedules in advance and validate any data that's collected.

## Asset-driven approach

The asset-driven approach provides a plan based on the assets that support an application for migration. In this approach, you pull statistical usage data from a configuration management database (CMDB) or other infrastructure assessment tools.

This approach usually assumes an IaaS model of deployment as a baseline. In this process, the analysis evaluates the attributes of each asset:

- Memory
- Number of processors (CPU cores)
- Operating system storage space
- Data drives
- Network interface cards (NICs)
- IPv6
- Network load balancing
- Clustering
- Operating system version
- Database version (if necessary)
- Supported domains
- Third-party components or software packages, among others

The assets that you inventory in this approach are then aligned with workloads or applications for grouping and dependency mapping purposes.

> [!TIP]
> The asset-driven approach requires a rich source of statistical usage data. The time that's needed to scan the inventory and collect data is the biggest risk to timing. The low-level data sources can miss dependencies between assets or applications. Plan for at least one month to scan the inventory. Validate dependencies before deployment.

## Incremental approach

We strongly suggest an incremental approach, as we do for many processes in the Cloud Adoption Framework. With digital estate planning, that equates to a multiphase process:

- **Initial cost analysis:** If you require financial validation, start with an asset-driven approach, described earlier, to get an initial cost calculation for the entire digital estate, with no rationalization. This approach establishes a worst-case scenario benchmark.

- **Migration planning:** After you've assembled a cloud strategy team, build an initial migration backlog using a workload-driven approach that's based on their collective knowledge and limited stakeholder interviews. This approach quickly builds a lightweight workload assessment to foster collaboration.

- **Release planning:** At each release, prune and reprioritize the migration backlog to focus on the most relevant business impact. During this process, you select the next 5 to 10 workloads as prioritized releases. At this point, the cloud strategy team invests the time in completing an exhaustive workload-driven approach. Delaying this assessment until a release better respects the time of stakeholders. It also delays the investment in full analysis until the business starts to see results from earlier efforts.

- **Implementation analysis:** Before migrating, modernizing, or replicating any asset, assess it both individually and as part of a collective release. At this point, you can scrutinize the data from the initial asset-driven approach to ensure accurate sizing and operational constraints.

> [!TIP]
> The incremental approach enables streamlined planning and accelerated results. It's important that all parties involved understand the approach to delayed decision making. It's equally important that assumptions made at each stage be documented to avoid loss of details.

## Next steps

After you choose an approach, gather the inventory data.

> [!div class="nextstepaction"]
> [Gather inventory data](./inventory.md)
