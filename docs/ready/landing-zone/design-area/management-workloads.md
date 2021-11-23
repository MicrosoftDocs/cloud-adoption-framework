---
title: Azure management - workloads
description: Design area guidance for workloads in an Azure landing zone
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Management - workloads

To expand on the previous section, this section will consider a federated model and explain how workload teams can operationally maintain these workloads

## Workload management and monitoring - design considerations

- Workload monitoring can use dedicated Log Analytics workspaces.
- For workloads that are deployed to virtual machines, logs should be stored centrally to the dedicated Log Analytics workspace from a platform perspective. Workload teams can access the logs subject to the Azure RBAC they have on their workloads or virtual machines.
- Workload performance and health monitoring for both infrastructure as a service (IaaS) and platform as a service (PaaS) resources.
- Data aggregation across all workload components.
- [Health modeling and operationalization](/manage/monitor/cloud-models-monitor-overview.md):
  - How to measure the health of the workload and its subsystems
  - A traffic-light model to represent health
  - How to respond to failures across workload components

## Workload management and monitoring recommendations

- Use a centralized Azure Monitor Log Analytics workspace to collect logs and metrics from IaaS and PaaS workload resources and [control log access with Azure RBAC](/azure/azure-monitor/platform/design-logs-deployment#access-control-overview).
- Use [Azure Monitor Metrics](/azure/azure-monitor/platform/data-platform-metrics) for time-sensitive analysis. Metrics in Azure Monitor are stored in a time-series database optimized to analyze time-stamped data. These metrics are well suited for alerts and detecting issues quickly. They can also tell you how your system is performing. They typically need to be combined with logs to identify the root cause of issues.
- Use [Azure Monitor Logs](/azure/azure-monitor/platform/data-platform-logs) for insights and reporting. Logs contain different types of data that's organized into records with different sets of properties. They're useful for analyzing complex data from a range of sources, such as performance data, events, and traces.
- When necessary, use shared storage accounts within the landing zone for Azure diagnostic extension log storage.
- Use [Azure Monitor alerts](/azure/azure-monitor/platform/alerts-overview) for the generation of operational alerts. Azure Monitor alerts unify alerts for metrics and logs and use features such as action and smart groups for advanced management and remediation purposes.

## Azure Well-Architected Framework

For further information on considerations for workload-specific management, review the [operational excellence](/azure/architecture/framework/#operational-excellence) of the Azure Well-Architected Framework
