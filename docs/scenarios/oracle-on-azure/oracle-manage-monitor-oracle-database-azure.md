---
title: Manage and monitor Oracle Database@Azure
description: Learn about considerations and recommendations that you can use to manage and monitor your Oracle Database@Azure and Exadata Database services.
author: sihbher
ms.author: rajanaki
ms.reviewer: bhbandam
ms.date: 09/03/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Manage and monitor Oracle Database@Azure

This article provides management and monitoring guidance for Oracle Database@Azure deployments. These recommendations enable comprehensive visibility, proactive issue resolution, and optimal performance across your Oracle Database@Azure infrastructure while integrating with Azure native monitoring capabilities.

Oracle Database@Azure requires coordinated monitoring across database, infrastructure, and security layers. Implement these recommendations to establish robust monitoring practices that support operational excellence and business continuity for your Oracle Autonomous Database@Azure and Oracle Exadata Database@Azure services.

## Establish comprehensive monitoring strategy

Implement a three-tier monitoring approach that provides visibility across database operations, infrastructure health, and security posture. This comprehensive strategy ensures complete operational coverage while avoiding monitoring gaps.

1. **Deploy three-tier monitoring architecture**. Oracle Database@Azure provides monitoring capabilities across three distinct layers that work together to provide complete operational visibility. Deploy all three layers to ensure comprehensive coverage: VM cluster monitoring through Azure Monitor, diagnostic log collection through Azure Monitor and Log Analytics, and individual VM monitoring through Azure Arc-enabled servers. For Azure Arc integration guidance, see [Azure Arc connectivity design for Oracle Database@Azure](azure-arc-connectivity-design.md).

2. **Configure Azure Monitor for VM cluster metrics**. Set up Azure Monitor to collect cluster-level performance metrics specific to your Oracle Database@Azure deployment type. Use [Oracle Exadata VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-exadbvmclusters-metrics) for Exadata deployments, [Oracle VM Cluster metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics) for standard clusters, and [Autonomous Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-autonomousdatabases-metrics) for Autonomous Database deployments.

3. **Enable diagnostic settings for enhanced observability**. Configure [diagnostic settings for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-exadata-database-dedicated-infrastructure-logs) to collect comprehensive operational data. This configuration captures Exadata VM cluster lifecycle management logs, database logs, infrastructure logs, and Data Guard logs through Azure Monitor and Log Analytics for centralized analysis.

4. **Integrate Azure Arc for infrastructure monitoring**. Enable [Azure Arc-enabled server monitoring](/azure/cloud-adoption-framework/scenarios/hybrid/arc-enabled-servers/eslz-management-and-monitoring-arc-server) to monitor operating system level metrics, security events, and compliance status on each VM within the cluster. This integration provides unified governance while preserving existing OCI console functionality for database-specific operations.

## Configure critical performance monitoring

Establish proactive monitoring for key performance indicators that directly impact business operations. Configure alerts and thresholds that enable early detection of issues before they affect service availability.

1. **Monitor database performance metrics with appropriate thresholds**. Configure monitoring for critical database metrics using proven thresholds that indicate potential issues. Set CPU utilization monitoring at 90% threshold with 5-minute collection frequency, storage utilization at 90% with 30-minute frequency, and memory usage at 90% with 15-minute frequency. For complete metric specifications, see the [database and cluster metrics reference table](#database-and-cluster-metrics) below.

2. **Implement Azure Arc agent monitoring for infrastructure health**. Monitor Azure Arc agent connectivity and health status to ensure continuous management capabilities. Configure Arc agent status monitoring with 5-minute frequency and immediate alerting for disconnected status, Arc-enabled server health monitoring with 10-minute frequency, and Azure Policy compliance monitoring with 30-minute frequency for configuration drift detection.

3. **Create unified monitoring dashboard**. Build a [custom dashboard in the Azure portal](/azure/azure-portal/azure-portal-dashboards) that aggregates metrics from all three monitoring layers. This unified view provides operators with complete visibility across database performance, infrastructure health, and security status without switching between multiple tools.

4. **Configure alert action groups for incident response**. Set up [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups) that automatically notify appropriate stakeholders when critical thresholds are exceeded. Configure escalation procedures that coordinate database administrators, infrastructure teams, and security personnel based on alert severity and type.

## Integrate security monitoring capabilities

Enhance operational security through integrated monitoring that combines Azure native security tools with existing Oracle security practices. This integration provides comprehensive threat detection without duplicating existing security investments.

1. **Deploy Microsoft Defender for Cloud integration**. Integrate [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) with Oracle Database@Azure infrastructure to provide comprehensive threat detection and security posture management. This integration enhances existing Oracle Advanced Security features with Azure native threat intelligence and automated response capabilities.

2. **Create unified security monitoring dashboards**. Build security monitoring using [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-overview) that combine Microsoft Defender security alerts, Oracle Enterprise Manager security monitoring, OCI security group events, and Arc infrastructure compliance status. This unified approach provides complete security visibility across both platforms.

3. **Implement automated threat response workflows**. Configure [Defender workflow automation](/azure/defender-for-cloud/workflow-automation) and [security incident response procedures](/azure/defender-for-cloud/managing-and-responding-alerts) with Oracle-specific considerations. Set up automated VM isolation that maintains database availability during security incidents and create incident tickets that include both Azure security context and Oracle operational impact assessment.

4. **Monitor security-focused metrics for compliance**. Track [Defender threat detection status](/azure/defender-for-cloud/managing-and-responding-alerts) with 5-minute frequency for active threats, [security baseline compliance score](/security/benchmark/azure/baselines/microsoft-defender-for-cloud-security-baseline) hourly with 80% threshold, and [vulnerability assessment status](/defender-vulnerability-management/tvm-dashboard-insights) daily for high and critical vulnerabilities.

For comprehensive security guidance, see [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md).

## Design Log Analytics workspace strategy

Configure Log Analytics workspaces that complement existing Oracle monitoring while providing centralized analysis capabilities. Design workspace architecture that supports compliance requirements and operational efficiency.

1. **Plan workspace isolation based on compliance requirements**. Design [Log Analytics workspace](/azure/azure-monitor/logs/log-analytics-workspace-overview) architecture that aligns with existing Oracle audit and compliance requirements. Consider workspace isolation for different environments (production, development, testing) and data residency requirements that may affect log storage and analysis capabilities.

2. **Configure log retention policies aligned with Oracle audit requirements**. Set log retention policies that meet organizational compliance requirements while optimizing storage costs. Align Azure Monitor log retention with existing Oracle audit log retention policies to ensure consistent compliance coverage across both platforms.

3. **Establish clear monitoring boundaries between platforms**. Define clear boundaries between database-level monitoring handled through OCI and Azure native metrics versus VM infrastructure monitoring handled through Azure Arc. This separation prevents monitoring overlap while ensuring complete coverage of all system components.

4. **Implement workspace access controls with role-based permissions**. Configure workspace access using [Azure Monitor roles and permissions](/azure/azure-monitor/roles-permissions-security) that align with existing organizational responsibilities. Ensure database administrators have appropriate access to database metrics while infrastructure teams have access to VM-level monitoring data.

## Plan migration monitoring integration

Coordinate monitoring capabilities with migration planning to ensure visibility during data movement operations. Configure monitoring that supports your chosen migration methodology while maintaining operational oversight.

1. **Align monitoring with migration methodology**. Configure monitoring that supports your chosen migration approach whether using Oracle Recovery Manager, Oracle Data Guard, Oracle Data Pump, or Linux VM with Network File System role. Each migration method requires specific monitoring focus areas to ensure successful data movement and validation.

2. **Extend monitoring across Azure regions when required**. If Oracle Database@Azure deployment spans multiple Azure regions, assess whether existing monitoring tools can extend capabilities to new regions. Plan for monitoring tool distribution and ensure seamless integration and functionality across all deployment regions.

3. **Coordinate with Oracle and Microsoft representatives for migration monitoring**. Engage Oracle and Microsoft representatives during migration planning to ensure monitoring configurations support migration validation and rollback procedures. This coordination ensures monitoring capabilities align with migration timeline and success criteria.

4. **Document monitoring integration points for stakeholder communication**. Create documentation that identifies key stakeholders for different alert types and establishes clear communication procedures. Map monitoring alerts to appropriate response teams and define escalation procedures that coordinate database administrators, infrastructure teams, and business stakeholders.

## Database and cluster metrics

The following table contains recommended settings for Oracle Database@Azure metrics. Configure alerts for these metrics across all available nodes in the cluster to ensure comprehensive monitoring coverage.

| Metric name | Collection frequency | Threshold | Description |
|-------------|---------------------|-----------|-------------|
| CPU Utilization | 5 minutes | 90% | CPU usage percentage aggregated across all consumer groups, reported with respect to database-available CPUs |
| Storage Utilization | 30 minutes | 90% | Percentage of provisioned storage capacity in use across all tablespaces |
| Flash Recovery Area Utilization | 15 minutes | 90% | Flash recovery area usage percentage |
| Memory Usage | 15 minutes | 90% | Total memory pool consumption |
| Process Limit Utilization | 5 minutes | 90% | Database process limit usage percentage |
| Session Limit Utilization | 5 minutes | 90% | Database session limit usage percentage |
| OCI Database Cluster Memory Utilization | 5 minutes | 90% | Memory consumption by Exadata Database clusters |
| Average Node Status | 5 minutes | 0 (false) | Availability status of Exadata Database cluster nodes |

For complete metric reference, see [Oracle Cloud Database metrics](/azure/azure-monitor/reference/supported-metrics/oracle-database-cloudvmclusters-metrics).

## Azure Arc-enabled server metrics

When Azure Arc is enabled for Oracle Database@Azure infrastructure, monitor these VM-level components to complement existing cluster and database monitoring:

| Metric name | Collection frequency | Threshold | Description |
|-------------|---------------------|-----------|-------------|
| Arc Agent Status | 5 minutes | 0 (disconnected) | Connection status of Azure Arc agents on each VM within the cluster |
| Arc-enabled Server Health | 10 minutes | Unhealthy | Overall health status including extension health and resource status |
| Azure Policy Compliance | 30 minutes | Noncompliant | Policy compliance status for OS-level configuration |

For detailed Azure Arc monitoring guidance, see [Monitor Azure Arc-enabled servers with Azure Monitor](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights).

## Security monitoring metrics

Monitor these security-focused metrics when Microsoft Defender for Cloud is integrated with Oracle Database@Azure infrastructure:

| Metric name | Collection frequency | Threshold | Description |
|-------------|---------------------|-----------|-------------|
| Defender Threat Detection Status | 5 minutes | Any active threats | Status of active threat detection and security alerts |
| Security Baseline Compliance Score | 1 hour | < 80% | Overall security compliance score from Defender assessments |
| Vulnerability Assessment Status | Daily | High/Critical vulnerabilities | Count and severity of identified vulnerabilities |

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Monitoring | [Azure Monitor](/azure/azure-monitor/overview) | Comprehensive monitoring platform for Oracle Database@Azure metrics |
| Visualization | [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-overview) | Custom dashboards for unified monitoring views |
| Log Analytics | [Log Analytics workspace](/azure/azure-monitor/logs/log-analytics-workspace-overview) | Centralized log analysis and retention |
| Alerting | [Azure Monitor action groups](/azure/azure-monitor/alerts/action-groups) | Automated notification and response workflows |
| Security | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Integrated security monitoring and threat protection |
| Hybrid Management | [Azure Arc-enabled servers](/azure/azure-arc/servers/overview) | Infrastructure monitoring and governance for Oracle VMs |
| Compliance | [Azure Policy](/azure/governance/policy/overview) | Configuration compliance and governance policies |

## Next steps
- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](oracle-network-topology-odaa.md)
- [Business continuity and disaster recovery for Oracle Database@Azure](oracle-disaster-recovery-oracle-database-azure.md)
