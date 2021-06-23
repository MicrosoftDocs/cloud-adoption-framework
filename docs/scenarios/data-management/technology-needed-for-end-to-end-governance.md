---
title: "Technology needed for end to end governance"
description: Technology needed for end to end governance
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Technology needed for end to end governance

In the context of technology needed for end-to-end data governance, Microsoft provides its own technologies and also partner technologies on Azure.
Microsoft provides the following technology components to assist you in governing data:

- Microsoft Common Data Model
- Azure Data Lake Storage
- Azure Data Factory
- Azure Purview

## Microsoft Common Data Model

The first step in data governance is to create a common business vocabulary of common data names and definitions describing logical data entities that can be shared across the enterprise. For example, customer, account, product, supplier, orders, payments, returns etc. Once this has been done, it then becomes possible to create these common data assets and store them where their reuse can be maximized to drive consistency everywhere.

:::image type="content" source="images/common-data-model.png" alt-text="common data model":::

Figure 1: common data model

The Microsoft Common Data Model (CDM) is an open, pre-built set of common business entities and activities used across a business that can be used to shortcut the creation of your common business vocabulary.

## Azure Data Lake Storage

Azure Data Lake Storage (ADLS) provides a common place to capture / ingest and integrate data to produce trusted data assets. CDM entities can be created in Azure Data Lake storage that is accessible to Power BI, Azure Data Factory, Azure Databricks, Azure Synapse Analytics and Azure ML.

## Microsoft Azure Data Factory (ADF)

Microsoft Azure Data Factory is a fully managed, pay-as-you-use, hybrid data integration service for highly scalable ETL and ELT processing. It uses Spark to process and analyse data in parallel and in memory to maximize throughput.

It supports over 80 connectors to external data sources and databases and has templates for common data integration tasks. A visual front-end browser-based GUI enables non- programmers to create and run process pipelines to ingest, transform and load data, while more experienced programmers have the option to incorporate custom code if required (e.g. Python programs).

Development of simple or comprehensive ETL and ELT processes without coding or maintenance, including ingest, move, prepare, transform and process your data can be achieved with a few clicks. Scheduling and triggers can also be designed and managed within Azure Data Factory to build an automated data integration and loading environment for producing trusted data assets that are described in the Azure Data Catalog business glossary.

ADF can be used to implement and manage a hybrid environment, which includes connectivity to on-premise, cloud, edge streaming and SaaS data (e.g. from applications such as Salesforce), in a secure and consistent way.

:::image type="content" source="images/data-factory-wrangling-data-flows.png" alt-text="data factory wrangling data flows" lightbox="images/data-factory-wrangling-data-flows-zoom.png":::

Figure 2: data factory wrangling data flows

ADF wrangling data flows enables business users to make use of the platform to visually discover, explore and prepare data at scale without writing code. This easy to use ADF capability is similar to Microsoft Excel Power Query or Microsoft Power BI Dataflows where business users use a spreadsheet style user interface with drop-down transforms to prepare and integrate data

## Azure Purview (placeholder)

## Combining Microsoft Technologies to Help Govern Data

In the context of data governance, these technologies can be combined to produce trusted reusable data assets. This is shown in Figure 3 and 4.

:::image type="content" source="images/data-cataloging.png" alt-text="Overlaying into data management and analytics construction set":::

Figure 3: Overlaying into data management and analytics construction set

Data in disparate registered data sources across the data landscape can be ingested into Azure Data Lake Storage and integrated using Azure Data Factory to create trusted, commonly understood, reusable CDM data assets that can be persisted back in the data lake published in Azure Purview.

:::image type="content" source="images/common-infrastructure.png" alt-text="common infrastructure":::

Figure 4: Common Infrastructure

Everything that is underpinned by ADLS and can then make use of trusted, commonly understood CDM described data assets The objective is build once, publish in a data marketplace (Azure Purview) and reuse everywhere.