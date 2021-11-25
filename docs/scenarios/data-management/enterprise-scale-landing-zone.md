---
title: Introduction to Data management and analytics scenario
description: Gain an overview of Data management and analytics scenario.
author: mboswell
ms.author: brblanch
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Introduction to Data management and analytics scenario

In the late 1980s, there was the introduction of the data warehouse Gen1, which combined disparate data sources from across the enterprise. In the late 2000s came Gen2, with the introduction of the big data ecosystem like Hadoop and the data lake. In the mid 2010s, we had the cloud data platform. It was similar to previous generations, but with the introduction of the ingestion of streaming data, like kappa or lambda architectures. The early 2020s introduced the concepts of the data lakehouse, data mesh, data fabric, and data-centric operational patterns.

Understanding the evolution and looking forward, many organizations still have the centralized monolithic platform, generation 1. This system works well, up to a point. Bottlenecks because of interdependent processes, tightly coupled components, hyperspecialized teams, and thousands of extract, transform, load (ETL) jobs.

The data warehouse and data lake is still valuable, and will play an important role in your overall architecture. We're highlighting some of the challenges that inevitably come forth when using these traditional practices. These challenges are especially relevant in a large complex organization, where data sources, requirements, teams, and outputs change.

Even with the introduction of the cloud, the centralized approach to data management remains largely unchanged most of the time.

In response to the challenges of centralized data warehouses, Data management and analytics scenario represents a strategic design path and targets the technical state for an Azure analytics and AI environment.

The pattern relies upon distribution of the data and its pipelines across domains. This pattern enables ownership of accessibility, usability, and development. Largely based on these patterns, Data management and analytics scenario includes the following capabilities:

- Storage
- Data lineage
- Data classification
- Data ingestion
- Networking
- Security
- Access management
- Encryption
- Resiliency
- Monitoring

> [!NOTE]
> The Data management and analytics scenario builds on the Cloud Adoption Framework [enterprise-scale architecture](../../ready/enterprise-scale/index.md) and should be considered a supplement to it.

## Critical design areas

Data management and analytics scenario considers five critical design areas that help translate organizational requirements to Azure constructs and capabilities. Lack of attention to these design areas typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. Data management and analytics scenario uses these design areas to help address the mismatch between on-premises and cloud-design infrastructure, and data monoliths.

To learn more, see:

- [Data management](#data-management-landing-zone)
- [Data landing zone](#data-landing-zone)
- [Data integrations](#data-integrations)
- [Data products](#data-products)
- [Data platform operational excellence](#data-platform-operational-excellence)

> [!IMPORTANT]
> Data management and analytics scenario recommends to use zone-redundant storage (ZRS).

### Data management landing zone

At the heart of Data management and analytics scenario, is its data management capability. This capability is enabled through the data management landing zone.

:::image type="content" source="./images/data-management-overview-1.png" alt-text="Diagram of a Data management overview.":::

The **Data management landing zone** is a subscription that governs the platform and supports the following capabilities:

- [Data catalog](./architectures/data-management-landing-zone.md#data-catalog)
- [Data classification](./architectures/data-management-landing-zone.md#data-classification)
- [Data lineage](./architectures/data-management-landing-zone.md#data-lineage)
- [Data quality management](./architectures/data-management-landing-zone.md#data-quality-management)
- [Data modeling repository](./architectures/data-management-landing-zone.md#data-modeling-repository)
- [Master data management](./architectures/data-management-landing-zone.md#master-data-management)
- [API catalog](./architectures/data-management-landing-zone.md#api-catalog)
- [Data sharing and contracts](govern-data-sharing-agreements.md)

For more information, see [Overview of the Azure Data management and analytics scenario data management landing zone](./architectures/data-management-landing-zone.md).

### Data landing zone

**Data landing zones** are subscriptions that might host multiple analytics and AI solutions relevant to their respective domain. These subscriptions within Data management and analytics scenario represent primary business groups, integrators, and enablers. These groups own, operate, and often provide innate understanding for the source systems.

:::image type="content" source="./images/data-landing-zone-overview.png" alt-text="Diagram of a data landing zone.":::

A few important points to keep in mind about data landing zones:

- Ingestion capabilities exist in each data landing zone. These capabilities allow subject matter experts to pull in external data sources into the data landing zone.
- A data landing zone is instantiated based on its core architecture. It includes key capabilities to host an analytics platform.
- A data landing zone can host one or many [data integrations](#data-integrations).
- A data landing zone can also host one or many [data products](#data-products).

For more information, see [Data landing zone](./architectures/data-landing-zone.md).

### Data integrations

The responsibility of ingesting external data into enterprise for analytics and AI lies with integration ops. Data integrations exist in a data landing zone as multiple resource groups, and each contains:

- Azure Key Vault
- Azure Data Factory for running developed engineering pipelines to transformations
- A security user group that you give access to the Azure Databricks analytics and data science workspace
- A service principal that's used by the data integration to deploy ingest jobs to the Azure Databricks engineering workspace

Other services like Azure Event Hubs, Azure IoT Hub, Azure Stream Analytics, and Azure Machine Learning can be created if they're needed.

> [!IMPORTANT]
> A **data integration** is responsible for ingesting external data into a read data source. Apart from data quality checks and other applied data, the data should avoid having other data transformations applied to it.

For more information, see [Data management and analytics scenario data integrations in Azure](./architectures/data-landing-zone-data-integration.md).

### Data products

A data product is anything that drives business value, including reports, workbooks, a distinct database, or a data API. It can use the following services and technologies that don't belong to a data landing zone's core architecture:

- Reporting with niche requirements, like compliance, tax reporting, HR, and others.
- Specialized capabilities that address gaps in the baseline policies.

Since data products are compute or polyglot persistence services, they might only be required depending on certain use cases.

Examples of data products include:

- Azure Functions
- Azure App Service
- Azure Logic Apps
- Azure Analysis Services
- Azure Cognitive Services
- Azure Machine Learning
- Azure SQL Database
- Azure Database for MySQL
- Azure Cosmos DB

> [!IMPORTANT]
> A **data product** fulfills a specific need within a business using data. Data products manage, organize, and make sense of the data across domains and present the insights gained from the data products. A data product is a result of data from one or many data integrations or other data products.

For more information, see [Data management and analytics scenario data products in Azure](./architectures/data-landing-zone-data-products.md).

### Data platform operational excellence

The Data management and analytics scenario is designed with data platform operational excellence at its core through self-service enablement, governance, and streamlined deployments. The working model for data operations enables these core principles by using infrastructure-as-code and deployment templates. It also uses deployment processes that include a forking and branching strategy and a central repository.

For more information, see [Understand DevOps automation for data management and analytics in Azure](./organize-data-operations.md).

## Next steps

[Scaling data management and analytics in Azure](./eslz-scale.md)
