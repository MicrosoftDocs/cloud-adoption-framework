---
title: Enterprise Scale Analytics and AI Databricks Pattern in Azure
description: Enterprise Scale Analytics and AI Databricks Pattern
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Databricks Implementation

Azure Databricks is a data analytics platform optimized for the Microsoft Azure cloud services platform. Azure Databricks offers two environments for developing data intensive applications: Azure Databricks SQL Analytics and Azure Databricks Workspace.

For the purpose of Enterprise Scale Analytics and AI, we have focused on Azure Databricks Workspaces. As Azure Databricks SQL Analytics moves to General Availability we will focus on how this can be integrated into the Enterprise Scale Analytics and AI construction set.

## Overview

For every Data Landing Zone deployed, two shared Azure Databricks Workspaces will be created.

1. An Azure Databricks Workspace is provisioned for Ingestion and Processing which will connect to Azure Data Lake via Azure Service Principals. This is referred to as **Azure Databricks Engineering Workspace**.
2. An Azure Databricks Workspace is provisioned for all Data Scientists and Data Ops which will connect to the Azure Data Lake using AAD Passthrough. This is referred to as **Azure Databricks Analytics and Data Science Workspace**.

The **Azure Databricks Analytics and Data Science Workspace** is shared across the whole Data Landing Zone, with all users which have been given access to the Workspace. These workspaces should not be used for Data Ingestion, Transformation, and Load &mdash; the **Azure Databricks Engineering Workspace** should be used for this instead.

If you have an automated ingestion framework engine, the **Azure Databricks Engineering Workspace** will use both an Azure Key Vault created in the Metadata Services Resource group, data ingestion pipelines from RAW into ENRICHED and an Azure Key Vault, per Data Integration, for running developed engineering pipelines to transform from Raw to Enriched.

If you don't have an automated ingestion framework engine, the **Azure Databricks Engineering Workspace** will use just the Azure Key Vault, per Data Integration, for running developed engineering pipelines to transform from Raw to Enriched.

The **Azure Databricks Data Engineering Workspace** should use Service Principals to access Data Lakes.

>[!NOTE]
>Automated ingestion framework engine refers to the case where you have developed an automated solution for registering and ingesting data which in turn drives an Azure Data Factory or other ETL product. A developed pipeline is where Integration Ops has had to write the pipeline, end-to-end, in Azure Data Factory or another ETL product.

The **Azure Databricks Analytics and Data Science** workspace should have Cluster Policies which require creation of High-Concurrency Clusters. This type of cluster will allow the Data Lakes to be explored using AAD Credential passthrough. See [AAD Credential passthrough](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md#pattern-3---aad-credential-passthrough).

## Azure Databricks Configuration

The Azure Databricks deployment is part parameter based, via an ARM template and YAML scripts, but also requires some manual intervention to complete the configuration of ALL Workspaces.

All Azure Databricks Workspaces should use the Premium Plan, which provides the following required features:

* Optimized autoscaling of compute
* Azure AD credential passthrough
* Conditional authentication
* Role-based access control for notebooks, clusters, jobs, tables
* Audit Logs

To align to the Enterprise Scale Analytics and AI construction set, we recommend that **ALL** Workspaces have the following default deployment options configured:

* The Azure Databricks Workspaces should connect to an external Hive Metastore which resides in the Data Landing Zone.
* Each Workspace should be configured to send Databricks Diagnostic Logging to Azure Log Analytics.
* Cluster Policies should be implemented to limit the ability to create clusters based on a set of rules. See [Manage Cluster Policies](/azure/databricks/administration-guide/clusters/policies).
  * Multiple cluster policies will be defined which each target group as part of onboarding process would be assigned permissions to use by the Data Landing Zone Ops. By default, cluster creation permission will be denied to all of the users except Data Landing Zone Ops team, but permission to use cluster policies will be given to different teams/groups.
  * We recommend that Cluster Policies are used in combination with Azure Databricks Pools to reduce cluster start and auto-scaling times by maintaining a set of idle, ready-to-use instances. See [Pools](/azure/databricks/clusters/instance-pools/)
* All Azure Databricks operational secrets such as SPN credentials and connection strings should be retrieved from Azure Key Vaults.
* Configure a separate Enterprise Application, per workspace, for use with SCIM (System for Cross-Domain Identity Management) and link to Azure Databricks Workspace to control access and permissions to each Azure Databricks Workspace. See [Provision users and groups using SCIM](/azure/databricks/administration-guide/users-groups/scim/) and [Configure SCIM provisioning for Microsoft Azure Active Directory](/azure/databricks/administration-guide/users-groups/scim/aad).

>[!WARNING]
>Failure to configure the Azure Databricks Workspaces to use the Azure Databricks SCIM interface will impact how you provide security controls. It will move from automated to a manual process and break all deployment CI/CD pipelines.

The following Access Control options are set for **ALL** Databricks Workspaces.

1. Workspace Visibility Control: Enabled (default: Disabled)
2. Cluster Visibility Control: Enabled (default: Disabled)
3. Job Visibility Control: Enabled (default: Disabled)

Depending on your use case you might wish to enable the following options for the **Azure Databricks Analytics and Data Science** workspace:

1. Notebook Exporting: Disabled (default: Enabled)
2. Notebook Table Clipboard Features: Disabled (default: Enabled)
3. Table Access Control: Enabled (default: Disabled)
4. Azure Active Directory Conditional Access

## Azure Databricks Deployment

The two Azure Databricks Workspaces are deployed as part of a new Data Landing Zone deployment. Figure 1 shows the overall workflow of deploying an Azure Databricks environment in Enterprise Scale Analytics and AI.

![Azure Databricks Deployment into a Data Landing Zone](./images/databricks-deploy.png)

Figure 1: Azure Databricks Deployment into a Data Landing Zone

1. At the start of the provisioning process, it will check to see if the Hive Metastore exists in the Data Landing Zone
   * If it fails to find the Hive Metastore, it will quit and raise an error.
2. Upon successfully finding the Hive Metastore, the process of creating a workspace is initiated.
3. After the workspace has been created, the process should check for a Log Analytics workspace in the Data Landing Zone.
   * If it fails to find the Log Analytics workspace, it will quit and raise an error.
4. For each workspace it will create an Azure AD Application and configure SCIM.

For the **Azure Databricks Engineering Workspace**:

1. It will configure the workspace with the service principal access.
2. Deploy Data Engineering Policies which have been defined by the Data Platform Ops.
3. If the Data Landing Zone Ops team has requested Databricks Pools or Clusters, these can be integrated into the deployment process.
4. Enable workspace options specific to **Azure Databricks Engineering Workspace**.

For **Azure Databricks Analytics and Data Science**:

1. Deploy Data Analytic Policies which have been defined by the Data Platform Ops team.
2. Data Landing Zone Ops have requested Databricks Pools or Clusters, these can be integrated into the deployment process.
3. Enable workspace options specific to **Azure Databricks Engineering Workspace**.

>[!NOTE]
>During the creation of a new Data Integration we will alter the configuration of all Azure Databricks Workspaces within a Data Landing Zone. Please see [Data Integration & Data Product Deployment Process](platform-provisioning.md#data-integration--data-product-deployment-process) for how this is implemented with Azure Databricks shared Workspaces.

### External Hive Metastore

In a deployment of an Azure Databricks workspace:

* A global init script is created that will configure Hive metastore settings for all clusters. This script is managed by the new
[Global Init Scripts](https://docs.databricks.com/clusters/init-scripts.html#global-init-scripts) API.
As of January, 2021, the new global init scripts API is in public preview. However, Microsoft's official position is that public preview features in Azure Databricks are ready for production environments and are supported by the Support Team. For more details, see:
[Azure Databricks Preview Releases](/azure/databricks/release-notes/release-types)
* This solution uses [Azure Database for MySQL](https://azure.microsoft.com/services/mysql/) to store the Hive metastore. This database was chosen for its cost effectiveness and its high compatibility with Hive.

## Further Reading

The Enterprise Scale Analytics and AI takes into account the following best practices for integrating Azure Databricks into the solution pattern:

* [Securing access to Azure Data Lake Gen 2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
* [Azure Databricks Best Practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)
