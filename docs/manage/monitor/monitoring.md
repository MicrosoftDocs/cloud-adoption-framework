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
| Cost | Cost monitoring tracks cloud spending and resource usage to identify cost-saving opportunities and prevent budget overruns. It monitors resource usage, identifies underused resources, and optimizes resource configurations to help reduce costs. |

## Shared responsibilities

In an on-premises environment, you're responsible for all aspects of monitoring because you own and manage all computing resources. In the cloud, you share this responsibility with your cloud provider. Depending on the type of deployment model that you choose, the responsibilities for monitoring various layers of the cloud stack might transfer from you to your cloud provider.

In an infrastructure as a service (IaaS) deployment, the cloud provider monitors the underlying cloud platform, such as the physical infrastructure and virtualization layer. And you monitor the operating system, applications, and data that run on the virtual machines that you deploy to the cloud platform. When the deployment model moves up the stack, the cloud provider takes on more responsibility to monitor the environment. This responsibility culminates in a software as a service (SaaS) deployment because you transfer monitoring responsibility to the cloud provider for the entire stack, including the application and data. 

:::image type="content" source="media/monitor/responsibilities.png" alt-text="Diagram that shows shared responsibilities for monitoring in the cloud." lightbox="media/monitor/responsibilities.png" border="false":::

You might use monitoring tools from the cloud provider to monitor your layers of the stack, but you're responsible for configuring these tools and analyzing the data that they collect. You need to grant access to various members of your organization and create dashboards and alerts to help them distinguish critical information. You might also need to integrate these components with other tools and ticketing systems that your organization uses.
 
The cloud provider must perform the same types of service for their layers of the stack that you provide to your internal customers. They must continuously monitor the health and performance of the platform that they contract to you. They provide you with dashboards and alerts to proactively notify you of any service problems. Much like your internal customers, you don't need visibility into the intricacies of how the cloud provider monitors their platform, only that they meet the service-level agreements that you contract with them.

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
| Network administrator | The network administrator manages and maintains the cloud network to help ensure that data flows securely and efficiently between servers, applications, and users. The network administrator handles network configurations, monitors performance, and implements security measures. They require network-centric telemetry, including network traffic analysis, latency measurements, packet loss, and firewall logs. 
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
| [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) | Defender XDR includes Microsoft security solutions that are native to the Azure platform, client and server Microsoft operating systems, and applications including Office 365, Exchange Online, and SharePoint in Microsoft 365. Each security solution uses AI and machine learning to correlate telemetry and determine if investigations are necessary. When they detect unacceptable behavior, they take action to prevent disruption.  | Security | Security engineer |
| [Microsoft Cost Management](/azure/cost-management-billing/costs/overview-cost-management) | Cost Management is a suite of tools that you can use to analyze, monitor, and optimize your Microsoft Cloud costs. Cost Management is available to anyone that has access to a billing account, subscription, resource group, or management group. | Cost | Cloud architect |
| [Azure Service Health](/azure/service-health/overview) | Service Health provides a health status of the services that your Azure resources rely on. It can inform you of any service outages and provide a personalized view of the health of your Azure services and regions.  | Infrastructure | Cloud provider |

## Reference for monitoring Azure services

The following table provides links to the monitoring guidance for nearly every Azure service.

| Azure service | Guidance to monitor the Azure service | Monitor deployments<br>(select services) |
|---------------|---------------------------------------| ------------------- |
| Azure AI Agent service | [Management center overview](/azure/ai-studio/concepts/management-center) | [How to enable tracing in Azure AI Agents](/azure/ai-services/agents/concepts/tracing) |
| Azure AI Foundry | [Management center overview](/azure/ai-studio/concepts/management-center) | [Monitor your Generative AI Applications](/azure/ai-studio/how-to/monitor-applications)<br><br>[Evaluation and monitoring metrics for generative AI](/azure/ai-studio/concepts/evaluation-metrics-built-in)<br><br>[Use Risks & Safety monitoring](/azure/ai-services/openai/how-to/risks-safety-monitor)<br><br>[Monitor prompt flow deployments](/azure/ai-studio/how-to/monitor-quality-safety)<br><br>[Run evaluations online](/azure/ai-studio/how-to/online-evaluation)<br><br>[View evaluation results in Azure AI Foundry portal](/azure/ai-studio/how-to/evaluate-results)<br><br>[Visualize your traces](/azure/ai-studio/how-to/develop/visualize-traces) |
| Azure AI Search | [Monitor Azure AI Search](/azure/search/monitor-azure-cognitive-search) | [Monitor queries](/azure/search/search-monitor-queries)<br><br>[Analyze performance in Azure AI Search](/azure/search/search-performance-analysis)<br><br>[Collect telemetry data for search traffic analytics](/azure/search/search-traffic-analytics)<br><br>[Visualize Azure AI Search Logs and Metrics with Power BI](/azure/search/search-monitor-logs-powerbi)   |
| Azure AI services | [Enable diagnostic logging Azure AI services](/azure/ai-services/diagnostic-logging) | |
| Azure AI Video Indexer | [Monitor Azure AI Video Indexer](/azure/azure-video-indexer/monitor-video-indexer)<br><br>[Monitoring Azure AI Video Indexer data reference](/azure/azure-video-indexer/monitor-video-indexer-data-reference) | |
| Azure Analysis Services | [Monitor Azure Analysis Services](/azure/analysis-services/monitor-analysis-services)<br><br>[Monitoring data reference for Azure Analysis Services](/azure/analysis-services/monitor-analysis-services-reference) | |
| Azure API for FHIR | [Enable diagnostic logging in Azure API for FHIR](/azure/healthcare-apis/azure-api-for-fhir/enable-diagnostic-logging) | |
| Azure API Management | [Monitor Azure API Management](/azure/api-management/monitor-api-management)<br><br>[Monitoring data reference for Azure API Management](/azure/api-management/monitor-api-management-reference) | [Observability in Azure API Management](/azure/api-management/observability)<br><br>[Monitor published APIs in Azure API Management](/azure/api-management/api-management-howto-use-azure-monitor)<br><br>[Integrate Azure API Management with Application Insights](/azure/api-management/api-management-howto-app-insights)<br><br>[Monitor your APIs](/azure/api-management/api-management-log-to-eventhub-sample) |
| Azure App Configuration | [Monitor Azure App Configuration](/azure/azure-app-configuration/monitor-app-configuration)<br><br>[Monitoring Azure App Configuration data reference](/azure/azure-app-configuration/monitor-app-configuration-reference) | |
| Azure App Service | [Monitor Azure App Service](/azure/app-service/monitor-app-service)<br><br>[Azure App Service monitoring data reference](/azure/app-service/monitor-app-service-reference) | [Enable application monitoring](/azure/azure-monitor/app/codeless-app-service)<br><br>[Monitor App Service instances by using Health Check](/azure/app-service/monitor-instances-health-check)<br><br>[Azure App Service diagnostics overview](/azure/app-service/overview-diagnostics)|
| Azure Application Gateway | [Monitor Azure Application Gateway](/azure/application-gateway/monitor-application-gateway)<br><br>[Monitoring data reference for Azure Application Gateway](/azure/application-gateway/monitor-application-gateway-reference) | [Application Gateway health probes overview](/azure/application-gateway/application-gateway-probe-overview)<br><br>[Application Gateway health probes overview](/azure/application-gateway/application-gateway-probe-overview)<br><br>[Backend health](/azure/application-gateway/application-gateway-backend-health)<br><br>[Azure Monitor metrics for Application Gateway](/azure/application-gateway/application-gateway-metrics) |
| Azure Arc resource bridge | [Azure Arc resource bridge maintenance operations](/azure/azure-arc/resource-bridge/maintenance) | |
| Azure Arc site manager | [How to configure Azure Monitor alerts for a site](/azure/azure-arc/site-manager/how-to-configure-monitor-site) | |
| Azure Arc-enabled data services | [Azure Data Studio dashboards for Azure Arc](/azure/azure-arc/data/azure-data-studio-dashboards) | |
| Azure Arc-enabled Kubernetes | [Enable monitoring for Azure Kubernetes Service (AKS) cluster](/azure/azure-monitor/containers/kubernetes-monitoring-enable) | |
| Azure Arc-enabled servers | [Monitor a hybrid machine with Azure Monitor VM insights](/azure/azure-arc/servers/learn/tutorial-enable-vm-insights) | |
| Azure Archive Storage | [Monitor Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)<br><br>[Monitoring data reference for Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage-reference) | |
| Azure Automation | [Forward Azure Automation job data to Azure Monitor logs](/azure/automation/automation-manage-send-joblogs-log-analytics) | |
| Azure Backup | [Monitoring and reporting solutions for Azure Backup](/azure/backup/monitoring-and-alerts-overview) | |
| Azure Batch | [Monitor Azure Batch](/azure/batch/monitor-batch)<br><br>[Monitoring data reference for Azure Batch](/azure/batch/monitor-batch-reference) | |
| Azure Blob Storage | [Monitor Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)<br><br>[Monitoring data reference for Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage-reference) | [Best practices for monitoring Azure Blob Storage](/azure/storage/blobs/blob-storage-monitoring-scenarios)<br><br>[Monitoring your storage service with Azure Monitor Storage insights](/azure/storage/common/storage-insights-overview) |
| Azure Cache for Redis | [Monitor Azure Cache for Redis](/azure/azure-cache-for-redis/monitor-cache)<br><br>[Monitoring data reference for Azure Cache for Redis](/azure/azure-cache-for-redis/monitor-cache-reference) | [Azure Monitor insights for Azure Cache for Redis](/azure/azure-cache-for-redis/cache-insights-overview) |
| Azure Chaos Studio | [Set up Azure monitor for a Chaos Studio experiment](/azure/chaos-studio/chaos-studio-set-up-azure-monitor) | |
| Azure Communication Services | [Monitor SMS](/azure/communication-services/concepts/analytics/enable-logging)<br> [Monitor Voice and video](/azure/communication-services/concepts/analytics/enable-logging)<br> [Monitor Chat](/azure/communication-services/concepts/analytics/enable-logging)<br>[Monitor Phone calling](/azure/communication-services/concepts/analytics/enable-logging)<br> [Monitor Email](/azure/communication-services/concepts/analytics/enable-logging) | |
| Azure confidential ledger | [Verify Azure Confidential Ledger write transaction receipts](/azure/confidential-ledger/verify-write-transaction-receipts) | |
| Azure Container Apps | [Monitor Azure Container Apps](/azure/container-apps/observability)<br><br>[Monitor Azure Container Apps metrics](/azure/container-apps/metrics) | [Application logging in Azure Container Apps](/azure/container-apps/logging)<br><br>[Health probes in Azure Container Apps](/azure/container-apps/health-probes)|
| Azure Container Instances | [Monitor Azure Container Instances](/azure/container-instances/monitor-azure-container-instances)<br><br>[Monitoring data reference for Container Instances](/azure/container-instances/monitor-azure-container-instances-reference) | [Configure liveness probes](/azure/container-instances/container-instances-liveness-probe)|
| Azure Container Registry | [Monitor Azure Container Registry](/azure/container-registry/monitor-container-registry)<br><br>[Monitoring Data Reference for Azure Container Registry](/azure/container-registry/monitor-container-registry-reference) | |
| Azure Container Storage | [Enable monitoring for Azure Container Storage](/azure/storage/container-storage/enable-monitoring) | |
| Azure Cosmos DB | [Monitor Azure Cosmos DB](/azure/cosmos-db/monitor)<br><br>[Monitoring data reference for Azure Cosmos DB](/azure/cosmos-db/monitor-reference) | [Azure Cosmos DB insights](/azure/cosmos-db/insights-overview)<br><br>[Monitor and debug with insights in Azure Cosmos DB](/azure/cosmos-db/use-metrics)<br><br>[Monitor throughput or request unit usage of an operation in Azure Cosmos DB](/azure/cosmos-db/monitor-request-unit-usage)<br><br>[Query execution metrics](/azure/cosmos-db/nosql/query-metrics-performance)<br><br>[Index metrics](/azure/cosmos-db/nosql/index-metrics)<br><br>[Explore Azure Monitor in vCore-based Azure Cosmos DB for MongoDB (vCore)](/azure/cosmos-db/mongodb/vcore/monitor-metrics) |
| Azure CycleCloud | [Monitor Azure CycleCloud](/azure/cyclecloud/concepts/monitoring) | |
| Azure Data Box | [Track and log Azure Data Box, Azure Data Box Heavy events for import order](/azure/databox/data-box-logs) | |
| Azure Data Explorer | [Monitor Azure Data Explorer](/azure/data-explorer/monitor-data-explorer)<br><br>[Monitoring data reference for Azure Data Explorer](/azure/data-explorer/monitor-data-explorer-reference) | |
| Azure Data Lake Storage | [Monitor Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage)<br><br>[Monitoring data reference for Azure Blob Storage](/azure/storage/blobs/monitor-blob-storage-reference) | |
| Azure Database for MySQL | [Monitoring - Azure Database for MySQL](/azure/mysql/flexible-server/concepts-monitoring) | [Best practices for monitoring](/azure/mysql/flexible-server/concept-monitoring-best-practices) |
| Azure Database for PostgreSQL | [Monitoring and metrics - Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-monitoring) | [Intelligent tuning](/azure/postgresql/flexible-server/concepts-intelligent-tuning) [Monitor performance with query store](/azure/postgresql/flexible-server/concepts-query-store)|
| Azure Databricks | [Configure diagnostic log delivery for Azure Databricks](/azure/databricks/admin/account-settings/audit-log-delivery) | |
| Azure DDoS Protection | [Monitor Azure DDoS Protection](/azure/ddos-protection/monitor-ddos-protection)<br><br>[Monitor Azure DDoS Protection monitoring data reference](/azure/ddos-protection/monitor-ddos-protection-reference) | |
| Azure Dedicated Host | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | |
| Azure Dedicated HSM | [Monitoring options - Azure Dedicated HSM](/azure/dedicated-hsm/monitoring) | |
| Azure DevTest Labs | [Activity logs - Azure DevTest Labs](/azure/devtest-labs/activity-logs) | |
| Azure Digital Twins | [Monitor your instance  in Azure Digital Twins](/azure/digital-twins/how-to-monitor) | |
| Azure Disk Storage | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | |
| Azure DNS | [Metrics and alerts](/azure/dns/dns-alerts-metrics) | |
| Azure Elastic SAN | [Metrics for Azure Elastic SAN](/azure/storage/elastic-san/elastic-san-metrics) | |
| Azure Event Grid | [Enable diagnostic logs for Event Grid resources](/azure/event-grid/enable-diagnostic-logs-topic)<br><br>[Monitor data reference (push delivery)](/azure/event-grid/monitor-push-reference) | |
| Azure Event Hubs | [Monitor Azure Event Hubs](/azure/event-hubs/monitor-event-hubs)<br><br>[Monitoring data reference for Azure Event Hubs](/azure/event-hubs/monitor-event-hubs-reference) | |
| Azure ExpressRoute | [Monitor Azure ExpressRoute](/azure/expressroute/monitor-expressroute)<br><br>[Monitoring data reference for Azure ExpressRoute](/azure/expressroute/monitor-expressroute-reference) | |
| Azure Files | [Monitor Azure Files using Azure Monitor](/azure/storage/files/storage-files-monitoring)<br><br>[Monitoring data reference for Azure Files](/azure/storage/files/storage-files-monitoring-reference) | |
| Azure Firewall | [Monitor Azure Firewall](/azure/firewall/monitor-firewall)<br><br>[Monitoring data reference for Azure Firewall](/azure/firewall/monitor-firewall-reference) | |
| Azure Front Door | [Monitor Azure Front Door](/azure/frontdoor/monitor-front-door)<br><br>[Monitoring data reference for Azure Front Door](/azure/frontdoor/monitor-front-door-reference) | [Azure Front Door reports](/azure/frontdoor/standard-premium/how-to-reports)<br><br>[Health probes](/azure/frontdoor/health-probes) |
| Azure Functions | [Monitor Azure Functions](/azure/azure-functions/monitor-functions)<br><br>[Monitoring data reference for Azure Functions](/azure/azure-functions/monitor-functions-reference) | [Monitor Azure Functions with Azure Monitor Application Insights](/azure/azure-monitor/app/monitor-functions)<br><br>[Monitor executions in Azure Functions](/azure/azure-functions/functions-monitoring) |
| Azure FXT Edge Filer | [Monitor the Azure FXT Edge Filer](/azure/fxt-edge-filer/monitor) | |
| Azure HDInsight | [Monitor Azure HDInsight](/azure/hdinsight/monitor-hdinsight)<br><br>[Monitoring data reference for Azure HDInsight](/azure/hdinsight/monitor-hdinsight-reference) | |
| Azure Health Data Services | [Logging for Azure Health Data Services](/azure/healthcare-apis/logging) | |
| Azure HPC Cache | [Azure HPC Cache metrics and monitoring](/azure/hpc-cache/metrics) | |
| Azure IoT | [Manage your IoT solution](/azure/iot/iot-overview-solution-management) | |
| Azure IoT Central | [Manage and monitor IoT Central](/azure/iot-central/core/howto-manage-and-monitor-iot-central) | |
| Azure IoT Edge | [Tutorial - Azure Monitor workbooks for IoT Edge](/azure/iot-edge/tutorial-monitor-with-workbooks) | |
| Azure IoT Hub | [Monitor Azure IoT Hub](/azure/iot-hub/monitor-iot-hub)<br><br>[Monitoring data reference for Azure IoT Hub](/azure/iot-hub/monitor-iot-hub-reference) | |
| Azure IoT Operations | [Deploy observability resources](/azure/iot-operations/configure-observability-monitoring/howto-configure-observability) | |
| Azure Key Vault | [Monitor Azure Key Vault](/azure/key-vault/general/monitor-key-vault)<br><br>[Monitoring data reference for Azure Key Vault](/azure/key-vault/general/monitor-key-vault-reference) | [Monitoring your key vault service with Key Vault insights](/azure/key-vault/key-vault-insights-overview)<br><br>[Configure Azure Key Vault alerts](/azure/key-vault/general/alert)<br><br>[Azure Key Vault monitoring data reference](/azure/key-vault/general/monitor-key-vault-reference)<br><br>[Azure Key Vault logging](/azure/key-vault/general/logging)<br><br>[Enable Key Vault logging](/azure/key-vault/general/howto-logging)<br><br>[Monitoring Key Vault with Azure Event Grid](/azure/key-vault/general/event-grid-overview) |
| Azure Kubernetes Service (AKS) | [Monitor Azure Kubernetes Service (AKS)](/azure/aks/monitor-aks)<br><br>[Monitoring data reference for Azure Kubernetes Service](/azure/aks/monitor-aks-reference) | [Zero instrumentation application monitoring for Kubernetes](/azure/azure-monitor/app/kubernetes-codeless)<br><br>[Full stack monitoring](/azure/azure-monitor/containers/monitor-kubernetes)<br><br>[Best practices for monitoring Kubernetes with Azure Monitor](/azure/azure-monitor/best-practices-containers)|
| Azure Lab Services | [Track usage of a lab in Azure Lab Services](/azure/lab-services/tutorial-track-usage) | |
| Azure Lighthouse | [Monitor delegated resources at scale](/azure/lighthouse/how-to/monitor-at-scale) | |
| Azure Load Balancer | [Monitor Azure Load Balancer](/azure/load-balancer/monitor-load-balancer)<br><br>[Monitoring data reference for Azure Load Balancer](/azure/load-balancer/monitor-load-balancer-reference) | |
| Azure Load Testing | [Monitoring Azure Load Testing](/azure/load-testing/monitor-load-testing)<br><br>[Monitor Azure Load Testing data reference](/azure/load-testing/monitor-load-testing-reference) | |
| Azure Local | [Overview of Azure Local monitoring](/azure/azure-local/concepts/monitoring-overview) | |
| Azure Logic Apps | [Monitor Azure Logic Apps](/azure/logic-apps/monitor-logic-apps-overview)<br><br>[Monitoring data reference for Azure Logic Apps](/azure/logic-apps/monitor-logic-apps-reference) | |
| Azure Machine Learning | [Monitor Azure Machine Learning](/azure/machine-learning/monitor-azure-machine-learning)<br><br>[Azure Machine Learning monitoring data reference](/azure/machine-learning/monitor-azure-machine-learning-reference) | [Azure Machine Learning model monitoring](/azure/machine-learning/concept-model-monitoring)<br><br>[Monitor performance of models deployed to production](/azure/machine-learning/how-to-monitor-model-performance)<br><br>[Monitor online endpoints](/azure/machine-learning/how-to-monitor-online-endpoints) |
| Azure Managed Grafana | [Monitor an Azure Managed Grafana instance with logs](/azure/managed-grafana/how-to-monitor-managed-grafana-workspace) | |
| Azure Managed Instance for Apache Cassandra | [Monitor Azure Managed Instance for Apache Cassandra](/azure/managed-instance-apache-cassandra/monitor-clusters) | |
| Azure Managed Lustre | [Monitor Azure Managed Lustre](/azure/azure-managed-lustre/monitor-file-system)<br><br>[Monitoring data reference for Azure Managed Lustre](/azure/azure-managed-lustre/monitor-file-system-reference) | |
| Azure NAT Gateway | [Monitor Azure NAT Gateway](/azure/nat-gateway/monitor-nat-gateway)<br><br>[Monitoring data reference for Azure NAT Gateway](/azure/nat-gateway/monitor-nat-gateway-reference) | |
| Azure NetApp Files | [Ways to monitor Azure NetApp Files](/azure/azure-netapp-files/monitor-azure-netapp-files)<br><br>[Metrics for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-metrics) | |
| Azure Notification Hubs | [Monitor Azure Notification Hubs](/azure/notification-hubs/monitor-notification-hubs)<br><br>[Monitoring data reference for Azure Notification Hubs](/azure/notification-hubs/monitor-notification-hubs-reference) | |
| Azure OpenAI Service | [Monitor Azure OpenAI Service](/azure/ai-services/openai/how-to/monitor-openai) | [Use Risks & Safety monitoring](/azure/ai-services/openai/how-to/risks-safety-monitor) |
| Azure Operator Nexus | [Azure Operator Nexus: observability using Azure Monitor](/azure/operator-nexus/concepts-observability) | |
| Azure Private 5G Core | [Monitor Azure Private 5G Core with Azure Monitor platform metrics](/azure/private-5g-core/monitor-private-5g-core-with-platform-metrics)<br><br>[Monitor with correlated metrics in Azure portal](/azure/private-5g-core/ran-insights-monitor-with-correlated-metrics-concepts) | |
| Azure Private Link | [Monitor Azure Private Link](/azure/private-link/monitor-private-link)<br><br>[Monitoring data reference for Azure Private Link](/azure/private-link/monitor-private-link-reference) | |
| Azure Power BI Embedded | [Monitor Power BI Embedded](/power-bi/developer/embedded/monitor-power-bi-embedded)<br><br>[Monitoring data reference for Power BI Embedded](/power-bi/developer/embedded/monitor-power-bi-embedded-reference) | |
| Azure Queue Storage | [Monitor Azure Queue Storage](/azure/storage/queues/monitor-queue-storage)<br><br>[Monitoring data reference for Azure Queue Storage](/azure/storage/queues/monitor-queue-storage-reference) | |
| Azure Red Hat OpenShift | [Monitor Azure Red Hat OpenShift](/azure/azure-monitor/containers/kubernetes-monitoring-enable) | |
| Azure Service Bus | [Monitor Azure Service Bus](/azure/service-bus-messaging/monitor-service-bus)<br><br>[Monitoring data reference for Azure Service Bus](/azure/service-bus-messaging/monitor-service-bus-reference) | [Azure Monitor - Service Bus insights](/azure/service-bus-messaging/service-bus-insights) |
| Azure Service Fabric | [Monitor Azure Service Fabric](/azure/service-fabric/monitor-service-fabric)<br><br>[Monitoring data reference for Azure Service Fabric](/azure/service-fabric/monitor-service-fabric-reference) | |
| Azure SignalR Service | [Monitor Azure SignalR Service](/azure/azure-signalr/monitor-signalr)<br><br>[Monitoring data reference for Azure SignalR Service](/azure/azure-signalr/monitor-signalr-reference) | |
| Azure Site Recovery | [Monitor Azure Site Recovery](/azure/site-recovery/monitor-site-recovery)<br><br>[Monitoring data reference for Azure Site Recovery](/azure/site-recovery/monitor-site-recovery-reference) | |
| Azure Sphere | [Overview Monitor Azure Sphere resources](/azure-sphere/deployment/az-monitor-overview)<br><br>[Monitor Azure Sphere data reference](/azure-sphere/deployment/az-monitor-data) | |
| Azure Spot Virtual Machines | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | |
| Azure SQL Database | [Monitor Azure SQL Database](/azure/azure-sql/database/monitoring-sql-database-azure-monitor)<br><br>[Monitoring data reference for Azure SQL Database](/azure/azure-sql/database/monitoring-sql-database-azure-monitor-reference) | [Monitor Azure SQL workloads with database watcher](/azure/azure-sql/database-watcher-overview)<br><br>[Tune applications and databases for performance in Azure SQL Database](/azure/azure-sql/database/performance-guidance) |
| Azure SQL Edge | [Troubleshoot Azure SQL Edge deployments](/azure/azure-sql-edge/troubleshoot) | |
| Azure SQL Managed Instance | [Monitor Azure SQL Managed Instance](/azure/azure-sql/managed-instance/monitoring-sql-managed-instance-azure-monitor) | [Tune applications and databases for performance in Azure SQL Managed Instance](/azure/azure-sql/managed-instance/performance-guidance) |
| Azure Stack Edge | [Enable Azure Monitor on Azure Stack Edge Pro GPU device](/azure/databox-online/azure-stack-edge-gpu-enable-azure-monitor) | |
| Azure Stack Hub | [Monitor health and alerts in Azure Stack Hub](/azure-stack/operator/azure-stack-monitor-health) | |
| Azure Static Web Apps | [Monitor Azure Static Web Apps](/azure/static-web-apps/monitor)<br><br>[Supported metrics for managed Functions in Azure Static Web Apps](/azure/static-web-apps/metrics) | |
| Azure Synapse Analytics | [Monitor Azure Synapse Analytics](/azure/synapse-analytics/monitor-synapse-analytics)<br><br>[Monitoring data reference for Azure Synapse Analytics](/azure/synapse-analytics/monitor-synapse-analytics-reference) | |
| Azure Table Storage | [Monitor Azure Table Storage](/azure/storage/tables/monitor-table-storage)<br><br>[Monitoring data reference for Azure Table Storage](/azure/storage/tables/monitor-table-storage-reference) | |
| Azure Update Manager | [Create alerts in Azure Update Manager](/azure/update-manager/manage-alerts) | |
| Azure Virtual Machine Scale Sets | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm) | [Application Insights for Azure VMs and virtual machine scale sets](/azure/azure-monitor/app/azure-vm-vmss-apps) |
| Azure Virtual Network | [Monitor Azure Virtual Network](/azure/virtual-network/monitor-virtual-network)<br><br>[Monitoring data reference for Azure Virtual Network](/azure/virtual-network/monitor-virtual-network-reference) | |
| Azure Virtual WAN | [Monitor Azure Virtual WAN](/azure/virtual-wan/monitor-virtual-wan)<br><br>[Monitoring data reference for Azure Virtual WAN](/azure/virtual-wan/monitor-virtual-wan-reference) | |
| Azure VMware Solution | [Monitor and protect VMs with Azure native services](/azure/azure-vmware/integrate-azure-native-services) | |
| Azure Virtual Desktop | [Monitor Azure Virtual Desktop](/azure/virtual-desktop/insights) | |
| Azure Virtual Machines | [Monitor Azure Virtual Machines](/azure/virtual-machines/monitor-vm)<br><br>[Monitoring data reference for Azure Virtual Machines](/azure/virtual-machines/monitor-vm-reference) | [Application Insights for Azure VMs and virtual machine scale sets](/azure/azure-monitor/app/azure-vm-vmss-apps)<br><br>[VM Watch](/azure/virtual-machines/azure-vm-watch)<br><br>[Availability monitoring](/azure/virtual-machines/flash-overview) |
| Azure VPN Gateway | [Monitor Azure VPN Gateway](/azure/vpn-gateway/monitor-vpn-gateway)<br><br>[Monitoring data reference for Azure VPN Gateway](/azure/vpn-gateway/monitor-vpn-gateway-reference) | |
| Azure Web Application Firewall | [Web Application Firewall + Azure Front Door](/azure/web-application-firewall/afds/waf-front-door-monitor)<br><br>[Web Application Firewall + Application Gateway](/azure/web-application-firewall/ag/application-gateway-waf-metrics)<br><br>[Resource logs for Azure Web Application Firewall](/azure/web-application-firewall/ag/web-application-firewall-logs) | |
| Azure Web PubSub | [Monitor Azure Web PubSub](/azure/azure-web-pubsub/howto-azure-monitor)<br><br>[Monitoring Azure Web PubSub data reference](/azure/azure-web-pubsub/howto-monitor-data-reference) | |
| Data Factory in Microsoft Fabric | [Monitor Data Factory](/fabric/data-factory/monitor-data-factory) | |
| Microsoft Dev Box | [Monitoring Microsoft Dev Box data reference](/azure/dev-box/monitor-dev-box-reference) | |
| Microsoft Entra Domain Services | [Check the health of Microsoft Entra Domain Services](/entra/identity/domain-services/check-health) | |
| Microsoft Entra External ID | [Azure Monitor in external tenants](/entra/external-id/customers/how-to-azure-monitor) | |
| Microsoft Entra ID | [What is Microsoft Entra monitoring and health?](/entra/identity/monitoring-health/overview-monitoring-health) | |
| Microsoft Sentinel | [Auditing and health monitoring in Microsoft Sentinel](/azure/sentinel/health-audit) | |
| Microsoft Dev Box | [Monitoring Microsoft Dev Box data reference](/azure/dev-box/monitor-dev-box-reference) | |
| Microsoft Entra Domain Services | [Check the health of Microsoft Entra Domain Services](/entra/identity/domain-services/check-health) | |
| Microsoft Entra External ID | [Azure Monitor in external tenants](/entra/external-id/customers/how-to-azure-monitor) | |
| Microsoft Entra ID | [What is Microsoft Entra monitoring and health?](/entra/identity/monitoring-health/overview-monitoring-health) | |
| Microsoft Dev Box | [Monitoring Microsoft Dev Box data reference](/azure/dev-box/monitor-dev-box-reference) | |
| Multicloud connector enabled by Azure Arc | [View multicloud inventory with the multicloud connector enabled by Azure Arc](/azure/azure-arc/multicloud-connector/view-multicloud-inventory) | |
