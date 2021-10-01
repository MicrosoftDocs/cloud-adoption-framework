---
title: Understand how to integrate SAP applications with the data management and analytics scenario in Azure
description: Learn about best practices for integrating SAP applications with the data management and analytics scenario
author:  mboswell
ms.author:  mboswell 
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Best practices for integrating SAP applications with the data management and analytics scenario

Following are best practices when designing analytics architectures in enterprise environments where transactional and analytical SAP applications provide business capabilities and services.

## Assess the existing SAP landscape

- Evaluate the current SAP landscape using the brief application and tool descriptions in this document.
- Which business domains and capabilities do these applications cover?
- Which SAP and strategic data- and application-integration tools are implemented?
- In which model and by which service provider are the applications hosted, operated and managed?
- What is the cloud strategy for the SAP applications and landscape?
- How does a standard deployment of a SAP NetWeaver system look like, does the customer use development, quality-assurance, sandbox and productive SAP systems? Is the landscape even more complex to manage software development concurrency in large SAP projects?
- Align the SAP roadmap with the Enterprise Scale Analytics and AI platform roadmap and implementation timeline.
- Understand which SAP systems (and when) will be upgraded or migrated following the SAP product and support roadmap.
- Understand the potential impact of S/4HANA transformations on the ESA platform interfaces and capabilities.
- Avoid integrating of SAP systems out of, or soon ending support.
- Evaluate the impact of out-of-the-box analytical content, that will be provided with upgrades of the SAP S/4HANA project.

For example: [Machine Learning Extensions for SAP S/4HANA processes SAP Blogs](https://blogs.sap.com/2020/08/25/machine-learning-extensions-for-sap-s-4hana-processes/)

- Understand the governance principles and identify responsible teams for SAP data extraction processes.
- Evaluate if obligatory SAP extraction tools like SAP Data-Service are already established for distributing data from SAP systems.
- Jointly work with the SAP basis teams on authorization concepts for technical user required for data extraction from SAP systems.

## Identify relevant SAP applications interfaces and accelerators

- Identity the relevant SAP applications for implementing the specific scenario.
- Select the required extraction interface and extraction method.
- Low-latency or near Realtime replication required?
- SAP ABAP table or SAP ODP based extraction required?
- SaaS application with specific APIs and interfaces?
- Are partner accelerators or predefined data models available for the specific SAP application or domain?
- Examples for partner accelerators

- Kagool: [All products -- Microsoft Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/kagool.velocity-kagool?tab=Overview)
- Qlik: SAP Solution Accelerators. [Data Integration and SAP Data Analytics Solutions Qlik](https://www.qlik.com/us/products/technology/sap)
- Verovis: [SAP on Azure: SAP Data Pool (microsoft.com)](https://azuremarketplace.microsoft.com/marketplace/apps/verovisgmbh.adva_app_sapdwh)
- Simplement: [Solution Templates - Simplement, Inc.](https://www.simplement.us/Home/SolutionTemplates)

## Select the best suitable SAP data integration tool

As guidance, there are three high level options for choosing data integration tools:

- Azure Data Factory
- Partner Solutions
- Established SAP solutions

All solutions must be evaluated with sample evaluation criteria like:

- Does the tool support the required extraction interfaces and methods?
- Are the performance requirements achievable with the tool?
- Does the solution support the required Azure data sinks like high-speed ingestion to Azure Synapse Analytics?
- Is the tool and the tool's access method approved by the SAP basis or governance team? Does the SAP Basis team allow the installation of an add-on, especially applicable in case of Partner tooling.
- Is the tool strategic and future proof according to the vendors roadmap?
- Is the tool's access method covered by the SAP License. This is especially important for direct db access or access via db logs.
- Is the tool certified by SAP, does it require the implementation or deployment on the SAP system?

## Assess supported SAP application versions

When assessing the current SAP environment for data ingestion, it is highly recommended to first look into SAP product availability matrix (PAM) and to check the release of the SAP system. This will help you to avoid connecting SAP systems for data ingestion or integration that are either out of maintenance or will be out of support in the short-term.
Connecting SAP systems which are out of support should be avoided in any circumstance as joint Microsoft & SAP support won't be provided.

## SAP data ingestion with Azure Data Factory

This chapter gives an overview of the SAP data ingestion best practices with Azure Data Factory.

Azure Data Factory supports the following SAP applications and interfaces:

- SAP Business Warehouse Open Hub
- SAP Business Warehouse via MDX
- SAP HANA (ODBC)
- SAP Table (RFC)
- SAP Cloud for Customer (OData)
- SAP ECC (OData)

Mandatory read, to get a better understanding and overview about SAP data integration with SAP systems, is this [document by the Azure Data Factory Team](https://github.com/Azure/Azure-DataFactory/blob/main/whitepaper/SAP%20Data%20Integration%20using%20Azure%20Data%20Factory.pdf)

In addition, there are comprehensive examples and tutorials provided by the community:

- [bdelangh/ADF_SAPDataExtraction: How to extract data from SAP using Azure Data Factory (github.com)](https://github.com/bdelangh/ADF_SAPDataExtraction)
- [SAP Data & AI Microhack](https://github.com/thzandvl/microhack-sap-data)

This document will focus on data integration using SAP BW and SAP ECC & S/4HANA, which are the most common scenarios.

### Azure Data Factory connectors

#### SAP BW and MDX

In case a SAP BW is the required data-source for data-extraction, ADF provides the Open-Hub and MDX connector.

The MDX connects against SAP BW Bex queries or directly against BW Info Cubes. Since the MDX protocol is primarily designed for communication between BI-tools like Power BI and SAP BW, frequent mass data exports will not meet the performance requirements.

SAP BW queries will be a good fit, if smaller amounts of data will be extracted with very specific focus on business rules or logic, usually created by Power-Users, in the SAP BW queries is required.

[OT-MDX - SAP NetWeaver Business Warehouse - Community Wiki](https://wiki.scn.sap.com/wiki/display/BI/OT-MDX)

Important to mention is the missing CDC support in this scenario since SAP BW queries and MDX are not designed as data export tools.

This connector does currently not support SAP BW/4HANA, as consequence customer would have to migrate their ADF BW MDX developments when they upgrade to SAP BW/4HANA.

#### SAP BW via Open Hub

For mass data extraction from SAP BW, ADF provides the SAP BW Open-Hub connector.

[Copy data from SAP Business Warehouse via Open Hub - Azure Data Factory Microsoft Docs](/azure/data-factory/connector-sap-business-warehouse-open-hub)

As documented in the ADF Open-Hub connector documentation, the connector provides the option to connect against multiple DWH-layers of the SAP BW. Depending in the scenario, data could be extracted from the staging,
harmonization or reporting layer. Please refer to the LSA++ document, to get a deeper understanding of the data-warehousing concepts, layers and terms of SAP BW.

[SAP NetWeaver BW LSA++](https://www.sap.com/documents/2015/07/bc549283-577c-0010-82c7-eda71af511fa.html)

This connector does currently not support SAP BW/4HANA, as consequence customers would have to replace their ADF BW Open-Hub developments, when they upgrade to SAP BW/4HANA. A possible work-around is to have ODP export to for example an SQL Server and have ADF pick up the data from there.

ADF provides a pipeline template for implementing incremental copy using the SAP BW Open-Hub connector.

:::image type="content" source="../images/azure-data-factory-sap-template.png" alt-text="Azure Data Factory SAP Template":::

#### SAP ECC and SAP Table connector

For data extraction from SAP ECC or SAP S/4HANA, ADF provides an SAP ECC and SAP Table connector.

While both connectors are able to extract data from the transactional source system, the connectors utilize different interfaces on the SAP system.

The SAP ECC connector uses OData and the SAP Table connector uses RFC to consume SAP ABAP tables.

[Copy data from SAP ECC - Azure Data Factory Microsoft Docs](/azure/data-factory/connector-sap-ecc)

[Copy data from an SAP table - Azure Data Factory  Microsoft Docs](/azure/data-factory/connector-sap-table)

The SAP ECC connector can consume multiple OData services, provided by the SAP system. While the native RFC connector provides advantages related to the extraction speed.

For mass data extraction the SAP Table connector, considering the following best practices, is the preferred method of SAP data extraction:

### Define technical SAP user for data extraction

Jointly work with the SAP Basis on defining a technical SAP User for connecting the SAP Table connector.

The required SAP authorizations and roles are defined in the ADF documentation under the chapter prerequisites:

[Copy data from an SAP table - Azure Data Factory  Microsoft Docs](/azure/data-factory/connector-sap-table)

### Identify and analyze SAP tables required for data extraction

Each SAP ABAP table requires as specific strategy for data extraction with the ADF SAP table connector.

Most important to identify are table columns to be used in CDC:

- **Timestamps** or similar characteristics to implement CDC using a watermark -- or delta-flag.
- Example: "Modified on" timestamp

- **Incremental column** to implement to implement CDC using a datastore objects on the Azure data hold the latest highest watermark. This is mostly applicable for objects which don't change, for example a record over a financial transaction (ledger) or goods movement transaction
- Example: Incremental Transaction Id

Azure Data Factory contains a pipeline template for implementing Incremental Copy from a SAP Table using Azure Blob Storage.

:::image type="content" source="../images/incremental-copy-from-sap-table.png" alt-text="Incremental copy from SAP table":::

- Partition column for parallelization

Next to identifying columns for incremental data loads, selecting appropriate columns for data load parallelization is key for performant data ingestion using the SAP table connector. The parallelization of the loads is achieved with partitioning criteria over columns.

Example for partitioning criteria:

- **SAP Table:** VBAP
- **Partitioning Column**: ERDAT
- Lower bound: 20200101 (Only load data starting from January 1st, 2020)
- Upper bound: 0 (Till now)
- **Sample Partitioning**: 16
- Equally distributed number of records for all records contained in VBAP for 2020 until now
- 16.000.000 records since January 1^st^2020
- Load chunks of 1 million records per job with 16 jobs in parallel

In case the SAP table doesn't provide an incremental or timestamp criterion to implement delta or CDC loads, the partitioning criteria is still an option for achieving fast data ingestion by parallelization of the ingestion jobs.

### ADF Accelerator for SAP tables

To speed up and simplify the data ingestion of SAP data using ADF, Bartosz Jarkowski & Marius Panga started a project for a ADF Accelerator for SAP tables on GitHub.

The accelerator aims to simplify the integration of SAP tables in Azure Data Factory using a metadata driven approach configurable via a Power App.

The accelerator provides preconfigured parameters, like timestamp or partitioning columns, for a set of frequently used SAP tables. Next to providing best practice configurations for SAP tables, the accelerator
has the option to utilize predefined templates for SAP areas like Business Partner or Master Data. Each template then consists of multiple preselected SAP tables which belong to this specific area.

[mariuspc/saptable-adf-starter (github.com)].

[#43 - The One with the ADF Accelerator for SAP (Bartosz Jarkowski & Marius Panga)  SAP on Azure -YouTube](https://www.youtube.com/watch?v=1aqJo7KY6JA)

## Data lake zones and hierarchical folder structure

Before designing the specifics of data lake zones and folder structures, the first design of zones and folders should follow the best practices, defined for data lake services:

[Data Lake landing zones](../data-lake-zones.md)

Specific to consider about SAP is the fact, that initial application developments will have to take place on data provided by the SAP development system. Which is typically a small set of developer generated data.

The next stage will be the SAP QA -systems, where a larger amount of pseudonymized or anonymized records will be available for testing.

Productive SAP data is only accessible to authorized business users and in many cases not at all to the developers of the analytics applications. Sample scenarios here could be HR payroll data, private
banking customer relationship data, the travel expenses of the CEO office or person related data in general.

In practice this means, developers will hardly get the opportunity to test or debug their analytics developments or applications on productive SAP data.

For this reason, the data lake zones should distinguish between these stages of SAP systems and correlated data availability, quality and accessibility.

The elements for the designing the unique folder structure could be the development stage, the unique SAP system, the table combined with a load timestamp.

:::image type="content" source="../images/sap-sample-folder-structure.png" alt-text="SAP sample folder structure":::

## Licensing

In practice data ingestion from SAP systems will have to consider the impact on SAP licensing terms.

Recommended documents here are:

- [Indirect Access Guide for SAP Installed Base Customers](https://www.sap.com/documents/2019/05/eadfa9d2-4a7d-0010-87a3-c30de2ffd8ff.html), especially the indirect access related explanation On-premise software usage rights, especially the terms related SAP HANA runtime usage rights.
- [Product Use & Support Terms  About SAP](https://www.sap.com/about/trust-center/agreements/on-premise/product-use-and-support-terms.html?tag=agreements:product-use-support-terms/on-premise-software/software-use-rights&tag=language:english&sort=latest_desc&pdf-asset=f02f1161-db7d-0010-87a3-c30de2ffd8ff&page=1)