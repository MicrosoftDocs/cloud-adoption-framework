---
title: Create data product tutorial
description: Learn about create data product tutorial
author: andrehass
ms.author: anhass
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Create Data Product tutorial

## 1 - Deploy Data Product Batch via One Click Deployment

 If you want to experiment with the resources and see what gets deployed as part of Data Product Batch deployment, use the **Deploy to Azure Button** to deploy resources for the Data Product Batch in a Data Landing Zone. The applicable scenarios for Data Product Batch includes Data Product and Data Integration. As Explained earlier, Data Products are another unit of scale inside a Data Landing Zone. In addition to Data Product, this template can be used for Data Integration into the platform.


To deploy the Data Product Batch using the One Click method, follow these steps below: 



1. Click on the Deploy to Azure button below. This opens a new page in the Azure portal as depicted on the image below this table:

| Reference implementation   | Description | Deploy to Azure |
|:---------------------------|:------------|:----------------|
| Data Product Batch     | Deploys a Data Workload template for Data Batch Analysis to a resource group inside a Data Landing Zone. Please make sure you deploy a [Data Management Zone](https://github.com/Azure/data-management-zone) and [Data Landing Zone](https://github.com/Azure/data-landing-zone) first. |[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Fdocs%2Freference%2Fportal.dataProduct.json) | [Repository](https://github.com/Azure/data-product-batch) |


![Data Batch Deployment Screen 1](/images/dataproduct-deployment-1.png)

2. In this page, provide the following information:
    * **Subscription**: Select the subscription to deploy the Data Product to. If you have access to multiple subscriptions, please choose the correct one.

    * **Resource Group**: Type "dev-dp001" on the dropdown and select the resource group that has the DLZ prefix you created earlier plus the "-dev-dp001" suffix.  

    * **Location**: Select from the dropdown. If there are no organizational policies influencing the location, it is a good idea to pick a region that is physically close to you. Please verify that this region is supported for Enterprise Scale Analytics. A list of supported regions are available [here](/lab1/0_data_management_landing_zone_overview/) and navigate to "Supported Regions"

    * **Environment**: We recommend you choose Development, as this is a lab. You could use the same process to deploy a Test or Production environment as well.

    * **Data Product Name**: This is a prefix added to all the deployed data product resources to make them unique within the subscription. This can be a max of 10 alphanumeric characters.

3. Click on **Next: General Settings**, and provide the information as instructed right below this image:

![Data Product General Settings](/images/dataproduct-general-settings.png)

* **Create Data Processing Service**: Select Data Factory from the dropdown menu.

* **Connect to Purview Account**: Select from the dropdown the Azure Purview you created when deploying the Data Management Landing Zone.

* **SQL Flavour**: Select "SQL Server" from the dropdown menu.

* **Password**: Enter a strong password for your Azure SQL Server account, and confirm it.

* **Enable Azure Cosmos DB**: Leave this option **unchecked**

* **Enable role assignments**: This is optional, but you should **Check** this option to add required permissions. 


4. Next, click on **Next: Connectivity Settings**, and provide the information as instructed right below this image:

 ![Data Product Connectivity Settings](/images/dataproduct-connectivity-settings.png)

* **Virtual Network**: Select the Virtual Network of your Data Landing Zone.

* **Subnet**: Select the "DataIntegration" Subnet. (Follow the note on the beginning of the Virtual Network section)

* **DNS A-Records are deployed through Azure Policy**: Select **No** and proceed to select the subscription and all the other requested DNS Zones.


5. Click on **Review + Create** to go the last step.

6. When the parameters are validated, the **Create** button will be enabled. Click in **Create** to start the deployment.

![DMLZ Deployment Final Step](/images/dmlz-deployment-create.png)



The deployment will take a few minutes to complete. You can use the steps [here](/lab3/5_data_product_validation_steps/) to validate the deployment.
