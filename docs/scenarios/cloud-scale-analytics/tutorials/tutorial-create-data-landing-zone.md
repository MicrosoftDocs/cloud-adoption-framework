---
title: Create data landing zone tutorial
description: Learn about the create data landing zone tutorial
author: andrehass
ms.author: anhass
ms.date: 07/07/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank, references_regions
---

# Create data landing zone tutorial

A data landing zone is a unit of scale of the Enterprise-Scale Analytics architecture pattern. data landing zones enable regional deployments, clear separation of ownership, chargeback of cost, in-place data sharing within and across data landing zones and many other benefits. In addition, it is possible to scale within data landing zones with cross-functional Data Integration and Data Product teams. The reference design targets a self-service approach for these teams to overcome bottlenecks and the need for a central team for cloud service deployments. The data landing zone reference implementation will create a consistent setup inside a subscription and will deploy storage accounts as well as data processing services like Azure Synapse, Azure Data Factory as well as Azure Databricks.

## What will be deployed?

By navigating through the deployment steps, you will deploy the following setup in a subscription:

> [!NOTE]
>Before deploying the resources, we recommend to check registration status of the required resource providers in your subscription. For more information, see [Resource providers for Azure services](/azure/azure-resource-manager/management/resource-providers-and-types).

:::image type="content" source="../images/data-landing-zone.png" alt-text="Diagram of the data landing zone.":::

The deployment and code artifacts include the following services:

- [Virtual Network](/azure/virtual-network/virtual-networks-overview)
- [Network Security Groups](/azure/virtual-network/network-security-groups-overview)
- [Route Tables](/azure/virtual-network/virtual-networks-udr-overview)
- [Key Vault](/azure/key-vault/general)
- [Storage Account](/azure/storage/common/storage-account-overview)
- [Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction)
- [Data Factory](/azure/data-factory/)
- [Self-Hosted Integration Runtime](/azure/data-factory/create-self-hosted-integration-runtime)
- [Log Analytics](/azure/azure-monitor/learn/quick-create-workspace)
- [SQL Server](/sql/sql-server/?view=sql-server-ver15&preserve-view=true)
- [SQL Database](/azure/azure-sql/database/)
- [Synapse Workspace](/azure/synapse-analytics/)
- [Databricks](/azure/databricks/)
- [Event Hubs](/azure/event-hubs/)

## Supported regions

For now, we're recommending to select one of the regions mentioned below. The list of regions is limited for now due to the fact that not all services and features are available in all regions. This is mostly related to the fact that we're recommending to use the zone-redundant storage replication option for all your central Data Lakes in the data landing zones. Since zone-redundant storage is not available in all regions, we're limiting the regions in the Deploy to Azure experience. If you are planning to deploy the Data Management Zone and data landing zone to a region that is not listed below, then change the setting in the corresponding bicep files in this repository. Officially supported regions are:

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

> [!NOTE]
> Make sure you have successfully deployed a [Data Management Landing Zone]. The data landing zone relies on the Private DNS Zones that are deployed in the Data Management Template. If you have Private DNS Zones deployed elsewhere, you can also point to these. If you do not have the Private DNS Zones deployed for the respective services, Data landing zone templates deployment will fail.

Before we start with the deployment, make sure that you have the following available:

- A **Data Management Zone** deployed. For more information, check the [Data Management Zone](https://github.com/Azure/data-management-zone) repo.
- An **Azure subscription**. If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).

    :::image type="content" source="../images/marketplace-subscription.png" alt-text="Screenshot showing the search Subscription.":::

- **Permissions to the Azure subscription**:[User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) or [Owner](/azure/role-based-access-control/built-in-roles#owner) access to the subscription to be able to create a service principal and role assignments for it.
- For the deployment, choose one of the **Supported Regions**.

## One Click Deployment

1. Deploy data landing zone

      This is a UI based deployment option that lets you deploy the data landing zone into your Azure subscription.

      This will deploy all the resources of data landing zone explained earlier in quickest and simplistic possible way.

      To use the Deploy to Azure Button, click on the button below:

      | Reference implementation   | Description | Deploy to Azure |
      |:---------------------------|:------------|:----------------|
      | Data landing zone          | Deploys a single data landing zone to a subscription. Deploy a [Data Management Landing Zone](https://github.com/Azure/data-management-zone) first. |[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataLandingZone.json) |

      This opens up a new page in the Azure portal.

1. In this page, provide the following information:

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | Subscription | Select the subscription to deploy the data landing zone to. If you have access to multiple subscriptions, choose the correct one. |
      |Location | Select from the dropdown. If there are no organizational policies influencing the location, it is a good idea to pick a region that is physically close to you. Verify that this region is supported for Enterprise Scale Analytics. A list of supported regions are available [here](#supported-regions) |
      | Environment | We recommend you choose Development, as this is a tutorial. You could use the same process to deploy a Test or Production environment as well. |
      | Data landing zone prefix | This is a prefix added to all the deployed resource groups and resources to make them unique within the subscription. This can be a max of 10 alphanumeric characters. |

    :::image type="content" source="../images/dlz-1.png" alt-text="Screenshot showing the data landing zone.":::

1. Click on **Next: General Settings**. In this page, provide the following information:

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | Password  | This is required to set an administrator password for the Synapse workspaces, SQL Servers and potentially self-hosted Integration Runtimes hosted on Virtual Machine Scale Set. |
      | Confirm Password  | Confirm the previously entered password. |
      | Connect to Purview Account | Select the Purview account from the dropdown to which you want to connect Synapse and Data Factory. |
      | Deploy self-hosted Integration Runtimes | Choose Yes to deploy self-hosted Integration Runtimes into your data landing zone. |
      | Purview Self-hosted Integration Runtime Authentication Key | Paste the previously captured SHIR authentication key. If you don't have the key, follow the steps on [Create Purview SHIR](/Lab1/7_create_purview-shir/) to generate and copy it. |

    :::image type="content" source="../images/dlz-creation-2.png" alt-text="Screenshot showing the general settings page.":::

1. Next, click on **Next: Connectivity Settings**. In this page, provide the following information:

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | Virtual Network Configuration | This is an **optional** step required only if the default Vnet configuration has to be altered. **Don't make any changes to these IP addresses.** |  

    :::image type="content" source="../images/dlz-connectivity-1.png" alt-text="Screenshot showing data landing zone connectivity Settings.":::

1. Scroll down to the Data Management Landing Zone Virtual Network Configuration section.

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | Data Management Landing Zone Subscription | Choose the appropriate subscription to deploy data landing zone. |
      | Data Management Landing Zone Virtual Network | Select the Vnet of your **Data Management Landing Zone** to peer it with your data landing zone. |
      | Existing Firewall | Select the existing Azure Firewall. |
      | Azure Firewall Subscription | Select the Firewall subscription. It should be the same subscription used to deploy Data Management Landing Zone. |
      | Azure Firewall | Select the Firewall from the Data Management Landing Zone deployment. i.e. _`[DMLZPrefix]`_`-dev-firewall` |

      :::image type="content" source="../images/dlz-connectivity-2.png" alt-text="Screenshot showing data landing zone connectivity settings continued.":::

1. Under Private DNS Zone settings enter the following information.

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | DNS A-Records are deployed through Azure Policy | Choose **No** |
      | Subscription with Private DNS Zones | Select the subscription used to deploy Data Management Landing Zone. |
      | Private DNS Zone Key Vault | select privatelink.vaultcore.azure.net |
      | Private DNS Zone DataFactory | select privatelink.datafactory.azure.net |
      | Private DNS Zone DataFactory Portal | select privatelink.adf.azure.net |
      | Private DNS Zone Blob Storage | select privatelink.blob.core.windows.net |
      | Private DNS Zone DFS Storage | select privatelink.dfs.core.windows.net |
      | Private DNS Zone SQL Server | select privatelink.database.windows.net |
      | Private DNS Zone MySQL Server | select privatelink.mysql.database.azure.com |
      | Private DNS Zone EventHub Namespace | select privatelink.servicebus.windows.net |
      | Private DNS Zone Synapse Dev | select privatelink.dev.azuresynapse.net |
      | Private DNS Zone Synapse SQL | select privatelink.sql.azuresynapse.net |

    :::image type="content" source="../images/dlz-connectivity-3.png" alt-text="Screenshot showing the private DNS Zone Settings.":::

1. Click on **Review + Create**  

1. When the parameters are validated, the **Create** button will be enabled. Click in **Create** to start the deployment.

    :::image type="content" source="../images/dlz-deployment-create.png" alt-text="Screenshot showing the data landing zone create summary page.":::

The deployment will take around 25 minutes to complete.
