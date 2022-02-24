---
title: Data management and analytics scenario data applications (source-aligned)
description: Learn about data management and analytics scenario data applications (source-aligned) in Azure.
author: mboswell
ms.author: mboswell
ms.date: 02/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data applications (source-aligned)

In the case where you've chosen not to implement a data agnostics engine, for ingesting once from operational sources, or complex connections aren't facilitated in the data agnostics engine, you would create a data application which is source aligned. It should follow the same flow as the data agnostics engine would for ingesting data from external data sources.

## Overview

This application resource group would responsible for data ingestion and enrichment only from external sources such a telemetry, finance, and CRM. This layer can operate in both real-time, batch and micro-batch.

This section explains the infrastructure that's deployed for each Data applications (source-aligned) resource group inside a data landing zone.

> [!TIP]
> For data mesh you could chose to deploy one of these per source or one per domain. The standards of data standardization, quality and lineage must still be followed. It is recommended that the Data platform ops teams develop snippets of standard code which can be called to achieve this.

:::image type="content" source="../images/data-application-source-aligned.png" alt-text="Data application  (source-aligned) resource group":::

For each data application (source-aligned) resource group in a data landing zone, you should create:

- An Azure Key Vault.
- An Azure Data Factory for running developed engineering pipelines to transform from raw to enriched.
- If using Azure Databricks, a service principal used by the data application (source-aligned) for deploying ingest jobs to the Azure Databricks (ingest)

Instances of other services such as Azure Event Hubs, Azure IoT Hub, Azure Stream Analytics, and Azure Machine Learning can optionally be created.

> [!NOTE]
> To enforce the standard of delta lake, you will have to use a spark engine such as Azure Synapse Spark or Azure Databricks.
>
> If you decide to use Azure Databricks then we would recommend deploying Azure Data Factory instead of Azure Synapse Analytics workspace,. This would reduce the surface area to required features.
>
> However, if you need an all encompassing development area with pipelines and spark then use Azure Synapse Analytics. A policy should be applied to only allow the use of Spark and Pipelines to avoid data silo's being created in an Azure Synapse SQL Pool.

## Azure Key Vault

Data management and analytics scenario will make use of Azure Key Vault functionality and store secrets within Azure whenever possible.

Each data application (source-aligned) resource group or data domain (if mesh) will have an Azure Key Vault. This functionality will ensure that encryption key, secret, and certificate derivation meet the requirements of the environment. This is to allow better separation of administrative duties and reduce risk associated with mixing keys, secrets of differing classifications, and integrations.

All keys relating to the data application (source-aligned) should be held in this Azure Key Vault.

> [!IMPORTANT]
> Data application (source-aligned) key vaults should follow the least-privilege model and avoid secret sharing across environments as well as transaction scale limits.

## Azure Data Factory

An Azure Data Factory will be deployed to allow pipelines written by the data application team to take data from raw to enriched using developed pipelines. We prescribe using mapping data flows for transformations and breaking out to use Azure Databricks (ingest) workspace or Azure Synapse Spark for complex transformations.

It should be connected to the DevOps instance of the data application team repo responsible for the data application (source-aligned) to allow CI/CD deployments.

## Event Hubs

If the data application (source-aligned)n has a requirement to stream data in, it's possible to deploy downstream Event Hubs in the Data application (source-aligned) resource group.

## Next steps

[Data Application Reference Patterns](data-reference-patterns.md)
