---
title: Enterprise-scale for analytics and AI introduction for Azure
description: Enterprise-scale for analytics and AI introduction for Azure
author: mboswell
ms.author: brblanch
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Introduction to enterprise-scale for analytics and AI for Azure

In the late 1980s, there was the introduction of the data warehouse Gen1, which combined disparate data sources from across the enterprise. In the late 2000s came Gen2, with the introduction of the big data ecosystem like Hadoop and the data lake. In the mid 2010s, we had the cloud data platform. It was similar to previous generations, but with the introduction of the ingestion of streaming data, like Kappa or Lambda architectures. In the early 2020s, we have the concept of the data lakehouse, data mesh, data fabric, and data centric operational patterns.

Understanding the evolution and looking forward, many organizations still have the centralized monolithic platform, generation 1. This system works well, up to a point. Bottlenecks because of interdependent processes, tightly coupled components, hyperspecialized teams, and thousands of extract, transform, load (ETL) jobs.

The data warehouse and data lake is still valuable, and will play an important role in your overall architecture. We're highlighting some of the challenges that inevitably come forth when using these traditional practices. These challenges are especially relevant in a large complex organization, where data sources, requirements, teams, and outputs change.

Even with the introduction of the cloud, the centralized approach to data management remains largely unchanged most of the time.

In response to the centralized data warehouse challenges, enterprise-scale for analytics and AI represents a strategic design path and targets the technical state for an Azure analytics and AI environment.

The pattern relies upon distribution of the data and its pipelines across domains. This pattern enables ownership of accessibility, usability, and development. Largely based on these patterns, enterprise-scale for analytics and AI includes capabilities such as:

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
> The enterprise-scale for analytics and AI framework builds on our [enterprise-scale architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/) and should be considered a supplement to it.

## Critical design areas

Enterprise-scale for analytics and AI considers five critical design areas that help translate organizational requirements to Azure constructs and capabilities. Lack of attention to these design areas typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. Enterprise-scale for analytics and AI uses these design areas to help address the mismatch between on-premises and cloud-design infrastructure, and data monoliths.

To learn more, see:

- [Data management](#data-management-landing-zone)

- [Data landing zone](#data-landing-zone)

- [Data integrations](#data-integrations)

- [Data products](#data-products)

- [Data platform operational excellence](#data-platform-operational-excellence)

> [!IMPORTANT]
> Enterprise-scale for analytics and AI recommends to use zone-redundant storage (ZRS).

### Data management landing zone

At the heart of enterprise-scale for analytics and AI, is its data management capability. This capability is enabled through the data management landing zone.

:::image type="content" source="./images/data-management-overview-1.png" alt-text="Diagram of a Data management overview.":::

The **Data management landing zone**, which is a subscription, is responsible for the governance of the platform and allows for the following capabilities:

- [Data catalog](./architectures/data-management-landing-zone.md#data-catalog)
- [Data classification](./architectures/data-management-landing-zone.md#data-classification)
- [Data lineage](./architectures/data-management-landing-zone.md#data-lineage)
- [Data quality management](./architectures/data-management-landing-zone.md#data-quality-management)
- [Data modeling repository](./architectures/data-management-landing-zone.md#data-modeling-repository)
- [Master data management](./architectures/data-management-landing-zone.md#master-data-management)
- [API catalog](./architectures/data-management-landing-zone.md#api-catalog)
- Data sharing and contracts

For more information, see [Data management landing zone](./architectures/data-management-landing-zone.md).

### Data landing zone

**Data landing zones** are subscriptions that might host multiple analytics and AI solutions relevant to their respective domain. These subscriptions within enterprise-scale for analytics and AI represent primary business groups, integrators, and enablers. These groups own, operate, and often provide innate understanding for the source systems.

:::image type="content" source="./images/data-landing-zone-overview.png" alt-text="Diagram of a data landing zone.":::

A few important points to keep in mind about data landing zones:

- Ingestion capabilities exist in each data landing zone. These capabilities allow subject matter experts to pull in external data sources into the data landing zone.
- A data landing zone is instantiated based on its core architecture. It includes key capabilities to host an analytics platform.
- A data landing zone can host one or many [Data integrations](#data-integrations).
- A data landing zone can also host one or many [Data products](#data-products).

For more information, see [Data landing zone](./architectures/data-landing-zone.md).

### Data integrations

The responsibility of ingesting external data into enterprise for analytics and AI lies with integration operations. Data integrations exist in a data landing zone as multiple resource groups, and each contains:

- Azure Key Vault
- Azure Data Factory for running developed engineering pipelines to transformations
- A security user group that you give access to the Azure Databricks analytics and data science workspace
- A service principal that's used by the data integration to deploy ingest jobs to the Azure Databricks engineering workspace

Additional services such as Azure Event Hub, Azure IoT Hub, Azure Stream Analytics, and Azure Machine Learning can optionally be created.

> [!IMPORTANT]
> A **data integration** is responsible for ingestion of external data into a read data source. The data should avoid having any data transformations applied to it apart from data quality checks and application of data types.

For more information, see [Data landing zone data integrations](./architectures/data-landing-zone-data-integration.md).

### Data products

A data product is anything that drives business value, such as reports, workbooks, a bespoke database, or a data API. It can use other services and technologies that aren't part of data landing zone core architecture such as:

- Reporting with niche requirements, like compliance, tax reporting, HR, and others.
- Specialized capabilities that address gaps in the baseline policies.

Since data products are compute or polyglot persistence services, they might only be required depending on certain use cases.

Examples of data products include:

- Azure Functions

- Azure App Service

- Azure Logic Apps

- Azure Analysis Services

- Cognitive Services

- Azure Machine Learning

- Azure SQL Database

- Azure Database for MySQL

- Azure Cosmos DB

> [!IMPORTANT]
> A **data product** fulfills a specific need within a business using data. Data products manage, organize and make sense of the data across domains and present the insights gained from the data products. A data product is a result of data from one or many data integrations or other data products.

For more information, see [Data landing zone data products](./architectures/data-landing-zone-data-products.md).

### Data platform operational excellence

The enterprise-scale for analytics and AI platform is designed with data platform operational excellence at its core through self-service enablement, governance, and streamlined deployments. The working model for data operations enables these core principles by using infrastructure as code (IaC) and deployment templates. It also uses deployment processes that include a forking and branching strategy and a central repository.

For more information, see [Platform automation and DevOps](./organize-data-operations.md).

## Next steps

[Scale data management and analytics](./eslz-scale.md)
