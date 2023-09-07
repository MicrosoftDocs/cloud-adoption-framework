---
title: Innovation tools to democratize data
description: Learn about Azure Data Catalog and other data collection services that help you quickly test a hypothesis before expanding into broader, more costly digital inventions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 09/07/2023
ms.topic: conceptual
ms.custom: internal, seo-caf-innovate
keywords: democratize data, democratizing data, data collection, innovation tools
---

# Innovation tools to democratize data in Azure

As the conceptual article on [democratizing data](../considerations/data.md) describes, you can deliver many data collection innovations with little technical investment. Major innovations often require raw data. Democratizing data is about investing the least resources needed to engage your customers. The customers then use the data to take advantage of their existing knowledge.

Starting with data democratization is a quick way to test a hypothesis before expanding into broader, more costly digital inventions. As you refine more of the hypothesis and begin to adopt the inventions at scale, the following processes will help you prepare for operational support of the innovation.

![Diagram that shows the Cloud Adoption Framework approach to democratizing data.](../../_images/innovate/democratize-data.png)

## Alignment to the methodology

This type of digital invention can be accelerated through each phase of the following processes, as shown in the preceding image. Technical guidance to accelerate digital invention is listed in the table of contents on the left side of this page. Those articles are grouped by phase to align guidance with the overall methodology.

- **Share collected data:** The first step of democratizing data is to share openly.
- **Govern data:** Ensure that sensitive data is secured, tracked, and governed before sharing.
- **Centralize data:** Sometimes you need to provide a centralized platform for data democratization, sharing, and governance.
- **Collect data:** Migration, integration, ingestion, and virtualization can each collect existing data to be centralized, governed, and shared.

In every iteration, cloud adoption teams should go only as deep into the stack as they require to put the focus on customer needs over architecture. Delaying technical spikes in favor of customer needs accelerates the validation of your hypothesis.

All guidance maps to the four preceding processes. Guidance ranges from the highest customer effect to the highest technical effect. Across each process, you'll see guidance on ways Azure can accelerate your ability to [build with customer empathy](../considerations/build.md).

## Toolchain

In Azure, the following innovation tools are commonly used to accelerate digital invention across the preceding phases:

- [Power BI](/power-bi/)
- [Azure Data Catalog](/azure/data-catalog/)
- [Azure Synapse Analytics](/azure/synapse-analytics/)
- [Azure Cosmos DB](/azure/cosmos-db/)
- [Azure Database for PostgreSQL](/azure/postgresql/)
- [Azure Database for MySQL](/azure/mysql/)
- [Azure Database for MariaDB](/azure/mariadb/)
- [Azure Database for PostgreSQL hyperscale](/azure/postgresql/concepts-hyperscale-nodes)
- [Azure Data Lake Storage](/azure/storage/blobs/data-lake-storage-introduction)
- [Azure Database Migration Service](/azure/dms/)
- [Azure SQL Database, with or without Azure SQL Managed Instance](/azure/azure-sql/)
- [Azure Data Factory](/azure/data-factory/)
- [Azure Stream Analytics](/azure/stream-analytics/)
- [SQL Server Integration Services](/sql/integration-services/sql-server-integration-services)
- [Azure Stack](/azure-stack/)
- [SQL Server Stretch Database](/sql/sql-server/stretch-database/stretch-database)
- [Azure StorSimple](/azure/storsimple/)
- [Azure Files](/azure/storage/files/)
- [Azure File Sync](/azure/storage/file-sync/file-sync-planning)
- [PolyBase](/sql/relational-databases/polybase/polybase-guide)

As the invention approaches adoption at scale, the aspects of each solution require refinement and technical maturity. As that happens, more of these services are likely to be required. Use the table of contents on the left side of this page for Azure tools guidance relevant to your hypothesis-testing process.

## Get started

Below you'll find articles to help you get started with each of the tools in this toolchain.

> [!NOTE]
> The links might leave the Cloud Adoption Framework to help you go beyond the scope of this framework.

### Share data with experts

- [Quickly generate data insights](/power-bi/create-reports/service-insights)
- [Sharing data with coworkers and partners](/power-bi/collaborate-share/service-share-dashboards)
- [Embed reports in a website or portal](/power-bi/collaborate-share/service-embed-secure)
- [Create new workspaces in Power BI](/power-bi/collaborate-share/service-create-the-new-workspaces)

### Govern data

- [Classify data](./data-classification.md) (CAF)
- [Secure data](/azure/architecture/data-guide/scenarios/securing-data-solutions)
- [Annotate data with Azure Data Catalog](/azure/data-catalog/data-catalog-how-to-annotate)
- [Document data sources with Azure Data Catalog](/azure/data-catalog/data-catalog-how-to-documentation)

### Centralize data

- [Create and query an Azure Synapse Analytics SQL pool](/azure/synapse-analytics/sql-data-warehouse/create-data-warehouse-portal)
- [Best practices for loading data for data warehousing](/azure/synapse-analytics/sql/data-loading-best-practices)
- [Visualize warehouse data with Power BI](/power-bi/connect-data/service-azure-sql-data-warehouse-with-direct-connect)
- [Reference architecture for enterprise BI with Azure Synapse Analytics](/azure/architecture/reference-architectures/data/enterprise-bi-synapse)
- [Manage enterprise big data with Azure Data Lake Storage](/azure/storage/blobs/data-lake-storage-introduction)
- [What is a data lake?](/azure/architecture/data-guide/scenarios/data-lake)

### Collect data

- [Integrate cloud data sources with a SQL Analytics data warehouse](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-overview-integrate)
- [Load on-premises data into Azure Synapse Analytics](/sql/integration-services/load-data-to-sql-data-warehouse)
- [Integrate data - Azure Data Factory to OLAP](/azure/architecture/data-guide/scenarios/hybrid-on-premises-and-cloud)
- [Use Azure Stream Analytics with Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-integrate-azure-stream-analytics)
- [Reference architecture for ingestion and analysis of new feeds](/azure/architecture/example-scenario/ai/news-feed-ingestion-and-near-real-time-analysis)
- [Load data into Azure Synapse Analytics SQL pool](/azure/synapse-analytics/sql-data-warehouse/load-data-wideworldimportersdw)

## Next steps

Learn about tools to create applications that engage customers beyond raw data.

> [!div class="nextstepaction"]
> [Innovation application development tools](./apps.md)
