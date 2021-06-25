---
title: Azure Enterprise Scale Analytics and AI Data Products
description: Enterprise Scale Analytics and AI Data Products
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 06/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---
# Data Products

## Overview

At a high level, data products are computed or polyglot persistence services that may be required depending on certain use cases. A data product is anything that drives business value (e.g., reports, workbooks, bespoke database or data API). It can leverage additional services and technologies which are not part of [Data Landing Zone](data-landing-zone.md) core services such as reporting with niche requirements like compliance and tax reporting or specialized capabilities that address gaps in the baseline policies.

## Design considerations

- A Data Landing Zone can have multiple data products which are created by ingesting data either inside the same Data Landing Zone or from across multiple Data Landing Zones which are subject to approval.
- The resource group for a data product would include all the service required to make that data product. Examples of services which may be part of a data product include Azure Functions, App Service, Logic Apps, Azure Analysis Services, Cognitive Services, Azure Machine Learning, Azure SQL DB, Azure MySQL and Azure CosmosDB.
- A data product is data from a READ data source which has had some data transformation applied. This could be a newly curated dataset or a BI report, for example.

## Design recommendations

We recommend building data products within your Data Landing Zone by adhering to design principles which allow you to scale with data governance. Following are design recommendations to help you plan your data products ecosystem.

### Deploy multiple resource groups

 Each data product is a resource group. Since data products are compute or polyglot persistence services, they may only be required depending on certain use cases. As such, they can be considered an optional component of your Data Landing Zone. In the case where data products are required, you should create multiple resource groups by data product as shown below.
    
![Data products resource groups](./images/data-products-resource-group.png)

### Set guard rails

Azure Policy would drive the default configuration of services within a Data Landing Zone. We can consider operational analytics as multiple resource groups which the Data Product Team can request from a standard service catalog. By using Azure Policy, we can configure the security boundary and required feature set.

>[!IMPORTANT]
>To drive consistency we recommend configuring an Azure Policy per Data Product.

### Consume data from many places

Data products manage, organize, and make sense of the data across data assets and present the insights gained from the data products. A data product is a result of data from one or many data integrations and/or other data products.

#### Cross Data Landing Zone Data Products

![Creating a Data Product](./images/data-product-cross-data-landing-zone.png)

The figure above illustrates how a Data Product is created if you have deployed multiple Data Landing Zone subscriptions. It shows how a Data Landing Zone hosts multiple data integrations and data products. A Data Integration is a logical boundary which driven by data ownership and knowledge. A Data Product is created by ingesting data from Data Integrations or Data Products either inside the same Data Landing Zone or from across multiple Data Landing Zones subject to approval of the Integration Ops.

### Scale as needed

Services that make up a data product are considered an incremental deployment to the Data Landing Zone therefore we recommend you scale data products as needed.

### Enable data discovery

Data products should be automatically registered in a data catalog such as [Azure Purview](purview-deployment.md) to allow scanning of data.

### Identify your data products

At the start of planning a Data Landing Zone, you should have identified as many data products as you need to help drive the data product architecture. At the top of each decision should be conformity to implement platform governance.

For your data products, focus on how they are **data producers** and **data consumers** for others. To understand this further, let's assume you have identified a suite of data products (A, B, C and D) which produce and consume data. As shown below, you require data product A and D to produce data for data product B. Data product B consumes from data products A and D and in turn—acting as a data producer itself alongside being a data consumer—also produces data for data product C.

:::image type="content" source="images/data-producers-consumers.png" alt-text="data producer and consumers":::

### Control the environment with Infrastructure-as-Code

Across the whole of your data products ecosystem, governance and infrastructure-as-code should control the environment as shown in the diagram above.

### Publish data models

Data product teams should publish their data model in a modeling repository.

### Set expectations for data product users

Service Level Agreements and certification for the data product, should update the Data Sharing Contracts to set the right expectation for potential users of the data product.

### Capture lineage

As data product B (in the diagram above) is consuming from data product A and D, we would want to make sure the lineage is captured from A and D to B. A further lineage would be captured for data product C consuming from data product B. This should be captured in a data lineage application before every release of a data product.

>[!Note]
> Using Azure DevOps Pipelines would allow building of approval gates to invoke functions to make sure metadata, lineage and SLAs are registered in the correct governance service.

### Define your data product's architecture

Fully defining a data product's relationship with other data products, its dependencies and access requirements requires a detailed architecture for a given data product.

#### Example Scenario

To explain the architecture definition process, we'll look at an example of a financial institution and its *credit monitoring* data product, as illustrated in the figure below.

:::image type="content" source="images/data-product-define-detail.png" alt-text="Define Data Product Architecture Detail":::

The credit monitoring data product shown above consumes data from a *read data store* that has been ingested by the [Integration Ops team](persona-and-teams.md#integration-ops-per-integration) and produces data assets for two other data products.

>[!Note]
>A read data source (or store) is also known as Golden Record Source. These types of data sources have been cleaned but haven't had any transformation applied to them.

The credit monitoring data product team requests read access to the read data stores they require for their data product. These requests are routed through the owners of the data for approval. Upon approval, the product teams can start to build the credit monitoring data product.

Data from the read data source is transformed into the credit monitoring data product and any new data assets are stored in the Data Lake's Curated layer (indicated in green above). These new data assets should be registered, alongside the new data lineage, as part of the DevOps deployment process. A function should check what has been registered metadata with the physical structure of the data asset and register the dependency on the read data source data assets.

The *loan approval* data product team (top right corner of the figure above) take a dependency on some of the credit monitoring data assets. They would request read access to the credit monitoring data product assets they require for their data product. Upon release of the loan approval data product, all data assets, lineage, and models should be registered in the relevant governance services.

## Sample data products

### Reporting and Visualization

For every Data Landing Zone, an empty Visualization Resource Group is created. Visualization is considered a **data product** and, depending on the complexity, can be created via a self-serve process or managed by a data product team.

![Visualization Resource Group](./images/visualization-resource-group.png)

>[!NOTE]
>Licensing costs might mean that is it more economical to deploy third-party products such as Spotfire and Tableau into the Data Management Landing Zone and for the products to connect across to the Data Landing Zone to pull data back.

Whilst an initial Reporting and Visualization Resource Group would be deployed for a new Data Landing Zone, Data Products might require their own Reporting and Visualization Resource Group due to security boundaries or a requirement to cross-charge for usage. However, it is important to remember that using Azure Active Directory Passthrough authentication from services such as Power BI and Azure Analysis Services often reduces the need for a separated security boundary.

Power BI is the strategic visualization tool for self-service analytics and for citizen data scientists. Our recommendation is to use the current well-established processes for data refresh scheduling, security, compliance, and data confidentiality handling.

Aligned to Microsoft investments and roadmap, we recommend when necessary and if possible to use Power BI Premium as the primary option for specific cases where refresh frequency, performance, or users licensing cannot be met by Power BI Pro.

Azure Analysis Services should  be used on an exception basis. There are specific use cases where it might be required such as multi-dimensional models, CI/CD advanced requirements, etc.

Therefore, as part of low-level design, we recommend enterprises consider an approach that allows access to a "trial" PBI Premium capacity by business users who would like to evaluate if it is a good fit for their use cases.
