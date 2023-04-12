---
title: Monitoring strategy for cloud deployment models
description: Learn how to adopt our recommended monitoring strategy for each of the cloud deployment models in Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/27/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank, engagement-fy23
products: azure-monitor
---

# Monitoring strategy for cloud deployment models

This article describes our recommended monitoring strategy for each of the cloud deployment models based on the following criteria:

- You maintain your commitment to [System Center Operations Manager](/system-center/scom/key-concepts), or another enterprise monitoring platform because it's integrated with your IT operations processes, knowledge, and expertise or because certain functionality isn't available in Azure Monitor.
- You monitor workloads on-premises, in the public cloud, or just in the cloud.
- Your cloud migration strategy includes modernizing IT operations and moving to our cloud monitoring services and solutions.
- You might have critical systems that are air-gapped, physically isolated, hosted in a private cloud, or on physical hardware, which needs to be monitored.

The strategy delivers a complete, service-oriented monitoring perspective, and it includes support for monitoring:

- infrastructure: compute, storage, and server workloads
- applications: end-user, exceptions, and client
- network resources

## Azure cloud monitoring

[Azure Monitor](/azure/azure-monitor/overview) is a comprehensive solution for collecting, analyzing, and acting on signals from your Azure and on-premises environments. It's designed for virtual machine (VM) workloads or complex cloud architectures that use microservices and other platform resources.

Azure Monitor examines all layers of the stack, starting with tenant services such as Azure Active Directory (Azure AD) Domain Services, subscription-level events, and Azure Service Health.

It also monitors infrastructure resources, such as VMs, storage, and network resources. At the top layer, it monitors your application. You gain visibility into applications and the critical infrastructure you need by monitoring dependencies and collecting the right signals that each dependency can emit.

Our recommended approach to monitoring each layer of the stack is summarized in the following table:

| Layer | Resource | Scope | Method |
|---|---|---|---|
| Application | A web-based application that runs on .NET, .NET Core, Java, JavaScript, or Node.js on Azure VM, Azure App Service, Azure Service Fabric, Azure Functions, or Azure Cloud Services. | Monitor a live web application to automatically detect performance anomalies, identify code exceptions and issues and collect user behavior analytics. | Application Insights, a feature of Azure Monitor. |
| Azure resources: platform as a service (PaaS) | Azure database services, such as SQL or MySQL. | Azure SQL Database availability, performance, and operation monitoring. | <li>Enable diagnostics logging to stream SQL data to Azure Monitor Logs.<li>[Azure Monitor SQL Insights (preview)](/azure/azure-sql/database/monitoring-sql-database-azure-monitor) |
| Azure resources: infrastructure as a service (IaaS) | 1. Azure Storage <br> 2. Azure [load balancing services](/azure/architecture/guide/technology-choices/load-balancing-overview#azure-load-balancing-services) <br> 3. Network security groups <br> 4. Azure Virtual Machines <br> 5. [Azure Kubernetes Service](/azure/aks/intro-kubernetes) / [Azure Container Instances](/azure/container-instances/) | 1. Capacity, availability, and performance. <br> 2. Performance and diagnostics logs. <br> 3. Monitor events when rules are applied, and use rule counter for how many times a rule is applied to deny or allow. <br> 4. Monitor capacity, availability, and performance in a guest VM operating system. Map application dependencies hosted on each VM, including the visibility of active network connections between servers. <br> 5. Monitor capacity, availability, and performance of workloads running on containers and container instances. | <li> For items 1-5 in the first column, platform metrics, and the activity log are automatically collected and available in Azure Monitor for analysis and alerting. <li> Configure diagnostic settings to forward resource logs to Azure Monitor Logs. <li> Enable [Azure VM insights](/azure/azure-monitor/vm/vminsights-overview). <li> Enable [Azure Container insights](/azure/azure-monitor/containers/container-insights-overview). |
| Network | Communication between your virtual machine and one or more endpoints (another VM, a fully qualified domain name, a uniform resource identifier, or an IPv4 address). | Monitor reachability, latency, and network topology changes between the VM and the endpoint. | Azure Network Watcher. |
| Azure subscription | [Azure Service Health](/azure/service-health/overview) and basic resource health from the perspective of the Azure service. | <li> Administrative actions performed on a service or resource. <li> Service health of an Azure service is in a degraded or unavailable state. <li> Health issues detected with an Azure resource from the Azure service perspective. <li> Operations performed with Azure autoscale indicating a failure or exception. <li> Operations performed with Azure Policy indicating that an allowed or denied action occurred. <li> Record of alerts generated by Microsoft Defender for Cloud. | Delivered in the activity log for monitoring and alerting by using Azure Monitor. |
| Azure tenant | Azure AD | Azure AD audit and sign-in logs. | Enable [diagnostics logging](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics), and configure streaming to Azure Monitor Logs. |

## Hybrid cloud monitoring

The hybrid cloud model is a common first step for organizations that want to approach cloud migration gradually. You carefully select the appropriate subset of applications and infrastructure to begin your migration while avoiding disruption to your business. However, because we offer multiple monitoring platforms that support this cloud model, IT decision-makers might need clarification on which platform best helps their business and IT operational goals.

SCOM Managed Instance (preview) provides a cloud-based alternative for SCOM customers, enabling monitoring continuity for your environments and accelerating Azure adoptions. SCOM Managed Instance (preview) is ideal for customers with existing SCOM investments who are adopting Azure, undergoing a lift and shift (rehosting) of applications and infrastructure to Azure, or maintaining on-premises environments with Azure connectivity (extended to Azure).

This section presents several factors that help determine which platform to consider. Keep in mind the following critical technical aspects:

- You need to collect data from Azure resources that support the workload, then forward the data to your existing on-premises or managed service provider tools.

- You need to maintain your current investment in System Center Operations Manager and configure it to monitor IaaS and PaaS resources that are running in Azure. Optionally, because you're monitoring two environments with different characteristics, you need to determine how integrating with Azure Monitor supports your strategy.

- As part of your modernization strategy to standardize on a single tool to reduce cost and complexity, you need to commit to Azure Monitor to monitor the resources in Azure and your corporate network.

Azure Monitor, SCOM Managed Instance (preview), and System Center Operations Manager support the following requirements for monitoring hybrid clouds.

| Requirement | Azure Monitor | Operations Manager | SCOM Managed Instance (preview) |
|---|---|---|---|
| Infrastructure requirements | No | Yes <br><br> Requires, at a minimum, a management server and a SQL Server instance to host the operational database and the reporting data warehouse database. The complexity increases when high availability and disaster recovery are required, and there are machines in multiple sites, untrusted systems, and other complex design considerations. | Yes, limited <br><br> Requires, at a minimum, connectivity to Active Directory Domain, availability of Azure SQL Managed  |
| Limited connectivity: no internet or isolated network | No | Yes | No |
| Limited connectivity: controlled internet access | Yes | Yes | Yes |
| Limited connectivity: frequently disconnected | Yes | Yes | Yes |
| Configurable health monitoring | Yes, with Application Insights | Yes | Yes |
| Web app availability test (isolated network) | Yes, limited <br><br> Azure Monitor has limited support in this area and requires custom firewall exceptions. | Yes | Yes, limited <br><br> SCOM Managed Instance (preview) has limited support in this area and requires custom firewall exceptions. |
| Web app availability test (globally distributed) | No | Yes | No |
| Monitor VM workloads | Yes, limited <br><br> Can collect IIS and SQL Server error logs, Windows events, and performance counters. Requires creating custom queries, alerts, and visualizations. | Yes <br><br> Supports monitoring most server workloads with available management packs. Requires either the Log Analytics Windows agent or Operations Manager agent on the VM, reporting back to the management group on the corporate network. | Yes <br><br> Supports monitoring most of the server workloads with available management packs. Requires the Operations Manager agent on the VM, reporting back to the managed instance. |
| Monitor Azure IaaS | Yes | Yes <br><br> Supports monitoring most of the infrastructure from the corporate network. Tracks availability state, metrics, and alerts for Azure VMs, SQL, and storage via the Azure management pack. | Yes <br><br>Supports monitoring most of the infrastructure. Tracks availability state, metrics, and alerts for Azure VMs, SQL, and storage via the Azure management pack. |
| Monitor Azure PaaS | Yes | Yes, limited <br><br> Based on what's supported in the Azure management pack. | Yes, limited <br><br> Based on what's supported in the Azure management pack. |
| Azure service monitoring | Yes | Yes <br><br> Although there's no native monitoring of Azure Service Health provided today through a management pack, you can create custom workflows to query Service Health alerts. Use the Azure REST API to get alerts through your existing notifications. | Yes <br><br> Although there's no native monitoring of Azure Service Health provided today through a management pack, you can create custom workflows to query Service Health alerts. Use the Azure REST API to get alerts through your existing notifications. |
| Modern web application monitoring | Yes | No | No |
| Legacy web application monitoring | Yes, limited, varies by SDK <br><br> Supports monitoring older versions of .NET and Java web applications. | Yes, limited | Yes, limited |
| Monitor Azure Kubernetes Service containers | Yes | No | Yes, limited <br><br> Monitoring is available through a management pack. |
| Monitor Docker or Windows containers | Yes | No | No |
| Network performance monitoring | Yes | Yes, limited <br><br> Supports availability checks and collects basic statistics from network devices by using the Simple Network Management Protocol (SNMP) from the corporate network. | Yes, limited <br><br> Supports availability checks and collects basic statistics from network devices by using the Simple Network Management Protocol (SNMP) from the corporate network. |
| Interactive data analysis | Yes | No <br><br> Relies on SQL Server Reporting Services canned or custom reports, third-party visualization solutions, or a custom Power BI implementation. There are scale and performance limitations with the Operations Manager data warehouse. Integrate with Azure Monitor Logs as an alternative for data aggregation requirements. You achieve integration by configuring the Log Analytics connector. | Yes, limited <br><br> Relies on Power BI implementation or third-party visualization solutions. |
| End-to-end diagnostics, root-cause analysis, and timely troubleshooting | Yes | Yes, limited <br><br> Supports end-to-end diagnostics and troubleshooting only for on-premises infrastructure and applications. Uses other System Center components or partner solutions. | Yes <br><br> Supports end-to-end diagnostics and troubleshooting only for workloads. |
| Interactive visualizations | Yes | Yes, limited <br><br> Delivers essential dashboards with its HTML5 web console or an advanced experience from partner solutions, such as Squared Up and Savision. | Yes, limited <br><br> Delivers essential dashboards with its HTML5 web console or an advanced experience from partner solutions, such as Squared Up and Savision. |
| Integration with IT or DevOps tools | Yes | Yes, limited | Yes, limited |

### Collect and stream monitoring data to third-party or on-premises tools

To collect metrics and logs from Azure infrastructure and platform resources, enable [Azure resource logs](/azure/azure-monitor/essentials/resource-logs) for those resources. With Azure VMs, you can collect metrics and logs from the guest OS by enabling the [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) extension and [Azure Monitor VM Insights](/azure/azure-monitor/vm/vminsights-overview). To forward the diagnostics data emitted from your Azure resources to your on-premises tools or managed service provider, configure [Azure Event Hubs](/azure/azure-monitor/essentials/resource-logs#send-to-azure-event-hubs) to stream the data to them.

### Monitor with System Center Operations Manager

Although System Center Operations Manager was initially designed as an on-premises solution to monitor applications, workloads, and infrastructure components running in your IT environment, it evolved to include cloud-monitoring capabilities. It integrates with Azure, Microsoft 365, and Amazon Web Services (AWS). It can monitor these diverse environments with management packs that are designed and updated to support them.

For customers who have made significant investments in Operations Manager to achieve comprehensive monitoring or for customers new to Azure, it's understandable to ask the following questions:

- Can Operations Manager continue to deliver value, and does it make business sense?
- Do the features of Operations Manager make it the right fit for our IT organization?
- Does integrating Operations Manager with Azure Monitor provide the cost-effective and comprehensive monitoring solution we require?

If you've already invested in Operations Manager, you can focus on something other than planning a migration to replace it immediately. With Azure or other cloud providers that are an extension of your on-premises network, the Operations Manager can monitor the guest VMs and Azure resources as if they were on your corporate network. This approach requires a reliable network connection between your network and the virtual network in Azure that has sufficient bandwidth.

To monitor Azure workloads, you need the following:

- The [System Center Operations Manager management pack for Azure](https://www.microsoft.com/download/details.aspx?id=50013). It collects performance metrics emitted by Azure services such as web and worker roles, Application Insights availability tests (web tests), Azure Service Bus, and so on. The management pack uses the Azure REST API to monitor the availability and performance of these resources. Some Azure service types have no metrics or predefined monitors in the management pack. However, you can still monitor them through the relationships defined in the Azure management pack for discovered services.

- The [management pack for Azure SQL Database](https://www.microsoft.com/download/details.aspx?id=38829) to monitor the availability and performance of Azure SQL databases using the Azure REST API and T-SQL queries to SQL Server system views.

- To monitor the guest OS and workloads that run on the VM, such as SQL Server, IIS, or Apache Tomcat, you need to download and import the management pack that supports the application, service, and OS.

Knowledge is defined in the management pack, which describes how to monitor the individual dependencies and components. Both Azure management packs require a set of configuration steps in Azure and Operations Manager before you can begin monitoring these resources.

At the application tier, Operations Manager offers basic application performance monitoring capabilities for some legacy versions of .NET and Java. Suppose specific applications within your hybrid cloud environment operate offline or network-isolated, so they can't communicate with a public cloud service. In that case, Operations Manager application performance monitoring might be a viable option for specific limited scenarios. For applications that aren't running on legacy platforms but are hosted both on-premises and in any public cloud that allows communication through a firewall to Azure, use Azure Monitor Application Insights. This service offers deep, code-level monitoring with first-class support for ASP.NET, ASP.NET Core, Java, JavaScript, and Node.js.

For any web application that can be reached externally, you should enable a synthetic transaction known as [availability monitoring](/azure/azure-monitor/app/monitor-web-app-availability). It's important to know whether your application or a critical HTTP/HTTPS endpoint that your application relies on is available and responsive. With Application Insights availability monitoring, you can run tests from multiple Azure datacenters and provide insight into the health of your application from a global perspective.

Although Operations Manager is capable of monitoring resources that are hosted in Azure, there are several advantages to including Azure Monitor. Its strengths overcome the limitations of Operations Manager and can establish a solid foundation to support eventual migration from it. Here we review those strengths and limitations, with our recommendation to include Azure Monitor in your hybrid monitoring strategy.

#### Disadvantages of using Operations Manager by itself

- Monitoring data in Operations Manager is commonly analyzed using predefined views provided by management packs accessed from the console, SQL Server Reporting Services (SSRS) reports, or custom views end users have created. Ad hoc data analysis isn't possible out of the box. Operations Manager reporting is inflexible. The data warehouse that provides long-term retention of the monitoring data doesn't scale or perform well. And expertise in writing T-SQL statements, developing a Power BI solution, or using third-party solutions is required to support the requirements for the various personas in the IT organization.

- Alerting in Operations Manager doesn't support complex expressions or include correlation logic. To help reduce noise, alerts are grouped to show their relationships and identify their causes.

#### Advantages of using Operations Manager with Azure Monitor

- Azure Monitor can work around the limitations of Operations Manager. It complements the Operations Manager data warehouse database by collecting important performance and log data. Azure Monitor delivers better analytics, performance when querying large data volume, and retention than the Operations Manager data warehouse.

You can create more complex and sophisticated queries with the Kusto Query Language (KQL). You can run queries across terabytes of data in seconds. You can quickly transform your data into pie charts, time charts, and many other visualizations. To analyze this data, you're no longer constrained by working with Operations Manager reports based on SQL Server Reporting Services, custom SQL queries, or other workarounds.

- You can deliver an improved alerting experience by implementing the Azure Monitor Alert Management solution. Alerts that are generated in the Operations Manager management group can be forwarded to the Azure Monitor Log Analytics workspace. You can configure the subscription responsible for forwarding alerts from Operations Manager to Azure Monitor Logs to forward only specific alerts. For example, you can forward only alerts that meet your criteria for querying in support of problem management for trends, and investigation of the root cause of failures or problems, through a single pane of glass. You can also correlate other log data from Application Insights or other sources to gain insight that improves user experience, increases uptime, and reduces time to resolve incidents.

- You can monitor cloud-native infrastructure and applications from a simple or multitier architecture in Azure using Azure Monitor, and you can use Operations Manager to monitor on-premises infrastructure. This monitoring includes one or more VMs, multiple VMs placed in an availability set or virtual machine scale set, or a containerized application deployed to Azure Kubernetes Service (AKS) running on Windows Server or Linux containers.

    If you need comprehensive monitoring of Microsoft or third-party workloads running on your Azure VMs and have advanced scenarios that can't be evaluated based on log or performance data alone, use System Center Operations Manager. Its management packs deliver advanced logic, which includes a service and health model, to determine the operational health of the workload.

- Using the Map feature of Azure VM insights, you can monitor standard connectivity metrics from network connections between your Azure VMs and on-premises VMs. These metrics include response time, requests per minute, traffic throughput, and links. You can identify failed connections, troubleshoot, perform migration validation, perform security analysis, and verify the overall architecture of the service. Map can automatically discover application components on Windows and Linux systems and map the communication between services. This automation helps you identify connections and dependencies you were unaware of, plan and validate migration to Azure, and minimize speculation during incident resolution.

- By using Network Performance Monitor, you can monitor the network connectivity between:
  - Your corporate network and Azure.
  - Mission-critical multitier applications and microservices.
  - User locations and web-based applications (HTTP/HTTPS).

    This strategy delivers network layer visibility without the need for SNMP. In an interactive topology map, it can also present the hop-by-hop topology of routes between the source and destination endpoint. It's better than attempting to accomplish the same result with network monitoring in Operations Manager or with other network monitoring tools currently used in your environment.

### Monitoring with Azure Monitor

Although migration to the cloud presents numerous challenges, it also provides opportunities. Your organization can migrate from one or more on-premises enterprise monitoring tools to reduce capital expenditures and operating costs and benefit from the advantages that a cloud monitoring platform such as Azure Monitor can deliver at cloud scale. Examine your monitoring and alerting requirements, the configuration of existing monitoring tools, and workloads transitioning to the cloud. After your plan is finalized, configure Azure Monitor.

- Monitor the hybrid infrastructure and applications from a simple or multitier architecture where components are hosted between Azure, other cloud providers, and your corporate network. The components might include one or more VMs, multiple VMs placed in an availability set or virtual machine scale set, or a containerized application that's deployed to Azure Kubernetes Service (AKS) running on Windows Server or Linux containers.

- Use [Azure Arc](/azure/azure-arc/overview) to prepare your servers, virtual machines, Kubernetes clusters, and databases across your environment for management as if they're running in Azure. Azure Arc delivers consistent inventory, management, governance, and security with familiar Azure services and management capabilities.

- Enable Azure VM insights, Azure Container insights, and Application Insights to detect and diagnose issues between infrastructure and applications. For a more thorough analysis and correlation of data collected from the multiple components or dependencies supporting the application, you need to use Azure Monitor Logs.

- Create intelligent alerts that apply to a core set of applications and service components, help reduce alert noise with dynamic thresholds for complex signals, and use alert aggregation based on machine learning algorithms to help identify the issue quickly.

- Define a library of queries and dashboards to support the requirements of the various personas in the IT organization.

- Define standards and methods for enabling monitoring across the hybrid and cloud resources, a monitoring baseline for each resource, and alert thresholds.

- Configure Azure role-based access control (Azure RBAC) so you grant users and groups only the access required to monitor data from the resources they manage.

- Include automation and self-service to enable each team to create, enable, and tune their monitoring and alerting configurations as needed.

## Private cloud monitoring

You can achieve holistic monitoring of Azure Stack with System Center Operations Manager. Specifically, you can monitor the workloads running in the tenant, the resource level, the virtual machines, and the infrastructure hosting Azure Stack (physical servers and network switches).

You can also achieve holistic monitoring with a combination of [infrastructure monitoring capabilities](/azure-stack/operator/azure-stack-monitor-health) that are included in Azure Stack. These capabilities help you view health and alerts for an Azure Stack region and the [Azure Monitor service](/azure-stack/user/azure-stack-metrics-azure-data) in Azure Stack, which provides base-level infrastructure metrics and logs for most services.

If you've already invested in Operations Manager, use the Azure Stack management pack to monitor Azure Stack deployment's availability and health state, including regions, resource providers, updates, update runs, scale units, unit nodes, infrastructure roles, and their instances. This management pack uses the health and update resource provider REST APIs to communicate with Azure Stack. To monitor physical servers and storage devices, utilize the OEM vendors' management pack (for example, provided by Lenovo, HPE, or Dell).

Operations Manager can natively monitor the network switches to collect basic statistics by using SNMP. The Azure management pack can monitor the tenant workloads by following two basic steps. Configure the subscription that you want to monitor, and then add the monitors for that subscription.

## Next steps

> [!div class="nextstepaction"]
> [Collect the right data](./data-collection.md)
