---
title: Plan for virtual machine remote access
description: Plan for virtual machine remote access
author: sitarant
ms.author: sitarant
ms.date: 02/25/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Plan for virtual machine remote access

This document describes the recommended guidance for providing remote access to virtual machines deployed within an Azure landing zones architecture.
Azure offers different technologies for providing remote access to virtual machines: 

- [Azure Bastion](/azure/bastion/bastion-overview), a PaaS solution, for accessing virtual machines through a browser or currently in preview through the native SSH/RDP client on Windows workstations 
- Just in time [JIT](/azure/defender-for-cloud/just-in-time-access-overview) access provided through Microsoft Defender for Cloud
- Hybrid connectivity options such as ExpressRoute and VPN
- Public IP attached directly to the virtual machine or through a NAT rule via an Azure public load balancer

The choice of which remote access solution is most appropriate depends on several factors such as scale, topology and security requirements.

## Design considerations

- When available, you can use existing hybrid connectivity to Azure VNets via ExpressRoute or S2S/P2S VPN connections to provide remote access from on-premises to Windows and Linux Azure VMs.
- NSGs can be used to secure SSH/RDP connections to Azure VMs.
- Just-in-time allows remote SSH/RDP access over the internet without having to deploy any additional infrastructure.
- Note that there are some [availability limitation](/azure/defender-for-cloud/just-in-time-access-usage) with JIT access.
  - Just-in-time access cannot be used for VMs protected by Azure firewalls controlled by Azure Firewall Manager.
- [Azure Bastion](/azure/bastion/bastion-overview) provides an additional layer of control, enabling secure and seamless RDP/SSH connectivity to your virtual machines directly from the Azure portal or [native client](/azure/bastion/connect-native-client-windows) in preview over a secure TLS channel, also negating the need for hybrid connectivity.
- Consider the appropriate Azure Bastion SKU to use based on your requirements as documented in [About Azure Bastion configuration settings](/azure/bastion/configuration-settings).
- Review the [Azure Bastion FAQ](/answers/products/) for answers to common questions you may have about the service.
- Bastion can be used in Virtual WAN topology, however there are some known limitations, such as:
  - Azure Bastion cannot be deployed in an Azure Virtual WAN virtual hub.
  - Azure Bastion is currently not supported with Azure Virtual WAN's native routing capabilities, instead, it must be deployed within each spoke VNet to provide connectivity to VMs within the same VNet. 
  
## Design recommendations

- Use existing ExpressRoute or VPN connectivity to provide remote access to Azure Virtual Machines that are accessible from on-premises via the ExpressRoute or VPN connections.
- In a Virtual WAN-based network topology where remote access to Azure Virtual Machines over the internet is required, deploy Azure Bastion in each spoke VNet of the respective VMs as depicted in Figure 1 below.
- In hub-and-spoke network topology, where remote access to Azure Virtual Machines over the internet is required:
  - A single Azure Bastion host can be deployed in the hub VNet, which can provide connectivity to Azure VMs on spoke VNets via VNet peering. This configuration will reduce the number of bastion instances to manage in your environment. However, this scenario requires that users logging on to Windows and Linux VMs via bastion to have [Reader role on the Azure Bastion resource as well as the hub virtual network](/azure/bastion/bastion-faq#peering), which may have security/compliance considerations in some implementations. See Figure 2 below.
  - If in your environment is not permitted to grant users the reader RBAC role on the Azure Bastion resource as well as the hub VNet, use Azure Bastion (basic or Standard SKU) to provide connectivity to virtual machines within a spoke VNet by deploying a dedicated Azure Bastion instance into each spoke VNet that requires remote access. See Figure 3 below.
- Configure NSG rules to protect Azure Bastion and the virtual machines to which it provides connectivity as per the guidance documented in [Working with VMs and NSGs in Azure Bastion](/azure/bastion/bastion-nsg).
- Configure Azure Bastion diagnostic logs to be sent to the central Log Analytics workspace as documented in [Enable and work with Azure Bastion resource logs](/azure/bastion/diagnostic-logs).
- Ensure the [required RBAC role assignments](/azure/bastion/bastion-faq#roles) are made for the users/groups connecting to the virtual machines via Azure Bastion are in place.
- If connecting to Linux virtual machines via SSH, use the feature of [connecting using a private key stored in Azure Key Vault](/azure/bastion/bastion-connect-vm-ssh-linux#akv).
- Deploy Azure Bastion in addition to ExpressRoute or VPN access to address specific needs such as emergency break-glass access.
- Remote access to Windows and Linux VMs via public IPs directly attached to the virtual machines is discouraged and should never be deployed without very strict NSG rules and firewalling.

:::image type="content" source="./media/azure-virtual-wan-topology-bastion.png" alt-text="Diagram that shows Azure virtual WAN topology." lightbox="./media/azure-virtual-wan-topology-bastion.png":::

  *Figure 1: Azure Virtual WAN topology.*

:::image type="content" source="./media/azure-hub-spoke-bastion.png" alt-text="Diagram that shows Azure hub and spoke topology." lightbox="./media/azure-hub-spoke-bastion.png":::

   *Figure 2: Azure Hub&Spoke topology.*

:::image type="content" source="./media/azure-standalone-bastion.png" alt-text="Diagram that shows Azure standalone VNet topology." lightbox="./media/azure-standalone-bastion.png":::

   *Figure 3: Azure Standalone VNet topology.*
   
