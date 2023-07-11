---
title: Operations management considerations for the Azure Integration Services landing zone accelerator
description: Learn about design considerations and recommendations for operations management in the Azure Integration Services landing zone accelerator.
author: claytonsiemens77
ms.author: csiemens
ms.date: 03/16/2023
ms.topic: conceptual
ms.subservice: caf-scenario-app-plat
---

# Operations management considerations for the AIS Services landing zone accelerator

This article provides considerations and recommendations for operations management and monitoring when using the AIS offerings.

Most of the recommendations in this section apply to the Standard (single-tenant) version of Logic Apps, which itself is part of the Azure App Service offering and shares many of the same management capabilities.

Many resources that make up AIS can be configured to store log, telemetry and metric data in Log Analytics/Application Insights, or in custom storage locations (these resources include Storage Accounts, Event Hubs, and others).

We can utilize this information to visualize the overall health of our resources and take the appropriate management actions.

## Definitions

- **[Azure Monitor Logs](/azure/azure-monitor/logs/data-platform-logs)** collects and organizes log and performance data from monitored
  resources. Tools such as Log Analytics can then query or visualize this log information, or allow you to alert if certain conditions are met.

- **[Azure Metric Logs](/azure/azure-monitor/essentials/data-platform-metrics)** collects numeric data into a time-series database from monitored resources. Tools such as Application Insights can then visualize this data, help you identify performance and runtime issues.

- **[Log Analytics](/azure/azure-monitor/logs/log-analytics-overview)** is an Azure Monitoring offering, which provides a location to store
  log and performance data, provides a mechanism and language for querying those logs (Kusto); and provides the ability to create alerts and dashboards based on those logs (among other capabilities).

- **[Application Insights](/azure/azure-monitor/app/app-insights-overview)** is an Azure Monitoring offering, which provides the ability visualize
  and alert on performance data emitted by monitored resources.

- **[Kusto Query Language](/azure/data-explorer/kusto/query/)** (KQL) is a powerful query language optimized for querying and formatting data. For example, it's the primary query language for Log Analytics.

## Design Considerations

- Consider your monitoring solution as a whole:

  - What resources do you need to monitor?

  - How will you track messages that flow between resources?

  - What external systems will you connect to?

  - What types of alerting will you need?

- Think about what queries you need to run. For example, will you need to know if a given request takes longer than expected? Or if you get a single error vs a cluster of errors?

- What level of tracking will you need? For example, if a message arrives from a third party, do you need to track that message through all associated resources?

- What management tasks will you need to perform? Will you need to resubmit messages or files?

- Logic App run history is stored in Azure Storage by default, but you can choose to also export metrics and log files to other sources  (for example, Log Analytics, or an external Storage Account). Consider how you use your logging information, and if you use a centralized log store.

- Application Insights is used to provide application performance monitoring. It does so by collecting metrics from the resources that make up your solution.

- Log Analytics is used to query logs and set up alerts, enabling you to see the health of your resources and understand issues that may occur. Log data can include custom properties (see *Tracked Properties* below).

- Refer to the App Service landing zone accelerator [management article](../app-services/management.md) for more considerations and recommendations specific to App Services

## Design Recommendations

- Set up **Application Insights** so that it uses a Log Analytics Workspace as it’s data source (known as a [workspace-based resource](/azure/azure-monitor/app/convert-classic-resource)). Doing so allows logging and performance data to be kept in a consolidated location.

- Set up alerts for all resources to notify appropriate teams of events related to individual resources or to the workload.

- Link the resources in your solution to Application Insights, if supported. For example, a Logic App can be linked to Application Insights, so that runtime data and metrics are available for querying. See [here for an example](/azure/logic-apps/create-single-tenant-workflows-azure-portal#enable-open-application-insights).

- Use the **[clientTrackingId](/azure/logic-apps/monitor-logic-apps-log-analytics)** feature of Logic Apps to supply a custom tracking ID, allowing you to correlate events across logic app runs. You can use the x-ms-client-tracking-id header to achieve this result with the Request, HTTP, or HTTP+WebHook triggers.

- Use the **[Tracked Properties](/azure/logic-apps/monitor-logic-apps-log-analytics)** feature of Logic Apps to log other data (input or output) from an action into the log files. These properties are then available for use when querying logs using KQL with Log Analytics or another solution.

- Consider using resource tags. Resource tags can help you manage and organize resources on Azure. You can use them to assign metadata to resources. You can use this metadata for various purposes, like categorizing resources by application or business unit, tracking the cost of resources, and identifying resources for compliance.

## Sample Kusto Queries

The queries below show how to query the three main tables used for AIS log data. Each of these tables can be accessed from the Logs option in the Monitoring section of your Logic App.

The main query tables are:

- *exceptions*  
  This table contains any exceptions logged by your resource, like exceptions thrown by the Logic App runtime. It can be used to look for the underlying cause of any issues you see, either in the portal or during execution of your code.

- *requests*  
  This table logs all requests made by the Logic App runtime to another resource OR to specific actions within your workflow.

- *traces*  
  This table contains the bulk of the Logic Apps runtime logs, logging details on trigger execution, workflow starting and stopping, and action execution. If you've logged any tracked properties from your actions, you'll find this data in the *customDimensions* section.  You can then use the extend clause in a query to add the data as columns in your query response.

**Workflows with Errors:**

```Kusto
> traces
>
> \| where customDimensions\["Category"\] == "Host.Triggers.Workflows"
>
> \| where customDimensions.LogLevel == "Error"
```

**Number of workflow executions in last 24 hours across all workflows:**

```Kusto
> traces
>
> \| where customDimensions\["Category"\] == "Host.Triggers.Workflows"
>
> \| where customDimensions\["EventName"\] == "WorkflowActionStart"
>
> \| where timestamp \> ago(1d)
>
> \| count
```

**Trigger success rate, graphed over time**

```Kusto
> traces  
> \| where customDimensions\["Category"\] == "Host.Triggers.Workflows"  
> \| where customDimensions\["EventName"\] == "WorkflowTriggerEnd"  
> \|summarize
>
> success = countif(customDimensions\["prop\_\_status"\] ==
> "Succeeded"),
>
> failures = countif(customDimensions\["prop\_\_status"\] == "Failed")
>
> by bin(timestamp, 1m)  
> \| render timechart
```

## Next step

Review the critical design areas to make complete considerations and recommendations for your architecture.

> [!div class="nextstepaction"]
> [Governance](./governance.md)

## Recommended content

- [Application Insights overview](/azure/azure-monitor/app/app-insights-overview?tabs=net)

- [Overview of Log Analytics in Azure Monitor](/azure/azure-monitor/logs/log-analytics-overview)

- [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs)

- [Azure Monitor Metrics overview](/azure/azure-monitor/essentials/data-platform-metrics)

- [Set up Azure Monitor logs and collect diagnostics data for Azure Logic Apps](/azure/logic-apps/monitor-logic-apps-log-analytics)

- [Kusto Query Language (KQL) overview](/azure/data-explorer/kusto/query/)

- [Azure Logic Apps Running Anywhere – Monitor with Application Insights – part  1](https://techcommunity.microsoft.com/t5/integrations-on-azure-blog/azure-logic-apps-running-anywhere-monitor-with-application/ba-p/1877849)

- [Azure Logic Apps Running Anywhere – Monitor with Application Insights – part 2](https://techcommunity.microsoft.com/t5/integrations-on-azure-blog/azure-logic-apps-running-anywhere-monitor-with-application/ba-p/2003332)
