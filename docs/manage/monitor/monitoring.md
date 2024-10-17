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

*Monitoring* is the process of collecting, analyzing, and acting on telemetry indicating the health of your platform, resources, and applications. An effective monitoring environment includes your entire cloud estate which may include resources across multiple clouds and on-premises. *Observability* is a property of a system that's a measure of how well its internal states can be inferred from its external outputs. In addition to deploying service and processes in place to monitor your cloud environment, you need to have the ability to observe and understand the behavior of your services running in the cloud. 

## Value of monitoring
Investment in your monitoring environment provides a positive return across multiple aspects of your cloud including the following:

- **Availability and performance:** Monitoring helps ensure that your cloud services and applications are available and performing as expected. By tracking key metrics and configuring alert rules, you can identify and respond to issues before they impact users.

- **Cost Optimization:** By tracking resource utilization through monitoring, you can optimize costs by scaling resources according to demand, which helps to avoid over-provisioning and under-utilization. Monitoring can also identify and alert you to any cost overruns or unexpected spikes in usage.

- **Compliance:** Monitoring ensures that cloud services comply with policies and regulations by maintaining logs and records of activities. Reports using this data can assist with regular audits and compliance checks.

- **Security:** Continuous monitoring can detect security threats and vulnerabilities allowing for immediate action to protect data and resources. Collected data can also be analyzed for threat detection and response.

## Monitoring platforms
An effective monitoring strategy includes all platforms in your computing environment. In addition to Azure, you may have on-premises, multicloud, and edge resources, and each requires the same levels of monitoring. Following the guidance of the [Microsoft Cloud Adoption Framework for Azure](/azure/cloud-adoption-framework/overview), you should include monitoring in your [unified operations strategy](/azure/cloud-adoption-framework/scenarios/hybrid/unified-operations). Using this strategy, your monitoring tools are hosted by the primary cloud platform along with other management tools, and are used to monitor all resources across all platforms.

:::image type="content" source="media/monitor/primary-cloud-provider-extended.png" alt-text="Conceptual diagram showing the unified operations strategy." lightbox="media/monitor/primary-cloud-provider-extended.png" border="false":::


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
In an on-premises environment, the customer is responsible for all aspects of monitoring since you own and manage all computing resources. In the cloud, this becomes a shared responsibility between the customer and the cloud provider. Depending on the type of deployment model you choose, the responsibilities for monitoring different layers of the cloud stack will move from customer to cloud provider.

In an IaaS deployment, the cloud provider is responsible for monitoring the underlying cloud platform such as the physical infrastructure and virtualization layer while the customer monitors the operating system, applications, and data running on the virtual machines deployed to the cloud platform. As the deployment model moves up the stack, the cloud provider takes on more responsibility for monitoring the environment. This culminates in a SaaS deployment where the customer abdicates monitoring responsibility to the cloud provider for the entire stack including the application and data. 

:::image type="content" source="media/monitor/responsibilities.png" alt-text="Diagram showing shared responsibilities for monitoring in the cloud." lightbox="media/monitor/responsibilities.png" border="false":::

 While you may use monitoring tools from the cloud provider to monitor your layers of the stack, you're responsible for configuring these tools and analyzing the data they collect. You need to grant access to different members of your organization and create dashboards and alerting to help them distinguish critical information. You may also need to integrate these with other tools and ticketing systems used by your organization.
 
 The cloud provider is obligated to perform the same types of service for their layers of the stack that you provide to your internal customers. They must continuously monitor the health and performance of the platform they've contracted to you, providing you with dashboards and alerting to proactively notify you of any services issues. Much like your internal customers, you don't need visibility into the intricacies of how they monitor their platform, only that they meet the SLAs you've contracted with them.

## Roles and responsibilities
Most enterprise organizations will have a centralized operations team that's responsible for monitoring the overall health and performance of the cloud environment. This team will typically set the strategies for the overall company, perform centralized configuration of the monitoring environment, and delegate permissions to different stakeholders in your organization that require access to the monitoring data related to their applications and services. 

There are multiple roles in an organization that maintain the monitoring environment and require access to monitoring data to perform their job functions. Each role has different requirements for monitoring data based on their particular responsibilities. Depending on the size of your organization, you may have multiple individuals filling each role or may have one individual that fills multiple roles. 

While individual organizations may distribute responsibilities differently, the following table shows the roles and responsibilities for a typical organization.

| Role | Description |
|:---|:---|
| Cloud Architect | Designs and oversees the cloud infrastructure, ensuring it meets the organization’s business goals. The cloud architect focuses on reliability, security, and scalability of the cloud architecture and requires high-level telemetry to get a holistic view of the digital estate. This includes resource utilization metrics, application performance monitoring (APM), cost and billing insights, and compliance reports.
| Platform Engineer | Builds and manages the platform that developers use to deploy their applications. This includes creating CI/CD pipelines, managing cloud infrastructure as code, and ensuring the scalability and reliability of the platform. The platform engineer requires telemetry related to the platform's operational status. This includes container performance metrics, orchestration logs, infrastructure-as-code (IaC) validation, and service availability.
| System Administrator | Manages and maintains servers, operating systems, and other infrastructure components in the cloud. They ensure systems are up-to-date, perform backups, and troubleshoot issues. The system administrator requires server and OS-level telemetry including CPU, memory, disk usage, network performance, and system logs. 
| Security Engineer | Implements and manages security measures to protect data and applications from threats. The security engineer handles everything from identity management to threat detection and response. They need telemetry focused on security events including access logs, threat detection alerts, vulnerability assessments, and compliance metrics.
| Network Administrator | Responsible for managing and maintaining the cloud network, ensuring that data flows securely and efficiently between servers, applications, and end-users. The network administrator handles network configurations, monitors performance, and implements security measures. They require network-centric telemetry including network traffic analysis, latency measurements, packet loss, and firewall logs. 
| Database Administrator (DBA) | Manages and maintains databases, ensuring data integrity, performance, and availability. The DBA handles database backups, recovery, and optimize queries for efficiency. They need telemetry related to database performance and integrity including query performance metrics, database response times, transaction logs, and backup/recovery status.
| Developer | Design, write, test, and maintain the software that runs on cloud platforms. The developer creates features, fixing bugs, and ensuring the application performs well and is secure. They require application-specific telemetry including error rates, latency, response times, user behavior analytics, and feature usage metrics. 


## Azure facilitation
Azure includes multiple services that supporting the different [types of monitoring](#types-of-monitoring) required for your cloud environment. Each is targeted to one or more of the [roles](#roles-and-responsibilities) and together provide the features required for a comprehensive monitoring environment. 

| Service | Description | Type | Roles
|:---|:---|:---|:---|
| [Azure Monitor](/azure/azure-monitor) | Azure Monitor is at the center of the Azure monitoring ecosystem providing a comprehensive monitoring solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. In addition to providing complete monitoring of your infrastructure, network, and applications, Azure Monitor provides a data platform and core features such as data analysis, visualization, and alerting used by other services. | Infrastructure<br>Database<br>Compliance | Cloud architect<br>Platform engineer<br>System administrator<br>DBA |
| [Application insights](/azure/azure-monitor/app/app-insights-overview) | Application Insights is a feature of Azure Monitor that provides Application Performance Management (APM) service for your cloud applications. | Application Performance | Developer |
| [Network Watcher](/azure/network-watcher/network-watcher-overview) | Network Watcher is a feature of Azure Monitor that provides monitoring and visualization capabilities for network resources in Azure. It helps you monitor, diagnose, view metrics, and enable or disable logs for resources in an Azure virtual network. | Network | Network Administrator |
| [Microsoft Sentinel](/azure/sentinel/) | Microsoft Sentinel is a cloud native Security Information Event Management (SIEM) and Security Orchestration Automated Response (SOAR) solution. It ingests security telemetry from your Azure resources and other components to provide cyberthreat detection, investigation, response, and proactive hunting. | Security | Security Engineer |
| [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) | Microsoft Defender XDR includes multiple Microsoft security solutions native to the Azure platform, Microsoft operating systems (both client and server), and applications including Office 365, Exchange Online, and SharePoint Online. Each of the Defenders use AI and ML to correlate telemetry and determine if investigations are necessary and will attack disruption by taking action when known bad behaviors are taking place.  | Security | Security Engineer |
| [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Microsoft Cost Management is a suite of tools that help organizations analyze, monitor, and optimize your Microsoft Cloud costs. Cost Management is automatically available to anyone with access to a billing account, subscription, resource group, or management group. | Cost | Cloud architect |
| [Azure Service Health](/azure/service-health/overview) | Azure Service Health provides a health status of the services that your Azure resources rely on. This includes informing you of any service outages and a personalized view of the health of the Azure services and regions you're using.  | Infrastructure | Cloud provider |
