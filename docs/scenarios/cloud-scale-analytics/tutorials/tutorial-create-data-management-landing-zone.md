---
title: Create data management landing zone tutorial
description: Learn about create data management landing zone tutorial
author: andrehass
ms.author: anhass
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank, references_regions
---

# Create data management landing zone tutorial

## Data Management Landing Zone

Data Management Zone is at the heart of the DMA platform. It provides all data management for the data platform of an organization and enables central governance of data assets across all Data Landing Zones.

## What will be deployed?

The following services are deployed in the Data Management Landing Zone, in the order presented.

> [!NOTE]
>Before deploying the resources, we recommend checking the registration status of the required resource providers in your subscription. For more information, see [Resource providers for Azure services](/azure/azure-resource-manager/management/resource-providers-and-types).

:::image type="content" source="../images/data-management-zone.png" alt-text="Diagram of the Data Management Zone.":::

The deployment and code artifacts include the following services:

- [Virtual Network](/azure/virtual-network/virtual-networks-overview)
- [Network Security Groups](/azure/virtual-network/network-security-groups-overview)
- [Route Tables](/azure/virtual-network/virtual-networks-udr-overview)
- [Azure Firewall](/azure/firewall/overview)
- [Firewall Policy](/azure/firewall-manager/policy-overview#:~:text=Firewall%20Policy%20is%20an%20Azure,work%20across%20regions%20and%20subscriptions.)
- [Private DNS Zones](/azure/dns/private-dns-privatednszone#:~:text=By%20using%20private%20DNS%20zones,that%20are%20linked%20to%20it.)
- [Container Registry](/azure/container-registry/)
- [Purview](/azure/purview/)
- [Key Vault](/azure/key-vault/general)
- [Storage Account](/azure/storage/common/storage-account-overview)
- [Synapse Private Link Hub](/azure/synapse-analytics/security/synapse-private-link-hubs)
- [PowerBI](/power-bi/fundamentals/power-bi-overview)
- [Policies](/azure/governance/policy/overview)

The remainder of this tutorial will walk through the steps to deploy a Data Management Landing Zone.

## Supported regions

We recommend selecting one of the regions mentioned below. The list of regions is limited for now as all services and features are not available in all regions. This is mostly because we recommend at least the zone-redundant storage replication option for all your central Data Lakes in the Data Landing Zones, and this is only available in selected regions. If you are planning to deploy the Data Management Zone and Data Landing Zone to a region that is not listed below, then please change the setting in the corresponding bicep files in this repository. Officially supported regions are:

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

The following pre-requisites are common to all the deployment options.

- **An Azure subscription**: The Data Management Landing Zone will be deployed into a separate azure subscription. Please ensure there is a subscription ready for this.

:::image type="content" source="../images/marketplace-subscription.png" alt-text="Screenshot showing the subscription search screen.":::

- **Permissions to the Azure subscription**: User Access Administrator or Owner access to the subscription to be able to create a service principal and role assignments for it (next step).

- **Subscription Information**: Open the Azure portal. Navigate to the subscription to be used to deploy the Data Management Landing Zone and make a note of the subscription ID.

- **Azure CLI**: You can use Cloud Shell from the Azure Portal or work with Azure CLI on the desktop. Instructions to setup Azure CLI on the desktop can be found [here](/cli/azure/install-azure-cli).

## Deploy Data Management Landing Zone via One Click

This is a UI based deployment option that lets you deploy the Data Management Landing Zone into your Azure subscription.

Before beginning with the deployment, we have to check that the necessary resource providers are registered within this subscription. To check this, please follow the steps below.

1. In the Azure portal, navigate to the subscription

    :::image type="content" source="../images/marketplace-subscription.png" alt-text="Screenshot showing the search for a subscription screen.":::

1. Select the relevant subscription and click on **Resource Providers** in the left menu.

    :::image type="content" source="../images/dmlz-deployment-3.png" alt-text="Screenshot showing the resource provider tab.":::

1. Find Microsoft.Purview by filtering on the name.

    :::image type="content" source="../images/dmlz-deployment-purview-rp.png" alt-text="Screenshot showing how to find Microsoft Purview.":::

1. If the status shows Not Registered, click on the **Register** option on top to register the resource provider.

1. Repeat steps 3 and 4 for two more resource providers
    - Microsoft.EventHub
    - Microsoft.Storage

1. Your resource providers list should now look similar to this screenshot below

    :::image type="content" source="../images/dmlz-deployment-4.png" alt-text="Screenshot of the resource Providers List.":::

    Once this is done, we can go ahead and deploy the Data Management Landing Zone to this subscription. The following steps guide you through this process.

1. Click on the **Deploy to Azure** button below. Verify that the right button corresponding to the Data Management Landing Zone is clicked. This opens a new page in the Azure portal.

   | Reference implementation   | Description | Deploy to Azure | Link |
   |:---------------------------|:------------|:----------------|------|
   | Data Management Landing Zone       | Deploys a single Data Management Landing Zone to a subscription. |[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataManagementZone.json) | [Repository](https://github.com/Azure/data-management-zone) |

1. In the **Data Management Zone** page, provide the following information:

    | Setting| Suggested Value(s)  |
    |:-------|:--------------------|
    |Subscription |Select the subscription to deploy the Data Management Landing Zone to. If you have access to multiple subscriptions, please choose the correct one. |
    |Location |Select from the dropdown. If there are no organizational policies influencing the location, it is a good idea to pick a region that is physically close to you. Please verify that this region is supported for Enterprise Scale Analytics. A list of supported regions are available here and navigate to “Supported Regions” |
    |Environment|We recommend you choose Development, as this is a tutorial. You could use the same process to deploy a Test or Production environment as well.|
    |Data Management Landing Zone prefix|This is a prefix added to all the deployed resource groups and resources to make them unique within the subscription. This can be a max of 10 alphanumeric characters.|

    :::image type="content" source="../images/dmlz-1.png" alt-text="Screenshot showing the Data Management Zone Step one.":::

1. Optionally, click on **Next: General Settings**. This is required only if a user other than yourself has to be added as a collection admin in the Purview instance. To add a user, navigate to Azure Active Directory and in the list of users, select the relevant user to find the Object ID. Click on the Copy to Clipboard icon.

    :::image type="content" source="../images/dmlz-2.png" alt-text="Deployment Purview Root Collection object I D":::

1. Paste this into the Purview Root Collection Admin ID.

    :::image type="content" source="../images/dmlz-3.png" alt-text="Screenshot showing the general Settings Step.":::

1. Click on **Next: Connectivity Settings**. This is an **optional** step required only if the default Vnet configuration has to be altered. We don't recommend making any changes to these settings. Click on **Review + Create**.

    :::image type="content" source="../images/dmlz-4.png" alt-text="Screenshot showing the  connectivity settings step.":::

1. When the parameters are validated, the **Create** button will be enabled. Click in **Create** to start the deployment.

    :::image type="content" source="../images/dmlz-5.png" alt-text="Screenshot showing the review and create step.":::

The deployment will take around 20 minutes to complete. You can use the steps [here](/lab1/5_dmlz_validation_steps/) to validate the deployment.

## Connecting to environments privately

At this point you should have completed the deployment of the Data Management Landing Zone. In the next steps, you will need to access the services that are deployed in the Data Management Landing Zone, Data Landing Zone, and Data Product such as Azure Data Factory, Synapse Analytics, and Purview.

The Cloud-scale Analytics reference architecture is secure by design and uses a multi-layered security approach to overcome common data exfiltration risks raised by customers.

Network features like private endpoints and disabled public network access greatly reduce the attack surface of a data platform of an organization. However, with these features enabled, additional steps need to be taken to successfully connect to the respective services like Storage Accounts, Synapse workspaces, Purview or Azure Machine Learning from the public internet. We will describe the most common options for connecting to services inside the Data Management Landing Zone or Data Landing Zone in a simple and secure way.

Next, you will follow the steps to deploy a managed Bastion Host on Azure as well as a VM that will service a jumpbox to access any of the private endpoints in the VNETs. That includes Data Management Landing Zone and Data Landing Zone VNETs as they are all peered.

## Bastion Host and Jumpbox

The most simple solution is to host a jumpbox on the virtual network of the Data Management Landing Zone or Data Landing Zone to connect to the data services through private endpoints. The jumpbox would be an Azure Virtual Machine (VM) running Linux or Windows to which users can connect via Remote Desktop Protocol (RDP) or Secure Shell Protocol (SSH).

Previously, jumpbox VMs had to be hosted with public IPs to enable RDP and SSH sessions from the public internet. Network Security Groups (NSGs) could be used to further lock down traffic to only allow connections from a limited set of public Ips. However, this meant that a public IP needed to be exposed from the Azure environment, which again increased the attack surface of an organization. Alternatively, customers could have used DNAT rules in their Azure Firewall to expose the SSH or RDP port of a VM to the public internet, leading to similar security risks.

Today, instead of exposing a VM publicly, customers can rely on Azure Bastion as a more secure alternative. Azure Bastion provides a secure remote connection from the Azure portal to Azure VMs over Transport Layer Security (TLS). Azure Bastion needs to be provisioned to a dedicated subnet (subnet with name `AzureBastionSubnet`) in the Azure Data Landing Zone or Azure Data Management Landing Zone and can then be used to connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. No additional clients or agents need to be installed on any VM. NSGs can again be used to allow RDP and SSH from Azure Bastion only.

:::image type="content" source="../images/azure-bastion-network-architecture.png" alt-text="Diagram of the Azure Bastion Network Architecture.":::

A few other core security benefits of Azure Bastion are:

1. The traffic initiated from Azure Bastion to the target VM stays within the customer VNET.
1. Protection against port scanning, since RDP ports, SSH ports, and public IP addresses aren't publicly exposed for VMs.
1. Azure Bastion helps protect against zero-day exploits. It sits at the perimeter of your virtual network. So you don't need to worry about hardening each of the virtual machines in your virtual network. The Azure platform keeps Azure Bastion up to date since it is a PaaS service.
1. The service integrates with native security appliances for an Azure virtual network, like Azure Firewall.
1. Azure Bastion can be used to monitor and manage remote connections.

More details about Azure bastion can be found [here](/azure/bastion/bastion-overview).

### Deployment

To simplify the setup for cloud-scale analytics users, we provide a Bicep/ARM template to quickly create this setup inside your Data Management Landing Zone or Data Landing Zone. Our template will create the following setup inside your subscription:

:::image type="content" source="../images/azure-bastion-architecture.png" alt-text="Diagram of Azure Bastion Architecture.":::

To deploy this yourself, please use the following Deploy to Azure button:

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fportal.json)

## Deploy Azure Bastion Host

Deploy Azure Bastion Host template in the Data Management Landing Zone deployed in the previous tutorial.

1. Provide the following information on the **Bastion** tab.

    | Setting| Suggested Value(s)  |
    |:-------|:--------------------|
    |Subscription |  Select the subscription |
    | Location | Use the same location used to deploy the Data Management Landing Zone. |
    |Environment| Select Development|
    | Data Landing Zone Prefix |  Provide the **Data Management Landing Zone prefix** deployed in the previous step. |

    :::image type="content" source="../images/bastion-host-1.png" alt-text="Screenshot showing how to deploy Bastion Host.":::

1. Click Next to go to **General Settings** and provide the following information:

    | Setting| Suggested Value(s)  |
    |:-------|:--------------------|
    | Username | Leave it as is. You will use **VMMainUser** user to access the VM in a future step. |
    | Password | Enter the VM password for this user. |
    | Confirm Password | Confirm the password. |
    | VM SKU | Leave it unchanged. |

    :::image type="content" source="../images/bastion-host-2.png" alt-text="Screenshot showing Bastion General Settings page.":::

1. Click Next to go to **Connectivity Settings** and provide the following information:

    | Setting| Suggested Value(s)  |
    |:-------|:--------------------|
    | Data Landing Zone Default Network | Choose the **Data Management Landing Zone** Virtual network. **_`[DMLZprefix]`_`-dev-vnet`**.  |
    | Data Landing Zone Default Network Security Group | Choose the **Data Management Landing Zone** default Network Security Group. **_`[DMLZprefix]`_`-dev-nsg`**. |
    | Data Landing Zone Default Route Table | Choose the **Data Management Landing Zone** default route table. **_`[DMLZprefix]`_`-dev-routetable`**. |
    | Bastion Subnet CIDR Range | Ensure you are selecting the CIDR range that is within the **Data Management Landing Zone** CIDR range. Change it to **10.0.10.0/24** |
    | Jumpbox Subnet CIDR Range | Ensure you are selecting the CIDR range that is within the **Data Management Landing Zone** CIDR range. Change it to **10.0.11.0/24** |

    :::image type="content" source="../images/bastion-host-3.png" alt-text="Screenshot showing showing the Bastion Connectivity settings.":::

1. Click **Review + Create** and then click **Create** on the **Review + create** tab to start the deployment.

    :::image type="content" source="../images/bastion-host-4.png" alt-text="Screenshot showing how to review and create in Bastion.":::

    The deployment will take around 5 minutes to complete.

### Connecting to the VM

After the deployment, you will notice that two additional subnets have been created on the Data Management Landing Zone VNET.

:::image type="content" source="../images/azure-bastion-subnets.png" alt-text="Screenshot showing Bastion and Jumpbox Subnets.":::

In addition, you will find a new resource group inside your subscription, named **_`[DLZprefix]`_`-dev-bastion`** which includes the Azure Bastion resource as well as a Virtual Machine:

:::image type="content" source="../images/bastion-vm-connect.png" alt-text="Screenshot showing how Bastion Host V M.":::

If you want to connect to the VM using Azure Bastion, execute the following steps:

1. Click on the VM (in our case `dmalabs-dev-vm001`) > "Connect" > "Bastion".

    :::image type="content" source="../images/bastion-host-6.png" alt-text="Screenshot showing how to connect to V M via Bastion.":::

1. Click on the blue button "Use Bastion".
1. Enter your Credentials and click "Connect".

    :::image type="content" source="../images/bastion-host-7.png" alt-text="Screenshot showing how User Name and Password entry for Bastion V M.":::

1. The RDP session opens in a new Tab inside your Browser and you can start connecting to your data services.
1. Once logged into the VM in a separate browser tab, go to Microsoft Edge and open [Azure Portal](https://portal.azure.com/).
