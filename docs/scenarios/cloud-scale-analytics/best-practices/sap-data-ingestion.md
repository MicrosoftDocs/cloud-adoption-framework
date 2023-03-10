---
title: SAP ingestion with cloud-scale analytics in Azure
description: Learn about SAP ingestion with cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# SAP ingestion with cloud-scale analytics in Azure

Azure can support many approaches for extracting and ingesting data from SAP data sources, including from BusinessWare and SAP ERP Central Component (ECC). SAP systems are complex because their monolithic structure cuts across several domains. The recommended pattern is for each business group to ingest their data from SAP into their data landing zone. Data is presented in the enriched layer (having passed through raw) and is accessible subject to Azure Active Directory group access controls. Central finance teams can curate and ingest the finance objects into a single data asset, conducive to their data landing zone's requirements.

Depending on your organization's data volumes and latency requirements, one of three patterns can support your ingest requirements.

## Azure Data Factory

[Data Factory](/azure/data-factory/connector-overview) provides several connectors to SAP systems and various databases (including SAP HANA). These can be used to build simple, code-free data transformations in minutes. Delta replication isn't available out of the box but can be achieved with some programming. Azure Data Factory is only supported for batch processing or microbatches at a minimum of 15-minute intervals.

Described as the **PULL** option, this Data Factory option supports single sign-on and Secure Network Communication authentication into SAP. It also provides the option to use code-free data transformations to build resilient data flows that can integrate with Azure Databricks for flexible data preparation and enrichment coding. It's limited to batch processing and requires coding logic to support delta extracts. You may also want to evaluate the new [SAP ODP connector](/azure/data-factory/sap-change-data-capture-introduction-architecture), which leverages the SAP Operational Data Provisioning (ODP) framework. This new connector can connect to all the SAP systems that support ODP to perform full and incremental data loads.

## SAP Landscape Transformation replication server and business objects data services

SAP Landscape Transformation Replication Server (SLT) is an SAP NetWeaver add-on that uses trigger-based replication to extract data. This service integrates with Business Objects Data Services (BODS) at the source to provide extract, load, and transform capabilities and create the dataset files to be transferred. This option can be considered for both batch and near-real-time ingestion.

Described as the **PUSH** option, this SAP-based option facilitates trigger-based replication and near-real-time extraction with a simple and unified configuration for all SAP data. This requires SAP licensing, additional downstream steps, and scheduling to move data to Azure, including several network hops relying on a file copy tool like AzCopy.

## Third-party tools

There are many third-party tools that can provide value-added extraction and ingestion from SAP sources in real time. Microsoft recommends [Qlik Replicate](https://www.qlik.com/us/products/technology/sap) (previously known as Attunity), [Simplement Data Liberator](https://www.simplement.us/), and [Kagool Velocity](https://www.kagool.com/). Each provides similar functionality and can extract data from SAP in almost real time and provide business context and intelligence out of the box.

These services differ in their technical architecture. Qlik Replicate and Simplement Data Liberator provide near-real-time replication by identifying changes in source database logs. Kagool Velocity uses an add-on to SAP NetWeaver and submits a request for comments to the application layer to expose data. Compared to options mentioned earlier, these options provide better out-of-the-box functionality and near-real-time support, but they require third-party technologies.

## Recommendation
- Our primary recommendation is use the SAP ODP connector as:
  
  - It provides a single connector to connect to SAP ECC Extractors, SAP S/4HANA CDS Views, SAP BW, SAP BW4/HANA, SAP SLT, SAP HANA Views.
  
  - It makes use of the existing CDS views and custom created views that are already provided making it easier to extract data from SAP S/4HANA and SAP BW.
  
  - It can use SLT that allows for trigger based data capture at the table level.
  
  - Using the data flows in Azure Data Factory and Synapse Pipelines, makes data extractions simple with no need for watermarking.
  
  - Data flows provides inbuilt capabilities for applying  changes in the sink using the correct order based on the ODP metadata and completely hides the complexities required for the developers to create custom code to handle inserts/updates/deletes/upserts.
  
  - Data flows uses the ODQ framework’s recovery mechanism transparently requiring no custom logic to run recovery during failed extractions.
  
  - Data flows offer advantage of high throughputs (through parallel reads, partioning etc) to improve the performance of data extractions.
  
- Using a hybrid approach is also an available option and may consist of several options that serve as an ingestion strategy for SAP data. SAP SLT, BODS, and Qlik are used to extract the data from SAP transactional systems (like SAP ECC), and Data Factory pulls the data into Azure to convert it to the Parquet format before writing to Azure Data Lake Storage. It takes advantage of the existing framework by independently extracting data from SAP NetWeaver Business Warehouse.

## Next steps

[How automated ingestion frameworks support cloud-scale analytics in Azure](./automated-ingestion-pattern.md)
