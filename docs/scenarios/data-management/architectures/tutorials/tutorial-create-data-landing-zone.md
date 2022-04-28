---
title: Create data landing zone tutorial
description: Learn about create data landing zone tutorial
author: andrehass
ms.author: anhass
ms.date: 03/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Create data landing zone tutorial

## Data Landing Zone

A Data Landing Zone is a unit of scale of the Enterprise-Scale Analytics architecture pattern and it enables regional deployments, clear separation of ownership, chargeback of cost, in-place data sharing within and across Data Landing Zones and many other much asked benefits. In addition, it is possible to scale within Data Landing Zones with cross-functional Data Integration and Data Product teams. The reference design targets a self-service approach for these teams to overcome bottlenecks and the need for a central team for cloud service deployments. The Data Landing Zone reference implementation will create a consistent setup inside a subscription and will deploy storage accounts as well as data processing services like Azure Synapse, Azure Data Factory as well as Azure Databricks.

## What will be deployed?

By navigating through the deployment steps, you will deploy the following setup in a subscription:

{{% notice note %}}
Before deploying the resources, we recommend to check registration status of the required resource providers in your subscription. For more information, see [Resource providers for Azure services](https://docs.microsoft.com/azure/azure-resource-manager/management/resource-providers-and-types).
{{% /notice %}}


![Data Landing Zone](/images/DataLandingZone.png)

The deployment and code artifacts include the following services:

- [Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview)
- [Network Security Groups](https://docs.microsoft.com/azure/virtual-network/network-security-groups-overview)
- [Route Tables](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview)
- [Key Vault](https://docs.microsoft.com/azure/key-vault/general)
- [Storage Account](https://docs.microsoft.com/azure/storage/common/storage-account-overview)
- [Data Lake Storage Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-introduction)
- [Data Factory](https://docs.microsoft.com/azure/data-factory/)
- [Self-Hosted Integration Runtime](https://docs.microsoft.com/azure/data-factory/create-self-hosted-integration-runtime)
- [Log Analytics](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace)
- [SQL Server](https://docs.microsoft.com/sql/sql-server/?view=sql-server-ver15)
- [SQL Database](https://docs.microsoft.com/azure/azure-sql/database/)
- [Synapse Workspace](https://docs.microsoft.com/azure/synapse-analytics/)
- [Databricks](https://docs.microsoft.com/azure/databricks/)
- [Event Hub](https://docs.microsoft.com/azure/event-hubs/)


## Supported Regions

For now, we are recommending to select one of the regions mentioned below. The list of regions is limited for now due to the fact that not all services and features are available in all regions. This is mostly related to the fact that we are recommending to leverage at least the zone-redundant storage replication option for all your central Data Lakes in the Data Landing Zones. Since zone-redundant storage is not available in all regions, we are limiting the regions in the Deploy to Azure experience. If you are planning to deploy the Data Management Zone and Data Landing Zone to a region that is not listed below, then please change the setting in the corresponding bicep files in this repository. Officially supported regions are:

- (Africa) South Africa North
- (Asia Pacific) Southeast Asia
- (Asia Pacific) Australia East
- (Asia Pacific) Japan East
- (Canada) Canada Central
- (Europe) North Europe
- (Europe) West Europe
- (Europe) France Central
- (Europe) Germany West Central
- (Europe) UK South
- (South America) Brazil South
- (US) Central US
- (US) East US
- (US) East US 2
- (US) South Central US
- (US) West US 2

## Prerequisites

{{% notice note %}}
Please make sure you have successfully deployed a [Data Management Landing Zone]. The Data Landing Zone relies on the Private DNS Zones that are deployed in the Data Management Template. If you have Private DNS Zones deployed elsewhere, you can also point to these. If you do not have the Private DNS Zones deployed for the respective services, Data Landing Zone templates deployment will fail.
{{% /notice %}}

Before we start with the deployment, please make sure that you have the following available:

- A **Data Management Zone** deployed. For more information, check the [Data Management Zone](https://github.com/Azure/data-management-zone) repo.
- An **Azure subscription**. If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).

![Subscription ID](/images/Subscription.png)

- **Permissions to the Azure subscription**:[User Access Administrator](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#user-access-administrator) or [Owner](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#owner) access to the subscription to be able to create a service principal and role assignments for it.
- For the deployment, please choose one of the **Supported Regions**.