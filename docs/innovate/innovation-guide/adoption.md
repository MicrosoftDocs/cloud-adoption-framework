---
title: "Azure innovation guide: Shared solutions and feedback loops" 
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Azure innovation guide - Shared solutions and feedback loops
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

# Azure innovation guide: Empower adoption through feedback loops

User adoption, engagement and retention is key to successful innovation. Why?

Building an innovative new solution is not about giving the user what they want or think they want. It's about the formulation of a hypothesis which can be tested and improved upon. That testing comes in two forms: Quantitative (testing feedback) which means the actions we hope to see. Qualitative (customer feedback) which tell us what those metrics mean in the customer's voice. Together they inform the next hypothesis and the next improvement to the solution. These feedback loops are the foundation of the [Build-Measure-Learn process](../considerations/adoption.md) at the core of this methodology.

Before integrating feedback loops, a shared repository for your solution is a must-have requirement. A centralized repo will provide a way to record and act on all of the feedback coming in about your project.  [GitHub](https://github.com/) is the home for open source software. It also one of the most commonly used platforms for hosting the source code repository for commercially developed applications. The article on [building GitHub repositories](https://docs.microsoft.com/en-us/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml) can help get you started with your repo.

Each of the following tools in Azure integrate with (or is compatible with) projects hosted in GitHub:

## [Quantitative feedback for web apps](#tab/Quantitative-Apps)

Application Insights is a monitoring tool that allows for near-real time quantitative feedback on the usage of your application. This feedback can help test and validate your current hypothesis to shape the next feature or user story on your backlog.

### Action

To view quantitative data on your applications:

1. Go to **App Insights**.
2. If your application doesn't appear in the list, click the **Add +** link and follow the prompts to start configuring App Insights.
3. If the desired App is on the list, select the application.
4. The **Overview** pane includes some statistics on the application. The **Application Dashboard** link will allow you to build a custom dashboard to see data that is more relevant to your hypothesis.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/microsoft.insights%2Fcomponents]" submitText="Go to App Insights" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To view your data regarding your apps, go to the [Azure portal](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/microsoft.insights%2Fcomponents).

::: zone-end

### Learn More

- [Set up Azure Monitor](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-monitor-portal)
- [Get started with Azure Monitor App Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-users)
- [Build a telemitry dashboard](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-app-dashboards)

## [Quantitative feedback for APIs](#tab/Quantitative-APIs)

Connected economy is changing the way businesses innovate.  Markets and industries are being disrupted faster than ever. Disruption takes many forms and businesses must grapple with the **‘innovator’s dilemma’**: how to set the pace of change without stumbling over ongoing business activity. 

Enterprises are using APIs externally to change how they interact with customers and their partners. Internally they are using API’s to seamlessly connect distinct parts of the business. API economy operates on four building blocks: social, mobile, analytics and cloud. Apps and services can be linked rapidly and cost-effectively to create an extended value proposition.

### Action

To record quantitative data on your APIs:

1. Go to **API Management Service**.
2. Select the desired API from the list.
3. Choose **Diagnostic Settings** from the **Monitoring** section.

To view quantitative data on your APIs:

1. Go to **API Management Service**.
2. Select the desired API from the list.
3. Choose **Application** from the **Monitoring** section.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ApiManagement%2Fservice]" submitText="Go to App Service" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To open API Management Service, go to the [Azure portal](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ApiManagement%2Fservice).

::: zone-end

### Learn More

This article can help you use [Azure Monitor to get feedback on APIs](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-use-azure-monitor)

## [Qualitative feedback](#tab/Qualitative)

The backlog (or board) is where feedback is recorded as user stories. It is also where the related work is tracked as actionable tasks. Azure Boards can be directly integrated into GitHub, allowing for a seamless experience between feedback-work management and any source code.

### Action

Azure Board and Azure Pipelines require a separate portal from GitHub and Azure.
To get started with either tool, go to [Azure DevOps](https://dev.azure.com/)

### Learn More

The following links will help centralize and manage feedback using Azure Boards in conjunction with GitHub:

- [Get started with Azure Boards](https://docs.microsoft.com/en-us/azure/devops/boards/boards/kanban-quickstart?view=azure-devops)
- [Azure Boards & GitHub](https://docs.microsoft.com/en-us/azure/devops/boards/boards/kanban-quickstart?view=azure-devops)

## [Close the loop with pipelines](#tab/pipelines)

Acting on the feedback may not always result in the feature requested by the customer. But, every data point should result in some change. That change may be in how you think about things. It may also be an entirely different technical change than was requested. Either way, deployment pipelines and tools like Azure Pipelines allow you to quick publish those changes, so they can be shared with the customer frequently.

To see any active deployments related to your applications hosted in Azure:

### Action

To view current deployments in your pipeline:

1. Go to **App Service**.
2. Select the desired application from the list.
3. Choose **Deployment Center** from the **Deployment** section of the app services pane.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2Fsites]" submitText="Go to App Service" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To view your applications in App Service, go to the [Azure portal](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2Fsites).

::: zone-end

### Learn More

The following are addition links to start building out your deployment pipelines:

- [Create your first pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline?view=azure-devops&tabs=tfs-2018-2)
- [GitHub Release Tasks](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/github-release?view=azure-devops)
