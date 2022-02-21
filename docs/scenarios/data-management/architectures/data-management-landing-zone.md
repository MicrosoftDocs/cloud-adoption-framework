---
title: Overview of the data management and analytics scenario data management landing zone in Azure
description: Gain an overview of the data management and analytics scenario data management landing zone in Azure
author: mboswell
ms.author: mboswell
ms.date: 11/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Overview of the data management landing zone

The data management landing zone is classified as a management function and is central to the data management and analytics scenario. It's responsible for the governance of the analytics platform.

 :::image type="content" source="../images/data-management-overview.png" alt-text="Diagram of data management landing zone overview." lightbox="../images/data-management-overview.png":::

The data management landing zone is a separate subscription that has the standard services of an Azure landing zone. They're connected to the data landing zones and connectivity subscription via virtual network peering. It allows the data governance of the data, via crawlers, which connect to the data lakes and polyglot storage in the data landing zones.

> [!NOTE]
> Polyglot persistence is an enterprise storage term used to describe choosing different data storage/data stores technologies to support the various data types and their storage needs. Polyglot persistence is essentially the idea that an application can use more than one core database or storage technology.
> [!WARNING]
> The data management landing zone must be deployed as a separate subscription under the platform branch of an enterprise-scale architecture. You can then control the governance across the enterprise. The [Cloud Adoption Framework enterprise-scale architecture](../../../ready/landing-zone/index.md) illustrates the way to approach enterprise-scale.

## Data catalog

[!INCLUDE [data-catalog](../includes/data-catalog.md)]

- For more information, see [Data Catalog](../govern-data-catalog.md)

## Data quality management

Enterprises are advised to continue with their current solution.

Data quality should happen as close to the source as possible to avoid quality issues replicating across the analytics and AI estate. Moving quality metrics and validation to the data integration aligns the quality process with the teams that are closest to the data. These teams have the deepest understanding of the data asset. Data lineage also provides data quality confidence and should be provided for all data products and products.

- For more information, see [Data quality](../govern-data-quality.md)

## Data modeling repository

Entity relationship models should be captured and stored in a central location, that is in the data management landing zone. It gives consumers of the data a single place to go for conceptual diagrams.

[ER Studio](https://www.idera.com/products/er-studio/enterprise-data-modeling) and [iServer](https://www.orbussoftware.com/solutions/enterprise-architecture/data-architecture) are used by many enterprise customers to model their data products before ingesting.

## Master data management

Master data management control resides in the data management landing zone. For data mesh there are specific considerations to call out in [Master Data Management in Data Mesh](data-mesh-master-data-management.md)

Many master data management solutions fully integrate with Azure Active Directory. The integration allows you to secure the data and provide different views for different user groups.

- For more information, see [master data management system](../govern-master-data.md).

## API catalog

It's likely that teams across the enterprise will create various APIs for their data platforms and products. These APIs can be difficult to discover across the organization. Placing an API catalog in the data management landing zone can help solve this problem.

The API catalog can help standardize documentation and offers a place for internal collaboration on APIs. It can also help drive consumption, publishing, and governance controls across the organization.

## Data sharing and contracts

Data management and analytics scenario uses
[Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview) or Azure Purview policies to control access to sharing of data. Your enterprise still might require a sharing and contract repository. The repository is an organizational function. It should be in the data management landing zone.

These contracts should give information on data validation, model, and security policies.

- For more information, see [Data sharing agreements](../govern-data-sharing-agreements.md).

## Automation interfaces (optional)

Data management and analytics scenario creates three resource groups to help with the creation of your custom onboarding solutions for your data estate.

Typically, user interfaces are in the "governance" resource group. The application layer and database are in `automation` and `automationdb`, respectively.

You could use these resource groups to host an application that creates data landing zones, data integrations, and data products. You could develop a logic application to capture feedback and route to the correct teams.

### Ingestion framework engine user interface

If your enterprise has already developed an ingestion framework engine for automatically ingesting data based on registering metadata, which includes connection strings, path to copy data from and to, and ingestion schedule, we suggest this application should reside in the data management landing zone.

For example, you can implement the following workflow for an ingestion framework engine:

1. The ingestion engines framework UI is deployed to the data management landing zone.
1. The application communicates with an Azure Data Factory SQL Database metastore in each data landing zone to create new data sources for ingestion for landing into the data landing zones.
1. Once ingest requests have been approved, it will insert the source into the data management landing zone catalog via its API.
1. The metadata would be used as a driver for Azure Data Factory jobs, and it will have most of the parameters required for running of jobs.
1. ADF Master Pipeline will pull parameters from Metastore to land raw data lake, enrichment, with conformed data types, and creation of Hive View in Azure Databricks Metastore.

## Container registry

The data management landing zone hosts an Azure Container Registry. It allows the data platform operations to deploy standard containers for use in data science projects.

## Global DNS

Data management and analytics scenario uses Private Link, which relies on having a private DNS zone. Check with your networking team before deploying another private DNS as they might have already deployed the services.

## Azure Synapse Private Link hub

Azure Synapse Analytics Private Link hubs are Azure resources, which act as connectors between your secured network and the synapse studio web experience. Data management and analytics scenario uses the hubs to securely connect to Azure Synapse studio from your Azure Virtual Network using private links.

There are two steps to connect to Azure Synapse studio using private links. First, you must create a Private Link hubs resource. Second, you must create a private endpoint from your Azure Virtual Network to this Private Link hub. You can then use private endpoints to securely communicate with Azure Synapse studio. Integrate the private endpoints with your DNS solution, either in your on-premises solution or with Azure Private DNS.

For more information, see [Connect to Azure Synapse studio using private links](/azure/synapse-analytics/security/synapse-private-link-hubs).

## Next steps

[Overview of the data landing zone](./data-landing-zone.md)
