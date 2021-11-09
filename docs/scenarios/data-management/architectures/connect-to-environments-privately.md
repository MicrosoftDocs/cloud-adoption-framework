---
title: Network topology and connectivity for connecting to environments privately
description: Learn about the network topology for connecting to environments privately
author: marvinbuss
ms.author: mabuss
ms.date: 11/08/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Connecting to environments privately

The enterprise-scale reference architecture is secure by design and uses a multilayered security approach to overcome common data exfiltration risks raised by customers. Features on a network, identity, data and service layer, enable customers to define granular access controls to only expose required data to a user. Even if some of these security mechanisms fail, data within the ESA platform stays secure.

Network features like private endpoints and disabled public network access greatly reduce the attack surface of a data platform of an organization. However, with these features enabled, extra steps need to be taken to successfully connect to the respective services like Azure Storage accounts, Azure Synapse workspaces, Azure Purview, or Azure Machine Learning from the public internet. This document describes the most common options for connecting to services inside the data management zone or data landing zone in a simple and secure way.

## Bastion host and jumpbox

The most simple solution is to host a jumpbox on the virtual network of the data management zone or data landing zone to connect to the data services through private endpoints. The jumpbox would be an Azure virtual machine (VM) running Linux or Windows to which users can connect via Remote Desktop Protocol (RDP) or Secure Shell protocol (SSH).

Previously, jumpbox VMs had to be hosted with public IPs to enable RDP and SSH sessions from the public internet. Network security groups (NSGs) could be used to further lock down traffic to only allow connections from a limited set of public IPs. However, this meant that a public IP needed to be exposed from the Azure environment, which again increased the attack surface of an organization. Alternatively, customers could have used DNAT rules in their Azure Firewall to expose the SSH or RDP port of a VM to the public internet, leading to similar security risks.

Today, instead of exposing a VM publicly, customers can rely on Azure Bastion as a more secure alternative. Azure Bastion provides a secure remote connection from the Azure portal to Azure VMs over Transport Layer Security (TLS). Azure Bastion should be provisioned to a dedicated subnet (subnet with name `AzureBastionSubnet`) in the Azure data landing zone or Azure data management zone and can then be used to connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. No extra clients or agents need to be installed on any VM. NSGs can again be used to allow RDP and SSH from Azure Bastion only.

:::image type="content" source="../images/bastion-network-architecture.png" alt-text="Azure Bastion Network Architecture" lightbox="../images/bastion-network-architecture.png":::

A few other core security benefits of Azure Bastion are:

- Traffic initiated from Azure Bastion to the target VM stays within the customer VNet.
- Protection against port scanning, since RDP ports, SSH ports, and public IP addresses aren't publicly exposed for VMs.
- Azure Bastion helps protect against zero-day exploits. It sits at the perimeter of your virtual network. Since it's a PaaS service, the Azure platform keeps Azure Bastion up to date.
- The service integrates with native security appliances for an Azure virtual network, like Azure Firewall.
- Azure Bastion can be used to monitor and manage remote connections.

More details about Azure Bastion can be found in [What is Azure Bastion?](/azure/bastion/bastion-overview).

### Deployment

To simplify the setup for users, there is a Bicep/ARM template to quickly create this setup inside your data management zone or data landing zone. Our template will create the following setup inside your subscription:

:::image type="content" source="../images/bastion-architecture.png" alt-text="Azure Bastion Architecture" lightbox="../images/bastion-architecture.png":::

To deploy this yourself, use this **Deploy to Azure** button:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fportal.json)

When deploying Azure Bastion and the jumpbox through the deploy to Azure button, you can provide the same prefix and environment as for your data landing zone or data management zone. There will be no conflicts and this deployment acts as an add-on to your data landing zone or data management zone. Other, VMs can be added manually to allow more users to work inside the environment.

### Connecting to the VM

After the deployment, you will notice that two extra subnets have been created on the data landing zone VNet.

:::image type="content" source="../images/bastion-subnets.png" alt-text="Bastion And Jumpbox Subnets" lightbox="../images/bastion-subnets.png":::

In addition, you will find a new resource group inside your subscription, which includes the Azure Bastion resource and a virtual machine:

:::image type="content" source="../images/bastion-resource-groups.png" alt-text="Bastion Resource Groups":::

If you want to connect to the VM using Azure Bastion, execute the following steps:

1. Click on the VM (in this case `dlz01-dev-bastion`) > **Connect** > **Bastion**.

    :::image type="content" source="../images/bastion-connect-to-vm.png" alt-text="Connect to VM via Bastion":::

2. Click on the blue **Use Bastion** button.

3. Enter your credentials and click **Connect**.

    :::image type="content" source="../images/bastion-enter-credentials.png" alt-text="Connect to VM with credentials" lightbox="../images/bastion-enter-credentials.png":::

4. The RDP session opens in a new tab inside your browser and you can start connecting to your data services.

5. Once signed in to the VM in a separate browser tab, go to Microsoft Edge and open [Azure portal](https://portal.azure.com/). From here, navigate to the `{prefix}-{environment}-product-synapse001` Azure Synapse workspace inside the `{prefix}-{environment}-shared-product` resource group for data exploration.

    :::image type="content" source="../images/dev-shared-product-synapse.png" alt-text="Connect to Synapse Workspace" lightbox="../images/dev-shared-product-synapse.png":::

6. After signing in to the Azure Synapse workspace, load a sample dataset from the gallery (for example, the NYC Taxi dataset). Once imported, click on **New SQL Script** to query `TOP 100` rows.

:::image type="content" source="../images/new-sql-script.png" alt-text="Connect to New SQL Script" lightbox="../images/new-sql-script.png":::

Only a single jumpbox in one of the data landing zones is required to access services across all data landing zones and data management zones, if all the virtual networks have been peered with each other.

More details on why this network setup is recommended can be found in [Network architecture considerations](../eslz-network-considerations.md). A maximum of one Azure Bastion service is recommended per data landing zone. If more users require access to the environment, extra Azure VMs can be added to the data landing zone.

## Point-to-Site connection

Another alternative to connect users to the virtual network is by using Point-to-Site connections. An Azure native solution for this approach, requires setting up a VPN gateway to allow virtual private network (VPN) connections between users and the VPN gateway over an encrypted tunnel. Once the connection is established, users can start connecting privately to services hosted on the virtual network inside the Azure tenant including storage accounts, synapse, and purview.

It's recommended to set up the VPN gateway in the hub VNet of the hub and spoke architecture. Detailed step-by-step guidance on how to set up a VPN gateway can be found in [Tutorial create gateway portal](/azure/vpn-gateway/tutorial-create-gateway-portal).

## Site-to-Site connection

If users are already connected to the on-premises network environment and connectivity should be extended to Azure, Site-to-Site connections can be used to connect the on-premises and Azure connectivity hub. Similar to the VPN tunnel, the Site-to-Site connection allows to extend the connectivity to the Azure environment to allow users connected to the corporate network to connect privately to services hosted on the virtual network inside the Azure tenant including Azure Storage accounts, Azure Synapse, and Azure Purview.

The recommended and Azure native approach for such connectivity is the usage of ExpressRoute. It's recommended to set up the ExpressRoute gateway in the hub VNet of the hub and spoke architecture. Detailed step-by-step guidance on how to set up ExpressRoute connectivity can be found in [Tutorial: Create and modify peering for an ExpressRoute circuit using the Azure portal](/azure/expressroute/expressroute-howto-routing-portal-resource-manager).

## Next steps

More guidance on how to set up connectivity to Azure can be found in [Connectivity to Azure](/azure/cloud-adoption-framework/ready/azure-best-practices/connectivity-to-azure).
