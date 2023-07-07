---
title: SAP data integration example architecture
description: Learn about an example architecture for SAP data integration, including the dataflow and necessary components.
author: pankajmeshramCSA
ms.author: pameshra
ms.reviewer: tozimmergren
ms.date: 07/04/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap, UpdateFrequency2
---

# SAP data integration example architecture

This article is part of the "SAP extend and innovate data: Best practices" article series.

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [Data integration security for SAP on Azure](./sap-lza-data-integration-security.md)
- [SAP data integration generic architecture](./sap-lza-data-example-architecture.md)

## Architecture

The following diagram is an example architecture of an SAP data integration on Azure. Use this example architecture as a starting point.

:::image type="content" source="./media/sap-extend-data-integration-architecture-updated.svg" border="false" alt-text="Diagram that shows the SAP data integration security architecture on Azure." lightbox="./media/sap-extend-data-integration-architecture-updated.svg":::
_Download a [Visio file](https://arch-center.azureedge.net/sap-extend-data-integration-architecture.vsdx) of this architecture._

### Dataflow

The architecture design depicts a general approach to extending SAP solutions with Azure Data Services. This article describes the flow of SAP data from source SAP systems to several downstream targets, each serving a purpose in the Data journey in an Enterprise. These source SAP systems can, for example,  run either on-premises, with SAP RISE on Azure, or SAP on Azure VMs.

Azure Synapse Analytics is used to build a modern data platform to ingest, process, store, serve, and visualize data from various sources.

The dataflow can be defined with four main pieces:

1. **Data sources:** A system must connect to a data source to enable data ingestion and analytics.
1. **Data ingestion:** Using Azure Data Factory and Synapse pipelines enables data integration.
1. **Data storage:** Azure provides Azure Data Lake Storage (ADLS) built on Azure Blob Storage for data storage.
1. **Data transformation and consumption:** Data is transformed through various stages, and consumption is enabled through reports with Power BI, or through private endpoints allowing clients to access data securely over a Private Link.
1. **Data visualization and reporting:** Accessing reports and visualizing data can either be done through the Power BI service, or for example, using external applications.

The below sections expand further on the dataflow.

#### Data sources

In the example architecture, data sources can include on-premises SQL servers, semi-structured data in, JSON, XML and log files, or other data warehouse systems. The Synapse pipelines copy activities can then ingest this raw data. These source systems could be hosted on-premises, in any private or public cloud, or with SAP RISE subscriptions.

SAP Online Transactional Data Processing (OLTP) or Online Analytical Processing (OLAP) systems constitute central repositories of business data and transactions. Extraction is required to store and ingest into Azure to extract value and insights from the data residing in these business data repositories.

With Azure services, integrations are possible no matter where the source is located. Depending on the hosted location, security controls, operations standards, bandwidth, and contractual obligations, the extraction configuration must be planned accordingly.

#### Data ingestion

In this example architecture, data is ingested using Synapse pipelines and processed in stages using the Synapse Spark pool and its Data Lake capabilities.

Azure Data Factory and Synapse pipelines support extracting data using the following SAP connectors.

- [SAP Business Warehouse Open Hub](/azure/data-factory/connector-sap-business-warehouse-open-hub)
- [SAP Business Warehouse via MDX](/azure/data-factory/connector-sap-business-warehouse)
- [SAP CDC](/azure/data-factory/connector-sap-change-data-capture)
- [SAP Cloud for Customer](/azure/data-factory/connector-sap-cloud-for-customer)
- [SAP ECC](/azure/data-factory/connector-sap-ecc)
- [SAP HANA](/azure/data-factory/connector-sap-hana)
- [SAP Table](/azure/data-factory/connector-sap-table)

For more information, see the following resources:

- [Industry SAP Overview](/azure/data-factory/industry-sap-overview)
- [SAP connectors](/azure/data-factory/industry-sap-connectors)
- [Data Ingestion](/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/sap-data-ingestion)

#### Data storage

Data Lake Storage Gen2 makes Azure Storage the foundation for building enterprise data lakes on Azure. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput, Data Lake Storage Gen2 allows you to manage massive amounts of data easily.

Data is encrypted at rest once it's ingested into the data lake. Using your customer-managed keys can further enhance encryption and add more flexibility when managing access controls.

For more information about Azure Data Lake Storage, see these resources:

- [Data lake Storage](/azure/storage/blobs/data-lake-storage-introduction)
- [Data lake storage best practices](/azure/storage/blobs/data-lake-storage-best-practices)

#### Data transformation and consumption

In this example architecture, the ingested data from the data sources is stored in an Azure Data Lake Storage Gen2 location.

You can manage and run copy activities between a data store in your on-premises environment and the cloud using a self-hosted integration runtime. The Self-Hosted Integration Runtime (SHIR) system should always be in proximity to the source systems.

Data is stored in the Azure Storage account using stage-specific Azure Data Lake Storage Gen 2 directories like **Bronze**, **Silver**, and **Gold**:

1. **Bronze:** The Synapse pipelines copy activities initially ingest data from the source systems. This ingested data is stored in raw format using the data lake's Bronze directory.
1. **Silver:** The Synapse Spark pool then runs data quality rules to cleanse the raw data. This enriched data is then stored in the data lake's Silver directory.
1. **Gold:** After the cleansing process, the Spark pool applies any required normalization, data transformations, and business rules to the Silver directory data. This transformed data is then stored in the data lake's Gold directory.

**Enable consumption:**

The Synapse Apache Spark to Synapse SQL connector pushes the normalized data to the Synapse SQL pool for consumption by downstream applications and reporting services such as Power BI. This connector is designed to optimally transfer data between the serverless Apache Spark pools and the SQL pools in the Azure Synapse Analytics workspace.

Private endpoints for your Azure Storage accounts allow clients on the virtual network (VNet) to access data over a Private Link securely. The private endpoint uses an IP address from the VNet address space for the storage account service. Network traffic between the clients on the VNet and the storage account traverses over the VNet and a private link on the Microsoft backbone network, eliminating exposure to the public internet.

#### Data visualization and reporting

In the Power BI service, you can use DirectQuery to fetch data from the Synapse SQL pool securely.

A data gateway installed in a virtual machine on the private VNet is a connecting platform between the Power BI service and the Synapse SQL pool, using a Private Endpoint in the same VNet to connect securely.

External applications can access data from the Synapse serverless pools or dedicated SQL pools by accessing the appropriate private endpoints connected to the VNet.

## Components

This example solution makes use of several Azure services and capabilities:

### Data analysis

- [Azure Synapse Analytics](/azure/synapse-analytics/overview-what-is) is the core service used in this example solution to provide data ingestion, processing, and analytics.
- [Azure Data Lake Storage (Gen2)](/azure/storage/blobs/data-lake-storage-introduction) is built on top of Azure Storage services and provides data lake capabilities that other services in this example solution use when storing and processing data.
- [Azure Synapse Analytics pipelines](/azure/synapse-analytics/get-started-pipelines) copies data from sources into the data lake storage locations.
- [Apache Spark](/azure/synapse-analytics/spark/apache-spark-overview) in Azure Synapse Analytics cleanses, normalizes, and performs other processing tasks on data ingested from source locations.

### Storage

- [Azure Synapse Analytics - Dedicated SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is) provides data warehousing capabilities for data after it's been processed and normalized and is ready for use by your end users and applications.
- [Azure Synapse Analytics - Serverless SQL pool](/azure/synapse-analytics/sql/on-demand-workspace-overview) allows users to query and analyze processed and normalized data quickly.

### Networking and load balancing

- [Azure Synapse Analytics Managed Virtual Network](/azure/synapse-analytics/security/synapse-workspace-managed-vnet) creates an isolated managed virtual networking environment for the Azure Synapse workspace, offloading the need for you to manage networking configuration for the workspace resources.
- [Azure Synapse Managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints) establish private links to Azure resources and route traffic between your Azure Synapse workspaces and other Azure resources using only the Microsoft backbone network.
- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview) (VNet) provides private networking capabilities for Azure resources that aren't a part of the Azure Synapse workspace. It allows you to manage access, security, and routing between resources.
- [Azure Private Endpoint](/azure/private-link/private-endpoint-overview) provides a private IP address from the solution's VNet to Azure managed services, effectively connecting a service to the VNet. This allows secure networking between the Azure Synapse workspace and other Azure services such as Azure Storage, Azure Cosmos DB, Azure SQL Database, or your own Azure Private Link service.

### Reporting

- [Power BI](/power-bi/fundamentals/) allows users to perform advanced analysis and share insights using the solution's processed data.
