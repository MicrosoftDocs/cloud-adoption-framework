---
title: Inventory and visibility in Azure
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how to set up inventory, monitoring, reporting, and alerts for your Azure management environment.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

# Inventory and visibility in Azure

_Inventory and visibility_ is the first of three disciplines in a cloud management baseline.

![Cloud Management Baseline](../../_images/manage/management-baseline.png)

This discipline comes first because it is vital to collect proper operational data when making decisions about operations. Cloud management teams need to understand what is being managed and how well those assets are being operated. This article walks through the various tools that provide both an inventory and visibility into the inventory's run state.

For any enterprise-grade environment, the following table outlines the suggested minimum for any management baseline.

|Process  |Tool  |Purpose  |
|---------|---------|---------|
|Monitor health of Azure services|Azure Service Health|Health, performance, and diagnostics for services running in Azure|
|Log centralization|Log Analytics|Central logging for all visibility purposes|
|Monitoring centralization|Azure Monitor|Central monitoring of operational data and trends|
|VM Inventory and Change Tracking|Azure Change Tracking and Inventory Service|Inventory VMs and monitor changes for guest os level|
|Service Health|Azure Activity Log|Monitor change at the subscription level|
|Guest OS monitoring|Azure Monitor for VMs|Monitor changes and performance of VMs|
|Network Monitoring|Azure Network Watcher|Monitor network changes and performance|
|DNS monitoring|DNS Analytics|Security, Performance, and operations of DNS|

::: zone target="docs"

## Azure Service Health

::: zone-end
::: zone target="chromeless"

## [Azure Service Health](#tab/AzureServiceHealth)

::: zone-end

Azure Service Health provides a personalized view of the health of the Azure services and regions you use. Information about active issues is posted to Service Health to help you understand the impact to your resources. Regular updates keep you informed as the issue is resolved.

We also publish planned maintenance events to Service Health so you'll know about changes that could affect the availability of your resources. Set up Service Health alerts to be notified when service issues, planned maintenance, or other changes might affect the Azure services and regions you use.

Azure Service Health includes:

- **Azure status:** A global view of the health of Azure services.
- **Service health:** A personalized view of the health of your Azure services.
- **Resource health:** A deeper view of the health of each of your individual resources.

::: zone target="chromeless"

<!-- markdownlint-disable MD024 -->

### Action

To set up a Service Health alert:

1. Go to **Service Health**.
2. Select **Health alerts**.
3. Create a service health alert.

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts]" submitText="Go to Service Health" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To set up a Service Health alert, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts).

### Learn more

To learn more, see the [Azure Service Health documentation](https://docs.microsoft.com/azure/service-health).

## Log Analytics

::: zone-end
::: zone target="chromeless"

## [Log Analytics](#tab/Log-Analytics)

::: zone-end

A [Log Analytics workspace](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace) is a unique environment for storing Azure Monitor log data. Each workspace has its own data repository and configuration. Data sources and solutions are configured to store their data in particular workspaces. Azure monitoring solutions require all servers to be connected to a workspace, so that their log data can be stored and accessed.

::: zone target="chromeless"

### Action

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.OperationalInsights%2Fworkspaces]" submitText="Explore Azure Monitor" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

### Learn more

To learn more, see the [Log Analytics workspace creation documentation](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace).

## Azure Monitor

::: zone-end
::: zone target="chromeless"

## [Azure Monitor](#tab/Azure-Monitor)

::: zone-end

Azure Monitor provides a single unified hub for all monitoring and diagnostics data in Azure. You can use it to get visibility across your resources. With Azure Monitor, you can find and fix problems and optimize performance. You also can understand customer behavior.

- **Monitor and visualize metrics.** Metrics are numerical values available from Azure resources that help you understand the health of your systems. Customize charts for your dashboards, and use workbooks for reporting.

- **Query and analyze logs.** Logs include activity logs and diagnostic logs from Azure. Collect additional logs from other monitoring and management solutions for your cloud or on-premises resources. Log Analytics provides a central repository to aggregate all this data. From there, you can run queries to help troubleshoot issues or to visualize data.

- **Set up alerts and actions.** Alerts proactively notify you of critical conditions. Corrective actions can be taken based on triggers from metrics, logs, or service health issues. You can set up different notifications and actions and send data to your IT service management tools.

::: zone target="chromeless"

### Action

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview]" submitText="Explore Azure Monitor" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

 Start monitoring your:

- [Applications](https://docs.microsoft.com/azure/application-insights/app-insights-overview)
- [Containers](https://docs.microsoft.com/azure/monitoring/monitoring-container-overview)
- [Virtual machines](https://docs.microsoft.com/azure/monitoring/monitoring-service-map)
- [Networks](https://docs.microsoft.com/azure/networking/network-monitoring-overview)

To monitor other resources, find additional solutions in the Azure Marketplace.

To explore Azure Monitor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview).

### Learn more

To learn more, see [Azure Monitor documentation](https://docs.microsoft.com/azure/monitoring-and-diagnostics).

## Onboard solutions

::: zone-end
::: zone target="chromeless"

## [Onboard solutions](#tab/Configure-solutions)

::: zone-end

To enable solutions, you need to configure the Log Analytics workspace. Onboarded Azure VMs and on-premises servers will get the solutions from the Log Analytics workspaces they are connected to.

There are two approaches to onboarding:

- [Single VM](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/azure-server-management/onboard-single-vm)
- [Entire subscription](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/azure-server-management/onboard-at-scale)

Each article will guide you through a series of steps to onboard the following solutions:

- Update Management
- Change Tracking and Inventory
- Azure Activity Log
- Azure Log Analytics Agent Health
- Antimalware Assessment
- Azure Monitor for VMs
- Azure Security Center

Each of the above will help establish inventory and visibility.
