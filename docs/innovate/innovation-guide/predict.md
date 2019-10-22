---
title: "Azure innovation guide: Predict and influence" 
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn to predict and influence using Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: innovate
ms.custom: fasttrack-edit, AQC
ms.localizationpriority: high
---

::: zone target="docs"

# Azure innovation guide: Predict and influence

::: zone-end

::: zone target="chromeless"

# Predict and influence

::: zone-end

As an innovator, your company will have insights into the data, behavior, and needs of your customer base. Studying those insights can aid in predicting your customer's needs, before they may even be aware of those needs. This article will introduce a few approaches to delivering predictive solutions. In the later section, the article introduces approaches to integrating those predictions back into your solution to influence customer behaviors.

The following table is designed to help find the best solution based on your implementation needs.

|Service  |Pre-built models  |Build and experiment  |Train and build w/ Python|Required Skills|
|---------|---------|---------|---------|---------|
|Cognitive Services|Yes|No|No|API and Developer skills|
|Azure Machine Learning Studio|Yes|Yes|No|General understanding of predictive algorithms|
|Azure Machine Learning Service|Yes|Yes|Yes|Data Scientist|

## [Azure Cognitive Services](#tab/CognitiveServices)

The fastest and easiest path to predictions is Azure Cognitive Services. Cognitive Services allows predictions to be made based on existing models, which require no additional training. These services are optimal, when there isn't an existing data scientist on staff to train the predictive model. For some services, no training is required. Others require only minimal training.

For a list of the services available and the amount of training required, see [Cognitive Services and machine learning](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-and-machine-learning#service-requirements-for-the-data-model).

### Action

To use a cognitive service API:

1. Go to **Cognitive Services**.
2. Click **Add+** to find a Cognitive Service from the marketplace.
3. If you know the name of the service you'd like to use, you can enter the service name in the **Search the Marketplace** text box.
4. Alternatively, for a list of Cognitive Services, click the **See More** link next to the Cognitive Services header.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2Faccounts]" submitText="Go to Cognitive Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Cognitive Services in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2Faccounts).

::: zone-end

## [Azure Machine Learning Studio](#tab/MachineLearningStudio)

If the existing models within cognitive services don't align with the desired prediction, Azure Machine Learning Studio may provide a way to build the desired predictions, without requiring deep data scientist skills.

<!-- markdownlint-disable MD024 -->

### Action

You can use an Azure Machine Learning Studio to build a model and experiment with that model:

1. Go to **Azure Machine Learning Studio**.
2. Click **Create Machine Learning Studio Workspace** and follow the prompts to create a workspace.
3. The new workspace provides a drag-and-drop interface to build a model and experiment with the model, as an alternative to deep training.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearning%2Fworkspaces]" submitText="Go to Azure Machine Learning Studio" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Machine Learning Studio in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearning%2Fworkspaces).

::: zone-end

## [Azure Machine Learning Service](#tab/MachineLearningService)

Azure Machine Learning service provides the deeper code-based approach required for deeper training of customer data sets. Using languages like Python, data scientists can train and then build an algorithm to predict customer needs.

### Action

A data scientist can use an Azure Machine Learning Service to train and build a model using advanced languages like Python:

1. Go to **Azure Machine Learning Service**.
2. Click **Create Machine Learning service workspaces** and follow the prompts to create a workspace.
3. The new workspace provides a code driven approach for data scientists to train and build models that require more advanced analytics to accurately predict customer needs.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2Fworkspaces]" submitText="Go to Azure Machine Learning Service" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Machine Learning Studio in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2Fworkspaces).

::: zone-end

## Influence

All of the approaches mentioned above result in an API that exposes the prediction model to applications. Within your solution, use any of these approaches to feed data collected from your customer into a predictive API. The results can then be integrated into the customer experience as a suggested next step.

Those next steps attempt to shape the customer behavior patterns and influence how the customer reacts. Since the suggested next steps are based on predictive algorithms, the will use the previous customers and available data to predict the customer need and meet that need, often before the customer is even aware that the need exists.
