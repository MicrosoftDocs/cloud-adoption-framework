---
title: "Azure innovation: Prepare for feedback"
description: Learn how to use Azure tools to collect quantitative and qualitative feedback on web apps and APIs hosted in GitHub.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

::: zone target="docs"

# Azure innovation guide: Prepare for customer feedback

::: zone-end

::: zone target="chromeless"

# Prepare for customer feedback

::: zone-end

User adoption, engagement, and retention are key to successful innovation. Why?

Building an innovative new solution isn't about giving users what they want or think they want. It's about the formulation of a hypothesis that can be tested and improved upon. That testing comes in two forms:

- **Quantitative (testing feedback):** This feedback measures the actions we hope to see.
- **Qualitative (customer feedback):** This feedback tells us what those metrics mean in the customer's voice.

Before you integrate feedback loops, you need to have a shared repository for your solution. A centralized repo will provide a way to record and act on all the feedback coming in about your project. [GitHub](https://github.com) is the home for open source software. It's also one of the most commonly used platforms for hosting source code repositories for commercially developed applications. The article on [building GitHub repositories](https://docs.microsoft.com/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml) can help you get started with your repo.

Each of the following tools in Azure integrates with (or is compatible with) projects hosted in GitHub:

## [Quantitative feedback for web apps](#tab/Quantitative-Apps)

Application Insights is a monitoring tool that provides near-real-time quantitative feedback on the usage of your application. This feedback can help you test and validate your current hypothesis to shape the next feature or user story in your backlog.

### Action

To view quantitative data on your applications:

1. Go to **Application Insights**.
   - If your application doesn't appear in the list, select **Add** and follow the prompts to start configuring Application Insights.
   - If the desired application is in the list, select the application.
1. The **Overview** pane includes some statistics on the application. Select **Application Dashboard** to build a custom dashboard for data that's more relevant to your hypothesis.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Insights%2FComponents]" submitText="Go to Application Insights" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To view the data about your applications, go to the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Insights%2FComponents).

::: zone-end

### Learn more

- [Set up Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/learn/quick-monitor-portal)
- [Get started with Azure Monitor Application Insights](https://docs.microsoft.com/azure/azure-monitor/learn/tutorial-users)
- [Build a telemetry dashboard](https://docs.microsoft.com/azure/azure-monitor/learn/tutorial-app-dashboards)

## [Quantitative feedback for APIs](#tab/Quantitative-APIs)

The connected economy is changing the way businesses innovate. Markets and industries are being disrupted faster than ever. Disruption takes many forms and businesses must grapple with the _innovator's dilemma_: how to set the pace of change without stumbling over ongoing business activity.

Enterprises are using APIs externally to change how they interact with their customers and partners. Internally, they're using APIs to seamlessly connect distinct parts of the business. API economy operates on four building blocks: social, mobile, analytics, and cloud. Applications and services can be linked rapidly and cost-effectively to create an extended value proposition.

<!-- markdownlint-disable MD024 -->

### Action

To record quantitative data on your APIs:

1. Go to **API Management services**.
2. Select the desired API from the list.
3. Select **Diagnostic Settings** in the **Monitoring** section.

To view quantitative data on your APIs:

1. Go to **API Management services**.
2. Select the desired API from the list.
3. Select **Application** in the **Monitoring** section.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ApiManagement%2FService]" submitText="Go to API Management services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To open API Management services, go to the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.ApiManagement%2FService).

::: zone-end

### Learn more

- [Use Azure Monitor to get feedback on APIs](https://docs.microsoft.com/azure/api-management/api-management-howto-use-azure-monitor)

## [Qualitative feedback](#tab/Qualitative)

The backlog (or board) is where feedback is recorded as user stories. It's also where the related work is tracked as actionable tasks. Azure Boards can be directly integrated into GitHub, allowing a seamless experience between feedback-work management and any source code.

::: zone target="docs"

### Action

Azure Boards and Azure Pipelines require a portal that's separate from GitHub and Azure. Get started using [Azure DevOps Services](https://azure.microsoft.com/services/devops).

::: zone-end

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

### Action

To create a DevOps project:

1. Go to **Azure DevOps Projects**.
2. Select **Create DevOps project**.
3. Select **Runtime, Framework, and Service**.

::: form action="OpenBlade[#blade/HubsExtension/BrowseResource/resourceType/Microsoft.VisualStudio%2FAccount%2FProject]" submitText="Go to Azure DevOps Projects" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

### Learn more

These articles will help you centralize and manage feedback by using Azure Boards together with GitHub:

- [Get started with Azure Boards](https://docs.microsoft.com/azure/devops/boards/get-started/?view=azure-devops)
- [Azure Boards and GitHub](https://docs.microsoft.com/azure/devops/boards/github?view=azure-devops)

## [Close the loop with pipelines](#tab/pipelines)

Acting on feedback might not always mean adding the feature requested by the customer. But every data point should result in some change. That change might be a change in how you think about things. It might also be an entirely different technical change from the one requested. Either way, deployment pipelines and tools like Azure Pipelines allow you to quickly publish those changes so they can be shared with the customer frequently.

### Action

To view current deployments in your pipeline:

1. Go to **App Services**.
2. Select the desired application from the list.
3. Select **Deployment Center** in the **Deployment** section of the **App Services** pane.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2FSites]" submitText="Go to App Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

To view your applications in App Service, go to the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2FSites).

::: zone-end

### Learn more

Start building out your deployment pipelines:

- [Create your first pipeline](https://docs.microsoft.com/azure/devops/pipelines/create-first-pipeline?view=azure-devops&tabs=tfs-2018-2)
- [`GitHub Release` tasks](https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/github-release?view=azure-devops)
