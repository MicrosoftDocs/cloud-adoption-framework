---
title: "Skills readiness for cloud monitoring"
description: Skills readiness for cloud monitoring
author: BrianBlanchard
ms.author: magoedte
ms.date: 05/18/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore kusto ITIL -->

# Skills readiness for cloud monitoring

During the Plan phase of your migration journey, the objective is to develop the plans necessary to guide implementation. The plans need to also include how you will operate these workloads before they are transitioned or released into production, and not afterwards. Business stakeholders expect valuable services, and they expect them without disruption. IT staff members realize they need to learn new skills and adapt so they are prepared to confidently use the integrated Azure services to effectively monitor resources in Azure and hybrid environments.

Developing the necessary skills can be accelerated with the following learning paths. They are organized by starting with the learning fundamentals and then mapping of skills to three subject domains - infrastructure, application, and data analysis.  


## Fundamentals

- Introduction to [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/management/overview) discusses the basic concepts of management and deployment of Azure resources. The IT staff managing the monitoring experience across the enterprise should understand management scopes, role-based access control (RBAC), using. Azure Resource Manager templates, and management of resources using Azure CLI and Azure PowerShell.

- Introduction to [Azure Policy](https://docs.microsoft.com/azure/governance/policy/overview) helps you learn how you can use Azure Policy to create, assign, and manage policies. Azure Policy can deploy and configure the Azure Monitor agents, enable monitoring with Azure Monitor for VMs and Azure Security Center, deploy Diagnostic Settings, audit guest configuration settings, and more.

- Introduction to [Azure command-line interface (CLI)](https://docs.microsoft.com/cli/azure/get-started-with-azure-cli?view=azure-cli-latest), which is our cross-platform command-line experience for managing Azure resources. Also review, introduction to [Azure PowerShell](https://docs.microsoft.com/powershell/azure/?view=azps-3.6.1). LinkedIn offers, as part of their beginner-level course [Learning Azure Management Tools](https://www.linkedin.com/learning/learning-azure-management-tools), sessions covering Azure CLI and PowerShell programming languages:

  - [Use the Azure CLI](https://www.linkedin.com/learning/learning-azure-management-tools/use-the-azure-cli).
  - [Get started with Azure PowerShell](https://www.linkedin.com/learning/learning-azure-management-tools/understand-azure-powershell)

- Learn how to secure resources using policy, role-based access control, and other Azure services by viewing [Implement resource management security in Azure](https://docs.microsoft.com/learn/paths/implement-resource-mgmt-security).

- Introduction to [Monitoring Microsoft Azure Resources and Workloads](https://app.pluralsight.com/library/courses/microsoft-azure-resources-workloads-monitoring-update/table-of-contents) helps you learn how to use Microsoft Azure monitoring tools to monitor Azure network resources as well as resources on-premises.

## Infrastructure monitoring

- [Design a Monitoring Strategy for Infrastructure in Microsoft Azure](https://www.pluralsight.com/courses/microsoft-azure-monitoring-strategy-infrastructure-design-update) helps you learn foundational knowledge of monitoring capabilities and solutions in Azure. 

- [How to monitor your Kubernetes clusters](https://www.youtube.com/watch?time_continue=3&v=RjsNmapggPU&feature=emb_logo) provides an intermediate level deep dive to help you learn about monitoring your Kubernetes cluster with Azure Monitor for containers.

- Learn with Azure Monitor how to monitor data from Azure [Storage and HDInsight](https://www.pluralsight.com/courses/microsoft-azure-data-storage-monitoring).

- [Microsoft Azure Database Monitoring Playbook](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) explores the key monitoring capabilities that can be used to gain insight and actionable steps for Azure SQL Database, Azure SQL Datawarehouse, and Azure Cosmos DB.

- [Monitoring Microsoft Azure Hybrid Cloud Networks](https://www.pluralsight.com/courses/microsoft-azure-hybrid-cloud-networks-monitoring) helps you learn how to use Azure monitoring tools to visualize, maintain, and optimize Azure virtual networks and virtual private network connections for your hybrid cloud implementation.

- With [Azure Arc for servers](https://docs.microsoft.com/azure/azure-arc/servers/overview), learn how you can manage your Windows and Linux machines hosted outside of Azure similarly to how you manage native Azure virtual machines.


## Application monitoring

- Understand how [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview) helps you view availability and performance of your applications and services together from one place. Pluralsight offers the following courses to help:

  - [Microsoft Azure DevOps Engineer: Optimize Feedback Mechanisms](https://www.pluralsight.com/courses/microsoft-azure-optimize-feedback-mechanisms) helps you prepare you to use Azure Monitor, including Application Insights and Log Analytics to monitor and optimize your web applications.

  - [Microsoft Azure Database Monitoring Playbook](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) helps you learn how to implement and use monitoring of Azure SQL Database, Azure SQL Data Warehouse, and Azure Cosmos DB.

  - [Instrument Applications with Azure Monitor Application Insights](https://app.pluralsight.com/library/courses/microsoft-azure-application-insights-web-application-instrument) is a deep-dive course on using the Application Insights SDK to collect telemetry and events from an app with Angular and Node.js components.

## Data analysis

- Learn how to write [log queries in Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/log-query/get-started-queries). The Kusto query language is the primary resource for writing Azure Monitor log queries to explore and analyze log data between the collected data from Azure and hybrid resource application dependencies, including the live application.


## Deeper skills exploration

Beyond these initial options for developing skills, there are a variety of learning options available.

### Typical mappings of cloud IT roles

Microsoft and partners offer a variety of options for all audiences to develop their skills with Azure services:

- [Microsoft IT Pro Career Center](https://www.microsoft.com/itpro): Serves as a free online resource to help map your cloud career path. Learn what industry experts suggest for your cloud role and the skills to get you there. Follow a learning curriculum at your own pace to build the skills you need most to stay relevant.

Turn your knowledge of Azure into official recognition with [Microsoft Azure certification training and exams]( https://www.microsoft.com/learning/certification-overview.aspx).

## Azure DevOps and Project Management

The hybrid cloud environment disrupts IT with undefined roles, responsibilities, and activities. Organizations must move to modern service management practices, including Agile and DevOps methodologies, to better meet the transformation and optimization needs of today's businesses in a streamlined and efficient manner.

As part of migrating to a cloud monitoring platform, the IT team responsible for managing monitoring in the enterprise need to include agile training and participation in DevOps activities. This also includes following the _Dev_ in DevOps by taking requirements and turning into organized agile requirements, in order to deliver minimally viable monitoring solutions that are refined iteratively and in line with business needs. For source control to manage the iterative monitoring solution packages and any other related collateral, connect your Azure DevOps Server project with a GitHub Enterprise Server repository. This provides a link between GitHub commits and pull requests to work items. You can use GitHub Enterprise for development in support of continuous monitoring integration and deployment, while using Azure Boards to plan and track your work.

To learn more, review the following:

- [Get started with Azure DevOps](https://docs.microsoft.com/learn/modules/get-started-with-devops).

- [Learn about DevOps dojo white belt foundation](https://docs.microsoft.com/learn/paths/devops-dojo-white-belt-foundation)

- [Evolve your DevOps practices](https://docs.microsoft.com/learn/paths/evolve-your-devops-practices)

- [Automate your deployments with Azure DevOps](https://docs.microsoft.com/learn/paths/automate-deployments-azure-devops)

## Other Considerations

Customers often struggle to manage, maintain, and deliver the expected business (and to the IT organization) outcomes for the services that IT is charged with delivering. Monitoring is considered core to managing infrastructure and the business, with a focus on measuring quality of service and customer experience. In order to achieve those goals, lay the groundwork using ITSM in conjunction with DevOps, which will help the monitoring team mature how they manage, deliver, and support the monitoring service. Adopting an ITSM framework allows the monitoring team to function as a provider and gain recognition as a trusted business enabler by aligning to the strategic goals and needs of the organization.

Review the following to understand the updates made to the most popular ITSM framework [ITIL v4 and Cloud Computing whitepaper](https://www.axelos.com/case-studies-and-white-papers/itil-4-and-the-cloud), which focuses on joining existing ITIL guidance with best practices from DevOps, Agile, and Lean. Also consider the [IT4IT reference architecture](https://www.opengroup.org/it4it) that delivers an alternative blueprint on how to transform IT using a process agnostic framework.

## Learn more

To discover additional learning paths, browse the [Microsoft Learn catalog](https://docs.microsoft.com/learn/browse). Use the Roles filter to align learning paths with your role.
