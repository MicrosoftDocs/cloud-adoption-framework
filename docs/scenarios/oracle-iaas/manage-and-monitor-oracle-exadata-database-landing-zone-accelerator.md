---
title: Manage and Monitor Oracle Exadata Database Landing Zone Accelerator 
description: Learn how to manage and monitor your Exadata Database for Oracle Database@Azure.
author: anthdela
ms.author: anthdela
ms.reviewer: janfaurs
ms.date: 05/30/2024
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Manage and Monitor Oracle Exadata Database Landing Zone Accelerator 

This article provides recommended business practices to manage and monitor Oracle Exadata Database on Azure. The recommendations outlined provide important recommendations and considerations for the overall design and onboarding of this service within your Azure Enterprise Landing Zone. There are additional recommended design, platform management, and guidance in the following article [Azure enterprise-scale landing zone for management and monitoring](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/management). The intent of this article is to provide the reader with the required steps to proactively monitor mission critical workloads to promote both a stable and reliable digital estate.

Other guidance that should also be reviewed is covered within the [Azure Well-Architected Framework - Microsoft Azure Well-Architected Framework | Microsoft Learn](https://learn.microsoft.com/azure/well-architected/) and [Assessments | Azure Well-Architected Review (microsoft.com)](https://learn.microsoft.com/assessments/azure-architecture-review/) which are recommended for review when establishing your Azure Enterprise Landing Zone.

## Design considerations

To manage and monitor Oracle Exadata databases, Microsoft Azure provide various tools and services including Azure Monitor, Azure Advisor, and Azure Service Health to alert system owners of potential irregularities and bottlenecks within an Azure Landing Zone. The focus of this article will focus on leveraging Azure Monitor. Please review the following documentation to learn more about Azure Monitor found here [Azure Monitor documentation - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/azure/azure-monitor/). This article will focus primarily on the configuration settings from Azure Monitor to achieve a stable Oracle Exadata Database cluster.

The following are key topics to consider before deploying your Oracle resources:

- In which Azure datacenter will you deploy your Oracle Exadata databases in relation to your current or planned Azure enterprise landing zone. Will your current monitor tooling of choice be able to extend into these regions.
- Will you be planning to deploy your Oracle Exadata resources with Availability zones. Be aware that Availability zones are subscription-specific, which affects network latency and resiliency. The network latency may affect your monitoring results.
- Network planning will have to be taken into consideration before you deploy your resources. When you deploy your Oracle resources you have the choice of a single virtual network or to a Hub and Spoke architecture with hybrid connectivity. Please note  that Oracle Exadata database resources are deployed to a private subnet that is not accessible from the internet. If your current enterprise monitoring solution is on-premises you will need to account for the connectivity.
- Please note that the subnets that the Oracle Exadata database clusters are deployed within a virtual network and are delegated subnets which have constraints. For more information, see [Network planning for Oracle Database@Azure](https://learn.microsoft.com/azure/oracle/oracle-db/oracle-database-network-plan#constraints).
- As part of your networking planning, you will also have to take into consideration the topology that best supports your migration method of choice will have monitor the end-to-end process while moving your critical data.
- Consult with all Oracle database administrators the monitoring alerts of your chosen solution will be implemented and align with their expectations.
- Once a monitoring alert is received for your Oracle workload determine how this will integrate it into your current triage process and procedures.
- Identify if there are additional key stakeholders that will need to be included once an alert is triggered.

For additional design considerations, see [Plan for Oracle on Azure adoption - Cloud Adoption Framework | Microsoft Learn](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-landing-zone-plan).

## Design recommendations

#### Health Monitoring Metric Enablement

The metrics for Oracle Exadata database help measure useful quantitative data, such as CPU, memory utilization, storage utilization, database operations, SQL queries, and transactions. You can use the Azure Monitor metrics to diagnose and proactively troubleshoot issues. The database metrics are for operational readiness and long-term sustainment. 

An Azure administrator can create a custom dashboard in the Azure portal with an aggregated view of the various metrics collected from the Oracle Exadata Database with alerts from Azure Monitor. The required rights to accomplish this were described in the prerequisites section of this article. Details on how to create a custom dashboard can be found in the following article [Create a dashboard in the Azure portal - Azure portal | Microsoft Learn](https://learn.microsoft.com/azure/azure-portal/azure-portal-dashboards).

As part of your design considerations please review the following article to understand the required permissions [Roles, permissions, and security in Azure Monitor - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/azure/azure-monitor/roles-permissions-security). 

Please note at the time of writing of this article the telemetry provided from the Oracle Cloud Infrastructure (OCI) can provide an enterprise level insights, but if you require granular database monitoring we recommend that you review Oracle documentation located here [Enterprise Manager Database Management](https://www.oracle.com/database/technologies/manageability.html) and integrate this into your overall monitoring and management strategy. Oracle has also provided a comprehensive monitoring guide for review in the following article [Oracle Cloud Database Metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html). This article will primarily focus on monitoring and management from Azure based tooling.

#### Key Metric Monitoring

Below here are the initial recommended settings and other counters can be added based on your enterprise needs.  Ensure you to set the following monitoring settings against all the available nodes in the cluster. Azure Monitor does not allow at the time of writing of this article to select multiple objects at the same time when adding metrics. You will have to select each Exadata cluster node with the specified settings. 
The recommendation is to have alerts with your monitoring solution of choice for critical workloads. If you leverage Azure Monitor see [Azure Monitor action groups - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/azure/azure-monitor/alerts/action-groups).



|  Metric Display Name                                   |  Collection Frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| CPU Utilization                                        | 5 Minutes                                               | 90%                           | The CPU utilization expressed as a percentage, aggregated across all consumer groups. The utilization percentage is reported with respect to the number of CPUs the database is allowed to use, which is two times the number of OCPUs. This setting is per database within the cluster. |
| Storage Utilization                                    | 30 Minutes                                              | 90%                            | The percentage of provisioned storage capacity currently in use. Represents the total allocated space for all tablespaces. This setting is per database within the cluster.|
| Flash Recovery Area Utilization                        | 15 Minutes                                              | 90%                            | The flash recovery area utilization.   |
| Memory Usage                                           | 15 Minutes                                              | Mbit                           | The total size of the memory pool.     |
| Process Limit Utilization                              |   5 Minutes                                             | 90%                            | The process limit utilization          |
| Session Limit Utilization                              |   5 Minutes                                             | 90%                            | The database session limit utilization |
| Usable Fast Recovery Area                              | 15 Minutes                                              | 90%                            | The usable fast recovery area          |
| OCI Database Cluster Memory Utilization                | 5 Minutes                                               | 90%                            | Amount of Memory the Exadata database clusters are consuming |
| Average Node Status                                    | 5 Minutes                                               | 0 (this dimension means false) | Evaluate if the  Exadata database cluster node within the cluster is available or unavailable. The setting should be set against each node |

For detailed information and key metrics to monitor Oracle Exadata can be found in the following article [Oracle Cloud Database Metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html)




