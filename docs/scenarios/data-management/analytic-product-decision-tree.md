---
title: Analytic product decision tree
description: Analytic product decision tree
author: mboswell
ms.author: mboswell
ms.date: 06/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

<!-- needs a home-->

# Analytic product decision tree

:::image type="content" source="./images/data-product-decision-tree.png" alt-text="Analytic product decision tree" lightbox="./images/data-product-decision-tree.png":::

Figure 5: Analytic Product decision tree

Figures 5, above presents a decision tree to help choose the components for an analytic product on Azure. You'll navigate it from top to bottom through the following layers to determine for each of them what is the best solution to fit your requirements:

|Layer  |Description  |
|---------|---------|
|Data exploration     |The data exploration stage is meant to explore the data present in your data lakes and determine what data you need to access and its volume. On top of their current view of the business use cases, data project teams might also need an environment that allows them for ad-hoc queries on the data lake or data warehouse storage.         |
|Self-service BI     |To cater to self-service requirements and offer flexibility for small scale projects, the option to give access to the data lake through Power BI should be investigated. This pattern is particularly fit for data sets under 10GB, as it is one of the current limitations of Power BI data store.         |
|Orchestration and Ingestion layer    |The default solution for orchestrating the different data flows and transformations is Azure Data Factory (or its equivalent Synapse pipelines). Three options are today available to ingest data from the different sources, process it and store it in the right target. The choice boils down to the complexity of the transformation and some feature gaps between Azure Data Factory and Azure Synapse Pipelines.         |
|Data warehousing storage    |For large scale project, there might be a need to store data in a data warehouse storage to obtain optimal performance. Multiple options are available to you, depending on the dataset size your project requires, a set of features only available in certain solutions and for cost purposes.         |
|Semantic modeling     |This layer covers the need to store a subset of highly structured data and calculations for end-user consumption. This can be covered by Power BI premium or by having a dedicated Azure Analysis Services instance. The default option is to use the capabilities embedded in Power Bi premium, however some cases can only be covered by Azure Analysis Services to this day.         |