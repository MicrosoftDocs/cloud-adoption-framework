---
title: Enterprise Scale Analytics and AI Intro
description: Enterprise Scale Analytics and AI Intro
author: mboswell
ms.author: mboswell  # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Introduction to Enterprise Scale Analytics and AI

Today, customers are investing in moving data to the cloud and have been following a modern data warehouse (MDW) pattern published by multiple cloud vendors. This MDW pattern pushes for singular enterprise data lakes which focuses the organization on centralized analytics. These patterns are aligned to on-premises deployments as opposed to the agility and self-service of the cloud.

The Enterprise Scale Analytics and AI solution pattern represents the strategic design path and targets the technical state for an Azure Analytics and AI environment. It addresses the challenges of a centralized and monolithic data lake by using either a core service provider or a harmonized data mesh pattern.

A core service provider or harmonized data mesh pattern relies upon distribution of the data and its pipelines across [domains](data-landing-zone-division-and-consumption.md) enabling ownership of accessibility, usability, and development. Largely based on these patterns, the Enterprise Scale Analytics and AI solution pattern includes capabilities such as storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency, and monitoring.

> [!NOTE]
> The Enterprise Scale Analytics and AI framework builds on our [Enterprise-Scale Architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/) and should be considered a supplement to it.

## Critical Design Areas

Enterprise Scale Analytics and AI considers six critical design areas that help translate organizational requirements to Azure constructs and capabilities. Lack of attention to these design areas typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. Enterprise Scale Analytics and AI uses these design areas to help address the mismatch between on-premises and cloud-design infrastructure as well as data monoliths:

1. [Data Management](#data-management)
1. [Data Domains](#data-domains)
1. [Data Products](#data-products)
1. [Data Platform Operational Excellence](#data-platform-operational-excellence)
<!-- 1. [Data Science Environment](#data-science-environment)
1. [Data Science Workflow and MLOps](#data-science-workflow-and-mlops) -->

>[!IMPORTANT]
>For deployment, please choose one of the below **Supported Regions** list.
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

### Data Management

At the heart of Enterprise Scale Analytics and AI is its data management capability which is enabled through the Data Management Landing Zone.

The **Data Management Landing Zone**, which is a subscription, is responsible for the governance of the platform and allows for the following capabilities:

- [Data Catalog](data-management-landing-zone.md#data-catalog)
- [Data Classification](data-management-landing-zone.md#data-classification)
- [Data Lineage](data-management-landing-zone.md#data-lineage)
- [Data Quality Management](data-management-landing-zone.md#data-quality-management)
- [Data Modelling Repository](data-management-landing-zone.md#data-modelling-repository)
- [Master Data Management](data-management-landing-zone.md#master-data-management)
- [API Catalog](data-management-landing-zone.md#api-catalog)
- Data Sharing and Contracts

For further reading, see [Data Management Landing Zone](data-management-landing-zone.md).

The **Data Landing Zone(s)**, on the other hand, are subscriptions which may host multiple analytics and AI solutions relevant to their respective business domain. These subscriptions within the Enterprise Scale Analytics and AI solution pattern represent primary business groups, integrators, and enablers as these groups own, operate, and often provide innate understanding for the source systems. A few important points to keep in mind about Data Landing Zones:

- Ingestion capabilities exist in each Data Landing Zone to allow domain subject matter experts to pull in data sources from third-party clouds or on-premises environments if they wish to do so.
- Data Landing Zone are instantiated based on the Data Landing Zone core architecture, including all key capabilities to host an analytics platform.
- A Data Landing Zone can host one or many [Data Domains](#data-domains).
- A Data Landing Zone can also host one or many [Data Products](#data-products).

For further reading, see [Data Landing Zone](data-landing-zone.md).

### Data Domains

The responsibility of ingesting data into Enterprise Analytics and AI lies with Domains. A Domain exists in a Data Landing Zone as a resource group and contains the following:

- A Domain Azure Key Vault.
- A Domain Azure Data Factory for running developed engineering pipelines to transformations.
- A Domain security user group which we use to give access to the Azure Databricks Analytics and Data Science workspace.
- A Domain sensitive security group which we use to give access to the Azure Databricks Sensitive workspace.
- A Service Principal which is used by the Domain for deploying ingest jobs to the Azure Databricks Engineering workspace.

Additional services such as Event Hubs, IoT Hubs, Stream Insight, and Machine Learning can optionally be created.

>[!IMPORTANT]
>A **domain** is responsible for ingestion of data into a read data source. The data should avoid having any data transformations applied to it apart from data quality checks and application of data types.

For further reading, see [Data Landing Zone Data Domains](data-landing-zone-domains.md).

### Data Products

A data product is anything that drives business value (*e.g.* reports, workbooks, bespoke database or data API). It can leverage additional services and technologies which are not part of Data Landing Zone core architecture such as:

- Reporting with niche requirements, *e.g.* compliance, tax reporting, HR, etc.
- Specialized capabilities that address gaps in the baseline policies.

Since data products are compute or polyglot persistence services, they may only be required depending on certain use cases.

Examples of Data Products include Azure Functions, App Service, Logic Apps, Azure Analysis Services, Cognitive Services, Azure Machine Learning, Azure SQL DB, Azure MySQL, and Azure CosmosDB.

>[!IMPORTANT]
>A **data product** is data from a domain READ data source which has had some data transformation applied. This could be a newly curated dataset or a BI report.

For further reading, see [Data Landing Zone Data Products](data-landing-zone-data-products.md).

### Data Platform Operational Excellence

The Enterprise Scale Analytics and AI platform was designed with data platform operational excellence at its core through self-service enablement, governance and streamlined deployments. The working model for data operations enables these core principles through the use of Infrastructure as Code, deployment templates, deployment processes that includes a forking and branching strategy and a central repository.

For further reading, see [Platform automation and DevOps](dataops.md).

<!-- ### Data Science Environment

A **data science environment** following the Enterprise Scale Analytics and AI solution pattern, enables data scientists, business analyst and developers to benefit from many types of services, which can be quickly deployed to a [Data Product](#data-products).

For further reading, see [Data Science Environment](data-science-environment.md).

### Data Science Workflow and MLOps

On Enterprise Scale Analytics and AI platform there is a rigor process in place that allows data science teams to structure their projects and leverage git to share code and other artifacts.

For further reading, see [Data Science Workflow and MLOps](data-science-workflow-and-mlops.md). -->