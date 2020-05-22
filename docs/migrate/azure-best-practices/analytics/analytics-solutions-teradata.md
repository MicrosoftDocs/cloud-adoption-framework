---
title: "Analytics solutions for Teradata"
description: Use the Cloud Adoption Framework for Azure to learn about analytic solutions with teradata.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/22/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Analytics solutions for Teradata

Existing users of Teradata data warehouse systems are now looking to take advantage of the innovations provided by newer environments (e.g. cloud, IaaS, PaaS) and to delegate tasks such as infrastructure maintenance and platform development to the cloud provider.  

While there are similarities between Teradata and Azure Synapse in that both are SQL databases designed to use massively parallel processing (MPP) techniques to achieve high query performance on very large data volumes, there are also some basic differences in approach:

- Legacy Teradata systems will usually be installed on-premise, using proprietary hardware whereas Azure Synapse is cloud based using Azure storage and compute resources.
- Upgrading a Teradata configuration is a major task involving additional physical hardware and a potentially lengthy database reconfiguration. Since storage and compute resources are separate in the Azure environment these can easily be scaled (upwards and downwards) independently leveraging the elastic scalability capability.
- Azure Synapse can be paused or resized as required to reduce resource utilization and therefore cost.

Microsoft Azure is a globally available, highly secure, scalable cloud environment which includes Azure Synapse within an eco-system of supporting tools and capabilities.

<!-- TODO insert high resolution image -->

 (Source section: Migration to Azure Synapse Analytics Section 1.1 – Design and performance for Teradata migrations)

Azure Synapse provides best-of-breed relational database performance by using techniques such as massively parallel processing (MPP) and automatic in-memory caching. The results of this approach can be seen in independent benchmarks such as the one run recently by GigaOm – see <!-- https://gigaom.com/report/datawarehouse-cloud-benchmark/  this link doesn't work -->which compares Azure Synapse to other popular cloud data warehouse offerings. Customers who have already migrated to this environment have seen many benefits including:

- Improved performance and price/performance
- Increased agility and shorter time to value
- Faster server deployment and application development
- Elastic scalability – only pay for actual usage
- Improved security/compliance
- Reduced storage and Disaster Recovery costs  
- Lower overall TCO and better cost control (OPEX)

 To maximize these benefits it is necessary to migrate existing (or new) data and applications to the Azure Synapse platform, and in many organizations this will include migration of an existing data warehouse from legacy on-premise platforms such as Teradata. At a high level, the basic process will include the following steps:

<!-- markdownlint-disable MD033 -->

| ![1](./_images/icons/1.png) **Preparation** | ![2](./_images/icons/2.png) **Migration** | ![3](./_images/icons/3.png) **Post migration** |
|---|---|---|
|<li>Define scope - what is to be migrated<li>Build inventory of data and processes for mitration<li>Define data model changes (if any)<li>Identify appropriate Azure (and third party) tools and features to be used<li>Train staff early on new platform<li>Set up Azure target platform | <li>Start small and simple<li>Automate where possible<li>Leverage Azure built in tools and features to reduce migration effort<li>Migrate metadata for tables and views<li>Migrate historical data to be maintained<li>Migrate or refactor stored procedures and business processes<li>Migrate or refactor ETL/ELT incremental load processes | <li>Monitor and document all stages of the process<li>Use experience gained to build a template for future migrations<li>Re-engineer the data model if required (using new platform performance and scalability)<li>Test applications and query tools<li>Benchmark and optimize query performance |

## Design considerations

<!-- TODO - write intro paragraphg -->

### Migration scope

Choosing the workload for the initial migration
Legacy Teradata environments have typically evolved over time to encompass multiple subject areas and mixed workloads. When deciding where to start on an initial migration project it makes sense to choose an area that will be able to:  

- Prove the viability of migrating to Azure Synapse by quickly delivering the benefits of the new environment  
- Allow the in-house technical staff to gain relevant experience of the processes and tools involved that can be used in migrations of other areas
- Create a template for further migration exercises that is specific to the source Teradata environment and the current tools and processes that are already in place

A good candidate for an initial migration from a Teradata environment, which would enable the items above, is typically one that implements a BI/Analytics workload (i.e. not an OLTP workload) with a data model that can be migrated with minimal modifications—normally a star or snowflake schema.  

In terms of size, it is important that the data volume to be migrated in the initial exercise is large enough to demonstrate the capabilities and benefits of the Azure Synapse environment, while keeping the time to demonstrate value short, typically in the 1–10TB range.  

One possible approach for the initial migration project that will minimize the risk and reduce the implementation time for the initial project is to confine the scope of the migration to just the data marts (e.g. the OLAP DB part of a Teradata warehouse). This approach, by definition, limits the scope of the migration and can typically be achieved within short timescales and so can be a good starting point. However, this will not address the broader topics such as ETL migration and historical data migration as part of the initial migration project. These would have to be addressed in later phases of the project as the migrated data mart layer is back filled with the data and processes required to build them.

### Lift and shift as is vs a phased approach incorporating changes

Whatever the drivers and scope of the intended migration, broadly speaking there are 2 types of migration:

**Lift and shift**:
In this case the existing data model (e.g. star schema) is migrated unchanged to the new Azure Synapse platform. The emphasis here is on minimizing risk and the time taken to migrate by reducing the work that has to be done to achieve the benefits of moving to the Azure cloud environment.  

This is a good fit for existing Teradata environments where a single data mart is to be migrated, or the data is already in a well-designed star or snowflake schema, or perhaps there are time pressures to move to a more modern environment.

**Phased approach incorporating modifications**:
For cases where a legacy warehouse has evolved over a long time it may be necessary to re-engineer to maintain the required performance levels or support new data (e.g. IoT steams). Migration to Azure Synapse to obtain the benefits of a scalable cloud environment might be considered as part of the re-engineering process. This could include a change of the underlying data model (e.g. a move from an Inmon model to Data Vault).

The recommended approach for this is to initially move the existing data model as-is into the Azure environment (optionally using a VM Teradata instance in Azure as described below) then to use the performance and flexibility of the Azure environment to apply the re-engineering changes, leveraging the Azure capabilities where appropriate to make the changes without impacting the existing source system.

### Using a VM Teradata instance as part of a migration

One optional approach for running a migration from an on-premises Teradata environment is to leverage the Azure environment that provides cheap cloud storage and elastic scalability to create a Teradata instance within a VM in Azure, co-located with the target Azure Synapse environment.

With this approach, standard Teradata utilities such as Teradata Parallel Data Transporter (or third-party data replication tools such as Attunity Replicate) can be used to efficiently move the subset of Teradata tables that are to be migrated onto the VM instance, and then all migration tasks can take place within the Azure environment. This approach has several benefits:

- After the initial replication of data, the source system is not impacted by the migration tasks
- The familiar Teradata interfaces, tools, and utilities are available within the Azure environment
- Once in the Azure environment there are no potential issues with network bandwidth availability between the on-premises source system and the cloud target system
- Tools such as Azure Data Factory can efficiently call utilities such as Teradata Parallel Transporter to migrate data quickly and easily
• The migration process is orchestrated and controlled entirely within the Azure environment

### Use Azure Data Factory to implement a metadata-driven migration

It makes sense to automate and orchestrate the migration process by making use of the capabilities in the Azure environment. This approach also minimizes the impact on the existing Teradata environment (which may already be running close to full capacity).

Azure Data Factory is a cloud-based data integration service that allows creation of data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. Using Azure Data Factory, you can create and schedule data-driven workflows (called pipelines) that can ingest data from disparate data stores. It can process and transform the data by using compute services such as Azure HDInsight Hadoop, Spark, Azure Data Lake Analytics, and Azure Machine Learning.

By creating metadata to list the data tables to be migrated and their location, it is possible to use the ADF facilities to manage and automate parts of the migration process.

### Design differences between Teradata and Azure Synapse

**Separate databases vs schemas**:
In a Teradata environment it is common to define multiple separate databases for individual parts of the overall environment, e.g. there may be a separate database for data ingestion and staging tables, a database for the core warehouse tables and another database for data marts (sometimes called a semantic layer). Processing such as ETL/ELT pipelines may implement cross-database joins and will move data between these separate databases.

In the Azure Synapse environment there is a single database, and schemas are used to separate the tables into logically separate groups. Therefore, the recommendation is to use a series of schemas within the target Azure Synapse to mimic the separate databases that will be migrated from the Teradata environment. If schemas are already being used within the Teradata environment, then it may be necessary to use a new naming convention to move the existing Teradata tables and views to the new environment (e.g. concatenate the existing Teradata schema and table names into the new Azure Synapse table name and use schema names in the new environment to maintain the original separate database names). Another option is to use SQL views over the underlying tables to maintain the logical structures, but there are some potential downsides to this approach:

- Views in Azure Synapse are read-only, therefore any updates to the data must take place on the underlying base tables
- There may already be a layer (or layers) of views in existence and adding an extra layer of views might impact performance

**Table considerations**:
When migrating tables between different technologies it is generally only the raw data (and the metadata that describes it) that gets physically moved between the 2 environments. Other database elements from the source system (e.g. indexes) are not migrated as these may not be needed, or may be implemented differently within the new target environment.  

However, it is important to understand where performance optimizations such as indexes have been used in the source environment as this information can give useful indication of where performance optimization might be added in the new target environment. For example, if a NUSI has been created within the source Teradata environment, it may indicate that a non-clustered index should be created within the migrated Azure Synapse, but also be aware that other native performance optimization techniques (such as table replication) may be more applicable than a straight like-for-like creation of indexes.

**High availability for the database**:
Teradata supports data replication across nodes via the FALLBACK option, where table rows that reside physically on a given node are replicated to another node within the system. This approach guarantees data will not be lost if there is a node failure and provides the basis for failover scenarios.

The goal of the high availability architecture in Azure SQL Database is to guarantee that your database is up and running 99.99% of time, without worrying about the impact of maintenance operations and outages. Azure automatically handles critical servicing tasks, such as patching, backups, Windows and SQL upgrades, as well as unplanned events such as underlying hardware, software, or network failures.

Data storage in Azure Synapse is automatically backed up by use of snapshots. These are a built-in feature of the service that creates restore points. You do not have to enable this capability. Automatic restore points currently cannot be deleted by users where the service uses these restore points to maintain SLAs for recovery.

SQL Data Warehouse takes snapshots of the data warehouse throughout the day creating restore points that are available for seven days. This retention period cannot be changed. SQL Data Warehouse supports an eight-hour recovery point objective (RPO). You can restore your data warehouse in the primary region from any one of the snapshots taken in the past seven days. Other user-defined options are available if more granular backups are required.

**Unsupported Teradata table types**:
Teradata includes support for special table types for time series and temporal data. The syntax and some of the functions for these table types is not directly supported within Azure Synapse but the data can be migrated into a standard table with appropriate data types and indexing or partitioning on the date/time column.

Teradata implements the temporal query functionality via query re-writing to add additional filters within a temporal query to limit the applicable date range. If this functionality is currently in use within the source Teradata environment and is to be migrated, then this additional filtering will need to be added into the relevant temporal queries.

The Azure environment also includes specific features for complex analytics on timeseries data at scale called Time Series Insights. This is aimed at IoT data analysis applications and may be more appropriate for this use-case. See [Azure Time Series Insights](https://azure.microsoft.com/services/time-series-insights/) for more information.  

**Teradata data type mapping**:
Some Teradata datatypes are not directly supported in the Azure Synapse. The table below shows these data types together with the recommended approach for handling them. In the table, Teradata Column Type is the type that is stored within the system catalog (e.g. in DBC.ColumnsV)

<!-- TODO  insert table graphics or recreate the table -->
Use the metadata from the Teradata catalog tables to determine whether any of these data types are to be migrated and allow for this in the migration plan. For instance, a SQL query such as the one below can be used to find any occurrences of unsupported data types that need attention.

<!-- TODO this should probably be a code snippet that the user can copy and use -->
![SQL query](../_images/analytics/sql-query.png)

There are third-party vendors who offer tools and services to automate migration including the mapping of data types as described above. Also, if a third-party ETL tool such as Informatica or Talend is already in use in the Teradata environment, these can implement any required data transformations.

### SQL DML syntax differences

There are a few differences in SQL Data Manipulation Language (DML) syntax between Teradata SQL and Azure Synapse to be aware of when migrating:

- QUALIFY – Teradata supports the QUALIFY operator. For example:
...
SELECT col1 FROM tab1 WHERE col1='XYZ'
...

Third-party tools and services can automate data mapping tasks:
...
 QUALIFY ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) = 1; This can be achieved in Azure Synapse by the syntax below: SELECT * FROM  ( SELECT col1, ROW_NUMBER() OVER (PARTITION by col1 ORDER BY col1) rn FROM tab1 WHERE c1='XYZ' ) WHERE rn = 1;
 ...

- Date Arithmetic – Azure Synapse has operators such as:
...
DATEADD and DATEDIFF which can be used on DATE or DATETME fields – Teradata supports direct subtraction on dates such as ‘SELECT DATE1 – DATE2 FROM…’
- LIKE ANY – Teradata supports LIKE ANY syntax such as:
...
SELECT * FROM CUSTOMER WHERE POSTCODE LIKE ANY (‘CV1%’, ‘CV2%’, CV3%’); The equivalent in Azure Synapse syntax is: SELECT * FROM CUSTOMER WHERE (POSTCODE LIKE ‘CV1%’) OR (POSTCODE LIKE ‘CV2%’) OR (POSTCODE LIKE ‘CV3%’);
...
- Depending on system settings, character comparisons in Teradata may be noncase specific by default. In Azure Synapse these comparisons are always case specific.  

### Functions, stored procedures, triggers, and sequences

When migrating from a mature legacy data warehouse environment such as Teradata there are often elements other than simple tables and views that need to be migrated to the new target environment. Examples of this are Functions, Stored Procedures, Triggers, and Sequences.

As part of the preparation phase, an inventory of these objects that are to be migrated should be created and the method of handling them defined, with an appropriate allocation of resources assigned in the project plan.

It may be that there are facilities in the Azure environment that replace the functionality implemented as functions or stored procedures in the Teradata environment; in which case it is generally more efficient to use the built-in Azure facilities rather than recoding the Teradata functions.

<!-- TODO link doesn't work Third-party vendors offer tools and services that can automate the migration, see for examples https://www.ispirer.com/products/teradata-to-azure-sql-data-warehousemigration  -->

For more information on each of these elements:

**Functions**:
In common with most database products, Teradata supports system functions and also user-defined functions within the SQL implementation. When migrating to another database platform such as Azure Synapse, common system functions are generally available and can be migrated without change. Some system functions may have slightly different syntax, but the required changes can be automated in this case.  

For system functions where there is no equivalent, or for arbitrary user-defined functions these may need to be recoded using the language(s) available in the target environment. Azure Synapse uses the popular Transact-SQL language for implementation of user-defined functions.

**Stored procedures**:
Most modern database products allow for procedures to be stored within the database. Teradata’s SPL language is provided for this purpose. A stored procedure typically contains SQL statements and some procedural logic and may return data or a status.

SQL Azure Data Warehouse also supports stored procedures using T-SQL, so if there are stored procedures to be migrated, they must be recoded accordingly.

**Triggers**:
Creation of triggers is not supported within Azure Synapse but can be implemented within Azure Data Factory.

**Sequences**:
Azure Synapse sequences are handled in a similar way to Teradata, i.e. via use of IDENTITY columns or using SQL code to create the next sequence number in a series.

### Extracting metadata and data from a Teradata environment

**Data Definition Language (DDL) generation**:
It is possible to edit existing Teradata CREATE TABLE and CREATE VIEW scripts to create the equivalent definitions (with modified data types if necessary as described above). Typically, this involves removing extra Teradata-specific clauses (e.g. FALLBACK).

However, all the information that specifies the current definitions of tables and views within the existing Teradata environment is maintained within system catalog tables. This is the best source of this information as it is guaranteed to be up to date and complete. (Be aware that user-maintained documentation may not be in sync with the current table definitions.)

This information can be accessed via views onto the catalog such as DBC.ColumnsV and can be used to generate the equivalent CREATE TABLE DDL statements for the equivalent tables in Azure Synapse.  

Third-party migration and ETL tools also use the catalog information to achieve the same result.

**Data extraction from Teradata**:
Migrate the raw data to from existing Teradata tables using standard Teradata utilities such as BTEQ and FASTEXPORT. Generally during a migration exercise, it is important to extract the data as efficiently as possible and the recommended approach for this with recent versions of Teradata is to use Teradata Parallel Transporter, which will use multiple parallel FASTEXPORT streams to achieve the best throughput.

Teradata Parallel Transporter can be called directly from Azure Data Factory and this is the recommended approach for managing the data migration process (this is true whether the Teradata instance in on-premises or copied to a VM within the Azure environment as described above).  
Recommended data formats for the extracted data are delimited text files (also called Comma Separated Values or similar) or Optimized Row Columnar (ORC) or Parquet files.

For more detailed information on the process of migrating data and ETL from a Teradata environment see the associated document Section 2.1. Data Migration ETL and Load from Teradata.

### Performance Recommendations for Teradata Migrations

Differences in performance tuning approach

**Data distribution options**:
Azure enables the specification of data distribution methods for individual tables. The aim is to reduce the amount of data that must be moved between processing nodes when executing a query.  

For large table-large table joins, hash distributing one or both (ideally both) tables on the join columns will ensure that join processing can be performed locally as the data rows to be joined will already be collocated on the same processing node.

Another way to achieve local joins for small table-large table joins (typically dimension table to fact table in a star schema model) is to replicate the smaller dimension table across all nodes, therefore ensuring any value of the join key of the larger table will have a matching dimension row locally available. The overhead of replicating the dimension tables is relatively low, provided the tables are not very large. In this case, the hash distribution approach as described above is more appropriate.

**Data indexing**:
Azure Synapse provides a number of indexing options, but these are different in operation and usage to those implemented in Teradata. More details of the different indexing options are described in <!-- TODO this link doesn't work https://docs.microsoft.com/en-us/azure/sql-datawarehouse/sql-data-warehouse-tables-index-->.  

Existing indexes within the source Teradata environment can however provide a useful indication of how the data is currently used and provide an indication of candidates for indexing within the Azure Synapse environment.

**Data partitioning**:
In an enterprise data warehouse fact tables can contain many billions of rows and partitioning is a way to optimize the maintenance and querying of these tables by splitting them into separate parts to reduce the amount of data processed. The partitioning specification for a table is defined in the CREATE TABLE statement.

Only 1 field per table can be used for partitioning, and this is frequently a date field as many queries will be filtered by date or a date range. Note that it is possible to change the partitioning of a table after initial load if necessary by recreating the table with the new distribution using the CREATE TABLE AS (or CTAS) statement. See <!-- TODO this link doesn't work https://docs.microsoft.com/en-us/azure/sql-data-warehouse/sql-data-warehousetables-partition --> for a detailed discussion of partitioning in Azure Synapse.

**Data table statistics**:
Ensure that statistics on data tables are up to date – this can be achieved by building in a COLLECT STATISTICS step to ETL/ELT jobs, or by enabling automatic statistics collection on the table.

**PolyBase for data loading**:
PolyBase is the most efficient method for loading large amounts of data into the warehouse, as it is able to leverage parallel loading streams

**Use Resource Classes for workload management**:
Azure Synapse uses Resource Classes to manage workloads. In general, large resource classes provide better individual query performance, while smaller resource classes enable higher levels of concurrency. Utilization can be monitored via Dynamic Management Views to ensure that the appropriate resources are being utilized efficiently.

## Next steps

<!-- TODO Can we close on a call to action? Is there a single reference implementation or reference architecture that we can send the reader to, if they want to implement this guidance? -->
