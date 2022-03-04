---
title: How automated ingestion frameworks support cloud-scale analytics in Azure
description: Learn about how automated ingestion frameworks support cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 02/25/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# How automated ingestion frameworks support cloud-scale analytics in Azure

This section provides guidance for how custom ingestion frameworks can drive services and processes.

> [!NOTE]
> The following suggestions for an automated ingestion framework aren't explained in detail, and they don't describe a specific Microsoft product.

## Automated data source application

The following illustrates how data application teams can use custom applications, Azure Logic Apps, or Microsoft Power Apps to register new data sources:

![Diagram of an automated ingestion process.](../images/automated-ingest-process.png)

A data agnostic ingestion engine UI is deployed to the data management landing zone. This could be integrated into a data marketplace or operations console.

The application can talk to an Azure Data Factory SQL Database metastore within each data landing zone to create new data sources and ingest them into data landing zones. Once ingestion requests are approved, it uses the Azure Purview REST API to insert the sources into Azure Purview.

The metadata triggers Data Factory jobs and will have most of the parameters required for running pipelines. A Data Factory master pipeline pulls parameters from the Data Factory SQL Database metastore to transfer data from the source into the data lake and enrich it with conformed data types before creating a table definition in the Azure Databricks Apache Hive metastore.

For all job types (including indirect ingestion from sources like SAP), areas, and functions, the application should store the jobs' technical and operational metadata in a SQL database. Technical metadata can drive jobs because it has have most of the parameters required for this task. Data platform, data landing zone, and data application teams can use the metadata to:

- Track jobs and the latest data-loading timestamps for data products related to their functions.
- Track available data products.
- Grow data volumes.
- Obtain real-time updates about job failures.

Operational metadata can be used to track:

- Jobs, job steps, and their dependencies.
- Job performance and performance history.
- Data volume growth.
- Job failures.
- Source metadata changes.
- Business functions that depend on data products.

If the business needs operational reports and event notifications, data landing zone ops and data application teams can use Microsoft Power BI to query the SQL Database to build them.

## Register a new dataset (automated)

Figure 2 recommends the following registration process for automating the ingestion of new data sources:

![How new data products are ingested (automated).](../images/new-dataset-ingestion.png)

*Figure 2: How new data products are ingested (automated).*

Enterprises can use custom applications, Azure Logic Apps, or Microsoft Power Apps in the data management landing zone to enter data into the Data Factory metastore and gain the following benefits:

- Source details are registered, including production and Data Factory environments.
- Data shape, format, and quality constraints are captured.
- Integration ops indicate if the data is **sensitive (Personal data)**, and this classification drives the process during which data lake folders are created to ingest raw and enriched data. The source names raw data, and the data asset names enriched and curated data.
- Service principal and security groups are created for ingesting and giving access to the dataset.
- An ingestion job is created in the data landing zone Data Factory metastore.
- An API inserts the data definition into Azure Purview.
- Details are validated and tested in development/testing environments.
- Subject to the validation of the data source and approval by the ops team, details are published to a Data Factory metastore.

## Ingest new data sources (automated)

The following illustrates how registered data sources in a Data Factory SQL Database metastore are pulled and how data is ingested at first:

![Diagram of how new data sources are ingested.](../images/new-datastore-ingestion.png)

The Data Factory ingestion master pipeline reads configurations from a Data Factory SQL Database metastore and runs iteratively with the correct parameters. Data moves with little to no change from the source to the raw layer in Azure Data Lake. The data shape is validated based on the Data Factory metastore, and file formats are converted to delta lake format.

## Use the Azure Purview REST API to discover data

As part of the integration framework, Azure Purview REST APIs should be used to register data during the first ingestion. They can be used to submit data to the data catalog for discovering data soon after it's ingested. For more information and to get started, see the tutorial for [how to use Azure Purview REST APIs](/azure/purview/tutorial-using-rest-apis).

### Register data sources

Use the following API call to register new data sources:

````HTTP
PUT https://{accountName}.scan.purview.azure.com/datasources/{dataSourceName}
````

**URI parameters for the data source:**

|Name  |Required  |Type  |Description  |
|---------|---------|---------|---------|
|`accountName`    | True       | String        | Name of the Azure Purview account         |
|`dataSourceName` | True       | String        | Name of the data source         |

### Use the Azure Purview REST API for registration

The following examples show how to use the Azure Purview REST API to register data sources with payloads:

**Register an Azure Data Lake Storage Gen2 data source:**

```json
{
  "kind":"AdlsGen2",
  "name":"<source-name> (for example, My-AzureDataLakeStorage)",
  "properties":{
    "endpoint":"<endpoint> (for example, https://adls-account.dfs.core.windows.net/)",
    "subscriptionId":"<azure-subscription-guid>",
    "resourceGroup":"<resource-group>",
    "location":"<region>",
    "parentCollection":{
      "type":"DataSourceReference",
      "referenceName":"<collection-name>"
    }
  }
}
```

**Register a SQL Database data source:**

```json
{
  "kind":"<source-kind> (for example, AdlsGen2)",
  "name":"<source-name> (for example, My-AzureSQLDatabase)",
  "properties":{
    "serverEndpoint":"<server-endpoint> (for example, sqlservername.database.windows.net)",
    "subscriptionId":"<azure-subscription-guid>",
    "resourceGroup":"<resource-group>",
    "location":"<region>",
    "parentCollection":{
      "type":"DataSourceReference",
      "referenceName":"<collection-name>"
    }
  }
}
```

> [!NOTE]
> The `<collection-name>`is a current collection that exists in an Azure Purview account.

### Create a scan

[Learn how to can create credentials](/azure/purview/manage-credentials) to authenticate sources in Azure Purview before setting up and running a scan.

Use the following API call to scan data sources:

````HTTP
PUT https://{accountName}.scan.purview.azure.com/datasources/{dataSourceName}/scans/{newScanName}/
````

**URI parameters for a scan:**

|Name  |Required  |Type  |Description  |
|---------|---------|---------|---------|
|`accountName`    | True        | String        | Name of the Azure Purview account         |
|`dataSourceName` | True        | String        | Name of the data source         |
|`newScanName`    | True        | String        | Name of the new scan         |

### Use the Azure Purview REST API for scanning

The following examples show how to use the Azure Purview REST API to scan data sources with payloads:

**Scan an Azure Data Lake Storage Gen2 data source:**

```json
{
  "name":"<scan-name>",
  "kind":"AdlsGen2Msi",
  "properties":
  {
    "scanRulesetType":"System",
    "scanRulesetName":"AdlsGen2"
  }
}
```

**Scan a SQL Database data source:**

```json
{
  "name":"<scan-name>",
  "kind":"AzureSqlDatabaseMsi",
  "properties":
  {
    "scanRulesetType":"System",
    "scanRulesetName":"AzureSqlDatabase",
    "databaseName": "<database-name>",
    "serverEndpoint": "<server-endpoint> (for example, sqlservername.database.windows.net)"
  }
}

```

**Use the following API call to scan data sources:**

```http
POST https://{accountName}.scan.purview.azure.com/datasources/{dataSourceName}/scans/{newScanName}/run
```

## Next steps

[Overview of Azure Data Lake Storage for cloud-scale analytics](data-lake-overview.md)
