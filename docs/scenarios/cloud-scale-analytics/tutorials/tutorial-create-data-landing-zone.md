---
title: Tutorial - Create a data landing zone
description: Learn how to create a data landing zone.
author: andrehass
ms.author: anhass
ms.date: 07/11/2022
ms.topic: tutorial
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank, references_regions
---

# Tutorial: Create a data landing zone

A data landing zone is a unit of scale in the enterprise-scale analytics architecture pattern. You can use a data landing zone to achieve regional deployments, clear separation of ownership, cost chargeback, and in-place data sharing within and across zones, and for many other benefits. You also can scale within data landing zones with cross-functional data integration and data product teams. The reference design targets a self-service approach for these teams to overcome bottlenecks and the need for a central team for cloud service deployments. The data landing zone reference implementation will create a consistent setup inside a subscription and will deploy storage accounts as well as data processing services like Azure Synapse, Azure Data Factory, and Azure Databricks.

## What's deployed in the tutorial?

When you complete the deployment steps described in this tutorial, you deploy the following setup in an Azure subscription:

:::image type="content" source="../images/data-landing-zone.png" border="false" alt-text="Diagram of a data landing zone.":::

> [!NOTE]
> Before you deploy the resources described in this tutorial, check the registration status of the required resource providers in your Azure subscription. For more information, see [Resource providers for Azure services](/azure/azure-resource-manager/management/resource-providers-and-types).

The deployment in the tutorial uses these Azure services and resources:

- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview)
  - [Network security groups](/azure/virtual-network/network-security-groups-overview)
  - [Route tables](/azure/virtual-network/virtual-networks-udr-overview)
- [Azure Key Vault](/azure/key-vault/general)
- [Azure Storage Account](/azure/storage/common/storage-account-overview)
- [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction)
- [Azure Data Factory](/azure/data-factory/)
  - [Self-hosted integration runtime](/azure/data-factory/create-self-hosted-integration-runtime)
- [Azure Monitor](/azure/azure-monitor/)
  - [Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace?tabs=azure-portal)
- [SQL Server](/sql/sql-server/?view=sql-server-ver15&preserve-view=true)
- [Azure SQL Database](/azure/azure-sql/database/)
- [Azure Synapse Analytics](/azure/synapse-analytics/)
  - [Synapse workspace](/azure/synapse-analytics/quickstart-create-workspace)
- [Azure Databricks](/azure/databricks/)
- [Azure Event Hubs](/azure/event-hubs/)

## Supported regions

Not all services and features are available in all Azure regions. For this tutorial, we recommend that you use the zone-redundant storage replication option for all your central data lakes in the data landing zones. Because zone-redundant storage isn't available in all regions, we're limiting the regions in the Deploy to Azure experience. If you plan to deploy the data management zone and data landing zone to a region that's not listed here, change the setting in the corresponding Bicep files in this repository.

For this tutorial, select one of the Azure regions in the following list:

- (Africa) South Africa North
- (Asia Pacific) Australia East
- (Asia Pacific) Central India
- (Asia Pacific) Japan East
- (Asia Pacific) South India
- (Asia Pacific) Southeast Asia
- (Canada) Canada Central
- (Europe) France Central
- (Europe) Germany West Central
- (Europe) North Europe
- (Europe) UK South
- (Europe) West Europe
- (South America) Brazil South
- (US) Central US
- (US) East US
- (US) East US 2
- (US) South Central US
- (US) West Central 2
- (US) West US 2

## Prerequisites

Before you begin setting up your deployment, make sure that you have these prerequisites:

- **Deploy a data management zone**. For more information, see the [data management zone](https://github.com/Azure/data-management-zone) GitHub repository.

  Before you begin, make sure you successfully deploy a [data management zone](https://github.com/Azure/data-management-zone). The data landing zone relies on Azure Private DNS zones that are deployed in the data management zone template. If you have Azure Private DNS zones deployed elsewhere, you can also point to these zones. If you don't have Azure Private DNS zones deployed for the respective Azure services, deploying the data landing zone templates fails.

- **Azure subscription**. If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).

  :::image type="content" source="../images/marketplace-subscription.png" alt-text="Screenshot that shows how to search for Azure subscriptions.":::

- **Permissions for the Azure subscription**. You must have the [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) or [Owner](/azure/role-based-access-control/built-in-roles#owner) role for the subscription to be able to create a service principal and role assignments for the service principal.

- For the deployment, choose one of the [#supported-regions].

## One-click deployment template

1. To deploy the data landing zone, select the **Deploy to Azure** button.

    You can use this option to deploy the data landing zone in your Azure subscription. The deployment template deploys all the resources to create a data landing zone.

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataLandingZone.json)

   The **Cloud-scale Analytics Scenario - Data Landing Zone** customized deployment template opens in the Azure portal.

1. In **Data landing zone**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Subscription** | Select the Azure subscription you want to use to deploy the data landing zone. |
    | **Location** | In the dropdown, select an Azure region. If no organizational policies influence the region you choose, it's a good idea to pick a region that's physically close to you. |
    | **Environment** | For this tutorial, select **Development**. |
    | **Data landing zone prefix** | Enter a unique string that's a maximum of 10 alphanumeric characters as a unique prefix that's added to all resource groups and resources in the deployment. |

    :::image type="content" source="../images/data-landing-zone-tab.png" alt-text="Screenshot that shows information to provide on the Data landing zone tab.":::

1. Select **Next : General Settings**.

1. In **General Settings**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Password**  | Enter a new password to create the required administrator password for Azure Synapse workspaces, Azure SQL servers, and potentially for self-hosted integration runtimes that are hosted on a virtual machine scale set. |
    | **Confirm Password** | Confirm the password. |
    | **Connect to Purview Account** | In the dropdown, select the Azure Purview account you want to use to connect Azure Synapse and Azure Data Factory. |
    | **Deploy Self-hosted Integration Runtimes** | Select **Yes** to deploy self-hosted integration runtimes in your data landing zone. |
    | **Purview Self-hosted Integration Runtime Authentication Key** | If you have a self-hosted integration runtime authentication key, enter or paste the key. If you don't have a key, complete the steps to [create a self-hosted integration runtime for Azure Purview](/Lab1/7_create_purview-shir/). Copy the key, and then paste the key here. |

    :::image type="content" source="../images/data-landing-zone-general-settings.png" alt-text="Screenshot that shows information to provide on the General settings tab.":::

1. Select **Next : Connectivity Settings**.

1. In **Connectivity Settings**, complete the following steps:

   1. In the **Data Management Landing Zone Virtual Network Configuration** section, select or enter the following information:

      | Setting | Action |
      | --- | --- |
      | **Data Management Landing Zone Subscription** | Select the Azure subscription to deploy the data landing zone to. |
      | **Data Management Landing Zone Virtual Network** | Select your data management landing zone virtual network to peer it with your data landing zone. |
      | **Existing Firewall** | Select the default **Azure Firewall**. |
      | **Azure Firewall Subscription** | Select the Azure subscription that has an Azure Firewall deployment. It should be the same subscription you use to deploy the data management landing zone. |
      | **Azure Firewall** | Select the Azure Firewall from the data management landing zone deployment. An example value is `DMLZPrefix-dev-firewall`. |

      :::image type="content" source="../images/data-landing-zone-connectivity-virtual-network.png" alt-text="Screenshot that shows data landing zone connectivity settings for virtual networks.":::

   1. In the **Private DNS Zone** section, select or enter the following information:

      | Setting | Action |
      | --- | --- |
      | **DNS A-Records are deployed through Azure Policy** | Select **No**. |
      | **Subscription with Private DNS Zones** | Select the Azure subscription you used to deploy the data management landing zone. |
      | **Private DNS Zone Key Vault** | Select **privatelink.vaultcore.azure.net**. |
      | **Private DNS Zone DataFactory** | Select **privatelink.datafactory.azure.net**. |
      | **Private DNS Zone DataFactory Portal** | Select **privatelink.adf.azure.net**. |
      | **Private DNS Zone Blob Storage** | Select **privatelink.blob.core.windows.net**. |
      | **Private DNS Zone DFS Storage** | Select **privatelink.dfs.core.windows.net**. |
      | **Private DNS Zone SQL Server** | Select **privatelink.database.windows.net**. |
      | **Private DNS Zone MySQL Server** | Select **privatelink.mysql.database.azure.com**. |
      | **Private DNS Zone EventHub Namespace** | Select **privatelink.servicebus.windows.net**. |
      | **Private DNS Zone Synapse Dev** | Select **privatelink.dev.azuresynapse.net**. |
      | **Private DNS Zone Synapse SQL** | Select **privatelink.sql.azuresynapse.net**. |

    :::image type="content" source="../images/data-landing-zone-connectivity-private-dns.png" alt-text="Screenshot that shows data landing zone connectivity settings for Private DNS zones.":::

1. Select **Review + create**.  

1. After the parameters are validated, select **Create** to start the deployment.

   :::image type="content" source="../images/data-landing-zone-create.png" alt-text="Screenshot shows the data landing zone parameter validation and Create page.":::

Deployment takes approximately 25 minutes to complete.
