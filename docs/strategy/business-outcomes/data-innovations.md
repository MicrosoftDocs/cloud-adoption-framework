---
title: "Data innovations"
description: Migrate and modernize your data warehouse, and extend your analytical capabilities to drive new business value.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/22/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Data innovation

Many companies today are looking to migrate their existing data warehouse to the cloud. There are many reasons for doing this, including no hardware to buy or maintenance costs, no infrastructure to manage, and the ability to switch to a secure, scalable, low-cost, cloud-native, pay-as-you-go, analytical DBMS in Microsoft Azure Synapse Analytics. In addition, the rich Microsoft analytical ecosystem that exists on Azure is also an attraction. This includes technologies to help modernize your data warehouse once it is migrated and extend your analytical capabilities to drive new business value.

A data warehouse migration project involves many things such as migrating schema, data, ETL pipelines, authorization privileges, users, BI tool semantic access layers, and analytic applications.

Many companies want to migrate and modernize their legacy data warehouses to the cloud to utilize new lower cost, dynamic scalable analytical databases, access new data, and exploit machine learning and advanced analytics.

Once your data warehouse has been migrated to Azure Synapse there is a major opportunity to exploit other technologies in the Microsoft analytical ecosystem. Doing so allows you to not only modernize your data warehouse, but also to bring together insights produced in other analytical data stores on Azure into an integrated analytical architecture that drives new value in your business.

You can broaden ETL processing to ingest data of any type into Azure Data Lake storage, and prepare and integrate it at scale using Azure Data Factory to produce trusted commonly understood data assets that can be consumed by your data warehouse and also accessed by data scientists and other applications. You can build real-time and batch oriented analytical pipelines and create machine learning models that can deploy to run in batch, in-real-time on streaming data and on-demand as a service.

In addition, you can use PolyBase to go beyond your data warehouse by simplifying access to insights being produced in multiple underlying analytical platforms on Azure. This is done by creating holistic integrated views in a logical data warehouse so that you can easily access streaming, big data and traditional data warehouse insights from BI tools and applications to drive new value in your business.

Many companies have had data warehouses running in their data centers for years to enable users to produce business intelligence. Data warehouses extract data from known transaction systems, stage the data and the clean, transform and integrate it to populate data warehouses.

There are several business and technology reasons why you should consider migrating your data warehouse to Azure Synapse to help you lower total cost of ownership, improve price/performance and use a rich ecosystem of additional data and analytical technologies that can help you modernize your data warehouse and also shorten time to value.

The use cases, business cases and technology advances include:

## Use cases

- Connected product innovation
- Factory of the Future
- Clinical analytics
- Compliance analytics
- Cost-based analytics
- Omni-channel optimization
- Personalization
- Intelligent supply chain
- Dynamic pricing
- Procurement analytics
- Digital control tower
- Risk management
- Customer analytics
- Fraud detection
- Claims analytics

## Business cases

- Build end-to-end analytics solutions with a single analytics service
- Use the Azure Synapse studio, which provides a unified workspace for data prep, data management, data warehousing, big data, and AI tasks
- Build and manage pipeline with a no-code visual environment, automate query optimization, build proofs of concept, and use Power BI all from the same analytics service
- Deliver insights from all your data, across data warehouses and big data analytics systems
- For mission-critical workloads, easily optimize the performance of all queries with intelligent workload management, workload isolation, and limitless concurrency
- Edit and build Power BI dashboards directly from Azure Synapse
- Reduce project development time for BI and machine learning projects
- Easily share data with just a few clicks using Azure Data Share integration within Azure Synapse Analytics
- Implement fine-grained access control with column-level security and native row-level security
- Automatically protect sensitive data in real-time with dynamic data masking
- Industry-leading security with built-in security features like automated threat detection and always-on data encryption.

## Buying Drivers

- No hardware to buy or maintenance costs, so you pay only for what you use
- No infrastructure to manage so you can focus on competitive insights
- Massively parallel SQL query processing with dynamic scalability when you need it and shut down or paused when you don't
- Ability to independently scale storage from compute
- Avoiding unnecessary expensive upgrades because of staging areas on your data warehouse are getting too big, using up storage capacity forcing an upgrade – i.e. move the staging area to Azure Data Lake Storage and process with an ETL tool like Azure Data Factory or your existing ETL tool running on Azure at lower cost
- Extract, Load and Transform (ELT) workloads running on your existing data warehouse DBMS are too expensive with SQL query processing doing the work. This is where you are loading staging tables in your data warehouse DBMS and then running ELT processing by generating SQL, so the DBMS transforms your data from staging to production tables. It's a very common practice. However, as staging data volumes increase, more storage and compute power underpinning your on-premises data warehouse is being consumed by ELT and is having an impact on query, reporting and analysis workloads that are used to support decisions and drive value. This is forcing expensive hardware upgrades when you could avoid this by doing this processing on the Azure cloud using Azure Data Lake Storage and Azure Data Factory
- The cost of data marts is proving too expensive to build due to cost of storage and databases software licenses on on-premises hardware versus in building them on Microsoft Azure Synapse. This is especially the case if your data warehouse is a Data Vault design which often causes an increased demand for data marts
- There is a need to analyze real-time machine generated data like clickstream and streaming IoT data in your data warehouse but the cost of analyzing and storing this high-velocity, high volume data on-premises hardware is too high and would force expensive upgrades that can require significant capital
- Although elasticity is about scaling up/out and scaling down, as your Data Warehouse grows you can't scale down storage and so you are paying a premium for storage on expensive data warehouse hardware in the data center when Azure Synapse can store your data in cloud storage at lower cost
  
## Next steps

[Data democratization](./data-democratization.md)
