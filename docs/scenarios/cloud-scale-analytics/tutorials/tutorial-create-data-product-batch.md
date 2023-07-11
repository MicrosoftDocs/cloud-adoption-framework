---
title: Tutorial - Create a data product batch
description: Learn how to deploy a data product batch by using one-click deployment in the Azure portal.
author: abdale
ms.author: hamoodaleem
ms.date: 07/18/2022
ms.topic: tutorial
s.custom: e2e-data-management, think-tank
---

# Tutorial: Create a data product batch

In this tutorial, experiment with Azure resources and see what's created in a one-click data product batch deployment in the Azure portal. Learn how to:

> [!div class="checklist"]
>
> - Use the Deploy to Azure option
> - Select settings and options for your deployment
> - Validate deployment parameters
> - Create the deployment

The Deploy to Azure feature is a customized deployment template that deploys resources for the data product batch in a data landing zone. The applicable scenarios for a data product batch include working with data products and data integration. As described in other tutorials, data products are a unit of scale in a data landing zone. You can use the template that's described in this tutorial to deploy a data product batch and add data integration to the platform.

## Prerequisites

Before you begin setting up your deployment, make sure you meet these prerequisites:

- **Azure subscription.** If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).

- **Permissions for the Azure subscription.** You must have the [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) role or the [Owner](/azure/role-based-access-control/built-in-roles#owner) role for the subscription to create a service principal and role assignments for the service principal.

- **Deployed resources.** To complete the tutorial, these resources must already be deployed in your Azure subscription:

  - *Data management landing zone.* For more information, see the [data management landing zone](https://github.com/Azure/data-management-zone) GitHub repository.
  - *Data landing zone.* For more information, see the [data landing zone](https://github.com/Azure/data-landing-zone) GitHub repository.

## Set up the data product batch deployment

You can use a one-click customized deployment template to deploy a data product batch in your Azure subscription. The deployment template deploys all the required resources.

1. To deploy a data product batch, select the **Deploy to Azure** button:

    [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Fdocs%2Freference%2Fportal.dataProduct.json)

   The **Cloud-scale Analytics Scenario - Data Product Batch** customized deployment template opens in the Azure portal.

1. In **Data Product**, select or enter the following information:

    | Setting | Action |
    | --- | --- |
    | **Subscription** | Select the subscription to use to deploy the data product batch. If you have access to multiple subscriptions, be sure to choose the correct one. |
    | **Resource Group** | Enter *dev-dp001* and select the resource group that has the DLZ prefix you created earlier, plus the *-dev-dp001* suffix. Example: *\<DLZ-prefix\>dev-dp001* |
    | **Location**| In the dropdown, select one of the Azure regions that are supported for this scenario. If no organizational policies influence the region you choose, it's a good idea to choose a region that's physically close to you. For more information, see [Supported regions](tutorial-create-data-landing-zone.md#supported-regions). |
    | **Environment** | For this tutorial, select **Development**. |
    | **Data Product Prefix** | Enter a unique string that's a maximum of 10 alphanumeric characters. The string is a unique prefix that's added to all resource groups and resources in the deployment. |

    :::image type="content" source="../images/data-product-deployment-tab.png" alt-text="Screenshot that shows settings to create a data product batch deployment.":::

   Select **Next : General Settings**.

1. In **General Settings**, select or enter the following information:

   | Setting | Action |
   | --- | --- |
   | **Create Data Processing Service** | Select **Data Factory**. |
   | **Connect to Purview Account** | Select the Microsoft Purview instance you created when you deployed your data management landing zone. |
   | **SQL Flavor** | Select **SQL Server**. |
   | **Password** | Enter a strong password for your Azure SQL server, and then reenter the password to confirm it. |
   | **Enable Azure Cosmos DB** | Leave this option *cleared*. |
   | **Enable role assignments** | This setting is optional, but we recommend that you *select* it to add required permissions. |

   :::image type="content" source="../images/data-product-general-settings.png" alt-text="Screenshot that shows the general settings in a data product batch deployment.":::

   Select **Next : Connectivity Settings**.

1. In **Connectivity Settings**, complete these steps:

    1. For **Virtual Network**, select the virtual network in your data landing zone.

    1. For **Subnet**, select the *DataProduct001Subnet* subnet.

       :::image type="content" source="../images/data-product-connectivity-settings.png" alt-text="Screenshot that shows the connectivity settings in a data product batch deployment.":::

    1. Under **Private DNS Zones**, select or enter the following information:

       | Setting | Action |
       | --- | --- |
       | **DNS A-Records are deployed through Azure Policy** | Select **No**. |
       | **Subscription with Private DNS Zones** | Select the subscription you used to deploy the data landing zone. |
       | **Private DNS Zone Key Vault** | Select `privatelink.vaultcore.azure.net`. |
       | **Private DNS Zone Synapse Dev** | Select `privatelink.dev.azuresynapse.net`. |
       | **Private DNS Zone Synapse SQL** | Select `privatelink.sql.azuresynapse.net`. |
       | **Private DNS Zone DataFactory** | Select `privatelink.datafactory.azure.net`. |
       | **Private DNS Zone DataFactory Portal** | Select `privatelink.adf.azure.net`. |
       | **Private DNS Zone Cosmos SQL**  | Select **privatelink.documents.azure.com**. |
       | **Private DNS Zone SQL Server** | Select `privatelink.database.windows.net`. |
       | **Private DNS Zone MySQL Server** | Select **privatelink.mysql.database.azure.com**. |
       | **Private DNS Zone MariaDB Server** | Select **privatelink.mariadb.database.azure.com**. |
       | **Private DNS Zone PostgreSQL Server** | Select **privatelink.postgres.database.azure.com**. |

       :::image type="content" source="../images/data-product-private-dns.png" alt-text="Screenshot that shows the Private DNS zones settings in a data product batch deployment.":::

1. Select **Review + create**.

1. When the parameters are validated, select **Create** to start the deployment.

   :::image type="content" source="../images/data-product-deployment-create.png" alt-text="Screenshot that shows the Create step in a data product batch deployment.":::

Deployment might take a few minutes to finish.

## Next steps

> [!div class="nextstepaction"]
> [Set up a data product batch](tutorial-set-up-data-product-batch.md)
