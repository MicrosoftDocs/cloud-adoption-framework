---
title: "Analytics solutions for Netezza"
description: Use the Cloud Adoption Framework for Azure to learn about analytic solutions with Netezza.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/22/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Analytics solutions for Netezza

Given the end of support from IBM, many existing users of Netezza data warehouse systems are now looking to take advantage of the innovations provided by newer environments (e.g. cloud, IaaS, PaaS) and to delegate tasks such as infrastructure maintenance and platform development to the cloud provider.  

While there are similarities between Netezza and Azure Synapse in that both are SQL databases designed to use massively parallel processing (MPP) techniques to achieve high query performance on very large data volumes, there are also some basic differences in approach:

- Legacy Netezza systems are installed on-premises, using proprietary hardware whereas Azure Synapse is cloud based using Azure storage and compute resources.
- Upgrading a Netezza configuration is a major task involving additional physical hardware and a potentially lengthy database reconfiguration or dump and reload. Since storage and compute resources are separate in the Azure environment these can easily be scaled (upwards and downwards) independently leveraging the elastic scalability capability.
- Azure Synapse can be paused or resized as required to reduce resource utilization and therefore cost.
Microsoft Azure is a globally available, highly secure, scalable cloud environment that includes Azure Synapse within an ecosystem of supporting tools and capabilities.

<!-- TODO add high resolution graphic -->

Azure Synapse provides best-of-breed relational database performance by using techniques such as MPP and automatic in-memory caching—the results of this approach can be seen in independent benchmarks such as the one run recently by GigaOm—see <!-- TODO https://gigaom.com/report/data-warehouse-cloud-benchmark/ --> which compares Azure Synapse to other popular cloud data warehouse offerings. Customers who have already migrated to this environment have seen many benefits including:  

- Improved performance and price/performance
- Increased agility and shorter time to value
- Faster server deployment and application development
- Elastic scalability—only pay for actual usage
- Improved security/compliance
- Reduced storage and Disaster Recovery costs  
- Lower overall TCO and better cost control (OPEX)

To maximize these benefits, it is necessary to migrate existing (or new) data and applications to the Azure Synapse platform. In many organizations, this will include migration of an existing data warehouse from legacy on-premises platforms such as Netezza. At a high level, the basic process will include the following steps.

<!-- markdownlint-disable MD033 -->

| ![1](./_images/icons/1.png) **Preparation** | ![2](./_images/icons/2.png) **Migration** | ![3](./_images/icons/3.png) **Post migration** |
|---|---|---|
|<li>Define scope - what is to be migrated<li>Build inventory of data and processes for mitration<li>Define data model changes (if any)<li>Identify appropriate Azure (and third party) tools and features to be used<li>Train staff early on new platform<li>Set up Azure target platform | <li>Start small and simple<li>Automate where possible<li>Leverage Azure built in tools and features to reduce migration effort<li>Migrate metadata for tables and views<li>Migrate historical data to be maintained<li>Migrate or refactor stored procedures and business processes<li>Migrate or refactor ETL/ELT incremental load processes | <li>Monitor and document all stages of the process<li>Use experience gained to build a template for future migrations<li>Re-engineer the data model if required (using new platform performance and scalability)<li>Test applications and query tools<li>Benchmark and optimize query performance |

This paper looks at schema migration with a view to obtain equivalent or better performance of your migrated Netezza data warehouse and data marts on Azure Synapse. The topics included in this paper apply specifically to migrations from an existing Netezza environment.

## Design considerations

### Migration scope

### Preparation for migration

When migrating from a Netezza environment there are some specific topics that must be taken into account in addition to the more general subjects described in the Section 1 – Design and Performance document.

### Choosing the workload for the initial migration

Legacy Netezza environments have typically evolved over time to encompass multiple subject areas and mixed workloads. When deciding where to start on an initial migration project it makes sense to choose an area that will be able to:

- Prove the viability of migrating to Azure Synapse by quickly delivering of the benefits of the new environment  
- Allow the in-house technical staff to gain relevant experience of the processes and tools involved which can be used in migrations of other areas
- Create a template for further migration exercises that is specific to the source Netezza environment and the current tools and processes that are already in place

A good candidate for an initial migration from a Netezza environment that would enable the items above is typically one that implements a BI/Analytics workload (i.e. not an OLTP workload) with a data model that can be migrated with minimal modifications—normally a start or snowflake schema.  

In terms of size, it is important that the data volume to be migrated in the initial exercise is large enough to demonstrate the capabilities and benefits of the Azure Synapse environment while keeping the time to demonstrate value short, typically in the 1-10TB range.  

One possible approach for the initial migration project that will minimize the risk and reduce the implementation time for the initial project, is confine the scope of the migration to just the data marts. This approach, by definition, limits the scope of the migration and can typically be achieved within short timescales and so can be a good starting point. However, this will not address the broader topics such as ETL migration and historical data migration as part of the initial migration project. These would have to be addressed in later phases of the project as the migrated data mart layer is back filled with the data and processes required to build them.

### Lift and shift as is vs a phased approach incorporating changes

Whatever the drivers and scope of the intended migration, broadly speaking there are 2 types of migration:

**Lift and shift**:
In this case the existing data model (e.g. star schema) is migrated unchanged to the new Azure Synapse platform. The emphasis here is on minimizing risk and the time taken to migrate by reducing the work that has to be done to achieve the benefits of moving to the Azure cloud environment.  

This is a good fit for existing Netezza environments where a single data mart is to be migrated, or the data is already in a well-designed star or snowflake schema or there are time and cost pressures to move to a more modern cloud environment.

**Phased approach incorporating modifications**:
For cases where a legacy warehouse has evolved over a long time it may be necessary to re-engineer them to maintain the require performance levels or support new data (e.g. IoT steams). Migration to Azure Synapse to obtain the well accepted benefits of a scalable cloud environment might be considered as part of the re-engineering process. This could include a change of the underlying data model (e.g. a move from an Inmon model to Data Vault).

The recommended approach for this is to initially move the existing data model as is into the Azure environment then to use the performance and flexibility of the Azure environment to apply the re-engineering changes, leveraging the Azure capabilities where appropriate to make the changes without impacting the existing source system.

### Use Azure Data Factory to implement a metadata-driven migration

It makes sense to automate and orchestrate the migration process by making use of the capabilities in the Azure environment. This approach also minimizes the impact on the existing Netezza environment (which may already be running close to full capacity).

Azure Data Factory is a cloud-based data integration service that allows creation of data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. Using Azure Data Factory, you can create and schedule datadriven workflows (called pipelines) that can ingest data from disparate data stores. It can process and transform the data by using compute services such as Azure HDInsight Hadoop, Spark, Azure Data Lake Analytics, and Azure Machine Learning.

By creating metadata to list the data tables to be migrated and their location it is possible to use the ADF facilities to manage the migration process.

### Design differences between Netezza and Azure Synapse

Multiple databases vs single database and schemas In a Netezza environment there are sometimes multiple separate databases for individual parts of the overall environment. For instance, there may be a separate database for data ingestion and staging tables, a database for the core warehouse tables and another database for data marts (sometimes called a semantic layer). Processing such as ETL/ELT pipelines may implement cross-database joins and will move data between these separate databases.

In the Azure Synapse environment there is a single database, and schemas are used to separate the tables into logically separate groups. Therefore, the recommendation is to use a series of schemas within the target Azure Synapse to mimic any separate databases that will be migrated from the Netezza environment. If schemas are already being used within the Netezza environment then it may be necessary to use a new naming convention to move the existing Netezza tables and views to the new environment (e.g. concatenate the existing Netezza schema and table names into the new Azure Synapse table name and use schema names in the new environment to maintain the original separate database names). Another option is to use SQL views over the underlying tables to maintain the logical structures, but there are some potential downsides to this approach.

- Views in Azure Synapse are read-only, therefore any updates to the data must take place on the underlying base tables
- There may already be a layer (or layers) of views in existence and adding an extra layer of views might impact performance

**Table considerations**:
When migrating tables between different technologies it is generally only the raw data (and the metadata that describes it) that gets physically moved between the 2 environments. Other database elements from the source system (e.g. indexes) are not migrated as these may not be needed or may be implemented differently within the new target environment.  

However, it is important to understand where performance optimizations such as indexes have been used in the source environment as this information can give useful indication of where performance optimization might be added in the new target environment. For example, if zone maps are frequently used by queries within the source Netezza environment, it may indicate that a non-clustered index should be created within the migrated Azure Synapse, but also be aware that other native performance optimization techniques (such as table replication)  may be more applicable that a straight like-for-like creation of indexes.

**Unsupported Netezza database object types**:
Netezza implements some database objects that are not directly supported in Azure Synapse, but there are generally methods to achieve the same functionality within the new environment:

- Zone Maps: In Netezza zone maps are automatically created and maintained for some column types and are used at query time to restrict the amount of data to be scanned. They are created on the following column types:
- INTEGER columns of length 8 bytes or less
- Temporal columns (i.e. DATE, TIME, TIMESTAMP)
- CHAR columns if these are part of a Materialized View and mentioned in the ORDER BY clause
It is possible to find out which columns have zone maps by using the nz_zonemap utility (part of the NZ Toolkit).

Azure Synapse does not include zone maps, but similar results can be achieved by using other (user-defined) index types and/or partitioning.

• Clustered Base tables (CBT): In Netezza CBT’s are most commonly used for fact table, which has billions of records. Scanning such a huge table requires lot of processing time as full table scan could be needed to get relevant records. Organizing records on restrictive CBT via allows Netezza to group records in same or nearby extents, and this process will also create zone maps that improves the performance by reducing the amount of data to be scanned.

In Azure Synapse a similar effect can be achieved by use of partitioning and/or use of other indexes.

• Materialized views: Netezza supports materialized views and recommends that 1 (or more) of these is created over large tables that have many columns where only a few of those columns are regularly used in queries. Materialized views are automatically maintained by the system when data in the base table is updates.
As of May 2019, Microsoft has announced that Azure Synapse will support materialized views which have the same functionality as Netezza. This feature is now available in preview.

**Netezza data type mapping**:
Most Netezza datatypes have a direct equivalent in the Azure Synapse. Below is a table that shows these data types together with the recommended approach for mapping these.

<!-- TODO  insert table graphics or recreate the table -->

There are third-party vendors who offer tools and services to automate migration including the mapping of data types as described above. Also, if a third-party ETL tool such as Informatica or Talend is already in use in the Netezza environment, these can implement any required data transformations.

**SQL DML syntax differences**:
There are a few differences in SQL Data Manipulation Language (DML) syntax between Netezza SQL and Azure Synapse to be aware of when migrating:

<!-- TODO this should probably be a code snippet that the user can copy and use -->
![SQL query](../_images/analytics/sql-query-netezza.png)

### Functions, stored procedures and sequences

When migrating from a mature legacy data warehouse environment such as Netezza there are often elements other than simple tables and views that need to be migrated to the new target environment. Examples of this in Netezza are Functions, Stored Procedures and Sequences.
As part of the preparation phase, an inventory of these objects that are to be migrated should be created and the method of handling them defined, with an appropriate allocation of resources assigned in the project plan.

It may be that there are facilities in the Azure environment that replace the functionality implemented as functions or stored procedures in the Netezza environment. In this case, it is generally more efficient to use the built-in Azure facilities rather than re-coding the Netezza functions.

Third-party vendors offer tools and services that can automate the migration of these (see Attunity or Wherescape migration products for examples).

**Functions**:
In common with most database products, Netezza supports system functions and also user-defined functions within the SQL implementation. When migrating to another database platform such as Azure Synapse common system functions are generally available and can be migrated without change. Some system functions may have slightly different syntax, but the required changes can be automated in this case.  

For system functions where there is no equivalent, of for arbitrary user-defined functions these may need to be re-coded using the language(s) available in the target environment. Netezza user-defined functions are coded in nzlua or C++ languages whereas Azure Synapse uses the popular Transact-SQL language for implementation of user-defined functions.

**Stored procedures**:
Most modern database products allow for procedures to be stored within the database. Netezza provides the NZPLSQL language for this purpose. NZPLSQL is based on Postgres PL/pgSQL. A stored procedure typically contains SQL statements and some procedural logic and may return data or a status.

SQL Azure Data Warehouse also supports stored procedures using T-SQL, so if there are stored procedures to be migrated, they must be recoded accordingly.

**Sequences**:
In Netezza a sequence is a named database object created via CREATE SEQUENCE that can provide the unique value via the NEXT VALUE FOR method. These can be used to generate unique numbers that can be used as surrogate key values for primary key values.

Within Azure Synapse there is no CREATE SEQUENCE, so sequences are handled via use of IDENTITY columns or using SQL code to create the next sequence number in a series.

### Extracting metadata and data from a Netezza environment

**Data Definition Language (DDL) generation**:
It is possible to edit existing Netezza CREATE TABLE and CREATE VIEW scripts to create the equivalent definitions (with modified data types if necessary, as described above). Typically, this involves removing or modifying any extra Netezza-specific clauses (e.g. ORGANIZE ON).

However, all the information that specifies the current definitions of tables and views within the existing Netezza environment is maintained within system catalog tables. This is the best source of this information as it is bound to be up to date and complete. (Be aware that user-maintained documentation may not be in sync with the current table definitions.)

This information can be accessed via utilities such as nz_ddl_table and can be used to generate the CREATE TABLE DDL statements that can then be edited for the equivalent tables in Azure Synapse.

Third-party migration and ETL tools also use the catalog information to achieve the same result.

**Data extraction from Netezza**:
The raw data to be migrated from existing Netezza tables can be extracted to flat delimited files using standard Netezza utilities such as nzsql, nzunload and via external tables. These files can be compressed using gzip and uploaded to Azure Blob Storage via AzCopy or by using Azure data transport facilities such as Azure Data Box.

Generally during a migration exercise it is important to extract the data as efficiently as possible and the recommended approach for this for Netezza is to use the external tables approach as this is the fastest method. Multiple extracts can be performed in parallel to maximize the throughput for data extraction.
A simple example of an external table extract is shown below:
CREATE EXTERNAL TABLE '/tmp/export_tab1.csv' USING (DELIM ',') AS SELECT * from <TABLENAME>;

If sufficient network bandwidth exists data can be extracted directly from an onpremises Netezza system into Azure Synapse tables or Azure Blob Data Storage by using Azure Data Factory processes or third-party data migration or ETL products.

Recommended data formats for the extracted data are delimited text files (also called Comma Separated Values or similar) or Optimized Row Columnar (ORC) or Parquet files.

For more detailed information on the process of migrating data and ETL from a Netezza environment see the associated document Section 2.1. Data Migration ETL and Load from Netezza.  

### Performance recommendations for Netezza migrations

**Similarities in performance tuning approach concepts**:
When moving from a Netezza environment many of the performance tuning concepts for Azure Data Warehouse will be very familiar. For example:

- Using data distribution to co-locate data to be joined onto the same processing node
- Using the smallest data type for a given column will save storage space and accelerate query processing
- Ensuring data types of columns to be joined are identical will optimize join processing by reducing the need to transform data for matching
- Ensuring statistics are up to date will help the optimizer produce the best execution plan

**Differences in performance tuning approach**:
This section highlights lower level implementation differences between Netezza and Azure Synapse for performance tuning.

**Data distribution options**:
CREATE TABLE statements in both Netezza and Azure Synapse allow for specification of a distribution definition via DISTRIBUTE ON for Netezza and DISTRIBUTION = in Azure Synapse.

Compared to Netezza, Azure Synapse provides an additional way to achieve local joins for small table-large table joins (typically dimension table to fact table in a start schema model) is to replicate the smaller dimension table across all nodes, therefore ensuring any value of the join key of the larger table will have a matching dimension row locally available. The overhead of replicating the dimension tables is relatively low provided the tables are not very large. In this case, the hash distribution approach as described above is more appropriate.

**Data indexing**:
Azure Synapse provides a number of user definable indexing options, but these are different in operation and usage to the system managed zone maps in Netezza. Understand the different indexing options as described in <!-- TODO verify link  https://docs.microsoft.com/en-us/azure/sql-data-warehouse/sql-datawarehouse-tables-index -->

Existing system managed zone maps within the source Netezza environment can however provide a useful indication of how the data is currently used and provide an indication of candidate columns for indexing within the Azure Synapse environment.

**Data partitioning**:
In an enterprise data warehouse fact tables can contain many billions of rows and partitioning is a way to optimize the maintenance and querying of these tables by splitting them into separate parts to reduce the amount of data processed. The partitioning specification for a table is defined in the CREATE TABLE statement.

Only 1 field per table can be used for partitioning, and this is frequently a date field as many queries will be filtered by date or a date range. Note that it is possible to change the partitioning of a table after initial load if necessary, by recreating the table with the new distribution using the CREATE TABLE AS (or CTAS) statement. See <!-- TODO verify link https://docs.microsoft.com/en-us/azure/sql-datawarehouse/sql-data-warehouse-tables-partition --> for a detailed discussion of partitioning in Azure Synapse.

**PolyBase for data loading**:
PolyBase is the most efficient method for loading large amounts of data into the Warehouse as it is able to leverage parallel loading streams

**Use resource classes for workload management**:
Azure Synapse uses resource classes to manage workloads. In general, large resource classes provide better individual query performance while smaller resource classes enable higher levels of concurrency. Utilization can be monitored via Dynamic Management Views to ensure that the appropriate resources are being utilized efficiently.

## Next steps
<!-- TODO -->
Can we close on a call to action? Is there a single reference implementation or reference architecture that we can send the reader to, if they want to implement this guidance?
