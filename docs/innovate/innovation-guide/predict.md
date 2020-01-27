---
title: "Azure innovation guide: Predict and influence" 
description: Learn to predict and influence using Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: guide
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

As an innovator, your company has insights into the data, behavior, and needs of its customer base. Studying those insights can aid in predicting your customers' needs, possibly before your customers themselves are aware of those needs. This article introduces a few approaches to delivering predictive solutions. In the final sections, the article introduces approaches to integrating the predictions back into your solution to influence customer behaviors.

The following table can help you find the best solution, based on your implementation needs.

|Service  |Prebuilt models  |Build and experiment  |Train and build with Python|Required skills|
|---------|---------|---------|---------|---------|
|Azure Cognitive Services|Yes|No|No|API and developer skills|
|Azure Machine Learning Studio|Yes|Yes|No|General understanding of predictive algorithms|
|Azure Machine Learning service|Yes|Yes|Yes|Data scientist|

## [Azure Cognitive Services](#tab/CognitiveServices)

The fastest and easiest path to predicting customer needs is Azure Cognitive Services. Cognitive Services allows predictions to be made based on existing models, which require no additional training. These services are optimal, and effective when you have no data scientist on staff to train the predictive model. For some services, no training is required. Other services require only minimal training.

For a list of available services and the amount of training that might be required, see [Cognitive Services and machine learning](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-and-machine-learning#service-requirements-for-the-data-model).

### Action

To use a Cognitive Services API:

1. In the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2Faccounts), go to **Cognitive Services**.
2. Select **Add** to find a Cognitive Services API in Azure Marketplace.
3. Do either of the following:
   - If you know the name of the service you want to use, enter the name in the **Search the Marketplace** box.
   - For a list of Cognitive Services APIs, select the **See More** link next to the Cognitive Services heading.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2Faccounts]" submitText="Go to Cognitive Services" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Cognitive Services in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.CognitiveServices%2Faccounts).

::: zone-end

## [Azure Machine Learning Studio](#tab/MachineLearningStudio)

If the existing models within Cognitive Services don't align with your desired prediction, Azure Machine Learning Studio might provide a way to build the desired predictions, without requiring deep data-scientist skills.

<!-- markdownlint-disable MD024 -->

### Action

You can use Azure Machine Learning Studio to build and experiment with a model by doing the following:

1. In the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearning%2Fworkspaces), go to **Azure Machine Learning Studio**.
2. Select **Create Machine Learning Studio Workspace**, and then follow the prompts to create a workspace.

   The new workspace provides a drag-and-drop interface for building and experimenting with a model, as an alternative to deep training.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearning%2Fworkspaces]" submitText="Go to Azure Machine Learning Studio" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Machine Learning Studio in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearning%2Fworkspaces).

::: zone-end

## [Azure Machine Learning service](#tab/MachineLearningService)

Azure Machine Learning service provides the deeper, code-based approach that's required for deeper training of customer datasets. By using languages such as Python, data scientists can train and then build an algorithm to predict customer needs.

### Action

A data scientist can use Azure Machine Learning service to train and build a model by using advanced languages such as Python:

1. Go to **Azure Machine Learning service**.
2. Select **Create Machine Learning service workspaces**, and then follow the prompts to create a workspace.
3. The new workspace provides a code-driven approach for data scientists to train and build models that require more advanced analytics for accurately predicting customer needs.

::: zone target="chromeless"

<!-- markdownlint-disable DOCSMD001 -->

::: form action="OpenBlade[#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2Fworkspaces]" submitText="Go to Azure Machine Learning service" :::

<!-- markdownlint-enable DOCSMD001 -->

::: zone-end

::: zone target="docs"

Go directly to Azure Machine Learning Studio in the [Azure portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.MachineLearningServices%2Fworkspaces).

::: zone-end

## Influence

All the approaches mentioned previously result in an API that exposes the prediction model to applications. Within your solution, use any of the approaches to feed data that's collected from your customer into a predictive API. The results can then be integrated into the customer experience as a suggested next step.

Those suggested next steps can help shape customer behavior patterns and influence how customers react. Because the suggested next steps are based on predictive algorithms, they use previous customer needs and available data to predict and meet future customer needs, often before the customers themselves are even aware that the need exists.
