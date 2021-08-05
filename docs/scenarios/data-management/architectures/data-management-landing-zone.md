---
title: Azure enterprise-scale for analytics and AI data management overview
description: enterprise-scale for analytics and AI architecture data management landing zone overview
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data management landing zone

The data management landing zone is classified as a management function and is at the heart of the enterprise-scale for analytics and AI platform. It's responsible for the governance of the platform and enables communication to ingest data sources from Azure, third-party clouds, and on-premises data sources.

 :::image type="content" source="../images/data-management-overview.png" alt-text="Diagram of data management landing zone overview" lightbox="../images/data-management-overview.png":::

The data management landing zone is a separate subscription that has the standard services of an enterprise-scale framework, but are connected to the data landing zones and connectivity subscription via Virtual Network Peering. It allows the data governance of the data, via crawlers, which connect to the Data Lakes and polyglot storage in the data landing zones.

>[!NOTE]
>Polyglot persistence is an enterprise storage term used to describe choosing different data storage/data stores technologies to support the various data types and their storage needs. Polyglot persistence is essentially the idea that an application can use more than one core database or storage technology.
>[!WARNING]
>The data management landing zone must be deployed as a separate subscription under the platform branch of an enterprise-scale architecture. You can then control the governance across the enterprise. The [Cloud Adoption Framework enterprise-scale architecture](/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) illustrates the way to approach enterprise-scale.

## Data catalog

We recommend having a catalog service provisioned for defining the metadata of the datasets stored across the data landing zones.

The catalog registers and maintains the data information in a centralized place and makes it available for the organization. This ensures that enterprises avoid duplicate datasets caused by redundant data ingestion by different project teams.

Enterprise-scale for analytics and AI relies on [Azure Purview](/azure/purview/overview) to serves as:

* system of registration
* discovery for enterprise data sources
* data classification engine
* policy store
* API for registering and reading data information.
* compliance dashboard hub

Being part of the data management landing zone, the Data Catalog will be able to communicate with each data landing zone via its VNet Peering and Self-Hosted Integration Runtimes. Discovery of datasets in on-premises stores and other public clouds is achieved by more deployments of Self-Hosted Integration Runtimes.

>[!NOTE]
>Although this section of the documentation primarily focuses on using Azure Purview for Data Catalog capabilities combined with the data classification, labeling, and compliance policy enforcement capabilities of Azure Information Protection, we appreciate that many enterprises may have invested in other products such as Alation, Okera, and Collibra. If this is the case, please work with your vendor to apply the principles described for a data management landing zone and get as close as you can. Be aware that some custom integration may be required.

### Data discovery

The Data Discovery or Catalog reflects the state of all the data that the Enterprise owns (the data estate).

The scanning process connects directly to a data source on a schedule.

As a new data landing zone is added to the environment, the associated Data Lakes and Polyglot persistence sources will be registered as sources for the Data Catalog Crawlers to scan.

With this automated discovery of your data estate to populate the catalog, you can crawl metadata from Azure and on-premises data sources, scan your data lakes, blobs, and other supported targets to extract schema for XML, TSV/CSV/PSV/SSV, JSON, Parquet, Avro, and Orc file types. It also allows automated catalog updates through configurable scheduling of scans and scan rule sets.

>[!IMPORTANT]
>As a new data landing zone is added to the environment, the associated Data Lakes and Polyglot storage should be registered through Azure DevOps as a source for the Data Catalog Crawlers to scan.

## Data Classification

Azure Purview allows you to apply system or custom classifications on file, table, or column assets.

Classifications are like subject tags and are used to mark and identify content of a specific type found within your data estate during scanning. Sensitivity labels are used to identify the categories of classification types within your organizational data and to group the policies you wish to apply to each category. It makes use of the same sensitive information types as Microsoft 365, allowing you to stretch your existing security policies and protections across your entire content and data estate.

Azure Purview can scan and automatically classify documents. For example, if you have a file named "multiple.docx" and it has a National ID number in its content, Azure Purview will add a classification such as `EU National Identification Number` in the Asset Detail page.

[Azure Defender for SQL](/azure/azure-sql/database/azure-defender-for-sql)
is a feature available for Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics. It includes functionality for discovering and classifying sensitive data, surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities.

## Data Lineage

Data Lineage plays an important component in an enterprise-scale for analytics and AI solution. Lineage is a factor in ascertaining data quality and validating compliance. Lineage also adds context to datasets and products that allows for discoverable and self-serviceable data products.

One of the primary features of a Data Catalog is the ability to show the lineage between datasets. Azure Purview supports capturing data lineage from three ADF activities: Copy Data, Data Flow, and Execute SSIS Package. In addition to the native integration, custom lineage reporting is also supported via Apache Atlas hooks or REST API.

<!-- increase image size-->
:::image type="content" source="../images/data-lineage.png" alt-text="Data Lineage" lightbox="../images/data-lineage.png":::

>[!IMPORTANT]
>It is recommended that Azure Data Factory be used for ingestion solutions as it will enable data lineage in Azure Purview. Other ingestion patterns should use Apache Atlas API to update Data Lineage as part of their data processing.

## Data Quality Management

Enterprises are advised to continue with their current solution.

In enterprise-scale for analytics and AI Data Integrations will become responsible for producing datasets that are consumed by other data products. Integration Ops owners are responsible for the business-aligned key performance indicators (KPIs) and the service level objectives around consumption of their read data sources.

Data quality should happen as close to the source as possible to avoid quality issues replicating across the analytics and AI estate. Moving quality metrics and validation to the data integration aligns the quality process with the team(s) that are closest to the data and have the deepest understanding of the data asset. Data lineage also provides data quality confidence and should be provided for all datasets and products.

See how data quality can be implemented in [Enforcing data quality](../best-practices/data-ingestion.md#enforce-data-quality).

## Data Modeling Repository

Entity relationship models should be captured and stored in a central location, that resides in the data management landing zone. It gives consumers of the data a single place to go for conceptual diagrams.

[ER Studio](https://www.idera.com/er-studio-enterprise-data-modeling-and-architecture-tools) and [iServer](https://www.orbussoftware.com/data-architecture/) are used by many enterprise customers to model their datasets prior to ingesting.

### Industry specific data models and Common Data Model with Data Lake

An industry data model enables organizations to more holistically capture and define business concepts, refine and integrate processes, and build interoperability in their ecosystem. [Microsoft acquired ADRM Software, a leader in large-scale, industry-specific data models](https://blogs.microsoft.com/blog/2020/06/18/microsoft-acquires-adrm-software-leader-in-large-scale-industry-specific-data-models/) to support this requirement on Azure.

With the Common Data Model (CDM), organizations can use a data format that provides semantic consistency across applications and deployments. With the evolution of the Common Data Model metadata system, the model brings the same structural consistency and semantic meaning to the data stored in Microsoft Azure Data Lake Storage Gen2 with hierarchical namespaces and folders that contain schematized data in standard Common Data Model format. The standardized metadata and self-describing data in an Azure data lake facilitates metadata discovery and interoperability between data producers and data consumers such as Power BI, Azure Data Factory, Azure Databricks, and Azure Machine Learning. When combined, these elements provide centralized data, structured data, fine-grained access control, and semantic consistency for apps and initiatives across the enterprise. See [Use the Common Data Model to optimize Azure Data Lake Storage Gen2](/common-data-model/data-lake).

## Master Data Management

Enterprises have typically invested several years into building out a [Master Data Management system](../govern-master-data.md). Some of the vendors in this space are:

* [SAP Master Data Governance](https://www.sap.com/products/master-data-governance.html)
* [Semarchy](https://www.semarchy.com/)
* [Profisee](https://profisee.com/)

Using Azure Data Factory, you can pull current master data via the Master Data Management's API and join with the data to be enriches or curated.

Many Master Data Management solutions are fully integrated with Azure Active Directory, which allows you to secure the data and provide different views for different user groups.

### Approaches

Enterprises have developed many different approaches to Master Data Management. The list below includes some of the more common approaches and how they can be implemented within the enterprise-scale for analytics and AI framework.

#### Registry

A central repository exists for all master data keys. The "registry" lives in the data management landing zone, but each data landing zone owns its own master data repository. This model allows a centralized lookup while still supporting different source locations for master data.

Changes to master data continue to be made in the source systems. It allows source systems to independently manage the quality of their master data. This approach also helps to support many distributed sources of master data.

#### Consolidation

Master data from across the data landing zones is consolidated into one hub in the data management landing zone. Updates made to source master data are written back to the source system. It's the quickest and simplest model if you have no existing Master Data Management system.

#### Coexistence

This approach allows you to establish a single version of the truth in the same way the consolidation style does. The difference is that the data management landing zone stores master data while updates can also take place in the source systems. All of the master data model attributes must have consistency. Cleansing must take place before uploading them into the MDM system. Master data changes can happen in both the MDS system and application systems. Data from the hub can be published back to sources.

Master Data is consolidated into one hub in the data management landing zone. Master Data from data landing zones is consolidated into the central hub. Updates made to source Master Data are written back to the source system. It's the quickest and simplest model if you have no existing Master Data Management system.

#### Centralized

Centralized builds on the Coexistence approach. There exists a central Master Data Management repository in the data management landing zone representing the truth, also known as **the Golden Record**. Master data can be pulled from various systems and consolidated into a central hub. Applications and systems use this as the source of Master Data. Source systems can subscribe to updates published by the central hub.

>[!IMPORTANT]
>Regardless the Master Data Management approach chosen, we recommend that the Master Data Management hub or registry be hosted in the data management landing zone. The sources of the master data should be distributed among data landing zones as architecturally appropriate.

## API catalog

It is likely that teams across the enterprise will create various APIs for their data platforms and products. These APIs can be difficult to discover across the organization. Placing an API Catalog in the data management landing zone can help solve this problem.

The API Catalog can help standardize documentation and offers a place for internal collaboration on APIs.  It can also help drive consumption, publishing, and governance controls across the organization.

### Data sharing and contracts

Although enterprise-scale for analytics and AI uses
[Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview)
to control access and sharing of data, the enterprise might require a sharing and contract repository. As this is an organizational function, the repository should reside in the data management landing zone.

These contracts should give information on data validation, model, and security policies. See [Data sharing agreements](../govern-data-sharing-agreements.md).

## Data lifecycle

Data products may have different lifecycles. We recommend applying policies to regulate the data lifecycle. A typical pattern is that newly ingested data is used and accessed often. As the age since ingesting increases, the rate of data access decreases. Older data will see a drastic drop in usage. Your data products and entities in these products may have different lifecycles. Some data can stay unused after the initial ingestion or is rarely accessed once stored. Some datasets may expire days or months after creation, while other datasets are actively used and modified throughout their lifetimes. Most countries have regulations related to how long you are required to store data such as PII and accounting data. For example, a country might require retention of primary documentation for five years, like incoming and outgoing invoices, cash book balances, bank vouchers, and salary slips. Retention of secondary documentation for three to five years, like letters, agreements, and notes.

In Azure, the data lifecycle is handled by each relevant service containing persisted data.

[Lifecycle management](../best-practices/data-lake-key-considerations.md#lifecycle-management) for enterprise-scale for analytics and AI outlines more considerations around the different layers in a Data Lake.

## Automation interfaces (optional)

Enterprise-scale for analytics and AI creates three resource groups to help with the creation of your custom onboarding solutions for your data estate.

Typically, user interfaces would reside in the "governance" resource group. The application layer and database would reside in the "automation" and "automationdb" respectively.

You could use these resource groups to host an application that creates data landing zones, data integrations, and data products. You could develop a logic application to capture feedback and route to the correct teams.

### Ingestion Framework Engine User Interface

If your enterprise has already developed an ingestion framework engine for automatically ingesting data based on registering metadata, which includes connection strings, path to copy data from and to, and ingestion schedule, we suggest this application should reside in the data management landing zone.

For example, you could implement the following workflow for an Ingestion Framework Engine:

1. The Ingestion Engines Framework UI is deployed to the data management landing zone.
1. The application communicates with an Azure Data Factory SQL DB Metastore in each data landing zone to create new data sources for ingestion for landing into the data landing zones.
1. Once Ingest requests have been approved, it will insert the source into the data management landing zone Catalog via its API.
1. The metadata would be used as a driver for Azure Data Factory jobs, and it will have most of the parameters required for running of jobs.
1. ADF Master Pipeline will pull parameters from Metastore to land Raw Data Lake, Enrichment (with conformed data types), and creation of Hive View in Azure Databricks Metastore.

## Container registry

To allow the data platform operations to deploy standard containers for use in data science projects, the data management landing zone hosts an Azure Container Registry.

## Global DNS

Enterprise-scale for analytics and AI uses Private Link, which relies on having a private DNS zone. Check with your networking team before deploying another Private DNS as they might have already deployed the services.

## Synapse Private Link Hub

Azure Synapse Analytics private link hubs are Azure resources, which act as connectors between your secured network and the Synapse Studio web experience. enterprise-scale for analytics and AI uses the hubs to securely connect to Azure Synapse Studio from your Azure virtual network using private links.

There are two steps to connect to Synapse Studio using private links. First, you must create a private link hubs resource. Second, you must create a private endpoint from your Azure virtual network to this private link hub. You can then use private endpoints to securely communicate with Synapse Studio. Integrate the private endpoints with your DNS solution, either in your on-premises solution or with Azure Private DNS.

For more information, see [Connect to Synapse Studio using private links](/azure/synapse-analytics/security/synapse-private-link-hubs).
