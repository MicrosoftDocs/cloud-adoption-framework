---
title: Azure Machine Learning as a data product for enterprise-scale for analytics and AI
description: Azure Machine Learning as a data product for enterprise-scale for analytics and AI
author: abdale
ms.author: hamoodaleem
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Machine Learning as a data product

Azure Machine Learning is considered a [data product](../architectures/data-landing-zone-data-products.md) and can be used to enable the end-to-end data science development activities. Data product and science teams interact with this workspace to:

- Explore and pre-process data
- Iterate through the machine learning model development cycle
- Operationalize models

Azure Machine Learning covers all aspects of the data science lifecycle. It covers datastore and dataset registration to model deployment. It can be used for any kind of machine learning, from classical machine learning to deep learning. It includes supervised and unsupervised learning. Whether you prefer to write Python, R code, or use zero-code or low-code options such as the designer, you can build, train, and track accurate machine learning and deep learning models in an Azure Machine Learning workspace.

> [!IMPORTANT]
> Deploy three Azure Machine Learning workspaces per project and use Azure Data Factory to orchestrate workflows and trigger registered machine learning pipelines.

For a production-grade deployment, use these three workspaces:

- Development
- Staging or testing, to ensure that results are reproducible
- Production

:::image type="content" source="../images/sample-data-science-flow.png" alt-text="Diagram showing a sample data science workflow." lightbox="../images/sample-data-science-flow.png":::

Data scientists have access to the development environment. They have optional access to the test environment. Azure Data Factory can be used in the production environment to orchestrate data flows and to trigger registered machine learning pipelines.

> [!IMPORTANT]
> Use Azure Machine Learning clusters for production-grade model training, and Azure Kubernetes Service (AKS) for production-grade deployments.
> [!TIP]
> Use Azure Machine Learning for data science projects. It covers the end-to-end workflow with sub-services and features, and allows to the process to be fully automated.
