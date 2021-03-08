---
title: Skills readiness for cloud monitoring
description: Skills readiness for cloud monitoring
author: BrianBlanchard
ms.author: brblanch
ms.date: 08/26/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- cSpell:ignore kusto ITIL -->

# Skills readiness for cloud monitoring

When planning your migration journey, the objective is to develop the plans necessary to guide implementation. The plans need to also include how you will operate these workloads before they are transitioned or released into production, and not afterwards. Business stakeholders expect valuable services, and they expect them without disruption. IT staff members realize they need to learn new skills and adapt so they are prepared to confidently use the integrated Azure services to effectively monitor resources in Azure and hybrid environments.

Developing the necessary skills can be accelerated with the following learning paths. They are organized starting with learning the fundamentals and then divided across three primary subject domains: infrastructure, application, and data analysis.

## Fundamentals

- Introduction to [Azure Resource Manager](/azure/azure-resource-manager/management/overview) discusses the basic concepts of management and deployment of Azure resources. The IT staff managing the monitoring experience across the enterprise should understand management scopes, Azure role-based access control (Azure RBAC), using. Azure Resource Manager templates, and management of resources using Azure CLI and Azure PowerShell.

- Introduction to [Azure Policy](/azure/governance/policy/overview) helps you learn how you can use Azure Policy to create, assign, and manage policies. Azure Policy can deploy and configure the Azure Monitor agents, enable monitoring with Azure Monitor for VMs and Azure Security Center, deploy diagnostic settings, audit guest configuration settings, and more.

- Introduction to [Azure command-line interface (CLI)](/cli/azure/get-started-with-azure-cli), which is our cross-platform command-line experience for managing Azure resources. Also review the introduction to [Azure PowerShell](/powershell/azure/). As part of their beginner-level course, [learning Azure management tools](https://www.linkedin.com/learning/learning-azure-management-tools), LinkedIn offers sessions covering Azure CLI and PowerShell programming languages:

  - [Use the Azure CLI](https://www.linkedin.com/learning/learning-azure-management-tools/use-the-azure-cli).
  - [Get started with Azure PowerShell](https://www.linkedin.com/learning/learning-azure-management-tools/understand-azure-powershell)

- Learn how to secure resources using policy, Azure role-based access control, and other Azure services by viewing [implement resource management security in Azure](/learn/paths/implement-resource-mgmt-security/).

- [Monitoring Microsoft Azure Resources and Workloads](https://www.pluralsight.com/courses/microsoft-azure-resources-workloads-monitoring-update) helps you learn how to use Azure monitoring tools to monitor Azure network resources as well as resources located on-premises.

- Learn about planning and designing your monitoring deployments at-scale and automating actions by viewing [Azure Monitor best practices and recommendations](https://www.youtube.com/watch?v=IWkqqahX_Ck&list=PLLasX02E8BPCDMuesOy2C0_TMFsoZWe_0&index=6).

## Infrastructure monitoring

- [Design a Monitoring Strategy for Infrastructure in Microsoft Azure](https://www.pluralsight.com/courses/microsoft-azure-monitoring-strategy-infrastructure-design-update) helps you learn foundational knowledge of monitoring capabilities and solutions in Azure.

- [How to monitor your Kubernetes clusters](https://www.youtube.com/watch?time_continue=3&v=RjsNmapggPU&feature=emb_logo) provides an intermediate level deep dive to help you learn about monitoring your Kubernetes cluster with Azure Monitor for containers.

- Learn with Azure Monitor how to monitor data from [Azure Storage and HDInsight](https://www.pluralsight.com/courses/microsoft-azure-data-storage-monitoring).

- [Microsoft Azure Database Monitoring Playbook](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) explores the key monitoring capabilities that can be used to gain insight and actionable steps for Azure SQL Database, Azure SQL Data Warehouse, and Azure Cosmos DB.

- [Monitoring Microsoft Azure Hybrid Cloud Networks](https://www.pluralsight.com/courses/microsoft-azure-hybrid-cloud-networks-monitoring) is an advanced-level course that helps you learn how to use Azure monitoring tools to visualize, maintain, and optimize virtual networks and virtual private network connections for your hybrid cloud implementation.

- With [Azure Arc for servers](/azure/azure-arc/servers/overview), learn how you can manage your Windows and Linux machines hosted outside of Azure similarly to how you manage virtual machines running in Azure.

- [How to monitor your VMs](https://www.youtube.com/watch?v=O7scXPrsM_0&list=PLLasX02E8BPCDMuesOy2C0_TMFsoZWe_0&index=6&t=0s) provides an intermediate level deep dive to help you learn about monitoring your hybrid machines or servers, and Azure VM or virtual machine scale sets with Azure Monitor for VMs.

## Application monitoring

- Understand how [Azure Monitor](/azure/azure-monitor/overview) helps you view availability and performance of your applications and services together from one place. Pluralsight offers the following courses to help:

  - [Microsoft Azure DevOps Engineer: Optimize Feedback Mechanisms](https://www.pluralsight.com/courses/microsoft-azure-optimize-feedback-mechanisms) helps you prepare you to use Azure Monitor, including Application Insights, to monitor and optimize your web applications.

  - [Capture and view page load times in your Azure web app](/learn/modules/capture-page-load-times-application-insights/). Get started with this course on using Azure Monitor Application Insights for end-to-end monitoring of your applications components running in Azure.

  - [Microsoft Azure Database Monitoring Playbook](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) helps you learn how to implement and use monitoring of Azure SQL Database, Azure SQL Data Warehouse, and Azure Cosmos DB.

  - [Instrument applications with Azure Monitor Application Insights](https://www.pluralsight.com/courses/microsoft-azure-application-insights-web-application-instrument) is a deep-dive course on using the Application Insights SDK to collect telemetry and events from an application with angular and Node.js components.

  - [Application Debugging and Profiling](https://www.pluralsight.com/courses/devintersection-azureai-session-31) is a recording from a Microsoft conference session on using and interpreting data provided by the Azure Monitor Application Insights snapshot debugger and profiler.

<!-- docutune:ignore "from Scratch" -->

## Data analysis

- Learn how to write [log queries in Azure Monitor](/learn/modules/analyze-infrastructure-with-azure-monitor-logs/). The Kusto Query Language is the primary resource for writing Azure Monitor log queries to explore and analyze log data between the collected data from Azure and hybrid resource application dependencies, including the live application.

- [Kusto Query Language (KQL) from Scratch](https://www.pluralsight.com/courses/kusto-query-language-kql-from-scratch) is a comprehensive course that includes detailed examples covering a wide range of use-cases and techniques for log analysis in Azure Monitor Logs.

## Deeper skills exploration

Various learning options beyond these initial options are available for developing skills.

### Typical mappings of cloud IT roles

Microsoft and partners offer various options for all audiences to develop skills with Azure services.

- [Map roles and skills](../../plan/suggested-skills.md): A resource for mapping your cloud career path. Learn about your cloud role and suggested skills. Follow a learning curriculum at your own pace to build the skills that you need most to stay relevant.

- Explore [Azure certification training and exams](/learn/certifications/) to gain official recognition for your Azure knowledge.

## Azure DevOps and project management

The hybrid cloud environment disrupts IT with undefined roles, responsibilities, and activities. Organizations must move to modern practices to manage services, including agile and DevOps methodologies, to better meet the transformation and optimization needs of today's businesses in a streamlined and efficient manner.

As part of migrating to a cloud monitoring platform, the IT team responsible for managing monitoring in the enterprise needs to include agile training and participation in DevOps activities. This also includes following the *Dev* in DevOps by taking requirements and turning into organized agile requirements, in order to deliver minimally viable monitoring solutions that are refined iteratively and in line with business needs. For source control to manage the iterative monitoring solution packages and any other related collateral, connect your Azure DevOps Server project with a GitHub Enterprise Server repository. This provides a link from commits and pull requests in GitHub to work items. You can use GitHub Enterprise for development in support of continuous monitoring integration and deployment, while using Azure Boards to plan and track your work.

To learn more, review the following:

- [Get started with Azure DevOps](/learn/modules/get-started-with-devops/).

- [Learn about DevOps Dojo white belt foundation](/learn/paths/devops-dojo-white-belt-foundation/).

- [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices/).

- [Automate your deployments with Azure DevOps](/learn/paths/automate-deployments-azure-devops/).

## Other considerations

Customers often struggle to manage, maintain, and deliver the expected business (and to the IT organization) outcomes for the services that IT is charged with delivering. Monitoring is considered core to managing infrastructure and the business, with a focus on measuring quality of service and customer experience. In order to achieve those goals, lay the groundwork using ITSM in conjunction with DevOps, which will help the monitoring team mature how they manage, deliver, and support the monitoring service. Adopting an ITSM framework allows the monitoring team to function as a provider and gain recognition as a trusted business enabler by aligning to the strategic goals and needs of the organization.

<!-- docutune:casing "ITIL 4 and the Cloud" -->

Review the following to understand the updates made to the most popular ITSM framework [ITIL 4 and the Cloud white paper](https://www.axelos.com/case-studies-and-white-papers/itil-4-and-the-cloud), which focuses on joining existing ITIL guidance with best practices from DevOps, agile, and lean approaches. Also consider the [IT4IT reference architecture](https://www.opengroup.org/it4it) that delivers an alternative blueprint on how to transform IT using a process agnostic framework.

## Learn more

To discover more learning paths, browse the [Microsoft Learn catalog](/learn/browse/). Use the roles filter to align learning paths with your role.
