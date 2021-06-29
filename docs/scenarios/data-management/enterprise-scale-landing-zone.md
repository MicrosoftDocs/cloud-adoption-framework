---
title: Enterprise Scale Analytics and AI Introduction for Azure
description: Enterprise Scale Analytics and AI Introduction
author: mboswell
ms.author: mboswell  # Microsoft employees only
ms.date: 06/22/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Introduction to Enterprise Scale Analytics and AI

In the late 80's we saw the introduction of the data warehouse (gen 1) which consolidated disparate data sources from across the enterprise. In the late 2000's came Gen 2 with the introduction of the big data ecosystem with the likes of Hadoop and the data lake. In the mid 2010's we had the cloud data platform which is similar to previous generations but with the introduction of the ingestion of streaming data i.e. Kappa/Lambda architectures and today, early 2020's we have the concept of the data lake house, data mesh, data fabric and data centric operational patterns.

Understanding this evolution and looking forward, many organizations still have the current centralized monolithic platform (Gen 1). This works well up to a point, but you start running into bottlenecks due to interdependent processes, tightly coupled components, hyperspecialized teams and thousands of unmaintainable ETL jobs but it is a well-trodden path for many organizations.

The Data Warehouse and Data Lake is still hugely valuable and will play an important role in your overall architecture, but we're just highlighting some of the struggles that inevitably come forth when utilizing these traditional practices for any period of time, especially in a large complex organization, where data sources and requirements change, teams change, outputs change, and so on.

And even with the introduction of Cloud, most of the time, the centralized approach to Data Management remains largely unchanged.

In response to the challenges posed by a centralized data warehouse, the Enterprise Scale Analytics and AI construction set represents a strategic design path and targets the technical state for an Azure Analytics and AI environment.

The pattern relies upon distribution of the data and its pipelines across [domains](data-landing-zone-division-consumption.md) enabling ownership of accessibility, usability, and development. Largely based on these patterns, the Enterprise Scale Analytics and AI construction set includes capabilities such as storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency, and monitoring.

> [!NOTE]
> The Enterprise Scale Analytics and AI framework builds on our [Enterprise-Scale Architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/) and should be considered a supplement to it.

## Critical Design Areas

Enterprise Scale Analytics and AI considers five critical design areas that help translate organizational requirements to Azure constructs and capabilities. Lack of attention to these design areas typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. Enterprise Scale Analytics and AI uses these design areas to help address the mismatch between on-premises and cloud-design infrastructure as well as data monoliths:

1. [Data Management](#data-management-landing-zone)
1. [Data Landing Zone](#data-landing-zone)
1. [Data Integrations](#data-integrations)
1. [Data Products](#data-products)
1. [Data Platform Operational Excellence](#data-platform-operational-excellence)

<!-- 1. [Data Science Environment](#data-science-environment)
1. [Data Science Workflow and MLOps](#data-science-workflow-and-mlops) -->

>[!IMPORTANT]
>The Enterprise Scale Analytics and AI construction set is recommending to use zone redundant storage. ZRS is currently supported for deployment, in one of the below **Supported Regions** list.
>
>- Asia Southeast
>- Europe North
>- Europe West
>- France Central
>- Japan East
>- South Africa North
>- UK South
>- US Central
>- US East
>- US East 2
>- US West 2

### Data Management Landing Zone

At the heart of Enterprise Scale Analytics and AI is its data management capability which is enabled through the Data Management Landing Zone.

:::image type="content" source="images/data-management-overview-1.png" alt-text="Data Management Overview":::

*Figure 1: Data Management Overview*

The **Data Management Landing Zone**, which is a subscription, is responsible for the governance of the platform and allows for the following capabilities:

- [Data Catalog](data-management-landing-zone.md#data-catalog)
- [Data Classification](data-management-landing-zone.md#data-classification)
- [Data Lineage](data-management-landing-zone.md#data-lineage)
- [Data Quality Management](data-management-landing-zone.md#data-quality-management)
- [Data Modeling Repository](data-management-landing-zone.md#data-modeling-repository)
- [Master Data Management](data-management-landing-zone.md#master-data-management)
- [API Catalog](data-management-landing-zone.md#api-catalog)
- Data Sharing and Contracts

For further reading, see [Data Management Landing Zone](data-management-landing-zone.md).

### Data Landing Zone

The **Data Landing Zone(s)**, on the other hand, are subscriptions which may host multiple analytics and AI solutions relevant to their respective domain. These subscriptions within the Enterprise Scale Analytics and AI construction set represent primary business groups, integrators, and enablers as these groups own, operate, and often provide innate understanding for the source systems.

:::image type="content" source="images/data-landing-zone-overview.png" alt-text="Data Landing Zone":::

Figure 2: Data Landing Zone

A few important points to keep in mind about Data Landing Zones:

- Ingestion capabilities exist in each Data Landing Zone to allow subject matter experts to pull in data sources from external sources into the Data Landing Zone.
- Data Landing Zone(s) are instantiated based on the Data Landing Zone core architecture, including all key capabilities to host an analytics platform.
- A Data Landing Zone can host one or many [Data Integrations](#data-integrations).
- A Data Landing Zone can also host one or many [Data Products](#data-products).

For further reading, see [Data Landing Zone](data-landing-zone.md).

### Data Integrations

The responsibility of ingesting external data into Enterprise Analytics and AI lies with Integration Op. Data Integrations exists in a Data Landing Zone as multiple resource group and each contains the following:

- A Azure Key Vault.
- A Azure Data Factory for running developed engineering pipelines to transformations.
- A security user group which we use to give access to the Azure Databricks Analytics and Data Science workspace.
- A Service Principal which is used by the Data Integration for deploying ingest jobs to the Azure Databricks Engineering workspace.

Additional services such as Event Hubs, IoT Hubs, Stream Insight, and Machine Learning can optionally be created.

>[!IMPORTANT]
>A **data integration** is responsible for ingestion of external data into a read data source. The data should avoid having any data transformations applied to it apart from data quality checks and application of data types.

For further reading, see [Data Landing Zone Data Integrations](data-landing-zone-data-integration.md).

### Data Products

A data product is anything that drives business value (*e.g.* reports, workbooks, bespoke database or data API). It can leverage additional services and technologies which are not part of Data Landing Zone core architecture such as:

- Reporting with niche requirements, *e.g.* compliance, tax reporting, HR, etc.
- Specialized capabilities that address gaps in the baseline policies.

Since data products are compute or polyglot persistence services, they may only be required depending on certain use cases.

Examples of Data Products include Azure Functions, App Service, Logic Apps, Azure Analysis Services, Cognitive Services, Azure Machine Learning, Azure SQL DB, Azure MySQL, and Azure CosmosDB.

>[!IMPORTANT]
>A **data product** fulfil a specific need within a business using data. Data products manage, organize and make sense of the data across domains and present the insights gained from the data products. A data product is a result of data from one or many data integrations and/or other data products.

For further reading, see [Data Landing Zone Data Products](data-landing-zone-data-products.md).

### Data Platform Operational Excellence

The Enterprise Scale Analytics and AI platform was designed with data platform operational excellence at its core through self-service enablement, governance and streamlined deployments. The working model for data operations enables these core principles through the use of Infrastructure as Code, deployment templates, deployment processes that includes a forking and branching strategy and a central repository.

For further reading, see [Platform automation and DevOps](dataops.md).

<!-- ### Data Science Environment

A **data science environment** following the Enterprise Scale Analytics and AI construction set, enables data scientists, business analyst and developers to benefit from many types of services, which can be quickly deployed to a [Data Product](#data-products).

For further reading, see [Data Science Environment](data-science-environment.md).

### Data Science Workflow and MLOps

On Enterprise Scale Analytics and AI platform there is a rigor process in place that allows data science teams to structure their projects and leverage git to share code and other artifacts.

For further reading, see [Data Science Workflow and MLOps](data-science-workflow-and-mlops.md). -->
