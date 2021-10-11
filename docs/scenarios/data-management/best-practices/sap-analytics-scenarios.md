---
title: Common analytics scenarios for SAP data integration in Azure
description: Learn about common analytics scenarios for SAP data integration in Azure
author:  mboswell
ms.author:  mboswell 
ms.date: 09/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Common analytics scenarios for SAP data integration in Azure

## Overview

Probably almost every data architect and consultant, working with enterprise customers, touches SAP systems when designing or implementing enterprise analytics architectures or applications. For enterprise customers typical SAP applications are utilized as enterprise resource planning system (ERP), Line of Business (LoB) SaaS applications, enterprise data-warehouses, business intelligence or integration platforms.

Meanwhile there is a strong momentum of enterprise customers to leverage Microsoft Azure as their platform of choice for infrastructure and their
SAP workloads ([Why customers, including SAP, choose Azure for their SAP solutions  Azure Blog and Updates  Microsoft Azure)](https://azure.microsoft.com/blog/why-customers-including-sap-choose-azure-for-their-sap-solutions/).

Hence combining and extending SAP workloads on Azure, deployed and operated as Infrastructure as a Service (IaaS) or SaaS with Azure Data Services, is the logical next step for our customers and partners.

This document is intended to describe the most relevant SAP applications, related SAP data ingestion best practices and patterns to process SAP data at enterprise scale.

The brief explanation of existing SAP applications should support the assessment of existing SAP landscapes and deployments.

Focus of this recommended assessment is the alignment of the customers SAP product roadmap and strategy with the Microsoft Azure Analytics strategy and roadmap.

One of the results of an assessment might be, that an SAP application is going out of support soon. Therefore, a complex data integration project might not be the right decision, if the successor and the corresponding migration of this SAP application, is already planned and includes a technology- and data-model change.

Important to highlight as well, is that SAP systems typically are run under strict governed change-management and data-access policies and processes.

Especially highly regulated industries like pharma, defense or finance might have restricted software changes or project releases to SAP systems. Even smaller changes, like new roles and authorization for a technical data extraction user, might have to follow strict release cycles and must be approved by multiple governance teams.

Furthermore, when Enterprise Scale Analytics (ESA) projects and implementations are implemented under strict time constraints, it might be less effort, faster and with less organizational alignment, to set up the connection and data integration to Azure services with an established SAP data integration tool.

For this reason, this document as well gives an overview about SAP data integration tools and connectivity options to Microsoft and Azure services.

Prerequisite to design architectures ingesting data from SAP is access to the SAP support portal with a so-called S-User. This S-User is
required to access the products availability matrix (PAM) and SAP notes on the [SAP Support Portal Home](https://support.sap.com/en/index.html) to lookup validated configurations, support timelines and product roadmaps.

When working with customers and partners, there are three major application patterns or **scenarios** when working with SAP applications as data source:

- SAP Business Warehouse Reporting with Microsoft PowerBI
- SQL-based Enterprise Data-Warehousing (EDWH) with Azure Synapse Analytics
- Advanced Analytics and Data Science

:::image type="content" source="../images/sap-high-level-architecture.png" alt-text="SAP high level architecture":::

## SAP Business Warehouse reporting with Microsoft PowerBI scenario

To leverage many person years of investments into building SAP Business Warehouse (BW) systems and respective SAP BW reporting applications, customers are using Microsoft PowerBI (PBI) to directly connect against SAP BW or SAP HANA systems.

Balance sheets, profit and loss statements or tax-reporting are business scenarios, which are implemented with SAP BW queries and can be consumed with Power BI as frontend.

PowerBI is certified for integration with SAP BW and SAP BW/4HANA. The certification process approves the support of specific functionality like accessing SAP BW metadata and master data.

PBI utilizes two connectivity modes when working with SAP BW, the Import and Direct Query mode.

:::image type="content" source="../images/overview-powerbi-sap-bw.png" alt-text="Overview PowerBI and SAP BW":::

Image source: [SAP Business Warehouse fundamentals  Microsoft Docs](/power-query/connectors/sap-bw/sap-bw-fundamentals)

### PowerBI direct query

The direct query mode allows PBI-users to consume SAP BW Queries and to reuse the SAP BW OLAP processing and authorization concepts.

It is important to mention, that not all SAP Query features and functionalities are supported by the public SAP interface which PBI implements.

DirectQuery and SAP Business Warehouse (BW) in Power BI - Power BI Microsoft Docs \[link\]

In customer environments this means, that not all existing complex SAP BW queries can be consumed with PBI, since unsupported features might be heavily used.

Best practices here would be to design specific SAP BW queries, by considering the limitations mentioned above.

It must be considered as well, that PowerBI treats Direct Query with OLAP sources differently to relational sources. For example, the Power Query Editor is not available.

### PowerBI import

For users who would like to use the Power Query Editor, PBI also provides an import option for SAP BW objects. Instead of executing direct queries and utilizing the SAP BW OLAP engine and SAP queries, the import mode will import the SAP BW data-objects to PowerBI. Advantage of this method is the full availability of Power Query features like the Power Query editor.

As well important to consider, when using the import connection, is the fact that the SAP authorizations are not applied anymore. In comparison to executing a Direct Query with either SSO or a named SAP user (Basic Authentication).

### Generated SAP HANA views from the SAP BW system

From SAP BW7.5 on HANA on, there is the possibility to generate a SAP HANA view from SAP BW objects.

[External SAP HANA Views - SAP NetWeaver Business Warehouse - Community Wiki](https://wiki.scn.sap.com/wiki/display/BI/External+SAP+HANA+Views)

These generated HANA views then are available for consumption with the PowerBI Direct Query connection for SAP HANA. Since those SAP HANA views are not processed through the SAP NetWeaver application servers, performance improvements are to be expected compared to the SAP BW MDX processing.

Important to highlight is the fact, that not only SAP BW objects are translated into multidimensional HANA views. SAP BW analysis authorizations are also translated into relational SAP HANA authorizations.

The translation into SAP HANA objects does not support all details and functionality of SAP modeling objects. One recommendation is to compare the constraints with the reporting requirements, to determine if mandatory SAP BW features are not supported.

[Generating SAP HANA Views from the BW System - SAP Help Portal](https://help.sap.com/viewer/04030263a0d041309a039fa3ea586720/7.5.3/en-US/6633d851345c4770bd4e523701b9f5b0.html)

Hence, this approach is a relevant variant to consume SAP BW models in a performing and relational access method. Including the translation and utilization of SAP BW authorization concepts.

The HANA runtime license for SAP BW differentiates between synchronous(Direct Query) and asynchronous(Import / Data extraction) access patterns. Please find further information about the HANA runtime licenses in chapter 7 "Licensing".

Recommended as well, is the clarification with the SAP account representative, if the SAP HANA Direct Query mode is applicable to asynchronous access patterns.

## SQL-based Enterprise Data-Warehousing (EDWH) with Azure Synapse Analytics scenario

The assessment of existing EDWH applications and corresponding data-sources will indicate, that SAP applications have a significant influence on data models, semantics, authorization-concepts and reporting requirements.

Hence, ingesting data from SAP-source systems and creating specific data-models, will be a common requirement in Azure Synapse Analytics migration- or Greenfield-projects.

These SAP specific EWDH domain- and data-models, typically related to accounting, material management or sales and distribution, will require specific semantics in the form of master- and movement data from the SAP source systems. This leads to typical challenges when integrating SAP data-sources.

### Challenges with SAP Data Integration in EDWH projects

Typical challenges and requirements, when working with SAP source system specific data-models within a EDWH project, are:

- How to determine change data capture (CDC, related extraction performance and source schema)?
- How to extract or leverage rich metadata and business entities?
- SAP organization and product hierarchies
- Complex currency conversions
- Advanced key figure calculations like non-cumulative key figures. For example: "How to model a General Ledger or Profit Center Accounting?"
- How to re-apply SAP authorizations and security concepts?

To deal with these challenges, the recommended best practice is to use and leverage predefined SAP data models or accelerators for the Azure
Data Platform.

- Examples for partner accelerators

  - Kagool: [All products -- Microsoft Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/kagool.velocity-kagool?tab=Overview)
  - Qlik: SAP Solution Accelerators. [Data Integration and SAP Data Analytics Solutions  Qlik](https://www.qlik.com/us/products/technology/sap)
  - Verovis: [SAP on Azure: SAP Data Pool (microsoft.com)](https://azuremarketplace.microsoft.com/marketplace/apps/verovisgmbh.adva_app_sapdwh)
  - Simplement: [Solution Templates - Simplement, Inc.](https://www.simplement.us/Home/SolutionTemplates)

Remark: If a Microsoft partner accelerator is missing, please open an issue on GitHub for this document.

## Advanced analytics and data science scenario

### Implement AI/ML scenarios with data form SAP applications

Many data-scientist choose tools like Apache Spark or TensorFlow to implement advanced analytics and machine learning scenarios. For enterprise customers data-science scenarios are very frequently either focused on SAP data or data from SAP systems are partially required to implement their overall scenario.

Prominent examples here are related to modern finance where machine learning on top of SAP data is used to improve financial- or cash-liquidity forecasting:

- Microsoft Modern Finance Story: FSI Fridays #30 -- YouTube [Link](https://youtu.be/nmWSD6PtNDY)
- Microsoft Customer Story-Grid operator TransnetBW uses Microsoft Azure to modernize liquidity management [Link](https://customers.microsoft.com/story/859513-transnetbw-azure-en)

In comparison to tabular or relational SQL-based Data-warehousing, machine learning and data-science applications typically process and query large datasets from cloud-based object or blob storages in columnar and compressed file format like parquet.

As consequence for SAP data ingestion, the first layer for exporting and further processing SAP data, is a cloud-based data-lake like Azure Data-Lake Gen2 (ADLS Gen2).

This first layer provides the entry point as well, for further processing and transforming the data for SQL Data Warehousing with Azure Synapse Analytics.

In later chapters this document will provide best practices and recommendations for design SAP data ingestion specific hierarchical folder structures on Azure Data Lake Gen2.

In data-warehousing projects data-engineers with SAP domain knowledge curate specific reporting or analytical data models for consumption by business or PowerBI users. Data-science projects often require applying the algorithms on the raw or transactional data level, before DWH specific transformations, harmonization and aggregations are applied.

In terms of business outcome and process integration, data-science projects and their results typically add the most value, when the predictions are made available, for example as decision support, to operational processes within the SAP transactional systems and user-interface.

Examples for advanced analytics scenarios leveraging SAP data-sources and processes:

- Multi-channel (Receipt or online store) demand forecasting and price optimization for retail customers
- Predictive Maintenance notifications based on IoT data and anomaly detection.
- Liquidity and cash forecasting for financial data
- Buying propensity or product recommendations using customer or marketing data
- Anomaly and fraud detection of suspicious financial transactions
- Inventory Optimization
- Demand Forecasting

For the scenarios described above, the data-science algorithms will have to learn from historical data and the resulting models need to be applied on the latest transactional SAP data-models and business processes. Also note that the needed data might not come from the SAP system alone. Most probably the SAP data needs to be supplemented with external data. Eg. IoT sensor data, social media, shop floor data logistics providers.

This brings the challenge of curating and understanding the SAP transactional raw data structure, including the representation of business processes in these structures.

An addition there could be the case, where SAP BW, or an EDWH in general, might not be a good source for certain data-science models. Since the transactional data was already cleansed, harmonized and aggregated to a data-warehousing data model.

On the other hand, a SAP BW might contain longer time series of data, which was already archived in the transactional source system.

Example here could be retail data, where the granularity of customer receipts would only be stored for two years. After two years, the
granularity would only be available on daily store and product aggregation level.

Best practice here is to maintain data catalogs and to describe the data models and SAP data on transaction raw data, e.g., ERP, and data-warehousing (SAP BW) level. This will allow data-scientist to focus on their scientific expertise and to efficiently consume SAP related datasets.

Azure Purview supports SAP ECC and SAP S/4HANA for scanning the tabular model:[Register SAP S/4HANA source and setup scans in Azure Purview - Azure Purview | Microsoft Docs](/azure/purview/register-scan-saps4hana-source)

Further information about Purview and SAP can be found here:

[Introduction to Azure Purview (preview) - Azure Purview  Microsoft Docs](/azure/purview/overview)

[Register and scan SAP ECC or SAP S4HANA source in Azure Purview - YouTube](https://www.youtube.com/watch?v=Q9aIs9cnmps)