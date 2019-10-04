---
title: Cloud monitoring guide – Monitoring strategy for cloud deployment models
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Choose when to use Azure Monitor or System Center Operations Manager in Microsoft Azure
author: MGoedtel
ms.author: magoedte
ms.date: 10/04/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: operate
services: azure-monitor
---

# Cloud monitoring guide: Monitoring strategy for cloud deployment models

This article includes our recommended monitoring strategy for each of the cloud deployment models, based on the following criteria:

- You need to maintain your commitment to Operations Manager or other enterprise monitoring platform because of integration with your IT operations processes, knowledge and expertise, or certain functionality isn't available yet in Azure Monitor.
- You have to monitor workloads both on-premises and in the public cloud, or just in the cloud.
- Your cloud migration strategy includes modernizing IT operations and moving to our cloud monitoring services and solutions.
- You might have critical systems that are air-gapped or physically isolated, hosted in a private cloud or on physical hardware, and need to be monitored.

Our strategy includes support for monitoring infrastructure (compute, storage, and server workloads), application (end-user, exceptions, and client), and network resources to deliver a complete, service-oriented monitoring perspective.

## Azure cloud monitoring

Azure Monitor is the Azure native platform service that provides a single source for monitoring Azure resources. It's designed for cloud solutions that are built on Azure, and that support a business capability that is based on VM workloads or complex architectures that use microservices and other platform resources. It monitors all layers of the stack, starting with tenant services such as Azure Active Directory Domain Services, and subscription-level events and Azure service health. It also monitors infrastructure resources like VMs, storage, and network resources, and, at the top layer, your application. Monitoring each of these dependencies, and collecting the right signals that each can emit, gives you the observability of applications and the key infrastructure you need.

The following table summarizes the recommended approach to monitoring each layer of the stack.

<!-- markdownlint-disable MD033 -->

Layer | Resource | Scope | Method
---|---|---|----
Application | Web-based application running on .NET, .NET Core, Java, JavaScript, and Node.js platform on an Azure VM, Azure App Services, Azure Service Fabric, Azure Functions, and Azure Cloud Services | Monitor a live web application to automatically detect performance anomalies, identify code exceptions and issues, and collect user behavior analytics. |  Azure Monitor (Application Insights)
Azure resources - PaaS | 1. Azure Database services (for example, SQL or mySQL) | 1. Azure Database for SQL performance metrics. | 1. Enable diagnostic logging to stream SQL data to Azure Monitor Logs.
Azure resources - IaaS | 1. Azure Storage<br/> 2. Azure Application Gateway<br/> 3. Network security groups<br/> 4. Azure Traffic Manager<br/> 5. Virtual Machine<br/> 6. Azure Kubernetes Service/Azure Container Instances | 1. Capacity, availability, and performance.<br/> 2. Performance and diagnostic logs (activity, access, performance, and firewall).<br/> 3. Monitor events when rules are applied, and the rule counter for how many times a rule is applied to deny or allow.<br/> 4. Monitor endpoint status availability.<br/> 5. Monitor capacity, availability, and performance in guest VM OS. Map app dependencies hosted on each VM, including the visibility of active network connections between servers, inbound and outbound connection latency, and ports across any TCP-connected architecture.<br/> 6. Monitor capacity, availability, and performance of workloads running on containers and container instances. | 1. Storage metrics for Blob storage.<br/> 2. Enable diagnostic logging and configure streaming to Azure Monitor Logs.<br/> 3. Enable diagnostic logging of network security groups, and configure streaming to Azure Monitor Logs.<br/> 4. Enable diagnostic logging of Traffic Manager endpoints, and configure streaming to Azure Monitor Logs.<br/> 5. Enable Azure Monitor for VMs<br/> 6. Enable Azure Monitor for containers
Network| Communication between your virtual machine and one or more endpoints (another VM, a fully qualified domain name, a uniform resource identifier, or an IPv4 address). | Monitor reachability, latency, and network topology changes that occur between the VM and the endpoint. | Azure Network Watcher
Azure subscription | Azure service health and basic resource health | <li> Administrative actions performed on a service or resource.<br/><li> Service health with an Azure service is in a degraded or unavailable state.<br/><li> Health issues detected with an Azure resource from the Azure service perspective.<br/><li> Operations performed with Azure Autoscale indicating a failure or exception. <br/><li> Operations performed with Azure Policy indicating that an allowed or denied action occurred.<br/><li> Record of alerts generated by Azure Security Center. |Delivered in the Activity Log for monitoring and alerting by using Azure Resource Manager.
Azure tenant|Azure Active Directory || Enable diagnostic logging, and configure streaming to Azure Monitor Logs.

<!-- markdownlint-enable MD033 -->

## Hybrid cloud monitoring

For many organizations, the cloud must be approached gradually, where the hybrid cloud model is the most common first step in the journey. You carefully select the appropriate subset of applications, and infrastructure to begin your migration while avoiding disruption to your business. However, because we offer two monitoring platforms that support this cloud model, IT decision makers are confused as to which one is the best choice to support their business and IT operational goals. We are going to review several factors to address the uncertainty and provide you with an understanding of which platform to consider.

Some of the key technical aspects to be considered are:

* You need to collect data from Azure resources supporting the workload, and forward them to your existing on-premises or managed service provider tools.

* You need to maintain your current investment in System Center Operations Manager, and configure it to monitor IaaS and PaaS resources running in Azure. Optionally, because you are monitoring two environments with different characteristics, based on your requirements, you determine integrating with Azure Monitor supports your strategy.

* As part of your modernization strategy to standardize on a single tool to reduce cost and complexity, you commit to Azure Monitor for monitoring the resources in Azure and on your corporate network.

The following table summarizes the requirements that Azure Monitor and System Center Operations Manager support with monitoring the hybrid cloud model based on a common set of criteria.

|Requirement | Azure Monitor | Operations Manager |
|:--|:---|:---|
|Infrastructure requirements | **No** | **Yes**<br> Requires at a minimum a management server, and a SQL server to host the operational database and the reporting data warehouse database. Becomes more complex when HA/DR are required, machines in multiple sites, untrusted systems, and other complex design considerations.|
|Limited connectivity - no internet<br> or isolated network | **No** | **Yes** | 
|Limited connectivity - controlled internet access | **Yes** | **Yes** |
|Limited connectivity - frequently disconnected | **Yes** | **Yes** |
|Configurable health monitoring | **No** | **Yes** |
| Web app availability test (isolated network) | **Yes, limited**<br> Azure Monitor has limited support in this area and requires custom firewall exceptions. | **Yes** | 
| Web app availability test (globally distributed) | **No** | **Yes** |
|Monitor VM workloads | **Yes, limited**<br> Can collect IIS and SQL Server error logs, Windows events, and performance counters. Requires creating custom queries, alerts, and visualizations. | **Yes**<br> Supports monitoring most of the server workloads with available management packs. Requires either the Log Analytics Windows agent or Operations Manager agent on the VM, reporting back to the management group on the corporate network.|
|Monitor Azure IaaS | **Yes** | **Yes**<br> Supports monitoring most of the infrastructure from the corporate network. Tracks availability state, metrics, and alerts for Azure VMs, SQL, and storage via the Azure management pack.|
|Monitor Azure PaaS | **Yes** | **Yes, limited**<br> Based on what's supported in the Azure management pack. | 
|Azure service monitoring | **Yes**<br> | **Yes**<br> While there is no native monitoring of Azure service health provided today through a management pack, you can create custom workflows to query Azure service health alerts. Use the Azure REST API to get alerts through your existing notifications.|
|Modern web application monitoring | **Yes** | **No** |
|Legacy web application monitoring | **Yes, limited varies by SDK**<br> Supports monitoring older versions of .NET and Java web applications. | **Yes, limited** |
|Monitor Azure Kubernetes Service containers | **Yes** | **No** |
|Monitor Docker / Windows containers | **Yes** | **No** | 
|Network performance monitoring | **Yes** | **Yes, limited**<br> Supports availability checks, and collects basic statistics from network devices by using the SNMP protocol from the corporate network.|
|Interactive data analysis | **Yes** | **No**<br> Relies on SQL Server Reporting Services pre-canned or custom reports, third-party visualization solutions, or a custom Power BI implementation. There are scale and performance limitations with the Operations Manager data warehouse. Integrate with Azure Monitor Logs as an alternative for data aggregation requirements. Integration is achieved by configuring the Log Analytics connector.| 
|End-to-end diagnostics, root-cause analysis, and timely troubleshooting | **Yes** | **Yes, limited**<br> Supports end-to-end diagnostics and troubleshooting only for on-premises infrastructure and applications. Uses other System Center components or partner solutions.|
|Interactive visualizations (Dashboards) | **Yes** | **Yes, limited**<br> Delivers essential dashboards with its HTLM5 web console or an advanced experience from partner solutions like Squared Up and Savision. |
|Integration with IT/DevOps tools | **Yes** | **Yes, limited** |

### Collect and stream monitoring data to third-party or on-premises tools

To collect metrics and logs from Azure infrastructure and platform resources, you need to enable Azure diagnostic logs for those resources. Additionally, with Azure VMs, you can collect metrics and logs from the guest operating system by enabling the Azure Diagnostics extension. To forward the diagnostic data emitted from your Azure resources to your on-premises tools or managed service provider, configure [Event Hubs](https://docs.microsoft.com/azure/azure-monitor/platform/diagnostic-logs-stream-event-hubs) to stream the data to them. 

### Monitor with System Center Operations Manager

While System Center Operations Manager was originally designed as an on-premises solution to monitor across applications, workloads, and infrastructure running in your IT environment, it evolved to include cloud-monitoring capabilities and integrates with Azure, Office 365, and Amazon Web Services (AWS). It is able to monitor across these diverse environments with management packs designed and updated to support them.  

For customers who have made significant investments in Operations Manager to achieve comprehensive monitoring that is tightly integrated with their IT service management processes and tools, or customers new to Azure, it is understandable to question:

* Can Operations Manager continue to deliver value and does it make business sense?

* If features in Operations Manager make it the right fit for our IT organization?

* Does integrating Operations Manager with Azure Monitor provide the cost-effective and comprehensive monitoring solution that we require? 

If you have already invested in Operations Manager, you don't need to concentrate on planning a migration to replace it immediately. With Azure or other cloud providers existing as an extension of your own on-premises network, Operations Manager can monitor the guest VMs and Azure resources as if they were on your corporate network. This requires having a reliable network connection between your network and the Azure virtual network that has sufficient bandwidth. 

To monitor the workloads running in Azure, you need:

* The [Azure management pack](https://www.microsoft.com/download/details.aspx?id=50013) to collect performance metrics emitted by Azure Services such as web and worker roles, Application Insights availability tests (webtests), Service Bus, etc. The management pack uses the Azure REST API to monitor the availability and performance of these resources. Some Azure service types do not have any metrics or any pre-defined monitors in the management pack, but still can be monitored through the relationships defined in the Azure management pack for discovered services.

* The [Azure SQL Database management pack](https://www.microsoft.com/download/details.aspx?id=38829) to monitor the availability and performance of Azure SQL databases and Azure SQL database servers using the Azure REST API and T-SQL queries to SQL Server system views.

* To monitor the guest OS and workloads running on the VM, such as SQL Server, IIS, or Apache Tomcat, you would need to download and import the management pack that supports the application, service, and operating system.

Knowledge is defined in the management pack which describes how to monitor the individual dependencies and components. Both Azure management packs require performing a set of configuration steps in Azure and Operations Manager in order to begin monitoring these resources. 

At the application tier, Operations Manager offers basic application performance monitoring capabilities for some legacy versions of .NET and Java. If certain applications within your hybrid cloud environment operate in an offline or network-isolated mode, such that they can't communicate with a public cloud service, Operations Manager Application Performance Monitoring (APM) may be a viable option for certain limited scenarios. For applications not running on legacy platforms, hosted both on-premises and in any public cloud that allows communication through a firewall (either direct or via a proxy) to Azure, use Azure Monitor Application Insights. This offers deep, code-level monitoring, with first-class support for ASP.NET, ASP.NET Core, Java, JavaScript, and Node.js.

For any web application that can be reached externally, you should enable a type of synthetic transactions known as [availability monitoring]( https://docs.microsoft.com/azure/azure-monitor/app/monitor-web-app-availability). It's extremely important to know if your application or a critical HTTP/HTTPS endpoint that your app relies on, is available and responsive. Application Insights availability monitoring allows you to run tests from multiple Azure datacenters, and provide insight into the health of your application from a global perspective.

While Operations Manager is capable of monitoring resources hosted in Azure, there are several advantages to including Azure Monitor, as its strengths overcome limitations in Operations Manager and establishes a strong foundation to support eventual migration from it. Here we review each of those with our recommendation to include Azure Monitor in your hybrid monitoring strategy.  



#### Disadvantage of using Operations Manager by itself

1. Analyzing monitoring data in Operations Manager is commonly performed using pre-defined views defined in management packs that are accessed from the console, from SQL Server Reporting Services (SSRS) reports, or custom views created by the end user. Performing ad-hoc analysis of the data isn't possible out of the box. Operations Manager reporting is inflexible, the data warehouse which provides long-term retention of the monitoring data doesn't scale or perform well, and expertise in writing T-SQL statements, developing a Power BI solution, or using third-party solutions is required to support requirements for the different personas in the IT organization. 

2. Alerting in Operations Manager doesn't provide support for complex expressions and include correlation logic in an effort to help reduce alert noise and group alerts together in an effort to show the relationship between them to help identify the root cause of the issue. 

#### Advantage of Operations Manager + Azure Monitor

1. Azure Monitor Logs is the solution to work around Operations Manager’s limitations and compliments the Operations Manager data warehouse database to collect important performance and log data. Azure Monitor delivers better analytics, performance when querying large data volume, and retention than the Operations Manager data warehouse. Its query language allows you to create much more complex and sophisticated queries, with an ability to run queries across terabytes of data in seconds. You can quickly transform your data into pie charts, time charts, and many other visualizations. No longer are you constrained by working with reports in Operations Manager based on SQL Server Reporting Services, custom SQL queries, or other workarounds to analyze this data.

2. Deliver an improved alerting experience by implementing the Azure Monitor Alerts Management solution. Alerts generated in the Operations Manager management group can be forwarded to the Azure Monitor Logs Analytics workspace. You can configure the subscription responsible for forwarding alerts from Operations Manager to Azure Monitor Logs to only forward certain alerts. For example, you can forward only alerts that meet your criteria for querying in support of problem management for trends, and investigation of the root cause of failures or problems, through a single pane of glass. Additionally, you can correlate other log data from Application Insights or other sources, to gain insight that help improve user experience, increase uptime, and reduce time to resolve incidents.

3. Monitor cloud-native infrastructure and applications, from a simple or multi-tier architecture in Azure and use Operations Manager to monitor on-premises infrastructure. This includes one or more VMs, multiple VMs placed in an availability set or virtual machine scale set, or a containerized application deployed to Azure Kubernetes Service (AKS) running on Windows Server or Linux containers.

4. Use the System Center Operations Manager Health Check solution to proactively assess the risk and health of your System Center Operations Manager management group on a regular interval. This can replace or compliment any custom functionality you have added to your management group.

5. With the Map feature of Azure Monitor for VMs, it enables you to monitor standard connectivity metrics from network connections between your Azure VMs and on-premises VMs. These metrics include response time, requests per minute, traffic throughput, and links. You can identify failed connections, troubleshoot, perform migration validation, perform security analysis, and verify the overall architecture of the service. Map can automatically discover application components on Windows and Linux systems, and map the communication between services. This helps you identify connections and dependencies you were unaware of, plan and validate migration to Azure, and minimize speculation during incident resolution.

6. Using Network Performance Monitor, monitor the network connectivity between:

   - Your corporate network and Azure.

   - Mission critical multi-tier applications and micro-services.

   - User locations and web-based applications (HTTP/HTTPs).

   This strategy delivers visibility of the network layer, without the need for SNMP. It can also present in an interactive topology map, the hop-by-hop topology of routes between the source and destination endpoint. It is a better choice than attempting to accomplish the same result with network monitoring in Operations Manager, or other network monitoring tools currently used in your environment.

### Monitor with Azure Monitor

While a migration to the cloud presents numerous challenges, it also includes a number of opportunities. It enables your organization to migrate from one or more on-premises enterprise monitoring tools to not only potentially reduce capital expenditures and operating costs, but also benefit from the advantages a cloud monitoring platform like Azure Monitor delivers at cloud-scale. Examine your monitoring and alerting requirements, configuration of existing monitoring tools, workloads transitioning to the cloud, and configure Azure Monitor once your plan is finalized. 

- Monitor the hybrid infrastructure and applications, from a simple or multi-tier architecture where components are hosted between Azure, other cloud provider, and your corporate network. This includes one or more VMs, multiple VMs placed in an availability set or virtual machine scale set, or a containerized application deployed to Azure Kubernetes Service (AKS) running on Windows Server or Linux containers. 

- Enable Azure Monitor for VMs, Azure Monitor for containers, and Application Insights to detect and diagnose issues between infrastructure and applications. For a more thorough analysis and correlation of data collected from the multiple components or dependencies supporting the application, you need to use Azure Monitor Logs.

- Create intelligent alerts that can apply to a core set of applications and service components, help reduce alert noise with dynamic thresholds for complex signals, and utilize alert aggregation based on machine learning algorithms to help quickly identify the issue.

 - Define a library of queries and dashboards to support the requirements for the different personas in the IT organization.

- Define standards and methods for enabling monitoring across the hybrid and cloud resources, a monitoring baseline for each resource, alert thresholds, etc.  

- Configure role-based access control (RBAC) so you grant users and groups only the amount of access they need to work with monitoring data from resources they are responsible for managing. 

- Include automation and self-service to enable each team to create, enable, and tune their monitoring and alerting configurations as they need. 

## Private cloud monitoring

You can achieve holistic monitoring of Azure Stack with System Center Operations Manager. Specifically, you can monitor the workloads running in the tenant, the resource level, on the virtual machines, and the infrastructure hosting Azure Stack (physical servers and network switches). You can also achieve holistic monitoring with a combination of [infrastructure monitoring capabilities](/azure/azure-stack/azure-stack-monitor-health) included in Azure Stack. These capabilities help you view health and alerts for an Azure Stack region and the [Azure Monitor service](/azure/azure-stack/user/azure-stack-metrics-azure-data) in Azure Stack, which provides base-level infrastructure metrics and logs for most services.

If you've already invested in Operations Manager, use the Azure Stack management pack to monitor the availability and health state of Azure Stack deployments. This includes regions, resource providers, updates, update runs, scale units, unit nodes, infrastructure roles, and their instances (logical entities comprised of the hardware resources). It uses the Health and Update resource provider REST APIs to communicate with Azure Stack. To monitor physical servers and storage devices, use the OEM vendors' management pack (for example, provided by Lenovo, Hewlett Packard, or Dell). Operations Manager can natively monitor the network switches to collect basic statistics by using the SNMP protocol. Monitoring the tenant workloads is possible with the Azure management pack by following two basic steps. Configure the subscription that you want to monitor, and then add the monitors for that subscription.

## Next steps

> [!div class="nextstepaction"]
> [Collecting the right data](./data-collection.md)
