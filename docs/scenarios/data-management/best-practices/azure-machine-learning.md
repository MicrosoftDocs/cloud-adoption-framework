---
title: Azure Machine Learning as a Data Product for Enterprise Scale Analytics and AI
description: Azure Machine Learning as a Data Product for Enterprise Scale Analytics and AI
author:  abdale
ms.author: hamoodaleem # Microsoft employees only
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Machine Learning as a data product

Azure Machine Learning should be considered a [data product](../architectures/data-landing-zone-data-products.md) and can be used to enable the end-to-end data science development activities. Data Product and Science teams will interact with this workspace to explore and pre-process data, iterate through the machine learning model development cycle and operationalize models.

Azure Machine Learning will cover all aspects of the data science lifecycle from datastore and dataset registration to model deployment. It can be used for any kind of machine learning, from classical ML to deep learning, including both supervised and unsupervised learning. Whether you prefer to write Python or R code or use zero-code/low-code options such as the designer, you can build, train, and track highly accurate machine learning and deep learning models in an Azure Machine Learning workspace.

>[!IMPORTANT]
>Deploy three Azure Machine Learning workspaces per project and use Azure Data Factory for orchestrating workflows and triggering registered machine learning pipelines.

:::image type="content" source="../images/sample-data-science-flow.png" alt-text="Sample data science workflow" lightbox="../images/sample-data-science-flow.png":::

For a production-grade deployment, it is advised to use three workspaces as shown in figure outlining a sample data science workflow above:

* Development
* Staging or testing (to ensure that results are reproducible_
* Production

Data scientists should only have access to the development environment and optionally to the test environment. Azure Data Factory can be used in the production environment to orchestrate data flows and to trigger registered machine learning pipelines.

>[!IMPORTANT]
>Azure Machine Learning clusters should be used for production-grade model training, and Azure Kubernetes Service (AKS) should be used for production-grade deployments.

>[!TIP]
>Azure Machine Learning should be used for data science projects since it covers the end-to-end workflow with various sub-services and features and, in addition, allows to the process to be fully automated.