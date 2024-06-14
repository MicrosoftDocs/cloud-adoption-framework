---
title: Manage and Monitor Oracle Database@Azure, Exadata Database services 
description: Learn how to manage and monitor your Oracle Database@Azure, Exadata Database services.
author: AnthonyDelagarde
ms.author: anthdela
ms.reviewer: janfaurs
ms.date: 05/30/2024
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Manage and Monitor Oracle Database@Azure, Exadata Database services

This article provides recommended business practices to manage and monitor Oracle Database@Azure, Exadata Database services. The recommendations outlined provide important recommendations and considerations for the overall design and onboarding of this service within your Azure Enterprise Landing Zone. There is more recommended design, platform management, and guidance in the following article [Azure enterprise-scale landing zone for management and monitoring](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management). The intent of this article is to provide the reader with the required steps to proactively monitor mission critical workloads to promote both a stable and reliable digital estate.

Other guidance that should also be reviewed is covered within the [Azure Well-Architected Framework - Microsoft Azure Well-Architected Framework | Microsoft Learn](/azure/well-architected/) and [Assessments | Azure Well-Architected Review (microsoft.com)](/assessments/azure-architecture-review/) which are recommended for review when establishing your Azure Enterprise Landing Zone.

## Design considerations

To manage and monitor your Azure landing zone, Microsoft Azure provides various tools and services including Azure Monitor, Azure Advisor, and Azure Service Health. These tools can alert system owners of potential irregularities and bottlenecks within an Azure Landing Zone. The focus of this article is on using Azure Monitor to achieve a stable Oracle Database@Azure, Exadata Database services implementation. Review the following documentation to learn more about Azure Monitor [Azure Monitor documentation - Azure Monitor | Microsoft Learn](/azure/azure-monitor/).

The following are key topics to consider before deploying Oracle Database@Azure, Exadata Database services:

- In which Azure datacenter will you deploy your Oracle Exadata databases in relation to your current or planned Azure enterprise landing zone. Can your current monitor tooling of choice be able to extend into your region of choice.
- Network planning has to be taken into consideration before you deploy your resources. When you deploy your Oracle resources, you have the choice of a single virtual network or a Hub and Spoke architecture with hybrid connectivity.Please note that Oracle Exadata database resources are deployed to a private subnet that isn't accessible from the internet. If your current enterprise monitoring solution is on-premises, you'll need to account for the connectivity.
- The subnets that the Oracle Exadata database clusters are deployed within a virtual network and are delegated subnets, which have constraints. For more information, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#constraints).
- As part of your networking planning, you need to take into consideration the topology that best supports your migration method of choice. Your choice should also monitor the process while moving your critical data.
- Review with the database administrators the monitoring metrics selected of your chosen solution to align expectations.
- Once a monitoring alert is received for your Oracle workload decide how to integrate it into your current triage process.
- Identify if there are other key stakeholders that need to be included once an alert is triggered.

For additional design considerations, see [Plan for Oracle on Azure adoption - Cloud Adoption Framework | Microsoft Learn](/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-landing-zone-plan).

## Design recommendations

#### Health Monitoring Metric Enablement

The metrics for Oracle Exadata database help measure useful quantitative data, such as CPU, memory utilization, storage utilization, database operations, SQL queries, and transactions. You can use the Azure Monitor metrics to diagnose and proactively troubleshoot issues. The database metrics are for operational readiness and long-term sustainment. 

An Azure administrator can create a custom dashboard in the Azure portal with an aggregated view of the various metrics collected. Details on how to create a custom dashboard can be found in this article [Create a dashboard in the Azure portal - Azure portal | Microsoft Learn](/azure/azure-portal/azure-portal-dashboards).

As part of your design considerations review the following article to understand the required roles [Roles, permissions, and security in Azure Monitor - Azure Monitor | Microsoft Learn](/azure/azure-monitor/roles-permissions-security). 

Note at the time of writing of this article the telemetry provided by Azure Monitor can provide adequate monitoring, but if you require granular database monitoring we recommend that you review Oracle documentaion [Enterprise Manager Database Management](https://www.oracle.com/database/technologies/manageability.html). Oracle has a comprehensive monitoring guide for review in this article [Oracle Cloud Database Metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html). This article focuses on monitoring and management with Azure based tooling.

#### Key Metric Monitoring

Below here are the initial recommended settings and other counters can be added based on your enterprise needs.  Ensure you to set the following monitoring settings against all the available nodes in the cluster. Azure Monitor doesn't allow at the time of writing of this article to select multiple objects at the same time when adding metrics. You will have to select each Exadata cluster node with the specified settings. 

The recommendation is to have alerts with your monitoring solution of choice for critical workloads. If you leverage Azure Monitor see [Azure Monitor action groups - Azure Monitor | Microsoft Learn](/azure/azure-monitor/alerts/action-groups).



|  Metric Display Name                                   |  Collection Frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| CPU Utilization                                        | 5 Minutes                                               | 90%                           | The CPU utilization expressed as a percentage, aggregated across all consumer groups. The utilization percentage is reported with respect to the number of CPUs the database is allowed to use, which is two times the number of OCPUs. This setting is per database within the cluster. |
| Storage Utilization                                    | 30 Minutes                                              | 90%                            | The percentage of provisioned storage capacity currently in use. Represents the total allocated space for all tablespaces. This setting is per database within the cluster.|
| Flash Recovery Area Utilization                        | 15 Minutes                                              | 90%                            | The flash recovery area utilization    |
| Memory Usage                                           | 15 Minutes                                              | Mbit  90% consumed             | The total size of the memory pool      |
| Process Limit Utilization                              |   5 Minutes                                             | 90%                            | The process limit utilization          |
| Session Limit Utilization                              |   5 Minutes                                             | 90%                            | The database session limit utilization |
| Usable Fast Recovery Area                              | 15 Minutes                                              | 90%                            | The usable fast recovery area          |
| OCI Database Cluster Memory Utilization                | 5 Minutes                                               | 90%                            | Amount of Memory the Exadata database clusters are consuming |
| Average Node Status                                    | 5 Minutes                                               | 0 (this dimension means false) | Evaluate if the  Exadata database cluster node within the cluster is available or unavailable. The setting should be set against each node |

For detailed information and key metrics to monitor Oracle Exadata can be found in the following article [Oracle Cloud Database Metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html)




