---
title: Schema migration and data definition language (DDL) commands 
description: Learn about design considerations and performance options for data definition language (DDL) commands when you're migrating schemas to Azure Synapse Analytics.
author: v-hanki
ms.author: brblanch
ms.date: 07/14/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Schema migration and DDL commands

This article describes design considerations and performance options for data definition language (DDL) commands when you're migrating schemas to Azure Synapse Analytics.

## Design considerations

Review these design considerations as you plan your schema migration.

### Preparation for migration

When you're preparing to migrate existing data to Azure Synapse Analytics, it's important to clearly define the scope of the exercise (especially for an initial migration project). The time spent up front to understand how database objects and related processes will migrate can reduce both effort and risk later in the project.

Create an inventory of database objects to be migrated. Depending on the source platform, this inventory will include some or all of the following objects:

- Tables
- Views
- Indexes
- Functions
- Stored procedures
- Data distribution and partitioning

The basic information for these objects should include metrics such as row counts, physical size, data compression ratios, and object dependencies. This information should be available via queries against system catalog tables in the source system. The system metadata is the best source for this information. External documentation might be stale and not in sync with changes that have been applied to the data structure since the initial implementation.

You might also be able to analyze actual object usage from query logs or use tooling from Microsoft partners like Attunity Visibility to help. It's possible that some tables don't need to be migrated because they're no longer used in production queries.

Data size and workload information is important for Azure Synapse Analytics because it helps to define appropriate configurations. One example is the required levels of concurrency. Understanding the expected growth of data and workloads might affect a recommended target configuration, and it's a good practice to also harness this information.

When you're using data volumes to estimate the storage required for the new target platform, it's important to understand the data compression ratio, if any, on the source database. Simply taking the amount of storage used on the source system is likely to be a false basis for sizing. Monitoring and metadata information can help you determine uncompressed raw data size and overheads for indexing, data replication, logging, or other processes in the current system.

The uncompressed raw data size of the tables to be migrated is a good starting point for estimating the storage required in the new target Azure Synapse Analytics environment.

The new target platform will also include a compression factor and indexing overhead, but these will probably be different from the source system. Azure Synapse Analytics storage pricing also includes seven days of snapshot backups. When compared to the existing environment, this can have an impact on the overall cost of storage required.

You can delay performance tuning for the data model until late in the migration process and time this with when real data volumes are in the data warehouse. However, we recommend that you implement some performance tuning options earlier on.

For example, in Azure Synapse Analytics, it makes sense to define small dimension tables as replicated tables and to define large fact tables as clustered columnstore indexes. Similarly, indexes defined in the source environment provide a good indication of which columns might benefit from indexing in the new environment. Using this information when you're initially defining the tables before loading will save time later in the process.

It's good practice to measure the compression ratio and index overhead for your own data in Azure Synapse Analytics as the migration project progresses. This measure enables future capacity planning.

It might be possible to simplify your existing data warehouse before migration by reducing complexity to ease migration. This effort might include:

- Removing or archiving unused tables before migrating to avoid migrating data that's not used. Archiving to Azure Blob Storage and defining the data as an external table might keep the data available for a lower cost.
- Converting physical data marts to virtual data marts by using data virtualization software to reduce what you have to migrate. This conversion also improves agility and reduces total cost of ownership. You might consider it as modernization during migration.

One objective of the migration exercise might also be to modernize the warehouse by changing the underlying data model. One example is moving from an Inmon-style data model to a data vault approach. You should decide this as part of the preparation phase and incorporate a strategy for the transition into the migration plan.

The recommended approach in this scenario is to first migrate the data model as is to the new platform and then transition to the new model in Azure Synapse Analytics. Use the platform's scalability and performance characteristics to execute the transformation without affecting the source system.

### Data model migration

Depending on the platform and the origins of the source system, the data model of some or all parts may already be in a star or snowflake schema form. If so, you can directly migrate it to Azure Synapse Analytics as is. This scenario is the easiest and lowest-risk migration to achieve. An as-is migration can also be the first stage of a more complex migration that includes a transition to a new underlying data model such as a data vault, as described earlier.

Any set of relational tables and views can be migrated to Azure Synapse Analytics. For analytical query workloads against a large data set, a star or snowflake data model generally gives the best overall performance. If the source data model is not already in this form, it might be worth using the migration process to reengineer the model.

If the migration project includes any changes to the data model, the best practice is to perform these changes in the new target environment. That is, migrate the existing model first, and then use the power and flexibility of Azure Synapse Analytics to transform the data to the new model. This approach minimizes the impact on the existing system and uses the performance and scalability of Azure Synapse Analytics to make any changes quickly and cost-effectively.

You can migrate the existing system as several layers; for example, the data ingest/staging layer, data warehouse layer, and reporting or data mart layer. Each layer consists of relational tables and views. Although you can migrate these to Azure Synapse Analytics as they are, it might be more cost-effective and reliable to use some of the features and capabilities of the Azure ecosystem. For example:

- **Data ingest and staging:** Instead of using relational tables for fast parallel data loading, you can use Azure Blob storage with PolyBase during part of the ETL (extract, transform, load) or ELT (extract, load, transform) process.

- **Data ingest and staging:** You can use Azure Blob Storage in conjunction with PolyBase for fast parallel data loading for part of the ETL (extract, transform, load) or ELT (extract, load, transform) process, rather than relational tables.
- **Reporting layer and data marts:** The performance characteristics of Azure Synapse Analytics might eliminate the need to physically instantiate aggregated tables for reporting purposes or data marts. It might be possible to implement these as views onto the core data warehouse or via a third-party data virtualization layer. At the basic level, you can achieve the process for data migration of historical data and possibly also incremental updates as shown in this diagram:

   ![Diagram that illustrates a modern data warehouse.](../../../_images/analytics/schema-migration-ddl.png)
    *Figure 1: A modern data warehouse.*

If you can use these or similar approaches, the number of tables to be migrated is reduced. Some processes might be simplified or eliminated, again reducing the migration workload. The applicability of these approaches depends on the individual use case. But, the general principle is to consider using the features and facilities of the Azure ecosystem, where possible, to reduce the migration workload and build a cost-effective target environment. This also holds true for other functions, such as backup/restore and workflow management and monitoring.

Products and services available from Microsoft partners can help with data warehouse migrations and automate parts of the process for some cases. If the existing system incorporates a third-party ETL product, it might already support Azure Synapse Analytics as a target environment. The existing ETL workflows can be redirected to the new target data warehouse.

### Data marts: Physical or virtual

It's a common practice for organizations with older data warehouse environments to create data marts that provide their departments or business functions with good ad hoc self-service query and report performance. A data mart typically consists of a subset of the data warehouse that contains aggregated versions of the original data. Its form, typically a dimensional data model, supports users to easily query the data and receive fast response times from user-friendly tools like Tableau, MicroStrategy, or Microsoft Power BI.

One use of data marts is to expose the data in a usable form, even if the underlying warehouse data model is something different (such as a data vault). This approach is also known as a three-tier model.

You can use separate data marts for individual business units within an organization to implement robust data security regimes. For example, you can allow user access to specific data marts relevant to them and eliminate, obfuscate, or anonymize sensitive data.

If these data marts are implemented as physical tables, they require additional storage resources to house them and additional processing to build and refresh them regularly. Physical tables show that the data in the mart is only as current as the last refresh operation, so they may not be suitable for highly volatile data dashboards.

With the advent of low-cost, scalable massively parallel processing (MPP) architectures, you might be able to provide data mart functionality without needing to instantiate the mart as a set of physical tables. You can achieve this with Azure Synapse Analytics by using one of these methods to virtualize the data marts:

- SQL views on the main data warehouse.
- A virtualization layer that uses features such as views in Azure Synapse Analytics or third-party virtualization products such as Denodo.

This approach simplifies or eliminates the need for additional storage and aggregation processing. It reduces the overall number of database objects to be migrated.

Another benefit of the data warehouse approach is the capacity to run operations such as joins and aggregations on large data volumes. For example, implementing the aggregation and join logic within a virtualization layer and displaying external reporting in a virtualized view push the robust processing required to create these views into the data warehouse.

The primary drivers for choosing to implement physical or virtual data mart implementation are:

- More agility. A virtual data mart is easier to change than physical tables and the associated ETL processes.
- Lower total cost of ownership because of fewer data stores and copies of data in a virtualized implementation.
- Elimination of ETL jobs to migrate and simplified data warehouse architecture in a virtualized environment.
- Performance. Historically, physical data marts have been more reliable. Virtualization products are now implementing intelligent caching techniques to mitigate this.

You can also use data virtualization to display data to users consistently during a migration project.

### Data mapping

#### Key and integrity constraints in Azure Synapse Analytics

Primary key and foreign key constraints aren't currently enforced within Azure Synapse Analytics. However, you can include the definition for `PRIMARY KEY` in the `CREATE TABLE` statement with the `NOT ENFORCED` clause. This means that third-party reporting products can use the metadata for the table to understand the keys within the data model and therefore generate the most efficient queries.

#### Data type support in Azure Synapse Analytics

Some older database systems include support for data types that aren't directly supported within Azure Synapse Analytics. You can handle these data types by using a supported data type to store the data as is or by transforming the data to a supported data type.

Here's an alphabetical list of supported data types:

- `bigint`
- `binary [ (n) ]`
- `bit`
- `char [ (n) ]`
- `date`
- `datetime`
- `datetime2 [ (n) ]`
- `datetimeoffset [ (n) ]`
- `decimal [ (precision [, scale ]) ]`
- `float [ (n) ]`
- `int`
- `money`
- `nchar [ (n) ]`
- `numeric [ (precision [ , scale ]) ]`
- `nvarchar [ (n | MAX) ]`
- `real [ (n) ]`
- `smalldatetime`
- `smallint`
- `smallmoney`
- `time [ (n) ]`
- `tinyint`
- `uniqueidentifier`
- `varbinary [ (n | MAX) ]`
- `varchar [ (n | MAX) ]`

The following table lists common data types that aren't currently supported, together with the recommended approach for storing them in Azure Synapse Analytics.

| Unsupported data type | Workaround |
|--|--|
| `geometry` | `varbinary` |
| `geography` | `varbinary` |
| `hierarchyid` | `nvarchar(4000)` |
| `image` | `varbinary` |
| `text` | `varchar` |
| `ntext` | `nvarchar` |
| `sql_variant` | Split column into several strongly typed columns |
| `table` | Convert to temporary tables |
| `timestamp` | Rework code to use `datetime2` and the `CURRENT_TIMESTAMP` function |
| `xml` | `varchar` |
| User-defined type | Convert back to the native data type when possible |

#### Potential data issues

Depending on the source environment, some issues can cause problems when you're migrating data:

- There can be subtle differences in the way that `NULL` data is handled in different database products. Examples include collation sequence and handling of empty character strings.
- `DATE`, `TIME`, `INTERVAL`, and `TIME ZONE` data and associated functions can vary widely from product to product.

Test these thoroughly to determine whether the desired results are achieved in the target environment. The migration exercise can uncover bugs or incorrect results that are currently part of the existing source system, and the migration process is a good opportunity to correct anomalies.

#### Best practices for defining columns in Azure Synapse Analytics

It's common for older systems to contain columns with inefficient data types. For example, you might find a field defined as `VARCHAR(20)` when the actual data values would fit into a `CHAR(5)` field. Or, you might find the use of `INTEGER` fields when all values would fit within a `SMALLINT` field. Insufficient data types can lead to inefficiencies in both storage and query performance, especially in large fact tables.

It's a good time to check and rationalize current data definitions during a migration exercise. You can automate these tasks by using SQL queries to find the maximum numeric value or character length within a data field and comparing the result to the data type.

In general, it's a good practice to minimize the total defined row length for a table. For the best query performance, you can use the smallest data type for each column, as described earlier. The recommended approach to load data from external tables in Azure Synapse Analytics is to use the PolyBase utility, which supports a maximum defined row length of 1 megabyte (MB). PolyBase won't load tables with rows longer than 1 MB, and you must use the [`bcp` utility](/sql/tools/bcp-utility) instead.

For the most efficient join execution, define the columns on both sides of the join as the same data type. If the key of a dimension table is defined as `SMALLINT`, then the corresponding reference columns in fact tables using that dimension should also be defined as `SMALLINT`.

Avoid defining character fields with a large default size. If the maximum size of data within a field is 50 characters, use `VARCHAR(50)`. Similarly, don't use `NVARCHAR` if `VARCHAR` will suffice. `NVARCHAR` stores Unicode data to allow for different language character sets. `VARCHAR` stores ASCII data and takes less space.

## Summary of design recommendations

Don't migrate unnecessary objects or processes. Use built-in features and functions in the target Azure environment where appropriate to reduce the actual number of objects and processes to migrate. Consider using a virtualization layer to reduce or eliminate the number of physical data marts that you'll migrate and to push down processing into the data warehouse.

Automate wherever possible, and use metadata from system catalogs in the source system to generate DDL commands for the target environment. If possible, also automate generating documents. Microsoft partners such as WhereScape can provide specialized tools and services to assist with automation.

Perform any required data model changes or data-mapping optimizations on the target platform. You can make these changes more efficiently in Azure Synapse Analytics. This approach reduces the impact on source systems that might already be running close to full capacity.

## Performance options

This section describes the features available within Azure Synapse Analytics that you can use to improve performance for a data model.

### General approach

The platform's features run performance tuning on the database that will be migrated. Indexes, data partitioning, and data distribution are examples of such performance tuning. When you're preparing for migration, documenting the tuning can capture and reveal optimizations that you can apply in the Azure Synapse Analytics target environment.

For example, the presence of a non-unique index on a table can indicate that fields used in the index are used frequently for filtering, grouping, or joining. This will still be the case in the new environment, so keep it in mind when you're choosing which fields to index there. For more detailed information about Teradata or Netezza environments, see the Azure Synapse Analytics articles about [solutions and migration for Teradata](./analytics-solutions-teradata.md) and [solutions and migration for Netezza](./analytics-solutions-netezza.md).

Use the performance and scalability of the target Azure Synapse Analytics environment to experiment with different performance options like data distribution. Determine the best choice of alternative approaches (for example, replicated versus hash-distributed for a large dimension table). This doesn't mean that data must be reloaded from external sources. It's relatively quick and easy to test alternative approaches in Azure Synapse Analytics by creating copies of any table with different partitioning or distribution options via a `CREATE TABLE AS SELECT` statement.

Use the monitoring tools provided by the Azure environment to understand how queries are executed and where bottlenecks might be occurring. Tools are also available from third-party Microsoft partners to provide monitoring dashboards and automated resource management and alerting.

Each SQL operation in Azure Synapse Analytics and resource, such as memory or the CPU used by that query, is logged into system tables. A series of dynamic management views simplifies access to this information.

The following sections explain the key options within Azure SQL Data Warehouse for tuning query performance. Existing environments will contain information about potential optimization in the target environment.

### Temporary tables

Azure Synapse Analytics supports temporary tables that are visible only to the session in which they were created. They exist for the duration of a user session and are automatically dropped at the end of the session.

To create a temporary table, prefix the table name with the hash character (`#`). You can use all the usual indexing and distribution options with temporary tables, as described in the next section.

Temporary tables have some restrictions:

- Renaming them isn't allowed.
- Viewing or partitioning them isn't allowed.
- Changing permissions isn't allowed.

Temporary tables are commonly used within ETL/ELT processing, where transient intermediate results are used as part of a transformation process.

### Table distribution options

Azure Synapse Analytics is an MPP database system that achieves performance and scalability by running in parallel across multiple processing nodes.

The ideal processing scenario for running an SQL query in a multi-node environment is to balance the workload and give all nodes an equal amount of data to process. This approach also allows you to minimize or eliminate the amount of data that has to be moved between nodes to satisfy the query.

It can be challenging to achieve the ideal scenario because there are often aggregations in typical analytics queries and multiple joins between several tables, as between fact and dimension tables.

One way to influence how queries are processed is to use the distribution options within Azure Synapse Analytics to specify where each table's individual data rows are stored. For example, assume that two large tables are joined on the data column, `CUSTOMER_ID`. By distributing the two tables through the `CUSTOMER_ID` columns whenever that join is performed, you can ensure that the data from each side of the join will already be co-located on the same processing node. This method eliminates the need to move data between nodes. The distribution specification for a table is defined in the `CREATE TABLE` statement.

The following sections describe the available distribution options and recommendations for when to use them. It's possible to change the distribution of a table after the initial load, if necessary: re-create the table with the new distribution by using the `CREATE TABLE AS SELECT` statement.

#### Round robin

Round-robin table distribution is the default option and spreads the data evenly across the nodes in the system. This method is good for fast data loading and for data that's relatively low in volume and doesn't have an obvious candidate for hashing. It's frequently used for staging tables as part of an ETL or ELT process.

#### Hashed

The system assigns the row to a hash bucket, a task based on a hashing algorithm applied to a user-defined key like `CUSTOMER_ID` in the preceding example. The bucket is then assigned to a specific node, and all data rows hash-distributed on the same value end up on the same processing node.

This method is useful for large tables that are frequently joined or aggregated on a key. Other large tables to be joined should be hashed on the same key if possible. If there are multiple candidates for the hash key, choose the most frequently joined one.

The hash column shouldn't contain nulls and isn't typically a date because many queries filter on date. Hashing is typically more efficient if the key to hash is an integer value instead `CHAR` or `VARCHAR`. Avoid choosing keys with a highly skewed range of values, like when a small number of key values represent a large percentage of the data rows.

#### Replicated

Choosing replicated as the distribution option for a table will cause a complete copy of that table to be replicated on each compute node for query processing purposes.

This approach is useful for relatively small tables (typically less than 2 GB compressed) that are relatively static and frequently joined to larger tables via an equi-join. These tables are often dimensional tables in a star schema.

### Indexing

Azure Synapse Analytics includes options for indexing data in large tables to reduce the resources and time required to retrieve records:

- Clustered columnstore index
- Clustered index
- Non-clustered index

A non-indexed option, `HEAP`, exists for tables that don't benefit from any of the index options. Using indexes is a trade-off between improved query times versus longer load times and usage of more storage space. Indexes often speed up `SELECT`, `UPDATE`, `DELETE`, and `MERGE` operations on large tables that affect a small percentage of the data rows, and they can minimize full table scans.

Indexes are automatically created when `UNIQUE` or `PRIMARY KEY` constraints are defined on columns.

#### Clustered columnstore index

Clustered columnstore index is the default indexing option within Azure Synapse Analytics. It provides the best compression and query performance for large tables. For smaller tables of fewer than 60 million rows, these indexes aren't efficient, so you should use the `HEAP` option. Similarly, a heap or a temporary table might be more efficient if the data in a table is transient and part of an ETL/ELT process.

#### Clustered index

If there's a requirement to regularly retrieve a single row or small number of rows from a large table based on a strong filter condition, a clustered index might be more efficient than a clustered columnstore index. Only one clustered index is allowed per table.

#### Non-clustered index

Non-clustered indexes are similar to clustered indexes in that they can speed up retrieval of single rows or a small number of rows based on a filter condition. Internally, non-clustered indexes are stored separately from the data, and multiple non-clustered indexes can be defined on a table. However, each additional index will require more storage and will reduce the throughput of data insert or loading.

#### Heap

Heap tables incur none of the overhead associated with the creation and maintenance of indexes at data load time. They can help to quickly load transient data during processes, including ELT processes. Caching can also assist when the data is read immediately afterward. Because clustered columnstore indexes are inefficient below 60 million rows, heap tables can also help to store tables with rows less than this amount.

### Data partitioning

In an enterprise data warehouse, fact tables can contain many billions of rows. Partitioning is a way to optimize the maintenance and querying of these tables by splitting them into separate parts to reduce the amount of data processed when running queries. The partitioning specification for a table is defined in the `CREATE TABLE` statement.

You can use only one field per table for partitioning. It's frequently a date field because many queries are filtered by a date or date range. You can change the partitioning of a table after initial load, if necessary, by re-creating the table with the new distribution through the `CREATE TABLE AS SELECT` statement.

**Partitioning for query optimization:** If queries against a large fact table are frequently filtered by a certain data column, then partitioning on that column can significantly reduce the amount of data that needs to be processed to perform the queries. A common example is to use a date field to split the table into smaller groups. Each group contains data for a single day. When a query contains a `WHERE` clause that filters on the date, only partitions that match the date filter need to be accessed.

**Partitioning for optimization of table maintenance:** It's common for data warehouse environments to maintain a rolling window of detailed fact data. An example is sales transactions that go back five years. By partitioning on the sales date, the removal of old data beyond the rolling window becomes much more efficient. Dropping the oldest partition is quicker and uses fewer resources than deleting each individual row.

### Statistics

When a query is submitted to Azure Synapse Analytics, it's first processed by the query optimizer. The optimizer determines the best internal methods to execute the query efficiently.

The optimizer compares the various query-execution plans that are available based on a cost-based algorithm. The accuracy of the cost estimates is dependent on the statistics available. It's a good practice to ensure that statistics are up to date.

In Azure Synapse Analytics, if the `AUTO_CREATE_STATISTICS` option is turned on, it will trigger an automatic update of statistics. You can also create or update statistics manually via the `CREATE STATISTICS` command.

Refresh statistics when the contents have changed substantially, such as in a daily update. This refresh can be incorporated into an ETL process.

All tables in the database should have statistics collected on at least one column. It ensures that basic information such as row count and table size is available to the optimizer. Other columns that should have statistics collected are columns specified in `JOIN`, `DISTINCT`, `ORDER BY`, and `GROUP BY` processing.

### Workload management

Azure Synapse Analytics incorporates comprehensive features for managing resource utilization across mixed workloads. Creating resource classes for different workload types, such as queries versus data load, helps you manage your workload. It sets limits on the number of queries that run concurrently and on the compute resources assigned to each query. There's a trade-off between memory and concurrency:

- Smaller resource classes reduce the maximum memory per query but increase concurrency.
- Larger resource classes increase the maximum memory per query but reduce concurrency.

### Performance recommendations

Use performance improvement methods like indexes or data distribution to gauge candidates for similar methods in the new target environment, but benchmark to confirm that they're necessary in Azure Synapse Analytics. Build `COLLECT STATISTICS` steps into ETL/ELT processes to ensure that statistics are up to date, or select to automatically create statistics.

Understand the tuning options available in Azure Synapse Analytics and the performance characteristics of associated utilities, such as PolyBase for fast parallel data loading. Use these options to build an efficient end-to-end implementation.

Use the flexibility, scalability, and performance of the Azure environment to implement any data model changes or performance tuning options in place. This effort will reduce the impact on existing source systems.

Understand the dynamic management views available in Azure Synapse Analytics. These views provide both system-wide resource utilization information and detailed execution information for individual queries.

Understand Azure resource classes and allocate them appropriately to ensure efficient management of mixed workloads and concurrency.

Consider using a virtualization layer as part of the Azure Synapse Analytics environment. It can shield changes in the warehouse implementation from business users and reporting tools.

Research partner-provided migration tools and services such as Qlik Replicate for Microsoft migrations, WhereScape, and Datometry. These services can automate parts of the migration process and reduce the elapsed time and risk involved in a migration project.
