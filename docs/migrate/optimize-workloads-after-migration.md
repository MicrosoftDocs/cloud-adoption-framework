---
title: Optimize workloads post-migration
description: Comprehensive guide for post-migration workload optimization in Azure, covering performance fine-tuning, cost management, monitoring validation, backup verification, user feedback collection, operations team readiness, hybrid dependency management, and architecture reviews to ensure efficient, secure, and cost-effective cloud operations.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Optimize workloads post-migration

A successful migration does not end at cutover. Post-migration optimization ensures workloads operate efficiently, securely, and cost-effectively in Azure. This phase overlaps with ongoing operations and sets the foundation for long-term cloud maturity.

## Fine-tune workload configurations

A workload’s behavior often changes after migration due to differences in infrastructure, scaling, and service architecture. Immediate configuration adjustments help stabilize performance and reduce unnecessary costs.

1. **Use Azure Advisor to identify optimization opportunities.** [Azure Advisor](/azure/advisor/advisor-overview) provides tailored recommendations across cost, performance, reliability, and security. These insights help you prioritize actions based on impact and feasibility. Access Azure Advisor from the Azure portal and review recommendations by category.

2. **Apply service-specific configuration guidance.** Each Azure service has unique tuning parameters. Use the Azure Well-Architected Framework [Azure services guides](/azure/well-architected/service-guides/?product=popular) to align configurations with best practices. This ensures workloads are optimized for Azure-native capabilities.

3. **Review Microsoft Defender for Cloud recommendations.** [Microsoft Defender for Cloud](/azure/defender-for-cloud/review-security-recommendations) identifies security misconfigurations and vulnerabilities. Address these issues early to reduce risk exposure and align with your organization’s security posture.

## Monitor and control costs

Cost visibility and control become essential immediately after migration. Azure's elasticity benefits organizations but requires active monitoring to prevent cost inefficiencies from scaling automatically.

1. **Enable Azure Cost Management budgets and configure automated alerts.** Use [Microsoft Cost Management](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) to establish budget thresholds at your target spending level (100%), ideal spending level (90%), and warning threshold (110%). Configure automated alerts to notify stakeholders when spending approaches or exceeds these thresholds. Set up forecast alerts to provide advance notification when spending trends indicate budget overruns.

2. **Analyze resource utilization patterns using Azure Advisor recommendations.** Use [Azure Advisor cost recommendations](/azure/advisor/advisor-cost-recommendations) to identify underutilized virtual machines, unattached disks, and overprovisioned resources. Review metrics including CPU utilization, memory consumption, and storage usage across a 7-day period to detect resources that can be rightsized or deallocated. Implement the suggested optimizations to reduce waste without affecting performance.

3. **Implement cost anomaly detection for proactive monitoring.** Enable [cost anomaly detection](/azure/cost-management-billing/understand/analyze-unexpected-charges) to identify unexpected spending patterns that budget alerts might miss. Configure anomaly alerts to notify you of unusual cost variations that could indicate inefficiencies or security issues. Use these insights to investigate root causes and implement corrective actions promptly.

4. **Evaluate specialized cost optimization tools for complex environments.** For multi-subscription or hybrid environments, assess third-party cost optimization solutions based on their Azure integration capabilities, reporting granularity, and automation features. Consider tools that provide advanced analytics, automated scaling recommendations, and support for hybrid and multi-cloud cost management.

## Validate monitoring and alerting

Comprehensive monitoring ensures workloads perform optimally and enables proactive issue resolution. Post-migration monitoring validation establishes the foundation for reliable operations.

1. **Verify data collection rules capture essential metrics and logs.** Validate that performance, availability, and usage metrics are captured for all critical components. Adjust data collection rules if gaps exist. Review [Azure Monitor data collection rules (DCRs)](/azure/azure-monitor/data-collection/data-collection-rule-overview) to validate that performance, availability, and security metrics are collected from all critical workload components. Review DCR metrics including "Logs Ingestion Bytes per Min" and "Logs Rows Received per Min" to confirm data flow. Address any gaps by updating data collection configurations or creating additional DCRs for missing components.

2. **Test alert rules using multiple alert types and dynamic thresholds.** Configure [metric alerts](/azure/azure-monitor/alerts/alerts-types#metric-alerts) for performance thresholds, [log alerts](/azure/azure-monitor/alerts/alerts-types#log-alerts) for application-specific conditions, and [activity log alerts](/azure/azure-monitor/alerts/alerts-types#activity-log-alerts) for resource changes. Use [dynamic thresholds](/azure/azure-monitor/alerts/alerts-dynamic-thresholds) for metrics with seasonal patterns and static thresholds for known limits. Test alert workflows using controlled scenarios to validate notification delivery, escalation paths, and response procedures.

3. **Implement Azure Monitor Baseline Alerts for comprehensive coverage.** Deploy [Azure Monitor Baseline Alerts (AMBA)](https://aka.ms/amba) to establish industry-standard monitoring across your Azure services. These pre-configured alerts provide immediate visibility into common failure scenarios and performance degradation patterns. Customize alert severity levels and notification recipients based on your operational requirements.

4. **Create workbooks and dashboards for operational visibility.** Build [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-overview) that combine metrics, logs, and alerts into unified views for different stakeholder groups. Include key performance indicators (KPIs) such as response times, error rates, and resource utilization. Configure dashboards to reflect your post-migration architecture and enable drill-down capabilities for detailed troubleshooting.

5. **Enable proactive monitoring with DCR error logs and anomaly detection.** Activate [DCR error logs](/azure/azure-monitor/data-collection/data-collection-monitor#enable-dcr-error-logs) to capture detailed information about data processing failures. Monitor DCR health using metrics like "Logs Transformation Errors per Min" and "Logs Rows Dropped per Min". Set up alerts for sudden changes in data collection patterns that might indicate configuration issues or data source problems.

For comprehensive monitoring guidance, see [Monitor your Azure cloud estate](/azure/cloud-adoption-framework/manage/monitor).

## Validate backup and recovery

A validated backup and recovery process ensures that critical data remains protected and recoverable in the event of failure, corruption, or loss. This validation is essential to meet business continuity goals and regulatory requirements. You should follow these steps to confirm that your backup and recovery strategy is reliable, compliant, and operationally effective.

1. **Verify backup jobs are configured and running successfully.** Identify mission-critical systems and ensure they are included in your backup scope. Use Azure Backup or third-party tools that support Azure workloads.
Monitor backup job status daily. Use Azure Backup Reports in Azure Monitor or Recovery Services Vault to track job success, failures, and trends. Set up alerts for failed or missed jobs. Investigate and resolve failures immediately. Review error codes and logs to determine root causes. Common issues include network interruptions, storage limits, or misconfigured policies.

2. **Test restore procedures.** Perform test restores for critical workloads to validate recovery time objectives (RTOs) and recovery point objectives (RPOs). 
- Document the results and update runbooks accordingly. Use Azure Backup’s “Restore” feature to recover data to a test environment. Validate that the restored data is complete and usable.
Document test results and update runbooks. Record the time taken, data integrity, and any issues encountered. Update operational procedures to reflect lessons learned.

3. **Review backup policies for compliance.** Ensure backup retention and encryption settings align with organizational and regulatory requirements.

    - Audit retention settings. Ensure that backup retention meets business and legal requirements (7 years for financial data).
    - Verify encryption settings. Confirm that data is encrypted at rest and in transit using customer-managed keys (CMK) if required.
    - Review policy scope and frequency. Ensure that backup frequency aligns with data change rates and business continuity needs.

For data reliability, see [Manage data reliability](/azure/cloud-adoption-framework/manage/protect#manage-data-reliability).

## Collect and act on user feedback

User feedback provides real-world validation of workload performance and usability.

1. **Gather structured feedback from end users.** Use surveys, interviews, or support tickets to collect feedback on performance, reliability, and usability.

2. **Document and prioritize issues.** Track feedback in a centralized system and categorize by severity and impact. Address high-priority issues promptly.

3. **Share positive outcomes.** Highlight improvements such as faster response times or increased availability to reinforce migration success.

## Prepare operations teams for Azure

Operational readiness reduces downtime and accelerates incident response.

1. **Provide targeted training and documentation.** Create quick-reference guides for common tasks such as restarting services, accessing logs, or scaling resources.

2. **Ensure access to monitoring, backup, and security tools.** Confirm that operations teams have the necessary permissions and tools to manage workloads effectively.

3. **Establish escalation paths and support contacts.** Document who to contact for different types of issues and ensure this information is easily accessible.

For more information, see [Ready your Azure cloud operations ](/azure/cloud-adoption-framework/manage/ready#document-your-cloud-operations).

## Monitor hybrid and multi-cloud dependencies

Hybrid and multi-cloud architectures introduce complexity that requires additional monitoring.

1. **Monitor cross-cloud and on-premises dependencies.** Use tools like Azure Arc and Network Watcher to track latency, availability, and connectivity between environments.

2. **Secure hybrid connections.** Ensure VPNs, ExpressRoute, or other connectivity solutions are configured securely and monitored for anomalies.

3. **Plan to reduce external dependencies.** Identify opportunities to replace third-party or on-premises components with Azure-native services to simplify architecture and reduce risk.

## Schedule regular architecture reviews

Architecture reviews help identify modernization opportunities and prevent technical debt.

1. **Conduct quarterly reviews.** Use the [Azure Well-Architected Framework](/azure/well-architected/). Evaluate workloads across cost, performance, reliability, security, and operational excellence.

2. **Create a backlog of modernization opportunities.** Document findings and prioritize based on business value, risk reduction, and technical debt.

3. **Assign ownership for follow-up actions.** Designate responsibl structure and includes embedded links to relevant Azure tos and documentation.

## Post-migration checklist

| Task Category | Action | Priority | Timeline | Key Tools/Resources |
|---------------|--------|----------|----------|-------------------|
| **Performance Tuning** | Use Azure Advisor to identify optimization opportunities | High | Week 1 | [Azure Advisor](/azure/advisor/advisor-overview) |
| **Performance Tuning** | Apply service-specific configuration guidance | High | Week 1-2 | [Azure Well-Architected Framework service guides](/azure/well-architected/service-guides/?product=popular) |
| **Performance Tuning** | Review Microsoft Defender for Cloud recommendations | High | Week 1 | [Microsoft Defender for Cloud](/azure/defender-for-cloud/review-security-recommendations) |
| **Cost Management** | Enable Azure Cost Management and set budgets | High | Week 1 | [Microsoft Cost Management](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) |
| **Cost Management** | Analyze resource utilization to identify overprovisioning | Medium | Week 2 | Azure Monitor, Cost Management |
| **Cost Management** | Consider third-party cost optimization tools | Low | Month 1 | Third-party tools evaluation |
| **Monitoring** | Confirm Azure Monitor is collecting the right metrics | High | Week 1 | Azure Monitor |
| **Monitoring** | Test alert rules and thresholds | High | Week 1-2 | Azure Monitor Alerts |
| **Monitoring** | Review dashboards for operational visibility | Medium | Week 2 | Azure Monitor Dashboards |
| **Backup & Recovery** | Verify backup jobs are configured and running successfully | High | Week 1 | Azure Backup |
| **Backup & Recovery** | Test restore procedures | High | Week 2 | Azure Backup |
| **Backup & Recovery** | Review backup policies for compliance | Medium | Week 2 | Azure Backup |
| **User Experience** | Gather structured feedback from end users | Medium | Week 2-3 | Surveys, support tickets |
| **User Experience** | Document and prioritize issues | Medium | Ongoing | Issue tracking system |
| **User Experience** | Share positive outcomes | Low | Month 1 | Communication channels |
| **Operations** | Provide targeted training and documentation | High | Week 1-2 | Training materials |
| **Operations** | Ensure access to monitoring, backup, and security tools | High | Week 1 | Azure RBAC |
| **Operations** | Establish escalation paths and support contacts | High | Week 1 | Documentation |
| **Hybrid/Multi-cloud** | Monitor cross-cloud and on-premises dependencies | Medium | Week 2 | Azure Arc, Network Watcher |
| **Hybrid/Multi-cloud** | Secure hybrid connections | High | Week 1 | VPN, ExpressRoute |
| **Hybrid/Multi-cloud** | Plan to reduce external dependencies | Low | Month 2+ | Architecture planning |
| **Architecture** | Conduct quarterly reviews | Medium | Quarterly | [Azure Well-Architected Framework](/azure/well-architected/) |
| **Architecture** | Create a backlog of modernization opportunities | Medium | Quarterly | Documentation system |
| **Architecture** | Assign ownership for follow-up actions | Medium | Quarterly | Project management |

## Next step

> [!div class="nextstepaction"]
> [Decommission source workloads](./decommission-source-workload.md)