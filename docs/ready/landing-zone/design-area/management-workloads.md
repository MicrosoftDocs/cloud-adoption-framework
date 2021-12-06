---
title: Azure workload management and monitoring
description: Get design area guidance for managing and monitoring workloads in an Azure landing zone.
author: DominicAllen
ms.author: doalle
ms.date: 12/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Workload management and monitoring

This guidance considers a federated model to explain how workload teams can operationally maintain their workloads.

## Workload management and monitoring design considerations

Consider the following factors when planning for workload management and monitoring:

- Workload monitoring with dedicated Azure Monitor Log Analytics workspaces.

  For workloads that are deployed to virtual machines (VMs), store logs relative to dedicated Log Analytics workspaces. Workload teams can access the logs according to their Azure role-based access control (RBAC) roles on their workloads or VMs.

- Workload performance and health monitoring for both infrastructure-as-a-service (IaaS) and platform as a service (PaaS) resources.

- Data aggregation across all workload components.

- [Health modeling and operationalization](../../../manage/monitor/cloud-models-monitor-overview.md):

  - How to measure the health of the workload and its subsystems.
  - A traffic-light model to represent health.
  - How to respond to failures across workload components.

## Workload management and monitoring recommendations

- Use a centralized Log Analytics workspace to collect logs and metrics from IaaS and PaaS workload resources.

- Control workspace and log access with [Azure RBAC](/azure/azure-monitor/platform/design-logs-deployment#access-control-overview).

- Use [Azure Monitor Metrics](/azure/azure-monitor/platform/data-platform-metrics) for time-sensitive analysis.

  Azure Monitor stores metrics in a time-series database optimized to analyze time-stamped data. Metrics are well-suited for alerts and detecting issues quickly. Metrics can also tell you how your system is performing. You can combine metrics with logs to identify the root causes of issues.

- Use [Azure Monitor Logs](/azure/azure-monitor/platform/data-platform-logs) for insights and reporting.

  Logs contain different types of data organized into records with different sets of properties. Logs are useful for analyzing complex data from a range of sources, such as performance data, events, and traces. Use shared storage accounts in the landing zone for Azure diagnostic extension log storage if necessary.

- Use [Azure Monitor alerts](/azure/azure-monitor/platform/alerts-overview) for generating operational alerts. Azure Monitor Alerts unifies metric and log alerts, and uses features like actions and smart groups for advanced management and remediation.

## Next steps

For more considerations about workload-specific management, see [Operational excellence](/azure/architecture/framework/#operational-excellence) in the Azure Well-Architected Framework.
