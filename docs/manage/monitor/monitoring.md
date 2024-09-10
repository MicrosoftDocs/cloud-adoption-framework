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

# Monitoring in the cloud

Whether you're a business owner, platform owner, or application owner, you need visibility of your cloud environment to ensure that your workloads are running smoothly. You need to answer basic questions such as whether your applications are available and performing to your customers' expectations, if you have any security threats that require investigation, and if your consumption costs are within expected range.

Monitoring is the process of collecting, analyzing, and acting on metrics, logs, and transactions indicating the health of your platform, resources, and applications. An effective monitoring environment includes your entire cloud estate which may include resources across multiple clouds and on-premises.

> [!NOTE]
> Observability is a property of a system that's a measure of how well its internal states can be inferred from its external outputs. In addition to deploying service and processes in place to monitor your cloud environment, you need to have the ability to observe and understand the behavior of your services running in the cloud. 

## WAF and monitoring

The Microsoft Azure Well-Architected Framework (WAF) is a set of guiding tenets that can be used to improve the quality of cloud workloads. The WAF is based on five pillars: cost optimization, operational excellence, performance efficiency, reliability, and security. Each of these pillars fits into a type of monitoring that should be included in your monitoring strategy.



## Value of monitoring

Investment in your monitoring environment provides a positive return across multiple aspects of your cloud. 

**Availability and performance:** Monitoring helps ensure that your cloud services applications are available and performing as expected. By tracking key metrics and setting up alerts, you can identify and respond to issues before they impact users.

**Cost Optimization:** By tracking resource utilization through monitoring, you can optimize costs by scaling resources according to demand, which helps to avoid over-provisioning and under-utilization. Monitoring can also identify and alert you to any cost overruns or unexpected spikes in usage.

**Compliance:** Monitoring ensures that cloud services comply with policies and regulations by providing logs and records of activities. Reports using this data can assist with regular audits and compliance checks.

**Security:** Continuous monitoring can detect security threats and vulnerabilities, allowing for immediate action to protect data and resources. Collected data can also be analyzed for threat detection and response.

**Troubleshooting:** Detailed monitoring allows for in-depth analysis of issues, facilitating faster troubleshooting and identification of root cause.

## Types of monitoring
There are multiple types of monitoring that are required to maintain the health of your cloud environment and its applications. Because of the diversity of these requirements, you will typically require multiple products and services to implement a comprehensive monitoring environment.


| Type | Description |
|:---|:---|
| Infrastructure Monitoring | Infrastructure monitoring includes the performance and availability of cloud resources such as virtual machines, storage, and networks. This type of monitoring ensures that the underlying infrastructure is functioning optimally, which is critical for maintaining availability and performance of the applications that rely on them. In a cloud environment, infrastructure monitoring involves  |
| Application Performance Monitoring (APM) | APM focuses on monitoring the performance and availability of applications running in the cloud. It tracks metrics such as response times, error rates, and transaction volumes. APM identifies performance bottlenecks and ensures that applications meet user expectations. |
| Database Monitoring | Database monitoring involves tracking the performance, availability, and resource consumption of cloud databases. Key metrics include query performance, index usage, and lock statuses. |
| Network Monitoring | Network monitoring tracks the performance and availability of network components in the cloud environment. This includes monitoring bandwidth usage, latency, and packet loss. |
| Security Monitoring | Security monitoring involves tracking and analyzing security events and vulnerabilities within the cloud environment. This includes monitoring for unauthorized access, malware, and compliance violations. Effective security monitoring helps protect sensitive data, ensures compliance with regulatory requirements, and can prevent costly security breaches. |
| Compliance Monitoring | Compliance monitoring ensures that the cloud environment adheres to regulatory and industry standards. It involves tracking configurations, access controls, and data handling practices to ensure compliance with relevant regulations. |
| Cost monitoring | Cost monitoring involves tracking cloud spending and resource utilization to identify cost-saving opportunities and prevent budget overruns. This includes monitoring resource usage, identifying underutilized resources, and optimizing resource configurations to reduce costs. |


## Azure facilitation
Azure includes multiple services that provide the different types of monitoring required for your cloud environment. Azure Monitor is the center of the Azure monitoring ecosystem, providing a data platform for collecting and analyzing logs, metrics, and traces in addition to analysis and alerting services. Other features and services in Azure Monitor leverage the Azure Monitor data platform to provide additional monitoring capabilities.

| Service | Description | 
|:---|:---|
| [Azure Monitor](/azure/azure-monitor) | Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. It provides health and performance monitoring of your IaaS services and an extensive set of features for identifying and alerting on issues. Azure Monitor also serves as a platform for features and services that provide other types of monitoring in the Azure cloud. |
| [Application insights](/azure/azure-monitor/app/app-insights-overview) | Application Insights is a feature of Azure Monitor that provides Application Performance Management (APM) service for your cloud applications. |
| [Network Watcher](/azure/network-watcher/network-watcher-overview) | Network Watcher is a network performance and diagnostic service that provides monitoring and visualization capabilities for network resources in Azure. It helps you monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network. |
| [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) | Microsoft Defender XDR includes multiple Microsoft security solutions native to the Azure platform, Microsoft operating systems (both client and server), and applications including Office 365, Exchange Online, and SharePoint Online. Each of the Defenders use AI and ML to correlate telemetry and determine if investigations are necessary and will attack disruption by taking action when known bad behaviors are taking place.  |
| [Microsoft Sentinel](/azure/sentinel/) | Sentinel is a cloud native Security Information Event Management (SIEM) and Security Orchestration Automated Response (SOAR) solution. It ingests security telemetry from your Azure services and other network  |
| [Change Analysis](/azure/azure-monitor/change/change-analysis) | Change Analysis detects various types of changes, from the infrastructure layer through application deployment.  |


## Observability data




## XDR
[Extended detection and response (XDR)](https://www.microsoft.com/security/business/security-101/what-is-xdr), adds AI and automation to a unified security incident platform. Unlike targeted systems like [endpoint detection and response (EDR)](https://www.microsoft.com/security/business/security-101/what-is-edr-endpoint-detection-response), XDR platforms provide expanded coverage to protect against more sophisticated types of cyberattacks. They integrate detection, investigation, and response capabilities across a wider range of domains, including an organization’s endpoints, hybrid identities, cloud applications and workloads, email, and data stores. They also drive efficiency across security operations (SecOps) with advanced cyberattack chain visibility, AI-powered automation and analytics, and broad threat intelligence.

[Microsoft Defender XDR](https://learn.microsoft.com/defender-xdr/microsoft-365-defender)





|Log source|Description|
|---|---|
|[Service health](/azure/service-health/service-health-portal-update)|Service incidents and planned maintenance reported by Microsoft.|
|[Azure Resource Health](/azure/service-health/resource-health-overview)|Reports on your resources' current and past health.|
|[Azure Monitor activity log](/azure/azure-monitor/essentials/activity-log)|Reports subscription-level events across all the resources deployed in the subscription.|
|[Azure Monitor Change Analysis](/azure/azure-monitor/change/change-analysis)|Reports on changes to your Azure applications and reduces mean time to repair (MTTR).|

|[Azure Advisor](/azure/advisor/advisor-overview)|Use Azure Advisor to receive recommended solutions based on best practices to optimize your Azure deployments.|
| [Microsoft Cloud for Sovereignty transparency logs](/industry/sovereignty/transparency-logs) | Reports about when resources are accessed and which Microsoft engineer accesses the resource. Transparency logs provide details of access to customer resources. The logs also notify you when there has been no access, which is common. |

Observability evolves gradually, starting with a minimally viable monitoring plan, and the effort to integrate tools and processes is underway. As you get comfortable with the data (metrics, logs, and transactions), you can understand the behavior and signs of symptoms or issues from those resources or applications. By getting familiar with the data, you build trust in working with Azure Monitor and the data.




















## Infrastructure


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
