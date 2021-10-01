---
title: Management
description: Design area guidance for managing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Management for Azure environments

## Overview

For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities.

The management design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Manage methodology](/manage/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic management processes and tools. 

|Scope|Context|
|-|-|
|**Platform management**|As cloud environments are implemented and scaled out, management controls that span the environment become increasingly important. <br> Irrespective of the services that are running on top of the landing zone, there is a need for the management of fundamental elements of the platform to ensure stable, ongoing operations. <br> These management tools should be capable of scaling as the environments do. <br> They may include a mix of first party and third party tools, depending on your existing investments.|
|**Application management**| Applications and services built on top of the landing zone platform may have specific management requirements that are in addition to the tools and processes put in place for the platform services. <br> These should be considered in the context of the platform management, to ensure additions or exceptions are known and documented. <br> It is also important to look at these requirements in the broader context as what is thought to be a requirement for a single application may become a common patterns and should be considered as part of the overall platform toolset to avoid unnecessary duplication of effort. <br> For further information on considerations for application-specific management, review the [Operational excellence](/azure/architecture/framework/#operational-excellence) of the Well-architected Framework|
|**Business continuity and disaster recovery**| Your organization needs to design suitable, platform-level capabilities that application workloads can consume to meet their specific requirements.  <br>  Specifically, these application workloads have requirements pertaining to recover time objective (RTO) and recovery point objective (RPO). Be sure that you capture disaster recovery (DR) requirements in order to design capabilities appropriately for these workloads.

## Management considerations

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
- [Health modeling and operationalization](/manage/monitor/cloud-models-monitor-overview.md):
  - How to measure the health of the workload and its subsystems
  - A traffic-light model to represent health
  - How to respond to failures across application components

### Business continuity and disaster recovery - Design considerations

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

## Management recommendations

### Platform management and monitoring recommendations

- Use a single [monitor logs workspace](/azure/azure-monitor/platform/design-logs-deployment) to manage platforms centrally except where Azure role-based access control (Azure RBAC), data sovereignty requirements and data retention policies mandate separate workspaces. Centralized logging is critical to the visibility required by operations management teams. Logging centralization drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized workspace model reduces administrative effort and the chances for gaps in observability.

- Export logs to Azure Storage if log retention requirements exceed two years. Use immutable storage with a write-once, read-many policy to make data non-erasable and non-modifiable for a user-specified interval.
- Use Azure Policy for access control and compliance reporting. Azure Policy provides the ability to enforce organization-wide settings to ensure consistent policy adherence and fast violation detection. For more information, see [Understand Azure Policy effects](/azure/governance/policy/concepts/effects).
- Monitor in-guest virtual machine (VM) configuration drift using Azure Policy. Enabling [guest configuration](/azure/governance/policy/concepts/guest-configuration) audit capabilities through policy helps application team workloads to immediately consume feature capabilities with little effort.
- Use [Update Management in Azure Automation](/azure/automation/update-management/overview) as a long-term patching mechanism for both Windows and Linux VMs. Enforcing Update Management configurations via Azure Policy ensures that all VMs are included in the patch management regimen and provides application teams with the ability to manage patch deployment for their VMs. It also provides visibility and enforcement capabilities to the central IT team across all VMs.
- Use Network Watcher to proactively monitor traffic flows via [Network Watcher NSG flow logs v2](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). [Traffic Analytics](/azure/network-watcher/traffic-analytics) analyzes NSG flow logs to gather deep insights about IP traffic within a virtual network and provides critical information for effective management and monitoring. Traffic Analytics provide information such as most communicating hosts and application protocols, most conversing host pairs, allowed or blocked traffic, inbound and outbound traffic, open internet ports, most blocking rules, traffic distribution per an Azure datacenter, virtual network, subnets, or rogue networks.
- Use resource locks to prevent accidental deletion of critical shared services.
- Use [deny policies](/azure/governance/policy/concepts/effects#deny) to supplement Azure role assignments. Deny policies are used to prevent deploying and configuring resources that don't match defined standards by preventing the request from being sent to the resource provider. The combination of deny policies and Azure role assignments ensures the appropriate guardrails are in place to enforce *who* can deploy and configure resources and *what* resources they can deploy and configure.
- Include [service](/azure/service-health/service-health-overview) and [resource](/azure/service-health/resource-health-overview) health events as part of the overall platform monitoring solution. Tracking service and resource health from the platform perspective is an important component of resource management in Azure.
- Don't send raw log entries back to on-premises monitoring systems. Instead, adopt a principle that *data born in Azure stays in Azure*. If on-premises SIEM integration is required, then [send critical alerts](/azure/security-center/continuous-export) instead of logs.

### Application management and monitoring recommendations

- Use a centralized Azure Monitor Log Analytics workspace to collect logs and metrics from IaaS and PaaS application resources and [control log access with Azure RBAC](/azure/azure-monitor/platform/design-logs-deployment#access-control-overview).
- Use [Azure Monitor metrics](/azure/azure-monitor/platform/data-platform-metrics) for time-sensitive analysis. Metrics in Azure Monitor are stored in a time-series database optimized to analyze time-stamped data. These metrics are well suited for alerts and detecting issues quickly. They can also tell you how your system is performing. They typically need to be combined with logs to identify the root cause of issues.
- Use [Azure Monitor Logs](/azure/azure-monitor/platform/data-platform-logs) for insights and reporting. Logs contain different types of data that's organized into records with different sets of properties. They're useful for analyzing complex data from a range of sources, such as performance data, events, and traces.
- When necessary, use shared storage accounts within the landing zone for Azure diagnostic extension log storage.
- Use [Azure Monitor alerts](/azure/azure-monitor/platform/alerts-overview) for the generation of operational alerts. Azure Monitor alerts unify alerts for metrics and logs and use features such as action and smart groups for advanced management and remediation purposes.

### Business continuity and disaster recovery - Design recommendations

The following are best practices for your design:

- Employ Azure Site Recovery for Azure-to-Azure Virtual Machines disaster recovery scenarios. This enables you to replicate workloads across regions.

  Site Recovery provides built-in platform capabilities for VM workloads to meet low RPO/RTO requirements through real-time replication and recovery automation. Additionally, the service supports you to run recovery drills without affecting the workloads in production. You can use Azure Policy to enable replication and also audit the protection of your VMs.

- Use native PaaS service disaster recovery capabilities.

  The built-in features provide an easy solution to the complex task of building replication and failover into a workload architecture, simplifying both design and deployment automation. An organization that has defined a standard for the services they use can also audit and enforce the service configuration through Azure Policy.

- Use Azure-native backup capabilities.

  Azure Backup and PaaS-native backup features remove the need for managing third-party backup software and infrastructure. As with other native features, you can set, audit, and enforce backup configurations with Azure Policy. This ensures that services remain compliant with the organization's requirements.

- Use multiple regions and peering locations for ExpressRoute connectivity.

  A redundant hybrid network architecture can help ensure uninterrupted cross-premises connectivity if an outage affects an Azure region or peering provider location.

- Avoid using overlapping IP address ranges for production and DR sites.

  When possible, plan for a business continuity and DR network architecture that provides concurrent connectivity to all sites. DR networks that use the same classless inter-domain routing blocks like production networks require a network failover process that can complicate and delay application failover if an outage occurs.

## Azure landing zone accelerator and management

The Azure landing zone accelerator includes opinionated configuration that deploys key Azure management capabilities to help organizations get to scale and maturity quickly.

Included in the Azure landing zone accelerator deployment are:

| Technology| Configuration |
|--|--|
Azure Monitor| Insert specifics |
Network watcher| Insert specifics | 

### Centralized logging in the Azure landing zone accelerator

In the context of the Azure landing zone accelerator, centralized logging is primarily concerned with platform operations. 

This emphasis doesn't prevent the use of the same workspace for VM-based application logging. With a workspace configured in resource-centric access control mode, granular Azure RBAC is enforced to ensure application teams will only have access to the logs from their resources. 

In this model, application teams benefit from the use of existing platform infrastructure by reducing their management overhead. 

For any non-compute resources such as web apps or Azure Cosmos DB databases, application teams can use their own Log Analytics workspaces and configure diagnostics and metrics to be routed here.