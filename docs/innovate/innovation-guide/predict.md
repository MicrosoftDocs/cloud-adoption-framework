---
title: Innovate with AI in Azure
description: Learn about Azure solutions to predict customer needs, automate business processes, discover information lying latent in unstructured data, and engage with customers in new ways to deliver better experiences.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.localizationpriority: high
ms.custom: internal, fasttrack-edit, AQC, seo-caf-innovate
keywords: Automate business processes, ai innovation, machine learning, knowledge mining
---

<!-- cSpell:ignore ONNX -->

# Innovate with AI in Azure

As an innovator, your company has rich information about its business and its customers. Using AI innovation, your company can:

- Make predictions about customer needs.
- Automate business processes.
- Discover information that's latent in unstructured data.
- Engage with customers in new ways to deliver better experiences.

 This article introduces a few approaches to innovating with AI. Innovations can expand your company's business insights into your existing data. The following table can help you find the best solution for your implementation needs.

| Solution category | Description                                                                                                                              | Required skills              |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| Machine learning            | **Azure Machine Learning** <br> Build, deploy, and manage your own machine learning models.                                                       | Data scientist and developer |
| AI applications and agents             | **Azure Cognitive Services** <br> Use domain-specific AI models for vision, speech, language, and decision that can be customized with your data. <br><br> **Azure Bot Service** <br> Improve customer engagement by adding bots to your applications and websites. | Developer                    |
| Knowledge mining            | **Azure Cognitive Search** <br> Uncover insights that are latent in your content, including documents, contracts, images, and other data types.      | Developer                    |

## Machine learning

Azure provides advanced machine learning capabilities. Build, train, and deploy your machine learning models across the cloud and edge by using Azure Machine Learning. Develop models faster by using automated machine learning. Use tools and frameworks of your choice without being locked in.

For more information, see [Azure Machine Learning overview](/azure/machine-learning/overview-what-is-azure-ml) and [getting started with your first machine learning experiment](/azure/machine-learning/tutorial-1st-experiment-sdk-setup). For more information on the open-source model format and runtime for machine learning, see [ONNX Runtime](https://www.onnxruntime.ai/).

<!-- markdownlint-disable MD024 -->

### Action

A data scientist can use Azure Machine Learning to train and build a model by using advanced languages such as Python and R, as well as by using a drag-and-drop visual experience. To get started with Azure Machine Learning:

1. In the Azure portal, search for and select **Machine Learning**.

1. Select **Add**, and follow the steps in the portal to create a workspace.

1. The new workspace provides both low-code and code-driven approaches for data scientists to train, build, deploy, and manage models.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2FWorkspaces]" submitText="Go to Azure Machine Learning resources" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Machine Learning resources in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2FWorkspaces).

::: zone-end

## AI applications and agents

Azure provides a set of pre-built AI services called Cognitive Services to build AI applications. Additionally, Azure offers bot service, which allows developers to build conversational AI agents that improve customer and employee engagement.

### AI applications

Cognitive Services enables you to incorporate the AI capabilities of vision, speech, language, and decision into your applications. Most predictive models don't require additional training. These services are useful when you don't have data scientists on staff to train the predictive model. Other services require minimal training.

For more information about the training that might be required and a list of available services across vision, speech, language, and decision-making, see the [Cognitive Services](/azure/cognitive-services/cognitive-services-and-machine-learning#service-requirements-for-the-data-model) documentation.

#### Action

To get started with a Cognitive Services API:

1. In the Azure portal, search for and select **Cognitive Services**.

1. Select **Add** to find a Cognitive Services API in Azure Marketplace.

1. Search for and select a service:

    - If you know the name of the service you want to use, enter the name in **Search the Marketplace**. Then select the service.

    - For a list of Cognitive Services APIs, select **See More** next to the **Cognitive Services** heading. Then select the service.

1. Select **Create**, and follow the steps in the portal to provision the service.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2FAccounts]" submitText="Go to Cognitive Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Cognitive Services in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2FAccounts).

::: zone-end

### AI agents

Interact more naturally with your customers and improve customer engagement through conversational experiences powered by Bot Framework and Azure Bot Service. In addition, use Cognitive Services APIs like Language Understanding (LUIS), QnA Maker, and Speech service. These help your customers with common tasks, leaving your call center agents time to focus on more nuanced, higher value cases.

For more information on how to build bots, see [Azure Bot Service](/learn/paths/create-bots-with-the-azure-bot-service/).

#### Action

To get started with Azure Bot Service:

1. In the Azure portal, search for and select **Bot Services**.

1. Select **Add**, and then select **web app bot** or **bot channels registration**.

1. Select **Create**. Then follow the steps in the portal to provision the service.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.BotService%2FBotServices]" submitText="Go to Azure Bot Service" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Bot Service in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.BotService%2FBotServices).

::: zone-end

## Knowledge mining

Knowledge mining uses AI to drive content understanding over vast amounts of unstructured, semi-structured, and structured information. Use Azure Cognitive Search to uncover latent insights from your content, including documents, images, and media. You can discover patterns and relationships in your content, understand sentiment, and extract key phrases.

<!-- docutune:ignore "Azure Search" -->

Azure Cognitive Search uses the same natural language stack that Bing and Microsoft Office use. Spend more time innovating and less time maintaining a complex cloud search solution.

For more information, see [What is Azure Cognitive Search?](/azure/search/search-what-is-azure-search)

### Action

To get started:

1. In the Azure portal, search for and select **Azure Cognitive Search**.

1. Follow the steps in the portal to provision the service.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Search%2FSearchServices]" submitText="Go to Azure Cognitive Search" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Cognitive Search in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Search%2FSearchServices).

::: zone-end

---
