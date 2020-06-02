---
title: Management and monitoring
description: Management and monitoring
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring

## Planning platform management and monitoring

This section will explore how to operationally maintain a Microsoft Azure enterprise estate with centralized management and monitoring at a platform level. More specifically, it will present key recommendations for central teams to maintain operational visibility within a large-scale Azure platform.

![Management and monitoring](./media/mgmt-mon.png)

_Figure 1: Platform management and monitoring_

**Design considerations:**

- Using an Azure Monitor Logs workspace as an administrative boundary.

- Application-centric platform monitoring, encompassing both hot and cold telemetry paths for metrics and logs, respectively.

  - Operating system metrics (performance counters and custom metrics).

  - Operating system logs (Internet Information Services, Event Tracing for Windows, and syslogs).

  - Resource health events.

- Security audit logging and achieving a horizontal security lens across the customer's entire Azure estate.

  - Potential integration with on-premises security information and event management (SIEM) systems such as ServiceNow or ArcSight.

  - Azure activity logs.

  - Azure AD audit reports.

  - Azure diagnostic services, logs, and metrics; Azure Key Vault audit events; network security group (NSG) flow; and event logs.

  - Azure Monitor, Network Watcher, Security Center, and Sentinel.

- Azure data retention thresholds and archiving requirements.

  - The default retention period for Monitor Logs is 30 days, with a maximum of two years.

  - The default retention period for Azure Active Directory reports (premium) is 30 days.

  - The default retention period for the Azure diagnostic service is 90 days.

- Operational requirements:

  - Operational dashboards with native tools such as Azure Monitor Logs or third-party tooling.

  - Controlling privileged activities with centralized roles.

  - [Managed identities for Azure resources](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview) for access to Azure services.

  - Resource locks to protect editing and deleting resources.

**Design recommendations:**

- Use a single [Monitor Logs workspace](https://docs.microsoft.com/azure/azure-monitor/platform/design-logs-deployment) to manage platforms centrally except where role-based access control (RBAC) and data sovereignty requirements mandate separate workspaces. Centralized logging is critical to the visibility required by operations management teams. Logging centralization drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized workspace model reduces administrative effort and the chances for gaps in observability.

Within the context of the enterprise-scale architecture, centralized logging is primarily concerned with platform operations. This doesn't preclude using the same workspace for app logging. With a workspace configured in resource-centric access-control mode, granular RBAC is enforced to ensure that application teams only have access to the logs from their resources. In this model, application teams benefit from using existing platform infrastructure to reduce their management overhead.

- Export logs to Azure Storage if log retention requirements exceed two years. Use immutable storage with WORM (write once, read many) policy to make data non-erasable and non-modifiable for a user-specified interval.

- Use Azure Policy for access control and compliance reporting. This provides the ability to enforce organization-wide settings to ensure consistent policy adherence and fast violation detection, as described in this [article](https://docs.microsoft.com/azure/governance/policy/concepts/effects).

- Monitor in-guest virtual machine (VM) configuration drift using Azure Policy. Enabling [guest configuration](https://docs.microsoft.com/azure/governance/policy/concepts/guest-configuration) audit capabilities through policy helps app team workloads to immediately consume feature capabilities with little effort.

- Use [update management in Azure Automation](https://docs.microsoft.com/azure/automation/automation-update-management) as a long-term patching mechanism for both Windows and Linux VMs.
 Enforcing update management configurations through policy ensures that all VMs are included in the patch management regimen, provides application teams with the ability to manage patch deployment for their VMs, and provides central IT with visibility and enforcement capabilities across all VMs.

- Use Azure Network Watcher to proactively monitor traffic flows via [NSG flow logs, version 2](https://docs.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview). The Network Watcher [traffic analytics](https://docs.microsoft.com/azure/network-watcher/traffic-analytics) feature uses NSG flow logs to gather deep insights about IP traffic within a virtual network and providing critical information for effective management and monitoring. Traffic analytics provide information such as most communicating hosts and app protocols, most conversing host pairs, allowed/blocked traffic, inbound/outbound traffic, open internet ports, most blocking rules, traffic distribution per an Azure data center, virtual network, subnets, or rogue networks.

- Use resource locks to prevent accidental deletion of critical shared services.

- Use [deny policies](https://docs.microsoft.com/azure/governance/policy/concepts/effects#deny) to supplement Azure AD RBAC assignments. Deny policies are used to prevent deploying and configuring resources that don't match defined standards by preventing the request from being sent to the resource provider. The combination of deny policies and RBAC assignments ensures that the appropriate guard rails are in place to enforce who can deploy resources and which ones to deploy.

- Include [service](https://docs.microsoft.com/azure/service-health/service-health-overview) and [resource](https://docs.microsoft.com/azure/service-health/resource-health-overview) health events as part of the overall platform monitoring solution. Tracking service and resource health from the platform perspective is an important component of resource management in Azure.

- Do not send raw log entries back to on-premises monitoring systems. Instead, adopt a principle that _data born in Azure, stays in Azure_. If on-premises SIEM integration is required, [send critical alerts](https://docs.microsoft.com/azure/security-center/continuous-export) instead of logs.

## Planning for app management and monitoring

To expand on the previous section, this section will consider federated management and monitoring of customer app workloads and explain how application teams can operationally maintain these workloads.

**Design considerations:**

- App monitoring can use a dedicated workspaces or a centralized Monitor Logs workspace.

- App performance and health monitoring for both infrastructure-as-a-service (IaaS) and platform-as-a-service (PaaS) resources.

- Data aggregation across all app components.

- [Health modeling and operationalization](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/monitor/cloud-models-monitor-overview):

  - How to measure the health of the workload and its subsystems.
  - A _traffic-light_ model to represent health.
  - How to respond to failures across app components.

**Design recommendations:**

- Use a centralized Monitor Logs workspace to collect logs and metrics from IaaS and PaaS app resources and [control log access with RBAC](https://docs.microsoft.com/azure/azure-monitor/platform/design-logs-deployment#access-control-overview).

- Use [Azure Monitor metrics](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-metrics) for time-sensitive analysis. Metrics in Azure Monitor are stored in a time-series database optimized to analyze time-stamped data. This makes metrics suited for alerts and detecting issues quickly. They can tell you how your system is performing, but they typically need to be combined with logs to identify the root cause of issues.

- Use [Azure Monitor logs](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-logs) for insights and reporting. Logs contain different types of data that's organized into records with different sets of properties, and they're useful for analyzing complex data from a range of sources such as performance data, events, and traces.

- When necessary, use shared storage accounts within the landing zone for Azure diagnostic extension log storage.

- Use [Azure Monitor alerts](https://docs.microsoft.com/azure/azure-monitor/platform/alerts-overview) for the generation of operational alerts. Azure Monitor alerts unify alerts for metrics and logs and use features such as action and smart groups for advanced management and remediation purposes.
