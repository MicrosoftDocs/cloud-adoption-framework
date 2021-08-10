---
title: Understand the ingest process with enterprise-scale for analytics and AI in Azure
description: Learn about the ingest process with enterprise-scale for analytics and AI in Azure.
author: mboswell
ms.author: mboswell
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand the ingest process with enterprise-scale for analytics and AI in Azure

Data integrations and data products teams examine, transform, and release data in enterprise-scale for analytics and AI.

> [!IMPORTANT]
> Data integrations don't transform data, but if the business has several use cases whose data needs to be joined together (for example, weather and location data), then the team could be asked to create this in the curated layer.\
\
> Data products teams can apply transformations and create their datasets in the data lake's curated layer and the [polyglot storage](https://techcommunity.microsoft.com/t5/data-architecture-blog/polyglot-persistence-with-azure-data-services/ba-p/1514912) they've chosen to use.

Azure provides several services to ingest and release data to native and third-party platforms. Different services can be used, depending on volume, velocity, variety, and direction. Some of these services are:

- [Azure Data Factory](/azure/data-factory/introduction) is a service built for all data integration needs and skill levels. Write your own code or construct, extract, load, and transform processes within the intuitive visual environment and without code. With more than 90 natively built and maintenance-free connectors, visually integrate data sources at no added cost. Engineers can use private endpoints and link services to securely connect to Azure platform as a service (PaaS) resources without using the PaaS resource's public endpoints. Engineers can use integration runtimes to extend pipelines to third-party environments like on-premises data sources and other clouds.

Some of these connectors support being used as a source (read) or as a sink (write). Azure native services, Oracle, SAP, and others can be used as source or sink, but not all connectors support it. In these cases, you can use generic connectors like Open Database Connectivity (ODBC), the file system, or SSH File Transfer Protocol (SFTP) connectors.

- [Azure Databricks](/azure/databricks/) is a fast, easy, and collaborative Apache-Spark-based analytics service. For a big data pipeline, you can ingest the data (raw or structured) into Azure through Data Factory in batches or streamed in almost real time with Apache Kafka, Azure Event Hubs, or IoT Hub. This data lands in a data lake for long-term, persisted storage in Azure Data Lake Storage. Azure Databricks can read data from multiple data sources as part of the workflow.

- The Microsoft Power Platform provides [connectors to hundreds of services](/connectors/connector-reference/) that can be event-, schedule-, or push-driven. Microsoft Power Automate can act on events and trigger workflows optimized for single records or small data volumes.

Proprietary native and third-party tooling provides niche capabilities to integrate with specialized systems and near-real-time replication.

- [Azure Data Share](/azure/data-share/) supports organizations to securely share data with multiple external customers and partners. Once you create a data share account and add datasets, customers and partners can be invited to the data share. Data providers are always in control of the data that they've shared. Azure Data Share makes it simple to manage and monitor what data is shared, when it was shared, and who shared it.

> [!IMPORTANT]
> Every data landing zone has an [ingest and processing resource group](../architectures/data-landing-zone.md#ingest-and-processing) that exists for enterprises with an ingestion framework engine. If you don't have this framework engine, the only recommended resource is deploying an Azure Databricks data science and engineering workspace, which would be used by data integrations to run complex ingestion. See the [automated ingestion framework](./automated-ingestion-pattern.md#ingest-new-data-sources-automated) for potential automation patterns.

## Ingest considerations for Azure Data Factory

If you have an ingestion framework engine, you should deploy a single Data Factory for each data landing zone in the ingest and processing resource group. The Data Factory workspace should be locked off to users, and only managed identity and service principals will have access to deploy. Data landing zone operations should have read access to allow pipeline debugging.

Each data integration resource group will have its own Data Factory that integration operations will use to move data from the source to raw to enriched data. Having a Data Factory in each data integration resource group supports a complete continuous integration (CI) and continuous deployment (CD) experience by only allowing pipelines to be deployed from Azure DevOps or GitHub.

All Data Factory workspaces will mostly use the managed virtual network (VNet) feature in Data Factory or [self-hosted integration runtime](/azure/data-factory/concepts-integration-runtime) for their data landing zone within the data management landing zone. Engineers are encouraged to use the managed VNet feature to securely connect to the Azure PaaS resource.

However, it's possible to create more integration runtimes to ingest from on-premises, third-party clouds, and third-party software-as-a-service (SaaS) data sources.

> [!TIP]
> By deploying a [self-hosted integration runtime](/azure/data-factory/concepts-integration-runtime) in the data management landing zone, you can approve the IP range required to connect to on-premises or third-party cloud sources.

## Ingest considerations for Azure Databricks

This guidance elaborates on the guidance in:

- [Securing access to Azure Data Lake Gen2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks best practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)
- [Azure Databricks implementation](./azure-databricks-implementation.md)

- One premium Azure Databricks data engineering workspace should be deployed per data landing zone in the production ingest and processing resource group. It will enable a complete CI/CD experience and only allow notebooks to be deployed from Azure DevOps or GitHub.

- For development, integration operations should have their own Azure Databricks environments before checking in code to be deployed to the single Azure Databricks workspace during testing and production.

- The test and production workspaces will be locked off to users, and only managed identity/service principals will have access to it. All workspace management will be handled with a REST API.

- Data Factory in the data integration resource group should provide the framework for calling Azure Databricks jobs.

- Service principals can help to mount data lakes into this workspace. For more information, see [Pattern 1 - access via service principal](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md#pattern-1---access-via-service-principal) for more information.

- Integration operations teams can deploy short, automated jobs on Azure Databricks and expect their clusters to start quickly, execute the job, and terminate. It's recommended to set up Azure Databricks pools to reduce the time it takes for clusters to spin up for jobs.

- Pipelines created by the integration ops teams in Azure Databricks can take data from the source to raw, enriched, or curated data. Data integrations must use the integration ops service principal created when onboarding their data integration to deploy their notebooks in an integration ops repo. The notebook is from data integration's Data Factory resource group.

- We recommend organizations use Azure DevOps to implement a deployment framework for new pipelines. The framework will be used to create the dataset folders, assign access control lists, and create a table with or without enforcing Databricks table access controls.

## Stream ingestion

Organizations might need to support scenarios where publishers generate high-velocity event streams. For this pattern, a message queue is recommended, for example, Event Hubs or IoT Hub, to ingest these streams.

Event Hubs and IoT Hub are scalable event processing services that can ingest and process large event volumes and data with low latency and high reliability. Event Hubs is designed as a big data streaming and event ingestion service. IoT Hub is a managed service that serves as a central message hub for bidirectional communication between an IoT application and the devices it manages. From there, data can either be exported to a data lake at regular intervals (batch) and processed with Azure Databricks in near-real-time via Apache Spark streaming, Azure Data Explorer, Stream Analytics, or Time Series Insights.

The last Event Hub or Apache Kafka landing zone inside the use case's specific landing zone should send its aggregated data to the data lake's raw layer in one of the data landing zones and to Event Hubs related to the data integration resource group in the data landing zone.

## Enforce data quality

As data is ingested, data quality checks should be implemented near the sources and before downstream subscribers use the datasets. If there's batch ingestion from the data lake, these checks should be done when moving data from raw to enriched.

![Diagram of how to implement data quality during ingestion.](../images/adls-dq.png)

- Before data is moved to enriched layer, its schema and columns are checked against the metadata registered in the data catalog.

- If the data contains errors, the load will be aborted, and integration ops should be notified of the failure.

- If the schema and column checks pass, the data is loaded into the enriched layers with conformed data types.

- Before you move into the enriched layer, a data quality process checks for duplicate data, unknown values, and data type compliance. Integration operations can configure more checks and receive notifications about violations.

## Monitor ingestion

Out-of-the-box [Azure Data Factory pipeline monitoring](/azure/data-factory/monitor-visually) can be used to monitor and troubleshoot the exceptions from the Data Factory pipelines. It reduces the effort of developing a custom monitoring and reporting solution.

Built-in monitoring is one of the main reasons to use Azure Data Factory as a main orchestration tool, and Azure Policy can help to automate this setup.

## Map data sources to services

The guidance in this section maps ingestion and processing services to sources that typically need to be ingested or released from Azure.

**Ingestion services:**

| ID | Mechanism                   | Note                           |
|----|-----------------------------|--------------------------------|
| A  | Data Factory          | Built-in and generic (ODBC, SFTP, and REST) connectors |
| B  | Azure Databricks            | Custom code (JDBC, JAR, and more)   |
| C  | Third-party                   | WANdisco, Qlik, and Oracle GoldenGate |
| D  | Other                       | For example, native capabilities         |
| E  | Microsoft Power Platform and Azure Logic Apps | Microsoft Power Automate connectors      |

**Data sources mapping to services**:

| Provider | Type | Hosted | Category | Notes | Full-load ingest | Incremental load ingest | Real-time ingest | Full-load egress | Incremental load egress | Real-time egress |
|--|--|--|--|--|--|--|--|--|--|--|
| Oracle | Tabular | IaaS | Database | GoldenGate to Azure Data Lake Storage | A, B | A, B | C | A, B | A, B | C |
| Microsoft SQL Server | Tabular | IaaS | Database | SAP Landscape Transformation and Qlik | A, B | A, B | C, D2 | A, B | A, B | C, D2 |
| MySQL | Tabular | IaaS | Database | SAP Landscape Transformation and Qlik | A, B | A, B | C, D2 | A, B | A, B | C, D2 |
| SAP BW/4HANA  | Tabular | IaaS | Database | SAP Landscape Transformation and Qlik | A, B, C, D | A, B, C, D | C | - | - | - |
| SAP HANA | Tabular | IaaS | Database | SAP Landscape Transformation and Qlik | A, B, C, D | A, B, C, D | C | A, B | A, B | - |
| Apache Impala | Tabular | IaaS | Database | - | A, B | A, B | - | B | B | - |
| Microsoft SharePoint | List | SaaS | Record Store | - | A, E | A, E | E | A, E | A, E | E |
| REST | REST | Various | REST | XML, JSON, CSV | A, B, E | A, B, E | A, B, E | A, B, E | A, B, E | A, B, E |
| Microsoft Outlook | Email | SaaS | REST | XML, JSON, CSV | E | E | E | E | E | E |

Depending on the destination, Azure Database Migration Service can replicate from on-premises and third-party databases such as Microsoft SQL Server, PostgreSQL, MySQL, or Oracle, to an Azure-based data store.

## Next steps

[SAP data ingestion](./sap-data-ingestion.md)
