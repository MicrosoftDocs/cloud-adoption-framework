---
title: Network topology and connectivity for connecting to environments privately
description: Learn about the network topology for connecting to environments privately.
author: marvinbuss
ms.author: mabuss
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Connect to environments privately

The reference architecture is secure by design. It uses a multilayered security approach to mitigate common data exfiltration risks raised by customers. You can use certain features on a network, identity, data, and service layer to define specific access controls and expose only required data to your users. Even if some of these security mechanisms fail, the features help keep data within the enterprise-scale platform secure.

Network features such as private endpoints and disabled public network access can greatly reduce the attack surface of a data platform within an organization. Even with these features enabled, you need to take extra precautions to successfully connect to services such as Azure storage accounts, Azure Synapse workspaces, or Azure Machine Learning from the public internet.

This document describes the most common options for connecting to services inside a data management landing zone or data landing zone in a simple and secure way.

## Overview of Azure Bastion host and jumpboxes

The simplest solution is to host a jumpbox on the virtual network of the data management landing zone or data landing zone to connect to the data services through private endpoints. A jumpbox is an Azure virtual machine (VM) running Linux or Windows to which users can connect via the Remote Desktop Protocol (RDP) or Secure Shell (SSH).

Previously, jumpbox VMs had to be hosted with public IPs to enable RDP and SSH sessions from the public internet. Network security groups (NSGs) could be used to further lock down traffic to allow connections from only a limited set of public IPs. However, this approach meant that a public IP had to be exposed from the Azure environment, which increased the attack surface of an organization. Alternatively, customers could use DNAT rules in their Azure Firewall to expose the SSH or RDP port of a VM to the public internet, which leads to similar security risks.

Today, instead of exposing a VM publicly, you can rely on Azure Bastion as a more secure alternative. Azure Bastion provides a secure remote connection from the Azure portal to Azure VMs over Transport Layer Security (TLS). Azure Bastion should be set up on a dedicated subnet (subnet with the name `AzureBastionSubnet`) in the Azure data landing zone or Azure data management landing zone. You can then use it to connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. No extra clients or agents need to be installed on any VM. You can again use NSGs to allow RDP and SSH from Azure Bastion only.

:::image type="content" source="../images/bastion-network-architecture.png" alt-text="Diagram of Azure Bastion network architecture." lightbox="../images/bastion-network-architecture.png" :::

Azure Bastion provides a few other core security benefits, including:

- Traffic initiated from Azure Bastion to the target VM stays within the customer virtual network.
- You get protection against port scanning because RDP ports, SSH ports, and public IP addresses aren't publicly exposed for VMs.
- Azure Bastion helps protect against zero-day exploits. It sits at the perimeter of your virtual network. Because it's a platform as a service (PaaS), the Azure platform keeps Azure Bastion up to date.
- The service integrates with native security appliances for an Azure virtual network, such as Azure Firewall.
- Azure Bastion can be used to monitor and manage remote connections.

For more information, see [What is Azure Bastion?](/azure/bastion/bastion-overview).

### Deployment

To simplify the process for users, there's a Bicep/ARM Template that can help you quickly create this setup inside your data management landing zone or data landing zone. Use the template to create the following setup inside your subscription:

:::image type="content" source="../images/bastion-architecture.png" alt-text="Diagram of Azure Bastion architecture." lightbox="../images/bastion-architecture.png" :::

To deploy the Bastion host yourself, select the **Deploy to Azure** button:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fbastionhost%2Fportal.json)

When you deploy Azure Bastion and a jumpbox through the **Deploy to Azure** button, you can provide the same prefix and environment that you use in your data landing zone or data management landing zone. This deployment has no conflicts, and it acts as an add-on to your data landing zone or data management landing zone. You can manually add other VMs to allow more users to work inside the environment.

### Connect to the VM

After the deployment, you'll notice that two extra subnets are created on the data landing zone virtual network.

:::image type="content" source="../images/bastion-subnets.png" alt-text="Screenshot of the Azure Bastion and Jumpbox subnets." lightbox="../images/bastion-subnets.png" :::

In addition, you'll find a new resource group inside your subscription, which includes the Azure Bastion resource and a virtual machine:

:::image type="content" source="../images/bastion-resource-groups.png" alt-text="Screenshot of a list of Azure Bastion resource groups.":::

To connect to the VM by using Azure Bastion, follow these steps:

1. Select the VM (for example, *dlz01-dev-bastion*), select **Connect**, and then select **Bastion**.

    :::image type="content" source="../images/bastion-connect-to-vm.png" alt-text="Screenshot of the Overview pane for connecting to a VM by using Azure Bastion.":::

1. Select the blue **Use Bastion** button.

1. Enter your credentials, and then select **Connect**.

    :::image type="content" source="../images/bastion-enter-credentials.png" alt-text="Screenshot of the 'Connect using Azure Bastion' pane for connecting to your VM by signing in with your credentials." lightbox="../images/bastion-enter-credentials.png" :::

    The RDP session opens on a new browser tab, from which you can start connecting to your data services.

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. Go to the `{prefix}-{environment}-product-synapse001` Azure Synapse workspace inside the `{prefix}-{environment}-shared-product` resource group for data exploration.

    :::image type="content" source="../images/dev-shared-product-synapse.png" alt-text="Screenshot of the 'Synapse workspace' in the Azure portal." lightbox="../images/dev-shared-product-synapse.png" :::

1. In the Azure Synapse workspace, load a sample dataset from the gallery (for example, the NYC Taxi dataset), and then select **New SQL Script** to query `TOP 100` rows.

   :::image type="content" source="../images/new-sql-script.png" alt-text="Screenshot of the Synapse Analytics pane for connecting to a new SQL script." lightbox="../images/new-sql-script.png" :::

If all the virtual networks are peered with each other, only a single jumpbox in one data landing zone is required to access services across all data landing zones and data management landing zones.

To learn why we recommend this network setup, see [Network architecture considerations](../../cloud-scale-analytics/eslz-network-considerations-single-region.md). We recommend a maximum of one Azure Bastion service per data landing zone. If more users require access to the environment, you can add extra Azure VMs to the data landing zone.

## Use point-to-site connections

Alternatively, you can connect users to the virtual network by using point-to-site connections. An Azure-native solution to this approach is to set up a VPN gateway to allow VPN connections between users and the VPN gateway over an encrypted tunnel. After you establish the connection, users can start connecting privately to services that are hosted on the virtual network inside the Azure tenant.

We recommend that you set up the VPN gateway in the hub virtual network of the hub-and-spoke architecture. For detailed, step-by-step guidance on setting up a VPN gateway, see [Tutorial: Create a gateway portal](/azure/vpn-gateway/tutorial-create-gateway-portal).

## Use site-to-site connections

If users are already connected to the on-premises network environment and connectivity should be extended to Azure, you can use site-to-site connections to connect the on-premises and Azure connectivity hub. Like a VPN tunnel connection, the site-to-site connection lets you extend the connectivity to the Azure environment. Doing so allows users who are connected to the corporate network to connect privately to services that are hosted on the virtual network inside the Azure tenant.

The recommended, Azure-native approach to such connectivity is the use of ExpressRoute. We recommend that you set up an ExpressRoute gateway in the hub virtual network of the hub-and-spoke architecture. For detailed, step-by-step guidance on setting up ExpressRoute connectivity, see [Tutorial: Create and modify peering for an ExpressRoute circuit by using the Azure portal](/azure/expressroute/expressroute-howto-routing-portal-resource-manager).

## Next steps

[Enterprise-scale FAQ](../../../ready/enterprise-scale/faq.md)
