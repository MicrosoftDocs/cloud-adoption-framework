---
title: Migrate overview
description: Prepare for a successful migration to Azure by using an iterative process to assess, deploy, and release workloads.
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

### Monitor and control costs

Cost visibility and control are critical immediately after migration. Azure’s elasticity can amplify inefficiencies if not monitored closely.

1. **Enable Azure Cost Management and set budgets.** Use [Microsoft Cost Management](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) to track spending trends and forecast future costs. Set budget thresholds and configure alerts to notify stakeholders when spending exceeds expectations.

2. **Analyze resource utilization to identify overprovisioning.** Review metrics such as CPU, memory, and disk usage to detect underutilized resources. Right-size or deallocate these resources to reduce waste.

3. **Consider third-party cost optimization tools.** For complex environments, third-party tools can provide deeper analytics and automation. Evaluate tools based on integration capabilities, reporting granularity, and support for hybrid/multi-cloud environments.

### Validate monitoring and alerting

Monitoring ensures workloads operate as expected and enables rapid response to issues.

1. **Confirm Azure Monitor is collecting the right metrics.** Validate that performance, availability, and usage metrics are captured for all critical components. Adjust data collection rules if gaps exist.

2. **Test alert rules and thresholds.** Ensure alerts trigger under expected conditions and notify the correct teams. Use test scenarios to validate alert workflows and escalation paths.

3. **Review dashboards for operational visibility.** Create or update dashboards to reflect post-migration architecture. Include key performance indicators (KPIs) relevant to business and technical stakeholders.

For monitoring guidance, see [Monitor your Azure cloud estate.](/azure/cloud-adoption-framework/manage/monitor).

### Validate backup and recovery

Backup validation ensures data protection and recoverability in the event of failure or data loss.

1. **Verify backup jobs are configured and running successfully.** Use tools like Azure Backup to monitor job status and resolve any failures promptly.

2. **Test restore procedures.** Perform test restores for critical workloads to validate recovery time objectives (RTOs) and recovery point objectives (RPOs). Document the results and update runbooks accordingly.

3. **Review backup policies for compliance.** Ensure backup retention and encryption settings align with organizational and regulatory requirements.

For data reliability, see [Manage data reliability](/azure/cloud-adoption-framework/manage/protect#manage-data-reliability).

### Collect and act on user feedback

User feedback provides real-world validation of workload performance and usability.

1. **Gather structured feedback from end users.** Use surveys, interviews, or support tickets to collect feedback on performance, reliability, and usability.

2. **Document and prioritize issues.** Track feedback in a centralized system and categorize by severity and impact. Address high-priority issues promptly.

3. **Share positive outcomes.** Highlight improvements such as faster response times or increased availability to reinforce migration success.

### Prepare operations teams for Azure

Operational readiness reduces downtime and accelerates incident response.

1. **Provide targeted training and documentation.** Create quick-reference guides for common tasks such as restarting services, accessing logs, or scaling resources.

2. **Ensure access to monitoring, backup, and security tools.** Confirm that operations teams have the necessary permissions and tools to manage workloads effectively.

3. **Establish escalation paths and support contacts.** Document who to contact for different types of issues and ensure this information is easily accessible.

For more information, see [Ready your Azure cloud operations ](/azure/cloud-adoption-framework/manage/ready#document-your-cloud-operations).

### Monitor hybrid and multi-cloud dependencies

Hybrid and multi-cloud architectures introduce complexity that requires additional monitoring.

1. **Monitor cross-cloud and on-premises dependencies.** Use tools like Azure Arc and Network Watcher to track latency, availability, and connectivity between environments.

2. **Secure hybrid connections.** Ensure VPNs, ExpressRoute, or other connectivity solutions are configured securely and monitored for anomalies.

3. **Plan to reduce external dependencies.** Identify opportunities to replace third-party or on-premises components with Azure-native services to simplify architecture and reduce risk.

### Schedule regular architecture reviews

Architecture reviews help identify modernization opportunities and prevent technical debt.

1. **Conduct quarterly reviews.** Use the [Azure Well-Architected Framework](/azure/well-architected/). Evaluate workloads across cost, performance, reliability, security, and operational excellence.

2. **Create a backlog of modernization opportunities.** Document findings and prioritize based on business value, risk reduction, and technical debt.

3. **Assign ownership for follow-up actions.** Designate responsible teams or individuals to ensure recommendations are implemented and tracked.

Here is prescriptive, actionable guidance for decommissioning old workloads after migration to Azure, aligned with the Cloud Adoption Framework. This guidance follows the required structure and includes embedded links to relevant Azure tools and documentation.

## Next steps

> [!div class="nextstepaction"]
> https://learn.microsoft.com/azure/cloud-adoption-framework/manage/

