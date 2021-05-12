---
title: Cloud monitoring and alerting
description: Use the Cloud Adoption Framework for Azure to learn how to determine when to use Azure Monitor or System Center Operations Manager in Microsoft Azure.
author: MGoedtel
ms.author: brblanch
ms.date: 08/05/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

<!-- cSpell:ignore multisignal -->

# Cloud monitoring guide: Alerting

For years, IT organizations have struggled to combat the alert fatigue that's created by the monitoring tools deployed in the enterprise. Many systems generate a high volume of alerts often considered meaningless, while other alerts are relevant but are either overlooked or ignored. As a result, IT and developer operations have struggled to meet the service-level quality promised to internal or external customers. To ensure reliability, it's essential to understand the state of your infrastructure and applications. To minimize service degradation and disruption, or to decrease the effect of or reduce the number of incidents, you need to identify causes quickly.

## Successful alerting strategy

*You can't fix what you don't know is broken.*

Alerting on what matters is critical. It's underpinned by collecting and measuring the right metrics and logs. You also need a monitoring tool capable of storing, aggregating, visualizing, analyzing, and initiating an automated response when conditions are met. You can improve the observability of your services and applications only if you fully understand its composition. You map that composition into a detailed monitoring configuration to be applied by the monitoring platform. This configuration includes the predictable failure states (the symptoms, not the cause of the failure) that make sense to alert for.

Consider the following principles for determining whether a symptom is an appropriate candidate for alerting:

- **Does it matter?** Is the issue symptomatic of a real problem or issue influencing the overall health of the application? For example, do you care whether the CPU utilization is high on the resource? Or that a particular SQL query running on a SQL database instance on that resource is consuming high CPU utilization over a sustained period? Because the CPU utilization condition is a real issue, you should alert on it. But you don't need to notify the team, because it doesn't help point to what is causing the condition in the first place. Alerting and notifying on the SQL query process utilization issue is both relevant and actionable.
- **Is it urgent?** Is the issue real, and does it need urgent attention? If so, the responsible team should be immediately notified.
- **Are your customers affected?** Are users of the service or application affected as a result of the issue?
- **Are other dependent systems affected?** Are there alerts from dependencies that are interrelated, and that can possibly be correlated to avoid notifying different teams all working on the same problem?

Ask these questions when you're initially developing a monitoring configuration. Test and validate the assumptions in a nonproduction environment, and then deploy into production. Monitoring configurations are derived from known failure modes, test results of simulated failures, and experience from different members of the team.

After the release of your monitoring configuration, you can learn a lot about what's working and what's not. Consider high alert volume, issues unnoticed by monitoring but noticed by end users, and what were the best actions to have taken as part of this evaluation. Identify changes to implement to improve service delivery, as part of an ongoing, continuous monitoring improvement process. It's not just about evaluating alert noise or missed alerts, but also the effectiveness of how you're monitoring the workload. It's about the effectiveness of your alert policies, process, and overall culture to determine whether you're improving.

Both System Center Operations Manager and Azure Monitor support alerts based on static or even dynamic thresholds and actions set up on top of them. Examples include alerts for email, SMS, and voice calls for simple notifications. Both of these services also support IT service management (ITSM) integration, to automate the creation of incident records and escalate to the correct support team, or any other alert management system that uses a webhook.

When possible, you can use any of several services to automate recovery actions. These include System Center Orchestrator, Azure Automation, Azure Logic Apps, or autoscaling in the case of elastic workloads. While notifying the responsible teams is the most common action for alerting, automating corrective actions might also be appropriate. This automation can help streamline the entire incident management process. Automating these recovery tasks can also reduce the risk of human error.

## Azure Monitor alerting

If you're using Azure Monitor exclusively, follow these guidelines as you consider speed, cost, and storage volume.

Depending on the feature and configuration you're using, you can store monitoring data in any of six repositories:

- **Azure Monitor metrics database:** A time-series database used primarily for Azure Monitor platform metrics, but also has Application Insights metric data mirrored into it. Information entering this database has the fastest alert times.

- **Application Insights resource:** A database that stores most Application Insights telemetry in log form.

- **Azure Monitor Log Analytics workspace:** The primary store for Azure log data. Other tools can route data to it and can be analyzed in Azure Monitor Logs. Because of ingestion and indexing, log alert queries have higher latency. This latency is generally 5-10 minutes, but can be higher under certain circumstances.

- **Activity log:** Used for all activity log and service health events. Dedicated alerting is possible. Holds subscription level events that occur on objects in your subscription, as seen from the outside of those objects. An example might be when a policy is set or a resource is accessed or deleted.

- **Azure Storage:** General-purpose storage that's supported by Azure Diagnostics and other monitoring tools. It's a low-cost option for long-term retention of monitoring telemetry. Alerting isn't supported from data that's stored in this service.

- **Event Hubs:** Generally used to stream data into on-premises or other partners' monitoring or ITSM tools.

Azure Monitor has four types of alerts, each somewhat tied to the repository that the data is stored in:

- [Metric alert](/azure/azure-monitor/alerts/alerts-metric): Alerts on metric data in Azure Monitor. Alerts occur when a monitored value crosses a user-defined threshold, and then again when it returns to "normal" state.

- [Log query alert](/azure/azure-monitor/alerts/alerts-log-query): Available to alert on log data from Application Insights or Azure Monitor Logs. It can also alert based on cross-workspace queries.

- [Activity log alert](/azure/azure-monitor/alerts/alerts-activity-log): Alerts on items in the activity log, with the exception of Azure Service Health data.

- [Azure Service Health alert](/azure/service-health/alerts-activity-log-service-notifications-portal): A special type of alert that's used only for Azure Service Health issues that come from the activity log, such as outages and upcoming planned maintenance. Note that this type of alert is configured through [Azure Service Health](/azure/service-health/service-health-overview), a companion service to Azure Monitor.

### Enable alerting through partner tools

If you're using an external alerting solution, route as much as you can through Azure Event Hubs, which is the fastest path out of Azure Monitor. You'll have to pay for ingestion into Event Hubs. If cost is an issue and speed isn't, you can use Azure Storage as a less expensive alternative. Just make sure that your monitoring or ITSM tools can read Azure Storage to extract the data.

Azure Monitor includes support for integrating with other monitoring platforms, and ITSM software such as ServiceNow. You can use Azure alerting and still trigger actions outside of Azure, as required by your incident management or DevOps process. If you want to alert in Azure Monitor and automate the response, you can initiate automated actions by using Azure Functions, Azure Logic Apps, or Azure Automation, based on your scenario and requirements.

### Specialized Azure monitoring offerings

[Management solutions](/azure/azure-monitor/monitor-reference) generally store their data Azure Monitor Logs. Two exceptions are Azure Monitor for VMs and Azure Monitor for containers. The following table describes the alerting experience based on the particular data type and where it's stored.

| Solution | Data type | Alert behavior |
|---| ---| --- |
| Azure Monitor for containers | Calculated average performance data from nodes and pods are written to the metrics database. | Create metric alerts if you want to be alerted based on variation of measured utilization performance, aggregated over time. |
| | Calculated performance data that uses percentiles from nodes, controllers, containers, and pods are written to the workspace. Container logs and inventory information are also written to the workspace. | Create log query alerts if you want to be alerted based on variation of measured utilization from clusters and containers. Log query alerts can also be configured based on pod-phase counts and status node counts. |
| Azure Monitor for VMs | Health criteria are metrics stored in the metrics database. | Alerts are generated when the health state changes from healthy to unhealthy. This alert supports only action groups that are configured to send SMS or email notifications. |
| | Map and guest operating system performance log data is written to the Log Analytics workspace. | Create log query alerts. |

### Fastest speed, driven by cost

Latency is one of the most critical decisions driving alerting and a quick resolution of issues affecting your service. If you require near-real-time alerting under five minutes, evaluate first if you have or can get alerts on your telemetry where it's stored by default. In general, this strategy is also the cheapest option, because the tool you're using is already sending its data to that location.

That said, there are some important footnotes to this rule.

**Guest OS telemetry** has multiple paths to get into the system.

- The fastest way to alert on this data is to import it as custom metrics. Do this by using the Azure Diagnostics extension and then using a metric alert. However, custom metrics are currently in preview and are [more expensive than other options](https://azure.microsoft.com/pricing/details/monitor/).

- The least expensive, but with some ingestion latency, is to send it to a Log Analytics workspace. Running the Log Analytics agent on the VM is the best way to get all guest operating system metric and log data into the workspace.

- You can send it for storage as a metric and a log in Azure Monitor by running both the Azure Diagnostics extension and the Log Analytics agent on the same VM. You can then alert quicker, but also use the guest operating system data as part of more complex queries when you combine it with other telemetry.

**Importing data from on-premises:** If you're trying to query and monitor across machines running in Azure and on-premises, you can use the Log Analytics agent to collect guest operating system data. You can then use a feature called [logs to metrics](/azure/azure-monitor/alerts/alerts-metric-logs) to collect and store as metrics in Azure Monitor. This method bypasses part of the ingestion process into Azure Monitor Logs, and the data is thus available sooner.

### Minimize alerts

If you use a solution such as Azure Monitor for VMs and find the default health criteria that monitors performance utilization acceptable, don't create overlapping metric or log query alerts based on the same performance counters.

If you aren't using Azure Monitor for VMs, make the job of creating alerts and managing notifications easier by exploring the following features:

> [!NOTE]
> These features apply only to metric alerts, alerts based on data that's being sent to the Azure Monitor metric database. The features don't apply to the other types of alerts. As mentioned previously, the primary objective of metric alerts is speed. If getting an alert in less than five minutes isn't of primary concern, you can use a log query alert instead.

- [Dynamic thresholds](/azure/azure-monitor/alerts/alerts-dynamic-thresholds): Dynamic thresholds look at the activity of the resource over a time period, and create upper and lower "normal behavior" thresholds. When the metric being monitored falls outside of these thresholds, you get an alert.

- [Multisignal alerts](https://azure.microsoft.com/blog/monitor-at-scale-in-azure-monitor-with-multi-resource-metric-alerts/): You can create a metric alert that uses the combination of two different inputs from two different resource types. For example, if you want to fire an alert when the CPU utilization of a VM is over 90 percent, and the number of messages in a certain Azure Service Bus queue feeding that VM exceeds a certain amount, you can do so without creating a log query. This feature works for only two signals. If you have a more complex query, feed your metric data into the Log Analytics workspace, and use a log query.

- [Multiresource alerts](https://azure.microsoft.com/blog/monitor-at-scale-in-azure-monitor-with-multi-resource-metric-alerts/): Azure Monitor allows a single metric alert rule that applies to all VM resources. This feature can save you time because you don't need to create individual alerts for each VM. Pricing for this type of alert is the same. Whether you create 50 alerts for monitoring CPU utilization for 50 VMs, or one alert that monitors CPU utilization for all 50 VMs, it costs you the same amount. You can use these types of alerts in combination with dynamic thresholds as well.

Used together, these features can save time by minimizing alert notifications and the management of the underlying alerts.

### Limits on alerts

Be sure to note the [limits on the number of alerts you can create](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-monitor-limits). Some limits (but not all of them) can be increased by calling support.

### Best query experience

If you're looking for trends across all your data, it makes sense to import all your data into Azure Monitor Logs, unless it's already in Application Insights. You can create queries across both workspaces, so there's no need to move data between them. You can also import activity log and Azure Service Health data into your Log Analytics workspace. You pay for this ingestion and storage, but you get all your data in one place for analysis and querying. This approach also gives you the ability to create complex query conditions and alert on them.
