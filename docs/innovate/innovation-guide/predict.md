---
title: "Azure innovation: Innovate with AI"
description: Learn about Azure solutions to predict customer needs, automate business processes, discover information lying latent in unstructured data, and engage with customers in new ways to deliver better experiences.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/26/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

::: zone target="docs"

# Azure innovation guide: Innovate with AI

::: zone-end

::: zone target="chromeless"

# Innovate with AI

::: zone-end

As an innovator, your company has rich information about its business and its customers. Using artificial intelligence (AI), your company can make predictions about customer needs, automate business processes, discover information lying latent in unstructured data, and engage with customers in new ways to deliver better experiences. This article introduces a few approaches to innovating with AI. The following table can help you find the best solution, based on your implementation needs.

| Service / solution category | Description                                                                                                                              | Required skills              |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| Machine learning            | **Azure Machine Learning**</br>Build, deploy, and manage your own machine learning models.                                                       | Data scientist and developer |
| AI apps and agents             | **Azure Cognitive Services**</br>Use domain-specific AI models for Vision, Speech, Language, and Decision that can be customized with your data.</br>,</br>**Azure Bot Service**</br>Improve customer engagement by adding bots to your applications and websites. | Developer                    |
| Knowledge mining            | **Azure Cognitive Search**</br>Uncover insights lying latent in your content, including documents, contracts, images, and other data types.      | Developer                    |

## [Machine learning](#tab/MachineLearning)

Azure provides advanced machine learning capabilities. Quickly and easily build, train, and deploy your machine learning models across the cloud and edge, using Azure Machine Learning, Azure Databricks, and Open Neural Network Exchange (ONNX). Develop models faster using automated machine learning. Use tools and frameworks of your choice without being locked in.

For more information on getting started with Azure Machine Learning, see [What is Azure Machine Learning?](https://docs.microsoft.com/azure/machine-learning/overview-what-is-azure-ml) and [Getting started with your first ML experiment](https://docs.microsoft.com/azure/machine-learning/tutorial-1st-experiment-sdk-setup). For more information on the open source model format and runtime for machine learning, see our [ONNX and Azure Machine Learning](https://docs.microsoft.com/azure/machine-learning/concept-onnx) documentation.

### Action

A data scientist can use Azure Machine Learning to train and build a model by using advanced languages such as Python and R, as well as using a drag-and-drop visual experience. To get started with Azure Machine Learning:

1. In the Azure portal, search for and select **Machine Learning**.

1. Select **Add**, then follow the steps in the portal to create a workspace.

1. The new workspace provides a code-driven approach for data scientists to train and build models that require more advanced analytics to accurately predict customer needs.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2Fworkspaces]" submitText="Go to Azure Machine Learning resources" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Machine Learning resources in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2Fworkspaces).

::: zone-end

## [AI apps and agents](#tab/AIAppsAndAgents)


Azure provides a set of pre-built AI services called Cognitive Services to easily build AI applications. Additionally, Azure offers Bot Service, which allows developers to build conversational AI agents that improve customer and employee engagement.

### AI apps

Cognitive Services enables you to incorporate the AI capabilities of Vision, Speech, Language, and Decision into your applications, without requiring additional training for predictive models. These services are optimal and effective when you have no data scientist on staff to train the predictive model. For some services, no training is required; other services require only minimal training.

For a list of available services across Vision, Speech, Language, and Decision, and the amount of training that might be required, see the [Cognitive Services](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-and-machine-learning#service-requirements-for-the-data-model) documentation.

#### Action

To get started with a Cognitive Services API:

1. In the Azure portal, search for and select **Cognitive Services**.

1. Select **Add** to find a Cognitive Services API in Azure Marketplace.

1. Search for and select a service:

    - If you know the name of the service you want to use, enter the name in **Search the Marketplace**, then select the service.

    - For a list of Cognitive Services APIs, next to the **Cognitive Services** heading select **See More**, then select the service.

1. Select **Create**, then follow the steps in the portal to provision the service.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2FAccounts]" submitText="Go to Cognitive Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Cognitive Services in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2FAccounts).

::: zone-end

### AI agents

Interact more naturally with your customers and improve customer engagement through conversational experiences powered by Bot Framework and Azure Bot Service. In addition, use Cognitive Services APIs like Language Understanding, Speech, and QnA Maker so your customers can self-serve on common tasks, leaving your call center agents time to focus on more nuanced, higher value cases.

For more information on how to build bots, see the [Azure Bot Service](https://docs.microsoft.com/learn/paths/create-bots-with-the-azure-bot-service/) learning path.

#### Action

To get started with Azure Bot Service:

1. In the Azure portal, search for and select **Bot Services**.

1. Select **Add**, then select **Web App Bot** or **Bot Channels Registration**.

1. Select **Create**, then follow the steps in the portal to provision the service.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.BotService%2FbotServices]" submitText="Go to Azure Bot Service" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Bot Service in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.BotService%2FbotServices).

::: zone-end

## [Knowledge mining](#tab/KnowledgeMining)

Uncover latent insights from all your content - documents, images, and media - with Azure Cognitive Search. Using the only cloud search service with built-in AI capabilities, discover patterns and relationships in your content, understand sentiment, extract key phrases, and more.

Formerly known as Azure Search, Azure Cognitive Search uses the same integrated Microsoft natural language stack that Bing and Office have used for more than a decade, and AI services across vision, language, and speech. Spend more time innovating and less time maintaining a complex cloud search solution.

For more information, see [What is Azure Cognitive Search?](https://docs.microsoft.com/azure/search/search-what-is-azure-search)

### Action

To get started with Azure Cognitive Search:

1. In the Azure portal, search for and select **Azure Cognitive Search**.

1. Follow the steps in the portal to provision the service.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Search%2FsearchServices]" submitText="Go to Azure Cognitive Search" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Cognitive Search in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Search%2FsearchServices).

::: zone-end

---
