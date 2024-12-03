---
title: Data landing zones
description: Learn about cloud-scale analytics architecture data landing zones in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data landing zones

Data landing zones are connected to your [data management landing zone](./data-management-landing-zone.md) by virtual network peering or private endpoints. Each data landing zone is considered a [landing zone](../../../ready/landing-zone/index.md) related to Azure landing zone architecture.

> [!IMPORTANT]
> Before provisioning a data landing zone, ensure your DevOps and CI/CD operating model is in place and a data management landing zone is deployed.

Each data landing zone has several layers that enable agility for the service data integrations and data applications it contains. You can deploy a new data landing zone with a standard set of services that allow the data landing zone to begin ingesting and analyzing data.

A typical Azure subscription associated with a data landing zone has the following structure:

| Layer | Required | Resource groups |
|---|---|---|
| [Platform services layer](#platform-services) | Yes | <ul> <li> [Network](#networking) </li> <li> [Security](#security-and-monitoring) </li> </ul> |
| [Core services](#core-services) | Yes | <ul> <li> [Storage](#storage) </li> <li> [Shared integration runtimes](#shared-integration-runtimes) </li> <li> [Management](#management) </li> <li> [External storage](#external-storage) </li> <li> [Data Ingestion](#data-ingestion) </li> <li> [Shared Applications](#shared-applications) </li> </ul> |
| [Data application](#data-application) | Optional | <ul> <li> [Data application](#data-application-resource-group) (1 or more) </li> </ul> |
| [Reporting and visualization](#reporting-and-visualization) | Optional | <ul> <li> [Reporting and visualization](#reporting-and-visualization) </li> </ul> |

> [!NOTE]
> While the Core services layer is marked as required, not all resource groups and services included in this article may be necessary for your data landing zone.

## Data landing zone architecture

Data landing zone architecture illustrates the layers, their resource groups, and the services each resource group contains. The architecture offers an overview of all groups and roles associated with your data landing zone and the extent of their access to your control and data planes. The architecture also illustrates how each layer aligns with the Operational Model responsibilities.

:::image type="content" source="../images/data-landing-zone.png" alt-text="Diagram of the data landing zone architecture." lightbox="../images/data-landing-zone.png":::

> [!TIP]
> Before you deploy a data landing zone, make sure you [consider the number of initial data landing zones you want to deploy](../../cloud-scale-analytics/architectures/scale-architectures.md).

## Platform services

The platform services layer includes services required to enable connectivity and observability to your data landing zone within the context of cloud-scale analytics. The following table lists the recommended resource groups.

| Resource Group | Required | Description |
|----------------|----------|-------------|
| `network-rg` | Yes | Networking |
| `security-rg` | Yes | Security and Monitoring |

### Networking

The network resource group contains connectivity services, including [Azure Virtual Networks](/azure/virtual-network/virtual-networks-overview), [Network Security Groups](/azure/virtual-network/network-security-groups-overview) (NSG), and [route tables](/azure/virtual-network/virtual-networks-udr-overview). All of these services are deployed into a single resource group.

The virtual network of your data landing zone is [automatically peered with your data management landing zone's virtual network](../eslz-network-topology-and-connectivity.md) and your [connectivity subscription's virtual network](../../../ready/landing-zone/index.md).

### Security and Monitoring

The security and monitoring resource group includes [Azure Monitor](/azure/azure-monitor/overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) to collect service telemetry, define monitoring criteria and alerts, and apply policies and scanning to services.

## Core services

The core services layer includes foundational services required to enable your data landing zone within the context of cloud-scale analytics. The following table lists the resource groups that provide the standard suite of available services in every data landing zone you deploy.

| Resource Group | Required | Description |
|----------------|----------|-------------|
| `storage-rg` | Yes | Data lake services |
| `runtimes-rg` | Yes | Shared integration runtimes |
| `mgmt-rg` | Yes | CI/CD agents |
| `external-data-rg` | Yes | External data storage |
| `data-ingestion-rg` | Optional | Shared data ingestion services |
| `shared-applications-rg` | Optional | Shared applications (Synapse or Databricks) |

### Storage

As shown in the diagram, three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts are provisioned in a single data lake services resource group. Data transformed at different stages is saved in one of your data landing zone's data lakes. The data is available for consumption by your analytics, data science, and visualization teams.

[!INCLUDE [data-lake-layers](../../cloud-scale-analytics/includes/data-lake-layers.md)]

> [!NOTE]
> In the previous diagram, each data landing zone has three data lake storage accounts. However, depending on your requirements, you can choose to consolidate your raw, enriched, and curated layers into one storage account and maintain another storage account called 'workspace' for data consumers to bring in other useful data products.

For more information, see:

- [Overview of Azure Data Lake Storage for cloud-scale analytics](../best-practices/data-lake-overview.md)
- [Data Standardization](../../cloud-scale-analytics/architectures/data-standardization.md)
- [Provision Azure Data Lake Storage Gen2 accounts for each data landing zone](../../cloud-scale-analytics/best-practices/data-lake-zones.md)
- [Key considerations for Azure Data Lake Storage](../best-practices/data-lake-key-considerations.md)
- [Access control and data lake configurations in Azure Data Lake Storage](../best-practices/data-lake-access.md)

### Shared integration runtimes

Azure Data Factory and Azure Synapse Analytics Pipelines use integration runtimes (IR) to securely access data sources in peered or isolated networks. Shared IRs should be deployed to a virtual machine (or Azure Virtual Machine Scale Sets) in the shared integration runtime resource group.

To enable the shared resource group:

- Create at least one Azure Data Factory in your data landing zone's shared integration resource group. Use it only for linking the shared self-hosted integration runtime, not for data pipelines.
- [Create and configure a self-hosted integration runtime](/azure/data-factory/create-self-hosted-integration-runtime) on the virtual machine.
- Associate the self-hosted integration runtime with Azure data factories in your data landing zones.
- Use PowerShell scripts to [periodically update the self-hosted integration runtime](/azure/data-factory/self-hosted-integration-runtime-automation-scripts).

> [!NOTE]
> The deployment describes a single virtual machine deployment with a self-hosted integration runtime. You can associate a self-hosted integration runtime with multiple virtual machines on-premises or in Azure. These machines are called nodes, and you can have up to four nodes associated with a self-hosted integration runtime. The benefits of having multiple nodes are:
>
> - Higher availability of the self-hosted integration runtime so that it's no longer the single point of failure in your data application or in the orchestration of cloud data integration.
> - Improved performance and throughput during data movement between on-premises and cloud data services. Get more information on [performance comparisons](/azure/data-factory/copy-activity-performance).
>
> You can associate multiple nodes by installing the self-hosted integration runtime software from [Download Center](https://www.microsoft.com/download/details.aspx?id=39717). Then, register it by using either of the authentication keys obtained from the **New-AzDataFactoryV2IntegrationRuntimeKey** cmdlet, as described in the [tutorial](/azure/data-factory/tutorial-hybrid-copy-powershell).
>
> Further information is detailed in [Azure Data Factory High availability and scalability](/azure/data-factory/create-self-hosted-integration-runtime#high-availability-and-scalability).

> [!IMPORTANT]
> Deploy shared integration runtimes as close to the data source as possible. You can deploy the integration runtimes in a data landing zone, into third-party clouds, or into a private cloud provided the virtual machine has connectivity to the required data source(s).

### Management

CI/CD Agents run on virtual machines and help deploy artifacts from the source code repository, including data applications and changes to the data landing zone.

For more information, see [Azure Pipeline agents](/azure/devops/pipelines/agents/agents).

### External storage

Partner data publishers need to land data in your platform so your data application teams can pull it into their data lakes. You can also have internal or external data sources that can't support the connectivity or authentication requirements enforced across the rest of the data landing zones. Using a separate storage account is the recommended approach to receive data, then a shared integration runtime or similar ingestion process to bring it into your processing pipeline. As seen in the following diagram, your upload ingest storage resource group lets you provision blob stores for these use cases.

The data application teams request the storage blobs. These requests get approved by the data landing zone operations team. Data should be deleted from its source storage blob after being ingested into the raw data storage.

> [!IMPORTANT]
> Since Azure Storage blobs are provisioned on an *as-needed* basis, you should initially deploy an empty storage services resource group in each data landing zone.

### Data ingestion

This resource group is optional and doesn't prevent you from deploying your landing zone. It's applicable if you have, or are developing, a data-agnostic ingestion engine that automatically ingests data based on registered metadata, including connection strings, paths for data transfer, and ingestion schedules.

The ingestion and processing resource group has key services for this kind of framework.

Deploy an Azure SQL Database instance to hold metadata used by Azure Data Factory. Provision an Azure Key Vault to store secrets relating to automated ingestion services. These secrets can include:

- Azure Data Factory metastore credentials
- Service principal credentials for your automated ingestion process

For more information, see [How automated ingestion frameworks support cloud-scale analytics in Azure](../best-practices/automated-ingestion-pattern.md).

Services included in this resource group include:

| Service | Required | Guidelines |
|---------|----------|------------|
| Azure Data Factory | Yes | Azure Data Factory is your orchestration engine for data-agnostic ingestion. |
| Azure SQL DB | Yes | Azure SQL DB is the metastore for Azure Data Factory. |
| Event Hubs or IoT Hub | Optional | Event Hubs or IoT Hub can provide real-time streaming to Event Hubs, plus batch and streaming processing via a Databricks engineering workspace. |
| Azure Databricks | Optional | You can deploy Azure Databricks or Azure Synapse Spark for use with your data-agnostic ingestion engine. |
| Azure Synapse | Optional | You can deploy Azure Databricks or Azure Synapse Spark to use with the data-agnostic ingestion engine. |

### Shared applications

This optional resource group is used when there's a need to have a set of shared services made available to all the teams building data applications in this data landing zone. Example uses include:

- An Azure Databricks workspace used as a shared Metastore for all other Databricks workspaces created in the same data landing zone (or region)
- A shared Azure Synapse Analytics instance using Serverless SQL Pools to enable users to query across isolated storage accounts.

> [!NOTE]
> Azure Databricks uses Unity Catalog to govern access and visibility to metastores across Databricks Workspaces. Unity Catalog is enabled at a tenant level, but metastores are aligned to Azure regions. In practice, this means that all Unity Catalog-enabled Databricks workspaces in a given Azure region will need to register to the same Metastore. For more information, see [Unity Catalog Best Practices](/azure/databricks/data-governance/unity-catalog/best-practices).

Follow cloud-scale analytics best practices to integrate Azure Databricks:

- [Secure access to Azure Data Lake Gen2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks best practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)

## Data application

Each data landing zone can have multiple data applications. You can create these applications by ingesting data from various sources. You can also create data applications from other data applications within the same data landing zone or from other data landing zones. Creation of the data applications is subject to data steward approval.

### Data application resource group

Your data application resource group includes all the services required to make that data application. For example, an Azure Database is required for MySQL, which is used by a visualization tool. Data must be ingested and transformed before it lands into that MySQL database. In this case, you can deploy Azure Database for MySQL and an Azure Data Factory into the data application resource group.

> [!TIP]
> If you choose not to implement a data-agnostic engine for ingesting once from operational sources, or if complex connections aren't facilitated in your data-agnostic engine, create a source-aligned data application. For more information, see [Data applications (source-aligned)](../../cloud-scale-analytics/architectures/data-application-source-aligned.md).

For more information on how to onboard data products, see [Cloud-scale analytics data applications in Azure](./data-landing-zone-data-products.md).

## Reporting and Visualization

You can use visualization and reporting tools within Fabric Workspaces, which have many similarities to Power BI Workspaces, without having to deploy unique resources within your data landing zone. You can include a resource group to deploy Fabric capacity, virtual machines for data gateways, or other necessary data services to deliver your data application to the end user.

## Next steps

- [Cloud-scale analytics data products in Azure](data-landing-zone-data-products.md)