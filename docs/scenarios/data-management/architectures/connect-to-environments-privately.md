---
title: Network topology and connectivity for connecting to environments privately
description: Learn about the network topology for connecting to environments privately
author: marvinbuss
ms.author: mabuss
ms.date: 09/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Connecting to Environments Privately

The Enterprise-Scale reference architecture is secure by design and uses a multi-layered security approach to overcome common data exfiltration risks raised by customers. Features on a network, identity, data and service layer, enable customers to define granular access controls to only expose required data to a user. Even if some of these security mechanisms fail, data within the ESA platform stays secure.

Network features like private endpoints and disabled public network access greatly reduce the attack surface of a data platform of an organization. However, with these features enabled, extra steps need to be taken to successfully connect to the respective services like Storage Accounts, Synapse workspaces, Purview, or Azure Machine Learning from the public internet. This document describes the most common options for connecting to services inside the Data Management Zone or Data Landing Zone in a simple and secure way.

## Bastion Host & Jumpbox

The most simple solution is to host a jumpbox on the virtual network of the Data Management Zone or Data Landing Zone to connect to the data services through private endpoints. The jumpbox would be an Azure Virtual Machine (VM) running Linux or Windows to which users can connect via Remote Desktop Protocol (RDP) or Secure Shell Protocol (SSH).

Previously, jumpbox VMs had to be hosted with public IPs to enable RDP and SSH sessions from the public internet. Network Security Groups (NSGs) could be used to further lock down traffic to only allow connections from a limited set of public IPs. However, this meant that a public IP needed to be exposed from the Azure environment, which again increased the attack surface of an organization. Alternatively, customers could have used DNAT rules in their Azure Firewall to expose the SSH or RDP port of a VM to the public internet, leading to similar security risks.

Today, instead of exposing a VM publicly, customers can rely on Azure Bastion as a more secure alternative. Azure Bastion provides a secure remote connection from the Azure portal to Azure VMs over Transport Layer Security (TLS). Azure Bastion should be provisioned to a dedicated subnet (subnet with name `AzureBastionSubnet`) in the Azure Data Landing Zone or Azure Data Management Zone and can then be used to connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. No extra clients or agents need to be installed on any VM. NSGs can again be used to allow RDP and SSH from Azure Bastion only.

:::image type="content" source="../images/bastion-network-architecture.png" alt-text="Azure Bastion Network Architecture" lightbox="../images/bastion-network-architecture.png":::

A few other core security benefits of Azure Bastion are:

1. Traffic initiated from Azure Bastion to the target VM stays within the customer Vnet.
1. Protection against port scanning, since RDP ports, SSH ports, and public IP addresses aren't publicly exposed for VMs.
1. Azure Bastion helps protect against zero-day exploits. It sits at the perimeter of your virtual network. Since it is a PaaS service, the Azure platform keeps Azure Bastion up to date.
1. The service integrates with native security appliances for an Azure virtual network, like Azure Firewall.
1. Azure Bastion can be used to monitor and manage remote connections.

More details about Azure Bastion can be found [What is Bastion?](/azure/bastion/bastion-overview).

### Deployment

To simplify the setup for users, there is a Bicep/ARM template to quickly create this setup inside your Data Management Zone or Data Landing Zone. Our template will create the following setup inside your subscription:

:::image type="content" source="../images/bastion-architecture.png" alt-text="Azure Bastion Architecture" lightbox="../images/bastion-architecture.png":::

To deploy this yourself, use the following Deploy to Azure button:

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fportal.json)

When deploying Azure Bastion and the jumpbox through the Deploy to Azure button, you can provide the same prefix and environment as for your Data Landing Zone or Data Management Zone. There will be no conflicts and this deployment acts as an add-on to your Data Landing or Management Zone. Other, VMs can be added manually to allow more users to work inside the environment.

### Connecting to the VM

After the deployment, you will notice that two extra subnets have been created on the Data Landing Zone Vnet.

:::image type="content" source="../images/bastion-subnets.png" alt-text="Bastion And Jumpbox Subnets" lightbox="../images/bastion-subnets.png":::

In addition, you will find a new resource group inside your subscription, which includes the Azure Bastion resource and a Virtual Machine:

:::image type="content" source="../images/bastion-resource-groups.png" alt-text="Bastion Resource Groups":::

If you want to connect to the VM using Azure Bastion, execute the following steps:

1. Click on the VM (in our case `dlz01-dev-bastion`) > "Connect" > "Bastion".

    :::image type="content" source="../images/bastion-connect-to-vm.png" alt-text="Connect to VM via Bastion":::

2. Click on the blue button "Use Bastion".
3. Enter your Credentials and click "Connect".

    :::image type="content" source="../images/bastion-enter-credentials.png" alt-text="Connect to VM with credentials" lightbox="../images/bastion-enter-credentials.png":::

4. The RDP session opens in a new tab inside your browser and you can start connecting to your data services.
5. Once logged into the VM in a separate browser tab, go to Microsoft Edge and open [Azure portal](https://portal.azure.com/). From here, navigate to the `{prefix}-{environment}-product-synapse001` Synapse workspace inside the `{prefix}-{environment}-shared-product` resource group for data exploration.

    :::image type="content" source="../images/dev-shared-product-synapse.png" alt-text="Connect to Synapse Workspace" lightbox="../images/dev-shared-product-synapse.png":::

6. After logging into the Synapse workspace, load a sample dataset from the gallery (for example, NYC Taxi Dataset). Once imported, click on "New SQL Script" to query "TOP 100 rows".

:::image type="content" source="../images/new-sql-script.png" alt-text="Connect to New SQL Script" lightbox="../images/new-sql-script.png":::

Only a single jumpbox in one of the Data Landing Zones is required to access services across all Data Landing Zones and Data Management Zones, if all the virtual networks have been peered with each other.

More details on why this network setup is recommended can be found [Network Architecture Considerations](../eslz-network-considerations.md) A maximum of one Azure Bastion service is recommended per Data Landing Zone. If more users require access to the environment, extra Azure VMs can be added to the Data Landing Zone.

## Point to Site (P2S) Connection

Another alternative to connect users to the virtual network is by using Point to Site (P2S) connections. An Azure native solution for this approach, requires setting up a VPN Gateway to allow Virtual Private Network (VPN) connections between users and the VPN Gateway over an encrypted tunnel. Once the connection is established, users can start connecting privately to services hosted on the virtual network inside the Azure tenant including storage accounts, Synapse, and Purview.

It is recommended to setup the VPN Gateway in the Hub Vnet of the Hub & Spoke architecture. Detailed step-by-step guidance on how to setup a VPN gateway can be found [Tutorial create gateway portal](/azure/vpn-gateway/tutorial-create-gateway-portal).

## Site to Site (S2S) Connection

If users are already connected to the on-premise network environment and connectivity should be extended to Azure, Site to Site (S2S) connections can be used to connect the on-prem and Azure Connectivity Hub. Similar to the VPN tunnel, the S2S connection allows to extend the connectivity to the Azure environment to allow users connected to the corporate network to connect privately to services hosted on the virtual network inside the Azure tenant including storage accounts, Synapse, and Purview.

The recommended and Azure native approach for such connectivity is the usage of ExpressRoute. It is recommended to setup the ExpressRoute Gateway in the Hub Vnet of the Hub & Spoke architecture. Detailed step-by-step guidance on how to setup ExpressRoute connectivity can be found in [Tutorial: Create and modify peering for an ExpressRoute circuit using the Azure portal](/azure/expressroute/expressroute-howto-routing-portal-resource-manager).

## Next Steps

More guidance around how to setup connectivity to Azure can be found in the [Connectivity to Azure](/azure/cloud-adoption-framework/ready/azure-best-practices/connectivity-to-azure).
