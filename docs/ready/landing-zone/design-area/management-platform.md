---
title: Inventory and visibility considerations
description: Learn how to manage inventory and visibility in your Azure platform services.
author: Zimmergren
ms.author: pnp
ms.date: 02/20/2025
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
---

# Inventory and visibility considerations

As your organization designs and implements your cloud environment, the basis for your platform management and platform services monitoring is a key consideration. To ensure a successful cloud adoption, you must structure these services to meet the needs of your organization as your environment scales.

The cloud operating model decisions you make in early planning phases directly influence how management operations are delivered as part of your landing zones. The degree to which management is centralized for your platform is a key example.

Use the guidance in this article to consider how you should approach inventory and visibility in your cloud environment.

## Basic inventory considerations

- Consider using tools such as an Azure Monitor Log Analytics workspace as administrative boundaries.
- Determine which teams should use the system-generated logs from the platform and who needs access to those logs.

Consider the following items related to logging data to inform what types of data you might want to collate and use.

|Scope|Context|
|-|-|
|Application-centric platform monitoring <br>  |Include both hot and cold telemetry paths for metrics and logs, respectively. <br> Operating system metrics, such as performance counters and custom metrics. <br> Operating system logs, such as: <br> <ul> <li>Internet Information Services</li> <li>Event Tracing for Windows, and syslogs</li> <li>Resource health events</li> </ul>|
|Security audit logging  |Aim to achieve a horizontal security lens across your organization's entire Azure estate. <br> <ul> <li>Potential integration with on-premises security information and event management (SIEM) systems such as ArcSight or the Onapsis security platform</li> <li>Potential integration with software as a service (SaaS) offerings like ServiceNow</li> <li>Azure activity logs</li> <li>Microsoft Entra audit reports</li> <li>Azure diagnostic services, logs, and metrics, Azure Key Vault audit events, network security group (NSG) flow logs, and event logs</li> <li>Azure Monitor, Azure Network Watcher, Microsoft Defender for Cloud, and Microsoft Sentinel</li> </ul>|
 Azure data retention thresholds and archiving requirements|<ul> <li>The default retention period for Azure Monitor Logs is 30 days, with a maximum analytics retention of two years and archive of seven years.</li> <li>The default retention period for Microsoft Entra reports (premium) is 30 days.</li> <li>The default retention period for the Azure Activity logs and Application Insights logs is 90 days.</li> </ul>|
Operational requirements|<ul> <li>Operational dashboards with native tools such as Azure Monitor Logs or third-party tooling</li> <li>Use of centralized roles to control privileged activities</li> <li>Managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview) for access to Azure services</li> <li>Resource locks to protect from editing and deleting resources</li> </ul>|

### Visibility considerations

- Which teams need to receive alert notifications?
- Do you have groups of services that need multiple teams to be notified?
- Do you have existing Service Management tools in place that you need to send alerts to?
- Which services are considered business critical and require high priority notifications of issues?

## Inventory and visibility recommendations

- Use a single [monitor logs workspace](/azure/azure-monitor/platform/design-logs-deployment) to manage platforms centrally, except where Azure role-based access control (Azure RBAC), data sovereignty requirements, and data retention policies mandate separate workspaces. Centralized logging is critical to the visibility required by operations management teams and drives reports about change management, service health, configuration, and most other aspects of IT operations. Focusing on a centralized workspace model reduces administrative effort and the chances for gaps in observability.

  - Application teams can deploy their own Log Analytics Workspaces in their own subscriptions, alongside the central platform team workspace that they may have limited access to, to store logs and metrics that are specific to their workload requirements.

- Export logs to Azure Storage if your log retention requirements exceed seven years. Use immutable storage with a write-once, read-many policy to make data non-erasable and non-modifiable for a user-specified interval.

- Use Azure Policy for access control and compliance reporting. Azure Policy lets you enforce organization-wide settings to ensure consistent policy adherence and fast violation detection. For more information, see [Understand Azure Policy effects](/azure/governance/policy/concepts/effects).

- Use Network Watcher to proactively monitor traffic flows through [Network Watcher NSG flow logs v2](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). [Traffic Analytics](/azure/network-watcher/traffic-analytics) analyzes NSG flow logs to gather deep insights about IP traffic within virtual networks. It also provides critical information you need for effective management and monitoring, such as:

  - Most communicating hosts and application protocols
  - Most conversing host pairs
  - Allowed or blocked traffic
  - Inbound and outbound traffic
  - Open internet ports
  - Most blocking rules
  - Traffic distribution per an Azure datacenter
  - Virtual network
  - Subnets
  - Rogue networks
  
- Use [resource locks](/azure/azure-resource-manager/management/lock-resources) to prevent accidental deletion of critical shared services.

- Use [deny policies](/azure/governance/policy/concepts/effects#deny) to supplement Azure role assignments. Deny policies help prevent resource deployments and configurations that don't meet defined standards by blocking requests from being sent to resource providers. Combining deny policies and Azure role assignments ensures that you have appropriate guardrails in place to control *who* can deploy and configure resources and *which* resources they can deploy and configure.

- Include [service](/azure/service-health/service-health-overview) and [resource](/azure/service-health/resource-health-overview) health events as part of your overall platform monitoring solution. Tracking service and resource health from the platform perspective is an important component of resource management in Azure.

- Don't send raw log entries back to on-premises monitoring systems. Instead, adopt the principle that *data born in Azure stays in Azure*. If you require on-premises SIEM integration, send [critical alerts](/azure/security-center/continuous-export) instead of logs.

## Azure landing zone accelerator and management

The Azure landing zone accelerator includes opinionated configuration to deploy key Azure management capabilities that help your organization quickly scale and mature.

The Azure landing zone accelerator deployment includes key management and monitoring tools like:

- A Log Analytics workspace
- Microsoft Defender for Cloud monitoring
- Diagnostic settings for activity logs, virtual machines, and platform as a service (PaaS) resources sent to Log Analytics

### Centralized logging in the Azure landing zone accelerator

In the context of the Azure landing zone accelerator, centralized logging is primarily concerned with platform operations.

This emphasis doesn't prevent use of the same workspace for VM-based application logging. Within a workspace configured in resource-centric access control mode, granular Azure RBAC is enforced, which ensures that your application teams only have access to the logs from their resources.

In this model, application teams benefit from the use of existing platform infrastructure as it reduces their management overhead.

For non-compute resources, like web apps or Azure Cosmos DB databases, your application teams can use their own Log Analytics workspaces. They can then route diagnostics and metrics to those workspaces.

Application teams may also decide to duplicate some of the logs that are available in the central platform team Log Analytics Workspace for operational efficiencies within their team. This is also a supported approach within the Azure landing zone architecture and guidance.

## Next step

[Monitor your Azure platform landing zone components](management-monitor.md)
