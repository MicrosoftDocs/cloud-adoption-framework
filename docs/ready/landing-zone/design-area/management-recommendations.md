---
title: Management recommendations
description: Design area recommendations for managing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Management recommendations

### Platform management and monitoring recommendations

- Use a single [monitor logs workspace](/azure/azure-monitor/platform/design-logs-deployment) to manage platforms centrally except where Azure role-based access control (Azure RBAC), data sovereignty requirements and data retention policies mandate separate workspaces. Centralized logging is critical to the visibility required by operations management teams. Logging centralization drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized workspace model reduces administrative effort and the chances for gaps in observability.

    In the context of the enterprise-scale architecture, centralized logging is primarily concerned with platform operations. This emphasis doesn't prevent the use of the same workspace for VM-based application logging. With a workspace configured in resource-centric access control mode, granular Azure RBAC is enforced to ensure application teams will only have access to the logs from their resources. In this model, application teams benefit from the use of existing platform infrastructure by reducing their management overhead. For any non-compute resources such as web apps or Azure Cosmos DB databases, application teams can use their own Log Analytics workspaces and configure diagnostics and metrics to be routed here.

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

## Business continuity and disaster recovery - Design recommendations

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