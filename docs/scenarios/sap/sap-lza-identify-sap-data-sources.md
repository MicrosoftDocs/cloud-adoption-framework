---
title: Data and Analytics for SAP on Azure
description: Learn more about the best practices on Integrating SAP Data with Azure Data Services for SAP on Azure.
author: pankajmeshramCSA
ms.author: pankajmeshramCSA
ms.date: 16/01/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Identify SAP Data Sources 
SAP systems contain data from across the organization which can be used to derive insights. In many cases, this data is siloed and is not integrated with other data sources inside and outside of the organization. Following is an overview of the most relevant SAP applications that serve as the source of a Data Integration initiative

- a. SAP Business Suite is a set of core applications such as SAP ERP, SAP Customer Relationship Management (CRM), SAP Supply Chain Management (SCM), and SAP Supplier Relationship Management (SRM). Those applications run both on SAP HANA, SAP’s in-memory database or any non-SAP database such as Oracle, Microsoft SQL Server, or IBM Db2. 

- b. SAP ERP is the most widely used SAP solution for enterprise resource planning. It provides core business functions such as accounting, logistics and human capital management.

- c. SAP S/4HANA is a new product and the next generation of business applications. SAP S/4HANA comes with new data and business models as well as an HTML5-based user interface.  As the name implies, SAP S/4HANA runs only on SAP HANA and provides both OLAP and OLTP capabilities in real time. 

- d. SAP BW and SAP BW/4HANA are SAP’s data warehousing solutions. They present the most common source of SAP business data since almost all SAP customers use those solutions as an enterprise data warehouse, departmental data mart or big data platform, loading data from operational SAP source systems. SAP BW/4HANA, again, runs only on SAP HANA with a simplified data architecture and open analytics features. Both solutions deliver an integrated data warehousing experience with data modelling, acquisition, integration, and tiering in one place. 

In addition to SAP Business Warehouse, SAP Business Warehouse powered by SAP HANA and SAP BW/4HANA, customers may also deploy the following cloud-based analytics and planning solutions in their landscape:
- SAP Analytics Cloud
- SAP Data Warehouse Cloud

SAP SaaS solutions:
- SAP S/4HANA Cloud, public edition which is the SaaS version of SAP S/4HANA
- SAP Customer Experience solutions such as SAP Commerce Cloud, SAP Sales Cloud and SAP Service Cloud
- SAP Ariba for direct and indirect spend
- SAP Concur for travel and expense
- SAP Fieldglass for external workforce management
- SAP SuccessFactors for Human Capital Management

The community curated list of SAP products on Wikipedia lists more than 100 SAP products for business, industry or platform software (Wikipedia 2021, List of SAP products - Wikipedia) 
[List of SAP products - Wikipedia](https://en.wikipedia.org/wiki/List_of_SAP_products). Due to this wide variety of solution portfolio and deployment options, this article focuses on the most common and relevant products in customer environments. 


**Design considerations:**

- Source System: Consider choosing your source system based in existing implementations and business use case The source SAP environment is mostly given and cannot be changed. Document the source SAP solution along with OS and database version. An upgrade to a newer OS, SAP NetWeaver and database version will mostly not be possible in the short term. Options to access a SaaS solution may be more limited than a legacy and on-premises solution. Hence, first get familiar with the current solution’s capabilities and limitations concerning the nature of data and its extraction based on business requirements.

- Licensing - Understand the existing licenses available and figure out the licensing impact before extracting data from SAP systems. Ensure to work with your SAP counterparts. Since licensing is a complex topic and the policies may change over time, always contact your SAP account team for guidance. Please refer to these guides from SAP for more information on licensing 

   - a.	[Indirect access Guide](https://news.sap.com/wp-content/blogs.dir/1/files/Indirect_Access_Guide_for_SAP_Installed_Base.pdf) for SAP ERP (ECC and SAP S/4HANA) customers with contracts based  on SAP pricing policies prior to 10 April 2018.  
   - b.	[Pricing for Digital Age](https://news.sap.com/wp-content/blogs.dir/1/files/Pricing_for_Digital_Age_Overview.pdf)
        for the new outcome-based ERP pricing introduced on 10 April 2018

- For SAP HANA specifically, one needs to differentiate between the runtime and full-use database licenses. Runtime databases only support software licensed from SAP, whereas full-use databases licensed from SAP support both SAP and non-SAP software. Full-use SAP HANA databases are licensed based on a gigabyte-of-memory metric. In that sense, 3rd party data connectors accessing the SAP HANA database directly need the purchase of a full-use SAP HANA database license. For details, see https://blogs.sap.com/2021/01/18/technical-details-hana-licensing/ and SAP Licensing Guide in https://www.sapusers.org/uploads/files/5660. 

- For data extraction from SAP BW on anyDB or SAP HANA, consider the SAP NetWeaver OpenHub and SAP OpenHub for S/4HANA licenses which are also included in SAP HANA, enterprise edition. Note also that SAP BW/4HANA doesn't require an OpenHub license. For additional details about terms and conditions, refer to [SAP Software Use Rights (SUR)](https://assets.cdn.sap.com/agreements/product-use-and-support-terms/sur/sap-software-use-rights-english-v1-2022.pdf) document in SAP Trust Center. 

- One of the possible ODP providers of SAP CDC connector is SAP Landscape Transformation Replication Server (SLT). It is a trigger-based data replication technology that allows real-time replication from SAP and/or non-SAP sources to SAP and/or non-SAP targets. For SLT licensing, see the attachment in SAP Note 2707835. The license is determined by the target system of the replication. If the license of target system includes the use of SLT, no separate SLT license is needed. In any other SLT case, including the use of SAP CDC connector, an SLT Full License is required. 

- Within a customer organization, there are separate teams supporting data integration and SAP projects. Often the data team is unaware of existing OpenHub licenses which enables data extraction from SAP BW using the OpenHub interface. 

- Consider technical debt of existing SAP BW transformations and investments

- Data Analysis - Once the source system is identified, and its capabilities and limitations well known, consider the following items in data analysis: 
  - a. Source business object, 
  - b. type of data (master data, transactional data or language-dependent text data), 
  - c. source tables and/or views, primary key columns, 
  - e. full load vs. delta load, data change patterns, data volume, data compression, 
  - f. extraction in batches vs. near-real time replication (Note that the minimum interval of a schedule trigger in Azure Synapse is one minute), 
  - g. data access methods provided by the source system, 
  - h. native Azure or 3rd party ETL tools and data connectors most suitable for the use case, 
  - i. In case of SAP CDC connector, type of ODP provider/context, e.g., SAPI (DataSources/Extractors), BW (SAP   NetWeaver Business Warehouse), ABAP_CDS (ABAP Core Data Services) or HANA (HANA Information Views), in case of ABAP CDS views, the view's supported capabilities and analytics annotations.


**Design Recommendations**

- In case of multiple SAP ERP source systems sending data to a regional or global, central SAP BW instance, this SAP BW system is then the default candidate for further data extraction, transformation and loading into Azure Data Services.

- There may be cases where data extraction from an SAP ERP system into Azure makes more sense, such as in case of a standalone SAP ERP with no SAP BW connection, or data in SAP ERP tables that do not require the transformation logic in an existing SAP BW and can be extracted by means of data connectors available in Azure.  One of the use cases is a customer already using SAP BW as a source and there are a few tables that need to be extracted in full load directly from SAP ERP system.  Another scenario is a customer source itself is an SAP ERP system and this one requires bigger data set.
- If the SAP BW system has many transformations on top of data extracted from SAP ERP systems, then you may consider SAP BW Open Hub connector to extract data from SAP BW. Look at your organization’s data strategy and skill sets. You may already be investing in Azure Data Services which could influence the choice of the source SAP system. 

- Azure Data Factory and Azure Synapse Analytics pipelines provide multiple connectors for data extraction from SAP sources. https://github.com/Azure/Azure-DataFactory/blob/main/whitepaper/SAP Data Integration using Azure Data Factory.pdf For SAP CDC connector specifically, see Transform data from an SAP ODP source with the SAP CDC connector in Azure Data Factory or Azure Synapse Analytics - Azure Data Factory & Azure Synapse | Microsoft Learn.

- If one is using the [CDC (Change Data Capture) connector](https://learn.microsoft.com/en-us/azure/data-factory/sap-change-data-capture-introduction-architecture), the following are the data providers and recommendations. 

   - If the customer is using ECC then following are the options
	 - ECC extractors - An SAP extractor is a program that can be used to retrieve data in a SAP source system and transfer it to an SAP Business Warehouse or Business Intelligence system. It has all the logic that can be used to extract data in an SAP source system and transfer it to an SAP BW or BI system   -- Check if you or your partner have experience and skills with BW Extractors. If you have these skills, then extractors are preferred option. Ensure your partner has implementation and operation experience as well for successful project. 

	 - [SLT(System Landscape Transformation Replication Server)](https://www.sap.com/products/technology-platform/landscape-replication-server.html) – If extractors cannot be used or if database trigger option is required, then you can rely on original tables and work via SLT. 

    - If the customer is using S/4 Hana 
	  - ABAP CDS views (TBD – Pankaj to add details to explain) - preferred option to extract data. Data is easier to consume (multi-dimensional model), technology is easier to handle than since CDS views are like database views and can be easily understood without deep sap knowledge. Custom CDS views are easier to create and much more powerful as well. 
	  - Extractors – Exists in S/4 HANA to fill certain gaps. The use case is for the situations where we do not have CDS views, and the gap is filled with Extractors. (Off course the same consideration as above in terms of skills) 
      - SLT – This means connecting to Tables. Another option is if the above two do not fit the use case. 

    - If the source system is BW (BW & BW/4 HANA) 
      - BW Objects (Infoproviders , Infoobjects) – preferred method (TBD – Pankaj to add details to explain) - this is the preferred method and in most of the cases it is recommended to go directly to BW objects since we already have the data available in InfoProviders & InfoObjects.  
      - ABAP CDS Views (for exceptional use cases) - 
      - BW Extractors (for exceptional use cases) 
      -	SLT (for exceptional use cases) 
    For CDS, BW extractor and SLT – These are used for exceptional use cases for example if there are capabilities like CDC not available in the BW Objects then either of the options could be used. 
    **Note – If we are talking about all the connectors the providers options will be more.** 
       
-  In case of using SAP CDC connector, check whether customer is using SAP SLT or not. In some case customer has the licenses to use SAP SLT but the infrastructure is not there and that is going to be an additional cost. 

- Customers with license and facility to utilize SLT should leverage SLT as it provides more control to users on the data flows and offloads performance burden from core ERP system (for e.g. shadow tables to capture change).

## Next step: Learn about different Azure connectors and the recommendations. 

The following articles provide details on different connectors available in Azure to connect with SAP system and decision criterias to choose the right connector for your use case. 

- [Choosing Azure Connectors](./sap-lza-choosing-azure-connectors.md)





