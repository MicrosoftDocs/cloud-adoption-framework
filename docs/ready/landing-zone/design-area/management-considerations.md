---
title: Management considerations
description: Design area considerations for managing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Management considerations

Use the following items as discussion points within your cloud architecture and operations teams in order to explore and agree on the requirements and features that need to be included in your management design.

### Platform management and monitoring - Design considerations

- Use an Azure Monitor Log Analytics workspace as an administrative boundary.
- Application-centric platform monitoring, encompassing both hot and cold telemetry paths for metrics and logs, respectively:
  - Operating system metrics; for example, performance counters and custom metrics
  - Operating system logs; for example, Internet Information Services, Event Tracing for Windows, and syslogs
  - Resource health events
- Security audit logging and achieving a horizontal security lens across your organization's entire Azure estate:
  - Potential integration with on-premises security information and event management (SIEM) systems such as ArcSight or the Onapsis security platform
  - Potential integration with software as a service (SaaS) offerings such as ServiceNow
  - Azure activity logs
  - Azure Active Directory (Azure AD) audit reports
  - Azure diagnostic services, logs, and metrics; Azure Key Vault audit events; network security group (NSG) flow logs; and event logs
  - Azure Monitor, Azure Network Watcher, Azure Security Center, and Azure Sentinel
- Azure data retention thresholds and archiving requirements:
  - The default retention period for Azure Monitor Logs is 30 days, with a maximum of two years.
  - The default retention period for Azure AD reports (premium) is 30 days.
  - The default retention period for the Azure diagnostic service is 90 days.

- Operational requirements:
  - Operational dashboards with native tools such as Azure Monitor Logs or third-party tooling
  - Controlling privileged activities with centralized roles
  - [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) for access to Azure services
  - Resource locks to protect editing and deleting resources

### Application management and monitoring - Design considerations

To expand on the previous section, this section will consider a federated model and explain how application teams can operationally maintain these workloads.

- Application monitoring can use dedicated Log Analytics workspaces.
- For applications that are deployed to virtual machines, logs should be stored centrally to the dedicated Log Analytics workspace from a platform perspective. Application teams can access the logs subject to the Azure RBAC they have on their applications or virtual machines.
- Application performance and health monitoring for both infrastructure as a service (IaaS) and platform as a service (PaaS) resources.
- Data aggregation across all application components.
- [Health modeling and operationalization](../../manage/monitor/cloud-models-monitor-overview.md):
  - How to measure the health of the workload and its subsystems
  - A traffic-light model to represent health
  - How to respond to failures across application components

## Business continuity and disaster recovery - Design considerations

Consider the following factors:

- Application and data availability requirements, and the use of active-active and active-passive availability patterns (such as workload RTO and RPO requirements).

- Business continuity and DR for platform as a service (PaaS) services, and the availability of native DR and high-availability features.

- Support for multiregion deployments for failover purposes, with component proximity for performance reasons.

- Application operations with reduced functionality or degraded performance in the presence of an outage.

- Workload suitability for Availability Zones or availability sets.

  - Data sharing and dependencies between zones.

  - The impact of Availability Zones on update domains compared to availability sets and the percentage of workloads that can be under maintenance simultaneously.

  - Support for specific virtual machine (VM) stock-keeping units with Availability Zones.

  - Using Availability Zones is required if Microsoft Azure ultra disk storage is used.

- Consistent backups for applications and data.

  - VM snapshots and using Azure Backup and Recovery Services vaults.

  - Subscription limits restricting the number of Recovery Services vaults and the size of each vault.

  - Geo-replication and DR capabilities for PaaS services.

- Network connectivity if a failover occurs.

  - Bandwidth capacity planning for Azure ExpressRoute.

  - Traffic routing if a regional, zonal, or network outage occurs.

- Planned and unplanned failovers.

  - IP address consistency requirements and the potential need to maintain IP addresses after failover and failback.

  - Maintained engineering DevOps capabilities.

- Azure Key Vault DR for application keys, certificates, and secrets.