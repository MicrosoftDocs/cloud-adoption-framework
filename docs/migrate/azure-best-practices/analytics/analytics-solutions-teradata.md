---
title: "Analytics solutions for Teradata"
description: Use the Cloud Adoption Framework for Azure to learn about analytic solutions with Teradata.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/22/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore CTAS DATEADD DATEDIFF Attunity Teradata Inmon NUSI Informatica Talend BTEQ FASTEXPORT QUALIFY ORC Parquet "Parallel Data Transporter" "Attunity Replicate" -->

# Analytics solutions for Teradata

Existing users of Teradata data warehouse systems are now looking to take advantage of the innovations provided by newer environments (for example, cloud, IaaS, PaaS) and to delegate tasks such as infrastructure maintenance and platform development to the cloud provider.

While there are similarities between Teradata and Azure Synapse Analytics in that both are SQL databases designed to use massively parallel processing (MPP) techniques to achieve high query performance on large data volumes, there are also some basic differences in approach:

- Legacy Teradata systems will usually be installed on-premises, using proprietary hardware whereas Azure Synapse Analytics uses cloud-based storage and compute resources.
- Upgrading a Teradata configuration is a major task involving additional physical hardware and a potentially lengthy database reconfiguration. Since storage and compute resources are separate in the Azure environment these can easily be scaled (upwards and downwards) independently using the elastic scalability capability.
- Azure Synapse Analytics can be paused or resized as required to reduce resource utilization and therefore cost.

To maximize these benefits, it's necessary to migrate existing (or new) data and applications to the Azure Synapse Analytics platform, and in many organizations this will include migration of an existing data warehouse from legacy on-premises platforms such as Teradata. At a high level, the basic process will include the following steps:

<!-- markdownlint-disable MD033 -->

| Preparation | Migration | Post migration |
|---|---|---|
| <li> Define scope - what is to be migrated <li> Build inventory of data and processes for migration <li> Define data model changes (if any) <li> Identify appropriate Azure (and third-party) tools and features to be used <li> Train staff early on new platform <li> Set up Azure target platform |  <li> Start small and simple <li> Automate where possible <li> Use Azure built in tools and features to reduce migration effort <li> Migrate metadata for tables and views <li> Migrate historical data to be maintained <li> Migrate or refactor stored procedures and business processes <li> Migrate or refactor etl/elt incremental load processes |  <li> Monitor and document all stages of the process <li> Use experience gained to build a template for future migrations <li> Re-engineer the data model if required (using new platform performance and scalability) <li> Test applications and query tools <li> Benchmark and optimize query performance |

## Migration scope

### Choose the workload for the initial migration

Legacy Teradata environments have typically evolved over time to encompass multiple subject areas and mixed workloads. When deciding where to start on an initial migration project it makes sense to choose an area that will be able to:

- Prove the viability of migrating to Azure Synapse Analytics by quickly delivering the benefits of the new environment.
- Allow the in-house technical staff to gain relevant experience of the processes and tools involved that can be used in migrations of other areas.
- Create a template for further migration exercises that is specific to the source Teradata environment and the current tools and processes that are already in place.

A good candidate for an initial migration from a Teradata environment, which would enable the items above, is typically one that implements a BI/analytics workload (that is, not an OLTP workload) with a data model that can be migrated with minimal modifications—normally a star or snowflake schema.

In terms of size, it is important that the data volume to be migrated in the initial exercise is large enough to demonstrate the capabilities and benefits of the Azure Synapse Analytics environment, while keeping the time to demonstrate value short, typically in the 1-10 TB range.

One possible approach for the initial migration project that will minimize the risk and reduce the implementation time for the initial project is to confine the scope of the migration to just the data marts (for example, the OLAP database part of a Teradata warehouse). This approach, by definition, limits the scope of the migration and can typically be achieved within short timescales and so can be a good starting point. However, this will not address the broader topics such as etl migration and historical data migration as part of the initial migration project. These would have to be addressed in later phases of the project as the migrated data mart layer is back filled with the data and processes required to build them.

## Lift and shift as-is versus a phased approach incorporating changes

Whatever the drivers and scope of the intended migration, broadly speaking there are two types of migration:

### Lift and shift

In this case, the existing data model (for example, a star schema) is migrated unchanged to the new Azure Synapse Analytics platform. The emphasis here is on minimizing risk and the time taken to migrate by reducing the work that has to be done to achieve the benefits of moving to the Azure cloud environment.

This is a good fit for existing Teradata environments where a single data mart is to be migrated, or the data is already in a well-designed star or snowflake schema, or perhaps there are time pressures to move to a more modern environment.

### Phased approach incorporating modifications

For cases where a legacy warehouse has evolved over a long time it may be necessary to re-engineer to maintain the required performance levels or support new data (for example, IoT streams). Migration to Azure Synapse Analytics to obtain the benefits of a scalable cloud environment might be considered as part of the re-engineering process. This could include a change of the underlying data model (for example, a move from an Inmon model to data vault).

The recommended approach for this is to initially move the existing data model as-is into the Azure environment (optionally using a VM Teradata instance in Azure as described below) then to use the performance and flexibility of the Azure environment to apply the re-engineering changes, using the Azure capabilities where appropriate to make the changes without affecting the existing source system.

## Using a VM Teradata instance as part of a migration

One optional approach for running a migration from an on-premises Teradata environment is to use the Azure environment that provides cheap cloud storage and elastic scalability to create a Teradata instance within a VM in Azure, colocated with the target Azure Synapse Analytics environment.

With this approach, standard Teradata utilities such as Teradata Parallel Data Transporter (or third-party data replication tools such as Attunity Replicate) can be used to efficiently move the subset of Teradata tables that are to be migrated onto the VM instance, and then all migration tasks can take place within the Azure environment. This approach has several benefits:

- After the initial replication of data, the source system is not affected by the migration tasks.
- The familiar Teradata interfaces, tools, and utilities are available within the Azure environment.
- Once in the Azure environment there are no potential issues with network bandwidth availability between the on-premises source system and the cloud target system.
- Tools such as Azure Data Factory can efficiently call utilities such as Teradata Parallel Transporter to migrate data quickly and easily.
- The migration process is orchestrated and controlled entirely within the Azure environment.

## Use Azure Data Factory to implement a metadata-driven migration

It makes sense to automate and orchestrate the migration process by making use of the capabilities in the Azure environment. This approach also minimizes the impact on the existing Teradata environment (which may already be running close to full capacity).

Azure Data Factory is a cloud-based data integration service that allows creation of data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. Using Azure Data Factory, you can create and schedule data-driven workflows (called pipelines) that can ingest data from disparate data stores. It can process and transform the data by using compute services such as Azure HDInsight Hadoop, Spark, Azure Data Lake Analytics, and Azure Machine Learning.

By creating metadata to list the data tables to be migrated and their location, it is possible to use the Azure Data Factory facilities to manage and automate parts of the migration process.

## Design differences between Teradata and Azure Synapse Analytics

### Separate databases versus schemas

In a Teradata environment it is common to define multiple separate databases for individual parts of the overall environment, for example, there may be a separate database for data ingestion and staging tables, a database for the core warehouse tables and another database for data marts (sometimes called a semantic layer). Processing such as etl/elt pipelines may implement cross-database joins and will move data between these separate databases.

In the Azure Synapse Analytics environment there is a single database, and schemas are used to separate the tables into logically separate groups. Therefore, the recommendation is to use a series of schemas within the target Azure Synapse Analytics to mimic the separate databases that will be migrated from the Teradata environment. If schemas are already being used within the Teradata environment, then it may be necessary to use a new naming convention to move the existing Teradata tables and views to the new environment (for example, concatenate the existing Teradata schema and table names into the new Azure Synapse Analytics table name and use schema names in the new environment to maintain the original separate database names). Another option is to use SQL views over the underlying tables to maintain the logical structures, but there are some potential downsides to this approach:

- Views in Azure Synapse Analytics are read-only, so any updates to the data must take place on the underlying base tables.
- There may already be a layer (or layers) of views in existence and adding an extra layer of views might affect performance.

### Table considerations

When migrating tables between different technologies it is generally only the raw data (and the metadata that describes it) that gets physically moved between the two environments. Other database elements from the source system (for example, indexes) are not migrated as these may not be needed, or may be implemented differently within the new target environment.

However, it is important to understand where performance optimizations such as indexes have been used in the source environment as this information can give useful indication of where performance optimization might be added in the new target environment. For example, if a NUSI has been created within the source Teradata environment, it may indicate that a non-clustered index should be created within the migrated Azure Synapse Analytics, but also be aware that other native performance optimization techniques (such as table replication) may be more applicable than a straight like-for-like creation of indexes.

### High availability for the database

Teradata supports data replication across nodes via the `FALLBACK` option, where table rows that reside physically on a given node are replicated to another node within the system. This approach guarantees data will not be lost if there is a node failure and provides the basis for failover scenarios.

The goal of the high availability architecture in Azure SQL Database is to guarantee that your database is up and running 99.99% of time, without worrying about the impact of maintenance operations and outages. Azure automatically handles critical servicing tasks, such as patching, backups, Windows and SQL upgrades, as well as unplanned events such as underlying hardware, software, or network failures.

Data storage in Azure Synapse Analytics is automatically backed up by use of snapshots. These are a built-in feature of the service that creates restore points. You do not have to enable this capability. Automatic restore points currently cannot be deleted by users where the service uses these restore points to maintain SLAs for recovery.

SQL data warehouse takes snapshots of the data warehouse throughout the day creating restore points that are available for seven days. This retention period cannot be changed. Azure SQL Data Warehouse supports an eight-hour recovery point objective (RPO). You can restore your data warehouse in the primary region from any one of the snapshots taken in the past seven days. Other user-defined options are available if more granular backups are required.

### Unsupported Teradata table types

Teradata includes support for special table types for time series and temporal data. The syntax and some of the functions for these table types is not directly supported within Azure Synapse Analytics but the data can be migrated into a standard table with appropriate data types and indexing or partitioning on the date/time column.

Teradata implements the temporal query functionality via query rewriting to add additional filters within a temporal query to limit the applicable date range. If this functionality is currently in use within the source Teradata environment and is to be migrated, then this additional filtering will need to be added into the relevant temporal queries.

The Azure environment also includes specific features for complex analytics on time series data at scale called Time Series Insights. This is aimed at IoT data analysis applications and may be more appropriate for this use case. For more information, see [Azure Time Series Insights](https://azure.microsoft.com/services/time-series-insights/).

### Teradata data type mapping

Some Teradata data types are not directly supported in the Azure Synapse Analytics. The table below shows these data types together with the recommended approach for handling them. In the table, Teradata column type is the type that is stored within the system catalog (for example, in `DBC.ColumnsV`).

Use the metadata from the Teradata catalog tables to determine whether any of these data types are to be migrated and allow for this in the migration plan. For instance, a SQL query such as the one below can be used to find any occurrences of unsupported data types that need attention.

There are third-party vendors who offer tools and services to automate migration including the mapping of data types as described above. Also, if a third-party etl tool such as Informatica or Talend is already in use in the Teradata environment, these can implement any required data transformations.

## SQL DML syntax differences

There are a few differences in SQL Data Manipulation Language (DML) syntax between Teradata SQL and Azure Synapse Analytics to consider when migrating:

- **QUALIFY:** Teradata supports the `QUALIFY` operator. For example:

  `SELECT col1 FROM tab1 WHERE col1='XYZ'`

  Third-party tools and services can automate data mapping tasks:

  `QUALIFY ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) = 1;

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

When migrating from a mature legacy data warehouse environment such as Teradata, there are often elements other than simple tables and views that need to be migrated to the new target environment. Examples of this are Functions, Stored Procedures, Triggers, and Sequences.

As part of the preparation phase, an inventory of these objects that are to be migrated should be created and the method of handling them defined, with an appropriate allocation of resources assigned in the project plan.

It may be that there are facilities in the Azure environment that replace the functionality implemented as functions or stored procedures in the Teradata environment; in which case it is generally more efficient to use the built-in Azure facilities rather than recoding the Teradata functions.

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

However, all the information that specifies the current definitions of tables and views within the existing Teradata environment is maintained within system catalog tables. This is the best source of this information as it is guaranteed to be up to date and complete. (Be aware that user-maintained documentation may not be in sync with the current table definitions.)

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

Azure Synapse provides a number of indexing options, but these are different in operation and usage to those implemented in Teradata. More details of the different indexing options are described in [Design tables in SQL Synapse pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-overview).

Existing indexes within the source Teradata environment can however provide a useful indication of how the data is currently used and provide an indication of candidates for indexing within the Azure Synapse environment.

### Data partitioning

In an enterprise data warehouse fact tables can contain many billions of rows and partitioning is a way to optimize the maintenance and querying of these tables by splitting them into separate parts to reduce the amount of data processed. The partitioning specification for a table is defined in the CREATE TABLE statement.

Only one field per table can be used for partitioning, and this is frequently a date field as many queries will be filtered by date or a date range. Note that it is possible to change the partitioning of a table after initial load if necessary by recreating the table with the new distribution using the CREATE TABLE AS (or CTAS) statement. For a detailed discussion of partitioning in Azure Synapse, see [Partitioning tables in Synapse SQL pool](https://docs.microsoft.com/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-partition).

### Data table statistics

Ensure that statistics on data tables are up to date. This can be achieved by building in a `COLLECT STATISTICS` step to ETL/ELT jobs, or by enabling automatic statistics collection on the table.

### PolyBase for data loading

PolyBase is the most efficient method for loading large amounts of data into the warehouse, as it can use parallel loading streams.

### Use resource classes for workload management

Azure Synapse Analytics uses resource classes to manage workloads. In general, large resource classes provide better individual query performance, while smaller resource classes enable higher levels of concurrency. Utilization can be monitored via dynamic management views to ensure that the appropriate resources are being used efficiently.

## Next steps

For more information on implementing a Teradata migration, talk with your Microsoft account representative about on-premises migration offers.
