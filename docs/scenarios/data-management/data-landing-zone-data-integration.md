---
title: Azure Enterprise Scale Analytics and AI Integrations
description: Enterprise Scale Analytics and AI Integrations
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Integrations



Previously, we explained the role of Integrations Ops under [Integration Ops (per domain)](persona-and-teams.md#integration-ops-per-domain)

This section explains the infrastructure which is deployed for each Integration inside a Data Landing Zone.

## Overview

![Integrations](./images/integration-resource-group.png)

*Figure 1: Integration Resource Group*

For each Integration in a Data Landing Zone, we will create:

* An Azure Key Vault.
* An Azure Data Factory for running developed engineering pipelines to transform from Raw to Enriched.
* A Integration security user group which we use to give access to the Azure Databricks Analytics and Data Science workspace.
* A Service Principal which is used by the Integration for deploying ingest jobs to the Azure Databricks Engineering workspace.

Additional services such as Event Hubs, IoT Hubs, Stream Insight, and Machine Learning can optionally be created.

This leads to a Resource Group per external integration.

>[!NOTE]
>A Data Integration is responsible for data ingestion and enrichment only, our prescribed view is to deploy Azure Data Factory instead of Azure Synapse Analytics workspace. Our adopted policy is to reduce the surface area to required features. Azure Synapse Analytics is more suited to our data product layer.

## Azure Key Vault

Enterprise Scale Analytics and AI will make use of Azure Key Vault functionality and store secrets within Azure whenever possible.

Each Data Landing Zone will have an Azure Key Vault per Integration. This functionality will ensure that encryption key, secret, and certificate derivation meet the requirements of the environment. This is to allow better separation of administrative duties and reduce risk associated with mixing keys, secrets of differing classifications, and Integrations.


>[!IMPORTANT]
>Integration-specific key vaults should follow the least-privilege model and avoid secret sharing across environments as well as transaction scale limits.

## Azure Data Factory

An Azure Data Factory will be deployed to allow pipelines written by the Integration Ops team to take data from Raw to Enriched using developed pipelines. We prescribe using Mapping Data Flows for transformations and breaking out to use **Azure Databricks Engineering Workspace** for complex transformations.

## Event Hubs (Optional)

If the Integration has a requirement to stream data in, it is possible to deploy downstream Event Hubs in the Integrations resource group.

## Configuration specific to Databricks of adding a Integration to a Data Landing Zone

![Adding Permissions to Databricks Workspaces](./images/adding-permissions-databricks-workspaces.png)

*Figure 2: Adding Permissions to Databricks Workspaces*

Figure 2 shows the subprocess of adding a Integration to a pre-existing Azure Databricks workspaces within the Data Landing Zone. The subprocess adds the security groups to the Azure Enterprise Application and then into the workspace. The Integration Service Principal PAT is stored in an Azure Key Vault-backed scope in the Integration for use with the developed engineering pipelines.

### Azure Databricks Engineering Workspace Process

1. Add the Integration Service Principal to the workspace.
1. Obtain the Personal Access Token (PAT) for the Integration's Service Principal to be used with tools such as Azure Data Factory.
1. Store the PAT in the Integration Key Vault.
1. Assign the Integration Service Principal access to the Cluster Policies.
1. Assign appropriate workspace permissions to Integration Service Principal.

### Azure Databricks Analytics and Data Science Workspace Process

1. Add the Integration Azure AD Groups to the workspace Azure AD Enterprise Application.
1. Wait for Azure AD Enterprise Application to sync with Azure Databricks.
1. Add Integration Engineering Azure AD Group to the workspace.
1. Assign the Integration Azure AD Groups access to the Cluster Policies.
1. Assign appropriate workspace permissions to Integration Azure AD Groups.

>[!NOTE]
>The Integration Engineering Azure AD Group allows read/write access, and the Integration User Azure AD Group should allow read-only access.
