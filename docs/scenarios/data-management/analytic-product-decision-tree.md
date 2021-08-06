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

:::image type="content" source="./images/data-product-decision-tree.png" alt-text="Diagram of analytic product decision tree." lightbox="./images/data-product-decision-tree.png":::

The diagram presents a decision tree to help choose the components for an analytic product on Azure. Review it from top to bottom through the following areas. Determine the best solution to fit your requirements for each area.

|Layer  |Description  |
|---------|---------|
|Data exploration     |The data exploration stage is meant to explore the data present in your data lakes, determine what data you need to access, and its volume. Data project teams might also need an environment that allows them to do ad hoc queries on the data lake or data warehouse storage.         |
|Self-service BI     |To cater to self-service requirements and offer flexibility for small scale projects, the option to give access to the data lake through Power BI should be investigated. This pattern is fit for data sets under 10 GB, as it's one of the limitations of Power BI data store.         |
|Orchestration and ingestion layer    |The default solution for orchestrating the different data flows and transformations is Azure Data Factory, or its equivalent Azure Synapse pipelines. Three options are today available to ingest data from the different sources, process it and store it in the right target. The choice comes down to the complexity of the transformation and feature gaps between Azure Data Factory and Azure Synapse pipelines.         |
|Data warehousing storage    |For large-scale projects, there might be a need to store data in a data warehouse storage to obtain optimal performance. Multiple options are available, depending on the dataset size your project requires. A set of features might only be available in certain solutions and for cost purposes.         |
|Semantic modeling     |This area covers the need to store a subset of highly structured data and calculations for end-user consumption. You can use Power BI Premium, or have a dedicated Azure Analysis Services instance. The default option is to use the capabilities embedded in Power BI Premium, however in some cases, you can only use Azure Analysis Services.         |
