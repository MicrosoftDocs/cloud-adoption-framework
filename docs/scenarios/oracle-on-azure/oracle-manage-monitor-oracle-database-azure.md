---
title: Manage and monitor Oracle Database@Azure
description: Learn about considerations and recommendations that you can use to manage and monitor your Oracle Database@Azure and Exadata Database services.
author: stephen-sumner
ms.author: rajanaki
ms.reviewer: janfaurs
ms.date: 08/01/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Manage and monitor Oracle Database@Azure

This article provides business practices that you can implement to manage and monitor Oracle Exadata Database Service on Dedicated Infrastructure with Oracle Database@Azure. Implement these considerations when you create your overall design and when you onboard this service within your Azure enterprise landing zone.

## Design considerations

Consider these key topics before you deploy Oracle Database@Azure and Exadata Database services.

- Identify the Azure region where you want to deploy your Oracle Database@Azure and Exadata Database services. Ensure that this region aligns with your current or future Azure landing zone. If the region that you choose differs from your current deployment region, assess whether your existing monitoring tools can extend their capabilities to this new region. Ensure seamless integration and functionality across regions.

- Choose a network topology that best supports your migration method of choice when you create your network plan. Your migration method should monitor the process when you move your critical data. Options for migration include Oracle Recovery Manager, Oracle Data Guard, Oracle Data Pump, or a Linux VM that has the Network File System role installed. Consult with your Oracle and Microsoft representative for detailed guidance.

- Azure Arc management integration: Consider integrating Oracle Exadata Database@Azure infrastructure with [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) to enable unified management across hybrid environments. Arc provides additional monitoring and governance capabilities through [Azure Monitor](/azure/azure-monitor/overview) and [Azure Policy](/azure/governance/policy/overview) while preserving existing OCI console functionality for database-specific operations.

  For network connectivity requirements and configuration guidance for Arc integration, see [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md).

- Hybrid monitoring strategy: Plan for a comprehensive monitoring approach that differentiates between the three types of monitoring available for Oracle Database@Azure deployments:
  - **VM Cluster metrics**: Oracle Database@Azure provides native metrics through Azure Monitor for different service types:
    - [Oracle Exadata VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-exadbvmclusters-metrics) for Exadata Database@Azure
    - [Oracle VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics) for general Oracle Database@Azure clusters
    - [Autonomous Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-autonomousdatabases-metrics) for Oracle Autonomous Database@Azure
  - **Diagnostic logs**: Oracle Database@Azure includes [diagnostic settings](/azure/oracle/oracle-db/oracle-exadata-database-dedicated-infrastructure-logs) for database operations and infrastructure events
  - **VM-level monitoring**: Azure Arc enables [infrastructure monitoring](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server) for the individual virtual machines that comprise the VM cluster
  
  Establish clear boundaries between database-level monitoring (handled through OCI and Azure native metrics) and VM infrastructure monitoring (handled through Azure Arc).

- Security monitoring integration: Evaluate the integration of [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) with existing Oracle security monitoring to provide comprehensive threat detection and response capabilities. This integration enhances your security posture without duplicating existing Oracle Advanced Security features.

- Log Analytics workspace design: If you implement Azure Arc integration, design your Log Analytics workspace strategy to complement the existing three-tier monitoring approach for Oracle Database@Azure:
  - **VM Cluster metrics**: Already collected through Azure Monitor metrics for different Oracle Database@Azure service types:
    - [Exadata VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-exadbvmclusters-metrics)
    - [Oracle VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics)
    - [Autonomous Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-autonomousdatabases-metrics)
  - **Diagnostic logs**: Already available through [diagnostic settings](/azure/oracle/oracle-db/oracle-exadata-database-dedicated-infrastructure-logs) for database operations
  - **Arc-enabled VM monitoring**: New capability for [individual VM monitoring](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server) within the VM cluster
  
  Consider workspace isolation requirements and log retention policies that align with your existing Oracle audit and compliance requirements.

- Determine how to integrate monitor alerts into your triage process.
- Make a list of key stakeholders that you need to notify when an alert is triggered.
- Review monitoring metrics with database administrators to align expectations.

For more information, see [Plan for Oracle on Azure adoption](/azure/cloud-adoption-framework/scenarios/oracle-on-azure/oracle-landing-zone-plan).

## Design recommendations

Consider these recommendations before you deploy Oracle Database@Azure and Exadata Database services.

### Monitor for health and performance

You should collect quantitative metrics such as CPU usage, memory usage, storage usage, database operations, SQL queries, and overall transactions. You can use Azure Monitor metrics, Azure Arc monitoring capabilities, or your monitoring tool of choice to diagnose and proactively troubleshoot problems. The collection and review of database metrics helps to ensure operational readiness and long-term sustainment.

**Azure Arc monitoring integration**: When you onboard Oracle Exadata Database@Azure infrastructure to [Azure Arc-enabled servers](/azure/azure-arc/servers/overview), you add a third monitoring layer to the existing Oracle Database@Azure monitoring capabilities. This creates a comprehensive three-tier monitoring approach:

**Three-tier monitoring approach**: Create monitoring dashboards that leverage all available monitoring capabilities:
- **VM Cluster level**: Use Azure Monitor metrics appropriate to your Oracle Database@Azure deployment type:
  - [Oracle Exadata VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-exadbvmclusters-metrics) for Exadata Database@Azure deployments
  - [Oracle VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics) for standard Oracle Database@Azure clusters
  - [Autonomous Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-autonomousdatabases-metrics) for Autonomous Database@Azure deployments
- **Database operations**: Use [diagnostic settings](/azure/oracle/oracle-db/oracle-exadata-database-dedicated-infrastructure-logs) for database-specific logs and operations
- **Individual VM monitoring**: Use [Azure Arc-enabled server monitoring](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server) for operating system level metrics, security events, and compliance monitoring on each VM within the cluster

- Create a custom dashboard in the Azure portal with an aggregated view of the various metrics collected. For more information, see [Create a dashboard in the Azure portal](/azure/azure-portal/azure-portal-dashboards).

- To review the required roles, see [Roles, permissions, and security in Azure Monitor](/azure/azure-monitor/roles-permissions-security).
- If you require granular database monitoring, see [Enterprise Manager database management](https://www.oracle.com/database/technologies/manageability.html).
- For information about the Oracle comprehensive monitoring guide, see [Oracle Cloud database metrics](https://docs.oracle.com/iaas/database-management/doc/oracle-cloud-database-metrics.html).

### Monitor key metrics

The following table contains initial recommended settings for Oracle Cloud Database metrics. You can add counters based on your organization's needs. Set each monitoring setting against all the available nodes in the cluster. In Azure Monitor, you can't select multiple objects at the same time when you add metrics. To enter specified settings, you must select each Exadata cluster node.

Set alerts in your monitoring solution for critical workloads. If you use Azure Monitor, you can create [action groups](/azure/azure-monitor/alerts/action-groups).

|  Metric name                                   |  Collection frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| CPU Utilization                                        | 5 minutes                                               | 90%                           | The CPU usage that's expressed as a percentage and aggregated across all consumer groups. The usage percentage is reported with respect to the number of CPUs that the database can use, which is two times the number of Oracle CPUs. This setting is for each database within the cluster. |
| Storage Utilization                                    | 30 minutes                                              | 90%                            | The percentage of provisioned storage capacity that's in use. This setting represents the total allocated space for all tablespaces. This setting is for each database within the cluster.|
| Flash Recovery Area Utilization                        | 15 minutes                                              | 90%                            | The flash recovery area usage.    |
| Memory Usage                                           | 15 minutes                                              | Megabit  90% consumed             | The total size of the memory pool.      |
| Process Limit Utilization                             |   5 minutes                                             | 90%                            | The process limit usage.          |
| Session Limit Utilization                              |   5 minutes                                             | 90%                            | The database session limit usage. |
| Usable Fast Recovery Area                              | 15 minutes                                              | 90%                            | The usable fast recovery area.          |
| Oracle Cloud Infrastructure (OCI) Database Cluster Memory Utilization                | 5 minutes                                               | 90%                            | The amount of memory that the Exadata Database clusters consume. |
| Average Node Status                                    | 5 minutes                                               | 0 (this dimension means false) | Whether the Exadata Database cluster node within the cluster is available or unavailable. |

For more information, see [Oracle Cloud Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics).

### Monitor Azure Arc integration

If you enable Azure Arc for your Oracle Exadata Database@Azure infrastructure, monitor the following additional VM-level components to complement existing cluster and database monitoring:

Oracle Database@Azure provides three distinct monitoring capabilities:
- **VM Cluster metrics**: Available through Azure Monitor metrics, with different metric sets depending on your deployment type:
  - [Exadata VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-exadbvmclusters-metrics) for Exadata Database@Azure
  - [Oracle VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics) for standard Oracle Database@Azure
  - [Autonomous Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-autonomousdatabases-metrics) for Autonomous Database@Azure

**Arc-enabled VM monitoring additions**:
- Azure Arc agent connectivity: Monitor the connection status of Arc agents on each VM within the Exadata cluster
- VM-level security posture: Track security recommendations and alerts from Microsoft Defender for Cloud for each individual VM
- Operating system compliance: Monitor Azure Policy compliance for OS-level configurations on each VM
- VM performance metrics: Collect OS-level performance data that complements cluster-wide metrics

For detailed guidance on Azure Arc monitoring, see [Monitor Azure Arc-enabled servers with Azure Monitor](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights).

### Security monitoring integration with Defender

Integrate Microsoft Defender for Cloud security monitoring with existing Oracle Database@Azure monitoring practices:

**Centralized security dashboards**: Create unified security monitoring using [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-overview) and [Microsoft Defender for Cloud dashboards](/azure/defender-for-cloud/overview-page). Combine Microsoft Defender security alerts with Oracle Enterprise Manager monitoring and OCI security controls.

**Automated threat response workflows**: Implement [Defender workflow automation](/azure/defender-for-cloud/workflow-automation) and [security incident response procedures](/azure/defender-for-cloud/managing-and-responding-alerts) that coordinate Azure security context with Oracle operational requirements.

**Compliance and security reporting**: Establish reporting using [Defender compliance assessments](/azure/defender-for-cloud/regulatory-compliance-dashboard) combined with Oracle security audit reports. For comprehensive security metrics, see [Azure Monitor security monitoring](/azure/azure-monitor/security/overview).


**Arc-enabled server metrics**: If you enable Azure Arc for your Oracle Exadata Database@Azure infrastructure, monitor the following additional metrics to complement existing database and cluster monitoring. These metrics provide visibility into the Arc agent connectivity and security posture at the VM level. See [Management and monitoring for Azure Arc-enabled servers](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server#azure-monitor-configuration)

|  Metric name                                   |  Collection frequency                                   | Threshold                    | Description                                  |
| :------------------------------------------------------|:--------------------------------------------------------|:-----------------------------|:---------------------------------------------|
| Defender Threat Detection Status               | 5 minutes        | Any active threats           | Status of active threat detection and security alerts from Microsoft Defender for Cloud on Arc-enabled infrastructure |
| Security Baseline Compliance Score            | 1 hour           | < 80%                       | Overall security compliance score from Defender security baseline assessments across VM cluster nodes |
| Vulnerability Assessment Status                | Daily            | High/Critical vulnerabilities| Count and severity of vulnerabilities identified by Defender vulnerability scanning on infrastructure |
| Defender Agent Health Status                   | 10 minutes       | Unhealthy                   | Health status of Microsoft Defender agents and extensions on each Arc-enabled VM cluster node |
| Arc Agent Status                                       | 5 minutes                                               | 0 (disconnected)               | Connection status of Azure Arc agents on each VM within the Exadata cluster. Monitor for agent connectivity issues. |
| Arc-enabled Server Health                              | 10 minutes                                              | Unhealthy                      | Overall health status of Arc-enabled servers including extension health and resource status. |
| Defender Security Alert Count                          | 15 minutes                                              | > 0 (any active alerts)        | Count of active security alerts from Microsoft Defender for Cloud for Arc-enabled infrastructure. |
| Azure Policy Compliance                                | 30 minutes                                              | Non-compliant                  | Policy compliance status for Arc-enabled servers including OS-level configuration compliance. |



## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
