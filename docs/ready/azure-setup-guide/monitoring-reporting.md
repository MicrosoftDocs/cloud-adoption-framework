---
title: Monitoring and reporting in Azure
description: Learn how to use the Cloud Adoption Framework to set up monitoring, reporting, and alerts in Azure.
author: Zimmergren
ms.author: pnp
ms.reviewer: tozimmergren
ms.date: 12/13/2022
ms.topic: conceptual
ms.custom: think-tank, fasttrack-edit, AQC, setup, engagement-fy23
products: azure-monitor
---

# Monitoring and reporting in Azure

Azure offers many services that together provide a comprehensive solution for collecting, analyzing, and acting on telemetry from your applications and the Azure resources that support them. These services can also monitor critical on-premises resources to provide a hybrid monitoring environment.

## [Azure Monitor](#tab/AzureMonitor)

Azure Monitor provides a single unified hub for all monitoring and diagnostics data in Azure. You can use it to get visibility across your resources. With Azure Monitor, you can find and fix problems, optimize performance, and understand customer behavior.

- **Data collection**: Azure Monitor collects data from [various data sources](/azure/azure-monitor/overview#what-data-can-azure-monitor-collect), including: Application, Container, Guest operating system, Azure resource, Azure subscription, Azure tenant, and Azure resource changes. Additionally, Azure Monitor can collect log data from any REST client using the [Data Collector API](/azure/azure-monitor/logs/data-collector-api).

- **Insights**: Availability, performance, usage, and health of your web applications are monitored using [Application Insights](/azure/azure-monitor/app/app-insights-overview). Further, you can use the insights features of Azure Monitor to monitor your:

  - [Applications](/azure/azure-monitor/app/app-insights-overview)
  - [Containers](/azure/azure-monitor/containers/container-insights-overview)
  - [Virtual machines](/azure/azure-monitor/vm/vminsights-overview)
  - [Networks](/azure/networking/network-monitoring-overview)

- **Visualization**: Visualizing your monitoring data will greatly help you get an overview of the current posture of your cloud real estate. Make use of visualizations with built-in or custom charts and tables, workbooks, dashboards, or Power BI.
  - Read more about [best practices for analyzing and visualizing data](/azure/azure-monitor/best-practices-analysis).

- **Response**: An effective monitoring strategy often requires an actionable response to critical events in the collected data. You can automate actions by using the built-in [Alerts](/azure/azure-monitor/overview#alerts) or [Autoscale](/azure/azure-monitor/overview#autoscale) capabilities.

::: zone target="docs"

Find more solutions in the Azure Marketplace for monitoring other resource types.

To explore Azure Monitor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview).

### Learn more

To learn more, see [Azure Monitor documentation](/azure/azure-monitor/).

::: zone-end

::: zone target="chromeless"

::: zone-end

## [Azure Service Health](#tab/AzureServiceHealth)

Azure Service Health provides a personalized view of the health of your Azure services and regions. Information about active issues is posted to Azure Service Health to help you understand the impact on your resources. Regular updates keep you informed as problems are resolved.

Set up Service Health alerts to notify you when service issues, planned maintenance, or other changes might affect the Azure services and regions you use. You can also view planned maintenance events that could affect the availability of your resources.

Azure Service Health includes:

- **Azure status:** A global view of the health of Azure services.
- **Service health:** A personalized view of the health of your Azure services.
- **Resource health:** A deeper view of the health of each of your resources.

::: zone target="chromeless"

<!-- markdownlint-disable MD024 -->

### Action

To set up a Service Health alert:

1. Go to **Service Health**.
2. Select **Health alerts**.
3. Create a Service Health alert.

::: zone-end

::: zone target="docs"

To set up an Azure Service Health alert, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts).

### Learn more

For more information, see [Azure Service Health documentation](/azure/service-health/).

::: zone-end

## [Azure Advisor](#tab/AzureAdvisor)

Azure Advisor is a free, personalized cloud consultant that helps you follow and implement best practices for Azure deployments. Azure Advisor analyzes your resource configuration and usage telemetry and then recommends solutions that can help optimize your environment. The recommendations are divided into the following categories:

- **Reliability:** To improve the continuity of your business-critical applications. Recommendations might include adding virtual machines to an availability set or adding geo-redundant endpoints.
- **Security:** To detect threats and vulnerabilities that might lead to security breaches. Recommendations might include applying Azure Disk Encryption or enabling network security groups.
- **Performance:** To improve the speed of your applications. Recommendations might include boosting SQL query performance by creating indexes or reconfiguring your Traffic Manager settings.
- **Cost:** To optimize and reduce your overall Azure spending. Recommendations might include resizing or shutting down underused virtual machines or switching to Azure Reservations to lower the total cost of ownership.
- **Operational excellence:** To improve process and workflow efficiency and manageability. Recommendations might include setting up and enforcing Azure Policy rules, repairing invalid log alert rules, and configuring Service Health alerts.

Recommendations in Azure Advisor are based on the resources you deploy and your actions in Azure. You can check Advisor regularly for the latest recommendations.

Additionally, the five categories in Azure Advisor directly relate to the pillars of the [Azure Well-Architected Framework](/azure/architecture/framework/), a set of guiding tenets to optimize and improve the quality of your workloads.

::: zone target="chromeless"

::: zone-end

::: zone target="docs"

To explore Azure Advisor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Expert/AdvisorBlade).

### Learn more

To learn more, see [Azure Advisor documentation](/azure/advisor/).

::: zone-end

## [Microsoft Defender for Cloud](#tab/AzureSecurityCenter)

Microsoft Defender for Cloud also plays an integral part in your monitoring strategy. Defender for Cloud can help you monitor the security of your machines, networks, storage, data services, and applications. It provides advanced threat detection using machine learning and behavioral analytics to help identify active threats targeting your Azure resources. Defender for Cloud also provides threat protection that blocks malware or other unwanted code and reduces the surface area exposed to brute force and other network attacks.

When Defender for Cloud identifies a threat, it triggers a security alert with steps you need to take to respond to an attack. It also provides a report with information about the threat that was detected.

Microsoft Defender for Cloud is offered in two flavors:

- **Free**. Offers the secure score and related tools.
- **Enhanced security features**. Enables all of the Microsoft Defender plans to provide a range of security benefits for all your resources in Azure, hybrid, and multicloud environments.

::: zone target="chromeless"

### Action

**Try Standard tier for free for your first 30 days.**

After you turn on and set up security policies for a subscription's resources, you can view the security state of your resources and any issues in the **Prevention** section. You can also view a list of those issues on the **Recommendations** tile.

::: zone-end

::: zone target="docs"

To explore Microsoft Defender for Cloud, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0).

### Learn more

See [Microsoft Defender for Cloud documentation](/azure/defender-for-cloud/) to learn more.

::: zone-end

## [Microsoft Sentinel](#tab/MicrosoftSentinel)

Microsoft Sentinel delivers intelligent security analytics and threat intelligence across the enterprise. You can use the capabilities from Microsoft Sentinel to monitor security events at scale. Utilize sophisticated workbooks to build customized reports and dashboards with the correct data at your fingertips.

Microsoft Sentinel provides two critical cloud-native solutions:

- Security information and event management (SIEM)
- Security orchestration, automation, and response (SOAR)

By connecting data sources to Microsoft Sentinel using the built-in connectors, you can also widen your monitoring lens to a broader security and application ecosystem for non-Microsoft solutions.

**Get started:**

1. Review the [Microsoft Sentinel pricing](https://azure.microsoft.com/pricing/details/microsoft-sentinel/) to understand the cost impact.
1. Learn how to [onboard Microsoft Sentinel](/azure/sentinel/quickstart-onboard) and set up data connectors to monitor and protect your environment.

After you've connected data sources using the data connectors, you can immediately start using the platform's capabilities.

::: zone target="docs"

To explore Microsoft Sentinel, go to the [Azure portal](https://portal.azure.com/#view/HubsExtension/BrowseResource/resourceType/microsoft.securityinsightsarg%2Fsentinel).

### Learn more

See [Microsoft Sentinel documentation](/azure/sentinel/) to learn more.

::: zone-end
