---
title: Manage and monitor Oracle Exadata Database Services with Oracle Database@Azure
description: Learn how to manage and monitor your Oracle Database@Azure, Exadata Database services.
author: AnthonyDelagarde
ms.author: anthdela
ms.reviewer: janfaurs
ms.date: 07/30/2024
ms.topic: conceptual
---

# Manage and monitor Oracle Database@Azure, Exadata Database services

This article provides recommended business practices to manage and monitor Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure. The recommendations outlined provide important considerations for the overall design and onboarding of this service within your Azure Enterprise Landing Zone.

## Design considerations

Consider these key topics before deploying Oracle Database@Azure, Exadata Database services:

- Identify the Azure region where you want to deploy your Oracle Database@Azure and Exadata Database services. Ensure this region aligns with your current or planned Azure landing zone. If the chosen region differs from your current deployment, assess whether your existing monitoring tools can extend their capabilities to this new region. Ensure seamless integration and functionality across regions.
- Consider network planning before you deploy your resources. Oracle Exadata database resources are deployed to a private subnet that isn't accessible from either on-premises or other spoke virtual networks without deploying a Network Virtual Appliance (NVA). The NVA isn't a traditional firewall. The NVA is a Linux virtual machine with a user defined route (UDR) that provides the next hop IP address and custom Iptables that you must deploy if your current enterprise monitoring solution is on-premises.
- Oracle Exadata database clusters subnets that are deployed within a virtual network and are delegated private subnets. Delegated subnets currently don't allow network communication outside of the virtual network without deploying an NVA. For more information, see [Network planning for Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#constraints).
- As part of your networking planning, you need to take into consideration the topology that best supports your migration method of choice from on-premises. Your choice should also monitor the process while moving your critical data. Current options in migration are Oracle's RMAN, a Linux virtual machine with the NFS role installed, Oracle Dataguard, and Oracle's Data Pump. Please consult with your Oracle and Microsoft representative for detailed guidance.
- Determine how to integrate monitor alerts into your current triage process.
- Make a list of key stakeholders that you need to notify when an alert is triggered.
- Review with the database administrators the monitoring metrics selected of your chosen solution to align expectations.

For additional design considerations, see [Plan for Oracle on Azure adoption](/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-landing-zone-plan).

## Design recommendations

### Monitor for health and performance

You should collect quantitative metrics such as CPU use, memory utilization, storage utilization, database operations, SQL queries, and overall transactions. You can use Azure Monitor metrics, or your monitoring tool of choice, to diagnose and proactively troubleshoot issues. The collection and review of database metrics helps to ensure operational readiness and long-term sustainment.

- Create a custom dashboard in the Azure portal with an aggregated view of the various metrics collected. For more information on how to create a custom dashboard, see [Create a dashboard in the Azure portal](/azure/azure-portal/azure-portal-dashboards).
- To review the required roles, see [Roles, permissions, and security in Azure Monitor](/azure/azure-monitor/roles-permissions-security).
- If you require granular database monitoring, see [Enterprise Manager Database Management](https://www.oracle.com/database/technologies/manageability.html).
- For information on the Oracle comprehensive monitoring guide, see [Oracle Cloud Database Metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html).

### Key metric monitoring

The following table contains initial recommended settings. Add counters based on your enterprise needs. Set each monitoring setting against all the available nodes in the cluster. Azure Monitor doesn't allow you to select multiple objects at the same time when adding metrics. You'll need to select each Exadata cluster node to enter specified settings.

Set alerts in your monitoring solution for critical workloads. If you use Azure Monitor, see [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups) to set alerts.

|  Metric Display Name                                   |  Collection Frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| CPU Utilization                                        | 5 Minutes                                               | 90%                           | The CPU utilization expressed as a percentage, aggregated across all consumer groups. The utilization percentage is reported with respect to the number of CPUs the database is allowed to use, which is two times the number of OCPUs. This setting is per database within the cluster. |
| Storage Utilization                                    | 30 Minutes                                              | 90%                            | The percentage of provisioned storage capacity currently in use. Represents the total allocated space for all tablespaces. This setting is per database within the cluster.|
| Flash Recovery Area Utilization                        | 15 Minutes                                              | 90%                            | The flash recovery area utilization.    |
| Memory Usage                                           | 15 Minutes                                              | Mbit  90% consumed             | The total size of the memory pool.      |
| Process Limit Utilization                              |   5 Minutes                                             | 90%                            | The process limit utilization.          |
| Session Limit Utilization                              |   5 Minutes                                             | 90%                            | The database session limit utilization. |
| Usable Fast Recovery Area                              | 15 Minutes                                              | 90%                            | The usable fast recovery area.          |
| OCI Database Cluster Memory Utilization                | 5 Minutes                                               | 90%                            | The amount of memory the Exadata Database clusters are consuming. |
| Average Node Status                                    | 5 Minutes                                               | 0 (this dimension means false) | Evaluate if the Exadata Database cluster node within the cluster is available or unavailable. |

For detailed information about key metrics to monitor Oracle Exadata, see [Oracle Cloud Database Metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html).

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
