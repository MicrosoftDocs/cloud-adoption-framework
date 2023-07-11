---
title: Cloud-scale analytics data applications (source-aligned)
description: Learn about cloud-scale analytics data applications (source-aligned) in Azure.
author: mboswell
ms.author: mboswell
ms.date: 03/18/2022
ms.topic: conceptual
s.custom: e2e-data-management, think-tank
---

# Data applications (source-aligned)

If you've chosen not to implement a data agnostics engine for ingesting data once from operational sources, or if complex connections aren't facilitated in your data agnostics engine, you should create a data application that is source aligned. It should follow the same flow as a data agnostics engine would when ingesting data from external data sources.

## Overview

Your application resource group is responsible for data ingestion and enrichment only from external sources, such as telemetry, finance, or CRM. This layer can operate in real-time, batch and micro-batch.

This section explains the infrastructure deployed for each data applications (source-aligned) resource group inside your data landing zone.

> [!TIP]
> For data mesh, you can chose to deploy one of these per source or one per domain. The principles of data standardization, data quality, and data lineage must still be followed. Data platform ops teams can develop snippets of standard code and call upon them to achieve this.

:::image type="content" source="../media/data-application-source-aligned.png" alt-text="Data application (source-aligned) resource group":::

For each data application (source-aligned) resource group in your data landing zone, you should create:

- An Azure Key Vault
- An Azure Data Factory, to run developed engineering pipelines that transform data from raw to enriched
- A service principal used by the data application (source-aligned) for deploying ingest jobs to the Azure Databricks (only if using Azure Databricks)

You can also create instances of other services, such as Azure Event Hubs, Azure IoT Hub, Azure Stream Analytics, and Azure Machine Learning.

> [!NOTE]
>You need to use a spark engine like Azure Synapse Spark or Azure Databricks to enforce the delta lake standard.
>
> If you decide to use Azure Databricks, we recommend deploying Azure Data Factory rather than Azure Synapse Analytics workspace to reduce the surface area to only required features.
>
> However, if you need an all-encompassing development area with pipelines and spark, use Azure Synapse Analytics. Apply a policy to only allow the use of spark and pipelines so you avoid creating silos in an Azure Synapse SQL pool.

## Azure Key Vault

Use Azure Key Vault functionality to store secrets within Azure whenever possible.

Each data application (source-aligned) resource group or data domain (if mesh) will have an Azure Key Vault. This ensures that the encryption key, secret, and certificate derivation meet the requirements of your environment. This allows better separation of administrative duties and also reduces the risk of mixing keys, integrations, and secrets of differing classifications.

All keys relating to your data application (source-aligned) should be contained in your Azure Key Vault.

> [!IMPORTANT]
> Data application (source-aligned) key vaults should follow the least-privilege model and should avoid both transaction scale limits and secret-sharing across environments.

## Azure Data Factory

Deploy an Azure Data Factory to allow pipelines written by your data application team to take data from raw to enriched using developed pipelines. Use mapping data flows for transformations, and break out to use Azure Databricks (ingest) workspace or Azure Synapse Spark for complex transformations.

You should connect Azure Data Factory to the DevOps instance of your data application (source-aligned) repo. This connection allows CI/CD deployments.

## Event Hubs

If your data application (source-aligned) has a requirement to stream data in, you can deploy downstream Event Hubs in your data application (source-aligned) resource group.

## Next steps

[Data application reference patterns](data-reference-patterns.md)
