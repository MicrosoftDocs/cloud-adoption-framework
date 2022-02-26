---
title: Data management and analytics scenario data products in Azure
description: Learn about data management and analytics scenario data products in Azure.
author: SanemSSever
ms.author: sasever
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-data-management
---

# Data management and analytics scenario data products and data applications in Azure

At a high level, [data products](what-is-data-product.md) are data served as product and computed, saved and served by polyglot persistence services that might be required depending on certain use cases. The process of creating and serving a data product can require other services and technologies that aren't part of [data landing zone](./data-landing-zone.md) core services. One example can be reporting with niche requirements, such as compliance and tax reporting or specialized capabilities that address gaps in the baseline policies.

## Design considerations

- In a data landing zone it can be served multiple data products that are created by ingesting data either inside the same data landing zone or from across multiple data landing zones as shown below.

  :::image type="content" source="../images/data-product-cross-data-landing-zone.png" alt-text="Diagram of cross-data landing zone consumption.":::

  The example above shows:

  - Intrazone data consumption:
    - Data product B is created by consuming from data product A and other data and/or data products existing the data lake within its data landing zone; for example, data landing zone 1.
    - Data products C and D are created by only consuming data from within their own respective data landing zones.
  - Interzone data consumption:
    - Data product B is also created by consuming from data product C and the data in the data lake in data landing zone 3.

  > [!IMPORTANT]
  > In the case of interzone data consumption, since data product B is created by reading from data landing zone 3, this read access would require approval from the [data landing zone operations](../organize-persona-and-teams.md#data-landing-zone-teams) and [integration operations](../organize-persona-and-teams.md#data-landing-zone-teams) team of data landing zone 3.
  > [!IMPORTANT]
  > Data product B is created by consuming from data products A and C. Before this can happen, data product B must register its consumption of a data product via a data sharing agreement. This data sharing agreement should update the lineage from data product A to data product B and from data product C to data product B.

- The resource group for a data product would include all the service required to make that data product, which we can call as **data application**. Examples of services that might be part of a data application that creates and maintains a data product include Azure Functions, Azure App Service, Logic Apps, Azure Analysis Services, Azure Cognitive Services, Azure Machine Learning, Azure SQL Database, Azure Database for MySQL, and Azure Cosmos DB. For more information, see [Data Application samples](#sample-data-aoolications).
- A data product has data from a *READ* data source that has had some data transformation applied. For example, that can be a newly curated dataset or a BI report.

## Design recommendations

We recommend building data products within your data landing zone by adhering to design principles that allow you to scale with data governance. Following are design recommendations to help you plan your data application ecosystem.

### Deploy multiple resource groups

Each data application is a resource group. Since data applications are compute or polyglot persistence services or both, they may only be required depending on certain use cases. As such, they can be considered an optional component of your data landing zone. In the case where data applications are required, you should create multiple resource groups by data application as shown below.

![Diagram of data application resource groups.](../images/data-products-resource-group.png)

### Set guardrails

Azure Policy would drive the default configuration of services within a data landing zone. Consider operational analytics as multiple resource groups that the data product team can request from a standard service catalog. By using Azure Policy, we can configure the security boundary and required feature set.

> [!IMPORTANT]
> To drive consistency we recommend configuring an Azure Policy per data application.

### Consume data from many places

Data applications manage, organize, and make sense of the data across data assets and present the insights gained via their output data products. A data product is a result of data from one or many data integrations and other data applications within data landing zones. Therefore, a data application should access data from multiple and various sources if necessary.

### Scale as needed

Services that make up a data application are an incremental deployment to the data landing zone therefore we recommend you scale data applications as needed.

### Enable data discovery

Data products should be automatically registered in a data catalog such as [Azure Purview](../best-practices/purview-deployment.md) to allow scanning of data.

### Identify your data products

At the start of planning a data landing zone, you should have identified as many data products and their respective data applications that output and maintain them, as you need to help drive the data product application architecture. At the top of each decision should be conformity to implement platform governance.

For your data applications, focus on how they're data producers and consumers for others. To understand further, let's assume you have identified a suite of data products (A, B, C, and D) which are produced and consumed data. You require data product A and D as a source to produce data in Data Application B for data product B. Data product B is created by Data Application B consuming data from data products A and D, and Data Application B acts as a data producer itself. It also produces data for data product C.

:::image type="content" source="../images/data-producers-consumers.png" alt-text="Diagram of a data producer and consumers.":::

### Control the data application environment with infrastructure as code

Across the whole of your data products ecosystem, governance and infrastructure as code should control the data application environment as shown in the diagram above.

### Publish data models

Data product teams should publish their data model in a modeling repository.

### Set expectations for data product users

Service-level agreements and certification for the data product, should update the data sharing contracts to set the right expectation for potential users of the data product.

### Capture lineage

As data product B is created by consuming from data product A and D, we want to make sure the lineage is captured from A and D to B. A further lineage would be captured for data product C created by consuming from data product B. It should be captured in a data lineage application before every release of a data product.

> [!NOTE]
> Using Azure Pipelines would allow building of approval gates to invoke functions to make sure metadata, lineage and SLAs are registered in the correct governance service.

### Define your data product's data application architecture

Fully defining a data product's relationship with other data products, its dependencies, and access requirements requires a detailed architecture for a given data product.

#### Example scenario

To explain the architecture definition process, we'll look at an example of a financial institution and its credit monitoring data product.

:::image type="content" source="../images/data-product-define-detail.png" alt-text="Diagram of define-data-product architecture in detail.":::

The credit monitoring data product shown above is created by consuming data from a *read data store* that has been ingested by the [integration operations team](../organize-persona-and-teams.md#data-landing-zone-teams) and produces data product(s) also consumed for creating two other data products.

> [!NOTE]
> A read data source or store is also known as *golden record source*. These types of data sources have been cleaned but haven't had any transformation applied to them.

The credit monitoring data product team requests read access to the read data stores they require for their data product creation. These requests are routed through the owners of the data for approval. Upon approval, the product teams can start to build the data application for creating credit monitoring data product.

Data from the read data source is transformed into the credit monitoring data product(s). You'll store any new data products in the data lake's curated layer. These new data products should be registered, alongside the new data lineage, as part of the DevOps deployment process. A function should check registered metadata with the physical structure of the data asset. It should register the dependency on the read data source data assets/data products.

The loan approval data product team take a dependency on some of the credit monitoring data products. They would request read access to the credit monitoring data products  they require for their data products. Upon release of the loan approval data product and its data application, all data product assets, lineage, and models should be registered in the relevant governance services.

## Sample data applications

### Data analytics and data science data application

A data application for analytics and data science might contain the services shown in sample data application (`product-analytics-rg`).

:::image type="content" source="../images/ProductAnalytics.png" alt-text="Diagram that shows possible services that can be selected for Analytics Data Application Deployment." lightbox="../images/ProductAnalytics.png":::

> [!NOTE]
> The data application above is [available as a template](https://github.com/Azure/data-product-analytics) that deploys a set of services which can be used for data analytics and data science. Like all our templates, this data product application template is a blueprint which can be used to quickly spin up environments for cross-functional teams. Any services not required must be explicitly disabled.
>
Analytics Data Application template contains all templates to deploy a Data Product for Analytics and Data Science inside a Data Landing Zone of the Data Management & Analytics Scenario.

The deployment and code artifacts include the following services:

- [Machine Learning](https://azure.microsoft.com/services/machine-learning/)
- [Key Vault](https://docs.microsoft.com/azure/key-vault/general)
- [Application Insights](https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview)
- [Storage](https://azure.microsoft.com/services/storage/)
- [Container Registry](https://azure.microsoft.com/services/container-registry/)
- [Cognitive Services](https://azure.microsoft.com/services/cognitive-services/) (optional)
- [Data Factory](https://docs.microsoft.com/azure/data-factory/) (select between Data Factory and Synapse)
- [Synapse Workspace](https://docs.microsoft.com/azure/synapse-analytics/) (select between Data Factory and Synapse)
- [Azure Search](https://azure.microsoft.com/services/search/) (optional)
- [SQL Pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) (optional)
- [BigData Pool](https://docs.microsoft.com/sql/big-data-cluster/concept-data-pool?view=sql-server-ver15) (optional)

### Batch Data Application

Batch Data Application template contains all templates to deploy a Data Product for batch data processing inside a Data Landing Zone of the Data Management & Analytics Scenario.

The deployment and code artifacts include the following services:

:::image type="content" source="../images/ProductBatch.png" alt-text="Diagram that shows possible services that can be selected for Batch Data Application Deployment." lightbox="../images/ProductBatch.png":::

- [Key Vault](https://docs.microsoft.com/azure/key-vault/general)
- [Data Factory](https://docs.microsoft.com/azure/data-factory/) (select between Data Factory and Synapse)
- [Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/introduction) (optional)
- [Synapse Workspace](https://docs.microsoft.com/azure/synapse-analytics/) (select between Data Factory and Synapse)
- [MySQL Database](https://docs.microsoft.com/azure/mysql/overview) (optional)
- [Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/database/) (optional)
- [PostgreSQL Database](https://docs.microsoft.com/azure/postgresql/) (optional)
- [MariaDB Database](https://docs.microsoft.com/azure/mariadb/) (optional)
- [SQL Pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) (optional)
- [SQL Server](https://docs.microsoft.com/sql/sql-server/?view=sql-server-ver15) (optional)
- [SQL Elastic Pool](https://docs.microsoft.com/azure/azure-sql/database/elastic-pool-overview) (optional)
- [BigData Pool](https://docs.microsoft.com/sql/big-data-cluster/concept-data-pool?view=sql-server-ver15)

### Streaming Data Application

Streaming Data Application template contains all templates to deploy a Data Product for real-time data processing inside a Data Landing Zone of the Data Management & Analytics Scenario.

The deployment and code artifacts include the following services:

:::image type="content" source="../images/ProductStreaming.png" alt-text="Diagram that shows possible services that can be selected for Streaming Data Application Deployment." lightbox="../images/ProductStreaming.png":::

- [Key Vault](https://docs.microsoft.com/azure/key-vault/general)
- [Event Hub](https://docs.microsoft.com/azure/event-hubs/)
- [IoT Hub](https://docs.microsoft.com/azure/iot-hub/about-iot-hub)
- [Stream Analytics](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-introduction) (optional)
- [Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/introduction) (optional)
- [Synapse Workspace](https://docs.microsoft.com/azure/synapse-analytics/)
- [Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/database/) (optional)
- [SQL Pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) (optional)
- [SQL Server](https://docs.microsoft.com/sql/sql-server/?view=sql-server-ver15) (optional)
- [SQL Elastic Pool](https://docs.microsoft.com/azure/azure-sql/database/elastic-pool-overview) (optional)
- [BigData Pool](https://docs.microsoft.com/sql/big-data-cluster/concept-data-pool?view=sql-server-ver15)
- [Data Explorer](https://docs.microsoft.com/azure/synapse-analytics/data-explorer/data-explorer-overview) (optional)

For the repositories containing the deployment templates you can refer to [Deployment templates for data management and analytics scenario](deployment-templates.md)

## Next steps

[Overview of reference architectures for data management and analytics in Azure](./reference-architecture-overview.md)
