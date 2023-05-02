---
title: SAP data integration with Azure-Performance and troubleshooting
description: Learn about performance and troubleshooting for SAP data extraction with Azure connectors.
author: pankajmeshramCSA
ms.author: upunatik;dwerifs
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# SAP data integration Reference Architecture

This article is Part 5 of the SAP extend and innovate data: Best practices series. For more information, see [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md), [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md), [Performance and troubleshooting](./sap-lza-data-extraction-performance-troubleshooting.md) and [SAP Data Integration Security](./sap-lza-data-integration-security.md)


The following diagram is an example reference architecture of an SAP Data Integration on Azure. Use this reference architecture as a starting point. You can download the [Visio file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/ready/sap-extend-data-integration-architecture.vsdx) and modify it to fit your specific business and technical requirements. 

:::image type="content" source="./media/sap-extend-data-integration-architecture.svg" border="false" alt-text="Diagram that shows the SAP Data Integration Security architecture on Azure.":::


# Workflow 

The architecture design depicts a general approach to extending SAP solutions with Azure Data services. This article describes the flow of SAP data from source SAP systems (running either on-premises, or SAP RISE on Azure, and SAP on Azure Native IaaS) to several downstream targets each serving a purpose in the Data journey in an Enterprise. Azure Synapse Analytics is used to build a modern data platform to ingest, process, store, serve, and visualize data from various sources. 

## Dataflow 
Dataflow (Source -> Ingest and store -> Process and Model -> Serve and Consume)

### Source:
These are the SAP transactional OLTP (also could be OLAP) systems that constitute as central repositories of business data and transactions. To extract value and insights from this data residing in these business data repositories, extraction is required to store and ingest into Azure. 
These source systems could be hosted either on-premises, or any private/public cloud, or SAP RISE subscriptions, with Azure services and integration possibilities, integrations are possible no matter where the source is located. Depending on the hosted location, security controls, operations standards, bandwidth, and contractual obligations, the extraction configuration must be planned accordingly. The SHIR system should always be in proximity to the source systems

### Ingest and Store 
Data ingestion from SAP is supported by Azure Data Factory and Synapse pipelines and also utilizes SAP’s ODP framework for change data capture.
Azure Data Factory and Synapse pipelines support extracting data using the following SAP connectors.
•	SAP Business Warehouse Open Hub
•	SAP Business Warehouse via MDX
•	SAP CDC
•	SAP Cloud for Customer
•	SAP ECC
•	SAP HANA
•	SAP Table

For more information please see 
[Industry SAP Overview](https://learn.microsoft.com/en-us/azure/data-factory/industry-sap-overview)
[SAP connectors](https://learn.microsoft.com/en-us/azure/data-factory/industry-sap-connectors)
[Data Ingestion](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/cloud-scale-analytics/best-practices/sap-data-ingestion)

For storage of data, Azure provides ADLS (Azure Data Lake storage) built on Azure blob storage.
Data Lake Storage Gen2 makes Azure Storage the foundation for building enterprise data lakes on Azure. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput, Data Lake Storage Gen2 allows you to easily manage massive amounts of data.
[Data lake Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)
[Data lake storage best practices](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-best-practices)


## Transformation and consumption 
There are several services in Azure that cover all aspects of data processing and modeling of data, as well as serve and consume for either analytics, reporting or utilized by web applications or for ML/AI and Data Science/Engineering purposes. As we move towards the right hand side of the architecutre, we dive into the DATA AI and Analytics domain. 

Generally the data flows through the solution as follows: 
The Synapse pipelines copy activities ingest raw structured data from external relational data warehouses, semistructured data such as logs, flat files, and xml, and other source systems. This ingested data is then stored in an Azure Data Lake Storage Gen2 location. Using a self-hosted integration runtime, you can also manage and run copy activities between a data store in your on-premises environment and the cloud. Azure Data Lake Storage Gen2 provides secure storage. 

A firewall could be used to limit Storage Account access to trusted Azure services and is recommended to limit external attack vulnerability. 

Private endpoints for your Azure Storage accounts allow clients on the virtual network (VNet) to securely access data over a Private Link. The private endpoint uses an IP address from the VNet address space for the storage account service. Network traffic between the clients on the VNet and the storage account traverses over the VNet and a private link on the Microsoft backbone network, eliminating exposure to the public internet. 

Data is encrypted at rest once it's ingested into the data lake. Using your own customer-managed keys can further protect your encryption keys and add more flexibility when managing access controls. 

Data is ingested using Synapse pipelines and processed in stages using the Synapse Spark pool and its Data Lake capabilities. Data is stored in the Azure Storage account using stage-specific Azure Data Lake Storage Gen 2 directories. These stages are:

    - The Synapse pipelines copy activities initially ingest data from the source systems. This ingested data is stored in its raw
      format using the data lake's Bronze directory. 
    - The Synapse Spark pool then runs data quality rules to cleanse the raw data. This enriched data is then stored in the data lake's Silver directory. 
    - After the cleansing process, the Spark pool applies any required normalization, data transformations, and business rules on 
      the data in the Silver directory. This transformed data is then stored in the data lake's Gold directory. 
    - The Synapse Apache Spark to Synapse SQL connector pushes the normalized data to the Synapse SQL pool for consumption by downstream applications 
      and reporting services such as Power BI. This connector is designed to optimally transfer data between the serverless Apache Spark pools and the SQL pools in the Azure Synapse Analytics workspace. 

 
# Visualization 
The Power BI service uses DirectQuery mode to securely fetch data from the Synapse SQL pool. A data gateway installed in a virtual machine on the private VNet acts as a connecting platform between the Power BI service and the Synapse SQL pool, using Private Endpoint in the same VNet to securely connect. 
External applications can access data from the Synapse serverless pools or dedicated SQL pools by accessing the appropriate private endpoints connected to the VNet. 

# Components
This example solution makes use of several Azure services and features: 

  - [Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/synapse-analytics/overview-what-is) is the core service used in this example solution to provide data ingestion, processing, and analytics. 

  - [Azure Data Lake Storage (Gen2)](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction) is built on top of Azure Storage services and provides data lake capabilities that other services in this example solution use when storing and processing data. 

  - [Synapse pipelines](https://learn.microsoft.com/en-us/azure/synapse-analytics/get-started-pipelines) copies data from original sources into the data lake storage locations. 

  - [Apache Spark](https://learn.microsoft.com/en-us/azure/synapse-analytics/spark/apache-spark-overview) in Azure Synapse Analytics cleanses, normalizes, and performs other processing tasks on data ingested from source locations. 

  - [Dedicated SQL pool] (https://learn.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-what-is)(formerly SQL DW) provides data warehousing capabilities for data after it's been processed and normalized and is ready 
    for use by your end users and applications. 

  - [Serverless SQL pool](https://learn.microsoft.com/en-us/azure/synapse-analytics/sql/on-demand-workspace-overview) allows users to quickly query and analyze processed and normalized data. 

  - Azure Synapse Managed Virtual Network creates an isolated managed virtual networking environment for the Azure Synapse workspace, offloading 
    the need for you to manage networking configuration for the workspace resources. 

  - Azure Synapse Managed private endpoints establish private links to Azure resources and route traffic between your Azure Synapse workspaces 
    and other Azure resources using only the Microsoft backbone network. 

  - Azure Virtual Network (VNet) provides private networking capabilities for Azure resources that aren't a part of the Azure Synapse workspace. 
    It allows you to manage access, security, and routing between resources. 

  - Azure Private Endpoint provides a private IP address from the solution's VNet to Azure managed services, effectively connecting a service 
    to the VNet. This allows secure networking between the Azure Synapse workspace and other Azure services such as Azure Storage, Azure Cosmos DB, Azure SQL Database, or your own Azure Private Link service. 

  - Power BI allows users to perform advanced analysis and share insights using the solution's processed data. 