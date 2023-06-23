---
title: Identify SAP data sources
description: Learn how to identify SAP applications and connectors to integrate SAP data with Azure data services.
author: pankajmeshramCSA
ms.author: pameshra
ms.date: 01/16/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Identify SAP data sources

This article is part of the "SAP extend and innovate data: Best practices" article series.

- [Identify SAP data sources](./sap-lza-identify-sap-data-sources.md)
- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting for SAP data extraction](./sap-lza-data-extraction-performance-troubleshooting.md)
- [Data integration security for SAP on Azure](./sap-lza-data-integration-security.md)
- [SAP data integration generic architecture](./sap-lza-data-reference-architecture.md)

Digital transformation requires a seamless combination of intelligence derived from data across business operations to meet the business objectives of an enterprise. Enterprises use SAP applications as enterprise resource planning systems (ERP), line of business (LOB) SaaS applications, enterprise data warehouses, business intelligence, or integration platforms. The siloed data in SAP systems can be harnessed to drive business transformation. As you progress through your cloud adoption journey and move business-critical workloads to Azure, prioritize moving SAP workloads to Azure. This method optimally integrates data into your Azure environment.

Customers deployed the SAP landscape by following best practices from SAP landing zone accelerator. The next step is innovation with Azure data services. The logical next step is to combine and extend SAP workloads on Azure, which are deployed and operated as infrastructure as a service (IaaS) or software as a service (SaaS) with Azure data services. When customers combine SAP and non-SAP data and apply advanced data services, such as analytics and AI, they extract real-time, predictive insights. This method improves business outcomes.

## Overview

SAP systems contain data from across the organization that's used to derive insights. In many cases, this data is siloed and isn't integrated with other data sources inside or outside of the organization. The following overview describes the most relevant SAP applications that serve as the source of a data integration initiative.

- SAP Business Suite is a set of core applications, such as [SAP ERP](https://www.sap.com/uk/products/erp/what-is-sap-erp.html), [SAP Customer Relationship Management (CRM)](https://www.sap.com/uk/products/crm.html), [SAP Supply Chain Management (SCM)](https://www.sap.com/uk/products/scm.html), and [SAP Supplier Relationship Management (SRM)](https://help.sap.com/docs/SAP_SUPPLIER_RELATIONSHIP_MANAGEMENT?locale=en-US&version=7.04%20SP05). These applications run on SAP HANA, which is SAP’s in-memory database. Or they can run on any non-SAP database, such as Oracle, Microsoft SQL Server, or IBM Db2.

- [SAP ERP](https://www.sap.com/uk/products/erp/what-is-sap-erp.html) is the most widely used SAP solution for enterprise resource planning. It provides core business functions, such as accounting, logistics, and human capital management.

- [SAP S/4HANA](https://www.sap.com/uk/products/erp/s4hana-private-edition.html) is the next generation of business applications. SAP S/4HANA comes with more data and business models and an HTML5-based user interface. As the name implies, SAP S/4HANA runs only on SAP HANA and provides OLAP and OLTP capabilities in real time.

- SAP BW and [SAP BW/4HANA](https://www.sap.com/products/technology-platform/bw4hana-data-warehousing.html) are SAP’s data warehousing solutions. They present the most common source of SAP business data. Most SAP customers use these solutions as an enterprise data warehouse, departmental data mart, or big data platform to load data from operational SAP source systems. SAP BW/4HANA runs only on SAP HANA. It has a simplified data architecture and open analytics features. Both solutions deliver an integrated data warehousing experience with data modeling, acquisition, integration, and tiering.

Customers might also deploy the following cloud-based analytics and planning solutions in their landscape:

- [SAP Analytics Cloud](https://discovery-center.cloud.sap/serviceCatalog/sap-analytics-cloud?region=all&tab=service_plan&provider=azure&commercialModel=subscription)
- [SAP Data Warehouse Cloud](https://discovery-center.cloud.sap/serviceCatalog/sap-data-warehouse-cloud?region=all&tab=service_plan&provider=azure&service_plan=standard&commercialModel=subscription)

SAP SaaS solutions:

- [SAP S/4HANA Cloud](https://www.sap.com/products/erp/s4hana.html) is the public SaaS version of SAP S/4HANA.
- SAP Customer Experience solutions, such as [SAP Commerce Cloud](https://www.sap.com/products/crm/commerce-cloud.html), [SAP Sales Cloud](https://www.sap.com/products/crm/sales-cloud.html) and [SAP Service Cloud](https://www.sap.com/products/service-management/service-cloud.html).
- [SAP Business Network](https://www.sap.com/products/spend-management/ariba-network.html) for direct and indirect spend.
- [SAP Concur](https://www.concur.com/) for travel and expense.
- [SAP Fieldglass](https://www.fieldglass.com/) for external workforce management.
- [SAP SuccessFactors](https://www.sap.com/products/hcm.html) for human capital management.

### Design considerations

- **Source system** Choose your source system based on existing implementations and business use case. The source SAP environment is on a certain version, such as SAP, OS, and DB versions. Document the source SAP solution, OS, and database version. Typically, the OS, SAP NetWeaver, and database are updated as part of the software lifecycle management. Depending on the customer, they might be updated once or twice a year. Quick changes to software versions aren’t possible in the short term. Options to access a SaaS solution might be more limited than a legacy and on-premises solution. First get familiar with the current solution’s capabilities and limitations concerning the nature of data and its extraction based on business requirements.

- **Licensing** Understand the existing licenses available, and consider the licensing implications before you extract data from SAP systems. Work with your SAP counterparts. Because licensing is a complex subject and the policies might change over time, you can contact your SAP account team for guidance. For more information, see these guides:

  -	[Indirect access guide](https://news.sap.com/wp-content/blogs.dir/1/files/Indirect_Access_Guide_for_SAP_Installed_Base.pdf) for SAP ERP (ECC and SAP S/4HANA) customers with contracts based on SAP pricing policies prior to April 10, 2018.  
  - [ERP pricing for the digital age](https://news.sap.com/wp-content/blogs.dir/1/files/Pricing_for_Digital_Age_Overview.pdf) for the outcome-based ERP pricing introduced on April 10, 2018.

- **SAP HANA** For SAP HANA, you must differentiate between the runtime database and full-use database licenses. Runtime databases only support software that's licensed from SAP. Full-use databases licensed from SAP support SAP and non-SAP software. Full-use SAP HANA databases are licensed based on a gigabyte-of-memory metric. So, third-party data connectors that access the SAP HANA database directly need to have a full-use SAP HANA database license. For more information, see [HANA licensing technical details](https://blogs.sap.com/2021/01/18/technical-details-hana-licensing/) and the [SAP licensing guide](https://www.sapusers.org/uploads/files/5660).

- **OpenHub license** For data extraction from SAP BW on anyDB or SAP HANA, consider the SAP NetWeaver OpenHub license and the SAP OpenHub for S/4HANA license. These licenses are included in the SAP HANA enterprise edition. SAP BW/4HANA doesn't require an OpenHub license. For more information about terms and conditions, see [SAP Software Use Rights (SUR)](https://assets.cdn.sap.com/agreements/product-use-and-support-terms/sur/sap-software-use-rights-english-v1-2022.pdf).

- **SLT licensing** The Operational Data Provisioning (ODP) framework is part of many SAP systems, including SAP ECC and SAP S/4HANA. It's also contained in SAP BW and SAP BW/4HANA. One of the possible ODP providers of the SAP CDC connector is SAP Landscape Transformation Replication Server (SLT). It's a trigger-based data replication technology that allows real-time replication from SAP and/or non-SAP sources to SAP and/or non-SAP targets. For more information, see [SLT Licensing](https://launchpad.support.sap.com/#/notes/2707835). The target system of the replication determines which license you need. If the license of the target system includes the use of SLT, you don't need a separate SLT license. In any other SLT case, including the use of an SAP CDC connector, an SLT full license is required.

- Within a customer organization, there are separate teams that support data integration and SAP projects. Often the data team is unaware of existing OpenHub licenses that enable data extraction from SAP BW by using the OpenHub interface.

- Consider the technical debt of existing SAP BW transformations and investments.

- Azure Data Factory and Azure Synapse Analytics pipelines provide multiple connectors for data extraction from SAP sources. For more information, see [Transform data from an SAP ODP source using the SAP CDC connector](/azure/data-factory/connector-sap-change-data-capture) and [SAP data integration using Azure Data Factory](https://github.com/Azure/Azure-DataFactory/blob/main/whitepaper/SAP%20Data%20Integration%20using%20Azure%20Data%20Factory.pdf).

- **Data analysis** After the source system is identified and its capabilities and limitations are known, consider the following data analysis elements:
  - Source business object.
  - Type of data, such as primary data, transactional data, or language-dependent text data.
  - Source tables and/or views and primary key columns.
  - Full load vs. delta load, data change patterns, data volume, and data compression.
  - Extraction in batches vs. near real-time replication. The minimum interval of a schedule trigger in Azure Synapse is one minute.
  - Data access methods that are provided by the source system.
  - Native Azure or third-party ETL tools and data connectors most suitable for the use case.
  - In a case of an SAP CDC connector, consider the type of ODP provider or context, such as SAPI (DataSources/Extractors), BW (SAP NetWeaver Business Warehouse), ABAP CDS (ABAP Core Data Services), or HANA (HANA information views). In a case of ABAP CDS views, consider the view's supported capabilities and analytics annotations.

### Design recommendations

- If multiple SAP ERP source systems send data to a regional or global central SAP BW instance, the SAP BW system is the default candidate for further data extraction, transformation, and loading into Azure data services.

- In some cases, data extraction from an SAP ERP system into Azure makes more sense. For example, a standalone SAP ERP with no SAP BW connection or data in SAP ERP tables that don't require the transformation logic in an existing SAP BW and can be extracted with data connectors available in Azure. One example is a customer that uses SAP BW as a source and there are a few tables that need to be extracted in full load directly from the SAP ERP system. Another scenario is if the customer's source is an SAP ERP system and it requires a bigger data set.

- If the SAP BW system has many transformations on top of data that's extracted from SAP ERP systems, you might consider an SAP BW Open Hub connector to extract data from SAP BW. Consider your organization’s data strategy and skill set. You might already invest in Azure data services, which can influence your choice of source SAP system.

- If you use the [CDC (change data capture) connector](/azure/data-factory/sap-change-data-capture-introduction-architecture), the following data providers are recommended based on the source system.  

  | SAP source | Data provider |
  |---|---|
  | **ECC** | **ECC extractors**:  An SAP extractor is a program that's used to retrieve data in an SAP source system and transfer it to an SAP Business Warehouse or Business Intelligence system. If you or your partner have experience and knowledge of BW extractors, they're the preferred option. Ensure that you have implementation and operation experience for a successful project.<br><br> **SLT (SAP Landscape Transformation Replication Server)**: If you can't use extractors or if a database trigger option is required, you can rely on original tables and work via SLT. |
  | **S/4 HANA** | **ABAP CDS views**: SAP Core data services (CDS) is an infrastructure for data modeling where data models are defined and consumed on the database server rather than the application server. There are two types of SAP CDS views, HANA CDS views and ABAP CDS views. SAP ABAP CDS views are defined at the application server level. This option is preferred to extract data. Data is easier to consume (multi-dimensional model). Technology is easier to handle because CDS views are like database views, and they can be understood without deep SAP knowledge. Custom CDS views are easier to create and more powerful.<br><br>**Extractors**: Exists in S/4 HANA to fill gaps. Use this provider when you don't have CDS views and the gap is filled with extractors. Ensure that you or your partner have implementation and operational experience for a successful project.<br><br>**SLT (SAP Landscape Transformation Replication Server)**: Connecting to tables. Use this option if the previous two options don't fit the use case. |
  | **BW (BW & BW/4 HANA)** | **BW objects (InfoProviders, InfoObjects)**: This method is preferred. In most cases, it's recommended to go directly to BW objects because the data is already available in InfoProviders and InfoObjects. <br><br> **ABAP CDS views**: For exceptional use cases. <br><br> **BW Extractors**: For exceptional use cases. <br><br>**SLT**: For exceptional use cases. <br><br> ***Note:*** CDS, BW Extractors, and SLT are used for exceptional use cases. For example, if capabilities, like CDC, aren't available in the BW objects, you can use one of the other options. |

  > [!NOTE]
  >There are several data provider options when all the connectors are taken into consideration.

- If you're using an SAP CDC connector, check if the customer uses SAP SLT. In some cases, the customer has the licenses to use SAP SLT, but the infrastructure isn't there. This situation can add an extra cost.

- Customers with the license and facility should use SLT because it provides more data flow control for users. It offloads the performance burden from the core ERP system, for example shadow tables to capture change.

## Next steps

- [Choose the best SAP connector](./sap-lza-choose-azure-connectors.md)
- [Performance and troubleshooting](./sap-lza-data-extraction-performance-troubleshooting.md)
