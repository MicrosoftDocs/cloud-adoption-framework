---
title: Monitor your Azure cloud estate
description: Learn how to monitor your Azure cloud estate, workloads, other cloud environments, on-premises, and edge environment.
author: stephen-sumner
ms.author: pnp
ms.date: 04/01/2025
ms.topic: concept-article
products: azure-monitor
ms.custom: UpdateFrequency2
---

# Monitor your Azure cloud estate

This article explains how to plan, configure, and optimize monitoring across Azure while integrating data from other clouds, on-premises, and edge environments. Monitoring your Azure cloud estate involves continuously observing and analyzing the performance, health, and security of your cloud resources and applications.

:::image type="content" source="./media/caf-manage-monitor.svg" alt-text="Diagram showing the CAF Manage process: ready, administer, monitor, and protect (RAMP)." lightbox="./media/caf-manage-monitor.svg" border="false":::

## Identify your monitoring scope

Monitoring responsibilities vary by deployment model. Use the following table to identify your monitoring responsibilities for infrastructure (IaaS), platform (PaaS), software (SaaS), and on-premises deployments.

| Monitoring areas    | On-premises | IaaS (Azure) | PaaS (Azure) | SaaS |
|---------------------|------------------------|-------------------------|-------------------------|-----------------|
| Service health      | ✔️                     | ✔️                      | ✔️                      | ✔️              |
| Security            | ✔️                     | ✔️                      | ✔️                      | ✔️              |
| Compliance          | ✔️                     | ✔️                      | ✔️                      | ✔️              |
| Cost                | ✔️                     | ✔️                      | ✔️                      | ✔️              |
| Data                | ✔️                     | ✔️                      | ✔️                      | ✔️              |
| Code and runtime    | ✔️                     | ✔️                      | ✔️                      |                 |
| Cloud resources     | ✔️                     | ✔️                      | ✔️                      |                 |
| Operating system    | ✔️                     | ✔️                      |                         |                 |
| Virtualization layer| ✔️                     | ✔️                      |                         |                 |
| Physical hardware   | ✔️                     |                         |                         |                 |

## Plan your monitoring strategy

A monitoring strategy outlines your requirements across every environment. The goal of monitoring is to detect and respond to issues in real time, diagnose current or past issues, and predict and prevent future issues. Here's how:

1. **Define your monitoring approach.** Choose a centralized or shared management model based on your organization's size and complexity.

    | Monitoring approach | Responsibilities and scope | Best for| Pros | Cons|
    |---------------------|----------------------------|---------|------|-----|
    | Centralized | Manage all monitoring tasks centrally.| Startups or small cloud footprint. | Simplified governance and cost control.| Potential for operational bottlenecks.|
    | Shared management | Centrally monitor health, security, compliance, cost, data, and shared services. <br><br>Workload teams monitor workloads. | Enterprises with multiple workloads. | Balances governance with workload-level agility. <br><br>Improves response speed and accountability. | Requires clear role definitions and ongoing coordination.|

1. **Identify what you need to monitor.** Take a thorough inventory of your Azure estate. Include other clouds, edge deployments, and on-premises systems as needed. Use [Azure Resource Graph Explorer](/azure/governance/resource-graph/first-query-portal) to locate all Azure resources. Start with the sample [queries](/azure/governance/resource-graph/samples/starter). Use [Azure Arc](/azure/azure-arc/overview) to bring monitoring data from on-premises, other clouds, or edge locations into Azure.

1. **Define data collection requirements.** Determine which metrics and logs you must collect for compliance, security, and effective issue diagnosis. Meet regulatory compliance requirements and all internal governance rules. If you don't know what to collect, gather all available logs and metrics to avoid data gaps. It's a short-term solution that isn't cost efficient. When you have enough data, use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to estimate the cost of the collection long term and adjust the collection settings to meet your budget.

1. **Define data retention requirements.** Decide how long you must keep monitoring data to meet auditing and compliance needs. Proper retention policies enable historical analyses, support regulatory compliance, and preserve data for security investigations.

1. **Define alert requirements.** Determine which critical events must trigger alerts, such as resource outages, performance threshold breaches, or security anomalies. Categorize alerts by severity, outline response actions, and specify escalation paths so urgent events reach the right teams. Use [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-overview) to configure alert rules, notifications, and action groups. Proactive alerts ensure fast responses and minimize downtime.

1. **Test and refine your monitoring approach.** Verify that you capture the correct data and trigger alerts at the right thresholds. Adjust data collection and reliability targets based on new findings. Iterative improvements help you adapt to shifting business needs, monitoring gaps, and maintain optimal system performance.

## Design a monitoring solution

Designing a monitoring solution refers to creating a system for collecting and storing logs, metrics, and insights. A well-designed solution helps satisfy operational, security, and compliance needs. Here's how:

1. **Consolidate your monitoring solutions.** Use one platform to monitor Azure and on-premises, public cloud, and edge environments as needed. This consolidated approach streamlines your operations, prevents frequent tool-switching, and enables your team to detect and resolve issues quickly. Use [Azure Monitor](/azure/azure-monitor/fundamentals/overview) as your main monitoring solution. Use [Azure Arc](/azure/azure-arc/overview) to collect data from other clouds, on-premises, and edge deployments.

1. **Aim to centralize monitoring data.** Prefer fewer locations for storing logs and metrics. Fewer locations make it easier to manage and correlate data. There are reasons to have multiple locations to store and analyze monitoring data. For example, security operations, data residency, data resiliency, and number of Azure tenants are all factors that could require you to store your monitoring data in multiple locations. For more information, see [Design a Log Analytics workspace architecture](/azure/azure-monitor/logs/workspace-design).

1. **Understand where to send monitoring data.** Collect logs and metrics and store them in destinations that match your operational needs. Choose from these primary Azure destinations: Azure Log Analytics workspace ([interactive and long-term storage](/azure/azure-monitor/logs/data-retention-configure)), Azure Storage account (long-term storage), Azure Event Hubs (third-party SIEM integration), [Azure Data Explorer](/azure/data-explorer/ingest-data-no-code?tabs=diagnostic-metrics), and a partner solution. Where generally available, use [data collection rules](/azure/azure-monitor/data-collection/data-collection-rule-overview) to configure central monitoring data collection. Otherwise, use [diagnostic settings](/azure/azure-monitor/platform/diagnostic-settings).

1. **Automate monitoring.** You want an automated way to enforce your monitoring policies in larger environments.

    - *Use Azure Policy.* Enforce what you collect and where you send it with Azure Policy. Use Azure Policy to manage [data collection rules](/azure/azure-monitor/data-collection/data-collection-rule-associations). For diagnostic settings, use [built-in monitoring policies](/azure/azure-monitor/platform/diagnostic-settings-policy) and build custom policies as needed. Enforce the [installation of the Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-policy) on all virtual machines. If you're an Azure landing zone user, use Azure Policy to define your [Azure Monitor alert baseline](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor).

    - *Use infrastructure as code (IaC).* Use [infrastructure as code](/azure/azure-monitor/fundamentals/resource-manager-samples) to configure and deploy Azure Monitor resources at scale. This method is the professional way to manage your resources.

1. **Optimize monitoring spend.** Conduct regular reviews of the monitoring data you collect and store. What you collect, where you store it, and how long you store it affects the cost. Adjust storage retention periods to optimize cost without stopping the collection of certain monitoring data. To optimize costs further, stop collecting unhelpful logs. For more cost optimization tips, see [Cost optimization in Azure Monitor](/azure/azure-monitor/fundamentals/best-practices-cost).

## Configure monitoring

Set up the tools and parameters for collecting insights across your Azure environment. Proper configuration provides proactive issue detection and alignment with prescriptive governance in your cloud estate. This section shows you how to:

- [Monitor service health](./monitor.md#monitor-service-health)
- [Monitor security](./monitor.md#monitor-security)
- [Monitor compliance](./monitor.md#monitor-compliance)
- [Monitor costs](./monitor.md#monitor-costs)
- [Monitor data](./monitor.md#monitor-data)
- [Monitor code and runtime](./monitor.md#monitor-code-and-runtime)
- [Monitor cloud resources](./monitor.md#monitor-cloud-resources)

### Monitor service health

Monitoring service availability focuses on detecting service outages, disruptions, and resource issues in your cloud environment. You want real-time visibility into potential problems to maintain consistent operations. Monitoring service health is the bare minimum for monitoring your cloud estate. Here's how:

1. **Monitor underlying service health.** You need to be aware of any underlying outages to the cloud services and regions you're using. Use [Azure Service Health](/azure/service-health/service-health-portal-update) to receive free alerts about service issues, planned maintenance, and other changes affecting your Azure services and regions.

1. **Monitor underlying resource health.** You need a way to diagnose and resolve underlying issues in your cloud resources. You also need a history of these outages so you can report any service level agreement (SLA) breaches. Use [Azure Resource Health](/azure/service-health/resource-health-overview) to monitor the health of your individual cloud resources.

### Monitor security

Monitoring security involves tracking identity interactions, vulnerabilities, and network activity to protect your Azure estate. You need continuous security monitoring to safeguard data and maintain compliance within your cloud environments. Here's how:

1. **Monitor identity.** You need to understand user interactions, detect potential risky sign-ins, troubleshoot sign-in issues, and audit identity changes to ensure the security and health of your environment. Configure [Microsoft Entra monitoring](/entra/identity/monitoring-health/overview-monitoring-health) and collect the logs you need to meet your security and compliance requirements.

1. **Monitor security vulnerabilities.** You need a single security monitoring solution to detect security vulnerabilities across your various environments. For example, use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to monitor security vulnerabilities in Azure, other public clouds, edge devices, and on-premises private networks. Use [Microsoft Sentinel](/azure/sentinel/overview) for security information and event management (SIEM) and security orchestration, automation, and response (SOAR). Microsoft Sentinel relies on the Log Analytics platform so you have some key symbiosis.

1. **Monitor network activity.** You need to monitor network traffic within your cloud and networks outside of your cloud. Network monitoring helps you troubleshoot performance issues and maintain network security. Use Network Watcher to monitor Azure virtual networks (using [flow logs](/azure/network-watcher/network-watcher-overview#flow-logs') and [traffic analytics](/azure/network-watcher/network-watcher-overview#traffic-analytics)). Use [Connection monitor](/azure/network-watcher/network-watcher-overview#connection-monitor) for multicloud and on-premises network monitoring.

1. **Monitor workload security.** For workload security monitoring, see the Well-Architected Framework's [Recommendations for monitoring and threat detection](/azure/well-architected/security/monitor-threats).

### Monitor compliance

Monitoring compliance verifies alignment with governance requirements and industry regulations. You must track compliance to reduce risks and follow prescriptive standards for a well-managed Azure estate. Here's how:

1. **Monitor configuration compliance.** You need ways to align your environments with your governance policies. Use [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance) for automated auditing and enforcement of specific policies. It also monitors compliance against those policies. Azure Policy is free and offers built-in policies that align with many [regulatory standards](/azure/governance/policy/samples/#regulatory-compliance), such as [ISO 27001](/azure/governance/policy/samples/iso-27001), [NIST SP 800-53](/azure/governance/policy/samples/nist-sp-800-53-r5), and [PCI DSS](/azure/governance/policy/samples/pci-dss-4-0).

1. **Monitor data compliance.** You need to automatically assess and manage compliance across your multicloud environment, simplifying compliance and reducing risk. Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to assess and manage compliance across multicloud environments.

1. **Monitor workload compliance.** For workload compliance monitoring, see the Well-Architected Framework's [recommendations for establishing a security baseline](/azure/well-architected/security/establish-baseline).

### Monitor costs

Monitoring costs refers to tracking and controlling your cloud spending across Azure and other environments. You want cost transparency to optimize resource usage and follow prescriptive guidance for financial governance. Here's how:

1. **Understand service pricing.** Make sure you understand the pricing of the services and features you're using. You want to avoid surprises at the billing period. Use the [Azure pricing](https://azure.microsoft.com/pricing/) information.

1. **Monitor cloud spend.** Use the available tools to monitor costs across your environments. For Azure spend, use Microsoft Cost Management to [set budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?tabs=psbudget), get [cost optimization recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations), trigger [alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending) for cost anomalies, and [analyze costs](/azure/cost-management-billing/costs/quick-acm-cost-analysis).

1. **Review cloud spend regularly.** Incorporate cost reviews into your regular operational cadence. Regular assessments allow you to identify spending patterns in a timely manner and provide the opportunity to adjust resource usage to optimize costs.

1. **Monitor workload costs.** For workload cost monitoring, see the Well-Architected Framework recommendations for [collecting and reviewing cost data](/azure/well-architected/cost-optimization/collect-review-cost-data) and [optimizing component costs](/azure/well-architected/cost-optimization/optimize-component-costs).

### Monitor data

Monitoring data means overseeing data governance, protection, and usage across Azure, on-premises, multicloud, and SaaS environments. You need data visibility and security to maintain compliance and preserve business continuity in your Azure estate. Here's how.

1. **Monitor enterprise data.** You need a way to govern and secure your business data across all environments. Use [Microsoft Purview](/purview/purview) to provide data visibility, security, and compliance across these environments.

1. **Monitor workload data.** For workload data monitoring, see the Well-Architected Framework recommendations for [data classification](/azure/well-architected/security/data-classification), [optimizing data costs](/azure/well-architected/cost-optimization/optimize-data-costs), and [optimizing data performance](/azure/well-architected/performance-efficiency/optimize-data-performance).

### Monitor code and runtime

At the workload level, you need to gather telemetry (application logs, metrics, and traces) on your application code and execution to identify issues and optimize performance. For workloads in Azure, use [Application Insights](/azure/azure-monitor/app/app-insights-overview) to collect runtime telemetry (instrumentation), so you can identify performance bottlenecks and errors. For workload-specific code and run monitoring guidance, see the Well-Architected Framework:

| Workload monitoring area | Well-Architected Framework guidance |
|--------------------------|-------------------------------------|
| Operational excellence | [Instrument an application](/azure/well-architected/operational-excellence/instrument-application) |
| Performance optimization | [Prioritize the performance of critical flows](/azure/well-architected/performance-efficiency/prioritize-critical-flows)<br>[Recommendations for optimizing code and infrastructure](/azure/well-architected/performance-efficiency/optimize-code-infrastructure) |
| Cost optimization | [Optimize code costs](/azure/well-architected/cost-optimization/optimize-code-costs)<br>[Recommendations for optimizing environment costs](/azure/well-architected/cost-optimization/optimize-environment-costs)<br>[Optimize flow costs](/azure/well-architected/cost-optimization/optimize-flow-costs#monitor-flows-continuously) |
| Health modeling | [Health modeling for workloads](/azure/well-architected/design-guides/health-modeling) |

### Monitor cloud resources

Monitoring cloud resources covers watching control-plane activity, resource logs, and performance metrics across Azure. You want detailed visibility into resource usage and changes to maintain security, compliance, and operational excellence. Here's how:

1. **Monitor control plane activities.** You need to know who created, updated, and deleted resources across your subscriptions. Azure automatically captures control-plane events for each subscription, called [Azure Activity Logs](/azure/azure-monitor/platform/activity-log). [Create a diagnostic setting](/azure/azure-monitor/platform/activity-log) to send these Activity Logs to the right storage destination for later analysis.

1. **Collect cloud resource logs.** You need to collect log data for each cloud resource to assess its health and troubleshoot effectively. Different services have different types of logs. In Azure, you must configure [Azure resource logs](/azure/azure-monitor/platform/resource-logs) on every service to collect them. If you don't know what to collect, gather all available logs and metrics to avoid data gaps and optimize cost later. To optimize cost, adjust the retention period and eliminate certain logs from collection if unneeded. The logs you collect and how long you keep them should balance cost with compliance, security, and business continuity (root cause analysis). For more information, see [Azure Monitor cost optimization best practices](/azure/azure-monitor/fundamentals/best-practices-cost).

1. **Collect resource metrics.** You need visibility into the health and performance of your cloud resources. You need time-series data to get point-in-time data to troubleshoot issues. In Azure, every service automatically generates [Azure Monitor Metrics](/azure/azure-monitor/metrics/data-platform-metrics). Analyze these metrics in [metrics explorer](/azure/azure-monitor/metrics/analyze-metrics) and set up alert rules against them. Check the [default retention period](/azure/azure-monitor/metrics/data-platform-metrics#retention-of-metrics) for Azure Monitor Metrics. If you need to retain metrics for a longer period, create a [diagnostic setting](/azure/azure-monitor/platform/diagnostic-settings-policy) to store in a Log Analytics workspace for analysis and correlation with log data. Where generally available, use [data collection rules](/azure/azure-monitor/data-collection/data-collection-rule-overview) to configure central monitoring data collection.

1. **Monitor workload resources.** For workload-specific cloud resource monitoring guidance, see the Well-Architected Framework:

    | Workload monitoring area| Well-Architected Framework guidance |
    |-------------------------|------------------------------------------------------------------------------------------------|
    | Azure services monitoring | [Azure Service guides](/azure/well-architected/service-guides/#browse-the-catalog-of-azure-services) (*start with the Operational Excellence section*) |
    | Reliability | [Design a reliable monitoring and alerting strategy](/azure/well-architected/reliability/monitoring-alerting-strategy) |
    | Performance efficiency| [Define performance targets](/azure/well-architected/performance-efficiency/performance-targets)<br>[Collect workload performance data](/azure/well-architected/performance-efficiency/collect-performance-data) |

## Configure alerting

Configuring alerting means setting up notifications based on performance thresholds or operational conditions. You need timely alerts to respond quickly and follow prescriptive guidance for incident management. Here's how:

1. **Proactively identify health issues.** Define thresholds for key performance indicators to monitor resource health. This proactive approach ensures timely detection of potential issues and allows swifter remediation. Use [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-overview). If you're unsure about the thresholds to use in your alerts, [create a metric alert with dynamic thresholds](/azure/azure-monitor/alerts/alerts-dynamic-thresholds). Use [Azure Monitor Baseline Alerts](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor) as a starting point.

1. **Define the severity of the alert.** Have a system in place to categorize the severity of each alert. Apply a higher severity to resources that are critical to business operations, such as shared services and line of business workloads. Use a lower severity for other resources.

1. **Notify stakeholders.** Identify who should receive a notification when an alert triggers. A decentralized approach routes relevant alerts to the right people. Start with a flexible method that alerts stakeholders when a resource approaches anomalous behavior. Configure at least one action group for each subscription. This approach ensures relevant personnel receive alerts. Include an email notification channel as a minimum requirement. Notify operations teams about lower-severity alerts and notify management about high-severity alerts. For more information, see [customize alerts with Azure Logic Apps](/azure/azure-monitor/alerts/alerts-logic-apps) and integrate with [IT service management product (ITSM)](/azure/azure-monitor/alerts/itsmc-overview).

1. **Select notification channels.** Effective notification strategies enhance response times and mitigate potential impacts. Use email notification as a baseline and add SMS or integrate with incident management systems, as needed.

## Visualize monitoring data

Visualize monitoring data refers to creating dashboards and reports that present critical metrics in an accessible format. Clear visualization supports informed decision-making and aligns with prescriptive approaches to managing your Azure estate. Here's how:

1. **Develop monitoring dashboards.** Use [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-create-workbook) and create [Azure portal dashboards](/azure/azure-portal/azure-portal-dashboards). Dashboards present quick insights at a glance. Workbooks let you dive deeper into data with custom queries and analysis. Use dashboards for broad overviews. Use workbooks for detailed troubleshooting or advanced monitoring. If you use Grafana, use [Managed Grafana](/azure/managed-grafana/overview).

1. **Tailor visualizations.** Customize charts and reports to different audiences, whether segmented by team (enterprises) or by overall business impact (startups).