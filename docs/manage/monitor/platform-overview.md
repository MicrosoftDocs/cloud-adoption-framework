---
title: Cloud monitoring platforms overview
description: See a high-level overview of two monitoring platforms to help you understand how each delivers core monitoring functionality.
author: mgoedtel
ms.author: brblanch
ms.date: 07/31/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

<!-- docutune:casing "Squared Up" -->
<!-- cSpell:ignore opsman ITSM -->

# Cloud monitoring guide: Monitoring platforms overview

Microsoft provides a range of monitoring capabilities from two products: System Center Operations Manager, which was designed for on-premises and then extended to the cloud, and Azure Monitor, which was designed for the cloud but can also monitor on-premises systems. These two offerings deliver core monitoring services, such as alerting, service uptime tracking, application and infrastructure health monitoring, diagnostics, and analytics.

Many organizations are embracing the latest practices for DevOps agility and cloud innovations to manage their heterogenous environments. Yet they are also concerned about their ability to make appropriate and responsible decisions about how to monitor those workloads.

This article provides a high-level overview of our monitoring platforms to help you understand how each delivers core monitoring functionality.

## The story of System Center Operations Manager

In 2000, we entered the operations management field with Microsoft Operations Manager 2000. In 2007, we introduced a reengineered version of the product, System Center Operations Manager. It moved beyond simple monitoring of Windows Server instances and concentrated on robust, end-to-end service and application monitoring, including heterogenous platforms, network devices, and other application or service dependencies. It's an established, enterprise-grade monitoring platform for on-premises environments, in the same class as IBM Tivoli or HP Operations Manager in the industry. It has grown to support monitoring compute and platform resources running in Azure, Amazon Web Services (AWS), and other cloud providers.

## The story of Azure Monitor

When Azure was released in 2010, monitoring of cloud services was provided with the Azure Diagnostics agent, which provided a way to collect diagnostics data from Azure resources. This capability was considered a general monitoring tool rather than an enterprise-class monitoring platform.

Application Insights was introduced to shift with changes in the industry where proliferation of cloud, mobile, and IoT devices was growing and the introduction of DevOps practices. It grew from application performance monitoring in Operations Manager to a service in Azure, where it delivers rich monitoring of web applications written in a variety of languages. In 2015, the preview of Application Insights for Visual Studio was announced and later, it became known as just Application Insights. It collects details about application performance, requests and exceptions, and traces.

In 2015, Azure Operational Insights was made generally available. It delivered the Log Analytics service that collected and searched data from machines in Azure, on-premises, or other cloud environments, and connected to System Center Operations Manager. Intelligence packs were offered that delivered a variety of prepackaged management and monitoring configurations that contained a collection of query and analytic logic, visualizations, and data collection rules for such scenarios as security auditing, health assessments, and alert management. Later, Azure Operational Insights became known as Log Analytics.

In 2016, the preview of Azure Monitor was announced at the Microsoft Ignite conference. It provided a common framework to collect platform metrics, resource diagnostics logs, and subscription-level activity log events from any Azure service that started using the framework. Previously, each Azure service had its own monitoring method.

At the 2018 Ignite conference, we announced that the Azure Monitor brand expanded to include several different services originally developed with independent functionality:

- The original **Azure Monitor**, for collecting platform metrics, resource diagnostics logs, and activity logs for Azure platform resources only.
- **Application Insights**, for application monitoring.
- **Log Analytics**, the primary location for collecting and analyzing log data.
- A new **unified alerting service**, which brought together alert mechanisms from each of the other services mentioned earlier.

- **Azure Network Watcher**, for monitoring, diagnosing, and viewing metrics for resources in a virtual network.

<!-- docutune:casing "Operational Insights" -->

## The story of Operations Management Suite (OMS)

From 2015 until April 2018, Operations Management Suite (OMS) bundled the following Azure management services for licensing purposes:

- Application Insights
- Azure Automation
- Azure Backup
- Operational Insights (later rebranded as Log Analytics)
- Site Recovery

The functionality of the services that were part of OMS did not change when OMS was discontinued. They were realigned under Azure Monitor.

## Infrastructure requirements

### Operations Manager

Operations Manager requires significant infrastructure and maintenance to support a management group, which is a basic unit of functionality. At a minimum, a management group consists of one or more management servers, a SQL Server instance, hosting the operational and reporting data warehouse database, and agents. The complexity of a management group design depends on multiple factors, such as the scope of workloads to monitor, and the number of devices or computers supporting the workloads. If you require high availability and site resiliency, as is commonly the case with enterprise monitoring platforms, the infrastructure requirements and associated maintenance can increase dramatically.

![Diagram of Operations Manager management group](./media/monitoring-management-guidance-cloud-and-on-premises/operations-manager-management-group-optimized.svg)

### Azure Monitor

Azure Monitor is a software as a service (SaaS) offering, so its supporting infrastructure runs in Azure and is managed by Microsoft. It's performs monitoring, analytics, and diagnostics at scale. It's available in all national clouds. Core parts of the infrastructure (collectors, metrics and logs store, and analytics) that support Azure Monitor are maintained by Microsoft.

![Diagram of Azure Monitor](./media/monitoring-management-guidance-cloud-and-on-premises/azure-monitor-greyed-optimized.svg)

## Data collection

<!-- markdownlint-disable MD024 -->

### Operations Manager

#### Agents

Operations Manager collects data directly only from agents that are installed on [Windows computers](/system-center/scom/plan-planning-agent-deployment#windows-agent). It can accept data from the Operations Manager SDK, but this approach is typically used for partners that extend the product with custom applications, not for collecting monitoring data. It can collect data from other sources, such as [Linux computers](/system-center/scom/plan-planning-agent-deployment#linuxunix-agent) and network devices, by using special modules that run on the Windows agent that remotely accesses these other devices.

![Diagram of Operations Manager agent](./media/monitoring-management-guidance-cloud-and-on-premises/data-collection-opsman-agents-optimized.svg)

The Operations Manager agent can collect from multiple data sources on the local computer, such as the event log, custom logs, and performance counters. It can also run scripts, which can collect data from the local computer or from external sources. You can write custom scripts to collect data that can't be collected by other means, or to collect data from a variety of remote devices that can't otherwise be monitored.

#### Management packs

Operations Manager performs all monitoring with workflows (rules, monitors, and object discoveries). These workflows are packaged together in a [management pack](/system-center/scom/manage-overview-management-pack) and deployed to agents. Management packs are available for a variety of products and services, which include predefined rules and monitors. You can also author your own management pack for your own applications and custom scenarios.

#### Monitoring configuration

Management packs can contain hundreds of rules, monitors, and object discovery rules. An agent runs all these monitoring settings from all the management packs that apply, which are determined by discovery rules. Each instance of each monitoring setting runs independently and acts immediately on the data that it collects. This is how Operations Manager can achieve near-real-time alerting and the current health state of monitored resources.

For example, a monitor might sample a performance counter every few minutes. If that counter exceeds a threshold, it immediately sets the health state of its target object, which immediately triggers an alert in the management group. A scheduled rule might watch for a particular event to be created and immediately fire an alert when that event is created in the local event log.

Because these monitoring settings are isolated from each other and work from the individual sources of data, Operations Manager has challenges correlating data between multiple sources. It's also difficult to react to data after it's been collected. You can run workflows that access the Operations Manager database, but this scenario isn't common, and it's typically used for a limited number of special purpose workflows.

![Diagram of Operations Manager management group](./media/monitoring-management-guidance-cloud-and-on-premises/operations-manager-management-group-optimized.svg)

### Azure Monitor

#### Data sources

Azure Monitor collects data from a variety of sources, including Azure infrastructure and platform resources, agents on Windows and Linux computers, and monitoring data collected in Azure Storage. Any REST client can write log data to Azure Monitor by using an API, and you can define custom metrics for your web applications. Some metric data can be routed to different locations, depending on its usage. For example, you might use the data for "as-fast-as-possible" alerting or for long-term trend analysis searches in conjunction with other log data.

#### Monitoring solutions and insights

Monitoring solutions use the logs platform in Azure Monitor to provide monitoring for a particular application or service. They typically define data collection from agents or from Azure services, and provide log queries and views to analyze that data. They typically don't provide alert rules, which means that you must define your own alert criteria based on collected data.

Insights, such as Azure Monitor for containers and Azure Monitor for VMs, use the logs and metrics platform of Azure Monitor to provide a customized monitoring experience for an application or service in the Azure portal. They might provide health monitoring and alerting conditions, in addition to customized analysis of collected data.

#### Monitoring configuration

Azure Monitor separates data collection from actions taken against that data, which supports distributed microservices in a cloud environment. It consolidates data from multiple sources into a common data platform, and provides analysis, visualization, and alerting capabilities based on the collected data.

Data collected by Azure Monitor is stored as either logs or metrics, and different features of Azure Monitor rely on either. Metrics contain numerical values in time series that are well suited for near-real-time alerting and quick detection of issues. Logs contain text or numerical data and can be queried using a powerful language especially useful for performing complex analysis.

Because Azure Monitor separates data collection from actions against that data, it might be unable to provide near-real-time alerting in many cases. To alert on log data, queries are run on a recurring schedule defined in the alert. This behavior allows Azure Monitor to easily correlate data from all monitored sources, and you can interactively analyze data in a variety of ways. This is especially helpful for doing root cause analysis and identifying where else an issue might occur.

## Health monitoring

### Operations Manager

Management packs in Operations Manager include a service model that describes the components of the application being monitored and their relationship. Monitors identify the current health state of each component based on data and scripts on the agent. Health states roll up so that you can quickly view the summarized health state of monitored computers and applications.

### Azure Monitor

Azure Monitor doesn't provide a user-definable method of implementing a service model or monitors that indicate the current health state of any service components. Because monitoring solutions are based on standard features of Azure Monitor, they don't provide state-level monitoring. The following features of Azure Monitor can be helpful:

- **Application Insights:** Builds a composite map of your web application, and provides a health state for each application component or dependency. This includes alerts status and drill-down to more detailed diagnostics of your application.

- **Azure Monitor for VMs:** Delivers a health-monitoring experience for the guest Azure VMs, similar to that of Operations Manager, when it monitors Windows and Linux virtual machines. It evaluates the health of key operating system components from the perspective of availability and performance to determine the current health state. When it determines that the guest VM is experiencing sustained resource utilization, disk-space capacity, or an issue related to core operating system functionality, it generates an alert to bring this state to your attention.

- **Azure Monitor for containers:** Monitors the performance and health of Azure Kubernetes Service or Azure Container Instances. It collects memory and processor metrics from controllers, nodes, and containers that are available in Kubernetes through the metrics API. It also collects container logs and inventory data about containers and their images. Predefined health criteria that are based on the collected performance data help you identify whether a resource bottleneck or capacity issue exists. You can also understand the overall performance, or the performance from a specific Kubernetes object type (pod, node, controller, or container).

## Analyze data

### Operations Manager

Operations Manager provides four basic ways to analyze data after it has been collected:

- **Health Explorer:** Helps you discover which monitors are identifying a health state issue and review knowledge about the monitor and possible causes for actions related to it.

- **Views:** Offers predefined visualizations of collected data, such as a graph of performance data or a list of monitored components and their current health state. Diagram views visually present the service model of an application.

- **Reports:** Allow you to summarize historical data that's stored in the Operations Manager data warehouse. You can customize the data that views and reports are based on. However, there is no feature to allow for complex or interactive analysis of collected data.

- **Operations Manager command shell:** Extends Windows PowerShell with an additional set of cmdlets, and can query and visualize collected data. This includes graphs and other visualizations, natively with PowerShell, or with the Operations Manager HTML-based web console.

### Azure Monitor

With the powerful Azure Monitor analytics engine, you can interactively work with log data and combine them with other monitoring data for trending and other data analysis. Views and dashboards allow you to visualize query data in a variety of ways from the Azure portal, and import it into Power BI. Monitoring solutions include queries and views to present the data they collect. Insights such as Application Insights, Azure Monitor for VMs, and Azure Monitor for containers include customized visualizations to support interactive monitoring scenarios.

## Alerting

### Operations Manager

Operations Manager creates alerts in response to predefined events, when a performance threshold is met, and when the health state of a monitored component changes. It includes the complete management of alerts, allowing you to set their resolution and assign them to various operators or system engineers. You can set notification rules that specify which alerts will send proactive notifications.

Management packs include various predefined alerting rules for different critical conditions in the application being monitored. You can tune these rules or create custom rules to the particular requirements of your environment.

### Azure Monitor

With Azure Monitor, you can create alerts based on a metric crossing a threshold, or based on a scheduled query result. Although alerts based on metrics can achieve near-real-time results, scheduled queries have a longer response time, depending on the speed of data ingestion and indexing. Instead of being limited to a specific agent, log query alerts in Azure Monitor let you analyze data across all data stored in multiple workspaces. These alerts also include data from a specific Application Insights application by using a cross-workspace query.

Although monitoring solutions can include alert rules, you ordinarily create them based on your own requirements.

## Workflows

### Operations Manager

Management packs in Operations Manager contain hundreds of individual workflows, and they determine both what data to collect and what action to perform with that data. For example, a rule might sample a performance counter every few minutes, storing its results for analysis. A monitor might sample the same performance counter and compare its value to a threshold to determine the health state of a monitored object. Another rule might run a script to collect and analyze some data on an agent computer, and then fire an alert if it returns a particular value.

Workflows in Operations Manager are independent of each other, which makes analysis across multiple monitored objects difficult. These monitoring scenarios must be based on data after it's collected, which is possible but can be difficult, and it isn't common.

### Azure Monitor

Azure Monitor separates data collection from actions and analysis taken from that data. Agents and other data sources write log data to a Log Analytics workspace and write metric data to the metric database, without any analysis of that data or knowledge of how it might be used. Monitor performs alerting and other actions from the stored data, which allows you to perform analysis across data from all sources.

## Extend the base platform

### Operations Manager

Operations Manager implements all monitoring logic in a management pack, which you either create yourself or obtain from us or a partner. When you install a management pack, it automatically discovers components of the application or service on different agents, and deploys appropriate rules and monitors. The management pack contains health definitions, alert rules, performance and event collection rules, and views, to provide complete monitoring that supports the infrastructure service or application.

The Operations Manager SDK enables Operations Manager to integrate with third-party monitoring platforms or IT service management (ITSM) software. The SDK is also used by some partner management packs to support monitoring network devices and deliver custom presentation experiences, such as the Squared Up HTML5 dashboard or integration with Microsoft Office Visio.

### Azure Monitor

Azure Monitor collects metrics and logs from Azure resources, with little to no configuration. Monitoring solutions add logic for monitoring an application or service, but they still work within the standard log queries and views in Azure Monitor. Insights, such as Application Insights and Azure Monitor for VMs, use the Azure Monitor platform for data collecting and processing. They also provide additional tools to visualize and analyze the data. You can combine data collected by insights with other data, by using core Azure Monitor features such as log queries and alerts.

Monitor supports several methods to collect monitoring or management data from Azure or external resources. You can then extract and forward data from the metric or log stores to your ITSM or monitoring tools. Or you can perform administrative tasks by using the Azure Monitor REST API.

## Next steps

> [!div class="nextstepaction"]
> [Monitoring the cloud deployment models](./cloud-models-monitor-overview.md)
