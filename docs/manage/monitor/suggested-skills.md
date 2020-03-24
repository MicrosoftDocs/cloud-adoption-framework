---
title: "Skills readiness for cloud monitoring"
description: Skills readiness for cloud monitoring
author: BrianBlanchard
ms.author: mgoedtel
ms.date: 03/23/2020
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Skills readiness for cloud monitoring

During the Plan phase of your migration journey, the objective is to develop the plans necessary to guide implementation. The plans need to also include how you will operate these workloads before they are transitioned or released into production, and not afterwards. Business stakeholders expect valuable services — and they expect them without disruption. IT staff members realize they need to learn new skills and adapt so they are prepared to confidently leverage the integrated Azure services to effectively monitor resources in Azure and hybrid environments. 

Developing the necessary skills can be accelerated with the following learning paths:

- Introduction to [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/management/overview): discusses the basic concepts of management and deployment of Azure resources. The IT staff managing the monitoring experience across the enterprise should understand management scopes, role-based access control (RBAC), using. Azure Resource Manager templates, and management of resources using Azure CLI and Azure PowerShell.

- Learn how to secure resources using policy, role-based access control, and other Azure services by viewing [Implement resource management security in Azure](https://docs.microsoft.com//learn/paths/implement-resource-mgmt-security/). 

- Introduction to [Azure Policy](https://docs.microsoft.com/azure/governance/policy/overview): learn how you can use Azure Policy to create, assign, and manage policies to deploy and configure the Azure Monitor agents, enable monitoring with Azure Monitor for VMs and Azure Security Center, deploy Diagnostic Settings, audit guest configuration settings, and more. 

- Introduction to [Azure command-line interface](https://docs.microsoft.com/cli/azure/get-started-with-azure-cli?view=azure-cli-latest) (CLI), which is our cross-platform command-line experience for managing Azure resources. Also review, introduction to [Azure PowerShell](https://docs.microsoft.com/powershell/azure/?view=azps-3.6.1). LinkedIn offers as part of their beginner-level course [Learning Azure Management Tools], are sessions covering Azure CLI and PowerShell programming languages:

   - [Use the Azure CLI](https://www.linkedin.com/learning/learning-azure-management-tools/use-the-azure-cli).
   
   - [Getting started with Azure PowerShell](https://www.linkedin.com/learning/learning-azure-management-tools/understand-azure-powershell) 

- Learn how to write [log queries in Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/log-query/get-started-queries).  The Kusto query language is the primary resource for writing Azure Monitor log queries to explore and analyze log data between the collected data from Azure and hybrid resource application dependencies, including the live application.

- Understand how [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/overview) helps you view availability and performance of your applications and services together from one place. Pluralsight offers the following courses to help:

   - [Microsoft Azure IaaS Monitoring and Management](https://www.pluralsight.com/courses/azure-iaas-monitoring-management-getting-started) helps you learn how to use Azure Monitor to perform basic monitoring of workloads running on IaaS.

   - [Monitoring Microsoft Azure Resources and Workloads](https://www.pluralsight.com/courses/microsoft-azure-resources-workloads-monitoring) helps you learn how to use Microsoft Azure monitoring tools to monitor Azure network (as well as on-prem) resources.

   - [Microsoft Azure DevOps Engineer: Optimize Feedback Mechanisms](https://www.pluralsight.com/courses/microsoft-azure-optimize-feedback-mechanisms) helps you prepare you to use Azure Monitor, including Application Insights and Log Analytics to monitor and optimize your web applications.

   - [Microsoft Azure Database Monitoring Playbook](https://www.pluralsight.com/courses/microsoft-azure-database-playbook-monitoring) helps you learn how to implement and use monitoring of Azure SQL Database, Azure SQL Datawarehouse, and Azure Cosmos DB.

- With [Azure Arc for servers](https://docs.microsoft.com/azure/azure-arc/servers/overview), learn how you can manage your Windows and Linux machines hosted outside of Azure similarly to how you manage native Azure virtual machines.

## Deeper skills exploration

Beyond these initial options for developing skills, there are a variety of learning options available.

Typical mappings of cloud IT roles

Microsoft and partners offer a variety of options for all audiences to develop their skills with Azure services:

- [Microsoft IT Pro Career Center](https://www.microsoft.com/itpro): Serves as a free online resource to help map your cloud career path. Learn what industry experts suggest for your cloud role and the skills to get you there. Follow a learning curriculum at your own pace to build the skills you need most to stay relevant.

Turn your knowledge of Azure into official recognition with [Microsoft Azure certification training and exams]( https://www.microsoft.com/learning/azure-certification.aspx).

## Azure DevOps and Project Management

The hybrid cloud environment disrupts IT with undefined roles, responsibilities, and activities. Organizations must move to modern service management practices, including Agile and DevOps methodologies, to better meet the transformation and optimization needs of today's businesses in a streamlined and efficient manner. 

As part of migrating to a cloud monitoring platform, the IT team responsible for managing monitoring in the enterprise need to include agile training and participation in DevOps activities. This also includes following the *Dev* in DevOps by taking requirements and turning into organized agile requirements, in order to deliver minimally viable monitoring solutions that are refined iteratively and in line with business needs. For source control to manage the iterative monitoring solution packages and any other related collateral, connect your Azure DevOps Server project with a GitHub Enterprise Server repository. This provides a link between GitHub commits and pull requests to work items. You can use GitHub Enterprise for development in support of continuous monitoring integration and deployment, while using Azure Boards to plan and track your work.

To learn more, review the following:

- [Get started with Azure DevOps](https://docs.microsoft.com/learn/modules/get-started-with-devops/). 

- [Learn about DevOps dojo white belt foundation](https://docs.microsoft.com/learn/paths/devops-dojo-white-belt-foundation/)

- [Evolve your DevOps practices](https://docs.microsoft.com/learn/paths/evolve-your-devops-practices/)

- [Automate your deployments with Azure DevOps](https://docs.microsoft.com/learn/paths/automate-deployments-azure-devops/)

## Other Considerations

Customers often struggle to manage, maintain, and deliver the expected business (and to the IT organization) outcomes for the services that IT is charged with delivering. Monitoring is considered core to managing infrastructure and the business, with a focus on measuring quality of service and customer experience.  In order to achieve those goals, lay the groundwork using ITSM in conjunction with DevOps, which will help the monitoring team mature how they manage, deliver, and support the monitoring service. Adopting an ITSM framework allows the monitoring team to function as a provider and gain recognition as a trusted business enabler by aligning to the strategic goals and needs of the organization.

Review the following to understand the updates made to the most popular ITSM framework [ITIL v4 and Cloud Computing whitepaper](https://www.axelos.com/case-studies-and-white-papers/itil-4-and-the-cloud), which focuses on joining existing ITIL guidance with best practices from DevOps, Agile, and Lean. Also consider the [IT4IT reference architecture](https://www.opengroup.org/it4it) that delivers an alternative blueprint on how to transform IT using a process agnostic framework.
