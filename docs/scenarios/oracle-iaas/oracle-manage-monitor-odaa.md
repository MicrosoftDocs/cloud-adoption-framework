---
title: Management and monitoring considerations for Oracle Database@Azure
description: Learn about considerations and recommendations that you can use to manage and monitor your Oracle Database@Azure and Exadata Database services.
author: AnthonyDelagarde
ms.author: anthdela
ms.reviewer: janfaurs
ms.date: 08/01/2024
ms.topic: conceptual
---

# Management and monitoring considerations for Oracle Database@Azure

This article provides business practices that you can implement to manage and monitor Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure. Implement these considerations when you create your overall design and when you onboard this service within your Azure enterprise landing zone.

## Design considerations

Consider these key topics before you deploy Oracle Database@Azure and Exadata Database services:

- Identify the Azure region where you want to deploy your Oracle Database@Azure and Exadata Database services. Ensure that this region aligns with your current or future Azure landing zone. If the region that you choose differs from your current deployment region, assess whether your existing monitoring tools can extend their capabilities to this new region. Ensure seamless integration and functionality across regions.

- Consider your network plan before you deploy your resources. You deploy Oracle Exadata Database resources to a private subnet that isn't accessible from either on-premises or spoke virtual networks without deploying a network virtual appliance (NVA). An NVA isn't a traditional firewall. An NVA is a Linux virtual machine (VM) with a user-defined route that provides the next hop IP address and custom *iptables*. You must deploy iptables if you have an on-premises enterprise monitoring solution.
- The subnets that you deploy within a virtual network and that are associated with Oracle Exadata Database clusters are delegated private subnets. Delegated subnets don't allow network communication outside of the virtual network without deploying an NVA. For more information, see [Network planning](/azure/oracle/oracle-db/oracle-database-network-plan#constraints).
- Choose the network topology that best supports your migration method of choice when you create your network plan. Your migration method should monitor the process when you move your critical data. Options for migration include Oracle Recover Manager, Oracle Data Guard, Oracle Data Pump, or a Linux VM with the Network File System role installed. Consult with your Oracle and Microsoft representative for detailed guidance.
- Determine how to integrate monitor alerts into your current triage process.
- Make a list of key stakeholders that you need to notify when an alert is triggered.
- Review monitoring metrics with database administrators to align expectations.

For more information, see [Plan for Oracle on Azure adoption](/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-landing-zone-plan).

## Design recommendations

### Monitor for health and performance

You should collect quantitative metrics such as CPU usage, memory usage, storage usage, database operations, SQL queries, and overall transactions. You can use Azure Monitor metrics, or your monitoring tool of choice, to diagnose and proactively troubleshoot problems. The collection and review of database metrics helps to ensure operational readiness and long-term sustainment.

- Create a custom dashboard in the Azure portal with an aggregated view of the various metrics collected. For more information, see [Create a dashboard in the Azure portal](/azure/azure-portal/azure-portal-dashboards).

- To review the required roles, see [Roles, permissions, and security in Azure Monitor](/azure/azure-monitor/roles-permissions-security).
- If you require granular database monitoring, see [Enterprise Manager Database Management](https://www.oracle.com/database/technologies/manageability.html).
- For information about the Oracle comprehensive monitoring guide, see [Oracle Cloud Database metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html).

### Key metric monitoring

The following table contains initial recommended settings. Add counters based on your enterprise needs. Set each monitoring setting against all the available nodes in the cluster. Azure Monitor doesn't allow you to select multiple objects at the same time when you add metrics. You must select each Exadata cluster node to enter specified settings.

Set alerts in your monitoring solution for critical workloads. If you use Azure Monitor, see [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups) to set alerts.

|  Metric display name                                   |  Collection frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| CPU usage                                        | 5 minutes                                               | 90%                           | The CPU usage expressed as a percentage, aggregated across all consumer groups. The usage percentage is reported with respect to the number of CPUs the database is allowed to use, which is two times the number of Oracle CPUs. This setting is for each database within the cluster. |
| Storage usage                                    | 30 Minutes                                              | 90%                            | The percentage of provisioned storage capacity that's currently in use. Represents the total allocated space for all tablespaces. This setting is for each database within the cluster.|
| Flash recovery area usage                        | 15 minutes                                              | 90%                            | The flash recovery area usage.    |
| Memory usage                                           | 15 minutes                                              | Mbit  90% consumed             | The total size of the memory pool.      |
| Process limit usage                              |   5 minutes                                             | 90%                            | The process limit usage.          |
| Session limit usage                              |   5 minutes                                             | 90%                            | The database session limit usage. |
| Usable fast recovery area                              | 15 minutes                                              | 90%                            | The usable fast recovery area.          |
| Oracle Cloud Infrastructure (OCI) Database cluster memory usage                | 5 minutes                                               | 90%                            | The amount of memory the Exadata Database clusters are consuming. |
| Average node status                                    | 5 Minutes                                               | 0 (this dimension means false) | Evaluate if the Exadata Database cluster node within the cluster is available or unavailable. |

For more information, see [Oracle Cloud Database metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html).

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
