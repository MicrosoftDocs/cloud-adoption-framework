---
title: Azure Enterprise Scale Analytics and AI Ingest Overview
description: Enterprise Scale Analytics and AI Ingest Overview
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Ingestion

In the Enterprise Scale Analytics and AI construction set, Data Integrations and Data Product will ingress, transform, and egest data.

>[!IMPORTANT]
>Data Integrations do not carry out any transformation of data. However, if the business has multiple use cases where it requires the same data to be joined together, such as weather and location data, then the Data Integration could be asked to create this in the curated layer. \
\
>Data Products teams can apply transformations and create their datasets in the curated layer of the Data Lake as well as the [Polygot Storage](https://techcommunity.microsoft.com/t5/data-architecture-blog/polyglot-persistence-with-azure-data-services/ba-p/1514912) they have chosen to use.

Azure provides several services for ingesting and egesting data to various native and third-party platforms. Depending on volume, velocity, variety, and direction, different services can be used. Some of these services are listed below.

- [Azure Data Factory](/azure/data-factory/introduction) is a service built for all data integration needs and skill levels. Easily construct ETL and ELT processes code-free within the intuitive visual environment or write your own code. Visually integrate data sources using more than 90+ natively built and maintenance-free connectors at no added cost. Using private endpoints and private link services, engineers can securely connect to Azure PaaS resources without using any public endpoint of the PaaS resource. Using integration runtimes, engineers can extend pipelines to third-party environments, including on-premises data sources and other clouds.\
\
Some of these connectors support being used as a source (read) or as a sink (write). Azure native services, Oracle, SAP, and some others can be used as source or sink. However, not all connectors support this. In these cases you can use the generic connectors such as ODBC, filesystem, and SFTP connectors.

- [Azure Databricks](/azure/databricks/) is a fast, easy, and collaborative Apache Spark-based analytics service. For a big data pipeline, the data (raw or structured) is ingested into Azure through Azure Data Factory in batches, or streamed near-real-time using Kafka, Event Hub, or IoT Hub. This data lands in a data lake for long-term, persisted storage in Azure Data Lake Storage. Azure Databricks can read data from multiple data sources as part of the workflow.

- Power Platform provides [connectors to hundreds of services](/connectors/connector-reference/) that can be event, schedule, or push driven. Power Automate can act on events and trigger workflows, optimized for single records or small data volumes.\
\
Proprietary native and third-party tooling provides niche capabilities to integrate with specialist systems and/or near-real-time replication.

- [Azure Data Share](/azure/data-share) enables organizations to securely share data with multiple external customers and partners. Once a data share account is created and datasets added, customers and partners can be invited to the data share. Data providers are always in control of the data that they have shared. Azure Data Share makes it simple to manage and monitor what data was shared, when, and by whom.

>[!IMPORTANT]
>Every Data Landing Zone has an [Ingest and Processing resource group](data-landing-zone.md#ingest-and-processing) which exists for the purpose of Enterprises who have an ingestion framework engine. If you do not have this framework engine, the only resource we would recommend deploying is the *Azure Databricks Engineering Workspace* which would be used by Data Integrations to run complex ingestion. See [Automated Ingestion Framework](automated-ingestion-pattern.md#automated-ingestion-framework) for potential automation patterns.

## Azure Data Factory Ingest Considerations

If you have an ingestion framework engine, you should deploy a single Azure Data Factory per Data Landing Zone in the production Ingest and Processing Resource Group. The Azure Data Factory workspace should be locked off to users, and only managed identity and service principals will have access to deploy. Data Landing Zone Ops should have Read access to allow debugging of pipelines.

Each Data Integration resource group will have their own Azure Data Factory which will be used by Integration Ops to move data from source to Raw to Enriched. By having an Azure Data Factory per Data Integration resource group we can enable a complete Continuos Integration(CI) and Continuos Development(CD) experience by only allowing pipelines to be deployed from Azure DevOps or GitHub.

All Azure Data Factory workspaces will predominately use the Managed VNET feature in ADF or [Self-Hosted Integration Runtime](/azure/data-factory/concepts-integration-runtime) for their Data Landing Zone within the Data Management Landing Zone. Engineers are encouraged to use the managed VNET feature to securely connect to Azure PaaS resource.

However, it will be possible to create additional integration runtimes to ingest from on-premises, third-party clouds, and third-party SaaS data sources.

>[!TIP]
>By deploying a [Self-Hosted Integration Runtime](/azure/data-factory/concepts-integration-runtime) in the Data Management Data Landing Zone, you can approve the IP range required to connect to on-premises or third-party cloud sources.

## Azure Databricks Ingest Considerations

This guidance builds on top of:

- [Securing access to Azure Data Lake Gen 2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)
- [Azure Databricks Implementation](azure-databricks-implementation.md)

A single premium **Azure Databricks Data Engineering** Workspace should be deployed per Data Landing Zone in the production Ingest and Processing resource group. This will enable a complete CI/CD experience and only allow notebooks to be deployed from Azure DevOps or GitHub.

For Development we would expect Integration Ops Teams to have their own Databricks environments before checking in code to be deployed to the single Azure Databricks workspace in both Test and Production.

The test and production workspaces will be locked off to users, and only managed identity/service principals will have access to it. All workspace management will be handled via Rest API.

Azure Data Factory in the Data Integrations Resource Group should provide the orchestration for calling Azure Databricks jobs.

The Data Lakes will be mounted into this workspace using service principals. See [Access via Service Principal](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md#pattern-1---access-via-service-principal).

Integration Ops teams can deploy short, automated jobs on Databricks and expect their clusters to start quickly, execute the job, and terminate. Databricks Pools are recommended to be setup to reduce the time it takes for clusters to spin up for jobs.

Pipeline created by the Integration Ops teams in Azure Databricks can take data from SOURCE to RAW to ENRICH  to CURATED. Data Integrations must deploy their notebooks via a Integration Ops repo using the Integration Ops Service Principle which was created when onboarding their Data Integration. The notebook is called from the Data Integration resource group Azure Data Factory.

It is recommended that enterprises use Azure DevOps to implement a deployment framework for new pipelines which create the dataset folders, assign ACLs, and create a table with or without Databricks Table Access Controls enforced.

## Stream Ingestion

Organizations may have to support situations where publishers generate high-velocity event streams. For this pattern, a message queue is recommended (*e.g.* Event Hubs or IoT Hub) that can ingest these streams.

Both Event Hubs and IoT Hub are scalable event processing services that can ingest and process large volumes of events and data with low latency and high reliability. Event Hubs is designed as a big data streaming and event ingestion service, whereas IoT Hub is a managed service that acts as a central message hub for bi-directional communication between your IoT application and the devices it manages.

From that point, data can either be exported out to a data lake at regular intervals (batch) and processed in near-real-time via Spark streaming (using Azure Databricks), Azure Data Explorer, Azure Stream Analytics, or Time Series Insights.

The last Event Hub or Kafka Landing Zone, inside the use case specific Landing Zone, should send its aggregated data to both the Data Lake RAW layer in one of the Data Landing Zones and/or to an Event Hub related to the Data Integration resource group in the Data Landing Zone.

## Enforcing Data Quality

As data is ingested, data quality checks should be implemented as close to the sources and before downstream subscribers make use of the datasets. In the case of batch ingestion from the the data lake, these checks should be done when moving from the Raw to Enriched.

![Implementing Data Quality during ingestion](./images/adls-dq.png)

Figure 2: Implementing Data Quality during ingestion

Figure 2 illustrates the process of data moving through integrity and data quality into the curated layer.

- Before data is moved into the Enriched Layer, its schema and columns are checked against the metadata registered in the data catalog.
  - If the data contains errors, the load will be aborted, and Integration Ops should be notified of the failure.
  - If the schema and column checks pass, the data is loaded into the enriched layers with conformed data types.
- Before moving into the Enriched layer, a Data Quality process checks for duplicate data, NULL values, and data type compliance. Integration Ops can configure additional checks. Any violations are reported to Integration Ops.

## Ingestion Monitoring

The out-of-the-box [Azure Data Factory pipeline monitoring](/azure/data-factory/monitor-visually) will be used for monitoring and troubleshooting the exceptions from the Azure Data Factory pipelines. It reduces the effort on developing a custom monitoring and reporting solution.

The in-built monitoring is one of the primary reasons to use Azure Data Factory as the main orchestration tool. The creation can be automated using Azure Policy.

## Data Sources Mapping to Service

The tables below map out the Ingestion and Processing Services to the common sources which typically need to be ingested or egested from Azure.

| ID | Mechanism                   | Note                           |
|----|-----------------------------|--------------------------------|
| A  | Azure Data Factory          | Built-in and generic (ODBC, SFTP, REST) connectors |
| B  | Azure Databricks            | Custom code (JDBC, jar, *etc.*)   |
| C  | Third Party                   | Wandisco, Attunity, GoldenGate |
| D  | Other                       | *e.g.* native capability         |
| E  | Power Platform + Logic Apps | Power Automate connectors      |

Table 6: Ingestion Services

| Provider | Type | Hosted | Category | Notes | Full Load Ingest | Incr. Load Ingest | Real-Time Ingest | Full Load Egress | Incr. Load Egress | Real-Time Egress |
|--|--|--|--|--|--|--|--|--|--|--|
| Oracle | Tabular | IaaS | Database | GoldenGate to ADLS | A, B | A, B | C | A, B | A, B | C |
| SQL Server | Tabular | IaaS | Database | SLT+Attunity | A, B | A, B | C, D2 | A, B | A, B | C, D2 |
| MySQL | Tabular | IaaS | Database | SLT+Attunity | A, B | A, B | C, D2 | A, B | A, B | C, D2 |
| SAP BW | Tabular | IaaS | Database | SLT+Attunity | A, B, C, D | A, B, C, D | C | - | - | - |
| SAP HANA | Tabular | IaaS | Database | SLT+Attunity | A, B, C, D | A, B, C, D | C | A, B | A, B | - |
| Impala | Tabular | IaaS | Database | - | A, B | A, B | - | B | B | - |
| SharePoint | List | SaaS | Record Store | - | A, E | A, E | E | A, E | A, E | E |
| REST | REST | Various | REST | XML, JSON, CSV | A, B, E | A, B, E | A, B, E | A, B, E | A, B, E | A, B, E |
| Outlook | Email | SaaS | REST | XML, JSON, CSV | E | E | E | E | E | E |

Table 7: Data Sources Mapping to Service

Depending on the destination, Azure Data Migration service can replicate from on-premises and third-party databases (*e.g.* SQL Server, Postgres, MySQL, or Oracle) to an Azure-based data store.
