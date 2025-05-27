---
title: Cloud-scale analytics data applications (source-aligned)
description: Learn about cloud-scale analytics data applications (source-aligned) in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data applications (source-aligned)

If you choose not to implement a data agnostic engine for ingesting data once from operational sources, or if complex connections aren't facilitated in your data agnostic engine, you should create a data application that is source-aligned. It should follow the same flow as a data agnostic engine would when ingesting data from external data sources.

## Overview

Your application resource group is responsible for data ingestion and enrichment only from external sources, such as telemetry, finance, or CRM. This layer can operate in real-time, batch, and micro-batch.

This section explains the infrastructure deployed for each data application (source-aligned) resource group inside your data landing zone.

> [!TIP]
> For data mesh, you can choose to deploy one of these per source or one per domain. The principles of data standardization, data quality, and data lineage must still be followed. Data platform ops teams can develop snippets of standard code and call upon them to achieve this.

For each data application (source-aligned) resource group in your data landing zone, you should create:

- An Azure Key Vault
- An Azure Data Factory to run developed engineering pipelines that transform data from raw to enriched
- A service principal used by the data application (source-aligned) for deploying ingest jobs to Azure Databricks (only if using Azure Databricks)

You can also create instances of other services, such as Azure Event Hubs, Azure IoT Hub, Azure Stream Analytics, and Azure Machine Learning.

## Azure Key Vault

Use Azure Key Vault functionality to store secrets within Azure whenever possible.

Each data application (source-aligned) resource group or data domain (if mesh) has an Azure Key Vault which:

- Ensures that the encryption key, secret, and certificate derivation meet the requirements of your environment
- Allows better separation of administrative duties
- Reduces the risk of mixing keys, integrations, and secrets of differing classifications

All keys related to your data application (source-aligned) should be contained in your Azure Key Vault.

> [!IMPORTANT]
> Data application (source-aligned) key vaults should follow the least-privilege model and should avoid both transaction scale limits and secret-sharing across environments.

## Azure Data Factory

Deploy an Azure Data Factory to allow pipelines written by your data application team to take data from raw to enriched using developed pipelines. Use mapping data flows for transformations, and break out to use either Azure Databricks, Azure Synapse Spark, or Microsoft Fabric for complex transformations.

You should connect Azure Data Factory to the DevOps instance of your data application (source-aligned) repo. This connection allows CI/CD deployments.

## Event Hubs

If your data application (source-aligned) has a requirement to stream data in, you can deploy downstream Event Hubs in your data application (source-aligned) resource group.

## Next steps

[Data application reference patterns](data-reference-patterns.md)
