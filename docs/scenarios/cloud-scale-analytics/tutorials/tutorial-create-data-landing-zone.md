---
title: Tutorial - Create a data landing zone
description: Learn how to create a data landing zone by using one-click deployment in the Azure portal.
author: abdale
ms.author: hamoodaleem
ms.date: 07/18/2022
ms.topic: tutorial
s.custom: e2e-data-management, think-tank, references_regions
---

# Tutorial: Create a data landing zone

In this tutorial, learn how to create a data landing zone by using the Deploy to Azure option in the Azure portal. Learn how to:

> [!div class="checklist"]
>
> - Use the Deploy to Azure option
> - Select settings and options for your deployment
> - Validate deployment parameters
> - Create the deployment

A data landing zone is a unit of scale in the enterprise-scale analytics architecture pattern. The benefits of using a data landing zone include regional deployments, clear separation of ownership, cost chargeback, and in-place data sharing within and across zones. You also can scale within a data landing zone by using cross-functional data integration and data product teams. The reference design offers a self-service approach for data product teams to overcome bottlenecks and the need for a central team for cloud service deployments. The data landing zone reference implementation creates a consistent setup inside an Azure subscription. It deploys storage accounts and data processing services like Azure Synapse Analytics, Azure Data Factory, and Azure Databricks.

## What's deployed?

When you complete the deployment steps described in this tutorial, you deploy a setup in your Azure subscription like the one shown in the following diagram:

:::image type="content" source="../images/data-landing-zone.png" border="false" alt-text="Diagram of a data landing zone setup.":::

> [!NOTE]
> Before you deploy the resources described in this tutorial, check the registration status of the required resource providers for your Azure subscription. For more information, see [Resource providers for Azure services](/azure/azure-resource-manager/management/resource-providers-and-types).

A data landing zone deployment uses these Azure services and resources:

- [Azure Virtual Network](/azure/virtual-network/virtual-networks-overview), including [network security groups](/azure/virtual-network/network-security-groups-overview) and [route tables](/azure/virtual-network/virtual-networks-udr-overview)
- [Azure Key Vault](/azure/key-vault/general)
- [Azure Storage Account](/azure/storage/common/storage-account-overview)
- [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction)
- [Self-hosted integration runtime](/azure/data-factory/create-self-hosted-integration-runtime) (in [Azure Data Factory](/azure/data-factory/))
- [Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace?tabs=azure-portal) (in [Azure Monitor](/azure/azure-monitor/))
- [SQL Server](/sql/sql-server/?view=sql-server-ver15&preserve-view=true)
- [Azure SQL Database](/azure/azure-sql/database/)
- [Synapse workspace](/azure/synapse-analytics/quickstart-create-workspace) (in [Azure Synapse Analytics](/azure/synapse-analytics/))
- [Azure Databricks](/azure/databricks/)
- [Azure Event Hubs](/azure/event-hubs/)

## Supported regions

Not all services and features are available in all Azure regions. For this tutorial, we recommend that you use the zone-redundant storage replication option for all the central data lakes in your data landing zone. Because zone-redundant storage isn't available in all regions, we limit the regions that are available in the deployment template. If you plan to deploy to a region that's not listed here, change the setting in the corresponding [Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) files when you use the template to create a deployment in the Azure portal.

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

Before you begin setting up your deployment, make sure that you meet these prerequisites:

- **Azure subscription.** If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).

- **Permissions for the Azure subscription.** You must have the [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) role or the [Owner](/azure/role-based-access-control/built-in-roles#owner) role.

- **Deploy a data management landing zone.** Before you begin, make sure you successfully deploy a [data management landing zone](https://github.com/Azure/data-management-zone). The data landing zone relies on Azure Private DNS zones that are deployed when you use the data management landing zone template. If you already have Azure Private DNS zones deployed, you can point to those zones. If you don't have Azure Private DNS zones deployed for the respective Azure services, deployment by using the data landing zone template fails. For more information, see the [data management landing zone](https://github.com/Azure/data-management-zone) GitHub repository.

## Set up the data landing zone deployment

You can use a one-click customized deployment template to deploy the data landing zone in your Azure subscription. The deployment template deploys all the required resources.

1. To deploy a data landing zone, select the **Deploy to Azure** button:

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataLandingZone.json)

   The **Cloud-scale Analytics Scenario - Data Landing Zone** customized deployment template opens in the Azure portal.

1. In **Data Landing Zone**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Subscription** | Select the Azure subscription to use for the data landing zone deployment. |
    | **Location** | In the dropdown, select one of the Azure regions that are supported for this scenario. If no organizational policies influence the region you choose, it's a good idea to choose a region that's physically close to you. For more information, see [Supported regions](#supported-regions). |
    | **Environment** | For this tutorial, select **Development**. |
    | **Data landing zone prefix** | Enter a unique string that's a maximum of 10 alphanumeric characters. The string is a unique prefix that's added to all resource groups and resources in the deployment. |

    :::image type="content" source="../images/data-landing-zone-tab.png" alt-text="Screenshot that shows information to provide on the Data landing zone tab.":::

   Select **Next : General Settings**.

1. In **General Settings**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Password**  | Enter a new password to create the required administrator password for Synapse workspaces, Azure SQL servers, and potentially for self-hosted integration runtimes that are hosted on a virtual machine scale set. |
    | **Confirm Password** | Reenter the password to confirm it. |
    | **Connect to Purview Account** | In the dropdown, select the Azure Purview account you want to use to connect Azure Synapse Analytics and Azure Data Factory. |
    | **Deploy Self-hosted Integration Runtimes** | Select **Yes**. |
    | **Purview Self-hosted Integration Runtime Authentication Key** | If you have a self-hosted integration runtime authentication key, enter or paste the key. If you don't have a key, complete the steps to [create a self-hosted integration runtime for Azure Purview](/azure/purview/manage-integration-runtimes#create-a-self-hosted-integration-runtime). Copy the key, and then paste the key here. |

    :::image type="content" source="../images/data-landing-zone-general-settings.png" alt-text="Screenshot that shows information to provide on the General settings tab.":::

   Select **Next : Connectivity Settings**.

1. In **Connectivity Settings**, complete these steps:

   1. In the **Data Management Landing Zone Virtual Network Configuration** section, select or enter the following information:

      | Setting | Action |
      | --- | --- |
      | **Data Management Landing Zone Subscription** | Select the Azure subscription you use for the data landing zone deployment.
      | **Data Management Landing Zone Virtual Network** | Select your data management landing zone virtual network to peer it with your data landing zone. |
      | **Existing Firewall** | Leave the default, **Azure Firewall**. |
      | **Azure Firewall Subscription** | Select the Azure subscription that has an Azure Firewall deployment. It should be the same subscription you use to deploy the data management landing zone. |
      | **Azure Firewall** | Select the Azure Firewall from the data management landing zone deployment. An example value is `<DLZ-prefix>-dev-firewall`. |

      :::image type="content" source="../images/data-landing-zone-connectivity-virtual-network.png" alt-text="Screenshot that shows data landing zone connectivity settings for virtual networks.":::

   1. Under **Private DNS Zone**, select or enter the following information:

      | Setting | Action |
      | --- | --- |
      | **DNS A-Records are deployed through Azure Policy** | Select **No**. |
      | **Subscription with Private DNS Zones** | Select the Azure subscription you use to deploy the data management landing zone. |
      | **Private DNS Zone Key Vault** | Select `privatelink.vaultcore.azure.net`. |
      | **Private DNS Zone DataFactory** | Select `privatelink.datafactory.azure.net`. |
      | **Private DNS Zone DataFactory Portal** | Select `privatelink.adf.azure.net`. |
      | **Private DNS Zone Blob Storage** | Select `privatelink.blob.core.windows.net`. |
      | **Private DNS Zone DFS Storage** | Select `privatelink.dfs.core.windows.net`. |
      | **Private DNS Zone SQL Server** | Select `privatelink.database.windows.net`. |
      | **Private DNS Zone MySQL Server** | Select **privatelink.mysql.database.azure.com**. |
      | **Private DNS Zone EventHub Namespace** | Select `privatelink.servicebus.windows.net`. |
      | **Private DNS Zone Synapse Dev** | Select `privatelink.dev.azuresynapse.net`. |
      | **Private DNS Zone Synapse SQL** | Select `privatelink.sql.azuresynapse.net`. |

       :::image type="content" source="../images/data-landing-zone-connectivity-private-dns.png" alt-text="Screenshot that shows data landing zone connectivity settings for Azure Private DNS zones.":::

   Select **Review + create**.

1. When the parameters are validated, select **Create** to start the deployment.

   :::image type="content" source="../images/data-landing-zone-create.png" alt-text="Screenshot shows the data landing zone parameter validation and the Create pane.":::

Deployment takes approximately 25 minutes to complete.

## Next steps

> [!div class="nextstepaction"]
> [Create a data product batch](tutorial-create-data-product-batch.md)
