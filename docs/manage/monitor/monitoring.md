---
title: Monitoring in the cloud
description: Gain an understanding of how observability helps drive maturity in monitoring and help you understand the behavior of your services running in the cloud.
author: bwren
ms.author: bwren
ms.date: 09/19/2024
ms.topic: conceptual
products: azure-monitor
ms.custom: UpdateFrequency2
---

# Monitoring in a cloud environment

Whether you're a business owner, platform owner, or application owner, you need observability of your cloud environment to ensure that your workloads are running smoothly. You need to answer basic questions such as whether your applications are available and performing to your customers' expectations, if you have any security threats that require investigation, and if your consumption costs are within expected range.

*Observability is* a property of a system that's a measure of how well its internal states can be inferred from its external outputs. In addition to deploying service and processes in place to monitor your cloud environment, you need to have the ability to observe and understand the behavior of your services running in the cloud. 

*Monitoring* is the process of collecting, analyzing, and acting on telemetry indicating the health of your platform, resources, and applications. An effective monitoring environment includes your entire cloud estate which may include resources across multiple clouds and on-premises. 

## Value of monitoring
Investment in your monitoring environment provides a positive return across multiple aspects of your cloud including the following:

**Availability and performance:** Monitoring helps ensure that your cloud services and applications are available and performing as expected. By tracking key metrics and configuring alert rules, you can identify and respond to issues before they impact users.

**Cost Optimization:** By tracking resource utilization through monitoring, you can optimize costs by scaling resources according to demand, which helps to avoid over-provisioning and under-utilization. Monitoring can also identify and alert you to any cost overruns or unexpected spikes in usage.

**Compliance:** Monitoring ensures that cloud services comply with policies and regulations by maintaining logs and records of activities. Reports using this data can assist with regular audits and compliance checks.

**Security:** Continuous monitoring can detect security threats and vulnerabilities allowing for immediate action to protect data and resources. Collected data can also be analyzed for threat detection and response.

## Monitoring platforms
An effective monitoring strategy includes all platforms in your computing environment. In addition to Azure, you may have on-premises, multicloud, and edge resources, and each requires the same levels of monitoring. Following the guidance of the [Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/overview), you should include monitoring in your [unified operations strategy](/azure/cloud-adoption-framework/scenarios/hybrid/unified-operations). Using this strategy, your monitoring tools are hosted by the primary cloud platform along with other management tools, and are used to monitor all resources across all platforms.


## Types of monitoring
Monitoring is a multifaceted discipline that requires a combination of tools, processes, and practices. It can be broken down into the types described in the following table. Different services and features may provide different combinations of these types of monitoring, but a comprehensive monitoring environment will include all of them across each of the platforms in your computing environment.

| Type | Description |
|:---|:---|
| Infrastructure | Infrastructure monitoring includes the performance and availability of cloud resources such as virtual machines, storage, and networks. This type of monitoring ensures that the underlying infrastructure is functioning optimally, which is critical for maintaining availability and performance of the applications that rely on them. |
| Application Performance (APM) | APM focuses on monitoring the performance and availability of applications running in the cloud. It tracks metrics such as response times, error rates, and transaction volumes. APM identifies performance bottlenecks and ensures that applications meet user expectations. |
| Database | Database monitoring involves tracking the performance, availability, and resource consumption of cloud databases. Key metrics include query performance, index usage, and lock statuses. |
| Network | Network monitoring tracks the performance and availability of network components in the cloud environment. This includes monitoring bandwidth usage, latency, and packet loss. |
| Security | Security monitoring involves tracking and analyzing security events and vulnerabilities within the cloud environment. This includes monitoring for unauthorized access, malware, and compliance violations. Effective security monitoring helps protect sensitive data, ensures compliance with regulatory requirements, and can prevent costly security breaches. |
| Compliance | Compliance monitoring ensures that the cloud environment adheres to regulatory and industry standards. It involves tracking configurations, access controls, and data handling practices to ensure compliance with relevant regulations. |
| Cost | Cost monitoring involves tracking cloud spending and resource utilization to identify cost-saving opportunities and prevent budget overruns. This includes monitoring resource usage, identifying underutilized resources, and optimizing resource configurations to reduce costs. |

## Shared responsibilities

:::image type="content" source="media/monitor/responsibilities.png" alt-text="Diagram showing shared responsibilities for monitoring in the cloud." lightbox="media/monitor/responsibilities.png":::


## Roles and responsibilities
There are multiple roles in an organization that maintain the monitoring environment and require access to monitoring data to perform their job functions. Each role has different requirements for monitoring data based on their particular responsibilities. Depending on the size of your organization, you may have 

The following table describes the roles and their monitoring requirements.

- **Cloud Architect**: Designs and oversees the cloud infrastructure, ensuring it meets the organization’s business goals. The cloud architect focuses on reliability, security, and scalability of the cloud architecture and requires high-level telemetry to get a holistic view of the digital estate. This includes resource utilization metrics, application performance monitoring (APM), cost and billing insights, and compliance reports.

- **Platform Engineer**: Builds and manages the platform that developers use to deploy their applications. This includes creating CI/CD pipelines, managing cloud infrastructure as code, and ensuring the scalability and reliability of the platform. The platform engineer requires telemetry related to the platform's operational status. This includes container performance metrics, orchestration logs, infrastructure-as-code (IaC) validation, and service availability.

- **System Administrator:** Manages and maintains servers, operating systems, and other infrastructure components in the cloud. They ensure systems are up-to-date, perform backups, and troubleshoot issues. The system administrator requires server and OS-level telemetry including CPU, memory, disk usage, network performance, and system logs. 

- **Security Engineer:** Implements and manages security measures to protect data and applications from threats. The security engineer handles everything from identity management to threat detection and response. They need telemetry focused on security events including access logs, threat detection alerts, vulnerability assessments, and compliance metrics.

- **Network Administrator:** Responsible for managing and maintaining the cloud network, ensuring that data flows securely and efficiently between servers, applications, and end-users. The network administrator handles network configurations, monitors performance, and implements security measures. They require network-centric telemetry including network traffic analysis, latency measurements, packet loss, and firewall logs. 

- **Database Administrator (DBA):** Manages and maintains databases, ensuring data integrity, performance, and availability. The DBA handles database backups, recovery, and optimize queries for efficiency. They need telemetry related to database performance and integrity including query performance metrics, database response times, transaction logs, and backup/recovery status.

- **Developer:** Design, write, test, and maintain the software that runs on cloud platforms. The developer creates features, fixing bugs, and ensuring the application performs well and is secure. They require application-specific telemetry including error rates, latency, response times, user behavior analytics, and feature usage metrics. 

## Aspects of monitoring
While you may use multiple services with different sets of features to provide the a complete monitoring environment, the core aspects of monitoring can be broken down in the following aspects:

- **Data collection.** Monitoring begins by collecting telemetry data from your different cloud and on-premises resources. Telemetry can be broken down into logs, metrics, and traces, which are often referred to as the three pillars of observability. You must configure your environment to collect only the data that is relevant to your monitoring goals to avoid unnecessary data collection and storage costs. You must also store collected data in a manner and location that allows for effective analysis and alerting.

- **Data analysis.** Collected data needs to be analyzed to identify trends, patterns, and anomalies. In addition to manual analysis, you should be able to leverage automated tools that use machine learning and artificial intelligence to identify issues and provide insights into your data. Data analysis can help you identify performance bottlenecks, security threats, and compliance violations.

- **Alerting:** Alerts automatically notify you of issues that require attention. Effective alerting helps you respond to issues quickly and proactively, reducing the impact on your users and business. Monitoring tools may provide predefined alert rules based on best practices and will allow you to define custom alert rules based on your specific requirements. You also need to configure notifications to ensure that alerts are delivered to the right people at the right time.

- **Visualization:** Dashboards and reports allow you to visualize monitoring data insights into the health and performance of your cloud environment. They typically provide a graphical representation of key metrics and trends, making it easier to identify issues and communicate insights to stakeholders.

## Who needs monitoring data?
Most enterprise organizations will have a centralized operations team that's responsible for monitoring the overall health and performance of the cloud environment. This team will typically set the strategies for the overall company, perform centralized configuration of the monitoring environment, and delegate permissions to different teams and individuals as required by their particular role.

Different stakeholders in your organization require access to the monitoring data related to their applications and services. Depending on their specific needs, they may also require the following:

- Access to features of the monitoring tools required to analyze the telemetry related to their applications and services.
- Custom dashboards and reports that provide insights into their applications without requiring detailed knowledge of the underlying data.
- Authority to configure alerts and notifications for their applications.


## Azure facilitation
Azure includes multiple services that provide the different types of monitoring required for your cloud environment. These services together provide the features required for a comprehensive monitoring environment. 

| Service | Description | 
|:---|:---|
| [Azure Monitor](/azure/azure-monitor) | Azure Monitor is at the center of the Azure monitoring ecosystem providing a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. In addition to providing complete monitoring of your infrastructure, network, and applications, Azure Monitor provides a data platform and core features such as data analysis, visualization, and alerting used by other services. |
| [Application insights](/azure/azure-monitor/app/app-insights-overview) | Application Insights is a feature of Azure Monitor that provides Application Performance Management (APM) service for your cloud applications. |
| [Network Watcher](/azure/network-watcher/network-watcher-overview) | Network Watcher is a feature of Azure Monitor that provides monitoring and visualization capabilities for network resources in Azure. It helps you monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network. |
| [Azure Service Health](/azure/service-health/overview) | Azure Service Health provides a health status of the services that your Azure resources rely on. This includes informing you of any service outages and a personalized view of the health of the Azure services and regions you're using.  |
| [Microsoft Sentinel](/azure/sentinel/) | Microsoft Sentinel is a cloud native Security Information Event Management (SIEM) and Security Orchestration Automated Response (SOAR) solution. It ingests security telemetry from your Azure resources and other components to provide cyberthreat detection, investigation, response, and proactive hunting. |
| [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) | Microsoft Defender XDR includes multiple Microsoft security solutions native to the Azure platform, Microsoft operating systems (both client and server), and applications including Office 365, Exchange Online, and SharePoint Online. Each of the Defenders use AI and ML to correlate telemetry and determine if investigations are necessary and will attack disruption by taking action when known bad behaviors are taking place.  |
| [Change Analysis](/azure/azure-monitor/change/change-analysis) | Change Analysis detects various types of changes, from the infrastructure layer through application deployment.  |
| [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Microsoft Cost Management is a suite of tools that help organizations analyze, monitor, and optimize your Microsoft Cloud costs. Cost Management is automatically available to anyone with access to a billing account, subscription, resource group, or management group. |
