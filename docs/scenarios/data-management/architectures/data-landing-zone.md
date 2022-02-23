---
title: Overview of the data management and analytics scenario architecture data landing zone in Azure
description: Learn about the data management and analytics scenario architecture data landing zone in Azure.
author: mboswell
ms.author: mboswell
ms.date: 11/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Overview of the data landing zone in Azure

Data landing zones are connected to the [data management landing zone](./data-management-landing-zone.md) by virtual network (VNet) peering. They're considered a [landing zone](../../../ready/landing-zone/index.md) related to the enterprise-scale architecture.

> [!IMPORTANT]
> Before provisioning a data landing zone, you should have your DevOps and CI/CD operating model in place and a data management landing zone deployed.
>

A data landing zone has several layers to enable agility to service data integrations and data products within it. You can deploy a new data landing zone with a standard set of services to enable the data landing zone to start ingesting and analyzing data.

The Azure subscription associated with the data landing zone is structured as follows:

| Layer | Required |Resource groups |
|---|---|---|
|[Core services](#core-services-layer) | Yes |<ul><li>[Network](#networking) <li> [Data lake services](#data-lake-services) <li> [Upload ingest storage](#upload-ingest-storage) <li> [Data agnostic ingestion](#data-agnostic-ingestion) <li> [Shared integration runtimes](#shared-integration-runtimes) <li> [Shared applications](#shared-applications)|
|[Data application](#data-application)     |Optional         |<ul><li>[Data application](#data-product-resource-group) (1 or more)</li></ul>         |
|[Visualization](#visualization)    |Optional         |<ul><li>[Reporting and visualization](#reporting-and-visualization)</li></ul>         |

> [!NOTE]
> A data application produce one or more data products.

## Data landing zone architecture

The architecture of the data landing zone illustrates the layers, their respective resource groups, and services that are contained within each resource group. It also provides an overview of the groups and roles associated with the data landing zone and the extent of their access to the control and data planes.

:::image type="content" source="../images/data-landing-zone-2.png" alt-text="Diagram of the data landing zone architecture." lightbox="../images/data-landing-zone-2.png":::

 > [!TIP]
> Before getting started with deploying a data landing zone, it's highly recommended that you first [consider the number of initial data landing zones you want to deploy](scaling-architectures.md).

## Core services layer

Included are all the required services to enable the data landing zone within the context of enterprise-scale for analytics. The following resource groups form the suite of standard services available in every data landing zone that is deployed:

| Resource Group        | Required | Description             |
|-----------------------|----------|-------------------------|
| network-rg            | Yes      | Networking              |
| storage-rg            | Yes      | Data lakes services     |
| metadata-ingestion-rg | Optional | Data agnostic ingestion |
| external-data-rg      | Yes      | Upload ingest storage   |
| runtimes-rg           | Yes      | Shared integration runtimes |
| share-application-rg  | Optional | Shared applications         |

### Networking

:::image type="content" source="../images/data-landing-zone-network-rg.png" alt-text="Diagram of a data landing zone network resource group.":::

The network resource group, contains core enterprise components such as [network security groups](/azure/virtual-network/network-security-groups-overview) (NSG), Azure [Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview), and virtual network. All of these services are deployed into a single resource group. As part of the deployment, the virtual network of a data landing zone is [automatically peered with the data management landing zone's VNet](../eslz-network-topology-and-connectivity.md) and the [connectivity subscription's VNet](../../../ready/landing-zone/index.md).

### Data lake services

:::image type="content" source="../images/data-landing-zone-data-lake-services-rg.png" alt-text="Diagram of data landing zone data lake services resource group.":::

Three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts will be provisioned in the single data lake services resource group as shown above. The data transformed at different stages will be saved on one of the data landing zone's three data lakes. It will be available for analytics, data science, and visualizations teams to consume.

For more information, see:

- [Overview of Azure Data Lake Storage for the data management and analytics scenario](../best-practices/data-lake-overview.md)
- [Data Standardization](../best-practices/data-lake-standardization.md)
- [Provision three Azure Data Lake Storage Gen2 accounts for each data landing zone](../best-practices/data-lake-zones.md)
- [Key considerations for Azure Data Lake Storage](../best-practices/data-lake-key-considerations.md)
- [Access control and data lake configurations in Azure Data Lake Storage](../best-practices/data-lake-access.md)

### Upload ingest storage

Third-party data publishers require the ability to land their data into the platform so data application teams can pull it into their data lakes. The upload ingest storage resource group, shown below, enables provisioning of blob stores for third-parties.

![Diagram of upload ingest storage service.](../images/data-landing-zone-ingest-storage.png)

These storage blobs are requested by the data application teams and approved by the data landing zone operations team. Once the data has been pulled from the storage blobs into raw, the data should be removed from the source storage blob.

> [!IMPORTANT]
> Since the provisioning of Azure Storage blobs is on an *as-needed* basis, we recommend to initially deploy an empty storage services resource group in every data landing zone.

### Data agnostic ingestion

:::image type="content" source="../images/data-landing-zone-ingest-processing-rg.png" alt-text="Diagram of Data landing zone ingest and processing resource group.":::

This resource group is optional and it shouldn't prohibit you from deploying the landing zone. It applies if you have or are developing a data agnostic ingestion engine for automatically ingesting data based on registering metadata, which includes connection strings, path to copy data from and to, and ingestion schedule, the ingestion and processing resource group has key services to use such a framework.

> [!TIP]
> For more information, see [How automated ingestion frameworks support data management and analytics scenario in Azure](../best-practices/automated-ingestion-pattern.md).

Services included in the resource group include:

|Service | Required | Guidelines |
|---|---|---|
| Azure Databricks | Optional | <li> Always deploy Azure Databricks because integration operations teams can use it for ingestion, transformation, and loading of data. For more information about workspace deployments, see the [Azure Databricks section](#azure-databricks-in-shared-products). <li> An Azure Databricks workspace is provisioned for ingestion and processing that will connect to Azure Data Lake via Azure service principals. These workspaces are referred to as Azure Databricks engineering workspaces. <li> The Databricks workspaces should be locked down. The workspaces should only allow deployment of notebooks or jars from the data integration Azure DevOps repo via a data integrations service principal. |
|Event Hubs or IoT Hub | Optional | <li> Your ingestion framework engine can use Event Hubs or IoT Hub for real-time streaming to Event Hubs and for processing of batch and streaming via a Databricks engineering workspace. |
|Azure Data Factory |Optional | |

 If your organization has decided to develop your own ingestion framework engine based on the recommendations in the data management and analytics scenario ingestion flow, using either a Power Apps or .NET application, in the data management landing zone, we would suggest deploying an Azure SQL Database instance to hold metadata for Azure Data Factory to use.

An Azure Key Vault will be provisioned to store secrets relating to data landing zone services such as:

- Azure Data Factory metastore credentials
- Azure Databricks PAT tokens for use with the automated ingestion process
- Service principal credentials for the automated ingestion process
- Data landing zone data lake services keys

The types of data that you'll store in the data landing zone will help determine any other services that should be here. For example, if you're storing *sensitive (personal data)* data, you might include a tokenization engine. The tokenization engine will ensure that all *sensitive (personal data)* data can be tokenized as it's ingested into the data lake.

### Shared integration runtimes

We recommend you deploy a virtual machine scale set with self-hosted integration runtimes into the data landing zone. It should be hosted in the shared integration resource group. This deployment will enable rapid onboarding of data products to the data landing zone.

A self-hosted integration runtime will be deployed for use with Azure Purview to scan data inside the data landing zone. We recommend you understand how to [create and manage a self-hosted integration runtime in Azure Purview](/azure/purview/manage-integration-runtimes).

:::image type="content" source="../images/data-landing-zone-shared-integration-rg.png" alt-text="Diagram of a data landing zone shared integration resource group.":::

To enable the resource group, you need to:

- Create at least one Azure Data Factory in the shared integration resource group in the data landing zone. It will only be used for linking the shared self-hosted integration runtime and not for data pipelines.
- Create a [shared image for the Azure virtual machine scale set](/azure/virtual-machine-scale-sets/tutorial-use-custom-image-powershell) with a self-hosted integration runtime configured.
- The [self hosted integration runtimes should be setup in high availability mode](/azure/data-factory/create-self-hosted-integration-runtime#high-availability-and-scalability).
- The self-hosted integration runtimes should be associated with Azure data factories in the data landing zone(s).
- [Azure Automation should be setup to update the self hosted integration runtime periodically](/azure/data-factory/self-hosted-integration-runtime-automation-scripts)

> [!NOTE]
> This does not restrict the deployment of integration runtimes inside a data landing zone or into third-party clouds.

### Shared applications

For each data landing zone, a shared Azure Synapse Analytics workspace and Azure Databricks workspaces get provisioned. The workspaces are for use by everyone in the data landing zone for exploratory purposes.

:::image type="content" source="../images/data-landing-zone-shared-products-rg.png" alt-text="Diagram of data landing zone shared products resource group.":::

#### Azure Databricks in shared products

Azure Databricks service is envisioned to be one of the key consumers of the Azure Data Lake Storage service. The atomic file operations are optimized for Spark analytic engines. The optimization speeds up completion of Spark jobs issued from the Azure Databricks service.

> [!IMPORTANT]
> An Azure Databricks workspace will be provisioned for all data scientists and DataOps called the Azure Databricks analytics and data science workspace as shown in the shared products resource group.
> This workspace can be configured to connect to the Azure Data Lake using Azure Active Directory passthrough or table access control. Depending on the use case, conditional access can be configured as another security measure.

An Azure Database for MySQL database will be provisioned. The Azure Databricks engineering workspaces and Azure Databricks analytics and data science workspace use it as their external Apache Hive metastore.

The data management and analytics scenario guidance follows best practices to integrate Azure Databricks:

- [Securing access to Azure Data Lake Gen2 from Azure Databricks](https://github.com/hurtn/datalake-ADLS-access-patterns-with-Databricks/blob/master/readme.md)
- [Azure Databricks best practices](https://github.com/Azure/AzureDatabricksBestPractices/blob/master/toc.md)

The enterprise-scale pattern recommends all logs should be sent to a central Log Analytics workspace. However, there's also a monitoring resource group in each data landing zone to capture Spark logs from Databricks. The resource group contains a shared Log Analytics workspace and Azure Key Vault to store the Log Analytics keys.

> [!IMPORTANT]
> The Log Analytics workspace in the monitoring resource group should only be used for capturing Databricks Spark logs.

#### Azure Synapse Analytics in shared products

Azure Synapse Analytics is the provisioned integrated analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse Analytics brings together the best of **SQL** technologies used in enterprise data warehousing, Spark technologies used for big data, and **Pipelines** for data integration and extract, transform, load (ETL) or extract, load, transform (ELT). Azure Synapse studio provides a unified experience for management, monitoring, coding, and security. Synapse has deep integration with other Azure services such as Power BI, Azure Cosmos DB, and Azure Machine Learning.

> [!IMPORTANT]
> During the initial setup of a data landing zone, a single Azure Synapse Analytics workspace will be deployed to for use by all data analysts and scientists in the shared products resource group. More synapse workspaces can be optionally setup for data integrations and data products should cost management and recharge be required. Data integration and data product teams might make use of dedicated Azure Synapse Analytics workspaces for creating dedicated Azure SQL Database pools, as a read data store, which is used by the visualization layer.

## Data application

A data landing zone can have multiple data products. You can create the data products by ingesting data from data integrations read data stores. Or you can create data products by other data products inside the same data landing zone, or from across multiple data landing zones. The creation of the data products is subject to approval of the data steward.

### Data product resource group

The resource group for a data product includes all the service required to make that data product. For example, there's a requirement to have an Azure Database for MySQL, that's used by a visualization tool. The data must be ingested and transformed before landing into the MySQL database. You can deploy an Azure Data Factory and Azure Database for MySQL into the data product resource group.

For more information on how to onboard data products, see [Data management and analytics scenario data products in Azure](./data-landing-zone-data-products.md). The guidance explains the process to create the services and resource groups.

## Visualization

### Reporting and visualization

For every data landing zone, an empty visualization resource group will be created. This group can be filled with services required to implement your visualization solution. Using the existing VNet will enable your solution to connect to data products.

![A visualization resource group.](../images/visualization-resource-group.png)

This resource group could host virtual machines for third-party visualization services.

> [!TIP]
> It might be more economical to deploy third-party visualization products into the data management landing zone due to licensing costs, and for the products to connect across data landing zones to pull data back.

## Next steps

[Data management and analytics scenario data products in Azure](data-landing-zone-data-products.md)
