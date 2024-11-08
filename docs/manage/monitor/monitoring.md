---
title: Monitor a Cloud Environment
description: Learn how observability helps drive maturity in monitoring, and use monitoring to understand the behavior of your services that run in the cloud.
author: bwren
ms.author: bwren
ms.date: 11/9/2024
ms.topic: conceptual
products: azure-monitor
ms.custom: UpdateFrequency2
---

# Monitor a cloud environment

You need observability of your cloud environment to help ensure that your workloads run smoothly, whether you're a business owner, platform owner, or application owner. You need to know if:

- Your applications are available and if they perform to your customers' expectations.
- You have any security threats that require investigation.
- Your consumption costs are within the expected range.

*Monitoring* is the process of collecting, analyzing, and acting on telemetry that indicates the health of your platform, resources, and applications. An effective monitoring environment includes your entire cloud estate, which might include resources across multiple clouds and on-premises environments.

*Observability* is a property of a system that measures how well its internal states can be inferred from its external outputs. You need to deploy services and processes to monitor your cloud environment. And you need to have the ability to observe and understand the behavior of your services that run in the cloud.

## Benefits of monitoring

Invest in your monitoring environment to get the following benefits across multiple aspects of your cloud:

- **Availability and performance:** Monitor resources to help ensure that your cloud services and applications are available and perform as expected. To identify and respond to problems before they affect users, track key metrics and configure alert rules.

- **Cost Optimization:** Use monitoring to track resource usage and scale resources according to demand. This approach helps prevent overprovisioned and underused resources, which optimizes cost. Monitoring can also identify and alert you to any cost overruns or unexpected spikes in usage.

- **Compliance:** Use monitoring to maintain logs and records of activities, which help ensure that cloud services comply with policies and regulations. Reports that use this data can assist with regular audits and compliance checks.

- **Security:** Implement continuous monitoring to help detect security threats and vulnerabilities so that you can immediately act to protect data and resources. You can also analyze collected data for threat detection and response.

## Monitoring platforms

An effective monitoring strategy includes all platforms in your computing environment. In addition to Azure, you might have on-premises, multicloud, and edge resources. Each resource requires the same levels of monitoring. Follow the [Cloud Adoption Framework for Azure guidance](/azure/cloud-adoption-framework/overview), and include monitoring in your [unified operations strategy](/azure/cloud-adoption-framework/scenarios/hybrid/unified-operations). In this strategy, the primary cloud hosts your monitoring tools and other management tools. The monitoring tools monitor all resources across all platforms.

:::image type="content" source="media/monitor/primary-cloud-provider-extended.png" alt-text="Conceptual diagram that shows the unified operations strategy." lightbox="media/monitor/primary-cloud-provider-extended.png" border="false":::

## Types of monitoring

Monitoring is a multifaceted discipline that requires a combination of tools, processes, and practices. The following table breaks down various types of monitoring. Different services and features might provide different combinations of these monitoring types. But a comprehensive monitoring environment includes all of these monitoring types across each of the platforms in your computing environment.

| Type | Description |
|:---|:---|
| Infrastructure | Infrastructure monitoring includes the performance and availability of cloud resources, such as virtual machines, storage resources, and networks. This type of monitoring helps ensure that the underlying infrastructure functions optimally, which helps maintain the availability and performance of the applications that rely on it. |
| Application performance monitoring (APM) | APM monitors the performance and availability of applications that run in the cloud. It tracks metrics such as response times, error rates, and transaction volumes. APM identifies performance bottlenecks and helps ensure that applications meet user expectations. |
| Database | Database monitoring tracks the performance, availability, and resource consumption of cloud databases. Key metrics include query performance, index usage, and lock status. |
| Network | Network monitoring tracks the performance and availability of network components in the cloud environment. Metrics include bandwidth usage, latency, and packet loss. |
| Security | Security monitoring tracks and analyzes security events and vulnerabilities within the cloud environment, including unauthorized access, malware, and compliance violations. Effective security monitoring helps protect sensitive data, ensure compliance with regulatory requirements, and prevent costly security breaches. |
| Compliance | Compliance monitoring helps ensure that the cloud environment adheres to regulatory and industry standards. It tracks configurations, access controls, and data-handling practices to help ensure compliance with relevant regulations. |
| Cost | Cost monitoring tracks cloud spending and resource usage to identify cost-saving opportunities and prevent budget overruns. It monitors resource usage, identifies underused resources, and optimizes resource configurations to reduce costs. |

## Shared responsibilities

In an on-premises environment, you're responsible for all aspects of monitoring because you own and manage all computing resources. In the cloud, you share this responsibility with your cloud provider. Depending on the type of deployment model that you choose, the responsibilities for monitoring various layers of the cloud stack might transfer from you to your cloud provider.

In an infrastructure as a service (IaaS) deployment, the cloud provider monitors the underlying cloud platform, such as the physical infrastructure and virtualization layer. And you monitor the operating system, applications, and data that run on the virtual machines that you deploy to the cloud platform. When the deployment model moves up the stack, the cloud provider takes on more responsibility to monitor the environment. This responsibility culminates in a software as a service (SaaS) deployment because you transfer monitoring responsibility to the cloud provider for the entire stack, including the application and data. 

:::image type="content" source="media/monitor/responsibilities.png" alt-text="Diagram that shows shared responsibilities for monitoring in the cloud." lightbox="media/monitor/responsibilities.png" border="false":::

You might use monitoring tools from the cloud provider to monitor your layers of the stack, but you're responsible for configuring these tools and analyzing the data that they collect. You need to grant access to various members of your organization and create dashboards and alerts to help them distinguish critical information. You might also need to integrate these components with other tools and ticketing systems that your organization uses.
 
The cloud provider must perform the same types of service for their layers of the stack that you provide to your internal customers. They must continuously monitor the health and performance of the platform that they contract to you. They provide you with dashboards and alerts to proactively notify you of any service problems. Much like your internal customers, you don't need visibility into the intricacies of how the cloud provider monitors their platform, only that they meet the service-level agreements (SLAs) that you contract with them.

## Roles and responsibilities

Most enterprise organizations have a centralized operations team that monitors the overall health and performance of the cloud environment. 

This team typically:
- Sets the strategies for the overall company.
- Performs centralized configuration of the monitoring environment.
- Delegates permissions to stakeholders in your organization that require access to the monitoring data that's related to their applications and services.

Organizations have multiple roles that maintain the monitoring environment and that require access to monitoring data to perform their job functions. Each role has different requirements to monitor data based on their particular responsibilities. Depending on the size of your organization, you might have multiple individuals that fill each role, or you might have one individual that fills multiple roles. 

Individual organizations might distribute responsibilities differently. The following table shows an example of the roles and responsibilities for a typical organization.

| Role | Description |
|:---|:---|
| Cloud architect | The cloud architect designs and oversees the cloud infrastructure to help ensure that it meets the organization's business goals. The cloud architect focuses on reliability, security, and scalability of the cloud architecture. They require high-level telemetry to get a holistic view of the digital estate. This telemetry includes resource usage metrics, APM metrics, cost and billing insights, and compliance reports.
| Platform engineer | The platform engineer builds and manages the platform that developers use to deploy their applications. The platform engineer might create continuous integration and continuous delivery (CI/CD) pipelines, manage cloud infrastructure as code (IaC), and ensure the scalability and reliability of the platform. The platform engineer requires telemetry about the platform's operational status. This telemetry includes container performance metrics, orchestration logs, IaC validation, and service availability.
| System administrator | The system administrator manages and maintains servers, operating systems, and other infrastructure components in the cloud. They perform backups, troubleshoot problems, and ensure that systems are up to date. The system administrator requires server and OS-level telemetry, including CPU, memory, and disk usage, network performance, and system logs. 
| Security engineer | The security engineer implements and manages security measures to help protect data and applications from threats. The security engineer handles everything from identity management to threat detection and response. They use telemetry about security events, including access logs, threat-detection alerts, vulnerability assessments, and compliance metrics.
| Network administrator | The network administrator manages and maintains the cloud network to ensure that data flows securely and efficiently between servers, applications, and users. The network administrator handles network configurations, monitors performance, and implements security measures. They require network-centric telemetry, including network traffic analysis, latency measurements, packet loss, and firewall logs. 
| Database administrator (DBA) | The DBA manages and maintains databases to help ensure data integrity, performance, and availability. The DBA handles database backups and recovery and optimizes queries for efficiency. They use telemetry about database performance and integrity, including query performance metrics, database response times, transaction logs, and backup or recovery status.
| Developer | The developer designs, writes, tests, and maintains the software that runs on cloud platforms. The developer creates features and fixes bugs to help ensure that the application remains secure and performs well. They require application-specific telemetry, including error rates, latency, response times, user behavior analytics, and feature usage metrics. 

## Azure facilitation

Azure has many services that support the different [types of monitoring](#types-of-monitoring) that you need in your cloud environment. Each service targets one or more [roles](#roles-and-responsibilities). Combine services to provide the features that you need for a comprehensive monitoring environment. 

| Service | Description | Type | Roles
|:---|:---|:---|:---|
| [Azure Monitor](/azure/azure-monitor) | Azure Monitor is at the center of the Azure monitoring ecosystem. It's a comprehensive monitoring solution that you can use to collect, analyze, and respond to monitoring data from your cloud and on-premises environments. Azure Monitor provides complete monitoring of your infrastructure, network, and applications. It also provides a data platform and core features, such as data analysis, visualization, and alerting for other services. | Infrastructure,<br>database,<br>compliance | Cloud architect,<br>platform engineer,<br>system administrator,<br>DBA |
| [Application Insights](/azure/azure-monitor/app/app-insights-overview) | Application Insights is a feature of Azure Monitor that provides APM monitoring for your cloud applications. | APM | Developer |
| [Azure Network Watcher](/azure/network-watcher/network-watcher-overview) | Network Watcher provides monitoring and visualization capabilities for network resources in Azure. Use this service to monitor, diagnose, and view metrics. You can also enable or disable logs for resources in an Azure virtual network. | Network | Network administrator |
| [Microsoft Sentinel](/azure/sentinel/) | Microsoft Sentinel is a cloud-native security information event management (SIEM) and security orchestration automated response (SOAR) solution. It ingests security telemetry from your Azure resources and other components to provide cyber-threat detection, investigation, response, and proactive hunting. | Security | Security engineer |
| [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) | Defender XDR includes multiple Microsoft security solutions that are native to the Azure platform, client and server Microsoft operating systems, and applications including Office 365, Exchange Online, and SharePoint in Microsoft 365. Each security solution uses AI and machine learning to correlate telemetry and determine if investigations are necessary. When they detect unacceptable behavior, they take action to prevent disruption.  | Security | Security engineer |
| [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Cost Management is a suite of tools that you can use to analyze, monitor, and optimize your Microsoft Cloud costs. Cost Management is available to anyone that has access to a billing account, subscription, resource group, or management group. | Cost | Cloud architect |
| [Azure Service Health](/azure/service-health/overview) | Service Health provides a health status of the services that your Azure resources rely on. It can inform you of any service outages and provide a personalized view of the health of your Azure services and regions.  | Infrastructure | Cloud provider |
