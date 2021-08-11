---
title: Enterprise-scale for analytics and AI Azure Databricks pattern
description: Learn about the enterprise-scale for analytics and AI Azure Databricks pattern.
author: mboswell
ms.author: mboswell
ms.date: 07/30/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Implement Azure Databricks

Azure Databricks is a data analytics platform optimized for the Microsoft Azure Cloud Services platform. Azure Databricks offers two environments for developing data-intensive applications: Azure Databricks SQL Analytics and Azure Databricks workspace.

For enterprise-scale for analytics and AI, we'll focus on Azure Databricks workspace.

## Overview

For every data landing zone you deploy, two shared workspaces are created.

- The Azure Databricks Engineering workspace is for ingestion and processing. This workspace connects to Azure Data Lake via Azure service principals.
- The Azure Databricks Analytics and Data Science workspace is provisioned for all data scientists and data operations teams. This workspace connects to Azure Data Lake by using Azure Active Directory (Azure AD) Pass-through Authentication. You share the Azure Databricks analytics and data science workspace across the data landing zone with all users who have access to the workspace. Don't use this workspace for data ingestion, transformation, or load. Use the Azure Databricks engineering workspace instead.

If you have an automated ingestion framework engine, the Azure Databricks engineering workspace uses both an Azure Key Vault instance created in the Azure metadata service resource group for running data ingestion pipelines from **raw** into **enriched** and an Azure Key Vault instance created in the data integration resource group for running developed engineering pipelines to transform from **raw** to **enriched**.

If you don't have an automated ingestion framework engine, the Azure Databricks engineering workspace uses only the Azure Key Vault instance created in the data integration resource group for running developed engineering pipelines to transform from **raw** to **enriched**.

> [!NOTE]
> An automated ingestion framework engine is one in which you've developed an automated solution to register and ingest data that drives Azure Data Factory or another extract, transform, load (ETL) product. For a developed pipeline, an integration operations team wrote the pipeline end-to-end in Azure Data Factory or another ETL product.

The Azure Databricks analytics and data science workspace should have cluster policies that require you to create high concurrency clusters. This type of cluster allows data lake to be explored by using Azure AD credential pass-through. For more information, see [Azure AD credential pass-through](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md#pattern-3---aad-credential-passthrough).

## Configure Azure Databricks

The Azure Databricks deployment is partly parameter-based via an Azure Resource Manager template and YAML scripts, but it also requires some manual intervention to configure all workspaces.

All Azure Databricks workspaces should use the premium plan, which provides the following required features:

- Optimized autoscaling of compute
- Azure AD credential pass-through authentication
- Conditional authentication
- Role-based access control for notebooks, clusters, jobs, and tables
- Audit logs

To align to enterprise-scale for analytics and AI, we recommend that all workspaces have the following default deployment options configured:

- The Azure Databricks workspaces connects to an external Apache Hive metastore instance in the data landing zone.
- Configure each workspace to send Databricks diagnostic logging to Azure Log Analytics.
- Implement cluster policies to limit the ability to create clusters based on a set of rules. For more information, see [Manage cluster policies](/azure/databricks/administration-guide/clusters/policies).
  - Define multiple cluster policies. As part of the onboarding process, assign each target group permission to use by the data landing zone operations team. By default, cluster creation permission is given only to the operations team. Different teams or groups are given permission to use cluster policies.
  - Use cluster policies in combination with Azure Databricks pools to reduce cluster start and autoscaling times by maintaining a set of idle, ready-to-use instances. For more information, see [Pools](/azure/databricks/clusters/instance-pools/).
- Retrieve all Azure Databricks operational secrets, such as SPN credentials and connection strings, from an Azure Key Vault instance.
- Configure a separate enterprise application per workspace for use with SCIM (system for cross-domain identity management). Link to Azure Databricks workspace to control access and permissions to each workspace. For more information, see [Provision users and groups using SCIM](/azure/databricks/administration-guide/users-groups/scim/) and [configure SCIM provisioning for Microsoft Azure Active Directory](/azure/databricks/administration-guide/users-groups/scim/aad).

> [!WARNING]
> Failure to configure Azure Databricks workspace to use the Azure Databricks SCIM interface impacts how you provide security controls. It moves from an automated to a manual process and breaks all deployment CI/CD pipelines.

The following access control options are set for all Databricks workspaces:

- Workspace visibility control: enabled (default: disabled)
- Cluster visibility control: enabled (default: disabled)
- Job visibility control: enabled (default: disabled)

You might want to enable the following options for the Azure Databricks analytics and data science workspace:

- Notebook exporting: disabled (default: enabled)
- Notebook table clipboard features: disabled (default: enabled)
- Table access control: enabled (default: disabled)
- Azure Active Directory Conditional Access

## Deploy Azure Databricks

The two Azure Databricks workspaces are deployed as part of a new data landing zone deployment. This following image shows the workflow of deploying an Azure Databricks environment in enterprise-scale for analytics and AI.

![Diagram of of Azure Databricks deployment into a data landing zone.](../images/databricks-deploy.png)

1. The provisioning process first makes sure an Apache Hive metastore instance exists in the data landing zone. If it fails to find Apache Hive metastore, it quits and raises an error.
2. Upon successfully finding Apache Hive metastore, a workspace is created.
3. The process checks for a Log Analytics workspace in the data landing zone. If it fails to find the Log Analytics workspace, it quits and raises an error.
4. For each workspace, it creates an Azure AD application and configures SCIM.

For the Azure Databricks engineering workspace:

1. The process configures the workspace with the service principal access.
2. Data engineering policies that were defined by the data platform operations team are deployed.
3. If the data landing zone operations team has requested Databricks pools or clusters, they can be integrated into the deployment process.
4. It enables workspace options specific to the Azure Databricks engineering workspace.

For the Azure Databricks analytics and data science workspace:

1. The process deploys data analytic policies that were defined by the data platform operations team.
2. If the data landing zone operations team has requested Databricks pools or clusters, they can be integrated into the deployment process.
3. It enables workspace options specific to the Azure Databricks engineering workspace.

> [!NOTE]
> During the creation of a new data integration resource group, we'll alter the configuration of all Azure Databricks workspaces within a data landing zone. See [Data integration and data product deployment process](../eslz-provision-platform.md#data-integration-and-data-product-deployment-process) for how this is implemented with Azure Databricks shared workspaces.

### External Hive metastore

In an Azure Databricks workspace deployment:

- A new global init script configures Apache Hive metastore settings for all clusters. This script is managed by the new [global init scripts](https://docs.databricks.com/clusters/init-scripts.html#global-init-scripts) API.

The new global init scripts API is in public preview. Public preview features in Azure Databricks are ready for production environments and are supported by the support team. For more information, see [Azure Databricks preview releases](/azure/databricks/release-notes/release-types).

- This solution uses [Azure Database for MySQL](https://azure.microsoft.com/services/mysql/) to store the Apache Hive metastore instance. This database was chosen for its cost effectiveness and its high compatibility with Apache Hive.

## Next steps

Enterprise-scale for analytics and AI takes the guidelines below into account for integrating Azure Databricks:

- [Securing access to Azure Data Lake Gen 2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks best practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)

> [!div class="nextstepaction"]
> [Tools and technology to power your data strategy](./synapse.md)
