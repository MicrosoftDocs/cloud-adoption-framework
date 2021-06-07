---
title: Enterprise Scale Analytics and AI Automated Ingestion Framework
description: Enterprise Scale Analytics and AI Architecture Automated Ingestion Framework
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Automated Ingestion Framework

In previous topics [Azure Data Factory Ingest Considerations](eslz-data-ingestion.md#azure-data-factory-ingest-considerations) and [Ingestion and Processing Resource Group](eslz-data-landing-zone.md#ingestion-and-processing-resource-group), we have discussed enterprises building their own Custom Ingestion Framework.

This section provides guidance for services and processes that could be driven by a Custom Ingestion Framework.

>[!Note]
>The processes described below do not constitute a Microsoft product nor are they a complete specification. They are suggestions for architecting an Automated Ingestion Framework.

## Automated Data Source Application

![Automated Ingestion Process](./images/automated_ingestion_process.png)

Figure 1: Automated Ingestion Process

Figure 1 illustrates how Domains could register new data sources via a custom application, Logic App, or PowerApps.

The application could talk to an Azure Data Factory SQL DB Metastore in each Data Landing Zone to create new data sources for ingestion into the Data Landing Zones. Once ingestion requests have been approved, it insert the source into Azure Purview, in the Data Management Landing Zone, via the Azure Purview Rest API.

The metadata will be used as a trigger for Azure Data Factory jobs and will have most of the parameters required for running of pipelines.

An Azure Data Factory master pipeline would pull parameters from the Azure Data Factory SQL DB Metastore to land data, from source, into the Data Lake and Enrich with conformed data types before creating a table definition in the Azure Databricks Hive Metastore.

The app should store the jobs' technical metadata and operational metadata in an Azure SQL DB Database, for all job types (including indirect ingestion from sources like SAP) for all areas and functions. The metadata can be used by Data Platform Ops, Data Landing Zone Ops and Domain Ops for:

- Tracking of jobs and latest data loading timestamps for datasets related to their functions.
- Tracking of available datasets
- Data volume growth
- Real-time updates on job failures

The technical metadata could be used as a driver for various jobs, and it will have most of the parameters required for running the jobs.

Operational metadata can be used for tracking:

- Jobs, job steps, and their dependencies
- Job performance and performance history
- Data volume growth
- Job failures
- Source metadata changes
- Business functions dependent on datasets

If the business requires, Data Landing Zone Ops and Domain Ops could build operational reports and event notifications with Power BI by querying the Azure SQL DB Database.

## New Dataset Registration (Automated)

Figure 2 suggests a detailed registration process for automating the ingestion of new data sources.

![New Dataset Registration(Automated)](./images/new_dataset_ingestion.png)

Figure 2: New Dataset Ingestion (Automated)

By entering data into the Azure Data Factory Metastore via a custom app, Logic Apps or PowerApps in the Dat,a Management Landing Zone, enterprises can realize the following benefits:

- Source details are registered, including production and non-production environments.
- Data shape, format, and quality constraints are captured.
- Domains indicate if the data is sensitive, and this classification drives the process upon which Data Lake folders are created for ingestion of raw and enriched. Raw is named by source. Enriched and curated is named by Data Asset.
- Service Principal and Security Groups are created for ingesting and giving access to the dataset.
- An ingestion job is created in the Data Landing Zone ADF Metastore.
- The Data Definition is inserted in the Azure Purview via its API.
- Details validated and tested in dev/test environments.
- Subject to validation of the data source, and approval by the ops team, details are published to Azure Data Factory Metastore.

## New Data Source Ingestion (Automated)

Figure 3 illustrates how the registered data sources in Azure Data Factory SQL DB Metastore are polled and how data is initially ingested.

![New Data Source Ingestion](./images/new_datastore_ingestion.png)

The Azure Data Factory ingestion master pipeline reads configuration from Azure Data Factory SQL DB Metastore and runs iteratively with respective parameters. Data is moved from source to raw layer in Azure Data Lake with minimal to no change. Data shape is validated based on the Azure Data Factory Metastore, and file formats are converted to a single common format (*e.g.* parquet) before being copied into the enriched layer.

If it is the first time the data has been ingested, it connects to Azure Databricks Engineering workspace, and a data definition is created within the Data Management Landing Zone Hive Metastore. This data definition needs to be protected so that only the automation process can create, alter, or drop data definitions.

If the Domain wants to expose data via Synapse Pools, the custom solution should create external tables or ingest data directly into Synapse Pools internal tables.

## Data Discovery using the Purview Rest API

The Azure Purview REST APIs may be used to submit data to the data catalog or build a custom experience, such as an automated process, for discovering data soon after it is ingested. [See our tutorial on how to use the Azure Purview REST APIs](/azure/purview/tutorial-using-rest-apis) to get started.

### Registering Data Sources

To register new data sources, use the following API call:

````HTTP
PUT https://{accountName}.scan.purview.azure.com/datasources/{dataSourceName}
````

#### Data Source URI Parameters

|Name  |Required  |Type  |Description  |
|---------|---------|---------|---------|
|`accountName`    | True       | string        | Name of the Purview account.         |
|`dataSourceName` | True       | string        | Name of the data source         |

#### Sample Data Source Request Payloads

Following are a few examples of payloads to register data sources using the Purview Rest API.

##### Register Azure Data Lake Storage Gen2 Data Source

```JSON
{
  "kind":"AdlsGen2",
  "name":"<source-name> (e.g. My-AzureDataLakeStorage)",
  "properties":{
    "endpoint":"<endpoint> (e.g. https://adls-account.dfs.core.windows.net/)",
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

##### Register Azure SQL Database Data Source

```JSON
{
  "kind":"<source-kind> (e.g.AdlsGen2)",
  "name":"<source-name> (e.g. My-AzureSQLDatabase)",
  "properties":{
    "serverEndpoint":"<server-endpoint> (e.g., sqlservername.database.windows.net)",
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

>[!NOTE]
>The `<collection-name>` is an existing collection which exists in the Purview account.

### Creating a Scan

Before setting up and running a scan, [learn how you can create credentials](/azure/purview/manage-credentials) for source authentication in Azure Purview.

To set up a scan on data sources, use the following API call:

````HTTP
PUT https://{accountName}.scan.purview.azure.com/datasources/{dataSourceName}/scans/{newScanName}/
````

#### Scan URI Parameters

|Name  |Required  |Type  |Description  |
|---------|---------|---------|---------|
|`accountName`    | True        | string        | Name of the Purview account.         |
|`dataSourceName` | True        | string        | Name of the data source         |
|`newScanName`    | True        | string        | Name of the new scan         |

#### Sample Scan Request Payloads

Following are a few example payloads set up scans for data sources using the Purview Rest API.

#### Scan Azure Data Lake Storage Gen2

```JSON
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

##### Scan Azure SQL Database

```JSON
{
  "name":"<scan-name>",
  "kind":"AzureSqlDatabaseMsi",
  "properties":
  {
    "scanRulesetType":"System",
    "scanRulesetName":"AzureSqlDatabase",
    "databaseName": "<database-name>",
    "serverEndpoint": "<server-endpoint> (e.g., sqlservername.database.windows.net)"
  }
}

```

Run the scan on data sources using the following API call:

```HTTP
POST https://{accountName}.scan.purview.azure.com/datasources/{dataSourceName}/scans/{newScanName}/run
```
