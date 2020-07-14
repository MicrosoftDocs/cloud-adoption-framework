---
title: "Schema Migration Data Definition Languages (DDL)"
description: Use Azure Synapse features to address high availability and disaster recovery requirements.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Schema Migration Data Definition Languages (DDL)

## Design considerations

### Preparation for migration

When preparing to migrate existing data to Azure Synapse, it is important to clearly define the scope of the exercise (especially for an initial migration project). Time spent up front in understanding the database objects and associated processes to be migrated will pay dividends in reducing effort and risk later in the project.

An inventory of database objects to be migrated should be created. Depending on the source platform, this will generally include some or all of the following:

- Tables
- Views
- Indexes
- Functions
- Stored procedures
- Data distribution and partitioning

The basic information for these objects (including metrics such as row counts, physical size, data compression ratios, and object dependencies) should be available via queries against system catalog tables in the source system. The system metadata is the best source for this important information. External documentation may be out of date and not in sync with changes that have been applied to the data structure since the initial implementation.

It may also be possible to analyze actual object usage from query logs or use tooling from Microsoft partners to help, for example, Attunity Visibility. It might be that some tables don't need to be migrated as they are no longer used in production queries.

Data sizing and workload information (for example, levels of concurrency required) is important as this is used to define an appropriate configuration for the Azure Synapse. It is also good practice to understand the expected data and workload future growth as this may also impact the recommended target configuration.

When using data volumes to estimate the storage required for the new target platform, it is important to understand the data compression ratio (if any) on the source database. Simply taking the amount of storage used on the source system is likely to be a false basis for sizing. It should be possible from monitoring and metadata information to determine uncompressed raw data size, as well as any overheads for indexing, data replication, logging etc. in the current system.  

The uncompressed raw data size of the tables to be migrated is a good starting point for estimating the storage required in the new target Azure Synapse environment.

There will also be a compression factor as well as indexing overhead in the new target platform, but these will probably be different to the source system. the Azure Synapse storage pricing also includes seven days of snapshot backups. This can have an impact on the overall cost of storage required compared to the existing environment.

The data model performance tuning process can be left until late in the migration process so that it takes place when there are real data volumes within the data warehouse. But it is recommended that some performance tuning options can be implemented earlier in the process. For example, in Azure Synapse it generally makes sense to define small dimension tables as replicated tables and to define large fact tables as clustered columnstore indexes. Similarly, indexes defined in the source environment provide a good indication of which columns might benefit from indexing in the new environment. Using this information when initially defining the tables prior to loading will save time later in the process.

It is good practice to measure the compression ratio and index overhead for your own data in Azure Synapse as the migration project progresses, this will provide a sound basis for future capacity planning.

It may be possible to simply your existing data warehouse prior to migration by about reducing complexity to ease migration. It could include:

- Removing or archiving unused tables before migrating to avoid migrating data that is not used. Archiving to Azure Blob Storage and defining the data as an external table could keep the data available but at lower cost
- Converting physical data marts to virtual data marts using data virtualization software to reduce what you have to migrate. This would also improve agility and reduce total cost of ownership and so could be considered as modernization during migration.

One objective of the migration exercise may also be to modernize the warehouse by changing the underlying data model, for example, moving from an Inmon style data model to a Data Vault approach. This should be decided as part of the preparation phase and a strategy for the transition should be incorporated into the migration plan. The recommended approach in this scenario is to first migrate the data model as is to the new platform and then do the transition to the new model in Azure Synapse, leveraging the scalability and performance characteristics of the platform to execute the transformation with no impact on the source system.

### Data Model Migration

Depending on the platform and the origins of the source system, the data model of some or all parts may already be in a star or snowflake schema form. If so, this can be directly migrated to Azure Synapse as is. This scenario is the easiest and lowest risk migration to achieve. An as-is migration could also be the first stage of a more.

Data Model Migration Depending on the platform and the origins of the source system, the data model of some or all parts may already be in a star or snowflake schema form. If so, this can be directly migrated to Azure Synapse as is. This scenario is the easiest and lowest risk migration to achieve. An as-is migration could also be the first stage of a more complex migration which includes a transition to a new underlying data model such as Data Vault as described above.

While any set of relational tables and views can be migrated to Azure Synapse, for analytical query workloads against a large data set, a star or snowflake data model generally gives the best overall performance. If the source data model is not already in this form, it may be worth using the migration process to re-engineer the model.

If any changes to the data model are done as part of the migration project, the best practice is to perform these changes in the new target environment, that is, migrate the existing model first, then use the power and flexibility of Azure Synapse to transform the data to the new model there. This approach minimizes the impact on the existing system and leverages the performance and scalability of Azure Synapse to make any changes quickly and cost-effectively.

The existing system to be migrated may be implemented as several layers (for example, data ingest/staging layer, data warehouse layer and reporting or data marts layer) each of which consist of a number of relational tables and views. While these could all be migrated to Azure Synapse as-is, it might be more cost-effective and performant to leverage some of the features and capabilities of the Azure ecosystem rather than migrating everything directly. For example:

- Data ingest and staging – Azure blob storage in conjunction with PolyBase for fast parallel data loading could be used for part of the ETL/ELT process rather than relational tables
- Reporting layer and data marts – the performance characteristics of Azure Synapse may eliminate the need to physically instantiate aggregated tables for reporting purposes or data marts. It may be possible to implement these as views onto the core data warehouse or via a third-party data virtualization layer. At the basic level, the process for data migration of historical data and possibly also incremental updates can be achieved as shown below:

![Modern data warehouse](../../../_images/analytics/schema-migration-ddl.png)

If these approaches (or similar) can be used the number of tables to be migrated will be reduced and also some processes may be simplified or eliminated, again reducing the migration workload. The applicability of these approaches is dependent on the individual use case, but the general principle is to consider leveraging the features and facilities of the Azure ecosystem where possible to reduce the migration workload and build a cost-effective target environment. This also holds true for other functions such as backup/restore and workflow management and monitoring.

There are also products and services available from Microsoft Partners to assist in data warehouse migration and in some cases automate parts of the process. If the existing system incorporates a third-party ETL product, it may be that this already supports Azure Synapse as a target environment and the existing ETL workflows could be redirected to the new target SQL Data Warehouse.

### Data marts: physical or virtual

In legacy data warehouse environments, it is common practice to create a number of data marts that are structured to provide good performance for ad hoc self-service queries and reports for a given department or business function within an organization. As such, a data mart typically consists of a subset of the data warehouse containing aggregated versions of the data in a form that enables users to easily query that data with fast response times via user-friendly query tools such as Tableau, MicroStrategy, or Microsoft Power BI. This form is generally a dimensional data model, and one use of data marts is to expose the data in a usable form even if the underlying warehouse data model is something different (for example, data vault). This approach is also known as a three-tier model.

Separate data marts for individual business units within an organization can also be used to implement robust data security regimes, by only allowing user access to specific data marts relevant to them and eliminating, obfuscating, or anonymizing sensitive data.

If these data marts are implemented as physical tables, they required additional storage resources to store them and also additional processing to build and refresh them on a regular basis. It also implies that the data in the mart is only as up to date as the last refresh operation, so may not be suitable for highly volatile data dashboards.  

With the advent of relatively cheap scalable massively parallel processing (MPP) architectures such as Azure Synapse and their inherent performance characteristics, it may be that data mart functionality can be provided without having to instantiate the mart as a set of physical tables. This is achieved by effectively virtualizing the data marts via SQL views on to the main data warehouse or via a virtualization layer using features such as views in Azure Synapse or third-party virtualization products such as Denodo. This approach simplifies or eliminates the need for additional storage and aggregation processing, and reduces the overall number of database objects to be migrated.  

There is also another potential benefit of this approach. By implementing the aggregation and join logic within a virtualization layer and presenting external reporting tools via a virtualized view, the processing required to create these views is pushed down into the data warehouse, which is generally the best place to run operations such as joins and aggregations on large data volumes.  

The primary drivers for choosing to implement physical or virtual data mart implementation are:

- more agility as a virtual data mart is easier to change than physical tables and the associated ETL processes
- lower total cost of ownership because of fewer data stores and copies of data in a virtualized implementation
- elimination of ETL jobs to migrate and simplified DW architecture in a virtualized environment
- performance: historically physical data marts have been more performant though virtualization products are now implementing intelligent caching techniques to mitigate this  

Data virtualization can also be used to provide end users with a consistent view of data while a migration project takes place.

### Data mapping

**Key and integrity constraints in Azure Synapse**:

Primary key and foreign key constraints are not currently enforced within Azure Synapse, however the definition for PRIMARY KEY can be included in the CREATE TABLE statement with the NOT ENFORCED clause. This means that third-party reporting products can use the metadata for the table to understand the keys within the data model and therefore generate the most efficient queries.

**Data type support in Azure Synapse**:

Some legacy database systems include support for data types that are not currently directly supported within Azure Synapse. However, these data types can generally be handled either by using a supported data type to store the data as is, or by transforming the data to a supported data type.

An alphabetic list of supported data types is shown below:

- bigint  
- binary [ ( n ) ]  
- bit  
- char [ ( n ) ]  
- date  
- datetime  
- datetime2 [ ( n ) ]  
- datetimeoffset [ ( n ) ]  
- decimal [ ( precision [ , scale ] ) ]  
- float [ ( n ) ]  
- int  
- money  
- nchar [ ( n ) ]  
- numeric [ ( precision [ , scale ] ) ]  
- nvarchar [ ( n | max ) ]  
- real [ ( n ) ]  
- smalldatetime  
- smallint  
- smallmoney  
- time [ ( n ) ]  
- tinyint  
- uniqueidentifier  
- varbinary [ ( n | max ) ]  
- varchar [ ( n | max ) ]  

The table below lists some common data types that are not currently supported together with the recommended approach for storing these in Azure Synapse. (For specific environments, for example, Teradata or Netezza, see the associated documents for more detailed information.)

| **Unsupported data type** | **Workaround**                                                      |
|-----------------------|-----------------------------------------------------------------|
| geometry              | varbinary                                                       |
| geography             | varbinary                                                       |
| hierarchyid           | nvarchar(4000)                                                  |
| image                 | varbinary                                                       |
| text                  | varchar                                                         |
| ntext                 | nvarchar                                                        |
| sql_variant           | Split column into several strongly typed columns                |
| table                 | Convert to temporary tables                                     |
| timestamp             | Rework code to use datetime2 and the CURRENT_TIMESTAMP function |
| xml                   | varchar                                                         |
| user-defined type     | Convert back to the native data type when possible              |

**Potential data issues**:

Depending on the source environment, there are some issues that can cause problems when migrating data:

- Handling of NULL data – there can be subtle differences in the way that NULL data is handled in different database products, for example, collation sequence, handling of empty character string
- DATE, TIME, INTERVAL, TIME ZONE data and associated functions – these can vary wildly from product to product

Recommendation: test these thoroughly to ensure that the desired results are achieved in the target environment. The migration exercise can also uncover bugs or incorrect results that are currently part of the existing source system. The migration process is a good opportunity to correct any anomalies. Best practices for defining columns in Azure Synapse It is common in legacy systems to find columns specified with inefficient data types, for example, a field defined as VARCHAR(20) when the actual data values would fit into a CHAR(5) field, or using INTEGER fields when all values will fit within a SMALLINT field. This can lead to inefficiencies in both storage and query performance, especially in large fact tables.  

A migration exercise can be a good time to check existing data definitions and rationalize data definitions. This can be automated by using SQL queries to find the maximum numeric value or the maximum character length within a data field and comparing that to the data type. Some third-party data exploration or migration tools also incorporate this feature.

In general, it is good practice to minimize the total defined row length for a table (for example, by using the smallest data type for each column as described above) as this will give the best query performance. The PolyBase utility, which is the recommended method of data loading from external tables for Azure Synapse, supports a maximum defined row length of 1 MB. For rows greater than 1MB in length PolyBase cannot be used to load that table, BCP must be used instead.

For the most efficient join execution, define the columns used on both sides of the join as the same data type. If the key of a dimension table is defined as SMALLINT, then the corresponding reference columns in the FACT table(s) that use that dimension should also be defined as SMALLINT.

Avoid defining character fields with a large default size. If the maximum size of data within a field is 50 characters, use VARCHAR(50). Similarly, don’t used NVARCHAR if VARCHAR will suffice. NVARCHAR stores UNICODE data (allowing for different language character sets whereas VARCHAR stores ASCII data and takes less space.

## Design recommendations summary

Don’t migrate unnecessary objects or processes. Use built-in features and functions in the target Azure environment where appropriate to reduce the actual number of objects and processes to migrate. Consider using a virtualization layer to reduce or eliminate the number of physical data marts to migrate and to push down processing into the data warehouse.

Automate wherever possible. Use metadata from system catalogs in the source system to generate DDL for the target environment. If possible, automate the generation of documentation as well. Microsoft partners such as Wherescape can provide specialized tools and services to assist with this.

Perform any required data model changes or data mapping optimizations on the target platform. These changes can be done more efficiently in Azure Synapse. This approach reduces the impact on source systems that might already be running close to full capacity.

## Performance options

This section describes the features available within Azure Synapse that can be used to improve performance for a given data model.  

### General approach

The database to be migrated will already have had performance tuning applied using the features available on that platform, for example, indexes, data partitioning and possibly data distribution. As part of the preparation for migration these should be documented as this can be a good indication of optimizations that can be applied in the Azure Synapse target environment.

For example, the presence of a non-unique index on a table can indicate that field(s) used in the index are used frequently for filtering, grouping or joining. This will still be the case in the new environment and so this should be borne in mind when choosing which fields to index there. Migration recommendations for specific source platforms such as Teradata and Netezza are described in detail in separate documents.

Use the performance and scalability of the target Azure Synapse environment to experiment with different performance options such as data distribution to determine the best choice from alternative approaches (for example, replicated vs has distributed for a large dimension table). This doesn’t mean that data has to be reloaded from external sources. It is relatively quick and easy to test alternative approaches in Azure Synapse by creating copies of any table with different partitioning or distribution options via a CREATE TABLE AS (CTAS) statement.

Make use of the monitoring tools provided by the Azure environment to understand how queries are executed and where bottlenecks may be occurring. There are also tools available from third-party Microsoft partners that provide monitoring dashboards and automated resource management and alerting.

Each SQL operation in Azure Synapse together with the resources used by that query (memory, CPU etc.) is logged into system tables and a series of dynamic management views (DMVs) are provided to simplify access to this information.

The following sections explain the key options within Azure Data Warehouse for tuning query performance. Existing environments will contain information about potential optimization in the target environment.

### Temporary tables

Azure Synapse supports temporary tables, which are only visible to the session in which they were created, exist for the duration of a user session, and are automatically dropped at the end of the session.

To create a temporary table, prefix the table name with the hash character (#). All the usual indexing and distribution options can be used with temporary tables (see below).

Temporary tables have some restrictions:

- Renaming the table is not allowed
- Views and partitions on temporary tables are not allowed
- Permissions on temporary tables can’t be changed

Temporary tables are commonly used within ETL/ELT processing where transient intermediate results are used as part of a transformation process.

### Table distribution options

Azure Synapse is a massively parallel processing (MPP) database system that achieves performance and scalability by running in parallel across multiple processing nodes.

The ideal processing scenario when running a SQL query in a multi-node environment is to balance the workload so that all the nodes have an equal amount of data to process while at the same time minimizing (or eliminating completely) the amount of data that has to be moved between nodes to satisfy the query.

In typical analytics queries there are frequently multiple joins between several tables (for example, between fact tables and dimension tables) as well as aggregations and therefore it can be difficult to achieve the ideal scenario.

One way to influence the processing of queries is to use the distribution options within Azure Synapse to specify where individual data rows of each table are stored. For example, if two large tables are frequently joined on a given data column such as CUSTOMER_ID, by distributing the two tables using the CUSTOMER_ID columns whenever that join is performed the data from each side of the join will already be colocated on the same processing node, eliminating the need to move data between nodes. The distribution specification for a table is defined in the CREATE TABLE statement.

The distribution options available and recommendations of when to use them are described below. It is possible to change the distribution of a table after initial load, if necessary, by recreating the table with the new distribution using the CREATE TABLE AS (or CTAS) statement.

**Round robin**:

This is the default table distribution and is designed to spread the data evenly across the nodes within the system. This method is good for fast data loading and for data that is relatively low volume and doesn’t have an obvious candidate for hashing, so is frequently used for staging tables as part of an ETL or ELT process.

**Hashed**:

Based on a hashing algorithm applied to a user-defined key (for example, CUSTOMER_ID in the example above), the system assigns the row to a hash bucket, which in turn is assigned to a specific node. All data rows hash distributed on the same value will therefore end up on the same processing node.

This method is useful for large tables that are frequently joined or aggregated on a given key. Other large tables to be joined should also be hashed on the same key if possible. If there are multiple candidates for the hash key, choose the most frequently joined one. The hash column should not contain NULLs and typically is not a date (as many queries filter on date). Hashing is generally more efficient if the key to be hashed is an integer value—not CHAR or VARCHAR. Also, avoid choosing keys that have a highly skewed range of values, such as a small number of key values that represent a high percentage of the data rows.

**Replicated**:

Choosing replicated as the distribution option for a table will cause a complete copy of that table to be replicated on each compute node for query processing purposes.

This approach is useful for relatively small tables (typically less than 2 GB compressed) that are relatively static and frequently joined to larger tables via an equi-join, these are often dimensional tables in a star schema.

### Indexing

Azure Synapse includes several options for indexing data in large tables to reduce the resources and time required to retrieve records:

- Clustered columnstore index
- Clustered index
- Non-clustered index

There is also a non-indexed option called HEAP for tables that wouldn't benefit from any of the index options. The use of indexes generally is a tradeoff between improved query times versus longer load times and more storage space usage. In general, indexes can speed up SELECT, UPDATE, DELETE and MERGE operations on large tables where only a small proportion of the data rows are affected, and the indexes can be used to avoid full table scans.

Indexes are automatically created when UNIQUE or PRIMARY KEY constraints are defined on columns.  

**Clustered columnstore index**:

This is the default indexing option within Azure Synapse and provides the best compression and query performance for large tables. For smaller tables (less than 60 million rows) these indexes are not efficient and so the heap option should be used. Similarly, if the data in a table is transient (perhaps part of an ETL/ELT process) heap or a temporary table may be more efficient.

**Clustered index**:

If there is a requirement to regularly retrieve a single row or small number of rows from a large table based on a strong filter condition a clustered index may be more efficient than a clustered columnstore index. Only one clustered index is allowed per table.
Replication

**Non-clustered index**:

Non-clustered indexes are similar to clustered indexes in that they can speed up retrieval of single rows or a small number of rows based on a filter condition. Internally non-clustered indexes are stored separately from the data and multiple non-clustered indexes can be defined on a table. However, each additional index will require more storage and will reduce the throughput of data insert or loading.

**Heap**:

Heap tables incur none of the overhead associated with the creation and maintenance of indexes at data load time and therefore can be useful for quickly loading transient data (for example, as part of an ETL process). Reads of the data that follow immediately may also benefit from caching in this case. Heap tables can also be useful for storing tables of less than 60 million rows as clustered columnstores are inefficient below that size.

### Data partitioning

In an enterprise data warehouse fact tables can contain many billions of rows and partitioning is a way to optimize the maintenance and querying of these tables by splitting them into separate parts to reduce the amount of data processed when running queries. The partitioning specification for a table is defined in the CREATE TABLE statement.

Only one field per table can be used for partitioning, and this is frequently a date field as many queries will be filtered by date or a date range. Note that it is possible to change the partitioning of a table after initial load if necessary by recreating the table with the new distribution using the CREATE TABLE AS (or CTAS) statement.

**Partitioning for query optimization**:

If queries against a large fact table are frequently filtered by a certain data column, then partitioning on that column can significantly reduce the amount of data that needs to be processed to perform the queries. A common example is to use a date field to split the table into smaller groups each containing data for a single day. When a query contains a WHERE clause which filters on the date, only those partitions that match the date filter need to be accessed.  

**Partitioning for table maintenance optimization**:

It is common in data warehouse environments to maintain a rolling window of detailed fact data, for example, sales transactions going back for five years. By partitioning on the sales date the removal of old data beyond the rolling window becomes much more efficient. Dropping the oldest partition is quicker and use fewer resources than DELETEs of all of the individual rows.

### Statistics

When a query is submitted to Azure Synapse it is first processed by the query optimizer which determines the best internal methods to use to execute the query efficiently. The optimizer compares the various query execution plans available based on a cost-based algorithm, and the accuracy of the cost estimates is dependent on the statistics available. It is therefore good practice to ensure that statistics are up to date.

In Azure Synapse if the AUTO_CREATE_STATISTICS option is turned on this will trigger automatic update of statistics. Statistics can also be created or updated manually via the CREATE STATISTICS command.

It is good practice to refresh statistics when there has been substantial change in the contents (for example, a daily update), this can be incorporated into ETL process.

All tables in the database should have statistics collected on at least one column (to ensure that basic information such as row count and table size is available to the optimizer). Other columns that should have statistics collected are those that are specified in JOIN, DISTINCT, ORDER BY and GROUP BY processing.

### Workload management

Azure Synapse incorporates comprehensive features for managing resource utilization across mixed workloads. This can be achieved by creating resource classes for different workload types (for example, queries vs data load). Resource classes can help you manage your workload by setting limits on the number of queries that run concurrently and on the compute resources assigned to each query. There's a trade-off between memory and concurrency.

- Smaller resource classes reduce the maximum memory per query, but increase concurrency.
- Larger resource classes increase the maximum memory per query, but reduce concurrency

### Performance recommendations

Use any performance improvement methods (for example, indexes, data distribution) as indications of candidates to similar measures in the new target environment, but benchmark to confirm that they are necessary in Azure Synapse. Build COLLECT STATISTICS steps into ETL/ELT processes to ensure statistics are up to date, or turn on automatic statistics creation.

Understand the tuning options available within Azure Synapse and also the performance characteristics of associated utilities (for example, PolyBase for fast parallel data loading) and use these as appropriate to build an efficient end to end implementation.

Use the flexibility, scalability, and performance of the Azure environment to implement any data model changes or performance tuning options in-situ to reduce the impact on existing source systems.

Understand the dynamic management views available in Azure Synapse to provide both system-wide resource utilization information and detailed execution information for individual queries.

Understand Azure resource classes and allocate these as appropriate for efficient management of mixed workloads and concurrency.

Consider using a virtualization layer as part of the Azure Synapse environment to shield changes in the warehouse implementation from business users and reporting tools.

Research migration tools and services provided by third-party providers, for example, Attunity Replicate for Microsoft Migrations, Wherescape, Datometry. These can automate parts of the migration process and reduce the elapsed time and risk involved in a migration project.
