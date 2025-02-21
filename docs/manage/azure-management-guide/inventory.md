---
title: Inventory and visibility in Azure
description: Learn the tools that provide both an inventory and visibility into the inventory's run state to collect operational data.
author: martinekuan
ms.author: martinek
ms.date: 10/14/2024
ms.topic: conceptual
ms.custom: internal, fasttrack-edit, AQC
---

# Inventory and visibility in Azure

*Inventory and visibility* is the first of three disciplines in a cloud management baseline.

![Cloud management baseline](../../_images/manage/management-baseline.png)

This discipline comes first because collecting proper operational data is vital when you make decisions about operations. Cloud management teams must understand what is managed and how well those assets are operated. This article describes the different tools that provide both an inventory and visibility into the inventory's run state.

For any enterprise-grade environment, the following table outlines the suggested minimum for a management baseline.

| Process | Tool | Purpose |
|---|---|---|
| Monitor health of Azure services | [Azure Service Health](/azure/service-health/service-health-overview) | Health, performance, and diagnostics for services running in Azure |
| Monitoring centralization | [Azure Monitor](/azure/azure-monitor/overview) | Central monitoring of operational data and trends |
| Virtual machine monitoring | [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-overview) | Monitoring data from the guest operating system of Azure and hybrid virtual machines |
| Virtual machine inventory and change tracking | [Change Tracking and Inventory in Azure Automation](/azure/automation/change-tracking/overview-monitoring-agent) | Inventory VMs and monitor changes for guest OS level |
| Subscription monitoring | [Azure activity log](/azure/azure-monitor/essentials/activity-log) | Monitoring change at the subscription level |
| Guest OS monitoring | [Azure Monitor for VMs](/azure/azure-monitor/vm/vminsights-overview) | Monitoring changes and performance of VMs |
| Network monitoring | [Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) | Monitoring network changes and performance |
| DNS monitoring | [DNS Analytics](/azure/azure-monitor/insights/dns-analytics) | Security, performance, and operations of DNS |

::: zone target="docs"

## Azure Service Health

::: zone-end
::: zone target="chromeless"

## [Azure Service Health](#tab/AzureServiceHealth)

::: zone-end

Azure Service Health provides a personalized view of the health of your Azure services and regions. Information about active issues is posted to Azure Service Health to help you understand the effect on your resources. Regular updates keep you informed as issues are resolved.

We also publish planned maintenance events to Azure Service Health so you know about changes that can affect resource availability. Set up Service Health alerts to notify you when service issues, planned maintenance, or other changes might affect your Azure services and regions.

Azure Service Health includes:

- **Azure status:** A global view of the health of Azure services.
- **Service health:** A personalized view of the health of your Azure services.
- **Resource health:** A deeper view of the health of your individual resources.

::: zone target="chromeless"

<!-- markdownlint-disable MD024 -->

### Action

To set up a Service Health alert:

1. Go to **Service Health**.
2. Select **Health alerts**.
3. Create a Service Health alert.

::: zone-end

::: zone target="docs"

To set up Service Health alerts, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts).

### Learn more

For more information, see [Azure Service Health](/azure/service-health/).

## Azure Monitor

::: zone-end
::: zone target="chromeless"

## [Azure Monitor](#tab/Azure-Monitor)

::: zone-end

Azure Monitor provides a single unified hub for all monitoring and diagnostics data in Azure and gives you visibility across your resources. With Azure Monitor, you can find and fix problems and optimize performance. You can also understand customer behavior.

- **Monitor and visualize metrics.** Metrics are numerical values available from Azure resources. They help you understand the health of your systems. Customize charts for your dashboards, and use workbooks for reporting.

- **Query and analyze logs.** Logs include activity logs and diagnostic logs from Azure. Collect more logs from other monitoring and management solutions for your cloud or on-premises resources. Log Analytics provides a central repository to aggregate all of this data. From there, you can run queries to help troubleshoot issues or to visualize data.

- **Set up alerts and actions.** Alerts notify you of critical conditions. Corrective actions can be taken based on triggers from metrics, logs, or service-health issues. You can set up different notifications and actions and can also send data to your IT service management tools.

::: zone target="chromeless"

::: zone-end

::: zone target="docs"

Start monitoring your:

- [Applications](/azure/azure-monitor/app/app-insights-overview)
- [Containers](/azure/azure-monitor/containers/container-insights-overview)
- [Virtual machines](/azure/azure-monitor/vm/service-map)
- [Networks](/azure/networking/network-monitoring-overview)

To monitor other resources, find other solutions in Azure Marketplace.

To explore Azure Monitor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview).

### Learn more

To learn more, see [Azure Monitor documentation](/azure/azure-monitor/).

## Azure Monitor Agent

::: zone-end
::: zone target="chromeless"

## [Azure Monitor Agent](#tab/Monitor-Agent)

::: zone-end

Azure Monitor Agent (AMA) collects monitoring data from the guest operating system of Azure and hybrid virtual machines and delivers it to Azure Monitor for use by features, insights, and other services such as Microsoft Sentinel and Microsoft Defender for Cloud.

### Learn more

To learn more, see the [Azure Monitor Agent overview](/azure/azure-monitor/agents/azure-monitor-agent-overview).

## Microsoft Cloud for Sovereignty transparency logs

If you're using Microsoft Cloud for Sovereignty, you can use [transparency logs](/industry/sovereignty/transparency-logs) to understand when Microsoft engineers access your resources. These logs help with sovereignty compliance and other regulatory requirements.
