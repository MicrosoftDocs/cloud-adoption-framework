---
title: Manage and monitor Oracle Database@Azure
description: Learn about considerations and recommendations that you can use to manage and monitor your Oracle Database@Azure and Exadata Database services.
author: AnthonyDelagarde
ms.author: anthdela
ms.reviewer: janfaurs
ms.date: 08/01/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Manage and monitor Oracle Database@Azure

This article provides business practices that you can implement to manage and monitor Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure. Implement these considerations when you create your overall design and when you onboard this service within your Azure enterprise landing zone.

## Design considerations

Consider these key topics before you deploy Oracle Database@Azure and Exadata Database services.

- Identify the Azure region where you want to deploy your Oracle Database@Azure and Exadata Database services. Ensure that this region aligns with your current or future Azure landing zone. If the region that you choose differs from your current deployment region, assess whether your existing monitoring tools can extend their capabilities to this new region. Ensure seamless integration and functionality across regions.

- Choose a network topology that best supports your migration method of choice when you create your network plan. Your migration method should monitor the process when you move your critical data. Options for migration include Oracle Recovery Manager, Oracle Data Guard, Oracle Data Pump, or a Linux VM that has the Network File System role installed. Consult with your Oracle and Microsoft representative for detailed guidance.
- Determine how to integrate monitor alerts into your triage process.
- Make a list of key stakeholders that you need to notify when an alert is triggered.
- Review monitoring metrics with database administrators to align expectations.

For more information, see [Plan for Oracle on Azure adoption](/azure/cloud-adoption-framework/scenarios/oracle-on-azure/oracle-landing-zone-plan).

## Design recommendations

Consider these recommendations before you deploy Oracle Database@Azure and Exadata Database services.

### Monitor for health and performance

You should collect quantitative metrics such as CPU usage, memory usage, storage usage, database operations, SQL queries, and overall transactions. You can use Azure Monitor metrics, or your monitoring tool of choice, to diagnose and proactively troubleshoot problems. The collection and review of database metrics helps to ensure operational readiness and long-term sustainment.

- Create a custom dashboard in the Azure portal with an aggregated view of the various metrics collected. For more information, see [Create a dashboard in the Azure portal](/azure/azure-portal/azure-portal-dashboards).

- To review the required roles, see [Roles, permissions, and security in Azure Monitor](/azure/azure-monitor/roles-permissions-security).
- If you require granular database monitoring, see [Enterprise Manager database management](https://www.oracle.com/database/technologies/manageability.html).
- For information about the Oracle comprehensive monitoring guide, see [Oracle Cloud database metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html).

### Monitor key metrics

The following table contains initial recommended settings for Oracle Cloud Database metrics. You can add counters based on your organization's needs. Set each monitoring setting against all the available nodes in the cluster. In Azure Monitor, you can't select multiple objects at the same time when you add metrics. To enter specified settings, you must select each Exadata cluster node.

Set alerts in your monitoring solution for critical workloads. If you use Azure Monitor, you can create [action groups](/azure/azure-monitor/alerts/action-groups).

|  Metric name                                   |  Collection frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| CPU Utilization                                        | 5 minutes                                               | 90%                           | The CPU usage that's expressed as a percentage and aggregated across all consumer groups. The usage percentage is reported with respect to the number of CPUs that the database can use, which is two times the number of Oracle CPUs. This setting is for each database within the cluster. |
| Storage Utilization                                    | 30 minutes                                              | 90%                            | The percentage of provisioned storage capacity that's in use. This setting represents the total allocated space for all tablespaces. This setting is for each database within the cluster.|
| Flash Recovery Area Utilization                        | 15 minutes                                              | 90%                            | The flash recovery area usage.    |
| Memory Usage                                           | 15 minutes                                              | Megabit  90% consumed             | The total size of the memory pool.      |
| Process Limit Utilization                             |   5 minutes                                             | 90%                            | The process limit usage.          |
| Session Limit Utilization                              |   5 minutes                                             | 90%                            | The database session limit usage. |
| Usable Fast Recovery Area                              | 15 minutes                                              | 90%                            | The usable fast recovery area.          |
| Oracle Cloud Infrastructure (OCI) Database Cluster Memory Utilization                | 5 minutes                                               | 90%                            | The amount of memory that the Exadata Database clusters consume. |
| Average Node Status                                    | 5 minutes                                               | 0 (this dimension means false) | Whether the Exadata Database cluster node within the cluster is available or unavailable. |

For more information, see [Oracle Cloud Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics).

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
