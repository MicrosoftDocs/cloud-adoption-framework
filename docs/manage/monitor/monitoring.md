---
title: Observability in cloud monitoring
description: Gain an understanding of how observability helps drive maturity in monitoring and help you understand the behavior of your services running in the cloud.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/20/2023
ms.topic: conceptual
products: azure-monitor
ms.custom: UpdateFrequency2
---

# Observability in cloud monitoring

Observability is a property of a system that's a measure of how well the internal states of a system can be inferred from its system external outputs, along with controllability, another property of a system. In addition, a dynamical system also that over time, a state observer measures or estimates the health state of the system. 























This article is part of a series in [the cloud monitoring guide](./index.md).

The sections below aim to drive operational maturity by being observant and constantly iterating to improve how you monitor your services. Learn how organizations implement a consistent monitoring strategy quicker by establishing *observability* for each monitoring solution.

## Defining observability

While observability and monitoring complement each other, there's a notable distinction:

- **Monitoring**: Collects information and informs you that it detected an issue based on you configuring it to monitor for those conditions. You're monitoring for known or predictable failures.
- **Observability**: The ability to understand what's happening inside a system by looking at the output data. An *observability solution* helps you analyze this data to assess the system's health and find ways to fix problems in your IT infrastructure.



Here are a few examples of tools that enable your platform observability:

|Log source|Description|
|---|---|
|[Service health](/azure/service-health/service-health-portal-update)|Service incidents and planned maintenance reported by Microsoft.|
|[Azure Resource Health](/azure/service-health/resource-health-overview)|Reports on your resources' current and past health.|
|[Azure Monitor activity log](/azure/azure-monitor/essentials/activity-log)|Reports subscription-level events across all the resources deployed in the subscription.|
|[Azure Monitor Change Analysis](/azure/azure-monitor/change/change-analysis)|Reports on changes to your Azure applications and reduces mean time to repair (MTTR).|
|[Azure resource logs](/azure/azure-monitor/essentials/resource-logs)|Previously known as *diagnostic logs*, resource logs reports on operations performed within an Azure resource, on the data plane.|
|[Microsoft Entra reports (AzureAD) logs](/azure/azure-monitor/essentials/platform-logs-overview)|Reports on the history of sign-in activity and the audit trail of changes in Microsoft Entra ID for a given tenant.|
|[Azure Advisor](/azure/advisor/advisor-overview)|Use Azure Advisor to receive recommended solutions based on best practices to optimize your Azure deployments.|
| [Microsoft Cloud for Sovereignty transparency logs](/industry/sovereignty/transparency-logs) | Reports about when resources are accessed and which Microsoft engineer accesses the resource. Transparency logs provide details of access to customer resources. The logs also notify you when there has been no access, which is common. |

Observability evolves gradually, starting with a minimally viable monitoring plan, and the effort to integrate tools and processes is underway. As you get comfortable with the data (metrics, logs, and transactions), you can understand the behavior and signs of symptoms or issues from those resources or applications. By getting familiar with the data, you build trust in working with Azure Monitor and the data.



## Infrastructure

### Operations Manager

Operations Manager requires significant infrastructure and maintenance to support a management group, a basic unit of functionality. At a minimum, a management group consists of one or more management servers, a SQL Server instance, hosting the operational and reporting data warehouse database, and agents. The complexity of a management group design depends on multiple factors, such as the scope of workloads to monitor and the number of devices or computers supporting the workloads. If you require high availability and site resiliency, as is commonly the case with enterprise monitoring platforms, the infrastructure requirements and associated maintenance can increase dramatically.

### Azure Monitor SCOM Managed Instance

[Azure Monitor SCOM Managed Instance](/system-center/scom/operations-manager-managed-instance-overview) is a PaaS offering of System Center Operations Manager hosted in Azure. SCOM Managed Instance requires minimal infrastructure and maintenance as many of the infrastructure components such as the management servers and databases are hosted in Azure and managed by Microsoft; You no longer have to be responsible for patching your management server and databases with the latest upgrades and features. Also, scaling a management server can be done at the click of a button.

### Azure Monitor

Azure Monitor is a software as a service (SaaS) offering, so its supporting infrastructure runs in Azure and is managed by Microsoft. It performs monitoring, analytics, and diagnostics at scale. It's available in all national/regional clouds. Core parts of the infrastructure (collectors, metrics and logs store, and analytics) that support Azure Monitor are maintained by Microsoft.


[Azure Monitor](/azure/azure-monitor/overview) is a comprehensive solution for collecting, analyzing, and acting on signals from your Azure and on-premises environments. Azure Monitor contains many features, including, but not limited to, network monitoring, SCOM Managed Instance, VM Insights, and Application Insights.

Our recommended approach to monitoring each layer of the stack is summarized in the following table:

| Layer | Resource | Scope | Method |
|---|---|---|---|
| Application monitoring | A web-based application that runs on .NET, .NET Core, Java, JavaScript, or Node.js on Azure VM, Azure App Service, Azure Service Fabric, Azure Functions, or Azure Cloud Services. | Monitor a live web application to automatically detect performance anomalies, identify code exceptions and issues and collect user behavior analytics. | Application Insights, a feature of Azure Monitor. |
| Azure resources | For example, Azure website, Azure key vault or Network Security Groups. Also, Azure database services such as SQL or MySQL. | Availability, performance, and operation monitoring. | <li>Enable diagnostics logging to stream data to Azure Monitor Logs.<li>Enable Azure Monitor Insights to use curated monitoring views for specific Azure resources. |
| In-guest Operating Systems components|For example, Windows servers, containers, or Linux servers|Capacity, availability, performance, logs, events and services|<li>Enable diagnostics logging to stream data to Azure Monitor Logs.<li>Enable Azure Monitor Insights to use curated monitoring views for specific Azure resources.|
| Network | Communication between your virtual machine and one or more endpoints. | Monitor reachability, latency, and network topology changes between the VM and the endpoint. | [Azure Monitor Network Insights](/azure/network-watcher/network-insights-overview) and [Azure network monitoring solutions](/azure/networking/network-monitoring-overview).|
| Azure subscription | [Azure Service Health](/azure/service-health/overview) and basic resource health from the perspective of the Azure service. | <li> Administrative actions performed on a service or resource. <li> Service health of an Azure service is in a degraded or unavailable state. <li> Health issues detected with an Azure resource from the Azure service perspective. <li> Operations performed with Azure autoscale indicating a failure or exception. <li> Operations performed with Azure Policy indicating that an allowed or denied action occurred. <li> Record of alerts generated by Microsoft Defender for Cloud. | Delivered in the activity log for monitoring and alerting by using Azure Monitor. |
| Azure tenant | Microsoft Entra ID | Microsoft Entra audit and sign-in logs. | Enable [diagnostics logging](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics), and configure streaming to Azure Monitor Logs. |
| Security |All types of resources|Security Audit|<li>[Onboard Microsoft Sentinel](/azure/sentinel/quickstart-onboard)<li>[Microsoft Defender for Cloud](/azure/defender-for-cloud/).|


## Next steps

> [!div class="nextstepaction"]
> [Service Level Objectives](./service-level-objectives.md)
