---
title: Azure Synapse Analytics migration for Teradata
description: Use the Cloud Adoption Framework for Azure to learn about analytics solutions for Teradata and migrating to Azure Synapse Analytics.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

<!-- cSpell:ignore DATEADD DATEDIFF Inmon NUSI Informatica Talend BTEQ FASTEXPORT QUALIFY ORC Parquet "Parallel Data Transporter" Attunity "Qlik Replicate" -->

# Azure Synapse Analytics solutions and migration for Teradata

Many organizations are ready to take the step of shifting expensive data warehouse tasks like infrastructure maintenance and platform development to a cloud provider. Organizations are now looking to take advantage of innovative cloud, infrastructure as a service, and platform as a service offerings in newer environments like Azure.

Azure Synapse Analytics is a limitless analytics service that brings together enterprise data warehousing and big data analytics. It gives you the freedom to query data on your terms at scale by using either serverless on-demand or provisioned resources. Learn what to plan for as you migrate a legacy Teradata system to Azure Synapse.

Although Teradata and Azure Synapse are similar in that they're both SQL databases that are designed to use massively parallel processing techniques to achieve high query performance on large data volumes, they have some basic differences:

- Legacy Teradata systems are installed on-premises, and they use proprietary hardware. Azure Synapse is cloud-based and uses Azure compute and storage resources.
- Upgrading a Teradata configuration is a major task that involves extra physical hardware and a potentially lengthy database reconfiguration or dump and reload. In Azure Synapse, compute and storage resources are separate, so you can easily scale up or down independently by using the elastic scalability of Azure.
- Without a physical system to support, you can pause or resize Azure Synapse as needed to reduce resource utilization and cost. In Azure, you have access to a globally available, highly secure, and scalable cloud environment that includes Azure Synapse in an ecosystem of supporting tools and capabilities.

In this article, we look at schema migration, with an objective of obtaining equivalent or increased performance of your migrated Teradata data warehouse and data marts on Azure Synapse. We consider concerns that apply specifically to migrating from an existing Teradata environment.

At a high level, the migration process includes the steps that are listed in the following table:

| Preparation        | Migration                             | Post-migration |
| :----------------- | :----------------------------- | :---------------- |
| <li> Define scope: What do we want to migrate? <li> Build an inventory of data and processes to migrate. <li> Define any data model changes. <li> Identify the best Azure and third-party tools and features to use. <li> Train staff early on the new platform. <li> Set up the Azure target platform.</li> |  <li> Start small and simple. <li> Automate where possible. <li> Use Azure built-in tools and features to reduce the migration effort. <li> Migrate metadata for tables and views. <li> Migrate relevant historical data. <li> Migrate or refactor stored procedures and business processes. <li> Migrate or refactor ETL/ELT incremental load processes.</li> | <li> Monitor and document all stages of the migration process. <li> Use experience gained to build a template for future migrations. <li> Reengineer the data model, if necessary, by using the new platform's performance and scalability. <li> Test applications and query tools. <li> Benchmark and optimize query performance.</li> |

When you migrate from a legacy Teradata environment to Azure Synapse, in addition to the more general subjects that are described in the Teradata documentation, you must consider some specific factors.

## Initial migration workload

Legacy Teradata environments typically evolve over time to encompass multiple subject areas and mixed workloads. When you're deciding where to start on an initial migration project, it makes sense to choose an area that:

- Proves the viability of migrating to Azure Synapse by quickly delivering the benefits of the new environment.
- Allows in-house technical staff to gain experience with new processes and tools so that they can use them to migrate other areas.
- Creates a template based on the current tools and processes to use in additional migrations from the source Teradata environment.

A good candidate for an initial migration from a Teradata environment is one that implements a Power BI/analytics workload rather than an OLTP workload. The workload should have a data model that can be migrated with minimal modifications, such as a star or snowflake schema.

For size, it's important that the data volume you migrate in the initial exercise is large enough to demonstrate the capabilities and benefits of the Azure Synapse environment with a short time to demonstrate value. The size that typically meets the requirements is in the range of 1 to 10 terabytes (TB).

An approach for the initial migration project that minimizes risk and implementation time is to confine the scope of the migration to data marts. In Teradata, a good example is the OLAP database part of a Teradata data warehouse. This approach is a good starting point because it limits the scope of the migration, and it often can be achieved on a short timescale.

An initial migration scope of data marts only doesn't address broader concerns like how to migrate ETL and historical data. You must address these areas in later phases and backfill the migrated data mart layer with the data and processes that are required to build them.

## Lift-and-shift approach vs. phased approach

Regardless of the drivers and scope you choose for your migration, you can choose from two general types of migrations:

- **Lift-and-shift approach:** In this approach, the existing data model, such as a star schema, is migrated unchanged to the new Azure Synapse platform. The emphasis is on minimizing risk and the time it takes to migrate by reducing the work that's required to achieve the benefits of moving to the Azure cloud environment.

  This approach is a good fit for existing Teradata environments in which a single data mart is to be migrated and if the data is already in a well-designed star or snowflake schema. This approach is a good choice also if you have time and cost pressures to move to a more modern cloud environment.

- **Phased approach that incorporates modifications:** If your legacy warehouse has evolved over time, you might need to reengineer the data warehouse to maintain the required performance or to support new data sources like IoT streams. Migrating to Azure Synapse for the well-known benefits of a scalable cloud environment might be considered part of the reengineering process. This process might include changing the underlying data model, such as moving from an Inmon model to Azure Data Vault.

  The approach we recommend is to initially move the existing data model as-is to Azure. Then, take advantage of the performance and flexibility of Azure services to apply the reengineering changes without affecting the existing source system.

## Virtual machine colocation to support migration

An optional approach to migrate from an on-premises Teradata environment takes advantage of inexpensive cloud storage and elastic scalability in Azure. First, you create a Teradata instance on an Azure virtual machine that's colocated with the target Azure Synapse environment. Then, you use a standard Teradata utility like Teradata Parallel Transporter or a third-party data replication tool like Qlik Replicate (formerly by Attunity) to efficiently move the subset of Teradata tables that you're migrating to the VM instance. All migration tasks take place in the Azure environment.

This approach has several benefits:

- After the initial replication of data, the source system isn't affected by other migration tasks.
- Familiar Teradata interfaces, tools, and utilities are available in the Azure environment.
- After the migration shifts to the Azure environment, you don't have any potential issues with network bandwidth availability between the on-premises source system and the cloud target system.
- Tools like Azure Data Factory efficiently call utilities like Teradata Parallel Transporter to migrate data quickly and easily.
- The migration process is orchestrated and controlled entirely from within the Azure environment.

## Metadata migration

It makes sense to automate and orchestrate the migration process by using the capabilities of the Azure environment. This approach minimizes impact on the existing Teradata environment, which might already be running close to full capacity.

Azure Data Factory is a cloud-based data integration service. You can use Data Factory to create data-driven workflows in the cloud to orchestrate and automate data movement and data transformation. Data Factory pipelines can ingest data from disparate datastores. Then, they process and transform the data by using compute services like Azure HDInsight for Apache Hadoop and Apache Spark, Azure Data Lake Analytics, and Azure Machine Learning.

Start by creating metadata that lists the data tables you want to migrate along with their locations. Then, use Data Factory capabilities to manage the migration process.

## Design differences between Teradata and Azure Synapse

As you plan your migration from a legacy Teradata environment to Azure Synapse, it's important to consider the design differences between the two platforms.

### Multiple databases vs. a single database and schemas

In a Teradata environment, you might have multiple, separate databases for different parts of the overall environment. For example, you might have a separate database for data ingestion and staging tables, a database for core warehouse tables, and another database for data marts (sometimes called a *semantic layer*). Processing separate databases as ETL/ELT pipelines in Azure Synapse might require implementing cross-database joins and moving data between the separate databases.

The Azure Synapse environment has a single database. Schemas are used to separate tables into logically separate groups. We recommend that you use a set of schemas in Azure Synapse to mimic any separate databases you migrate from Teradata.

If you use schemas in the Teradata environment, you might need to use a new naming convention to move the existing Teradata tables and views to the new environment. For example, you might concatenate the existing Teradata schema and table names into the new Azure Synapse table name, and then use schema names in the new environment to maintain the original separate database names.

Another option is to use SQL views over the underlying tables to maintain their logical structures. There are some potential downsides to using SQL views:

- Views in Azure Synapse are read-only, so you must make any updates to the data on the underlying base tables.
- If layers of views already exist, adding another layer of views might affect performance.

### Tables

When you migrate tables between different technologies, you physically move only raw data and the metadata that describes it between the two environments. You don't migrate database elements like indexes from the source system because they might not be needed, or they might be implemented differently in the new environment.

However, understanding where performance optimizations like indexes have been used in the source environment can be a helpful indication of where you might optimize performance in the new environment. For example, if a non-unique secondary index was created in the source Teradata environment, you might conclude that it would be advantageous to create a nonclustered index in the migrated Azure Synapse environment, or that using other native performance optimization techniques like table replication might be preferable to creating a like-for-like index.

### High availability database

Teradata supports data replication across nodes via the `FALLBACK` option. Table rows that reside physically on a node are replicated to another node within the system. This approach guarantees that data isn't lost if a node fails, and it provides the basis for failover scenarios.

The goal of the high-availability architecture in Azure SQL Database is to guarantee that your database is up and running 99.99% of the time. You don't need to consider how maintenance operations and outages might affect your workload. Azure automatically handles critical servicing tasks like patching, backups, and Windows and SQL upgrades, and unplanned events like underlying hardware, software, or network failures.

Snapshots are a built-in feature of the service that creates restore points in Azure Synapse. Snapshots provide automatic backup for data storage in Azure Synapse. You don't have to enable the capability. Currently, individual users can't delete automatic restore points that the service uses to maintain SLAs for recovery.

Azure Synapse takes snapshots of the data warehouse throughout the day. The restore points that it creates are available for seven days. The retention period can't be changed. Azure Synapse supports an eight-hour recovery point objective. You can restore your data warehouse in the primary region from any of the snapshots taken in the past seven days. Other user-defined options are available if your organization needs more granular backups.

### Unsupported Teradata table types

Teradata includes support for special table types for time series and temporal data. Azure Synapse doesn't directly support the syntax and some of the functions for these table types, but you can migrate the data into a standard table that has the required data types and indexing or partitioning on the date/time column.

Teradata implements temporal query functionality by using query rewriting to add filters to a temporal query to limit the applicable date range. If you use temporal queries in the source Teradata environment and you want to migrate it, you must add filters to the relevant temporal queries.

The Azure environment also includes features for complex analytics on time series data at scale through Azure Time Series Insights. Time Series Insights is designed for IoT data analysis applications, and it might be more appropriate for that use case. For more information, see [Azure Time Series Insights](https://azure.microsoft.com/services/time-series-insights/).

### Teradata data type mapping

Some Teradata data types aren't directly supported in Azure Synapse. The following table shows these data types and the recommended approach for handling them. In the table, the Teradata column type is the type that's stored in the system catalog (for example, in `DBC.ColumnsV`).

Use the metadata from the Teradata catalog tables to determine whether any of these data types should be migrated, and then plan for supporting resources in your migration plan. For example, you can use a SQL query like the one in the next section to find any occurrences of unsupported data types that you need to address.

Third-party vendors offer tools and services that can automate migration, including mapping data types between platforms. If you already use a third-party ETL tool like Informatica or Talend in the Teradata environment, you can use the tool to implement any required data transformations.

## SQL Data Manipulation Language (DML) syntax differences

You should be aware of a few differences in SQL Data Manipulation Language (DML) syntax between Teradata SQL and Azure Synapse:

- `QUALIFY`: Teradata supports the `QUALIFY` operator.

   For example:

  `SELECT col1 FROM tab1 WHERE col1='XYZ'`

  Third-party tools and services can automate data-mapping tasks:

  `QUALIFY ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) = 1;`

  In Azure Synapse, you can achieve the same result by using the following syntax:

  `SELECT * FROM (SELECT col1, ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) rn FROM tab1 WHERE c1='XYZ' ) WHERE rn = 1;`

- **Date arithmetic:** Azure Synapse has operators like `DATEADD` and `DATEDIFF`, which you can use on `DATE` or `DATETIME`.

   Teradata supports direct subtraction on dates:

  - `SELECT DATE1 - DATE2 FROM ...`

  - `LIKE ANY` syntax

    Example:

    `SELECT * FROM CUSTOMER WHERE POSTCODE LIKE ANY ('CV1%', 'CV2%', CV3%') ;`.

    The equivalent in Azure Synapse syntax is:

    `SELECT * FROM CUSTOMER WHERE (POSTCODE LIKE 'CV1%') OR (POSTCODE LIKE 'CV2%') OR (POSTCODE LIKE 'CV3%') ;`

- Depending on system settings, character comparisons in Teradata might not be case-specific by default. In Azure Synapse, these comparisons are always case-specific.

## Functions, stored procedures, triggers, and sequences

When you migrate a data warehouse from a mature legacy environment like Teradata, often you need to migrate elements other than simple tables and views to the new target environment. Examples of non-table elements in Teradata that you might need to migrate to Azure Synapse are functions, stored procedures, triggers, and sequences. During the preparation phase of the migration, you should create an inventory of objects to migrate. In the project plan, define the method of handling all objects and allocate the appropriate resources to migrate them.

You might find services in the Azure environment that replace the functionality implemented as functions or stored procedures in the Teradata environment. Usually, it's more efficient to use the built-in Azure capabilities instead of recoding the Teradata functions.

Here's more information about migrating functions, stored procedures, triggers, and sequences:

- **Functions:** Like most database products, Teradata supports system functions and user-defined functions in a SQL implementation. When common system functions are migrated to another database platform like Azure Synapse, they're usually available in the new environment and can be migrated without change. If system functions have slightly different syntax in the new environment, you usually can automate the required changes.

  You might need to recode arbitrary user-defined functions and system functions that have no equivalent in the new environment. Use the languages that are available in the new environment. Azure Synapse uses the popular Transact-SQL language to implement user-defined functions.

- **Stored procedures:** In most modern database products, you can store procedures n the database. A stored procedure typically contains SQL statements and some procedural logic. It might also return data or a status.

  Teradata provides stored procedure language to create stored procedures. Azure Synapse supports stored procedures by using T-SQL. If you migrate stored procedures to Azure Synapse, you must recode them by using T-SQL.

- **Triggers:** You can't create triggers in Azure Synapse, but you can implement triggers in Data Factory.

- **Sequences:** Azure Synapse sequences are handled similarly to how they are handled in Teradata. Use `IDENTITY` columns or SQL code to create the next sequence number in a series.

## Metadata and data extraction

Consider the following information when you plan how to extract metadata and data from the Teradata environment:

- **Data Definition Language (DDL) generation:** As described earlier, it's possible to edit existing Teradata `CREATE TABLE` and `CREATE VIEW` scripts to create the equivalent definitions, with modified data types, if necessary. In this scenario, you usually must remove extra Teradata-specific clauses (for example, `FALLBACK`).

  The information that specifies the current table and view definitions is maintained in system catalog tables. System catalog tables are the best source of the information because the tables likely are up to date and complete. User-maintained documentation might not be in sync with current table definitions.

  You can access the information by using views on the catalog, such as `DBC.ColumnsV`. You also can use views to generate the equivalent `CREATE TABLE` Data Definition Language (DDL) statements for the equivalent tables in Azure Synapse.

  Third-party migration and ETL tools also use the catalog information to achieve the same result.

- **Data extraction**

  Migrate the raw data from existing Teradata tables by using standard Teradata utilities like `BTEQ` and `FASTEXPORT`. In a migration exercise, it's generally important to extract the data as efficiently as possible. For recent versions of Teradata, we recommend Teradata Parallel Transporter, a utility that uses multiple parallel `FASTEXPORT` streams to achieve the best throughput.

  You can call Teradata Parallel Transporter directly from Data Factory. We recommend this approach for managing the data migration process, whether the Teradata instance is on-premises or copied to a VM in the Azure environment, as described earlier.

  The data formats we recommend for extracted data are delimited text files (also called *comma-separated values*), optimized row columnar files, or Parquet files.

For detailed information about the process of migrating data and ETL from a Teradata environment, see the Teradata documentation.

## Performance-tuning recommendations

The platforms have some differences when it comes to optimization. In the following list of performance-tuning recommendations, lower-level implementation differences between Teradata and Azure Synapse and alternatives for your migration are highlighted:

- **Data distribution options:** In Azure, you can set the data distribution methods for individual tables. The purpose of the functionality is to reduce the amount of data that moves between processing nodes when a query is executed.

  For large table/large table joins, hash distributing in one or both (ideally, both) tables on the join columns helps ensure that join processing can be performed locally because the data rows to be joined are already colocated on the same processing node.

  Azure Synapse provides an additional way to achieve local joins for small table/large table joins (often called a *dimension table/fact table join* in a star schema model). You replicate the smaller table across all nodes, thereby ensuring that any value of the join key for the larger table has a matching dimension row that's locally available. The overhead of replicating the dimension table is relatively low if the tables aren't large. In this case, using the hash distribution approach described earlier is preferable.

- **Data indexing:** Azure Synapse provides various indexing options, but the options are different in operation and usage from indexing options in Teradata. To learn about the indexing options in Azure Synapse, see [Design tables in an Azure Synapse pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview).

  Existing indexes in the source Teradata environment can provide a useful indication of how data is used and provide an indication of candidate columns for indexing in the Azure Synapse environment.

- **Data partitioning:** In an enterprise data warehouse, fact tables might contain many billions of rows of data. Partitioning is a way to optimize maintenance and querying in these tables. Splitting the tables into separate parts reduces the amount of data processed at one time. Partitioning for a table is defined in the `CREATE TABLE` statement.

  Only one field per table can be used for partitioning. The field that's used for partitioning frequently is a date field because many queries are filtered by date or by a date range. You can change the partitioning of a table after initial load. To change a table's partitioning, re-create the table with a new distribution that uses the `CREATE TABLE AS SELECT` statement. For a detailed description of partitioning in Azure Synapse, see [Partition tables in an Azure Synapse SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-partition).

- **Data table statistics:** You can ensure that statistics about data tables are up to date by adding a `COLLECT STATISTICS` step in ETL/ELT jobs or by enabling automatic statistics collection on the table.

- **PolyBase for data loading:** PolyBase is the most efficient method to use to load large amounts of data into a warehouse. You can use PolyBase to load data in parallel streams.

- **Resource classes for workload management:** Azure Synapse uses resource classes to manage workloads. In general, large resource classes provide better individual query performance. Smaller resource classes give you higher levels of concurrency. You can use dynamic management views to monitor utilization to help ensure that the appropriate resources are used efficiently.

## Next steps

For more information about implementing a Teradata migration, talk with your Microsoft account representative about on-premises migration offers.
