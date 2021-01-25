---
# This basic template provides core metadata fields for Markdown articles on docs.microsoft.com.

# Mandatory fields.
title: Enterprise Scale Analytics and AI
description: Enterprise Scale Analytics and AI Architecture Data Management Subscription Overview
author:
ms.author: # Microsoft employees only
ms.date: 12/8/2020
ms.topic: conceptual
ms.service: architecture-center
ms.subservice: enterprise-scale-analytics
# Use ms.service for services or ms.prod for on-prem products. Remove the # before the relevant field.
# ms.service: service-name-from-white-list
# ms.prod: product-name-from-white-list

# Optional fields. Don't forget to remove # if you need a field.
# ms.custom: can-be-multiple-comma-separated
# ms.reviewer: MSFT-alias-of-reviewer
# manager: MSFT-alias-of-manager-or-PM-counterpart
---

# Data Management Subscription

The Data Management Subscription is classified as a management function and is at the heart of the Enterprise Scale Analytics and AI platform. It is responsible for the governance of the platform and enables communication to ingest data sources from Azure, 3rd Party Clouds and On-Premises data sources.

![Data Management Subscription Overview](../images/datamanagementoverview.png)

Figure 1: Data Management Subscription Overview

The Data Management Subscription is a separate subscription which has the standard services of an Enterprise Scale framework but are connected to the nodes and connectivity subscription via Virtual Network Peering. This allows the data governance of the data, via crawlers, which connect to the Data Lakes and polyglot storage in the nodes.

>[!NOTE] Polyglot persistence is an enterprise storage term used to describe choosing different data storage/data stores technologies to support the various data types and their storage needs. Polyglot persistence is essentially the idea that an application can use more than one core database (DB)/storage technology.

>[!WARNING] The Data Management Subscription must be deployed as a separate subscription under the platform branch of an Enterprise Scale architecture. This will allow it to control the governance across the enterprise. The [Cloud Adoption Framework Enterprise-Scale Architecture](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture.) illustrates the way to approach enterprise-scale.

## Data Governance with Azure Purview

It is recommended to have a catalog service provisioned for defining the metadata of the data sets stored across the data nodes.

The catalog registers and maintains the data information on a centralized place and make it available for the organization, this ensures that you avoid redundant data ingestion's from different project teams and duplications of datasets.

[Azure Purview](https://docs.microsoft.com/azure/purview/overview) serves as:

* System of registration
* Discovery for enterprise data sources
* Data Classification
* Policy Store
* API for registering and reading data information.
* Compliance Dashboards

![Azure Purview Overview](../images/purviewoverview.png)

Figure 2: Azure Purview Overview

Being part of the Data Management Subscription, the Data Catalogue will be able to communicate with each Data Node via its VNet Peering and Self-Hosted Integration Runtimes. Data Discovery of on-premise and other public clouds is achieved by additional deployment of Self-Hosted Integration Runtimes.

>[!NOTE] Although this section of the documentation primarily focuses on using Azure Purview for Data Catalog capabilities combined with the data classification, labeling, and compliance policy enforcement capabilities of Azure Information Protection, we appreciate that many enterprises may have invested in other products such as Alation, Okera, Collibra etc. If this is the case then please work with your vendor to apply the principles described for a Data Management Subscription and get as close as you can - some custom integration might be required.

### Data Discovery

The Data Discovery or Catalog reflects the state of all the data that the Enterprise owns (the data estate).

The scanning process connects directly to a data source on a schedule.

As a new Data Landing Zone is added to the environment the associated Data Lakes and Polyglot persistence sources will be registered as a source for the Data Catalogue Crawlers to scan.

With this automated discovery of your data estate to populate the catalog, this will enable you to crawl metadata from Azure and on premises data sources, scan your data lakes, blobs, and other supported targets to extract schema for XML, TSV/CSV/PSV/SSV, JSON, Parquet, Avro, and Orc file types, and automate Catalog updates through configurable scheduling of scans and scan rule sets.

>[!IMPORTANT] As a new Data Landing Zone is added to the environment the associated Data Lakes and Polyglot storage should be registered, via Azure DevOps, as a source for the Data Catalogue Crawlers to scan.

### Integration with Databricks and HDInsight

For integrating data from both the Azure Databricks and HDInsight Hive Metastore you will need to use the Atlas API to update Azure Purview.

Whilst it is possible to reverse engineer the table form by scanning all the Parquet files generated by Databricks and HDInsight. It is preferable to enable Catalogues updates by using the metadata which has been created in the Hive Metastore.

The pattern is to have a single Hive Metadata Store in the Data Management Subscription for all Databricks Workspaces and HDInsight instances.

This single database would be scanned by Azure Data Factory to extract the tables and paths to update the Event Data Management Subscription associated with Azure Purview.

>[!TIP] For Enterprise Scale Analytics and AI v1 Databricks sources should be registered via Apache Atlas API into the Azure Purview using an Event Hub.

## Classification

Azure Purview allows you to apply system or custom classifications on File, Table or Column assets.

Classifications are like subject tags and are used to mark and identify content of a specific type found within your data estate during scanning. Sensitivity labels are used to identify the categories of classification types within your organizational data, and the group the policies you wish to apply to each category. It makes use of the same sensitive information types as Microsoft 365, allowing you to stretch your existing security policies and protection across your entire content and data estate.

It can scan and automatically classify documentations. For example, if you have a file named multiple.docx and it has a National ID number in its content, Azure Purview will add classification such as EU National Identification Number in the Asset Detail page.

In addition to Azure Purview; Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics includes Advanced Data Security. It includes functionality for discovering and classifying sensitive data, surfacing, and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities. See [Advanced Data Security](https://docs.microsoft.com/azure/azure-sql/database/advanced-data-security).

## Data Lineage

One of the primary features of a Data Catalog is the ability to show the lineage between datasets. Azure Purview supports capturing data lineage from ADF activities Copy Data, Data flow and Execute SSIS package. In addition to the native integration, custom lineage reporting is also supported via Atlas hooks or REST API.

![Data Lineage](../images/datalineage.png)

Figure 3: Data Lineage

>[!IMPORTANT]It is recommended that Azure Data Factory which should be the default ingestion solutions as it will enable data lineage in Azure Purview and other ingestion patterns should use Apache Atlas API to update Data Lineage as part of their data processing.

## Data Lifecycle

Data products may have different lifecycles. We recommend  applying policies regulating the data lifecycle. Typical patterns experienced are that when the data is newly ingested it is used and access often. As the time since ingesting increases the use of the data decreases. Years old data will see a drastic drop in usage. Your different data products and entities in these products may have different lifecycles. Some data can stays unused after the initial ingest or is rarely accessed once stored. Some data you might want to enforce to expires days or months after creation, while other data sets are actively used and modified throughout their lifetimes. Most countries have regulations related to how long you are required to store data such as PII and accounting data. As an example a country requires retention of primary documentation for 5 years (incoming and outgoing invoices, cash book balances, bank vouchers, salary slips, etc.) and retention of secondary documentation for 3.5 years (letters, agreements, notes etc).

In Azure this data lifecycle is handled by each relevant service containing persisted data.

Azure Blob Storage lifecycle management uses a rule-based policy. You should use the policy to transition your data to the appropriate access tiers or expire at the end of the data's lifecycle.

The lifecycle management policy lets you:

* Transition blobs from cool to hot immediately if accessed to optimize for performance
* Transition blobs, blob versions, and blob snapshots to a cooler storage tier (hot to cool, hot to archive, or cool to archive) if not accessed or modified for a period of time to optimize for cost
* Delete blobs, blob versions, and blob snapshots at the end of their lifecycles
* Define rules to be run once per day at the storage account level
* Apply rules to containers or a subset of blobs (using name prefixes or blob index tags as filters)

In a scenario where data is used frequently during the first stages of the lifecycle, but only occasionally after a month. Later than a month, the data set is rarely used. In this scenario, hot storage is best during the first month. Cool storage is most cost optimal for occasional access. Archive storage is the best tier option after the data gets old. Use a lifecycle management policy rules to move aging data to cooler tiers.

[Data Lake Lifecycle Management](../03-datalandingzones/02-datalakeservices.md#lifecycle-management) for Enterprise Scale Analytics and AI prescribes further thoughts around the different layers in a Data Lake.

## Data Quality Management

Enterprise are advised to continue with their current solution.

## Data Modelling

[ER Studio](https://www.idera.com/er-studio-enterprise-data-modeling-and-architecture-tools) and [iServer](https://www.orbussoftware.com/data-architecture/) are used by many Enterprise Customers to model their datasets prior to ingesting.

## Master Data Management

Master Data Management should be hosted in the Data Management Subscription.

Enterprises have typically invested several years into building out a Master Data Management. Some of the vendors in this space are: -

* [SAP Master Data Governance](https://www.sap.com/products/master-data-governance.html)
* [Semarchy](https://www.semarchy.com/)
* [Profisee](https://profisee.com/)

For the Enterprise Scale Analytics and AI, you should focus on deploying Master Data Management in the Data Management Subscription.

Using Azure Data Factory, you would enable calls to pull current master data, via the Master Data Management's API, and join with the data we are enriching and/or curating.

A number of Master Data Management solutions are fully integrated with Azure Active Directory you can secure the Domains and provide different views for different user groups.

## Ingestion Framework Engine User Interface

If your enterprise has already developed a ingestion framework engine for automatically ingesting data based on registering metadata which includes connection strings, path to copy data from and to, and ingestion schedule then we suggest the application resides in the Data Management Subscription.

For example, you could implement the following workflow for a Ingestion Framework Engine:-

1. The Ingestion Engines Framework UI is deployed to the Data Management Subscription.
1. The application communicates with an Azure Data Factory SQL DB Metastore, in each Data Landing Zone, to create new data sources for ingestion for landing into the Data Landing Zones.
1. Once Ingest requests have been approved it will insert the source into the Data Data Management Subscription Catalogue via its API.
1. The metadata would be used as a driver for Azure Data Factory jobs and it will have most of the parameters required for running of jobs.
1. ADF Master Pipeline will pull parameters from Metastore to land RAW Data Lake, Enrichment (with conformed data types) and creation of Hive View in Azure Databricks Metastore.

## Shared Integration Runtime(s)

![Shared Integration Runtime](../images/datamanagementshir.png)

To enable rapid onboarding of datasets, from the Data Management Subscription, we recommend deploying a pair of Self Hosted Integration Runtimes, **per data node**. in the Data Management Subscription. These should be hosted in the Integration Resource Group.

By having a resource group, within the Data Management Subscription VNET, it allows the whitelisting of the subnet to allow communication to on-premises or Azure cloud sources.

To enable you would need to: -

* Create at least one Azure Data Factory in the entity data node.
* Create at least two Virtual Machines, with a Self-Hosted Integration Runtime inside an availability zone using the [ARM template](https://github.com/Azure/Azure-quickstart-templates/tree/master/101-vms-with-selfhost-integration-runtime).
* [The Self Hosted Integration Runtimes should be setup in high availability mode](https://docs.microsoft.com/Azure/data-factory/create-self-hosted-integration-runtime#high-availability-and-scalability).
* The Self Hosted Integration Runtimes should be associated with Azure Data Factories in the entity data node.
* [Azure Automation should be setup to update the Self Hosted Integration Runtime periodically](https://docs.microsoft.com/Azure/data-factory/self-hosted-integration-runtime-automation-scripts)
* For other Data Factories, in the Data Node, which require access to on-premise data sources, you should give permission from the original Data Node Data Factory to [share the runtimes](https://docs.microsoft.com/Azure/data-factory/create-shared-self-hosted-integration-runtime-powershel).

>[!NOTE]This does not restrict the deployment of Integration Runtimes inside a Data Landing Zone or into 3rd party clouds.

>[!div class="step-by-step"]
>[Previous](../01-overview/05-networking.md)
>[Next](../03-datalandingzones/01-datalandingzone.md)
