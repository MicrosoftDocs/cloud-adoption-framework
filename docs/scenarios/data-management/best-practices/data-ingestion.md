---
title: Understand the ingest process with enterprise-scale for analytics and AI in Azure
description: Learn about the ingest process with enterprise-scale for analytics and AI in Azure
author:  mboswell
ms.author:  mboswell 
ms.date: 08/06/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-data
---

# Understand the ingest process with enterprise-scale for analytics and AI in Azure

In the enterprise scale analytics and AI construction set, the Data Integrations and Data Products teams examine, transform, and release data.

>[!IMPORTANT]
>Data Integrations don't transform data. However, if the business has multiple use cases that require data to be joined together (for example, weather and location data) , then the team could be asked to create this in the curated layer.\
\
>Data Products teams can apply transformations and create their datasets in the curated layer of the data lake as well as the [polyglot storage](https://techcommunity.microsoft.com/t5/data-architecture-blog/polyglot-persistence-with-azure-data-services/ba-p/1514912) they've chosen to use.

Azure provides several services for ingesting and releasing data to various native and third-party platforms. Depending on volume, velocity, variety, and direction, different services can be used. Some of these services are listed below.

- [Azure Data Factory](/azure/data-factory/introduction) is a service built for all data integration needs and skill levels. Write your own code or construct, extract, load, and transform processes without code and within the intuitive visual environment. Visually integrate data sources with more than 90 natively built and maintenance-free connectors at no added cost. Engineers can use private endpoints and link services to securely connect to Azure platform-as-a-service (PaaS) resources without using the PaaS resource's public endpoints. Using integration runtimes, engineers can extend pipelines to third-party environments, including on-premises data sources and other clouds.\

Some of these connectors support being used as a source (read) or as a sink (write). Azure native services, Oracle, SAP, and some others can be used as source or sink. However, not all connectors support this. In these cases, you can use generic connectors like Open Database Connectivity (ODBC), the file system, or SFTP connectors.

- [Azure Databricks](/azure/databricks/) is a fast, easy, and collaborative Apache Spark-based analytics service. For a big data pipeline, the data (raw or structured) is ingested into Azure through Data Factory in batches or streamed in almost real time with Apache Kafka, Azure Event Hubs, or IoT Hub. This data lands in a data lake for long-term, persisted storage in Azure Data Lake Storage. Azure Databricks can read data from multiple data sources as part of the workflow.

- The Microsoft Power Platform provides [connectors to hundreds of services](/connectors/connector-reference/) that can be event-, schedule-, or push-driven. Power Automate can act on events and trigger workflows optimized for single records or small data volumes.\

Proprietary native and third-party tooling provides niche capabilities to integrate with specialist systems and/or near-real-time replication.

- [Azure Data Share](/azure/data-share) supports organizations to securely share data with multiple external customers and partners. Once a data share account is created and datasets are added, customers and partners can be invited to the data share. Data providers are always in control of the data that they've shared. Azure Data Share makes it simple to manage and monitor what data was shared, when, and by whom.

>[!IMPORTANT]
>Every data landing zone has an [ingest and processing resource group](../architectures/data-landing-zone.md#ingest-and-processing) that exists for the enterprises with an ingestion framework engine. If you don't have this framework engine, the only recommended resource is deploying the **Azure Databricks Engineering Workspace**, which would be used by Data Integrations to run complex ingestion. See the [automated ingestion framework](./automated-ingestion-pattern.md#ingest new-data-sources-(automated)) for potential automation patterns.

## Ingest considerations for Data Factory

If you have an ingestion framework engine, you should deploy a single Data Factory for each data landing zone in the ingest and processing resource group. The Data Factory workspace should be locked off to users, and only managed identity and service principals will have access to deploy. Data Landing Zone Ops should have read access to allow pipeline debugging.

Each data integration resource group will have its own Data Factory that will be used by Integration Ops to move data from the source to raw to enriched data. Having a Data Factory in each data integration resource group supports a complete continuos integration (CI) and continuos deployment (CD) experience by only allowing pipelines to be deployed from Azure DevOps or GitHub.

All Data Factory workspaces will mostly use the managed virtual network (VNeT) feature in Data Factory or [self-hosted integration runtime](/azure/data-factory/concepts-integration-runtime) for their data landing zone within the data management landing zone. Engineers are encouraged to use the managed VNeT feature to securely connect to the Azure PaaS resource.

However, it will be possible to create additional integration runtimes to ingest from on-premises, third-party clouds, and third-party software-as-a-service (SaaS) data sources.

>[!TIP]
>By deploying a [self-hosted integration runtime](/azure/data-factory/concepts-integration-runtime) in the data management landing zone, you can approve the IP range required to connect to on-premises or third-party cloud sources.

## Ingest considerations for Azure Databricks

This guidance builds on top of:

- [Securing access to Azure Data Lake Gen2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)
- [Azure Databricks Implementation](./azure-databricks-implementation.md)

A single premium **Azure Databricks Data Engineering** workspace should be deployed per data landing zone in the production ingest and processing resource group. This will enable a complete CI/CD experience and only allow notebooks to be deployed from Azure DevOps or GitHub.

For development, Integration Ops should have their own Databricks environments before checking in code to be deployed to the single Azure Databricks workspace during testing and production.

The test and production workspaces will be locked off to users, and only managed identity/service principals will have access to it. All workspace management will be handled with a REST API.

Data Factory in the data integration resource group should provide the framework for calling Azure Databricks jobs.

Service principals can help to mount data lakes into this workspace. See [Pattern 1 - Access via Service Principal](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md#pattern-1---access-via-service-principal) for more information.

Integration Ops teams can deploy short, automated jobs on Azure Databricks and expect their clusters to start quickly, execute the job, and terminate. It's recommended to set up Azure Databricks Pools to reduce the time it takes for clusters to spin up for jobs.

Pipelines created by the Integration Ops teams in Azure Databricks can take data from the source to raw, enriched, or curated data. Data Integrations must use the Integration Ops service principal created when onboarding their data integration to deploy their notebooks in an Integration Ops repo. The notebook is from Data Integration's Data Factory resource group.

It is recommended that enterprises use Azure DevOps to implement a deployment framework for new pipelines to create the dataset folders, assign access control lists, and create a table with or without enforcing Databricks Table Access Controls.

## Stream ingestion

Organizations might have to support situations where publishers generate high-velocity event streams. For this pattern, a message queue is recommended (for example, Azure Event Hubs or IoT Hub) to ingest these streams.

Azure Event Hubs and IoT Hub are scalable event processing services that can ingest and process large event volumes and data with low latency and high reliability. Event Hubs is designed as a big data streaming and event ingestion service, while IoT Hub is a managed service that serves as a central message hub for bidirectional communication between an IoT application and the devices it manages.

From that point, data can either be exported to a data lake at regular intervals (batch) and processed with Azure Databricks in near-real-time via Apache Spark streaming, Azure Data Explorer, Stream Analytics, or Time Series Insights.

The last Event Hubs or Kafka Landing Zone inside the use case's specific landing zone should send its aggregated data to the Data Lake's raw layer in one of the data landing zones and/or to Event Hubs related to the data integration resource group in the data landing zone.

## Enforce data quality

As data is ingested, data quality checks should be implemented near the sources and before downstream subscribers use the datasets. In the case of batch ingestion from the the data lake, these checks should be done when moving data from raw to enriched.

Figure 1 illustrates the process of data moving through integrity and data quality into the curated layer:

![Implement data quality during ingestion.](../images/adls-dq.png)

*Figure 1: Implement data quality during ingestion.*

- Before data is moved to enriched layer, its schema and columns are checked against the metadata registered in the data catalog.

- If the data contains errors, the load will be aborted, and Integration Ops should be notified of the failure.

- If the schema and column checks pass, the data is loaded into the enriched layers with conformed data types.

- Before moving into the enriched layer, a data quality process checks for duplicate data, unknown values, and data type compliance. Integration Ops can configure additional checks and receive notifications about violations.

## Monitor ingestion

The out-of-the-box [Data Factory pipeline monitoring](/azure/data-factory/monitor-visually) will be used for monitoring and troubleshooting the exceptions from the Data Factory pipelines. It reduces the effort of developing a custom monitoring and reporting solution.

Built-in monitoring is one of the main reasons to use Data Factory as the main orchestration tool, and its setup can be automated with Azure Policy.

## Map data sources to services

The tables below map ingestion and processing Services to sources that typically need to be ingested or released from Azure.

**Ingestion services**:

| ID | Mechanism                   | Note                           |
|----|-----------------------------|--------------------------------|
| A  | Data Factory          | Built-in and generic (ODBC, SFTP, REST) connectors |
| B  | Azure Databricks            | Custom code (JDBC, JAR, and more)   |
| C  | Third-party                   | WANdisco, Qlik, Oracle GoldenGate |
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
| Micosoft Outlook | Email | SaaS | REST | XML, JSON, CSV | E | E | E | E | E | E |

Depending on the destination, the Azure Data Migration service can replicate from on-premises and third-party databases (for example, Microsoft SQL Server, PostgreSQL, MySQL, or Oracle) to an Azure-based data store.
