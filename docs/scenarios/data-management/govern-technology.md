---
title: Technology needed for end-to-end governance in Azure
description: Learn about the technology needed for end to end governance in Azure.
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Technology needed for end-to-end governance

In the context of technology needed for end-to-end data governance, Microsoft provides its own technologies and also partner technologies on Azure. Microsoft provides the following technology components to assist you in governing data:

- Common Data Model
- Azure Data Lake Storage
- Azure Data Factory
- Azure Purview

## Common Data Model

The first step in data governance is to create a common business vocabulary of common data names and definitions describing logical data entities that can be shared across the enterprise. For example, customer, account, product, supplier, orders, payments, and returns. Once you've created a common business vocabulary, it becomes possible to create these common data assets. You can store them where their reuse can be maximized to drive consistency everywhere.

The graphic below shows some elements of the [standard entities](https://github.com/microsoft/CDM/tree/master/schemaDocuments/core/applicationCommon) available within Common Data Model. More information: [Common Data Model repository on GitHub](https://aka.ms/cdmrepo).

:::image type="content" source="images/cdm-entities-v1.png" alt-text="Common Data Model poster" lightbox="images/cdm-entities-v1.png":::

[Download the Common Data Model poster](https://aka.ms/cdmposter)

The Common Data Model is an open, prebuilt set of common business entities and activities used across a business. The Common Data Model can be used to shortcut the creation of your common business vocabulary.

## Azure Data Lake Storage

Azure Data Lake Storage provides a common place to capture, ingest, and integrate data to produce trusted data assets. Common Data Model entities can be created in Azure Data Lake storage. The entities can be accessible to:

- Power BI
- Azure Data Factory
- Azure Databricks
- Azure Synapse Analytics
- Azure Machine Learning

## Microsoft Azure Data Factory

Microsoft Azure Data Factory is a fully managed, pay-as-you-use, hybrid data integration service. You can use it for highly scalable extract, transform, load (ETL) and extract, load, transform (ELT) processing. It uses Spark to process and analyze data in parallel and in memory to maximize throughput.

It supports over 80 connectors to external data sources and databases and has templates for common data integration tasks. A visual front-end browser-based GUI enables non-programmers to create and run process pipelines to ingest, transform, and load data. More experienced programmers can incorporate custom code if necessary, for example, Python programs.

Development of simple or comprehensive extract, transform, load (ETL) and extract, load, transform (ELT) processes without coding or maintenance can be easily achieved. This process includes ingest, move, prepare, transform, and process your data. Scheduling and triggers can also be designed and managed within Azure Data Factory to build an automated data integration and loading environment. It can produce trusted data assets that are described in the Azure Data Catalog business glossary.

Azure Data Factory can be used to implement and manage a hybrid environment, which includes connectivity to on-premises, cloud, edge streaming, and software as a service (SaaS) data, in a secure and consistent way.

:::image type="content" source="./images/data-factory-wrangling-data-flows.png" alt-text="Diagram of data factory wrangling data flows." lightbox="images/data-factory-wrangling-data-flows-zoom.png":::

Azure Data Factory wrangling data flows enable business users to make use of the platform to visually discover, explore, and prepare data at scale without writing code. The Azure Data Factory capability is similar to Microsoft Excel Power Query or Microsoft Power BI data flows. Business users use a spreadsheet style user interface with dropdown lists to transform, prepare, and integrate data.

## Azure Purview

Azure Purview is a unified data governance service that helps you manage and govern your on-premises, multicloud, and SaaS data. You can easily create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. Azure Purview empowers data consumers to find valuable and trustworthy data.

Azure Purview data map provides the foundation for data discovery and effective data governance. Azure Purview data map is a cloud native PaaS service that captures metadata about enterprise data present in analytics and operation systems on-premises and cloud. Azure Purview data map is automatically kept up to date with built-in automated scanning and classification system. Business users can configure and use the Azure Purview data map through an intuitive UI. Developers can programmatically interact with the data map using open-source Apache Atlas 2.0 APIs.

Azure Purview data map powers the Azure Purview data catalog and Azure Purview data insights as unified experiences within the Azure Purview Studio.

With the Azure Purview data catalog, business and technical users can quickly and easily find relevant data using a search experience with filters based on various lenses like glossary terms, classifications, and sensitivity labels. For subject matter experts, data stewards and officers, the Azure Purview data catalog provides data curation features like business glossary management and the ability to automate tagging of data assets with glossary terms. Data consumers and producers can visually trace the lineage of data assets. This trace start from the operational systems on-premises, through movement, transformation, and enrichment with various data storage and processing systems in the cloud to consumption in an analytics system like Power BI.

With the Azure Purview data insights, data officers and security officers can get a bird's eye view and at a glance understand what data is actively scanned, where sensitive data is located, and how it moves.

## Combine Microsoft technologies to help govern data

In the context of data governance, these technologies can be combined to produce trusted reusable data assets.

:::image type="content" source="./images/data-cataloging.png" alt-text="Diagram of data landing zones in enterprise-scale for analytics and AI.":::

Data in disparate registered data sources across the data landscape can be ingested into Azure Data Lake Storage. It can be integrated using Azure Data Factory to create trusted, commonly understood, reusable Common Data Model data assets. The assets can be persisted back in the data lake published in Azure Purview.

:::image type="content" source="./images/common-infrastructure.png" alt-text="Diagram of common infrastructure.":::

Everything that is underpinned by Azure Data Lake Storage and can then make use of trusted, commonly understood Common Data Model described data assets. The goal is build once, publish in a data marketplace (Azure Purview), and reuse everywhere.

## Next steps

[Manage master data](./govern-master-data.md)
