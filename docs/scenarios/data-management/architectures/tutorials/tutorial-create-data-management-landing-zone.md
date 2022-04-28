---
title: Create data management landing zone tutorial
description: Learn about create data management landing zone tutorial
author: andrehass
ms.author: anhass
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Create data management landing zone tutorial


## Data Management Landing Zone

Data Management Zone is at the heart of the DMA platform. It provides all data management for the data platform of an organization and enables central governance of data assets across all Data Landing Zones.

## What will be deployed?

The following services are deployed in the Data Management Landing Zone, in the order presented.

### Note 
{{% notice note %}}
Before deploying the resources, we recommend checking the registration status of the required resource providers in your subscription. For more information, see [Resource providers for Azure services](https://docs.microsoft.com/azure/azure-resource-manager/management/resource-providers-and-types).
{{% /notice %}}

![Data Management Zone](/images/DataManagementZone.png)

The deployment and code artifacts include the following services:

- [Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview)
- [Network Security Groups](https://docs.microsoft.com/azure/virtual-network/network-security-groups-overview)
- [Route Tables](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview)
- [Azure Firewall](https://docs.microsoft.com/azure/firewall/overview)
- [Firewall Policy](https://docs.microsoft.com/azure/firewall-manager/policy-overview#:~:text=Firewall%20Policy%20is%20an%20Azure,work%20across%20regions%20and%20subscriptions.)
- [Private DNS Zones](https://docs.microsoft.com/azure/dns/private-dns-privatednszone#:~:text=By%20using%20private%20DNS%20zones,that%20are%20linked%20to%20it.)
- [Container Registry](https://docs.microsoft.com/azure/container-registry/)
- [Purview](https://docs.microsoft.com/azure/purview/)
- [Key Vault](https://docs.microsoft.com/azure/key-vault/general)
- [Storage Account](https://docs.microsoft.com/azure/storage/common/storage-account-overview)
- [Synapse Private Link Hub](https://docs.microsoft.com/azure/synapse-analytics/security/synapse-private-link-hubs)
- [PowerBI](https://docs.microsoft.com/power-bi/fundamentals/power-bi-overview)
- [Policies](https://docs.microsoft.com/azure/governance/policy/overview)

The remainder of this lab will walk through the steps to deploy a Data Management Landing Zone.

## Supported Regions

We recommend selecting one of the regions mentioned below. The list of regions is limited for now as all services and features are not available in all regions. This is mostly because we recommend leveraging at least the zone-redundant storage replication option for all your central Data Lakes in the Data Landing Zones, and this is only available in selected regions. If you are planning to deploy the Data Management Zone and Data Landing Zone to a region that is not listed below, then please change the setting in the corresponding bicep files in this repository. Officially supported regions are:

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

## Pre-requisites

The following pre-requisites are common to all the deployment options.

- **An Azure subscription**: The Data Management Landing Zone will be deployed into a separate azure subscription. Please ensure there is a subscription ready for this.

![Subscription ID](/images/Subscription.png)

- **Permissions to the Azure subscription**: User Access Administrator or Owner access to the subscription to be able to create a service principal and role assignments for it (next step).

- **Subscription Information**: Open the Azure portal. Navigate to the subscription to be used to deploy the Data Management Landing Zone and make a note of the subscription ID.

- **Azure CLI**: You can use Cloud Shell from the Azure Portal or work with Azure CLI on the desktop. Instructions to setup Azure CLI on the desktop can be found [here](https://docs.microsoft.com/cli/azure/install-azure-cli).

## 1 - Deploy Data Management Landing Zone via One Click

This is a UI based deployment option that lets you deploy the Data Management Landing Zone into your Azure subscription.

Before beginning with the deployment, we have to check that the necessary resource providers are registered within this subscription. To check this, please follow the steps below.

1. In the Azure portal, navigate to the subscription

![Subscription ID](/images/Subscription.png)

2. Select the relevant subscription and click on **Resource Providers** in the left menu. 

![Subscription ID](/images/dmlz-deployment-3.png)

3. Find Microsoft.Purview by filtering on the name.
![Purview Resource Provider](/images/dmlz-deployment-purview-rp.png)

4. If the status shows Not Registered, click on the **Register** option on top to register the resource provider.

5. Repeat steps 3 and 4 for two more resource providers
    - Microsoft.EventHub
    - Microsoft.Storage 

6. Your resource providers list should now look similar to this screenshot below

![Resource Providers List](/images/dmlz-deployment-4.png)

Once this is done, we can go ahead and deploy the Data Management Landing Zone to this subscription. The following steps guide you through this process.

1. Click on the **Deploy to Azure** button below. Verify that the right button corresponding to the Data Management Landing Zone is clicked. This opens a new page in the Azure portal.

| Reference implementation   | Description | Deploy to Azure | Link |
|:---------------------------|:------------|:----------------|------|
| Data Management Zone       | Deploys a single Data Management Zone to a subscription. |[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataManagementZone.json) | [Repository](https://github.com/Azure/data-management-zone) |

When you click the button, it opens the page depicted below in the Azure portal:

![DMLZ Deployment Screen 1](/images/dmlz-deployment-1.png)

2. In this page, provide the following information:
    * **Subscription**: Select the subscription to deploy the Data Management Landing Zone to. If you have access to multiple subscriptions, please choose the correct one.

    * **Location**: Select from the dropdown. If there are no organizational policies influencing the location, it is a good idea to pick a region that is physically close to you. Please verify that this region is supported for Enterprise Scale Analytics. A list of supported regions are available [here](lab1/0_data_management_landing_zone_overview/) and navigate to "Supported Regions"

    * **Environment**: We recommend you choose Development, as this is a lab. You could use the same process to deploy a Test or Production environment as well.

    * **Data management zone prefix**: This is a prefix added to all the deployed resource groups and resources to make them unique within the subscription. This can be a max of 10 alphanumeric characters.

3. Optionally, click on **Next: General Settings**. This is required only if a user other than yourself has to be added as a collection admin in the Purview instance. To add a user, navigate to Azure Active Directory and in the list of users, select the relevant user to find the Object ID. Click on the Copy to Clipboard icon.

    ![DMLZ Deployment Screen 1](/images/user-object-id.png)

    Paste this into the Purview Root Collection Admin ID.

    ![DMLZ Deployment Purview Root Collection ID](/images/dmlz-purview-rootcollid.png)

4. Next, click on **Next: Connectivity Settings**. This is an **optional** step required only if the default Vnet configuration has to be altered. We don't recommend making any changes to these settings. Click on **Review + Create**.

 ![DMLZ Deployment Connection Settings](/images/dmlz-deployment-connsettings.png)

5. When the parameters are validated, the **Create** button will be enabled. Click in **Create** to start the deployment.

![DMLZ Deployment Final Step](/images/dmlz-deployment-create.png)

The deployment will take around 20 minutes to complete. You can use the steps [here](/lab1/5_dmlz_validation_steps/) to validate the deployment.
## Next steps

put link to next page here
