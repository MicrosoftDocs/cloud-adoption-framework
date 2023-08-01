---
title: Monitoring strategy for cloud deployment models
description: Learn how to adopt our recommended monitoring strategy for each of the cloud deployment models in Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/20/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23, UpdateFrequency2
products: azure-monitor
---

# Monitoring strategy for cloud deployment models

This article is part of a series in [the cloud monitoring guide](./index.md).

When you've determined your [cloud monitoring strategy](/azure/cloud-adoption-framework/strategy/monitoring-strategy#high-level-modeling), including the cloud deployment models you'll operate, you need to accommodate for monitor strategies.

The typical cloud deployment models to monitor are **public cloud** for when deploying to the global Azure cloud, **hybrid** for when you have both on-premises and public cloud resources, and **private cloud** for when you operate a private cloud, for example Azure Stack.

During the implementation of a cloud deployment model monitoring strategy, evaluate these points:

- **Existing commitments**: Evaluate if you maintain a commitment to an existing enterprise monitoring platform, like [System Center Operations Manager](/system-center/scom/key-concepts). You might have existing commitments on other platforms because they are already integrated with your IT operations processes, knowledge, and expertise, and it would be more costly to change for these reasons.
- **Monitoring needs**: Do you monitor workloads and infrastructure on-premises only, both on-premises and in the public cloud, or just in the cloud?
- **Modernizing IT operations**: Does your monitoring strategy include modernizing IT operations and move to our cloud monitoring services and solutions?
- **Critical systems**: Do you have air-gapped or physically isolated systems? Do you have systems hosted in a private cloud, or on physical hardware that needs to be monitored?

The strategies discussed in this document deliver a complete, service-oriented monitoring perspective, and it includes support for monitoring these things:

- **Infrastructure**: Compute, storage, and server workloads.
- **Applications**: End-user, exceptions, and clients.
- **Networking**: Network resources.

Monitoring should be based on knowing what information needs to be visualized for the operators and application owners. Based on that information you can decide which data to collect, and choose the appropriate tools. If the environment includes multiple services, each service should be evaluated separately. Workload specific monitoring should be enabled on top of your [management baseline](/azure/cloud-adoption-framework/manage/azure-management-guide/) monitoring.

## Azure cloud monitoring

[Azure Monitor](/azure/azure-monitor/overview) is a comprehensive solution for collecting, analyzing, and acting on signals from your Azure and on-premises environments. Azure Monitor contains many features, including, but not limited to, network monitoring, SCOM Managed Instance, VM Insights, and Application Insights.

Our recommended approach to monitoring each layer of the stack is summarized in the following table:

| Layer | Resource | Scope | Method |
|---|---|---|---|
| Application monitoring | A web-based application that runs on .NET, .NET Core, Java, JavaScript, or Node.js on Azure VM, Azure App Service, Azure Service Fabric, Azure Functions, or Azure Cloud Services. | Monitor a live web application to automatically detect performance anomalies, identify code exceptions and issues and collect user behavior analytics. | Application Insights, a feature of Azure Monitor. |
| Azure resources | For example, Azure website, Azure key vault or Network Security Groups. Also, Azure database services such as SQL or MySQL. | Availability, performance, and operation monitoring. | <li>Enable diagnostics logging to stream data to Azure Monitor Logs.<li>Enable Azure Monitor Insights to use curated monitoring views for specific Azure resources. |
| In-guest Operating Systems components|For example, Windows servers, containers, or Linux servers|Capacity, availability, performance, logs, events and services|<li>Enable diagnostics logging to stream data to Azure Monitor Logs.<li>Enable Azure Monitor Insights to use curated monitoring views for specific Azure resources.|
| Network | Communication between your virtual machine and one or more endpoints. | Monitor reachability, latency, and network topology changes between the VM and the endpoint. | [Azure Monitor Network Insights](/azure/network-watcher/network-insights-overview) and [Azure network monitoring solutions](/azure/networking/network-monitoring-overview).|
| Azure subscription | [Azure Service Health](/azure/service-health/overview) and basic resource health from the perspective of the Azure service. | <li> Administrative actions performed on a service or resource. <li> Service health of an Azure service is in a degraded or unavailable state. <li> Health issues detected with an Azure resource from the Azure service perspective. <li> Operations performed with Azure autoscale indicating a failure or exception. <li> Operations performed with Azure Policy indicating that an allowed or denied action occurred. <li> Record of alerts generated by Microsoft Defender for Cloud. | Delivered in the activity log for monitoring and alerting by using Azure Monitor. |
| Azure tenant | Azure AD | Azure AD audit and sign-in logs. | Enable [diagnostics logging](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics), and configure streaming to Azure Monitor Logs. |
| Security |All types of resources|Security Audit|<li>[Onboard Microsoft Sentinel](/azure/sentinel/quickstart-onboard)<li>[Microsoft Defender for Cloud](/azure/defender-for-cloud/).|

## Hybrid cloud monitoring

Microsoft offers multiple monitoring platforms that support this cloud model, and IT decision-makers might need clarification on which platform best helps their business and IT operational goals.

This section compares several platform and infrastructure factors for Azure Monitor, System Center Operations Manager (Operations Manager), and System Center Operations Manager Managed Instance (preview) (SCOM Managed Instance (preview)).

| Requirement | Azure Monitor<br>_(without Azure Monitor SCOM Managed Instance features)_ | Operations Manager | SCOM Managed Instance (preview) |
|---|---|---|---|
| General target environment | Most IT resources are Azure PaaS resources.<br><br>The customers have a clear strategy to modernize IT operation and migrate to Azure. | Customers with limited or no resources in Azure. Monitoring focused on local data centers. Azure monitoring can be achieved with management packs for Azure and Microsoft 365. | Customers with both local data center and resources in Azure.<br><br>Customers who want to maintain commitment to System Center Operations Manager, because it's integrated with your IT operations processes, knowledge, and expertise or because certain functionality isn't available in Azure Monitor. |
| Infrastructure requirements | No | Yes <br><br> Requires, at a minimum, a management server and a SQL Server instance to host the operational database and the reporting data warehouse database.<br><br>The complexity increases when high availability and disaster recovery are required, and there are machines in multiple sites, untrusted systems, and other complex design considerations. |Yes, limited <br>Requires, at a minimum, connectivity to Active Directory Domain, availability of Azure SQL Managed. |
| Limited connectivity: no internet or isolated network | No | Yes | No |
| Limited connectivity: controlled internet access | Yes | Yes | Yes |
| Limited connectivity: frequently disconnected | Yes | Yes | Yes |
| Configurable health monitoring | Yes, with Application Insights | Yes | Yes |
| Web app availability test (isolated network) | Yes, limited.<br><br>Azure Monitor has limited support in this area and requires custom firewall exceptions. | Yes | Yes, limited.<br><br> SCOM Managed Instance (preview) supports this from agents or management server resource pools.|
| Web app availability test (globally distributed) | No | Yes | No |
| Monitor VM workloads | Yes, limited.<br><br>Can collect IIS and SQL Server error logs, Windows events, and performance counters. Requires creating custom queries, alerts, and visualizations. See [Get started with log queries in Azure Monitor](/azure/azure-monitor/logs/get-started-queries) | Yes.<br><br>Supports monitoring most server workloads with available management packs. Requires either the Log Analytics Windows agent or Operations Manager agent on the VM, reporting back to the management group on the corporate network.| Yes.<br><br>Supports monitoring most of the server workloads with available management packs. Requires the Operations Manager agent on the VM, reporting back to the managed instance.|
| Monitor Azure IaaS | Yes | Yes.<br><br>Supports monitoring most of the infrastructure from the corporate network. Tracks availability state, metrics, and alerts for Azure VMs, SQL, and storage via the Azure management pack. | Yes.<br><br>Supports monitoring most of the infrastructure. Tracks availability state, metrics, and alerts for Azure VMs, SQL, and storage via the Azure management pack.|
| Monitor Azure PaaS | Yes | Yes, limited.<br>Based on what's supported in the Azure and Microsoft 365 management packs. For more information about the Azure management pack, see [Download Microsoft System Center Operations Manager Management Pack for Microsoft Azure](https://www.microsoft.com/download/details.aspx?id=50013). | Yes, limited.<br><br>Based on what's supported in the Azure management pack. For more information about the Azure management pack, see [Download Microsoft System Center Operations Manager Management Pack for Microsoft Azure](https://www.microsoft.com/download/details.aspx?id=50013).|
| Azure service monitoring | Yes | Yes.<br><br>Although there's no native monitoring of Azure Service Health provided today through a management pack, you can create custom workflows to query Service Health alerts. Use the Azure REST API to get alerts through your existing notifications. | Yes.<br><br>Although there's no native monitoring of Azure Service Health provided today through a management pack, you can create custom workflows to query Service Health alerts. Use the Azure REST API to get alerts through your existing notifications.|
| Modern web application monitoring | Yes | No | No |
| Legacy web application monitoring | Yes, limited. It varies by SDK.<br><br>Supports monitoring older versions of .NET and Java web applications. | Yes, limited. | Yes, limited |
| Monitor Azure Kubernetes Service containers | Yes | Yes, with management pack from Microsoft partners. | Yes, with management pack from Microsoft partners. |
| Monitor Docker or Windows containers | Yes | No | No |
| Network performance monitoring | Yes.<br><br>Support monitoring of network with [Azure Monitor Network Insights](/azure/network-watcher/network-insights-overview).<br><br>Support SNMP monitoring through SNMP proxy server. | Yes.<br><br>Supports availability checks and collects basic statistics from network devices by using the Simple Network Management Protocol (SNMP) from the corporate network.<br><br>Support basic network connectivity. | Yes.<br><br>Supports availability checks and collects basic statistics from network devices by using the Simple Network Management Protocol (SNMP) from the corporate network.<br><br>Support basic network connectivity. |
| Interactive data analysis | Yes | No.<br><br>Relies on SQL Server Reporting Services canned or custom reports, third-party visualization solutions, or a custom Power BI implementation. There are scale and performance limitations with the Operations Manager data warehouse. Integrate with Azure Monitor Logs as an alternative for data aggregation requirements. You achieve integration by configuring the Log Analytics connector. | Yes, limited.<br><br>Relies on Power BI implementation or third-party visualization solutions.|
| End-to-end diagnostics, root-cause analysis, and timely troubleshooting | Yes.<br><br>Custom scripts might be needed or integration into other services for example Azure Automation. | Yes.<br><br>Custom scripts might be needed or integration to other services for example Azure Automation or System Center Orchestrator. | Yes.<br><br>Custom scripts might be needed or integration to other services for example Azure Automation or System Center Orchestrator. |
| Interactive visualizations | Yes | Yes, limited.<br><br>Delivers essential dashboards with its HTML5 web console or an advanced experience from partner solutions. | Yes, limited.<br><br>Delivers essential dashboards with its HTML5 web console or an advanced experience from partner solutions. |
| Integration with IT or DevOps tools | Yes | Yes, limited. | Yes, limited. |

### Hybrid monitoring considerations

Here are some considerations for hybrid monitoring.

- **Stream monitoring data to third-party or on-premises systems**: To forward the diagnostics data emitted from your Azure resources to your on-premises tools or managed service provider, configure [Azure Event Hubs](/azure/azure-monitor/essentials/resource-logs#send-to-azure-event-hubs) to stream the data to them.

#### Tradeoffs for using only Operations Manager

- **Ad-hoc data analysis is unavailable**: Monitoring data in Operations Manager is commonly analyzed using predefined views provided by management packs accessed from the console, SQL Server Reporting Services (SSRS) reports, or custom views end users have created. Ad hoc data analysis isn't possible out of the box.

- **Inflexible and somewhat complex reporting**: The data warehouse that provides long-term retention of the monitoring data doesn't scale or perform well. And expertise in writing T-SQL statements, developing a Power BI solution, or using third-party solutions is required to support the requirements for the various personas in the IT organization.

- **Alerting**: Alerting in Operations Manager doesn't support complex expressions or include correlation logic. To help reduce noise, alerts are grouped to show their relationships and identify their causes.

##### Benefits of using Operations Manager together with Azure Monitor

- **Better analytics, performance, and retention**: Azure Monitor complements the Operations Manager data warehouse database by collecting important performance and log data. Azure Monitor delivers better analytics, has an increased performance when querying large data volume, and better retention than the Operations Manager data warehouse.

- **Complex queries and data visualization**: You can create more complex and sophisticated queries with the Kusto Query Language (KQL). You can run queries across terabytes of data in seconds. You can quickly transform your data into pie charts, time charts, and many other visualizations. To analyze this data, you're no longer constrained by working with Operations Manager reports based on SQL Server Reporting Services, custom SQL queries, or other workarounds.

- **Alerts**: You can deliver an improved alerting experience by implementing the Azure Monitor Alert Management solution. Alerts that are generated in the Operations Manager management group can be forwarded to the Azure Monitor Log Analytics workspace. You can configure the subscription responsible for forwarding alerts from Operations Manager to Azure Monitor Logs to forward only specific alerts. For example, you can forward only alerts that meet your criteria for querying in support of problem management for trends, and investigation of the root cause of failures or problems, through a single pane of glass. You can also correlate other log data from Application Insights or other sources to gain insight that improves user experience, increases uptime, and reduces time to resolve incidents.

- **Monitor across the landscape**: You can monitor cloud-native infrastructure and applications from a simple or multitier architecture in Azure using Azure Monitor, and you can use Operations Manager to monitor on-premises infrastructure. This monitoring includes one or more VMs, multiple VMs placed in an availability set or Virtual Machine Scale Set, or a containerized application deployed to Azure Kubernetes Service (AKS) running on Windows Server or Linux containers.

  If you need comprehensive monitoring of Microsoft or third-party workloads running on your Azure VMs and have advanced scenarios that can't be evaluated based on log or performance data alone, use System Center Operations Manager. Its management packs deliver advanced logic, which includes a service and health model, to determine the operational health of the workload.

- **Network connectivity monitoring between Azure VMs and on-premises VMs**: Using the Map feature of Azure VM insights, you can monitor standard connectivity metrics from network connections between your Azure VMs and on-premises VMs. These metrics include response time, requests per minute, traffic throughput, and links. You can identify failed connections, troubleshoot, perform migration validation, perform security analysis, and verify the overall architecture of the service. Map can automatically discover application components on Windows and Linux systems and map the communication between services. This automation helps you identify connections and dependencies you were unaware of, plan and validate migration to Azure, and minimize speculation during incident resolution.

- **Network connectivity monitoring between environments**: By using Network Performance Monitor, you can monitor the network connectivity between:
  - Your corporate network and Azure.
  - Mission-critical multitier applications and microservices.
  - User locations and web-based applications (HTTP/HTTPS).

    This strategy delivers network layer visibility without the need for SNMP. In an interactive topology map, it can also present the hop-by-hop topology of routes between the source and destination endpoint. It's better than attempting to accomplish the same result with network monitoring in Operations Manager or with other network monitoring tools currently used in your environment.

#### Benefits of using Azure Monitor

Examine your monitoring and alerting requirements, the configuration of existing monitoring tools, and workloads transitioning to the cloud. After your plan is finalized, configure Azure Monitor.

- **Hybrid infrastructure and application monitoring**: Monitor the hybrid infrastructure and applications from a simple or multitier architecture where components are hosted between Azure, other cloud providers, and your corporate network. The components might include one or more VMs, multiple VMs placed in an availability set or Virtual Machine Scale Set, or a containerized application that's deployed to Azure Kubernetes Service (AKS) running on Windows Server or Linux containers.

- **Monitor on-premises resources with [Azure Arc](/azure/azure-arc/overview)**: Make use of Azure Arc to prepare your on-premises servers, virtual machines, Kubernetes clusters, and databases across your environment for management as if they're running in Azure. Azure Arc delivers consistent inventory, management, governance, and security with familiar Azure services and management capabilities.

- **Detect and diagnose issues between infrastructure and applications**: Enable Azure VM insights, Azure Container insights, and Application Insights to detect and diagnose issues between infrastructure and applications. For a more thorough analysis and correlation of data collected from the multiple components or dependencies supporting the application, you need to use Azure Monitor Logs.

- **Create intelligent alerts**: Design intelligent alerts that applies to a core set of applications and service components, which help reduce alert noise with dynamic thresholds for complex signals, and use alert aggregation based on machine learning algorithms to help identify the issue quickly.

- **Knowledge library**: Define a library of queries and dashboards to support the requirements of the various personas in the IT organization. You can access these from Azure Monitor, as an example, and quickly gain the insights you need for your daily business.

- **Define a monitoring baseline**: Define standards and methods for enabling monitoring across the hybrid and cloud resources, a monitoring baseline for each resource, and alert thresholds.

- **Configure the minimum required access**: Use Azure role-based access control (Azure RBAC) to grant users and groups only the access required to monitor data from the resources they manage.

## Private cloud monitoring

Many customers rely on Azure Stack for their private clouds. You can achieve holistic monitoring of Azure Stack with Operations Manager. Specifically, you can monitor the workloads running in the tenant, the resource level, the virtual machines, and the physical infrastructure hosting Azure Stack, like servers and network switches.

### Considerations for private cloud monitoring

- **Monitor health and alerts**: To learn about the included infrastructure monitoring capabilities that helps you view health and alerts for an Azure Stack Hub region, see [Monitor health and alerts in Azure Stack Hub](/azure-stack/operator/azure-stack-monitor-health).

- **Use Azure Monitor on Azure Stack Hub**: To get an integrated experience with Azure Monitor and get base-level infrastructure metrics and logs for most services, use [Azure Monitor on Azure Stack Hub](/azure-stack/user/azure-stack-metrics-azure-data).

- **Use Azure Stack management packs**: If you already invested in Operations Manager, use the Azure Stack management pack to monitor Azure Stack deployment's availability and health state, including regions, resource providers, updates, update runs, scale units, unit nodes, infrastructure roles, and their instances. This management pack uses the health and update resource provider REST APIs to communicate with Azure Stack. To monitor physical servers and storage devices, utilize the OEM vendors' management pack (for example, provided by Lenovo, HPE, or Dell).

- **Monitor network switches**: Operations Manager can natively monitor the network switches to collect basic statistics by using SNMP. The Azure management pack can monitor the tenant workloads by following two basic steps. Configure the subscription that you want to monitor, and then add the monitors for that subscription.

## Next steps

> [!div class="nextstepaction"]
> [Observability](./observability.md)
