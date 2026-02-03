---
title: Use Azure Bastion for Virtual Machine Remote Access
description: Learn about design and planning considerations for using Azure Bastion to enable secure remote access to virtual machines in Azure.
author: sitarant
ms.author: sitarant
ms.date: 01/10/2025
ms.topic: concept-article
ms.custom: think-tank
---

# Use Azure Bastion for virtual machine remote access

The remote access solution that you choose depends on factors like scale, topology, and security requirements. This article describes how to provide remote access to virtual machines (VMs) that are deployed within an Azure landing zone architecture. This guidance focuses on Azure Bastion for remote access.

Azure offers technologies that work together to facilitate highly secure remote access to virtual machines:
- [Azure Bastion](/azure/bastion/bastion-overview) is a platform as a service (PaaS) solution that you can use to access VMs through a browser or through the native SSH or RDP client on Windows workstations.

- [Just-in-time (JIT)](/azure/defender-for-cloud/just-in-time-access-overview) access is provided through Microsoft Defender for Cloud.
- Hybrid connectivity options, such as Azure ExpressRoute and VPNs.
- A public IP that's attached directly to the VM or through a NAT rule via an Azure public load balancer.

## Design considerations

- When available, you can use existing hybrid connectivity to Azure virtual networks via ExpressRoute or S2S and P2S VPN connections to provide remote access from on-premises to Windows and Linux Azure VMs.

- Network security groups (NSGs) can be used to secure SSH and RDP connections to Azure VMs.
- JIT allows remote SSH and RDP access over the internet without having to deploy any other infrastructure for supported VMs. JIT supports:
  - VMs deployed through Azure Resource Manager.
  -  VMs deployed with classic deployment models.
  -  VMs protected by Azure Firewalls on the same virtual network as the VM.
  -  VMs protected by Azure firewalls controlled by Azure Firewall Manager.
- [Azure Bastion](/azure/bastion/bastion-overview) provides an extra layer of control. It enables highly secure and seamless RDP and SSH connectivity to your VMs directly from the Azure portal or [native client](/azure/bastion/native-client) over a secure TLS channel. Azure Bastion also negates the need for hybrid connectivity.
- Use the appropriate Azure Bastion SKU based on your requirements. For more information, see [Azure Bastion configuration settings](/azure/bastion/configuration-settings).
- Review the [Azure Bastion FAQ](/azure/bastion/bastion-faq) for answers to common questions about the service.
- Azure Bastion with Kerberos authentication requires that both the domain controllers and Azure Bastion be located in the same virtual network. For more information, see [Azure Bastion Kerberos authentication](/azure/bastion/kerberos-authentication-portal).
- Azure Bastion can be used in an [Azure Virtual WAN topology](./virtual-wan-network-topology.md). However, there are some limitations:
  - Azure Bastion can't be deployed inside of a Virtual WAN virtual hub.
  
  - Azure Bastion must use the Premium or Standard SKU. The *IP-based connection* feature must be enabled on the Azure Bastion resource. For more information, see [Azure Bastion IP-based connection documentation](/azure/bastion/connect-ip-address).
  - Azure Bastion can be deployed in any spoke virtual network that's connected to a Virtual WAN. Azure Bastion provides access to VMs in its own virtual network via Virtual WAN virtual network connections. It can also provide access to VMs in other virtual networks that are connected to the same Virtual WAN through its associated hubs. A successful deployment requires the appropriate [routing](/azure/virtual-wan/about-virtual-hub-routing) configuration. For example, you can deploy Azure Bastion by using the [virtual hub extension pattern](/azure/architecture/networking/guide/private-link-virtual-wan-dns-virtual-hub-extension-pattern).
  - The Azure Bastion Standard SKU requires a dedicated subnet (AzureBastionSubnet), while the Developer SKU doesn't.
- The [Developer SKU](/azure/bastion/quickstart-host-portal) is a free, zero-configuration, always-on version of the Azure Bastion service. Unlike the Standard SKU, the Developer SKU isn't a dedicated resource but it operates as part of a shared pool and doesn't support virtual network peering.

> [!TIP]
> Azure Bastion IP-based connection also allows for connectivity to on-premises-based machines if hybrid connectivity exists between the Azure Bastion resource and the machine that you want to connect to. For more information, see [Connect to a VM via a specified private IP address](/azure/bastion/connect-ip-address).

## Design recommendations

- For production workloads, deploy the Azure Bastion Premium or Standard SKU. For sandbox and test environments, use the Developer SKU in [selected regions](/azure/bastion/quickstart-host-portal).

- Use existing ExpressRoute or VPN connectivity to provide remote access to Azure VMs that are accessible from your on-premises network.
- In a Virtual WAN-based network topology where you require remote access to VMs over the internet, you can deploy Azure Bastion in each spoke virtual network of the respective VMs.

  Or you might deploy a centralized Azure Bastion instance in a single spoke in your Virtual WAN topology. This configuration reduces the number of Azure Bastion instances to manage in your environment. This scenario requires users who sign in to Windows and Linux VMs via Azure Bastion to have a [Reader role on the Azure Bastion resource and the chosen spoke virtual network](/azure/bastion/bastion-faq#peering). Some implementations might have security or compliance considerations that restrict or prevent this requirement. The following diagram shows an Azure Virtual WAN topology.

  :::image type="content" source="./media/azure-virtual-wan-topology-bastion.png" alt-text="Diagram that shows an Azure Virtual WAN topology." lightbox="./media/azure-virtual-wan-topology-bastion.png" border="false":::

- In a hub-and-spoke network topology where you require remote access to Azure VMs over the internet:
  - You can deploy a single Azure Bastion host in the hub virtual network, which can provide connectivity to Azure VMs on spoke virtual networks via virtual network peering. This configuration reduces the number of Azure Bastion instances to manage in your environment. This scenario requires users who sign in to Windows and Linux VMs via Azure Bastion to have a [Reader role on the Azure Bastion resource and the hub virtual network](/azure/bastion/bastion-faq#peering). Some implementations might have security or compliance considerations that restrict or prevent this requirement. The following diagram shows an Azure hub-and-spoke topology.
  
  :::image type="content" source="./media/azure-hub-spoke-bastion.png" alt-text="Diagram that shows an Azure hub-and-spoke topology." lightbox="./media/azure-hub-spoke-bastion.png" border="false":::
  
  - Your environment might not permit granting users the Reader role-based access control (RBAC) role on the Azure Bastion resource and the hub virtual network. Use Azure Bastion Basic or Standard SKU to provide connectivity to VMs within a spoke virtual network. Deploy a dedicated Azure Bastion instance into each spoke virtual network that requires remote access. The following diagram shows an Azure standalone virtual network topology.
  
  :::image type="content" source="./media/azure-standalone-bastion.png" alt-text="Diagram that shows an Azure standalone virtual network topology." lightbox="./media/azure-standalone-bastion.png" border="false":::

- Configure NSG rules to protect Azure Bastion and the VMs to which it provides connectivity. For more information, see [Work with VMs and NSGs in Azure Bastion](/azure/bastion/bastion-nsg).
- Configure Azure Bastion diagnostic logs to be sent to the central Log Analytics workspace. For more information, see [Enable and work with Azure Bastion resource logs](/azure/bastion/monitor-bastion).
- Ensure that you create the [required RBAC role assignments](/azure/bastion/bastion-faq#roles) for the users or groups that connect to the VMs via Azure Bastion.
- If you connect to Linux VMs via SSH, establish the connection via a [private key in Azure Key Vault](/azure/bastion/bastion-connect-vm-ssh-linux#akv).
- Deploy Azure Bastion and ExpressRoute or VPN access to address specific needs like emergency break-glass access.
- Don't enable remote access to Windows and Linux VMs via public IPs directly attached to the VMs. Don't deploy remote access without strict NSG rules and firewalling.