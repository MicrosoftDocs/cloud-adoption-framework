---
title: How automated ingestion frameworks support data management and analytics scenario in Azure
description: Learn about how automated ingestion frameworks support data management and analytics scenario in Azure.
author: dmarz
ms.author: damarzol
ms.date: 02/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# How automated ingestion frameworks support cloud-scale analytics in Azure

This section discusses a design for how automated ingestion scenarios could be implemented using a combination of PowerApps, Azure Logic Apps and Metadata-driven copy tasks within Azure Data Factory.

Automated data ingestion scenarios are typically focused at enabling non-technical (that is, not Data Engineer) personas to publish data assets to a Data Lake so that further processing can occur. To implement this scenario requires onboarding capabilities enabling:

- Data asset registration
- Provisioning workflow / metadata capture
- Scheduling of ingestion

The interaction between the capabilities can be viewed as follows:

:::image type="content" source="../images/registration-capabilities.png" alt-text="Diagram of data registration capabilities and interactions":::

*Figure 1: Data registration capabilities interactions.*

The following illustrates how this process can be implemented using a combination of Azure services:

:::image type="content" source="../images/automated-ingestion-flow.png" alt-text="Diagram of an automated ingestion process":::

*Figure 2: Automated ingestion process.*

## Data asset registration

Data asset registration is required to provide the metadata used to drive automated ingestion. The information captured should describe:

- Technical information: Data asset name, source system, type, format and frequency
- Governance information: Owner, stewards, visibility (for discovery purposes) and sensitivity

For the purposes of this article, PowerApps is used to capture metadata describing the data asset. A model-driven app is used by the person entering the information that is persisted to a custom Dataverse table. Once saved, further processing steps are invoked through an Automated Cloud Flow that is triggered when the metadata is either created or updated within Dataverse.

![Diagram of an data asset registration.](../images/ingestion-step1-registration.png)

*Figure 3: Data asset registration.*

## Provisioning workflow / metadata capture

The provisioning workflow stage is where the data collected in the registration stage is validated and persisted to the metastore. During this stage, both technical and business validation steps are performed including:

- Validation of input data feeds
- Triggering of approval workflows
- Processing logic to trigger persistence of metadata to the metadata store
- Auditing activities

:::image type="content" source="../images/ingestion-step2-workflow.png" alt-text="Diagram of registration workflow":::

*Figure 4: Registration workflow.*

Once ingestion requests are approved, as part of the processing logic the workflow uses the Azure Purview REST API to insert the sources into Azure Purview.

## Scheduling of ingestion

Within Azure Data Factory, [metadata-driven copy tasks](/azure/data-factory/copy-data-tool-metadata-driven) provide functionality enabling orchestration pipelines to be driven by rows within a Control Table stored within Azure SQL Database. The Copy Data Tool can be used to pre-create metadata-driven pipelines. Once these have been created, the provisioning workflow adds entries to the Control Table to support ingestion from the sources identified in the data asset registration metadata. Both the Azure Data Factory pipelines and the Azure SQL Database containing the Control Table metastore can exist within each data landing zone to create new data sources and ingest them into data landing zones.

:::image type="content" source="../images/ingestion-step3-orchestration.png" alt-text="Diagram of scheduling of data asset ingestion":::

*Figure 5: Scheduling of data asset ingestion.*

## Captured Metadata

Through creating this automated data ingestion you can query the associated metadata and create dashboards to:

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
