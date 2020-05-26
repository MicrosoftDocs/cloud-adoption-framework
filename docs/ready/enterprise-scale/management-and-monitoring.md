---
title: Management and monitoring
description: Management and monitoring
author: rkuehfus
ms.author: brblanch
ms.date: 06/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Management and monitoring

![Management and Monitoring](./media/mgmt-mon.png)

_Figure 1: Platform management and monitoring._

## Planning platform management and monitoring

This section will focus on centralized management and monitoring at a platform level, exploring how an entire enterprise Azure estate can be operationally maintained. More specifically, it will consider the key recommendations to support central teams ability to maintain operational visibility of a large-scale Azure platform.

**Design considerations:**

- An Azure Monitor Logs workspace is an administrative boundary

- App-centric platform monitoring, encompassing both hot and cold telemetry paths for metrics and logs, respectively

  - OS metrics (Perf counters, custom metrics)

  - OS logs (Iis, etw, syslogs)

  - Resource health events

- Security audit logging and achieving a horizontal security lens across the entire customer Azure estate

  - Potential integration with on-premises SIEM systems such as service now or arcsight

  - Azure activity logs

  - Azure AD audit reports

  - Azure diagnostic service; diagnostic logs and metrics, kv audit events, NSG flow, and event logs

  - Azure Monitor, Network Watcher, Security Center, and Azure Sentinel

- Azure data retention thresholds and requirements for archiving.

  - The default retention period for Monitor Logs is 30 days, with a maximum of two years

  - The default retention period for Azure AD reports (premium) is 30 days

  - The default retention period for the Azure diagnostic service is 90 days

- Operational requirements

  - Operational dashboarding using native tools such as Azure Monitor Logs or third-party tooling

  - Controlling privileged activities with centralized roles

  - [Managed identities for Azure resources](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview) for access to Azure services.

  - Resource locks to protect both the deletion and edit of resources.

**Design recommendations:**

- Use a single [Monitor Logs workspace](https://docs.microsoft.com/azure/azure-monitor/platform/design-logs-deployment) for centralized platform management except where RBAC and data sovereignty requirements mandate the consideration of separate workspaces.

    Centralized logging is critical to the visibility that's required by the operations management teams. The centralization of logging drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized workspace model reduces administrative effort and reduces the chances for gaps in observability.

    Within the context of the enterprise-scale architecture, centralized logging is primarily concerned with platform operations. But this does not preclude the use of the same workspace for application logging. With a workspace configured in resource centric access control mode, granular RBAC is enforced to ensure app teams will only have access to the logs from their resources. In this model app teams benefit from the use of existing platform infrastructure by reducing their management overhead.

- Export logs to Azure Storage if log retention requirements exceed 2 years.

    Use immutable storage with worm policy (write once, read many) to make data non-erasable and non-modifiable for a user-specified interval.

- Use Azure Policy for access control and compliance reporting.

    This provides the ability to enforce the settings across an organization to ensure consistent policy adherence and fast violation detection, as described in this [article](https://docs.microsoft.com/azure/governance/policy/concepts/effects).

- Monitor in-guest VM configuration drift using Azure Policy.

    Enabling [guest configuration](https://docs.microsoft.com/azure/governance/policy/concepts/guest-configuration) audit capabilities through policy provides application teams with the ability to immediately consume the feature capabilities for their workloads with very little effort.

- Use [update management in Azure Automation](https://docs.microsoft.com/azure/automation/automation-update-management) as a long-term patching mechanism, for both Windows and Linux VMs.

    Enforcing configuration of update management through policy ensures all VMs are included in the patch management regimen, provides application teams with the ability to manage patch deployment for their VMs, and provides Central IT with visibility and enforcement capabilities across all VMs.

- Use Azure Network Watcher to proactively monitor traffic flows via [NSG flow logs v2](https://docs.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview).

    The Network Watcher [traffic analytics](https://docs.microsoft.com/azure/network-watcher/traffic-analytics) feature uses NSG flow logs to provide deep insights into IP traffic within a virtual network, providing information critical for effective management and monitoring. Traffic analytics provides information such as most communicating hosts, most communicating application protocols, most conversing host pairs, allowed/blocked traffic, inbound/outbound traffic, open internet ports, most blocking rules, traffic distribution per Azure datacenter, virtual network, subnets, or, rogue networks.

- Use resource locks to prevent accidental deletion of critical shared services.

- Use [deny policies](https://docs.microsoft.com/azure/governance/policy/concepts/effects#deny) to supplement Azure AD RBAC assignments.

    Deny policies are used to prevent deployment and configuration of resources that do not match defined standards by preventing the request from being sent to the resource provider. The combination of deny policies and RBAC assignments ensures the appropriate guard rails are in place to enforce who can deploy resources and what resources they can deploy.

- Include [service](https://docs.microsoft.com/azure/service-health/service-health-overview) and [resource](https://docs.microsoft.com/azure/service-health/resource-health-overview) health events as part of the overall platform monitoring solution.

    Tracking service and resource health from the platform perspective is an important component of resource management in Azure.

- Do not send raw logs entries back to on premise monitoring systems, but instead adopt the principal of "data born in Azure, stays in Azure".

  - If on-premises SIEM integration is required [send critical alerts](https://docs.microsoft.com/azure/security-center/continuous-export) instead of logs.

## Planning for application management and monitoring

Expanding on the previous section, this next section will now consider the federated management and monitoring of customer application workloads, touching on how application teams can operationally maintain their application workloads.

**Design considerations:**

- Application monitoring can utilize the centralized Monitor Logs workspace or use dedicated workspaces

- Application performance and health monitoring for both IaaS and PaaS resources

- Data aggregation across all application components

- [Health modelling and operationalization](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/monitor/cloud-models-monitor-overview)

  - How to measure the health of the workload and its subsystems; "traffic light" model for health representation

  - How to respond to failures across application components

**Design recommendations:**

- Use a centralized Monitor Logs workspace to collect logs and metrics from IaaS and PaaS application resources, and [control log access with RBAC](https://docs.microsoft.com/azure/azure-monitor/platform/design-logs-deployment#access-control-overview).

- Use [Azure Monitor metrics](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-metrics) for time sensitive analysis.

    Metrics in Azure Monitor are stored in a time-series database which is optimized for analyzing time-stamped data. This makes metrics particularly suited for alerting and fast detection of issues. They can tell you how your system is performing but typically need to be combined with logs to identify the root cause of issues.

- Use [Monitor logs](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-logs) for insights and reporting.

    Logs contain different kinds of data organized into records with different sets of properties and are especially useful for performing complex analysis across data from a variety of sources, such as performance data, events, and traces.

- Use shared storage accounts within the "landing zone" for Azure diagnostic extension log storage when required.

- Use [Azure Monitor alerts](https://docs.microsoft.com/azure/azure-monitor/platform/alerts-overview) for the generation of operational alerts.

    Azure Monitor alerts provides a unified experience for alerting on metrics and logs, and uses features such as action groups and smart groups for advanced management and remediation capabilities.
