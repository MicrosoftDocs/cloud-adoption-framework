---
title: SAP applications as data sources for analytics scenarios in Azure
description: Learn about SAP applications as data sources for analytics scenarios in Azure.
author:  mboswell
ms.author:  mboswell 
ms.date: 09/24/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# SAP applications as data sources for analytics scenarios in Azure

## Overview

The community curated [list of SAP products](https://en.wikipedia.org/wiki/List_of_SAP_products) on Wikipedia has more than 100 products for business, industry or platform software provided by SAP. Not included in the list are different versions and related architecture
and technology variants of these products. Due to this variety of products, architectures and deployment options, this article focuses on the most common products which are typically relevant in customer environments and provides an overview of most of the relevant SAP
applications used today.

> [!NOTE]
> There are other SAP applications specifically designed for specific
> industries, known as Industry-solutions (IS) like IS Utilities, IS Health or IS Automotive and many more. This document will not cover all of these but leveraging the content from the following chapter should also give some guidance and support regarding data extraction and integration for the applications not described in detail.

## SAP NetWeaver-based applications (IaaS)

SAP NetWeaver based products are implemented on the internally developed
software architecture stack of SAP. The acquired on-premises or
cloud-solutions are implemented on a wide variety of heterogeneous
platform and architectures.

An SAP NetWeaver based architecture consists of ABAP application servers
and an underlying runtime database. Next to ABAP as application
development platform, a smaller number of SAP NetWeaver applications is
built on Enterprise Java. For this document, the focus is on ABAP based
NetWeaver deployments.

:::image type="content" source="../images/overview-sap-netweaver.png" alt-text="Overview SAP Netweaver":::

## Data-extraction from SAP ERP / ECC

The most used SAP application is the SAP ERP or SAP ECC (ERP Central
Component), with coverage of business processes like Sales &
Distribution, Production Planning or Financial Accounting.

Currently the latest version of the SAP ERP is called ECC 6, which is
based on SAP NetWeaver 7.5.

Prior to the introduction of SAP HANA as runtime database, the SAP
Netweaver technology was database agnostic and supported a large variety
of relational database vendors like Microsoft, Oracle or IBM.

SAP S/4HANA is the next generation ERP of SAP, the mainstream
maintenance of all SAP NetWeaver 7.5 based applications will end on
31.12.2027.

For data extraction from SAP ECC there are multiple approaches described
in the following sections.

### SAP ABAP tables

Exporting SAP ERP data using SAP ABAP tables is a common way to extract
data from SAP.

SAP ABAP tables are table proxies to abstract from the underlying
relational database used to synchronize ABAP and database datatypes for
example. Still these tables have physical representatives on database
level. When connecting Azure Data Factory against an SAP ERP system,
over 200k highly denormalized tables (and views) are listed for
selection and exporting.

Examples for SAP tables can be found here:\
[SAP ABAP Table BSEG (Accounting Document Segment), sap-tables.org - The Best Online document for SAP ABAP Tables](https://www.sap-tables.org/table/bseg.html)

Most SAP table- and column names are German abbreviations that have to
be translated to the end-users preferred language.

Compared to API based access methods, where the content of the SAP ABAP
table is typically processed through certain logic or algorithms, the
extraction of SAP tables could be assumed as raw data export.

In theory, for certain data science scenarios for example, it might be a
difference if raw data was used to identify patterns or if the data was
already processed and transformed via an API.

When working with SAP ABAP tables, the following implications must be
considered:

#### SAP tables and their entity relationship for specific data models

In practice this means that the data engineer must have a deep
understanding of the SAP data model to select and join the required
tables. For example, this following website gives a good impression which SAP ECC
tables are required to implement the SAP Sales and Distribution data
model.

[SAP SD Tables (Sales and Distribution) and the relationships between them (se80.co.uk)](https://www.se80.co.uk/sapmodules/s/sd-t/sd-tables.htm)

This required knowledge includes the necessity to join the SAP tables as
shown here:\
[SAP ABAP Table BSEG (Accounting Document Segment), sap-tables.org - The Best Online document for SAP ABAP Tables](https://www.sap-tables.org/table/bseg.html)

#### SAP tables column names

Many SAP ABAP tables are named with technical German abbreviations, for
example the common column name BUKRS means Buchungskreis in German which
means Company code.

In practice most SAP table columns names will have to be translated to
meaningful descriptions and labels, typically in multiple languages
including non-Latin characters for global companies.

#### Columns for Change data capture (CDC) / Delta identifier

The next challenge, when extracting data from SAP tables, is the
necessity for columns containing information to identify new, deleted or
updated records. Typically timestamps or sequential and unique record
identifier are used. In some cases, these columns are not available on
table level and create the requirement of daily initial loads of large
tables with millions of rows. Best practice here is to either identify
columns with date- or timestamp information to apply CDC, or to find a
suitable partitioning criterion for parallelizing large daily initial
loads as workaround. If no such field is found on a table, consider creating a view joining the requested table with a table which contains a suitable identifier.

### Runtime Database access

Direct connection to the SAP NetWeaver runtime database via ODBC or JDBC
is another potential method used for data extraction. Utilizing this
pattern there are several implications to be considered carefully:

- ODBC / JDBC are not supported interfaces according to the S/4HANA
    security guide.

  - Security Guide for SAP S/4HANA 2020 (Chapter 6.1 Communication
        Channel)

- SAP on Azure reference architectures recommend limiting the
    communication between SAP application server and runtime database
    via network rules.

- SAP authorization concepts on application level are bypassed.

- SAP application logging and auditing are bypassed.

- Potential database resource or resource locking conflicts with
    application server

- Potential impact on runtime database licensing.

- ODBC and JDBC might have performance implications as well, when
    extracting large datasets

- SAP Mandant/Client concept is not implemented

In exceptional circumstances the performance requirements, particularly
for replication from SAP high-volume applications in industries like
retail or finance, might be so challenging that database log or
trigger-based replication is the only technical option and therefore
rules out all limitations above.

#### SAP events, messaging and protocols like BAPI (Business Application Programming Interface), IDocs or SOAP

In some exceptional cases, like highly regulated industries or SAP
application, more middleware or process-integration, than
data-integration focused tools or SAP interfaces, might be an option for
analytical scenarios as well.

Existing SAP middleware could be used to push events and messages to
analytical Azure applications. One example for existing SAP middleware
could be PI/PO.

Customer scenarios could be the publication or streaming of master data
updates, repair-, service-orders or shipping-events.

#### SAP NetWeaver Process Integration and SAP NetWeaver Process Orchestration

In on-premises or IaaS scenarios the SAP middleware tools SAP
NetWeaver Process Integration (PI) and SAP NetWeaver Process
Orchestration (PO), commonly referred to as SAP PI/PO, are widely used.

Important to mention is that SAP PI went out of mainstream maintenance
support on 31.12.2020 and SAP PO will be out of mainstream maintenance
support on 31.12.2027.

Here certain partner solutions or custom implementations can extend
SAP PO to store data on, for example, Azure Blob storage.

However, this approach, to use a middleware for SAP data ingestion
scenarios, is relative uncommon with little best practices. Guidance
here would be to focus on data integration tools and patterns and only
utilize the tools mentioned above when there is no option to utilize
data integration tools under certain conditions.

These conditions could be related to security and governance, or the
timeline to implement and operate new data integration tools.

Next to use SAP interfaces and protocols to push messages and events,
there a relative new approach where Kafka-oriented approaches change
the boundaries between process- and data-integration tools.\

[Using Apache Kafka As SAP Integration Backbone - e3zine -- E-3 Magazine International](https://e3zine.com/using-apache-kafka-as-sap-integration-backbone)

SAP has its own event-driven implementation for S4Hana and ECC. Here the SAP system can send events towards the BTP event mesh (aka SAP Cloud Platform Enterprise Messaging). There are also 3rd party companies which can be used to implement an event-driven architecture and which allow connectivity towards Kafka or Azure Event Hub.

If you're an ABAP oriented company you can also consider using the Azure ABAP SDK for this purpose. This ABAP SDK allows for connectivity towards a Azure Event Hub. The Azure ABAP SDK is available on GitHub.
For more information see :

- [SAP Help : SAP Event Mesh - SAP Help Portal](https://help.sap.com/viewer/product/SAP_EM/Cloud/en-US)

- [SAP Community : Please welcome 'SAP Event Mesh' – new name for 'SAP Cloud Platform Enterprise Messaging' | SAP Blogs](https://blogs.sap.com/2021/02/22/please-welcome-sap-event-mesh-new-name-for-sap-cloud-platform-enterprise-messaging/)

- [3rd party : ASAPIO](https://asapio.com/)

- [Github : microsoft/ABAP-SDK-for-Azure: ABAP Libraries for SAP native Integration with Azure Services (github.com)](https://github.com/Microsoft/ABAP-SDK-for-Azure)

- [Github : SAP-Event-Driven-Architecture-using-Azure-ABAP-SDK-and-Event-Hub (github.com)](https://github.com/bdelangh/SAP-Event-Driven-Architecture-using-Azure-ABAP-SDK-and-Event-Hub)

## Data-extraction from SAP BW

The most common source for SAP related data extraction to non-SAP systems is probably the SAP Business Warehouse (SAP BW) or SAP BW on HANA.

The SAP Business Warehouse is an integrated data-warehouse application and SAP HANA a relational In-Memory database.

Integrated Data-Warehouse application means data-integration, -modelling and general DWH services are provided this application. In opposite to combining ETL, database and modelling tools from multiple vendors, which would be an example for a best of breed DWH architecture.

Currently there a three different of BW versions deployed at customers landscapes:

### SAP BW on any DB (IaaS)

This version of SAP BW, with the release of SAP NetWeaver 7.5, supports most major database vendors until 31.12.2025.

#### SAP BW on HANA (IaaS)

SAP BW first the first SAP application that supported SAP HANA with the NetWeaver (NW) version 7.3. With each new SAP NW release new features
and application object were introduced, that are only available for SAP BW on HANA. As well certain applications objects were deprecated, as
consequence major refactoring is frequently required to prepare an SAP BW for a SAP BW on HANA migration.

#### SAP BW/4HANA (IaaS)

The SAP BW/4 only supports SAP HANA as underlying runtime database, and the code line is different from the SAP NetWeaver code line.

According to the SAP DWH strategy new DWH features and functionality will primarily be developed for SAP BW/4HANA.

[SAP BW/4HANA Technical Overview (L2)](https://assets.cdn.sap.com/sapcom/docs/2020/06/0c5da4de-9a7d-0010-87a3-c30de2ffd8ff.pdf)

#### Business consolidation and planning applications

Next to enterprise data warehousing, many SAP BW systems support finance processes and applications like business consolidation or business planning.

Tools which are typically used are SAP BW Integrated Planning (IP), SAP Business Planning and Consolidation (BPC) or the Strategic Enterprise Management Business Consolidation (SEM-BCS) Add-On.

This extends the capability and uses-cases of SAP BW beyond traditional data-warehousing and links the system usage with operational finance processes.

### SAP BW Best Practice Architectures and Business Content

To get a deeper understanding of the SAP BW application and DWH design patterns, this document about the Layered Scalable Architecture is a
good starting point: [SAP NetWeaver BW LSA++](https://www.sap.com/documents/2015/07/bc549283-577c-0010-82c7-eda71af511fa.html)

The reasons why SAP BW is a widely used as preprocessor for SAP data extraction, are typically the simplification of data-extraction, using the SAP BW business content extractors, and the existence of SAP BW business content. SAP BW business content provides predefined data-transformations, data-models and in general SAP specific semantics from the data-acquisition up to the reporting layer.

Since the effort to custom built those models is extensive, many customers decide to implement SAP BW and corresponding predefined models. In many cases even just for data-provisioning to consuming non-SAP applications.

Example for SAP BW business content: [SAP BW/4HANA Content](https://www.sap.com/documents/2017/06/4e8689f9-c17c-0010-82c7-eda71af511fa.html)

As well many SAP BW customers are using so called Special OLAP functions and services. These functions and service can be applied in SAP BW queries to implement requirements like hierarchies or currency- and quantity-translation.

[Analytic Functions - SAP Help Portal](https://help.sap.com/viewer/dd104a87ab9249968e6279e61378ff66/11.0/en-US/154ae7c8f61343da89c150d48417afd7.html)

### SAP BW OpenHub

When following the SAP BW reference architecture, SAP BW Open-Hub is the preferred tool and interface to distribute SAP BW data for further processing in non-SAP environments.

SAP Open-Hub support all databases as target destinations, which are supported according to the SAP NetWeaver PAM. This includes Microsoft SQL Server 2012 up to 2019.

[SAP Netweaver PAM](https://apps.support.sap.com/sap/support/pam?hash=pvnr%3D73554900100900000414%26pt%3Dt%257CPLTFRM%26ainstnr%3D73554900104900001064%26fclfilter%3DG1%257CMS%2520SQL%2520SERVER%2520X86_64)

Multiple SAP BW objects, in corresponding DWH-layers, are supported as source for Open-Hub extraction.

Further details about the SAP BW Open-Hub service can be found here:

[SAP BW OpenHub Service - An Overview](https://www.sap.com/documents/2016/06/e4b548b7-757c-0010-82c7-eda71af511fa.html)

:::image type="content" source="../images/overview-bw-open-hub.png" alt-text="Overview BW Open-hub":::

### SAP Operational Data Provisioning (ODP)

To overcome the challenges of tabular data extraction with SAP system, SAP developed a proprietary data extraction framework, which was historically used for data provisioning to the SAP Business Warehouse.

For this extraction technology, the term SAP BW business content extractors was often used, and these extractors cover a broad variety of SAP data models.

The ODP framework is an evolution of the SAP BW business content extractor technology and the version ODP 2.0 is available since the SAP BW 7.3.

In addition the ODP framework made SAP ERP businesses content extractors available to more consumers than just the SAP BW.

Technically there are four types of extractors:

- Attribute (Master-data)
- Text (Multi language for master-data)
- Hierarchy (SAP Hierarchies)
- Transactional / Movement data

Note: According to the SAP ODP FAQ, the interface and framework are not open for non-SAP ETL tools.

Multiple SAP tools like SAP Data-Services, SAP Data-Intelligence or SAP BW are ODP provider, consumer or both.

Specific partner solutions support ODP as an interface, please consult the corresponding to understand the support model of specific implementation.

[Operational Data Provisioning (ODP) FAQ  SAP Blogs](https://blogs.sap.com/2017/07/20/operational-data-provisioning-odp-faq/)

ADF can connect to ODP extractors using the oData protocol. This means that first the oData layer needs to be generated for these connectors. You can use transaction 'SEGW' for this. For more information, see :

- [SAP Help : Using the OData Service for Extracting ODP Data - SAP Help Portal](https://help.sap.com/viewer/ccc9cdbdc6cd4eceaf1e5485b1bf8f4b/7.5.21/en-US/50f4ee6253134d3cafa25b9444f0c5a9.html)

- [Github : ADF_SAPDataExtraction](https://github.com/bdelangh/ADF_SAPDataExtraction/blob/master/SAPS4H_ODP.md)

## SAP HANA based SAP ERP applications

In 2015 SAP launched the next generation business suite SAP S/4HANA which was exclusivity implemented and optimized for SAP HANA as runtime database.

As consequence the mainstream maintenance support of SAP NetWeaver 7.5 based applications and other runtime databases than SAP HANA will end on 31.12.2025.

### Data-extraction from SAP Business Suite on HANA

SAP Business Suite on HANA is the transactional application like SAP Business Suite on any DB and therefore data-extraction interfaces, or tools have not been changed

Introduced with SAP Business Suite on HANA was the concept of operational reporting with SAP HANA Live. SAP HANA Live was deprecated with S/4HANA and replaced with S/4HANA Embedded Analytics.

[SAP HANA Live & S/4HANA Embedded Analytics | SAP Blogs](https://blogs.sap.com/2013/01/02/sap-hana-live-s4hana-embedded-analytics/)

### Data-extraction from SAP S/4 HANA

Important to underline is the fact, that the SAP ERP application was not only technically refactored to run on SAP HANA, but also comes with significant changes to the business processes and reunifies multiple SAP modules to a single application. As consequence customers must apply different migration methodologies, like greenfield implementation or selective data migrations, to transform their existing SAP ERP applications to SAP S/HANA.

From an analytics perspective, SAP S/4HANA introduces multiple major changes that must be considered.

### Operational reporting ERP reporting with SAP S/4HANA Embedded Analytics

Prior SAP S/4HANA best practice for operational ERP reporting was to utilize SAP BW due to performance restrictions and conflicts. As well the built-in ABAP- and SAP-GUI built reporting interfaces in the SAP ERP did not meet the expectations for end-users used to work with modern BI-tools.

With SAP S/4HANA extensive operational reporting content was introduced and currently SAP Analytics Cloud is the only supported BI-Fronted.

This might have two implications on the overall analytics landscape after the S/4HANA transformation:

- Certain Operational Reporting in SAP BW is not required anymore and will be decommissioned. This might have an impact on existing PBI reports as well.
- SAP S/4HANA doesn't support PowerBI as frontend. Data hast to be extracted from SAP S/4HANA to make it available for reporting with PowerBI

Technical foundation for SAP S/4HANA Embedded Analytics is SAP ABAP Core Data Services (CDS).

The CDS-view supports the creation of virtual data models by defining Entities, Associations, Calculation Fields and Annotations.

Technically these semantics rich CDS views will be transparently translated into SAP HANA database views for execution during runtime. In addition, the definition of CDS for reporting purposes includes specific analytics data categories like Dimension, Fact, Cube or Aggregation level.

[SAP S/4HANA Embedded Analytics  SAP Blogs](https://blogs.sap.com/2017/06/29/sap-s4hana-embedded-analytics/)

[SAP S/4HANA and SAP BW/4HANA: What to Do Where?  SAP Blogs](https://blogs.sap.com/2017/08/15/sap-s4hana-and-sap-bw4hana-what-to-do-where/)

[ABAP Core Data Services -- Part 3(Virtual Data model types)  SAP Blogs](https://blogs.sap.com/2017/10/09/abap-core-data-services-part-2virtual-data-model-types/)

### Core Data Services based data extraction

Next to serving operational reporting, SAP S/4HANA CDS views can also be utilized for data extraction. By adding a particular annotation CDS
views, they are enabled for data extraction using the ODP framework.

Detailed information about CDS based data extraction can be found here:

[CDS based data extraction -- Part I Overview  SAP Blogs](https://blogs.sap.com/2019/12/13/cds-based-data-extraction-part-i-overview/)

ADF and CDS Views : CDS Views can be extracted using the ADF Table adapter (as long as the CDS views exists in the SAP Data Dictionary (transaction se11.)

## SAP Cloud applications

### SAP SaaS applications

SAP extended their vast product family regarding SaaS with taking over several market leaders in their respective spaces.

Data-Extraction and Integration of business processes is done by using REST, OData or SOAP APIs published and documented via SAP API Business Hub \[api.sap.com\]. The SAP API Business Hub serves as pivotal point when looking for the right API. It is a web portal application where APIs are documented and can be tested.

Possible SaaS sources inside SAP ecosystem:

- S/4HANA Cloud which is the SaaS version of S/4HANA(ODP via OData)
- C/4HANA like SAP Sales and SAP Commerce Cloud
- SAP Ariba for procurement
- SAP Concur for travel management.
- SAP Field Glass for service
- SAP Success Factors for HR-related business scenarios

As guidance for data-extraction, the available API's must be investigated per SaaS application.

Based on experiences and requirements from customer projects, this document will be extended with guidance and best practices per SaaS application, since each application might require different approaches.

Due to the characteristic of these heterogeneous SaaS APIs, it's likely that more application- or process-integration services like Azure Logic Apps will be a good fit in the first place.

For more information please refer to: [Announcing SAP API Business Hub Next Gen Experience General Availability  SAP Blogs](https://blogs.sap.com/2021/07/06/announcing-sap-api-business-hub-next-gen-experience-general-availability/)

In practice reusing the middleware integration layer, to provision data to Azure Blob and further processing with Azure Data Factory, could be an appropriate option as well.

## SAP Data Integration Tools

Prior the acquisition of BusinessObjects in 2007, the options for data integration of SAP systems into non-SAP analytical architectures, were limited to SAP tooling like SAP BW or flat-file exports.

With SAP Data-Services (formerly known as BusinessObjects Data-Services or BODS) a broad set of industry leading data-sources and targets were made available for integration with SAP applications like SAP BW.

Since the acquisition of BusinessObjects, the portfolio of SAP Data Integration tools was extended to SAP HANA Smart Data Integration and SAP Data Hub or Data Intelligence.

In certain project or customer situation and environments, it might be faster and more efficient to reuse existing SAP data integration tools, compared to introducing a new cloud-based data integration tool.

This especially applies to highly regulated SAP systems in certain industries or in environments.

### SAP Data Services

SAP Data Services (DS), formerly known as BusinessObjects Data-Services, is a standalone ETL tool used for non-SAP data ingestion to relational DWHs built with BusinessObjects-Enterprise.

According to the PAM SAP DS 4.2 support the following Azure services (on Windows deployments of SAP DS) as target and source:

- SQL Server on Azure VM (IaaS)
- Azure SQL DB
- Azure SQL Data Warehouse
- Blob Storage
- Blob Storage Gen2
- ADLS
- Microsoft Analytics Platform System

### [PAM SAP DataServices 4.2](https://support.sap.com/content/dam/launchpad/en_us/pam/pam-essentials/TIP/PAM_DataServices_4_2.pdf)

SAP DS support ODP sources as well and is therefore an option to leverage CDC and efficient extraction of SAP master- and movement data.

### SAP LT Replication

SAP Landscape Transformation Replication (SAP SLT) is primarily a tool used for near zero downtimes migrations towards SAP HANA. Simplified, it enables the synchronization of two databases using database triggers on the source system. Technically the configuration and synchronization are implemented and orchestrated by the SAP NW ABAP application server using the Data Migration Server (DMIS) add-on.

Next to database synchronization for zero downtime migrations, another use-case for SAP SLT is high volume and low-latency replication, based on DB triggers, towards SAP HANA or other databases in analytical scenarios.

For data-ingestion to Azure, MS SQL Server 2012 to 2019(IaaS) is supported by SAP NetWeaver as replication target. (s. SAP NetWeaver PAM).

In addition, there is the option to install ABAP Add-Ons on SLT to support more data target like Azure Blob.

Worth to mention is the fact that SLT replicates plain SAP tables and not master- or movement-data objects like ODP does.

### SAP Data Intelligence Cloud

SAP Data Intelligence is the next generation of cloud-scale data-ingestion tool of SAP. In principle, it could be perceived as successor of SAP Data-Services or SAP HANA Smart Data Integration. Next to data integration pipelines, SAP Data Intelligence Cloud provides Data Governance services a like a Metadata catalog.

SAP Data Intelligence provides specific options for bi-directional connections to SAP ABAP system: [User Guide for ABAP Integration in SAP Data Intelligence - SAP Help Portal](https://help.sap.com/viewer/3a65df0ce7cd40d3a61225b7d3c86703/Cloud/en-US)

SAP Data Intelligence Cloud supports Azure Data Lake Gen2 as data target next to protocols or tools like MQTT or Kafka.

Partner blogs about the integration of SAP Data Intelligence with the Azure Data Lake and Common Data Model:[Integration of SAP ERP Data into a Common Data Model SAP Blogs](https://blogs.sap.com/2020/12/03/integration-of-sap-erp-data-into-a-common-data-model/)

Next to SAP Data Intelligence Cloud, there is SAP Data-Hub which is the on-premise version of the product, which can also be deployed on the Azure Kubernetes Service(AKS).

[Your SAP on Azure -- Part 13 -- Install SAP Data Hub on Azure Kubernetes Service SAP Blogs](https://blogs.sap.com/2019/01/10/your-sap-on-azure-part-13-install-sap-data-hub-on-azure-kubernetes-service/)

### SAP HANA Smart Data Integration (SDI)

SAP HANA Smart Data Integration is a data integration tool direct deployed on the SAP HANA database and is focused on data ingestion to this single SAP HANA system.

In case SAP BW on HANA or SAP HANA applications require data from the Azure data platform the following Microsoft products are supported:

- MS SQL Server on Azure (PaaS)
- Microsoft Azure Data Explorer (ADX)
- Microsoft SQL Server Log Reader

[Azure DataBricks (ODBC) (see Your SAP on Azure – Part 19 – Expose Azure Databricks to SAP HANA using ODBC connection | SAP Blogs)](https://blogs.sap.com/2019/07/18/your-sap-on-azure-part-19-expose-azure-databricks-to-sap-hana-using-odbc-connection/)

Source via PAM:

[Source via PAM](https://support.sap.com/content/dam/launchpad/en_us/pam/pam-essentials/TIP/PAM_HANA_SDI_2_0.pdf)

In addition there are partner solutions to read from ADLS:\
[Hana SDI Adapter for Azure Data Lake  SAP
Blogs](https://blogs.sap.com/2021/02/08/hana-sdi-adapter-for-azure-data-lake/)