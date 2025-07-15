---
title: Monitor your Azure cloud estate
description: Learn how to monitor your Azure cloud estate, workloads, other cloud environments, on-premises, and edge environment.
author: stephen-sumner
ms.author: pnp
ms.date: 04/01/2025
ms.topic: conceptual
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

1. ***Define your monitoring approach.*** Choose a centralized or shared management model based on your organization's size and complexity.

    | Monitoring approach | Responsibilities and scope | Best for| Pros | Cons|
    |---------------------|----------------------------|---------|------|-----|
    | Centralized | Manage all monitoring tasks centrally.| Startups or small cloud footprint. | Simplified governance and cost control.| Potential for operational bottlenecks.|
    | Shared management | Centrally monitor health, security, compliance, cost, data, and shared services. <br><br>Workload teams monitor workloads. | Enterprises with multiple workloads. | Balances governance with workload-level agility. <br><br>Improves response speed and accountability. | Requires clear role definitions and ongoing coordination.|

    For shared management monitoring responsibilities, see an example [Shared management monitoring responsibilities](#shared-management-monitoring-responsibilities).

1. ***Identify what you need to monitor.*** Take a thorough inventory of your Azure estate. Include other clouds, edge deployments, and on-premises systems as needed. Use [Azure Resource Graph Explorer](/azure/governance/resource-graph/first-query-portal) to locate all Azure resources. Start with the sample [queries](/azure/governance/resource-graph/samples/starter). Use [Azure Arc](/azure/azure-arc/overview) to bring monitoring data from on-premises, other clouds, or edge locations into Azure.

1. ***Define data collection requirements.*** Determine which metrics and logs you must collect for compliance, security, and effective issue diagnosis. Meet regulatory compliance requirements and all internal governance rules. If you don't know what to collect, gather all available logs and metrics to avoid data gaps. It's a short-term solution that isn't cost efficient. When you have enough data, use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to estimate the cost of the collection long term and adjust the collection settings to meet your budget. Refer to the [complete list of Azure monitoring documentation links](#azure-services-monitoring-documentation) to learn more about what you should collect on every Azure service and how to configure it.

1. ***Define data retention requirements.*** Decide how long you must keep monitoring data to meet auditing and compliance needs. Proper retention policies enable historical analyses, support regulatory compliance, and preserve data for security investigations.

1. ***Define alert requirements.*** Determine which critical events must trigger alerts, such as resource outages, performance threshold breaches, or security anomalies. Categorize alerts by severity, outline response actions, and specify escalation paths so urgent events reach the right teams. Use [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-overview) to configure alert rules, notifications, and action groups. Proactive alerts ensure fast responses and minimize downtime.

1. ***Test and refine your monitoring approach.*** Verify that you capture the correct data and trigger alerts at the right thresholds. Adjust data collection and reliability targets based on new findings. Iterative improvements help you adapt to shifting business needs, monitoring gaps, and maintain optimal system performance.

## Design a monitoring solution

Designing a monitoring solution refers to creating a system for collecting and storing logs, metrics, and insights. A well-designed solution helps satisfy operational, security, and compliance needs. Here's how:

1. ***Consolidate your monitoring solutions.*** Use one platform to monitor Azure and on-premises, public cloud, and edge environments as needed. This consolidated approach streamlines your operations, prevents frequent tool-switching, and enables your team to detect and resolve issues quickly. Use [Azure Monitor](/azure/azure-monitor/overview) as your main monitoring solution. Use [Azure Arc](/azure/azure-arc/overview) to collect data from other clouds, on-premises, and edge deployments. Use available [Azure monitoring tools](#azure-monitoring-tools) and send their data to Azure Monitor for centralized visibility.

1. ***Aim to centralize monitoring data.*** Prefer fewer locations for storing logs and metrics. Fewer locations make it easier to manage and correlate data. There are reasons to have multiple locations to store and analyze monitoring data. For example, security operations, data residency, data resiliency, and number of Azure tenants are all factors that could require you to store your monitoring data in multiple locations. For more information, see [Design a Log Analytics workspace architecture](/azure/azure-monitor/logs/workspace-design).

1. ***Understand where to send monitoring data.*** Collect logs and metrics and store them in destinations that match your operational needs. Choose from these primary Azure destinations: Azure Log Analytics workspace ([interactive and long-term storage](/azure/azure-monitor/logs/data-retention-configure)), Azure Storage account (long-term storage), Azure Event Hubs (third-party SIEM integration), [Azure Data Explorer](/azure/data-explorer/ingest-data-no-code?tabs=diagnostic-metrics), and a partner solution. Where generally available, use [data collection rules](/azure/azure-monitor/essentials/data-collection-rule-overview) to configure central monitoring data collection. Otherwise, use [diagnostic settings](/azure/azure-monitor/essentials/diagnostic-settings#destinations).

1. ***Automate monitoring.*** You want an automated way to enforce your monitoring policies in larger environments.

    - *Use Azure Policy.* Enforce what you collect and where you send it with Azure Policy. Use Azure Policy to manage [data collection rules](/azure/azure-monitor/essentials/data-collection-rule-associations#azure-policy). For diagnostic settings, use [built-in monitoring policies](/azure/azure-monitor/essentials/diagnostic-settings-policy) and build custom policies as needed. Enforce the [install of the Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-policy) on all virtual machines. If you're an Azure landing zone user, use Azure Policy to define your [Azure Monitor alert baseline](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor).

    - *Use infrastructure as code (IaC).* Use [infrastructure as code](/azure/azure-monitor/resource-manager-samples) to configure and deploy Azure Monitor resources at scale. This method is the professional way to manage your resources.

1. ***Optimize monitoring spend.*** Conduct regular reviews of the monitoring data you collect and store. What you collect, where you store it, and how long you store it affects the cost. Adjust storage retention periods to optimize cost without stopping the collection of certain monitoring data. To optimize costs further, stop collecting unhelpful logs. For more cost optimization tips, see [Cost optimization in Azure Monitor](/azure/azure-monitor/best-practices-cost).

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

1. ***Monitor underlying service health.*** You need to be aware of any underlying outages to the cloud services and regions you’re using. Use [Azure Service Health](/azure/service-health/service-health-portal-update) to receive free alerts about service issues, planned maintenance, and other changes affecting your Azure services and regions.

1. ***Monitor underlying resource health.*** You need a way to diagnose and resolve underlying issues in your cloud resources. You also need a history of these outages so you can report any service level agreement (SLA) breaches. Use [Azure Resource Health](/azure/service-health/resource-health-overview) to monitor the health of your individual cloud resources.

### Monitor security

Monitoring security involves tracking identity interactions, vulnerabilities, and network activity to protect your Azure estate. You need continuous security monitoring to safeguard data and maintain compliance within your cloud environments. Here's how:

1. ***Monitor identity.*** You need to understand user interactions, detect potential risky sign-ins, troubleshoot sign-in issues, and audit identity changes to ensure the security and health of your environment. Configure [Microsoft Entra monitoring](/entra/identity/monitoring-health/overview-monitoring-health) and collect the logs you need to meet your security and compliance requirements.

1. ***Monitor security vulnerabilities.*** You need a single security monitoring solution to detect security vulnerabilities across your various environments. For example, use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to monitor security vulnerabilities in Azure, other public clouds, edge devices, and on-premises private networks. Use [Microsoft Sentinel](/azure/sentinel/overview) for security information and event management (SIEM) and security orchestration, automation, and response (SOAR). Microsoft Sentinel relies on the Log Analytics platform so you have some key symbiosis.

1. ***Monitor network activity.*** You need to monitor network traffic within your cloud and networks outside of your cloud. Network monitoring helps you troubleshoot performance issues and maintain network security. Use Network Watcher to monitor Azure virtual networks (using [flow logs](/azure/network-watcher/network-watcher-overview#flow-logs') and [traffic analytics](/azure/network-watcher/network-watcher-overview#traffic-analytics)). Use [Connection monitor](/azure/network-watcher/network-watcher-overview#connection-monitor) for multicloud and on-premises network monitoring.

1. ***Monitor workload security.*** For workload security monitoring, see the Well-Architected Framework’s [Recommendations for monitoring and threat detection](/azure/well-architected/security/monitor-threats).

### Monitor compliance

Monitoring compliance verifies alignment with governance requirements and industry regulations. You must track compliance to reduce risks and follow prescriptive standards for a well-managed Azure estate. Here's how:

1. ***Monitor configuration compliance.*** You need ways to align your environments with your governance policies. Use [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance) for automated auditing and enforcement of specific policies. It also monitors compliance against those policies. Azure Policy is free and offers built-in policies that align with many [regulatory standards](/azure/governance/policy/samples/#regulatory-compliance), such as [ISO 270001](/azure/governance/policy/samples/iso-27001), [NIST SP 800-53](/azure/governance/policy/samples/nist-sp-800-53-r5), [PCI DSS](/azure/governance/policy/samples/pci-dss-4-0), and [EU General Data Protection Regulation (GDPR)](/azure/governance/policy/samples/built-in-initiatives#regulatory-compliance).

1. ***Monitor data compliance.*** You need to automatically assess and manage compliance across your multicloud environment, simplifying compliance and reducing risk. Use [Microsoft Purview Compliance Manager](/purview/compliance-manager) to assess and manage compliance across multicloud environments.

1. ***Monitor workload compliance.*** For workload compliance monitoring, see the Well-Architected Framework’s [recommendations for establishing a security baseline](/azure/well-architected/security/establish-baseline).

### Monitor costs

Monitoring costs refers to tracking and controlling your cloud spending across Azure and other environments. You want cost transparency to optimize resource usage and follow prescriptive guidance for financial governance. Here's how:

1. ***Understand service pricing.*** Make sure you understand the pricing of the services and features you’re using. You want to avoid surprises at the billing period. Use the [Azure pricing](https://azure.microsoft.com/pricing/) information.

1. ***Monitor cloud spend.*** You should use the available tools to monitor costs across your environments. For Azure spend, use Microsoft Cost Management to [set budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?tabs=psbudget), get [cost optimization recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations), trigger [alerts](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending) for cost anomalies, and [analyze costs](/azure/cost-management-billing/costs/quick-acm-cost-analysis).

1. ***Review cloud spend regularly.*** Incorporate cost reviews into your regular operational cadence. Regular assessments allow for the timely identification of spending patterns and the opportunity to adjust resource usage to optimize costs.

1. ***Monitor workload costs.*** For workload cost monitoring, see the Well-Architected Framework recommendations for [collecting and reviewing cost data](/azure/well-architected/cost-optimization/collect-review-cost-data) and [optimizing component costs](/azure/well-architected/cost-optimization/optimize-component-costs).

### Monitor data

Monitoring data means overseeing data governance, protection, and usage across Azure, on-premises, multicloud, and SaaS environments. You need data visibility and security to maintain compliance and preserve business continuity in your Azure estate. Here's how.

1. ***Monitor enterprise data.*** You need a way to govern and secure your business data across all environments. Use [Microsoft Purview](/purview/purview) to provide data visibility, security, and compliance across these environments.

1. ***Monitor workload data.*** For workload data monitoring, see the Well-Architected Framework recommendations for [data classification](/azure/well-architected/security/data-classification), [optimizing data costs](/azure/well-architected/cost-optimization/optimize-data-costs), and [optimizing data performance](/azure/well-architected/performance-efficiency/optimize-data-performance).

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

1. ***Monitor control plane activities.*** You need know who created, updated, and deleted resources across your subscriptions. Azure automatically captures control-plane events for each subscription, called [Azure Activity Logs](/azure/azure-monitor/essentials/activity-log). [Create a diagnostic setting](/azure/azure-monitor/essentials/activity-log) to send these Activity Logs to the right storage destination for later analysis.

1. ***Collect cloud resource logs.*** You need to collect log data for each cloud resource to assess its health and troubleshoot effectively. Different services have different types of logs. In Azure, you must configure [Azure resource logs](/azure/azure-monitor/essentials/resource-logs) on every service to collect them. If you don't know what to collect, gather all available logs and metrics to avoid data gaps and optimize cost later. To optimize cost, adjust the retention period and eliminate certain logs from collection if unneeded. The logs you collect and how long you keep them should balance cost with compliance, security, and business continuity (root cause analysis). For more information, see [Azure Monitor cost optimization best practices](/azure/azure-monitor/best-practices-cost)

1. ***Collect resource metrics.*** You need visibility into the health and performance of your cloud resources. You need time-series data to get point-in time data to troubleshoot issues. In Azure, every service automatically generates [Azure Monitor Metrics](/azure/azure-monitor/essentials/data-platform-metrics). Analyze these metrics in [metrics explorer](/azure/azure-monitor/essentials/analyze-metrics) and set up alert rules against them. Check the [default retention period](/azure/azure-monitor/essentials/data-platform-metrics#retention-of-metrics) for Azure Monitor Metrics. If you need to retain metrics for a longer period, create a [diagnostic setting](/azure/azure-monitor/essentials/diagnostic-settings-policy) to store in a Log Analytics workspace for analysis and correlation with log data. Where generally available, use [data collection rules](/azure/azure-monitor/essentials/data-collection-rule-overview) to configure central monitoring data collection.

1. ***Monitor workload resources.*** For workload-specific cloud resource monitoring guidance, see the Well-Architected Framework:

    | Workload monitoring area| Well-Architected Framework guidance |
    |-------------------------|------------------------------------------------------------------------------------------------|
    | Azure services monitoring | [Azure Service guides](/azure/well-architected/service-guides/#browse-the-catalog-of-azure-services) (*start with the Operational Excellence section*) |
    | Reliability | [Design a reliable monitoring and alerting strategy](/azure/well-architected/reliability/monitoring-alerting-strategy) |
    | Performance efficiency| [Define performance targets](/azure/well-architected/performance-efficiency/performance-targets)<br>[Collect workload performance data](/azure/well-architected/performance-efficiency/collect-performance-data) |

## Configure alerting

Configuring alerting means setting up notifications based on performance thresholds or operational conditions. You need timely alerts to respond quickly and follow prescriptive guidance for incident management. Here's how:

1. ***Proactively identify health issues.*** You need to define thresholds for key performance indicators to monitor resource health. This proactive approach ensures timely detection of potential issues and allows swifter remediation. Use [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-overview). If you're unsure about the thresholds to use in your alerts, [create a metric alert with dynamic thresholds](/azure/azure-monitor/alerts/alerts-dynamic-thresholds). Use [Azure Monitor Baseline Alerts](/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor) as a starting point.

1. ***Define the severity of the alert.*** Have a system in place to categorize the severity of each alert. Apply a higher severity to resources that are critical to business operations, such as shared services and line of business workloads. Use a lower severity for other resources.

1. ***Notify stakeholders.*** Identify who should receive a notification when an alert triggers. A decentralized approach routes relevant alerts to the right people. Start with a flexible method that alerts stakeholders when a resource approaches anomalous behavior. Configure at least one action group for each subscription. This approach ensures relevant personnel receive alerts. Include an email notification channel as a minimum requirement. Notify operations teams about lower-severity alerts and notify management about high-severity alerts. For more information, see [customize alerts with Azure Logic Apps](/azure/azure-monitor/alerts/alerts-logic-apps) and integrate with [IT service management product (ITSM)](/azure/azure-monitor/alerts/itsmc-overview).

1. ***Select notification channels.*** Effective notification strategies enhance response times and mitigate potential impacts. Use email notification as a baseline and add SMS or integrate with incident management systems, as needed.

## Visualize monitoring data

Visualize monitoring data refers to creating dashboards and reports that present critical metrics in an accessible format. Clear visualization supports informed decision-making and aligns with prescriptive approaches to managing your Azure estate. Here's how:

1. ***Develop monitoring dashboards.*** Use [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-create-workbook) and create [Azure portal dashboards](/azure/azure-portal/azure-portal-dashboards). Dashboards present quick insights at a glance. Workbooks let you dive deeper into data with custom queries and analysis. Use dashboards for broad overviews. Use workbooks for detailed troubleshooting or advanced monitoring. If you use Grafana, use [Managed Grafana](/azure/managed-grafana/overview).

1. ***Tailor visualizations.*** Customize charts and reports to different audiences, whether segmented by team (enterprises) or by overall business impact (startups).

## Azure monitoring tools

| Category| Tool | Description |
|-------------------------------|----------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| Multi-environment monitoring| [Azure Monitor](/azure/azure-monitor)| Serves as the central platform that collects telemetry from cloud and on‑premises environments. It monitors resource performance and operational state. |
| Multi-environment extension | [Azure Arc](/azure/azure-arc/overview) | Extends Azure management, including monitoring and governance, to on‑premises, multicloud, and edge environments.|
| Service health monitoring | [Azure Service Health](/azure/service-health/overview) | Provides real‑time status and personalized information about service issues, planned maintenance, and other changes affecting your Azure services and regions. |
| Service health monitoring | [Azure Resource Health](/azure/service-health/resource-health-overview) | Tracks the health of individual cloud resources and records issues over time for troubleshooting and reporting. |
| Security monitoring | [Microsoft Entra monitoring](/entra/identity/monitoring-health/overview-monitoring-health) | Tracks identity interactions, sign‑in health, and audits changes to user accounts to safeguard access.|
| Security monitoring | [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) | Protects your cloud resources with threat detection, vulnerability assessments, and security recommendations. |
| Security monitoring | [Microsoft Sentinel](/azure/sentinel/overview) | Acts as a cloud‑native SIEM and SOAR solution that analyzes security telemetry and automates responses to threats.|
| Compliance monitoring | [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance) | Enforces organizational standards and audits resource compliance at‑scale through automated assessments.|
| Compliance monitoring | [Microsoft Purview Compliance Manager](/purview/compliance-manager) | Assesses regulatory compliance and provides insights and recommendations to reduce risk.|
| Cost monitoring | [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) | Estimates the cost of Azure services and helps plan and optimize your monitoring spend. |
| Cost monitoring | [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Monitors and manages cloud spending while providing insights to optimize resource usage and costs.|
| Data monitoring | [Microsoft Purview](/purview/purview)| Governs and protects enterprise data by offering discovery, classification, and risk management capabilities. |
| Code and runtime monitoring | [Application Insights](/azure/azure-monitor/app/app-insights-overview) | Monitors application performance with telemetry on code execution, performance, and usage to pinpoint issues. |
| Cloud resource monitoring | [Azure Resource Graph Explorer](/azure/governance/resource-graph/first-query-portal) | Enables querying and exploration of your Azure resources, offering visibility across your cloud estate. |
| Cloud resource monitoring | [Network Watcher](/azure/network-watcher/network-watcher-overview) | Monitors and diagnoses network performance and connectivity for Azure virtual networks and related resources. |
| Cloud resource monitoring | [Connection Monitor](/azure/network-watcher/network-watcher-overview#connection-monitor) | Provides insights into connectivity across Azure, on‑premises, and multicloud environments.|
| Cloud resource monitoring | [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-policy) | Installs on virtual machines to collect telemetry from operating systems and applications.|
| Cloud resource monitoring | [Azure Activity Logs](/azure/azure-monitor/essentials/activity-log) | Records control‑plane operations such as resource creation, updates, or deletions across Azure subscriptions. |
| Cloud resource monitoring | [Azure Resource Logs](/azure/azure-monitor/essentials/resource-logs) | Captures diagnostic data from individual Azure services for troubleshooting and performance analysis. |
| Cloud resource monitoring | [Azure Monitor Metrics](/azure/azure-monitor/essentials/data-platform-metrics) | Collects time‑series performance data from Azure services to track resource health and performance. |
| Cloud resource monitoring | [Metrics explorer](/azure/azure-monitor/essentials/analyze-metrics) | Visualizes and analyzes collected metrics data, supporting trend analysis and troubleshooting.|
| Monitoring data storage | [Azure Log Analytics workspace](/azure/azure-monitor/logs/data-retention-configure) | Stores and enables querying of collected log data for detailed analysis and long‑term retention.|
| Monitoring data storage | [Azure Storage account](/azure/storage/common/storage-account-overview) | Provides secure, scalable storage used for long‑term retention of logs and monitoring data. |
| Monitoring data storage | [Azure Event Hubs](/azure/event-hubs/event-hubs-about) | Ingests large volumes of telemetry and event data, supporting integration with SIEM and other analytics platforms. |
| Monitoring data storage | [Azure Data Explorer](/azure/data-explorer/ingest-data-no-code?tabs=diagnostic-metrics) | Offers fast, interactive analysis of large volumes of telemetry data, supporting real‑time analytics. |
| Monitoring data configuration | [Infrastructure as Code for Azure Monitor](/azure/azure-monitor/resource-manager-samples) | Deploys and manages Azure Monitor resources at scale using code, ensuring consistent configuration across environments.|
| Monitoring data configuration | [Diagnostic settings in Azure Monitor](/azure/azure-monitor/essentials/diagnostic-settings#destinations) | Routes monitoring data (logs and metrics) to destinations like Log Analytics, storage accounts, or Event Hubs. |
| Monitoring data configuration | [Data collection rules](/azure/azure-monitor/essentials/data-collection-rule-overview) | Standardizes the collection and ingestion of monitoring data across your environment. |
| Alerting| [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-overview) | Notifies you when defined thresholds for metrics or log data are breached, allowing you to react promptly to issues. |
| Visualization | [Azure Monitor workbooks](/azure/azure-monitor/visualize/workbooks-create-workbook) | Enables creation of interactive reports and custom dashboards to analyze monitoring data in detail. |
| Visualization | [Azure portal dashboards](/azure/azure-portal/azure-portal-dashboards) | Displays key monitoring data in customizable dashboards for at‑a‑glance insights.|
| Visualization | [Managed Grafana](/azure/managed-grafana/overview) | Offers hosted Grafana for visualizing monitoring data, integrating with Azure Monitor for custom dashboards. |

## Azure services monitoring documentation

The table provides a near complete list of the monitoring articles for every Azure service in alphabetical order.

| Azure service | Monitoring guidance | Deployment monitoring<br>(select services) |
|---------------|---------------------------------------| ------------------- |
| Azure AI Foundry Agent Service | [Management center overview](/azure/ai-studio/concepts/management-center) | [How to enable tracing in Azure AI Agents](/azure/ai-services/agents/concepts/tracing) |
| Azure AI Foundry | [Management center overview](/azure/ai-studio/concepts/management-center) | [Monitor your Generative AI Applications](/azure/ai-studio/how-to/monitor-applications)<br><br>[Evaluation and monitoring metrics for generative AI](/azure/ai-studio/concepts/evaluation-metrics-built-in)<br><br>[Use Risks & Safety monitoring](/azure/ai-services/openai/how-to/risks-safety-monitor)<br><br>[Run evaluations online](/azure/ai-studio/how-to/online-evaluation)<br><br>[View evaluation results in Azure AI Foundry portal](/azure/ai-studio/how-to/evaluate-results)<br><br>[Visualize your traces](/azure/ai-studio/how-to/develop/visualize-traces) |
| Azure AI Search | [Monitor Azure AI Search](/azure/search/monitor-azure-cognitive-search) | [Monitor queries](/azure/search/search-monitor-queries)<br><br>[Analyze performance in Azure AI Search](/azure/search/search-performance-analysis)<br><br>[Collect telemetry data for search traffic analytics](/azure/search/search-traffic-analytics)<br><br>[Visualize Azure AI Search Logs and Metrics with Power BI](/azure/search/search-monitor-logs-powerbi) |
| Azure AI services | [Enable diagnostic logging Azure AI services](/azure/ai-services/diagnostic-logging) | |
| Azure AI Video Indexer | [Monitor Azure AI Video Indexer](/azure/azure-video-indexer/monitor-video-indexer)<br><br>[Monitoring Azure AI Video Indexer data reference](/azure/azure-video-indexer/monitor-video-indexer-data-reference) | |
| Azure Analysis Services | [Monitor Azure Analysis Services](/azure/analysis-services/monitor-analysis-services)<br><br>[Monitoring data reference for Azure Analysis Services](/azure/analysis-services/monitor-analysis-services-reference) | |
| Azure API for FHIR | [Enable diagnostic logging in Azure API for FHIR](/azure/healthcare-apis/azure-api-for-fhir/enable-diagnostic-logging) | |
| Azure API Management | [Monitor Azure API Management](/azure/api-management/monitor-api-management)<br><br>[Monitoring data reference for Azure API Management](/azure/api-management/monitor-api-management-reference) | [Observability in Azure API Management](/azure/api-management/observability)<br><br>[Monitor published APIs in Azure API Management](/azure/api-management/api-management-howto-use-azure-monitor)<br><br>[Integrate Azure API Management with Application Insights](/azure/api-management/api-management-howto-app-insights)<br><br>[Monitor your APIs](/azure/api-management/api-management-log-to-eventhub-sample) |
| Azure App Configuration | [Monitor Azure App Configuration](/azure/azure-app-configuration/monitor-app-configuration)<br><br>[Monitoring Azure App Configuration data reference](/azure/azure-app-configuration/monitor-app-configuration-reference) | |
| Azure App Service | [Monitor Azure App Service](/azure/app-service/monitor-app-service)<br><br>[Azure App Service monitoring data reference](/azure/app-service/monitor-app-service-reference) | [Enable application monitoring](/azure/azure-monitor/app/codeless-app-service)<br><br>[Monitor App Service instances by using Health Check](/azure/app-service/monitor-instances-health-check)<br><br>[Azure App Service diagnostics overview](/azure/app-service/overview-diagnostics)|
| Azure Application Gateway | [Monitor Azure Application Gateway](/azure/application-gateway/monitor-application-gateway)<br><br>[Monitoring data reference for Azure Application Gateway](/azure/application-gateway/monitor-application-gateway-reference) | [Application Gateway health probes overview](/azure/application-gateway/application-gateway-probe-overview)<br><br>[Backend health](/azure/application-gateway/application-gateway-backend-health)<br><br>[Azure Monitor metrics for Application Gateway](/azure/application-gateway/application-gateway-metrics) |
| Azure Arc resource bridge | [Azure Arc resource bridge maintenance operations](/azure/azure-arc/resource-bridge/maintenance) | |
| Azure Arc site manager | [How to configure Azure Monitor alerts for a site](/azure/azure-arc/site-manager/how-to-configure-monitor-site) | |
| Azure Arc-enabled data services | [Azure Data Studio dashboards for Azure Arc](/azure/azure-arc/data/azure-data-studio-dashboards) | |
| Azure Arc-enabled Kubernetes | [Enable monitoring for Azure Kubernetes Service (AKS) cluster](/azure/azure-monitor/containers/kubernetes-monitoring-enable) | |
| Azure Arc-enabled servers | [Monitor a hybrid machine with Azure Monitor VM insights](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights) | |
| Azure Archive Storage | [Monitor Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)<br><br>[Monitoring data reference for Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage-reference) | |
| Azure Automation | [Forward Azure Automation job data to Azure Monitor logs](/azure/automation/automation-manage-send-joblogs-log-analytics) | |
| Azure Backup | [Monitoring and reporting solutions for Azure Backup](/azure/backup/monitoring-and-alerts-overview) | |
| Azure Batch | [Monitor Azure Batch](/azure/batch/monitor-batch)<br><br>[Monitoring data reference for Azure Batch](/azure/batch/monitor-batch-reference) | |
| Azure Blob Storage | [Monitor Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)<br><br>[Monitoring data reference for Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage-reference) | [Best practices for monitoring Azure Blob Storage](/azure/storage/blobs/blob-storage-monitoring-scenarios)<br><br>[Monitoring your storage service with Azure Monitor Storage insights](/azure/storage/common/storage-insights-overview) |
| Azure Cache for Redis | [Monitor Azure Cache for Redis](/azure/azure-cache-for-redis/monitor-cache)<br><br>[Monitoring data reference for Azure Cache for Redis](/azure/azure-cache-for-redis/monitor-cache-reference) | [Azure Monitor insights for Azure Cache for Redis](/azure/azure-cache-for-redis/cache-insights-overview) |
| Azure Chaos Studio | [Set up Azure monitor for a Chaos Studio experiment](/azure/chaos-studio/chaos-studio-set-up-azure-monitor) | |
| Azure Communication Services | [Monitor SMS](/azure/communication-services/concepts/analytics/enable-logging)<br> [Monitor Voice and video](/azure/communication-services/concepts/analytics/enable-logging)<br> [Monitor Chat](/azure/communication-services/concepts/analytics/enable-logging)<br>[Monitor Phone calling](/azure/communication-services/concepts/analytics/enable-logging)<br> [Monitor Email](/azure/communication-services/concepts/analytics/enable-logging) | |
| Azure confidential ledger | [Verify Azure Confidential Ledger write transaction receipts](/azure/confidential-ledger/verify-write-transaction-receipts) | |
| Azure Container Apps | [Monitor Azure Container Apps](/azure/container-apps/observability)<br><br>[Monitor Azure Container Apps metrics](/azure/container-apps/metrics) | [Application logging in Azure Container Apps](/azure/container-apps/logging)<br><br>[Health probes in Azure Container Apps](/azure/container-apps/health-probes)|
| Azure Container Instances | [Monitor Azure Container Instances](/azure/container-instances/monitor-azure-container-instances)<br><br>[Monitoring data reference for Container Instances](/azure/container-instances/monitor-azure-container-instances-reference) | [Configure liveness probes](/azure/container-instances/container-instances-liveness-probe)|
| Azure Container Registry | [Monitor Azure Container Registry](/azure/container-registry/monitor-container-registry)<br><br>[Monitoring Data Reference for Azure Container Registry](/azure/container-registry/monitor-container-registry-reference) | |
| Azure Container Storage | [Enable monitoring for Azure Container Storage](/azure/storage/container-storage/enable-monitoring) | |
| Azure Cosmos DB | [Monitor Azure Cosmos DB](/azure/cosmos-db/monitor)<br><br>[Monitoring data reference for Azure Cosmos DB](/azure/cosmos-db/monitor-reference) | [Azure Cosmos DB insights](/azure/cosmos-db/insights-overview)<br><br>[Monitor and debug with insights in Azure Cosmos DB](/azure/cosmos-db/use-metrics)<br><br>[Monitor throughput or request unit usage of an operation in Azure Cosmos DB](/azure/cosmos-db/monitor-request-unit-usage)<br><br>[Query execution metrics](/azure/cosmos-db/nosql/query-metrics-performance)<br><br>[Index metrics](/azure/cosmos-db/nosql/index-metrics)<br><br>[Explore Azure Monitor in vCore-based Azure Cosmos DB for MongoDB (vCore)](/azure/cosmos-db/mongodb/vcore/monitor-metrics) |
| Azure CycleCloud | [Monitor Azure CycleCloud](/azure/cyclecloud/concepts/monitoring) | |
| Azure Data Box | [Track and log Azure Data Box, Azure Data Box Heavy events for import order](/azure/databox/data-box-logs) | |
| Azure Data Explorer | [Monitor Azure Data Explorer](/azure/data-explorer/monitor-data-explorer)<br><br>[Monitoring data reference for Azure Data Explorer](/azure/data-explorer/monitor-data-explorer-reference) | |
| Azure Data Lake Storage | [Monitor Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)<br><br>[Monitoring data reference for Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage-reference) | |
| Azure Database for MySQL | [Monitoring - Azure Database for MySQL](/azure/mysql/flexible-server/concepts-monitoring) | [Best practices for monitoring](/azure/mysql/flexible-server/concept-monitoring-best-practices) |
| Azure Database for PostgreSQL | [Monitoring and metrics - Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-monitoring) | [Intelligent tuning](/azure/postgresql/flexible-server/concepts-intelligent-tuning) [Monitor performance with query store](/azure/postgresql/flexible-server/concepts-query-store)|
| Azure Databricks | [Configure diagnostic log delivery for Azure Databricks](/azure/databricks/admin/account-settings/audit-log-delivery) | |
| Azure DDoS Protection | [Monitor Azure DDoS Protection](/azure/ddos-protection/monitor-ddos-protection)<br><br>[Monitor Azure DDoS Protection monitoring data reference](/azure/ddos-protection/monitor-ddos-protection-reference) | |
| Azure Dedicated Host | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | |
| Azure Dedicated HSM | [Monitoring options - Azure Dedicated HSM](/azure/dedicated-hsm/monitoring) | |
| Azure DevTest Labs | [Activity logs - Azure DevTest Labs](/azure/devtest-labs/activity-logs) | |
| Azure Digital Twins | [Monitor your instance in Azure Digital Twins](/azure/digital-twins/how-to-monitor) | |
| Azure Disk Storage | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | |
| Azure DNS | [Metrics and alerts](/azure/dns/dns-alerts-metrics) | |
| Azure Elastic SAN | [Metrics for Azure Elastic SAN](/azure/storage/elastic-san/elastic-san-metrics) | |
| Azure Event Grid | [Enable diagnostic logs for Event Grid resources](/azure/event-grid/enable-diagnostic-logs-topic)<br><br>[Monitor data reference (push delivery)](/azure/event-grid/monitor-push-reference) | |
| Azure Event Hubs | [Monitor Azure Event Hubs](/azure/event-hubs/monitor-event-hubs)<br><br>[Monitoring data reference for Azure Event Hubs](/azure/event-hubs/monitor-event-hubs-reference) | |
| Azure ExpressRoute | [Monitor Azure ExpressRoute](/azure/expressroute/monitor-expressroute)<br><br>[Monitoring data reference for Azure ExpressRoute](/azure/expressroute/monitor-expressroute-reference) | |
| Azure Files | [Monitor Azure Files using Azure Monitor](/azure/storage/files/storage-files-monitoring)<br><br>[Monitoring data reference for Azure Files](/azure/storage/files/storage-files-monitoring-reference) | |
| Azure Firewall | [Monitor Azure Firewall](/azure/firewall/monitor-firewall)<br><br>[Monitoring data reference for Azure Firewall](/azure/firewall/monitor-firewall-reference) | |
| Azure Front Door | [Monitor Azure Front Door](/azure/frontdoor/monitor-front-door)<br><br>[Monitoring data reference for Azure Front Door](/azure/frontdoor/monitor-front-door-reference) | [Azure Front Door reports](/azure/frontdoor/standard-premium/how-to-reports)<br><br>[Health probes](/azure/frontdoor/health-probes) |
| Azure Functions | [Monitor Azure Functions](/azure/azure-functions/monitor-functions)<br><br>[Monitoring data reference for Azure Functions](/azure/azure-functions/monitor-functions-reference) | [Monitor Azure Functions with Azure Monitor Application Insights](/azure/azure-monitor/app/monitor-functions)<br><br>[Monitor executions in Azure Functions](/azure/azure-functions/functions-monitoring) |
| Azure FXT Edge Filer | [Monitor the Azure FXT Edge Filer](/azure/fxt-edge-filer/monitor) | |
| Azure HDInsight | [Monitor Azure HDInsight](/azure/hdinsight/monitor-hdinsight)<br><br>[Monitoring data reference for Azure HDInsight](/azure/hdinsight/monitor-hdinsight-reference) | |
| Azure Health Data Services | [Logging for Azure Health Data Services](/azure/healthcare-apis/logging) | |
| Azure HPC Cache | [Azure HPC Cache metrics and monitoring](/azure/hpc-cache/metrics) | |
| Azure IoT | [Manage your IoT solution](/azure/iot/iot-overview-solution-management) | |
| Azure IoT Central | [Manage and monitor IoT Central](/azure/iot-central/core/howto-manage-and-monitor-iot-central) | |
| Azure IoT Edge | [Tutorial - Azure Monitor workbooks for IoT Edge](/azure/iot-edge/tutorial-monitor-with-workbooks) | |
| Azure IoT Hub | [Monitor Azure IoT Hub](/azure/iot-hub/monitor-iot-hub)<br><br>[Monitoring data reference for Azure IoT Hub](/azure/iot-hub/monitor-iot-hub-reference) | |
| Azure IoT Operations | [Deploy observability resources](/azure/iot-operations/configure-observability-monitoring/howto-configure-observability) | |
| Azure Key Vault | [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault)<br><br>[Monitoring data reference for Azure Key Vault](/azure/key-vault/general/monitor-key-vault-reference) | [Monitoring your key vault service with Key Vault insights](/azure/key-vault/key-vault-insights-overview)<br><br>[Configure Azure Key Vault alerts](/azure/key-vault/general/alert)<br><br>[Azure Key Vault monitoring data reference](/azure/key-vault/general/monitor-key-vault-reference)<br><br>[Azure Key Vault logging](/azure/key-vault/general/logging)<br><br>[Enable Key Vault logging](/azure/key-vault/general/howto-logging)<br><br>[Monitoring Key Vault with Azure Event Grid](/azure/key-vault/general/event-grid-overview) |
| Azure Kubernetes Service (AKS) | [Monitor Azure Kubernetes Service (AKS)](/azure/aks/monitor-aks)<br><br>[Monitoring data reference for Azure Kubernetes Service](/azure/aks/monitor-aks-reference) | [Zero instrumentation application monitoring for Kubernetes](/azure/azure-monitor/app/kubernetes-codeless)<br><br>[Full stack monitoring](/azure/azure-monitor/containers/monitor-kubernetes)<br><br>[Best practices for monitoring Kubernetes with Azure Monitor](/azure/azure-monitor/best-practices-containers)|
| Azure Lab Services | [Track usage of a lab in Azure Lab Services](/azure/lab-services/tutorial-track-usage) | |
| Azure Lighthouse | [Monitor delegated resources at scale](/azure/lighthouse/how-to/monitor-at-scale) | |
| Azure Load Balancer | [Monitor Azure Load Balancer](/azure/load-balancer/monitor-load-balancer)<br><br>[Monitoring data reference for Azure Load Balancer](/azure/load-balancer/monitor-load-balancer-reference) | |
| Azure Load Testing | [Monitoring Azure Load Testing](/azure/load-testing/monitor-load-testing)<br><br>[Monitor Azure Load Testing data reference](/azure/load-testing/monitor-load-testing-reference) | |
| Azure Local | [Overview of Azure Local monitoring](/azure/azure-local/concepts/monitoring-overview) | |
| Azure Logic Apps | [Monitor Azure Logic Apps](/azure/logic-apps/monitor-logic-apps-overview)<br><br>[Monitoring data reference for Azure Logic Apps](/azure/logic-apps/monitor-logic-apps-reference) | |
| Azure Machine Learning | [Monitor Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning)<br><br>[Azure Machine Learning monitoring data reference](/azure/machine-learning/monitor-azure-machine-learning-reference) | [Azure Machine Learning model monitoring](/azure/machine-learning/concept-model-monitoring)<br><br>[Monitor performance of models deployed to production](/azure/machine-learning/how-to-monitor-model-performance)<br><br>[Monitor online endpoints](/azure/machine-learning/how-to-monitor-online-endpoints) |
| Azure Managed Grafana | [Monitor an Azure Managed Grafana instance with logs](/azure/managed-grafana/how-to-monitor-managed-grafana-workspace) | |
| Azure Managed Instance for Apache Cassandra | [Monitor Azure Managed Instance for Apache Cassandra](/azure/managed-instance-apache-cassandra/monitor-clusters) | |
| Azure Managed Lustre | [Monitor Azure Managed Lustre](/azure/azure-managed-lustre/monitor-file-system)<br><br>[Monitoring data reference for Azure Managed Lustre](/azure/azure-managed-lustre/monitor-file-system-reference) | |
| Azure NAT Gateway | [Monitor Azure NAT Gateway](/azure/nat-gateway/monitor-nat-gateway)<br><br>[Monitoring data reference for Azure NAT Gateway](/azure/nat-gateway/monitor-nat-gateway-reference) | |
| Azure NetApp Files | [Ways to monitor Azure NetApp Files](/azure/azure-netapp-files/monitor-azure-netapp-files)<br><br>[Metrics for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-metrics) | |
| Azure Notification Hubs | [Monitor Azure Notification Hubs](/azure/notification-hubs/monitor-notification-hubs)<br><br>[Monitoring data reference for Azure Notification Hubs](/azure/notification-hubs/monitor-notification-hubs-reference) | |
| Azure OpenAI Service | [Monitor Azure OpenAI Service](/azure/ai-services/openai/how-to/monitor-openai) | [Use Risks & Safety monitoring](/azure/ai-services/openai/how-to/risks-safety-monitor) |
| Azure Operator Nexus | [Azure Operator Nexus: observability using Azure Monitor](/azure/operator-nexus/concepts-observability) | |
| Azure Private 5G Core | [Monitor Azure Private 5G Core with Azure Monitor platform metrics](/azure/private-5g-core/monitor-private-5g-core-with-platform-metrics)<br><br>[Monitor with correlated metrics in Azure portal](/azure/private-5g-core/ran-insights-monitor-with-correlated-metrics-concepts) | |
| Azure Private Link | [Monitor Azure Private Link](/azure/private-link/monitor-private-link)<br><br>[Monitoring data reference for Azure Private Link](/azure/private-link/monitor-private-link-reference) | |
| Azure Power BI Embedded | [Monitor Power BI Embedded](/power-bi/developer/embedded/monitor-power-bi-embedded)<br><br>[Monitoring data reference for Power BI Embedded](/power-bi/developer/embedded/monitor-power-bi-embedded-reference) | |
| Azure Queue Storage | [Monitor Azure Queue Storage](/azure/storage/queues/monitor-queue-storage)<br><br>[Monitoring data reference for Azure Queue Storage](/azure/storage/queues/monitor-queue-storage-reference) | |
| Azure Red Hat OpenShift | [Monitor Azure Red Hat OpenShift](/azure/azure-monitor/containers/kubernetes-monitoring-enable) | |
| Azure Service Bus | [Monitor Azure Service Bus](/azure/service-bus-messaging/monitor-service-bus)<br><br>[Monitoring data reference for Azure Service Bus](/azure/service-bus-messaging/monitor-service-bus-reference) | [Azure Monitor - Service Bus insights](/azure/service-bus-messaging/service-bus-insights) |
| Azure Service Fabric | [Monitor Azure Service Fabric](/azure/service-fabric/monitor-service-fabric)<br><br>[Monitoring data reference for Azure Service Fabric](/azure/service-fabric/monitor-service-fabric-reference) | |
| Azure SignalR Service | [Monitor Azure SignalR Service](/azure/azure-signalr/monitor-signalr)<br><br>[Monitoring data reference for Azure SignalR Service](/azure/azure-signalr/monitor-signalr-reference) | |
| Azure Site Recovery | [Monitor Azure Site Recovery](/azure/site-recovery/monitor-site-recovery)<br><br>[Monitoring data reference for Azure Site Recovery](/azure/site-recovery/monitor-site-recovery-reference) | |
| Azure Sphere | [Overview Monitor Azure Sphere resources](/azure-sphere/deployment/az-monitor-overview)<br><br>[Monitor Azure Sphere data reference](/azure-sphere/deployment/az-monitor-data) | |
| Azure Spot Virtual Machines | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | |
| Azure SQL Database | [Monitor Azure SQL Database](/azure/azure-sql/database/monitoring-sql-database-azure-monitor)<br><br>[Monitoring data reference for Azure SQL Database](/azure/azure-sql/database/monitoring-sql-database-azure-monitor-reference) | [Monitor Azure SQL workloads with database watcher](/azure/azure-sql/database-watcher-overview)<br><br>[Tune applications and databases for performance in Azure SQL Database](/azure/azure-sql/database/performance-guidance) |
| Azure SQL Managed Instance | [Monitor Azure SQL Managed Instance](/azure/azure-sql/managed-instance/monitoring-sql-managed-instance-azure-monitor) | [Tune applications and databases for performance in Azure SQL Managed Instance](/azure/azure-sql/managed-instance/performance-guidance) |
| Azure Stack Edge | [Enable Azure Monitor on Azure Stack Edge Pro GPU device](/azure/databox-online/azure-stack-edge-gpu-enable-azure-monitor) | |
| Azure Stack Hub | [Monitor health and alerts in Azure Stack Hub](/azure-stack/operator/azure-stack-monitor-health) | |
| Azure Table Storage | [Monitor Azure Table Storage](/azure/storage/tables/monitor-table-storage)<br><br>[Monitoring data reference for Azure Table Storage](/azure/storage/tables/monitor-table-storage-reference) | |
| Azure Update Manager | [Create alerts in Azure Update Manager](/azure/update-manager/manage-alerts) | |
| Azure Virtual Machine Scale Sets | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm) | [Application Insights for Azure VMs and virtual machine scale sets](/azure/azure-monitor/app/azure-vm-vmss-apps) |
| Azure Virtual Network | [Monitor Azure Virtual Network](/azure/virtual-network/monitor-virtual-network)<br><br>[Monitoring data reference for Azure Virtual Network](/azure/virtual-network/monitor-virtual-network-reference) | |
| Azure Virtual WAN | [Monitor Azure Virtual WAN](/azure/virtual-wan/monitor-virtual-wan)<br><br>[Monitoring data reference for Azure Virtual WAN](/azure/virtual-wan/monitor-virtual-wan-reference) | |
| Azure VMware Solution | [Monitor and protect VMs with Azure native services](/azure/azure-vmware/integrate-azure-native-services) | |
| Azure Virtual Desktop | [Monitor Azure Virtual Desktop](/azure/virtual-desktop/insights) | |
| Azure Virtual Machines | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | [Application Insights for Azure VMs and virtual machine scale sets](/azure/azure-monitor/app/azure-vm-vmss-apps)<br><br>[VM Watch](/azure/virtual-machines/azure-vm-watch)<br><br>[Availability monitoring](/azure/virtual-machines/flash-overview) |
| Azure VPN Gateway | [Monitor Azure VPN Gateway](/azure/vpn-gateway/monitor-vpn-gateway)<br><br>[Monitoring data reference for Azure VPN Gateway](/azure/vpn-gateway/monitor-vpn-gateway-reference) | |
| Azure Web Application Firewall | [Web Application Firewall + Azure Front Door](/azure/web-application-firewall/afds/waf-front-door-monitor)<br><br>[Web Application Firewall + Application Gateway](/azure/web-application-firewall/ag/application-gateway-waf-metrics)<br><br>[Resource logs for Azure Web Application Firewall](/azure/web-application-firewall/ag/web-application-firewall-logs) | |
| Azure Web PubSub | [Monitor Azure Web PubSub](/azure/azure-web-pubsub/howto-azure-monitor)<br><br>[Monitoring Azure Web PubSub data reference](/azure/azure-web-pubsub/howto-monitor-data-reference) | |
| Data Factory in Microsoft Fabric | [Monitor Data Factory](/fabric/data-factory/monitor-data-factory) | |
| Microsoft Dev Box | [Monitoring Microsoft Dev Box data reference](/azure/dev-box/monitor-dev-box-reference) | |
| Microsoft Entra Domain Services | [Check the health of Microsoft Entra Domain Services](/entra/identity/domain-services/check-health) | |
| Microsoft Entra External ID | [Azure Monitor in external tenants](/entra/external-id/customers/how-to-azure-monitor) | |
| Microsoft Entra ID | [What is Microsoft Entra monitoring and health?](/entra/identity/monitoring-health/overview-monitoring-health) | |
| Microsoft Sentinel | [Auditing and health monitoring in Microsoft Sentinel](/azure/sentinel/health-audit) | |
| Microsoft Dev Box | [Monitoring Microsoft Dev Box data reference](/azure/dev-box/monitor-dev-box-reference) | |
| Microsoft Entra Domain Services | [Check the health of Microsoft Entra Domain Services](/entra/identity/domain-services/check-health) | |
| Microsoft Entra External ID | [Azure Monitor in external tenants](/entra/external-id/customers/how-to-azure-monitor) | |
| Microsoft Entra ID | [What is Microsoft Entra monitoring and health?](/entra/identity/monitoring-health/overview-monitoring-health) | |
| Microsoft Dev Box | [Monitoring Microsoft Dev Box data reference](/azure/dev-box/monitor-dev-box-reference) | |
| Multicloud connector enabled by Azure Arc | [View multicloud inventory with the multicloud connector enabled by Azure Arc](/azure/azure-arc/multicloud-connector/view-multicloud-inventory) | |

## Shared management monitoring responsibilities

| Monitoring area | Centralized monitoring responsibilities | Workload monitoring responsibilities|
|-----------------|-----------------------------------------|-------------------------------------|
| Service health monitoring | Monitor overall cloud platform health, service outages, and maintenance.<br><br>Set baseline alerts for Azure Service Health.<br><br>Ensure SLA reporting.| Monitor specific application or workload resource health.<br><br>Respond to workload-specific service alerts. |
| Security monitoring | Define security standards and governance.<br><br>Monitor identity and network security centrally using tools like Defender for Cloud and Sentinel.<br><br>Perform enterprise-wide threat detection and investigations. | Implement workload-specific security monitoring.<br><br>Respond to workload-specific security threats and remediate security incidents.|
| Compliance monitoring | Establish central compliance and governance policies using tools like Azure Policy and Purview Compliance Manager.<br><br>Perform enterprise-wide audits and compliance assessments. | Ensure workload-specific compliance with central policies.<br><br>Remediate compliance issues detected within the workload. |
| Cost monitoring | Manage centralized cost monitoring tools like Microsoft Cost Management.<br><br>Set budgets, configure cost alerts, and provide enterprise-wide cost reporting. | Monitor and optimize workload-specific spending.<br><br>Comply with central cost guidelines, proactively manage budgets, and remediate cost anomalies.|
| Data monitoring | Govern data visibility, data classification, protection policies, and compliance using centralized tools like Microsoft Purview.<br><br>Ensure consistent data standards across environments. | Implement workload-specific data monitoring to meet governance and protection standards.<br><br>Ensure correct data classification and optimize data performance.|
| Code and runtime monitoring | Define baseline application monitoring standards and tooling such as Application Insights.<br><br>Provide guidance for collecting application logs, metrics, and traces. | Implement workload-specific application telemetry and logging.<br><br>Identify performance bottlenecks and remediate application-specific issues. |
| Cloud resource monitoring | Monitor shared services and manage centralized monitoring data.<br><br>Set standard resource-monitoring rules, dashboards, and retention policies. | Configure and manage workload-specific resource logs, metrics, and monitoring dashboards.<br><br>Resolve operational issues specific to the workload. |

## Next steps

> [!div class="nextstepaction"]
> [Protect your Azure cloud operations](./protect.md)

> [!div class="nextstepaction"]
> [CAF Manage checklist](./index.md#cloud-management-checklist)
