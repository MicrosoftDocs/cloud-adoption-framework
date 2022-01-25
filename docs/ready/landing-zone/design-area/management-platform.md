---
title: Inventory and visibility considerations
description: Learn how to manage inventory and visibility in your Azure platform services
author: DominicAllen
ms.author: doalle
ms.date: 01/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Inventory and visibility considerations

As organizations design and implement cloud environments, the basis for your management and monitoring of the platform services are a key consideration.
Structuring these services to meet the needs of your business as the environment scales is an important factor in successful cloud adoption.

The cloud-operating model choices you made as part of the earlier planning phases directly influence how management operations are delivered as part of a landing zone. The degree to which management is centralized for the platform is a key example of this situation.

Use the guidance in this section to consider how to approach inventory and visibility in your cloud environment.

## Basic inventory considerations

- Consider using tools such as an Azure Monitor Log Analytics workspace as an administrative boundary.
- Determine which teams will use the system-generated logs from the platform and who requires access to the logs.

Consider the following items related to logging data. Doing so helps inform the types of data you might want to collate and use.

|Scope|Context|
|-|-|
|Application-centric platform monitoring <br>  |Include both hot and cold telemetry paths for metrics and logs, respectively. <br> Operating system metrics; for example, performance counters and custom metrics <br> Operating system logs; for example: <br> <ul> <li>Internet Information Services</li> <li>Event Tracing for Windows, and syslogs</li> <li>Resource health events</li> </ul>|
|Security audit logging  |Aim to achieve a horizontal security lens across your organization's entire Azure estate <br> <ul> <li>Potential integration with on-premises security information and event management (SIEM) systems such as ArcSight or the Onapsis security platform</li> <li>Potential integration with software as a service (SaaS) offerings such as ServiceNow</li> <li>Azure activity logs</li> <li>Azure Active Directory (Azure AD) audit reports</li> <li>Azure diagnostic services, logs, and metrics; Azure Key Vault audit events; network security group (NSG) flow logs; and event logs</li> <li>Azure Monitor, Azure Network Watcher, Microsoft Defender for Cloud, and Microsoft Sentinel</li> </ul>|
 Azure data retention thresholds and archiving requirements|<ul> <li>The default retention period for Azure Monitor Logs is 30 days, with a maximum of two years.</li> <li>The default retention period for Azure AD reports (premium) is 30 days.</li> <li>The default retention period for the Azure diagnostic service is 90 days.</li> </ul>|
Operational requirements|<ul> <li>Operational dashboards with native tools such as Azure Monitor Logs or third-party tooling</li> <li>Controlling privileged activities with centralized roles</li> <li>Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) for access to Azure services</li> <li>Resource locks to protect editing and deleting resources</li> </ul>|

### Visibility considerations

- Which teams will need alert notifications?
- Are there groups of services that will need different teams to be notified?
- Are there existing Service Management tools in place that alerts need to be sent to?
- Which services are considered business critical and need high priority notifications of issues?

### Update Management considerations

- Are there existing Update Management tools used by your organization? Can they be extended to cover the cloud environment or are new tools required?
- Which teams will be responsible for overseeing Update Management?
- Are there groups of resources that share similar update schedules?
- Are there groups of resources that cannot be updated at the same time for business continuity reasons?

## Inventory and visibility recommendations

- Use a single [monitor logs workspace](/azure/azure-monitor/platform/design-logs-deployment) to manage platforms centrally except where Azure role-based access control (Azure RBAC), data sovereignty requirements, and data retention policies mandate separate workspaces. Centralized logging is critical to the visibility required by operations management teams. Logging centralization drives reports about change management, service health, configuration, and most other aspects of IT operations. Focusing on a centralized workspace model reduces administrative effort and the chances for gaps in observability.
- Export logs to Azure Storage if log retention requirements exceed two years. Use immutable storage with a write-once, read-many policy to make data non-erasable and non-modifiable for a user-specified interval.
- Use Azure Policy for access control and compliance reporting. Azure Policy lets you enforce organization-wide settings to ensure consistent policy adherence and fast violation detection. For more information, see [Understand Azure Policy effects](/azure/governance/policy/concepts/effects).
- Monitor in-guest virtual machine (VM) configuration drift using Azure Policy. Enabling [guest configuration](/azure/governance/policy/concepts/guest-configuration) audit capabilities through policy helps application team workloads to consume feature capabilities immediately, with little effort.
- Use [Update Management in Azure Automation](/azure/automation/update-management/overview) as a long-term patching mechanism for both Windows and Linux VMs. Enforcing Update Management configurations through Azure Policy ensures that all VMs are included in the patch management regimen. It also provides application teams with the ability to manage patch deployment for their VMs. It also provides visibility and enforcement capabilities to the central IT team across all VMs.
- Use Network Watcher to proactively monitor traffic flows through [Network Watcher NSG flow logs v2](/azure/network-watcher/network-watcher-nsg-flow-logging-overview). [Traffic Analytics](/azure/network-watcher/traffic-analytics) analyzes NSG flow logs to gather deep insights about IP traffic within a virtual network and provides critical information for effective management and monitoring. Traffic Analytics provides information such as:
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
- Use [resource locks](/azure/governance/blueprints/concepts/resource-locking) to prevent accidental deletion of critical shared services.
- Use [deny policies](/azure/governance/policy/concepts/effects#deny) to supplement Azure role assignments. Deny policies help prevent deploying and configuring resources that don't match defined standards. They do so by preventing the request from being sent to the resource provider. The combination of deny policies and Azure role assignments ensures the appropriate guardrails are in place to enforce *who* can deploy and configure resources and *what* resources they can deploy and configure.
- Include [service](/azure/service-health/service-health-overview) and [resource](/azure/service-health/resource-health-overview) health events as part of the overall platform monitoring solution. Tracking service and resource health from the platform perspective is an important component of resource management in Azure.
- Don't send raw log entries back to on-premises monitoring systems. Instead, adopt a principle that *data born in Azure stays in Azure*. If on-premises SIEM integration is required, then [send critical alerts](/azure/security-center/continuous-export) instead of logs.

## Azure landing zone accelerator and management

The Azure landing zone accelerator includes opinionated configuration that deploys key Azure management capabilities to help organizations get to scale and maturity quickly.

Included in the Azure landing zone accelerator deployment are key management and monitoring tools, such as:

- A Log Analytics workspace and Automation account
- Microsoft Defender for Cloud monitoring
- Diagnostic settings for activity logs, virtual machines, and platform as a service (PaaS) resources sent to Log Analytics

### Centralized logging in the Azure landing zone accelerator

In the context of the Azure landing zone accelerator, centralized logging is primarily concerned with platform operations.

This emphasis doesn't prevent the use of the same workspace for VM-based application logging. With a workspace configured in resource-centric access control mode, granular Azure RBAC is enforced. Doing so ensures that application teams only have access to the logs from their resources.

In this model, application teams benefit from the use of existing platform infrastructure by reducing their management overhead.

For any non-compute resources, such as web apps or Azure Cosmos DB databases, application teams can use their own Log Analytics workspaces. Teams can then route diagnostics and metrics to those workspaces.
