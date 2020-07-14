---
title: "Data innovations"
description: Migrate and modernize your data warehouse, and extend your analytical capabilities to drive new business value.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Data innovation

Many companies today want to migrate their existing data warehouse to the cloud for reasons that include no hardware to buy or maintenance costs, no infrastructure to manage, and the ability to switch to a secure, scalable, low-cost, cloud-native, pay-as-you-go, analytical DBMS like Azure Synapse Analytics. Additionally, the rich Microsoft analytical ecosystem that exists in Azure is also attractive. Azure technologies help modernize your data warehouse once it's migrated and extend your analytical capabilities to drive new business value.

A data warehouse migration project involves many components such as schema, data, ETL pipelines, authorization privileges, users, BI tool semantic access layers, and analytic applications.

Many companies want to migrate and modernize their legacy data warehouses to the cloud to utilize new lower cost, dynamic scalable analytical databases, access new data, and take advantage of machine learning and advanced analytics.

Once your data warehouse has been migrated to Azure Synapse there is a major opportunity to take advantage of other technologies in the Microsoft analytical ecosystem. Doing so allows you to not only modernize your data warehouse, but also to bring together insights produced in other analytical data stores on Azure into an integrated analytical architecture that drives new value in your business.

You can broaden ETL processing to ingest data of any type into Azure Data Lake storage, and prepare and integrate it at scale using Azure Data Factory to produce trusted commonly understood data assets that can be consumed by your data warehouse and also accessed by data scientists and other applications. You can build real-time and batch oriented analytical pipelines and create machine learning models that can deploy to run in batch, in-real-time on streaming data and on-demand as a service.

In addition, you can use PolyBase to go beyond your data warehouse by simplifying access to insights being produced in multiple underlying analytical platforms on Azure. This is done by creating holistic integrated views in a logical data warehouse so that you can easily access streaming, big data and traditional data warehouse insights from BI tools and applications to drive new value in your business.

Many companies have had data warehouses running in their datacenters for years to enable users to produce business intelligence. Data warehouses extract data from known transaction systems, stage the data and the clean, transform and integrate it to populate data warehouses.

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

- No hardware to buy or maintenance costs, so you pay only for what you use.
- No infrastructure to manage so you can focus on competitive insights.
- Massively parallel SQL query processing with dynamic scalability when you need it and shut down or paused when you don't.
- Ability to independently scale storage from compute.
- Avoiding unnecessary expensive upgrades because the staging areas on your data warehouse are getting too big, using up storage capacity and forcing an upgrade. Fo example, move the staging area to Azure Data Lake Storage and process with an ETL tool like Azure Data Factory or your existing ETL tool running on Azure at lower cost.
- ELT workloads running on your existing data warehouse DBMS are too expensive with SQL query processing doing the work. This is where you are loading staging tables in your data warehouse DBMS and then running ELT processing by generating SQL, so the DBMS transforms your data from staging to production tables. This practice is common, but as staging data volumes increase, more storage and compute power underpinning your on-premises data warehouse is consumed by ELT and affects the performance of query, reporting, and analysis workloads that support decisions and drive value. This forces expensive hardware upgrades that can be avoided by processing in Azure using Data Lake Storage and Azure Data Factory.
- Data marts are too expensive to build because of the cost of storage and databases software licenses on on-premises hardware compared to building them in Azure Synapse. This is especially true if your data warehouse is a Data Vault design, which often causes an increased demand for data marts.
- There is a need to analyze real-time machine generated data like click-stream and streaming IoT data in your data warehouse, but the cost of analyzing and storing this high-velocity high-volume data on on-premises hardware is high and would force expensive upgrades that require significant capital.
- Although elasticity is about scaling up/out and scaling down, as your Data Warehouse grows you can't scale down storage, so you'll pay a premium for storage on expensive data warehouse hardware in the datacenter. Azure Synapse can store your data in cloud storage at a lower cost.
  
## Next steps

<!-- TODO: More detail needed here. -->

[Data democratization](./data-democratization.md)
