---
title: Create data product tutorial
description: Learn how to experiment with resources to deploy a data product batch using the one-click method in a data landing zone.
author: andrehass
ms.author: anhass
ms.date: 07/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---
# Deploy data product batch via one-click deployment

 If you want to experiment with the resources and see what's deployed as part of data product batch deployment, use the **Deploy to Azure** button. You deploy resources for the data product batch in a data landing zone. The applicable scenarios for data product batch include data product and data integration. As described in previous articles, data products are another unit of scale inside a data landing zone. You can use this template for a data product and data integration into the platform.

To deploy the data product batch using the one-click method, follow these steps:

1. Select the **Deploy to Azure** button. A new page opens in the Azure portal as shown in the following table:

      | Reference implementation   | Description | Deploy to Azure |
      |:---------------------------|:------------|:----------------|
      | Data product batch     | Deploys a data workload template for data batch analysis to a resource group inside a data landing zone. Be sure you deploy a [data management landing zone](https://github.com/Azure/data-management-zone) and [data landing zone](https://github.com/Azure/data-landing-zone) first. |[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Fdocs%2Freference%2Fportal.dataProduct.json) |

1. In the **Data Product** tab, provide the following information:

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | **Subscription** | Select the subscription to deploy the data product to. If you have access to multiple subscriptions, be sure to choose the correct one. |
      | **Resource Group** | Type *dev-dp001* in the field and select the resource group that has the DLZ prefix you created earlier, plus the *-dev-dp001* suffix. |  
      | **Location**| Select the location. If there are no organizational policies influencing the location, it's a good idea to pick a region that's physically close to you. Verify that the region is supported for Enterprise Scale Analytics. A list of supported regions is available in the [data management landing zone overview](/lab1/0_data_management_landing_zone_overview/). Navigate to **Supported Regions**. |
      | **Environment** | We recommend you choose **Development**, for this tutorial. You could use the same process to deploy a test or production environment as well. |
      | **Data Product Prefix** | A prefix added to all the deployed data product resources to make them unique within the subscription. This prefix can be a max of 10 alphanumeric characters. |

      :::image type="content" source="../images/dataproduct-deployment-1.png" alt-text="Screenshot showing how to deploy Data Product.":::

1. Select **Next: General Settings**, and provide the following information:

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | **Create Data Processing Service** | Select **Data Factory** from the dropdown menu. |
      | **Connect to Purview Account** | Select the Microsoft Purview you created when deploying the data management landing zone. |
      | **SQL Flavor** | Select **SQL Server**. |
      | **Password** | Enter a strong password for your Azure SQL Server account, and confirm it. |
      | **Enable Azure Cosmos DB** | Leave this option *unchecked*. |
      | **Enable role assignments** | This setting is optional, but you should *check* it to add required permissions. |

      :::image type="content" source="../images/dataproduct-general-settings.png" alt-text="Screenshot showing data product general settings.":::

1. Next, select **Next: Connectivity Settings**, and provide the following information:

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | **Virtual Network** | Select the virtual network of your data landing zone. |
      | **Subnet** | Select the *DataProduct001Subnet* subnet. |

      :::image type="content" source="../images/dataproduct-connectivity-settings.png" alt-text="Screenshot showing data product connectivity settings.":::

1. Under **Private DNS Zones**, enter the following information.

      | Setting| Suggested Value(s)  |
      |:-------|:--------------------|
      | **DNS A-Records are deployed through Azure Policy** | Choose **No**. |
      | **Subscription with Private DNS Zones** | Select the subscription used to deploy the data landing zone. |
      | **Private DNS Zone Key Vault** | Select **privatelink.vaultcore.azure.net**. |
      | **Private DNS Zone Synapse Dev** | Select **privatelink.dev.azuresynapse.net**. |
      | **Private DNS Zone Synapse SQL** | Select **privatelink.sql.azuresynapse.net**. |
      | **Private DNS Zone DataFactory** | Select **privatelink.datafactory.azure.net**. |
      | **Private DNS Zone DataFactory Portal** | Select **privatelink.adf.azure.net**. |
      | **Private DNS Zone Cosmos SQL**  | Select **privatelink.documents.azure.com**. |
      | **Private DNS Zone SQL Server** | Select **privatelink.database.windows.net**. |
      | **Private DNS Zone MySQL Server** | Select **privatelink.mysql.database.azure.com**. |
      | **Private DNS Zone MariaDB Server** | Select **privatelink.mariadb.database.azure.com**. |
      | **Private DNS Zone PostgreSQL Server** | Select **privatelink.postgres.database.azure.com**. |

      :::image type="content" source="../images/dataproduct-private-dns.png" alt-text="Screenshot showing Data Product Private DNS.":::

1. Select **Review + create** to go the last step.

1. When the parameters validate, the **Create** button enables. Select the button to start the deployment.

   :::image type="content" source="../images/dataproduct-deployment-create.png" alt-text="Screenshot showing how to create in Data Product deploy.":::

The deployment can take a few minutes to complete.
