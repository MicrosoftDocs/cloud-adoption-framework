---
title: Monitoring and reporting in Azure
description: Learn how to use the Cloud Adoption Framework to set up monitoring, reporting, and alerts in Azure.
author: timleyden
ms.author: martinek
ms.date: 08/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, fasttrack-edit, AQC, setup
---

# Monitoring and reporting in Azure

Azure offers many services that together provide a comprehensive solution for collecting, analyzing, and acting on telemetry from your applications and from the Azure resources that support them. These services can also monitor critical on-premises resources to provide a hybrid monitoring environment.

## [Azure Monitor](#tab/AzureMonitor)

Azure Monitor provides a single unified hub for all monitoring and diagnostics data in Azure. You can use it to get visibility across your resources. With Azure Monitor, you can find and fix problems, optimize performance, and understand customer behavior.

- **Monitor and visualize metrics.** Metrics are numerical values available from Azure resources that help you understand the health of your systems. You can customize charts for your dashboards, and use workbooks for reporting.

- **Query and analyze logs.** Log Analytics provides a central repository to aggregate data from activity and diagnostic logs in Azure. From there, you can run queries to help troubleshoot issues or to visualize data. You can also collect logs from other monitoring and management solutions for your cloud or on-premises resources. 

- **Set up alerts and actions.** Alerts proactively notify you of critical conditions, so you can take corrective actions based on triggers from metrics, logs, or service health issues. You can set up different notifications and actions, and send data to your IT service management tools.

::: zone target="docs"

Start monitoring your:

- [Applications](/azure/azure-monitor/app/app-insights-overview)
- [Containers](/azure/azure-monitor/containers/container-insights-overview)
- [Virtual machines](/azure/azure-monitor/vm/vminsights-overview)
- [Networks](/azure/networking/network-monitoring-overview)

To monitor other resources, find more solutions in the Azure Marketplace.

To explore Azure Monitor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/overview).

### Learn more

To learn more, see [Azure Monitor documentation](/azure/azure-monitor/).

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->


::: zone-end

## [Azure Service Health](#tab/AzureServiceHealth)

Azure Service Health provides a personalized view of the health of your Azure services and regions. Information about active issues is posted to Azure Service Health to help you understand the impact to your resources. Regular updates keep you informed as issues are resolved.

Set up Service Health alerts to notify you when service issues, planned maintenance, or other changes might affect the Azure services and regions you use. You can also view planned maintenance events that could affect the availability of your resources.

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


::: zone-end

::: zone target="docs"

To set up an Azure Service Health alert, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/healthalerts).

### Learn more

For more information, see [Azure Service Health documentation](/azure/service-health/).

::: zone-end

## [Azure Advisor](#tab/AzureAdvisor)

Azure Advisor is a free, personalized cloud consultant that helps you follow and implement best practices for Azure deployments. Advisor analyzes your resource configuration and usage telemetry, and then recommends solutions that can help optimize your environment. The recommendations are divided into the following categories:

- **Reliability:** To improve the continuity of your business-critical applications. Recommendations might include adding virtual machines to an availability set or adding geo-redundant endpoints.
- **Security:** To detect threats and vulnerabilities that might lead to security breaches. Recommendations might include applying Azure Disk Encryption or enabling network security groups.
- **Performance:** To improve the speed of your applications. Recommendations might include boosting SQL query performance by creating indexes or reconfiguring your Traffic Manager settings.
- **Cost:** To optimize and reduce your overall Azure spending. Recommendations might include resizing or shutting down underused virtual machines or switching to Azure Reservations to lower total cost of ownership.
- **Operational excellence:** To improve process and workflow efficiency and manageability. Recommendations might include setting up and enforcing Azure Policy rules, repairing invalid log alert rules, and configuring Service Health alerts.

Recommendations in Advisor are based on the resources you deploy and the actions you take in Azure. You can check Advisor regularly for the latest recommendations.

::: zone target="chromeless"


::: zone-end

::: zone target="docs"

To explore Azure Advisor, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Expert/AdvisorBlade).

### Learn more

To learn more, see [Azure Advisor documentation](/azure/advisor/).

::: zone-end

## [Microsoft Defender for Cloud](#tab/AzureSecurityCenter)

Microsoft Defender for Cloud also plays an important part in your monitoring strategy. Defender for Cloud can help you monitor the security of your machines, networks, storage, data services, and applications. It provides advanced threat detection by using machine learning and behavioral analytics to help identify active threats that target your Azure resources. Defender for Cloud also provides threat protection that blocks malware or other unwanted code, and reduces the surface area exposed to brute force and other network attacks.

When Defender for Cloud identifies a threat, it triggers a security alert with steps you need to take to respond to an attack. It also provides a report with information about the threat that was detected.

Defender for Cloud is offered in two tiers: free and standard. Features like security recommendations are available for free. The standard tier provides more protection like advanced threat detection and protection across hybrid cloud workloads.

::: zone target="chromeless"

### Action

**Try Standard tier for free for your first 30 days.**

After you turn on and set up security policies for a subscription's resources, you can view the security state of your resources and any issues in the **Prevention** section. You can also view a list of those issues on the **Recommendations** tile.


::: zone-end

::: zone target="docs"

To explore Microsoft Defender for Cloud, go to the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_Security/SecurityMenuBlade/SecurityMenuBlade/0).

### Learn more

To learn more, see [Microsoft Defender for Cloud documentation](/azure/security-center/).

::: zone-end
