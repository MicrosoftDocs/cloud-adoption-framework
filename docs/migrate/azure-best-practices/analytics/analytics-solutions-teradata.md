---
title: Azure Synapse Analytics solutions and migration for Teradata 
description: Use the Cloud Adoption Framework for Azure to learn about analytics solutions for Teradata and migrating to Azure Synapse Analytics.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore DATEADD DATEDIFF Attunity Teradata Inmon NUSI Informatica Talend BTEQ FASTEXPORT QUALIFY ORC Parquet "Parallel Data Transporter" "Attunity Replicate" -->

# Azure Synapse Analytics solutions and migration for Teradata

Existing users of Teradata data warehouse systems are now are looking to take advantage of innovative cloud, infrastructure as a service (IaaS), and platform as a service (PaaS) offerings in newer environments like Azure. Many organizations are ready to take the step of shifting expensive tasks like infrastructure maintenance and platform development to a cloud provider. 

Azure Synapse Analytics is a limitless analytics service that brings together enterprise data warehousing and Big Data analytics. It gives you the freedom to query data on your terms, by using either serverless on-demand or provisioned resources, at scale. Learn what to plan for as you migrate a legacy Teradata system to Azure Synapse.

Although Teradata and Azure Synapse are similar in that they both are SQL databases that are designed to use massively parallel processing techniques to achieve high query performance on large data volumes, they have some basic differences:

- Legacy Teradata systems are installed on-premises, and they use proprietary hardware. Azure Synapse is cloud-based and uses Azure storage and compute resources.
- Upgrading a Teradata configuration is a major task that involves extra physical hardware and a potentially lengthy database reconfiguration or dump and reload. In Azure Synapse,  storage and compute resources are separate, so you can easily scale these resources up or down independently by using the elastic scalability of Azure.
- Without a physical system to support, you can pause or resize Azure Synapse as needed to reduce resource utilization and cost. In Microsoft Azure, you have access to a globally available, highly secure, scalable cloud environment that includes Azure Synapse in an ecosystem of supporting tools and capabilities.

In this article, we look at schema migration, with a view to obtaining equivalent or increased performance of your migrated Teradata data warehouse and data marts on Azure Synapse. We consider concerns that apply specifically to migrating from an existing Teradata environment.

At a high level, the migration process includes the steps that are listed in the following table:

<!-- markdownlint-disable MD033 -->

| Preparation        | Migration                             | Post-migration |
| :----------------- | :----------------------------- | :---------------- |
| <ul><li> Define scope: what do we want to migrate?</li><li>Build an inventory of data and processes to migrate.</li><li>Define any data model changes.</li><li>Identify the best Azure and third-party tools and features to use.</li><li>Train staff early on the new platform.</li><li>Set up the Azure target platform.</li></ul> |  <ul><li> Start small and simple.</li><li>Automate where possible.</li><li>Use Azure built-in tools and features to reduce the migration effort.</li><li>Migrate metadata for tables and views.</li><li>Migrate relevant historical data.</li><li>Migrate or refactor stored procedures and business processes.</li><li>Migrate or refactor ETL/ELT incremental load processes.</li></ul> | <ul><li> Monitor and document all stages of the migration process.</li><li>Use experience gained to build a template for future migrations.</li><li>Re-engineer the data model if necessary by using the new platform's performance and scalability.</li><li>Test applications and query tools.</li><li>Benchmark and optimize query performance.</li></ul> |

When you migrate from a legacy Teradata environment to Azure Synapse, you must consider some specific factors, in addition to the more general subjects described in the Teradata documentation. 

## Initial migration workload

Legacy Teradata environments typically evolve over time to encompass multiple subject areas and mixed workloads. When you are deciding where to start on an initial migration project, it makes sense to choose an area that:

- Proves the viability of migrating to Azure Synapse by quickly delivering the benefits of the new environment.
- Allows in-house technical staff to gain experience with new processes and tools so that they can use them to migrate other areas.
- Creates a template based on the current tools and processes to use in additional migration from the source Teradata environment.

A good candidate for an initial migration from a Teradata environment that would support these objectives typically is one that implements a Power BI/analytics workload rather than an OLTP workload. The workload should have a data model that can be migrated with minimal modifications, such as a star or snowflake schema.

For size, it's important that the data volume you migrate in the initial exercise is large enough to demonstrate the capabilities and benefits of the Azure Synapse environment while keeping the time to demonstrate value short. The size that typically meets the requirements is in the range of 1 TB to 10 TB.

An approach for the initial migration project that minimizes risk and implementation time is to confine the scope of the migration to data marts. This approach is a good starting point because it clearly limits the scope of the migration and typically can be achieved on a short timescale. An initial migration of data marts only doesn't address broader concerns like how to migrate ETL and historical data. These areas must be addressed in later phases as the migrated data mart layer is backfilled with the data and processes that are required to build them.

## Lift-and-shift approach vs. phased approach

Regardless of the drivers and scope that you choose for your migration, generally, you can choose from two types of migration:

- **Lift-and-shift approach**: In this approach, the existing data model, such as a star schema, is migrated unchanged to the new Azure Synapse platform. In this scenario, the emphasis is on minimizing risk and the time it takes to migrate by reducing the work that has to be done to achieve the benefits of moving to the Azure cloud environment.

  This approach is a good fit for existing Teradata environments in which a single data mart is to be migrated if the data is already in a well-designed star or snowflake schema, or if you have time and cost pressures to move to a more modern cloud environment.

- **Phased approach that incorporates modifications**: When a legacy warehouse has evolved over time, you might need to reengineer the data warehouse to maintain the required performance or support new data sources like IoT streams. Migrating to Azure Synapse for the well-known benefits of a scalable cloud environment might be considered part of the re-engineering process. This process might include changing the underlying data model, such as moving from an Inmon model to Azure Data Vault.

  The recommended approach is to initially move the existing data model as-is to Azure. Then, take advantage of the performance and flexibility of Azure services to apply the re-engineering changes without affecting the existing source system.





## Using a VM Teradata instance as part of a migration

One optional approach for running a migration from an on-premises Teradata environment is to use the Azure environment that provides cheap cloud storage and elastic scalability to create a Teradata instance within a VM in Azure, colocated with the target Azure Synapse Analytics environment.

With this approach, standard Teradata utilities such as Teradata Parallel Data Transporter (or third-party data replication tools such as Attunity Replicate) can be used to efficiently move the subset of Teradata tables that are to be migrated onto the VM instance, and then all migration tasks can take place within the Azure environment. This approach has several benefits:

- After the initial replication of data, the source system is not affected by the migration tasks.
- The familiar Teradata interfaces, tools, and utilities are available within the Azure environment.
- Once in the Azure environment there are no potential issues with network bandwidth availability between the on-premises source system and the cloud target system.
- Tools such as Azure Data Factory can efficiently call utilities such as Teradata Parallel Transporter to migrate data quickly and easily.
- The migration process is orchestrated and controlled entirely within the Azure environment.





## Metadata migration

It makes sense to automate and orchestrate the migration process by using the capabilities of the Azure environment. This approach also minimizes the effect on the existing Teradata environment, which might already be running close to full capacity.

Azure Data Factory is a cloud-based data integration service. You can use Data Factory to create data-driven workflows in the cloud to orchestrate and automate data movement and data transformation. Data Factory pipelines can ingest data from disparate datastores, and then process and transform the data by using compute services like Azure HDInsight for Apache Hadoop and Apache Spark, Azure Data Lake Analytics, and Azure Machine Learning. You start by creating metadata to list the data tables you want to migrate, with their locations, and then use Data Factory capabilities to manage the migration process.

## Design differences between Teradata and Azure Synapse

As you plan your migration from a legacy Teradata environment to Azure Synapse, it's important to consider the design differences between the two platforms.

### Multiple databases vs. a single database and schemas

In a Teradata environment, you might have multiple, separate databases for different parts of the overall environment. For example, you might have a separate database for data ingestion and staging tables, a database for core warehouse tables, and another database for data marts (sometimes called a *semantic layer*). Processing separate databases as ETL/ELT pipelines in Azure Synapse might require implementing cross-database joins and moving data between the separate databases.

The Azure Synapse environment has a single database. Schemas are used to separate tables into logically separate groups. We recommend that you use a series of schemas in the target Azure Synapse to mimic any separate databases that you migrate from Teradata. If you use schemas in the Teradata environment, you might need to use a new naming convention to move the existing Teradata tables and views to the new environment. For example, you might concatenate the existing Teradata schema and table names into the new Azure Synapse table name, and then use schema names in the new environment to maintain the original separate database names. 

Another option is to use SQL views over the underlying tables to maintain the logical structures. There are some potential downsides to using SQL views:

- Views in Azure Synapse are read-only, so you must make any updates to the data on the underlying base tables.
- If layers of views already exist, adding another layer of views might affect performance.

### Tables

When you migrate tables between different technologies, you physically move only raw data and the metadata that describes it between the two environments. You don't migrate database elements like indexes from the source system because they might not be needed or they might be implemented differently in the new environment.

However, understanding where performance optimizations like indexes have been used in the source environment can be a helpful indication of where you might optimize performance in the new environment. For example, if queries in the source Teradata environment frequently use zone maps, you might conclude that it would be advantageous to create a nonclustered index in the migrated Azure Synapse environment, or that using other native performance optimization techniques like table replication might be preferable to creating a like-for-like index.




### High availability for the database

Teradata supports data replication across nodes via the `FALLBACK` option, where table rows that reside physically on a given node are replicated to another node within the system. This approach guarantees data will not be lost if there is a node failure and provides the basis for failover scenarios.

The goal of the high availability architecture in Azure SQL Database is to guarantee that your database is up and running 99.99% of time, without worrying about the impact of maintenance operations and outages. Azure automatically handles critical servicing tasks, such as patching, backups, Windows and SQL upgrades, as well as unplanned events such as underlying hardware, software, or network failures.

Data storage in Azure Synapse Analytics is automatically backed up by use of snapshots. These snapshots are a built-in feature of the service that creates restore points. You do not have to enable this capability. Automatic restore points currently cannot be deleted by users where the service uses these restore points to maintain SLAs for recovery.

Azure SQL Data Warehouse takes snapshots of the data warehouse throughout the day creating restore points that are available for seven days. This retention period cannot be changed. Azure SQL Data Warehouse supports an eight-hour recovery point objective (RPO). You can restore your data warehouse in the primary region from any one of the snapshots taken in the past seven days. Other user-defined options are available if more granular backups are required.

### Unsupported Teradata table types

Teradata includes support for special table types for time series and temporal data. The syntax and some of the functions for these table types is not directly supported within Azure Synapse Analytics but the data can be migrated into a standard table with appropriate data types and indexing or partitioning on the date/time column.

Teradata implements the temporal query functionality via query rewriting to add additional filters within a temporal query to limit the applicable date range. If this functionality is currently in use within the source Teradata environment and is to be migrated, then this additional filtering will need to be added into the relevant temporal queries.

The Azure environment also includes specific features for complex analytics on time series data at scale called Time Series Insights. This is aimed at IoT data analysis applications and may be more appropriate for this use case. For more information, see [Azure Time Series Insights](https://azure.microsoft.com/services/time-series-insights/).

### Teradata data type mapping

Some Teradata data types are not directly supported in the Azure Synapse Analytics. The table below shows these data types together with the recommended approach for handling them. In the table, Teradata column type is the type that is stored within the system catalog (for example, in `DBC.ColumnsV`).

Use the metadata from the Teradata catalog tables to determine whether any of these data types are to be migrated and allow for this in the migration plan. For instance, a SQL query such as the one below can be used to find any occurrences of unsupported data types that need attention.

There are third-party vendors who offer tools and services to automate migration including the mapping of data types as described above. Also, if a third-party ETL tool such as Informatica or Talend is already in use in the Teradata environment, these can implement any required data transformations.

## SQL DML syntax differences

There are a few differences in SQL Data Manipulation Language (DML) syntax between Teradata SQL and Azure Synapse Analytics to consider when migrating:

- **QUALIFY:** Teradata supports the `QUALIFY` operator. For example:

  `SELECT col1 FROM tab1 WHERE col1='XYZ'`

  Third-party tools and services can automate data-mapping tasks:

  `QUALIFY ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) = 1;`

  This can be achieved in Azure Synapse by the syntax below:

  `SELECT * FROM (SELECT col1, ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) rn FROM tab1 WHERE c1='XYZ' ) WHERE rn = 1;`

- **Date arithmetic:** Azure Synapse has operators such as:

  - `DATEADD` and `DATEDIFF`, which can be used on `DATE` or `DATETIME` fields. Teradata supports direct subtraction on dates, such as:

    `SELECT DATE1 - DATE2 FROM ...`

  - `LIKE ANY` syntax, such as:

    `SELECT * FROM CUSTOMER WHERE POSTCODE LIKE ANY ('CV1%', 'CV2%', CV3%') ;`.

    The equivalent in Azure Synapse syntax is:

    `SELECT * FROM CUSTOMER WHERE (POSTCODE LIKE 'CV1%') OR (POSTCODE LIKE 'CV2%') OR (POSTCODE LIKE 'CV3%') ;`

- Depending on system settings, character comparisons in Teradata may be non-case-specific by default. In Azure Synapse these comparisons are always case-specific.





## Functions, stored procedures, triggers, and sequences

When migrating from a mature legacy data warehouse environment such as Teradata, there are often elements other than simple tables and views that need to be migrated to the new target environment. Examples of this are functions, stored Procedures, triggers, and sequences.

As part of the preparation phase, an inventory of these objects that are to be migrated should be created and the method of handling them defined, with an appropriate allocation of resources assigned in the project plan.

Facilities in the Azure environment might replace the functionality implemented as functions or stored procedures in the Teradata environment. In this case, it's typically more efficient to use the built-in Azure facilities rather than recoding the Teradata functions.

For more information on each of these elements, see below.

### Functions

In common with most database products, Teradata supports system functions and also user-defined functions within the SQL implementation. When migrating to another database platform such as Azure Synapse, common system functions are generally available and can be migrated without change. Some system functions may have slightly different syntax, but the required changes can be automated in this case.

For system functions where there is no equivalent, or for arbitrary user-defined functions these may need to be recoded using the languages available in the target environment. Azure Synapse uses the popular Transact-SQL language for implementation of user-defined functions.

### Stored procedures

Most modern database products allow for procedures to be stored within the database. Teradata provides the SPL language for this purpose. A stored procedure typically contains SQL statements and some procedural logic and may return data or a status.

SQL Azure Data Warehouse also supports stored procedures using T-SQL, so if there are stored procedures to be migrated, they must be recoded accordingly.

### Triggers

Creation of triggers is not supported within Azure Synapse but can be implemented within Azure Data Factory.

### Sequences

Azure Synapse sequences are handled in a similar way to Teradata, via use of `IDENTITY` columns or using SQL code to create the next sequence number in a series.

## Extracting metadata and data from a Teradata environment

### Data Definition Language (DDL) generation

It is possible to edit existing Teradata `CREATE TABLE` and `CREATE VIEW` scripts to create the equivalent definitions (with modified data types if necessary as described above). Typically, this involves removing extra Teradata-specific clauses (for example, `FALLBACK`).

However, all the information that specifies the current definitions of tables and views within the existing Teradata environment is maintained within system catalog tables. This is the best source of this information as it is guaranteed to be up to date and complete. User-maintained documentation might not be in sync with the current table definitions.

This information can be accessed via views onto the catalog such as `DBC.ColumnsV` and can be used to generate the equivalent `CREATE TABLE` DDL statements for the equivalent tables in Azure Synapse.  

Third-party migration and ETL tools also use the catalog information to achieve the same result.

### Data extraction from Teradata

Migrate the raw data to from existing Teradata tables using standard Teradata utilities such as `BTEQ` and `FASTEXPORT`. Generally during a migration exercise, it is important to extract the data as efficiently as possible and the recommended approach for this with recent versions of Teradata is to use Teradata Parallel Transporter, which will use multiple parallel `FASTEXPORT` streams to achieve the best throughput.

Teradata Parallel Transporter can be called directly from Azure Data Factory and this is the recommended approach for managing the data migration process (this is true whether the Teradata instance in on-premises or copied to a VM within the Azure environment as described above).  
Recommended data formats for the extracted data are delimited text files (also called Comma-Separated Values or similar) or Optimized Row Columnar (ORC) or Parquet files.

For more detailed information on the process of migrating data and ETL from a Teradata environment see the associated document Section 2.1. Data Migration ETL and Load from Teradata.

## Performance Recommendations for Teradata Migrations

Differences in performance tuning approach

### Data distribution options

Azure enables the specification of data distribution methods for individual tables. The aim is to reduce the amount of data that must be moved between processing nodes when executing a query.  

For large table-large table joins, hash distributing one or both (ideally both) tables on the join columns will ensure that join processing can be performed locally as the data rows to be joined will already be collocated on the same processing node.

Another way to achieve local joins for small table-large table joins (typically dimension table to fact table in a star schema model) is to replicate the smaller dimension table across all nodes, therefore ensuring any value of the join key of the larger table will have a matching dimension row locally available. The overhead of replicating the dimension tables is relatively low, provided the tables are not large. In this case, the hash distribution approach as described above is more appropriate.

### Data indexing

Azure Synapse provides a number of indexing options, but these are different in operation and usage to those implemented in Teradata. More details of the different indexing options are described in [Design tables in Azure Synapse pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview).

Existing indexes within the source Teradata environment can however provide a useful indication of how the data is currently used and provide an indication of candidates for indexing within the Azure Synapse environment.

### Data partitioning

In an enterprise data warehouse fact tables can contain many billions of rows and partitioning is a way to optimize the maintenance and querying of these tables by splitting them into separate parts to reduce the amount of data processed. The partitioning specification for a table is defined in the `CREATE TABLE` statement.

Only one field per table can be used for partitioning, and this is frequently a date field as many queries will be filtered by date or a date range. You can change the partitioning of a table after initial load if necessary by recreating the table with the new distribution using the `CREATE TABLE AS SELECT` statement. For a detailed discussion of partitioning in Azure Synapse, see [Partitioning tables in Synapse SQL pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-partition).

### Data table statistics

Ensure that statistics on data tables are up to date. This can be achieved by building in a `COLLECT STATISTICS` step to ETL/ELT jobs, or by enabling automatic statistics collection on the table.

- **PolyBase for data loading**: PolyBase is the most efficient method to use to load large amounts of data into a warehouse. You can use PolyBase to load data in parallel streams.

- **Resource classes for workload management**: Azure Synapse uses resource classes to manage workloads. In general, large resource classes provide better individual query performance. Smaller resource classes give you higher levels of concurrency. You can use dynamic management views to monitor utilization to help ensure that the appropriate resources are used efficiently.

## Next steps

For more information about implementing a Netezza migration, talk with your Microsoft account representative about on-premises migration offers.
