---
title: The ingest process with cloud-scale analytics in Azure
description: Understand the ingest process with cloud-scale analytics in Azure.
author: mboswell
ms.author: mboswell
ms.date: 12/03/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# The ingest process with cloud-scale analytics in Azure

Azure provides several services to ingest and release data to native and third-party platforms. Different services can be used, depending on volume, velocity, variety, and direction. Some of these services are:

- [Azure Data Factory](/azure/data-factory/introduction) is a service built for all data application (source-aligned) needs and skill levels. Write your own code or construct, extract, load, and transform processes within the intuitive visual environment and without code. With more than 90+ natively built and maintenance-free connectors, visually integrate data sources at no added cost. Engineers can use private endpoints and link services to securely connect to Azure platform as a service (PaaS) resources without using the PaaS resource's public endpoints. Engineers can use integration runtimes to extend pipelines to third-party environments like on-premises data sources and other clouds.

Some of these connectors support being used as a source (read) or as a sink (write). Azure native services, Oracle, SAP, and others can be used as source or sink, but not all connectors support it. In these cases, you can use generic connectors like Open Database Connectivity (ODBC), the file system, or SSH File Transfer Protocol (SFTP) connectors.

- [Azure Databricks](/azure/databricks/) is a fast, easy, and collaborative Apache-Spark-based analytics service. For a big data pipeline, you can ingest the data (raw or structured) into Azure through Data Factory in batches or streamed in almost real time with Apache Kafka, Azure Event Hubs, or IoT Hub. This data lands in a data lake for long-term, persisted storage in Azure Data Lake Storage. Azure Databricks can read data from multiple data sources as part of the workflow.

- The Microsoft Power Platform provides [connectors to hundreds of services](/connectors/connector-reference/) that can be event-, schedule-, or push-driven. Microsoft Power Automate can act on events and trigger workflows optimized for single records or small data volumes.

Proprietary native and third-party tooling provides niche capabilities to integrate with specialized systems and near-real-time replication.

- [Azure Data Share](/azure/data-share/) supports organizations to securely share data with multiple external customers and partners. After you create a data share account and add data products, customers and partners can be invited to the data share. Data providers are always in control of the data that they've shared. Azure Data Share makes it simple to manage and monitor what data is shared, when it was shared, and who shared it.

> [!IMPORTANT]
> Every data landing zone can have an [data ingestion resource group](../architectures/data-landing-zone.md#data-ingestion) that exists for businesses with an data agnostic ingestion engine. If you don't have this framework engine, the only recommended resource is deploying an Azure Databricks analytics workspace, which would be used by data integrations to run complex ingestion. See the [data agnostic ingestion engine](./automated-ingestion-pattern.md) for potential automation patterns.

## Ingest considerations for Azure Data Factory

If you have an data agnostic ingestion engine, you should deploy a single Data Factory for each data landing zone in the data ingestion resource group. The Data Factory workspace should be locked off to users, and only managed identity and service principals will have access to deploy. Data landing zone operations should have read access to allow pipeline debugging.

Data application can have there own Data Factory for data movement. Having a Data Factory in each data application resource group supports a complete continuous integration (CI) and continuous deployment (CD) experience by only allowing pipelines to be deployed from Azure DevOps or GitHub.

All Data Factory workspaces will mostly use the managed virtual network (VNet) feature in Data Factory or [self-hosted integration runtime](/azure/data-factory/concepts-integration-runtime) for their data landing zone within the data management landing zone. Engineers are encouraged to use the managed VNet feature to securely connect to the Azure PaaS resource.

However, it's possible to create more integration runtimes to ingest from on-premises, third-party clouds, and third-party software-as-a-service (SaaS) data sources.

## Ingest considerations for Azure Databricks

This guidance elaborates on the information within:

- [Securing access to Azure Data Lake Storage Gen2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks best practices](/azure/databricks/getting-started/best-practices)

- For development, integration operations should have their own Azure Databricks environments before checking in code to be deployed to the single Azure Databricks workspace during testing and production.

- Data Factory in the data application (source-aligned) resource group should provide the framework for calling Azure Databricks jobs.

- Data applications teams can deploy short, automated jobs on Azure Databricks and expect their clusters to start quickly, execute the job, and terminate. It's recommended to set up Azure Databricks pools to reduce the time it takes for clusters to spin up for jobs.

- We recommend organizations use Azure DevOps to implement a deployment framework for new pipelines. The framework will be used to create the dataset folders, assign access control lists, and create a table with or without enforcing Databricks table access controls.

## Stream ingestion

Organizations might need to support scenarios where publishers generate high-velocity event streams. For this pattern, a message queue is recommended, for example, Event Hubs or IoT Hub, to ingest these streams.

Event Hubs and IoT Hub are scalable event processing services that can ingest and process large event volumes and data with low latency and high reliability. Event Hubs is designed as a big data streaming and event ingestion service. IoT Hub is a managed service that serves as a central message hub for bidirectional communication between an IoT application and the devices it manages. From there, data can either be exported to a data lake at regular intervals (batch) and processed with Azure Databricks in near-real-time via Apache Spark Streaming, Azure Data Explorer, Stream Analytics, or Time Series Insights.

The last Event Hubs or Apache Kafka landing zone inside the use case's specific landing zone should send its aggregated data to the data lake's raw layer in one of the data landing zones and to Event Hubs related to the data application (source-aligned) resource group in the data landing zone.

## Monitor ingestion

Out-of-the-box [Azure Data Factory pipeline monitoring](/azure/data-factory/monitor-visually) can be used to monitor and troubleshoot the exceptions from the Data Factory pipelines. It reduces the effort of developing a custom monitoring and reporting solution.

Built-in monitoring is one of the main reasons to use Azure Data Factory as a main orchestration tool, and Azure Policy can help to automate this setup.

## Next steps

[SAP ingestion with cloud-scale analytics in Azure](sap-data-ingestion.md)
