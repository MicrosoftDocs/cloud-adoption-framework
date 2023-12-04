---
title: SAP data integration example architecture
description: Learn about an example architecture for SAP data integration, including the dataflow and necessary components.
author: PmeshramPM
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/18/2023
ms.topic: conceptual
ms.subservice: caf-scenario-sap
ms.custom: think-tank, e2e-sap, UpdateFrequency2
---

# SAP data integration example architecture

This article is part of the "SAP extend and innovate data: Best practices" article series.

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [Data integration security for SAP on Azure](./sap-lza-data-integration-security.md)
- [SAP data integration generic architecture](./sap-lza-data-example-architecture.md)

This article describes the flow of SAP data from source SAP systems to downstream targets. Each target serves a purpose in the data journey for your enterprise. The architecture design extends SAP solutions by using Azure data services. Use Azure Synapse Analytics to build a modern data platform to ingest, process, store, serve, and visualize data from various sources.

## Architecture

The following diagram is an example architecture of an SAP data integration on Azure. Use this example architecture as a starting point.

:::image type="content" source="./media/sap-extend-data-integration-architecture-updated.svg" border="false" alt-text="Diagram that shows the SAP data integration security architecture on Azure." lightbox="./media/sap-extend-data-integration-architecture-updated.svg":::
_Download a [Visio file](https://arch-center.azureedge.net/sap-extend-data-integration-architecture.vsdx) of this architecture._

### Dataflow

The following dataflow corresponds to the previous diagram:

1. **Data sources.** A system connects to a data source to enable data ingestion and analytics.
1. **Data ingestion.** Azure Data Factory and Synapse pipelines enable data integration.
1. **Data storage.** Data is stored in Azure Data Lake Storage that's built on Azure Blob Storage.
1. **Data transformation and consumption.** Data is transformed in stages, and consumption is enabled through reports with Power BI or through private endpoints that allow you to securely access data over a private link.
1. **Data visualization and reporting.** You can access reports and visualize data with the Power BI service or an external application.

#### Data sources

The source SAP systems can run on-premises with SAP RISE on Azure or SAP on Azure Virtual Machines. They can be on-premises SQL servers, semi-structured data in JSON, XML, and log files, or other data warehouse systems. The Synapse pipelines copy activities can ingest this raw data. The source systems are hosted on-premises, in a private or public cloud, or with SAP RISE subscriptions.

SAP online transactional data processing (OLTP) and online analytical processing (OLAP) systems are central repositories of business data and transactions. Extract, store, and ingest data into Azure to obtain value and insights from the data residing in these business data repositories.

With Azure services, you can integrate data from any source location. Plan the extraction configuration based on the hosted location, security controls, operations standards, bandwidth, and contractual obligations.

#### Data ingestion

In this architecture, data is ingested by using Synapse pipelines, and it's processed in stages by using the Data Lake capabilities of Synapse Spark pool.

Data Factory and Synapse pipelines extract data by using the following SAP connectors:

- [SAP Business Warehouse via Open Hub](/azure/data-factory/connector-sap-business-warehouse-open-hub)
- [SAP Business Warehouse via Multidimensional Expressions (MDX)](/azure/data-factory/connector-sap-business-warehouse)
- [SAP Customer Data Cloud (CDC)](/azure/data-factory/connector-sap-change-data-capture)
- [SAP Cloud for Customer](/azure/data-factory/connector-sap-cloud-for-customer)
- [SAP ERP Central Component (ECC)](/azure/data-factory/connector-sap-ecc)
- [SAP HANA](/azure/data-factory/connector-sap-hana)
- [SAP table](/azure/data-factory/connector-sap-table)

For more information, see the following resources:

- [SAP knowledge center overview](/azure/data-factory/industry-sap-overview)
- [SAP connectors](/azure/data-factory/industry-sap-connectors)
- [SAP ingestion with cloud-scale analytics in Azure](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/sap-data-ingestion)

#### Data storage

In Data Lake Storage Gen2, Azure Storage is the foundation for building enterprise data lakes on Azure. With Data Lake Storage Gen2, you can manage huge amounts of data because it services multiple petabytes of information while sustaining hundreds of gigabits of throughput.

Data is encrypted at rest after it's ingested into the data lake. Use your customer-managed keys to further enhance encryption and add access control flexibility.

For more information, see the Data Lake Storage Gen2 [introduction](/azure/storage/blobs/data-lake-storage-introduction)
and [best practices](/azure/storage/blobs/data-lake-storage-best-practices).

#### Data transformation and consumption

In this architecture, the ingested data from the data sources is stored in a Data Lake Storage Gen2 location.

You can manage and run copy activities between a data store in your on-premises environment and the cloud by using a self-hosted integration runtime (SHIR). Always keep the SHIR system in proximity to the source systems.

Store data in your Storage account by using stage-specific Data Lake Storage Gen2 directories, like **Bronze**, **Silver**, and **Gold**.

- **Bronze:** The Synapse pipelines copy activities ingest data from the source systems. This ingested data is stored in raw format by using the data lake's Bronze directory.
- **Silver:** The Synapse Spark pool runs data quality rules to cleanse the raw data. This enriched data is stored in the data lake's Silver directory.
- **Gold:** After the cleansing process, the Spark pool applies any required normalization, data transformations, and business rules to the Silver directory data. This transformed data is stored in the data lake's Gold directory.

The Synapse Apache Spark to Synapse SQL connector pushes the normalized data to the Synapse SQL pool for consumption by downstream applications and reporting services, such as Power BI. This connector optimally transfers data between the serverless Apache Spark pools and the SQL pools in the Azure Synapse Analytics workspace.

For your Storage accounts, private endpoints provide customers on the virtual network secure access to data over a private link. The private endpoint uses an IP address from the virtual network address space for the Storage account service. Network traffic between the customers on the virtual network and the Storage account traverses over the virtual network and a private link on the Microsoft backbone network to eliminate exposure to the public internet.

#### Data visualization and reporting

In the Power BI service, use DirectQuery to securely fetch data from the Synapse SQL pool.

A data gateway installed in a virtual machine on the private virtual network provides a connecting platform between the Power BI service and the Synapse SQL pool. To connect securely, the data gateway uses a private endpoint in the same virtual network.

External applications can access data from the Synapse serverless pools or dedicated SQL pools by using private endpoints that are connected to the virtual network.

## Components

This architecture uses several Azure services and capabilities.

### Data analysis

- [Azure Synapse Analytics](/azure/synapse-analytics/overview-what-is) is the core service that ingests, processes, and analyzes data.
- [Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) is built on top of Storage services and provides data lake capabilities that other services use when storing and processing data.
- [Azure Synapse Analytics pipelines](/azure/synapse-analytics/get-started-pipelines) copy data from sources to Data Lake Storage Gen2 locations.
- [Apache Spark](/azure/synapse-analytics/spark/apache-spark-overview) cleanses, normalizes, and processes data that's ingested from source locations.

### Storage

- The [Azure Synapse Analytics dedicated SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) provides data warehousing capabilities after data is processed and normalized and is ready for customers and applications to use.
- With the [Azure Synapse Analytics serverless SQL pool](/azure/synapse-analytics/sql/on-demand-workspace-overview), you can query and analyze processed and normalized data quickly.

### Networks and load balancers

- An [Azure Synapse Analytics-managed virtual network](/azure/synapse-analytics/security/synapse-workspace-managed-vnet) creates an isolated and managed environment for the Azure Synapse workspace, so you don't have to manage the networking configuration for the workspace resources.
- [Azure Synapse-managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints) establish private links to Azure resources and route traffic between your Azure Synapse workspaces and other Azure resources by using the Microsoft backbone network.
- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview) provides private networking capabilities for Azure resources that aren't a part of the Azure Synapse workspace. You can manage the access, security, and routing between resources.
- An [Azure private endpoint](/azure/private-link/private-endpoint-overview) connects a service to a virtual network by using a private IP address from the solution's virtual network to Azure-managed services. This connection secures the networking between the Azure Synapse workspace and other Azure services, such as Storage, Azure Cosmos DB, Azure SQL Database, or your own Azure Private Link service.

### Reporting

- [Power BI](/power-bi/fundamentals/) performs advanced analysis and insights of the processed data.

## Next steps

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [Data integration security for SAP on Azure](./sap-lza-data-integration-security.md)