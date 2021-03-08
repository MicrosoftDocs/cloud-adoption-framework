---
title: Monitoring and reporting in Azure
description: Use the Cloud Adoption Framework for Azure to learn how to set up monitoring, reporting, and alerts for your Azure management environment.
author: timleyden
ms.author: brblanch
ms.date: 04/09/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.localizationpriority: high
ms.custom: think-tank, fasttrack-edit, AQC, setup
---

# Monitoring and reporting in Azure

Azure offers many services that together provide a comprehensive solution for collecting, analyzing, and acting on telemetry from your applications and the Azure resources that support them. In addition, these services can extend to monitoring critical on-premises resources to provide a hybrid monitoring environment.

## [Azure Monitor](#tab/AzureMonitor)

Azure Monitor provides a single unified hub for all monitoring and diagnostics data in Azure. You can use it to get visibility across your resources. With Azure Monitor, you can find and fix problems and optimize performance. You also can understand customer behavior.

- **Monitor and visualize metrics.** Metrics are numerical values available from Azure resources that help you understand the health of your systems. Customize charts for your dashboards, and use workbooks for reporting.

- **Query and analyze logs.** Logs include activity logs and diagnostic logs from Azure. Collect additional logs from other monitoring and management solutions for your cloud or on-premises resources. Log Analytics provides a central repository to aggregate all this data. From there, you can run queries to help troubleshoot issues or to visualize data.

- **Set up alerts and actions.** Alerts proactively notify you of critical conditions. Corrective actions can be taken based on triggers from metrics, logs, or service health issues. You can set up different notifications and actions and send data to your IT service management tools.

::: zone target="docs"

 Start monitoring your:

- [Applications](/azure/azure-monitor/app/app-insights-overview)
- [Containers](/azure/azure-monitor/containers/container-insights-overview)
- [Virtual machines](/azure/azure-monitor/vm/service-map)
- [Networks](/azure/networking/network-monitoring-overview)

To monitor other resources, find additional solutions in the Azure Marketplace.

To explore Azure Monitor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview).

### Learn more

To learn more, see [Azure Monitor documentation](/azure/azure-monitor/).

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

### Action

::: form action="OpenBlade[#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview]" submitText="Explore Azure Monitor" :::

::: zone-end

## [Azure Service Health](#tab/AzureServiceHealth)

Azure Service Health provides a personalized view of the health of the Azure services and regions you use. Information about active issues is posted to Azure Service Health to help you understand the impact to your resources. Regular updates keep you informed as the issue is resolved.

We also publish planned maintenance events to Azure Service Health so you'll know about changes that could affect the availability of your resources. Set up Service Health alerts to be notified when service issues, planned maintenance, or other changes might affect the Azure services and regions you use.

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
3. Create a Service Health alert.

::: form action="OpenBlade[#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts]" submitText="Go to Service Health" :::

::: zone-end

::: zone target="docs"

To set up an Azure Service Health alert, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts).

### Learn more

For more information, see [Azure Service Health](/azure/service-health/).

::: zone-end

## [Azure Advisor](#tab/AzureAdvisor)

Azure Advisor is a free, personalized cloud consultant that helps you follow and implement best practices for Azure deployments. It analyzes your resource configuration and usage telemetry and recommends solutions that can help optimize your environment. The recommendations are divided into the following categories:

- **High availability:** To improve the continuity of your business-critical applications. Recommendations might include adding virtual machines to an availability set or adding geo-redundant endpoints.
- **Security:** To detect threats and vulnerabilities that might lead to security breaches. Recommendations might include applying Azure Disk Encryption or enabling network security groups.
- **Performance:** To improve the speed of your applications. Recommendations might include boosting SQL query performance by creating indexes or reconfiguring your Traffic Manager settings.
- **Cost:** To optimize and reduce your overall Azure spending. Recommendations might include resizing or shutting down underused virtual machines or switching to Azure Reservations to lower total cost of ownership.
- **Operational excellence:** To improve process and workflow efficiency and manageability. Recommendations might include setting up and enforcing Azure Policy rules, repairing invalid log alert rules, and configuring Service Health alerts.

Recommendations in Advisor are based on the resources you deploy and the actions you take in Azure. You can check Advisor regularly for the latest recommendations.

::: zone target="chromeless"

### Action

::: form action="OpenBlade[#blade/Microsoft_Azure_Expert/AdvisorBlade]" submitText="Explore Azure Advisor" :::

::: zone-end

::: zone target="docs"

To explore Azure Advisor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Expert/AdvisorBlade).

### Learn more

To learn more, see [Azure Advisor documentation](/azure/advisor/).

::: zone-end

## [Azure Security Center](#tab/AzureSecurityCenter)

Azure Security Center also plays an important part in your monitoring strategy. It can help you monitor the security of your machines, networks, storage, data services, and applications. Security Center provides advanced threat detection by using machine learning and behavioral analytics to help identify active threats targeting your Azure resources. It also provides threat protection that blocks malware or other unwanted code, and reduces the surface area exposed to brute force and other network attacks.

When Security Center identifies a threat, it triggers a security alert with steps you need to take to respond to an attack. It also provides a report with information about the threat that was detected.

Azure Security Center is offered in two tiers: free and standard. Features like security recommendations are available for free. The Standard tier provides additional protection like advanced threat detection and protection across hybrid cloud workloads.

::: zone target="chromeless"

### Action

**Try Standard tier for free for your first 30 days.**

After you turn on and set up security policies for a subscription's resources, you can view the security state of your resources and any issues in the **Prevention** section. You can also view a list of those issues on the **Recommendations** tile.

::: form action="OpenBlade[#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0]" submitText="Explore Azure Security Center" :::

::: zone-end

::: zone target="docs"

To explore Azure Security Center, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0).

### Learn more

To learn more, see [Azure Security Center documentation](/azure/security-center/).

::: zone-end
