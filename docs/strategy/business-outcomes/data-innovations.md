---
title: Data innovations
description: Migrate and modernize your data warehouse, and extend your analytical capabilities to drive new business value.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: think-tank
---

# Data innovations

Many companies want to migrate their existing data warehouse to the cloud. They are motivated by a number of factors, including:

- No hardware to buy or maintenance costs.
- No infrastructure to manage.
- The ability to switch to a secure, scalable, and low-cost cloud solution.

For example, the cloud-native, pay-as-you-go service from Azure called Azure Synapse Analytics provides an analytical database management system for organizations. Azure technologies help modernize your data warehouse after it's migrated and extend your analytical capabilities to drive new business value.

A data warehouse migration project involves many components. These include schema, data, extract-transform-load (ETL) pipelines, authorization privileges, users, BI tool semantic access layers, and analytic applications.

After your data warehouse has been migrated to Azure Synapse Analytics, you can take advantage of other technologies in the Microsoft analytical ecosystem. Doing so allows you to not only modernize your data warehouse but also bring together insights produced in other analytical data stores on Azure.

You can broaden ETL processing to ingest data of any type into Azure Data Lake Storage. You can prepare and integrate it at scale by using Azure Data Factory. This produces trusted, commonly understood data assets that can be consumed by your data warehouse, and also accessed by data scientists and other applications. You can build real-time, batch-oriented analytical pipelines. You can also create machine learning models that can deploy to run in batch, in real time on streaming data, and on demand.

In addition, you can use PolyBase to go beyond your data warehouse. This simplifies access to insights being produced in multiple underlying analytical platforms on Azure. You create holistic, integrated views in a logical data warehouse to gain access to streaming, big data, and traditional data warehouse insights from BI tools and applications.

Many companies have had data warehouses running in their datacenters for years, to enable users to produce business intelligence. Data warehouses extract data from known transaction systems, stage the data, and then clean, transform, and integrate it to populate data warehouses.

Use cases, business cases, and technology advances all support how Azure Synapse Analytics can help you with data warehouse migration. The following sections list many of these examples.

## Use cases

- Connected product innovation
- Factory of the future
- Clinical analytics
- Compliance analytics
- Cost-based analytics
- Omnichannel optimization
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

- Build end-to-end analytics solutions with a single analytics service.
- Use the Azure Synapse Analytics studio, which provides a unified workspace for data prep, data management and analytics, data warehousing, big data, and AI tasks.
- Build and manage pipeline with a no-code visual environment, automate query optimization, build proofs of concept, and use Power BI, all from the same analytics service.
- Deliver your data insights to data warehouses and big data analytics systems.
- For mission-critical workloads, optimize the performance of all queries with intelligent workload management, workload isolation, and limitless concurrency.
- Edit and build Power BI dashboards directly from Azure Synapse Analytics.
- Reduce project development time for BI and machine learning projects.
- Easily share data with just a few clicks by using Azure Data Share integration within Azure Synapse Analytics.
- Implement fine-grained access control with column-level security and native row-level security.
- Automatically protect sensitive data in real time with dynamic data masking.
- Industry-leading security with built-in security features like automated threat detection and always-on data encryption.

## Technology advances

- No hardware to buy or maintenance costs so you pay only for what you use.
- No infrastructure to manage, so you can focus on competitive insights.
- Massively parallel SQL query processing with dynamic scalability when you need it, and the option to shut down or pause when you don't.
- Ability to independently scale storage from compute.
- You can avoid unnecessary, expensive upgrades caused by the staging areas on your data warehouse getting too big, taking up storage capacity, and forcing an upgrade. For example, move the staging area to Azure Data Lake Storage. Then process it with an ETL tool like Azure Data Factory or your existing ETL tool running on Azure at lower cost.
- Avoid expensive hardware upgrades by processing ETL workloads in Azure, by using Azure Data Lake Storage and Azure Data Factory. This is often a better solution than running on your existing data warehouse DBMS with SQL query processing doing the work. As staging data volumes increase, more storage and compute power underpinning your on-premises data warehouse is consumed by ETL. This in turn affects the performance of query, reporting, and analysis workloads.
- Avoid building expensive data marts that use storage and databases software licenses on on-premises hardware. You can build them in Azure Synapse Analytics instead. This is especially helpful if your data warehouse is a data vault design, which often causes an increased demand for data marts.
- Avoid the cost of analyzing and storing high-velocity, high-volume data on on-premises hardware. For example, if you need to analyze real-time, machine generated data like click-stream and streaming IoT data in your data warehouse, you can use Azure Synapse Analytics.
- You can avoid paying a premium for storing data on expensive warehouse hardware in the datacenter as your data warehouse grows. Azure Synapse Analytics can store your data in cloud storage at a lower cost.

## Next steps

<!-- TODO: More detail needed here. -->

[Data democratization](./data-democratization.md)
