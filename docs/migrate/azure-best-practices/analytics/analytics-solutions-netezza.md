---
title: Azure Synapse Analytics migration for Netezza
description: Use the Cloud Adoption Framework for Azure to learn about analytics solutions for Netezza and migrating to Azure Synapse Analytics.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

<!-- docutune:casing Informatica Talend Inmon Attunity Qlik nzLua CBT CBTs NZPLSQL DELIM TABLENAME ORC Parquet nzsql nzunload mpp -->

<!-- cSpell:ignore Informatica Talend Qlik CBTs NZPLSQL CHARINDEX DATEDIFF DELIM STRPOS TABLENAME nzsql nzunload zonemap -->

# Azure Synapse Analytics solutions and migration for Netezza

Many organizations that currently use Netezza data warehouse systems are looking to take advantage of innovative cloud, infrastructure as a service, and platform as a service offerings in newer environments like Azure. Many organizations are ready to take the step of shifting expensive tasks like infrastructure maintenance and platform development to a cloud provider.

Azure Synapse Analytics is a limitless analytics service that brings together enterprise data warehousing and big data analytics. It gives you the freedom to query data on your terms at scale by using either serverless on-demand or provisioned resources. Learn what to plan for as you migrate a legacy Netezza system to Azure Synapse.

Netezza and Azure Synapse are similar in that each is a SQL database that's designed to use massively parallel processing techniques to achieve high query performance on large data volumes. But the two platforms are different in key aspects:

- Legacy Netezza systems are installed on-premises, and they use proprietary hardware. Azure Synapse is cloud-based and uses Azure compute and storage resources.
- Upgrading a Netezza configuration is a major task that involves extra physical hardware and a potentially lengthy database reconfiguration or dump and reload. In Azure Synapse, storage and compute resources are separate. You can use the elastic scalability of Azure to independently scale up or down.
- Without a physical system to support, you can pause or resize Azure Synapse as needed to reduce resource utilization and cost. In Azure, you have access to a globally available, highly secure, and scalable cloud environment that includes Azure Synapse in an ecosystem of supporting tools and capabilities.

In this article, we look at schema migration, with a view to obtaining equivalent or increased performance of your migrated Netezza data warehouse and data marts on Azure Synapse. We consider concerns that apply specifically to migrating from an existing Netezza environment.

At a high level, the migration process includes the steps that are listed in the following table:

| Preparation        | Migration                             | Post-migration |
| :----------------- | :----------------------------- | :---------------- |
| <li> Define scope: What do we want to migrate? <li> Build an inventory of data and processes to migrate. <li> Define any data model changes. <li> Identify the best Azure and third-party tools and features to use. <li> Train staff early on the new platform. <li> Set up the Azure target platform.</li> | <li> Start small and simple. <li> Automate where possible. <li> Use Azure built-in tools and features to reduce the migration effort. <li> Migrate metadata for tables and views. <li> Migrate relevant historical data. <li> Migrate or refactor stored procedures and business processes. <li> Migrate or refactor ETL or ELT incremental load processes.</li> | <li> Monitor and document all stages of the migration process. <li> Use experience gained to build a template for future migrations. <li> Reengineer the data model, if necessary, by using the new platform's performance and scalability. <li> Test applications and query tools. <li> Benchmark and optimize query performance.</li> |

When you migrate from a legacy Netezza environment to Azure Synapse, you must consider some specific factors, in addition to the more general subjects described in the Netezza documentation.

## Initial migration workload

Legacy Netezza environments typically evolve over time to encompass multiple subject areas and mixed workloads. When you are deciding where to start on an initial migration project, it makes sense to choose an area that:

- Proves the viability of migrating to Azure Synapse by quickly delivering the benefits of the new environment.
- Allows in-house technical staff to gain experience with new processes and tools so that they can use them to migrate other areas.
- Creates a template based on the current tools and processes to use in additional migrations from the source Netezza environment.

A good candidate for an initial migration from a Netezza environment that would support these objectives typically is one that implements a Power BI/analytics workload rather than an OLTP workload. The workload should have a data model that can be migrated with minimal modifications, such as a star or snowflake schema.

For size, it's important that the data volume you migrate in the initial exercise is large enough to demonstrate the capabilities and benefits of the Azure Synapse environment with a short time to demonstrate value. The size that typically meets the requirements is in the range of 1 terabyte (TB) to 10 TB.

An approach for the initial migration project that minimizes risk and implementation time is to confine the scope of the migration to data marts. This approach is a good starting point because it clearly limits the scope of the migration and typically can be achieved on a short timescale. An initial migration of data marts only doesn't address broader concerns like how to migrate ETL and historical data. You must address these areas in later phases and backfill the migrated data mart layer with the data and processes that are required to build them.

## Lift-and-shift approach vs. phased approach

Regardless of the drivers and scope that you choose for your migration, you can choose from two general types of migration:

- **Lift-and-shift approach:** In this approach, the existing data model, such as a star schema, is migrated unchanged to the new Azure Synapse platform. In this scenario, the emphasis is on minimizing risk and the time it takes to migrate by reducing the work that has to be done to achieve the benefits of moving to the Azure cloud environment.

  This approach is a good fit for existing Teradata environments in which a single data mart is to be migrated, and if the data is already in a well-designed star or snowflake schema. This approach is a good choice also if you have time and cost pressures to move to a more modern cloud environment.

- **Phased approach that incorporates modifications:** When a legacy warehouse has evolved over time, you might need to reengineer the data warehouse to maintain the required performance or to support new data sources like IoT streams. Migrating to Azure Synapse for the well-known benefits of a scalable cloud environment might be considered part of the reengineering process. This process might include changing the underlying data model, such as moving from an Inmon model to Azure Data Vault.

  The approach we recommend is to initially move the existing data model as-is to Azure. Then, take advantage of the performance and flexibility of Azure services to apply the reengineering changes without affecting the existing source system.

## Metadata migration

It makes sense to automate and orchestrate the migration process by using the capabilities of the Azure environment. This approach minimizes the effect on the existing Netezza environment, which might already be running close to full capacity.

Azure Data Factory is a cloud-based data integration service. You can use Data Factory to create data-driven workflows in the cloud to orchestrate and automate data movement and data transformation. Data Factory pipelines can ingest data from disparate datastores, and then process and transform the data by using compute services like Azure HDInsight for Apache Hadoop and Apache Spark, Azure Data Lake Analytics, and Azure Machine Learning. You start by creating metadata to list the data tables you want to migrate, with their locations, and then use Data Factory capabilities to manage the migration process.

## Design differences between Netezza and Azure Synapse

As you plan your migration from a legacy Netezza environment to Azure Synapse, it's important to consider the design differences between the two platforms.

### Multiple databases vs. a single database and schemas

In a Netezza environment, you might have multiple, separate databases for different parts of the overall environment. For example, you might have a separate database for data ingestion and staging tables, a database for core warehouse tables, and another database for data marts, sometimes called a *semantic layer*. Processing separate databases as ETL/ELT pipelines in Azure Synapse might require implementing cross-database joins and moving data between the separate databases.

The Azure Synapse environment has a single database. Schemas are used to separate tables into logically separate groups. We recommend that you use a set of schemas in the target Azure Synapse to mimic any separate databases that you migrate from Netezza. If you use schemas in the Netezza environment, you might need to use a new naming convention to move the existing Netezza tables and views to the new environment. For example, you might concatenate the existing Netezza schema and table names into the new Azure Synapse table name, and then use schema names in the new environment to maintain the original separate database names.

Another option is to use SQL views over the underlying tables to maintain the logical structures. There are some potential downsides to using SQL views:

- Views in Azure Synapse are read-only, so you must make any updates to the data on the underlying base tables.
- If layers of views already exist, adding another layer of views might affect performance.

### Tables

When you migrate tables between different technologies, you physically move only raw data and the metadata that describes it between the two environments. You don't migrate database elements like indexes from the source system because they might not be needed or they might be implemented differently in the new environment.

However, understanding where performance optimizations like indexes have been used in the source environment can be a helpful indication of where you might optimize performance in the new environment. For example, if queries in the source Netezza environment frequently use zone maps, you might conclude that it would be advantageous to create a nonclustered index in the migrated Azure Synapse environment, or that using other native performance optimization techniques like table replication might be preferable to creating a like-for-like index.

<!-- docutune:casing "NZ Toolkit" -->

### Unsupported Netezza database object types

Netezza implements some database objects that aren't directly supported in Azure Synapse. However, Azure Synapse offers methods that you can use to achieve the same functionality in the new environment, as described in the following list:

- **Zone maps:** In Netezza, zone maps are automatically created and maintained for some column types. Zone maps are used at query time on the following column types to restrict the amount of data to be scanned:

  - `INTEGER` columns that are a length of 8 bytes or less
  - Temporal columns, including `DATE`, `TIME`, and `TIMESTAMP`
  - `CHAR` columns, if they are part of a materialized view and included in the `ORDER BY` clause

  You can find out which columns have zone maps by using the nz_zonemap utility. The utility is part of the NZ Toolkit.

  Azure Synapse doesn't use zone maps, but you can achieve similar results by using user-defined index types or partitioning.

- **Clustered base tables (CBTs):** In Netezza, the most common CBT is the fact table, which has billions of records. Scanning such a huge table requires a long processing time because a full table scan might be needed to get relevant records. By organizing records in restrictive CBTs, Netezza can group records in the same or nearby extents. The process also creates zone maps that improve performance by reducing the amount of data to scan.

  In Azure Synapse, you can achieve a similar result through partitioning or by using other index types.

- **Materialized views:** Netezza recommends that users create one or more materialized view over large tables that have many columns, and in which only a few columns are regularly used in queries. Materialized views are automatically maintained by the system when data in the base table is updated.

  Currently, Microsoft offers preview support for materialized views, with the same functionality as Netezza, in Azure Synapse.

- **Data type mapping:** Most Netezza data types have a direct equivalent in Azure Synapse. The following table shows the data types and the recommended approaches for mapping the data types.

<!-- docutune:disable -->

| IBM Netezza data type | Azure Synapse SQL v2 data type |
| :-------------------- | :----------------------------- |
| bigint (int8) | bigint |
| binary varying(n) (alias varbinary(n)) | varbinary(n) |
| binary(n) | binary(n) |
| boolean (bool) | bit |
| bpchar(n) | varchar(n) |
| byteint (int1) | smallint |
| character varying (n) (alias varchar(n)) | varchar(n) |
| character(n) (alias char(n)) | char(n) |
| dataslice | *Not Supported* |
| date | date |
| datetime | datetime |
| decimal | decimal(18,0) |
| decimal(p,s) | decimal(p,s) |
| double | float(53) |
| float | float |
| float(p) | float(p) |
| float4 | float(53) |
| float8 | float(53) |
| integer (alias int, int4) | int |
| interval (alias timespan) | *Not Supported* |
| national bpchar(n) | nvarchar(n) |
| national character(n) (alias nchar(n)) | nchar(n) |
| number(p,s) | decimal(p,s) |
| numeric | decimal(18,0) |
| numeric(p,s) | numeric (p,s)|
| national character varying(n) (alias nvarchar(n)) | nvarchar(n) |
| real | real |
| rowid | *Not Supported* |
| smallint (alias int2) | smallint |
| st_geometry(n) | *Not Supported* |
| time | time |
| time with time zone (alias timetz) | datetimeoffset |
| timestamp(p) | datetime2(p) |
| transactionid | *Not Supported* |

<!-- docutune:enable -->

Note: Some third-party vendors offer tools and services that can automate migration tasks, including data type mapping. If a third-party ETL tool like Informatica or Talend is already used in the Netezza environment, you can use the tool to implement any data transformations that are required.

- **SQL Data Manipulation Language (DML) syntax:** You should be aware of a few differences in SQL DML syntax between Netezza SQL and Azure Synapse.

  Here are some key functions and how they are different:

  - `STRPOS`: In Netezza, the `STRPOS` function returns the position of a substring within a string. The equivalent in Azure Synapse is the `CHARINDEX` function, and the order of the arguments is reversed.

    In Netezza:

    `SELECT STRPOS('abcdef', 'def') ...`

    Is replaced with the following code in Azure Synapse:

    `SELECT CHARINDEX('def', 'abcdef') ...`

  - `AGE`: Netezza supports the `AGE` operator to give the interval between two temporal values (for example, timestamps and dates). For example:

    `SELECT AGE ('23-03-1956', '01-01-2019') FROM ...`

    You can achieve the same result in Azure Synapse by using `DATEDIFF` (note the date representation sequence):

    `SELECT DATEDIFF(day, '1956-03-23', '2019-01-01') FROM ...`

  - `NOW()`: Netezza uses `NOW()` to represent `CURRENT_TIMESTAMP` in Azure Synapse.

## Functions, stored procedures, and sequences

When you migrate a data warehouse from a mature legacy environment like Netezza, you often need to migrate elements other than simple tables and views to the new target environment. Examples of non-table elements in Netezza that you might need to migrate to Azure Synapse are functions, stored procedures, and sequences. During the preparation phase of the migration, you should create an inventory of objects to migrate. In the project plan, define the method of handling all objects and allocate the appropriate resources for their migration.

You might find services in the Azure environment that replace the functionality implemented as functions or stored procedures in the Netezza environment. Usually, it's more efficient to use the built-in Azure capabilities instead of recoding the Netezza functions.

Also, third-party vendors offer tools and services that can automate the migration of functions, stored procedures, and sequences from Netezza. Examples include Qlik (formerly Attunity) and WhereScape.

Here's some additional information about migrating functions, stored procedures, and sequences:

- **Functions:** Like most database products, Netezza supports system functions and user-defined functions in a SQL implementation. When common system functions are migrated to another database platform like Azure Synapse, they generally are available in the new environment and can be migrated without change. If system functions have slightly different syntax in the new environment, you usually can automate the required changes.

  You might need to recode arbitrary user-defined functions and system functions that have no equivalent in the new environment. Use the languages that are available in the new environment. Netezza user-defined functions are coded by using nzLua or C++. Azure Synapse uses the popular Transact-SQL language to implement user-defined functions.

- **Stored procedures:** In most modern database products, you can store procedures n the database. A stored procedure typically contains SQL statements and some procedural logic. It might also return data or a status.

  Netezza provides the NZPLSQL language, based on PL/pgSQL, for stored procedures. Azure Synapse supports stored procedures by using T-SQL. If you migrate stored procedures to Azure Synapse, you must recode them by using T-SQL.

- **Sequences:** In Netezza, a sequence is a named database object that's created via a `CREATE SEQUENCE` statement. Objects can provide the unique value via the `NEXT()` method. You can use values to generate unique numbers as surrogate key values for primary key values.

  Azure Synapse doesn't support `CREATE SEQUENCE`. In Azure Synapse, sequences are handled by using identity columns or SQL code to create the next sequence number in a series.

## Metadata and data extraction

Consider the following information when you plan how to extract metadata and data from the Netezza environment:

- **Data Definition Language (DDL) generation:** It's possible to edit existing Netezza `CREATE TABLE` and `CREATE VIEW` scripts to create the equivalent definitions, with modified data types if necessary, as described earlier. This task usually involves removing or modifying any clauses that are specific to Netezza, like `ORGANIZE ON`.

  In Netezza, the information that specifies the current table and view definitions is maintained in system catalog tables. System catalog tables are the best source of the information because the tables likely are up to date and complete. User-maintained documentation might not be in sync with current table definitions.

You can access system catalog tables in Netezza by using a utility like nz_ddl_table. You can use the tables to generate `CREATE TABLE` DDL statements, which you can then edit for the equivalent tables in Azure Synapse. Third-party migration and ETL tools also use the catalog information to achieve the same results.

- **Data extraction:** You can extract raw data to migrate from an existing Netezza table into a flat, delimited file by using standard Netezza utilities like nzsql and nzunload, and by using external tables. Compress the files by using Gzip, and then use AzCopy or an Azure data transport service like Azure Data Box to upload the files to Azure Blob Storage.

  During a migration exercise, it's important to extract data as efficiently as possible. The recommended approach for Netezza is to use external tables, which is also the fastest method. You can complete multiple extracts in parallel to maximize the throughput for data extraction.

Here's a simple example of an external table extract:

  `CREATE EXTERNAL TABLE '/tmp/export_tab1.CSV' USING (DELIM ',') AS SELECT * from <TABLE-NAME>;`

   If you have sufficient network bandwidth, you can extract data directly from an on-premises Netezza system into Azure Synapse tables or into Azure data storage by using Data Factory processes or third-party data migration or ETL products.

   Recommended data formats for extracted data are delimited text files (also called *comma-separated values*), optimized row columnar files, or Parquet files.

For more detailed information about the process of migrating data and ETL from a Netezza environment, see the Netezza documentation about data migration ETL and load.

## Performance-tuning recommendations

When you move to Azure Synapse from a Netezza environment, many of the performance-tuning concepts you use will be familiar.

For example, these concepts are the same for both environments:

- Data distribution colocates data to be joined onto the same processing node.
- Using the smallest data type for a specific column saves storage space and accelerates query processing.
- Ensuring that data types of columns to be joined are identical optimizes join processing by reducing the need to transform data for matching.
- Ensuring that statistics are up to date helps the optimizer produce the best execution plan.

There are some differences between platforms when it comes to optimization. In the following list of performance-tuning recommendations, lower-level implementation differences between Netezza and Azure Synapse, and alternatives for your migration, are highlighted:

- **Data distribution options:** In both Netezza and Azure Synapse, you can use a `CREATE TABLE` statement to specify a distribution definition. Use `DISTRIBUTE ON` for Netezza and `DISTRIBUTION =` for Azure Synapse.

   Azure Synapse provides an additional way to achieve local joins for small table/large table joins, often called a *dimension table/fact table join* in a star schema model. The approach is to replicate the smaller dimension table across all nodes, thereby ensuring that any value of the join key for the larger table will have a matching dimension row that's locally available. The overhead of replicating the dimension table is relatively low if the tables are not large. In this case, using the hash distribution approach described earlier is preferable.

- **Data indexing:** Azure Synapse provides various user-definable indexing options, but the options are different in operation and usage than system-managed zone maps in Netezza. To learn about the indexing options in Azure Synapse, see [Index tables in an Azure Synapse SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index).

   Existing system-managed zone maps in the source Netezza environment can provide a useful indication of how data is used and provide an indication of candidate columns for indexing in the Azure Synapse environment.

- **Data partitioning:** In an enterprise data warehouse, fact tables might contain many billions of rows of data. Partitioning is a way to optimize maintenance and querying in these tables. Splitting the tables into separate parts reduces the amount of data processed at one time. Partitioning for a table is defined in the `CREATE TABLE` statement.

  Only one field per table can be used for partitioning. The field that's used for partitioning frequently is a date field because many queries are filtered by date or by a date range. You can change the partitioning of a table after initial load. To change a table's partitioning, re-create the table with a new distribution that uses the `CREATE TABLE AS SELECT` statement. For a detailed description of partitioning in Azure Synapse, see [Partition tables in an Azure Synapse SQL pool](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-partition).

- **PolyBase for data loading:** PolyBase is the most efficient method to use to load large amounts of data into a warehouse. You can use PolyBase to load data in parallel streams.

- **Resource classes for workload management:** Azure Synapse uses resource classes to manage workloads. In general, large resource classes provide better individual query performance. Smaller resource classes give you higher levels of concurrency. You can use dynamic management views to monitor utilization to help ensure that the appropriate resources are used efficiently.

## Next steps

For more information about implementing a Netezza migration, talk with your Microsoft account representative about on-premises migration offers.
