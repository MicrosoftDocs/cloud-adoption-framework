---
title: Skills readiness for cloud monitoring
description: Skills readiness for cloud monitoring
author: BrianBlanchard
ms.author: brblanch
ms.reviewer: tozimmergren
ms.date: 11/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal, engagement-fy23
---

# Skills readiness for cloud monitoring

The objective of planning your migration journey is to develop the plans necessary to guide implementation. The plans also need to include how you'll operate these workloads before they're transitioned or released into production, as opposed to afterward. Business stakeholders expect valuable services, and they expect them without disruption. IT staff members realize they need to learn new skills and adapt. Hence, they're prepared to confidently use the integrated Azure services to monitor resources effectively in Azure and hybrid environments.

Developing the necessary skills can be accelerated with the following learning paths. They're organized starting with learning the fundamentals and then divided across three primary subject domains: infrastructure, application, and data analysis.

## Fundamentals

- Introduction to [Azure Resource Manager](/azure/azure-resource-manager/management/overview) discusses the basic concepts of management and deployment of Azure resources. The IT staff managing the monitoring experience across the enterprise should understand management scopes, Azure role-based access control (Azure RBAC), using Azure Resource Manager (ARM) templates, and managing resources using Azure CLI and Azure PowerShell.

- Introduction to [Azure Policy](/azure/governance/policy/overview) helps you learn how to use Azure Policy to create, assign, and manage policies. Azure Policy can deploy and configure the Azure Monitor agents, enable monitoring with Azure Monitor for VMs and Microsoft Defender for Cloud, deploy diagnostic settings, audit guest configuration settings, and more.

- Introduction to [Azure CLI](/cli/azure/get-started-with-azure-cli), our cross-platform command-line experience for managing Azure resources. Also, review the introduction to [Azure PowerShell](/powershell/azure/get-started-azureps). Extend your skills with the Azure CLI and Azure PowerShell further by taking these Microsoft Learn courses:
  - [Control Azure services with the CLI](/training/modules/control-azure-services-with-cli/) and [Create Azure resources by using Azure CLI](/training/modules/create-azure-resources-by-using-azure-cli/).
  - [Review Azure PowerShell module](/training/modules/review-azure-powershell-module/) and [Manage Azure resources with Windows PowerShell](/training/modules/manage-azure-resources-windows-powershell/).

- Learn how to secure resources using policy, Azure role-based access control, and other Azure services by viewing [implement resource management security in Azure](/training/paths/implement-resource-mgmt-security/).

- [Monitor the usage, performance, and availability of resources with Azure Monitor](/training/paths/monitor-usage-performance-availability-resources-azure-monitor/) is a Microsoft Learn path walking you through how to monitor the usage, performance, and availability of resources using Azure Monitor.

- Learn about planning and designing your monitoring deployments at scale and automating actions by viewing [Azure Monitor best practices and recommendations](https://www.youtube.com/watch?list=PLLasX02E8BPCDMuesOy2C0_TMFsoZWe_0&index=6&v=IWkqqahX_Ck).

- Review the [Azure Monitor best practices - Planning your monitoring strategy and configuration](/azure/azure-monitor/best-practices-plan) documentation to strengthen your understanding of designing Azure Monitor strategies.

## Infrastructure monitoring

- The Microsoft Learn module [Design a holistic monitoring strategy on Azure](/training/modules/design-monitoring-strategy-on-azure/) teaches you to use monitoring services on Azure to bring operational excellence to your applications and infrastructure.

- For a larger scope of instrumentation, you can take the Microsoft Learn Path [Develop an instrumentation strategy](/training/paths/az-400-develop-instrumentation-strategy/), which teaches you about logging, telemetry, and monitoring to give you full visibility into what's happening in your environment.

- In the [Instrument a cloud-native ASP.NET Core microservice](/training/modules/microservices-logging-aspnet-core/) Microsoft Learn module, you'll learn how to instrument your cloud-native ASP.NET Core microservice apps to diagnose problems and monitor performance. This module includes how to enable Azure Monitor for Containers in a Kubernetes cluster.

- Learn how to [Analyze your Azure infrastructure by using Azure Monitor logs](/training/modules/analyze-infrastructure-with-azure-monitor-logs). This Microsoft Learn module walks you through using Azure Monitor logs to extract valuable information about your infrastructure from log data.

- Review the documentation on [Monitoring your storage service with Azure Monitor Storage insights](/azure/storage/common/storage-insights-overview).

- [`Microsoft Azure Database Monitoring Playbook`](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) explores the key monitoring capabilities used to gain insight and actionable steps for Azure SQL Database, Azure SQL Data Warehouse, and Azure Cosmos DB.

- [`Monitoring Microsoft Azure Hybrid Cloud Networks`](https://www.pluralsight.com/courses/microsoft-azure-hybrid-cloud-networks-monitoring) is an advanced-level course helps you learn how to use Azure monitoring tools to visualize, maintain, and optimize virtual networks and virtual private network connections for your hybrid cloud implementation.

- With [Azure Arc for servers](/azure/azure-arc/servers/overview), learn how you can manage your Windows and Linux machines hosted outside of Azure similarly to how you manage virtual machines running in Azure.

- Read the [overview of VM insights](/azure/azure-monitor/vm/vminsights-overview) to learn how to monitor the performance and health of your virtual machines and Virtual Machine Scale Sets.

## Application monitoring

- Understand how [Azure Monitor](/azure/azure-monitor/overview) helps you view the availability and performance of your applications and services together from one place. The following courses can help:

- The Microsoft Learn module [Monitor the health and performance of your web apps](/training/modules/monitor-health-performance-of-your-web-applications/) teaches you how to monitor your solution for performance and issues using Application Insights.

- Learn to [Instrument server-side web application code with Application Insights](/training/modules/instrument-web-app-code-with-application-insights/) with Microsoft Learn.

- [Capture and view page load times in your Azure web app](/training/modules/capture-page-load-times-application-insights/). Get started with this course on using Azure Monitor Application Insights for end-to-end monitoring of your application's components running in Azure.

- [`Microsoft Azure Database Monitoring Playbook`](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) helps you learn how to implement and use the monitoring of Azure SQL Database, Azure SQL Data Warehouse, and Azure Cosmos DB.

- Learn more about the [Application Insights Snapshot Debugger](/azure/azure-monitor/snapshot-debugger/snapshot-debugger) to automatically collect a debug snapshot from your live web applications. Further, learn how to use the [Application Insights Profiler](/azure/azure-monitor/profiler/profiler-overview) to capture and view performance traces for apps running in the cloud.

## Data analysis

While collecting data is a foundational piece of any environment operating in the cloud, analyzing that information is imperative to understand more about the health of your workloads and infrastructure. Review the following resources to dive in and analyze logs using Kusto Query Language (KQL).

- Learn how to [write your first query with Kusto Query Language](/training/modules/write-first-query-kusto-query-language/). This module gets you started by writing simple queries in KQL to explore and gain insights from your data.

- Explore how to write more advanced queries in KQL with the Learn Module [Gain insights from your data by using Kusto Query Language](/training/modules/gain-insights-data-kusto-query-language/).

- The Microsoft Learn module [Write multi-table queries by using Kusto Query Language](/training/modules/multi-table-queries-with-kusto-query-language/) teaches you how to retrieve data from multiple tables in a single query.

- Expand your learning with the [guided project - Analyze logs in Azure Monitor with KQL](/training/modules/analyze-logs-with-kql/) learn module to understand how to write log queries to find answers to operational and business questions. Further, this module will teach you to use KQL to extract insights from logs in Azure Monitor.

## Deeper skills exploration

Various learning options beyond these initial options are available for developing skills.

### Typical mappings of cloud IT roles

Microsoft and its partners offer various options for all audiences to develop skills with Azure services.

- [Map roles and skills](../../plan/suggested-skills.md): A resource for mapping your cloud career path. Learn about your cloud role and suggested skills. Follow a learning curriculum at your own pace to build the skills you need most to stay relevant.

- Explore [Azure certification training and exams](/certifications/) to gain official recognition for your Azure knowledge.

## Azure DevOps and project management

The hybrid cloud environment disrupts IT with undefined roles, responsibilities, and activities. Organizations must move to modern practices to manage services, including agile and DevOps methodologies, to better meet the transformation and optimization needs of today's businesses in a streamlined and efficient manner.

As part of migrating to a cloud monitoring platform, the IT team responsible for monitoring the enterprise needs to include agile training and participation in DevOps activities. This also includes following the *Dev* in DevOps by taking requirements and turning them into organized agile requirements to deliver minimally viable monitoring solutions refined iteratively and in line with business needs. Connect your Azure DevOps Server project with a GitHub Enterprise Server repository for source control to manage the iterative monitoring solution packages and any other related collateral. This links commits and pull requests in GitHub to work items. You can use GitHub Enterprise for development to support continuous monitoring integration and deployment while using Azure Boards to plan and track your work.

To learn more, review the following:

- [Get started with Azure DevOps](/training/modules/get-started-with-devops/).

- [Introduce DevOps Dojo: Create efficiencies that support your business](/training/paths/devops-dojo-white-belt-foundation/).

- [Evolve your DevOps practices](/training/paths/evolve-your-devops-practices/).

- [Automate your deployments with Azure DevOps](/training/modules/deploy-nodejs/).

## Other considerations

Customers often need help with managing, maintaining, and delivering the expected business (and to the IT organization) outcomes for the services that IT provides. Monitoring is considered core to managing infrastructure and the business, focusing on measuring service quality and customer experience. To achieve those goals, lay the groundwork using ITSM in conjunction with DevOps, which will help the monitoring team mature how they manage, deliver, and support the monitoring service. Adopting an ITSM framework allows the monitoring team to function as a provider and gain recognition as a trusted business enabler by aligning with the strategic goals and needs of the organization.

Review the following to understand the updates made to the most popular ITSM framework [`ITIL 4 and the Cloud` white paper](https://www.axelos.com/case-studies-and-white-papers/itil-4-and-the-cloud), which focuses on joining existing ITIL guidance with best practices from DevOps, agile and lean approaches. Also, consider the [IT4IT reference architecture](https://www.opengroup.org/it4it) that delivers an alternative blueprint for transforming IT using a process-agnostic framework.

## Learn more

To discover more learning paths, browse the [Microsoft Learn training catalog](/training/browse/). Use the roles filter to align learning paths with your role.
