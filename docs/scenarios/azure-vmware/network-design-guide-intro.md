---
title: Azure VMware Solution network design guide
description: Learn how to design network connectivity for Azure VMware Solution. Learn about connectivity with on-premises datacenters, virtual networks, and more. 
author: fguerri
ms.author: fguerri
ms.date: 09/06/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Azure VMware Solution landing zone accelerator network design guide

This guide covers network design for the Azure VMware Solution landing zone accelerator. It encompasses four design areas:

- **Connectivity with on-premises datacenters**. Connectivity between Azure VMware Solution private clouds and on-premises sites supports a broad set of use cases: HCX migrations, hybrid applications, and remote vCenter or NSX-T Data Center administration. Azure VMware Solution supports multiple options for hybrid connectivity, including Azure ExpressRoute circuits and internet-based IPSec virtual private networks.

- **Connectivity with Azure virtual networks**. Azure VMware Solution runs on bare-metal VMware vSphere clusters that can be connected to native Azure virtual networks via Azure ExpressRoute. ExpressRoute connections between Azure VMware Solution private clouds and Azure virtual networks enable you to build applications that span the two environments or to use jump box virtual machines in Azure to log in to vCenter (vSphere Client) and NSX-T Manager console for administration purposes.

- **Inbound internet connectivity**. Inbound internet connectivity enables applications running on Azure VMware Solution to be exposed to the internet via public IP addresses. Internet-facing applications are almost invariably published through security devices (application delivery controllers, web application firewalls, L3/L4 next-generation firewalls, and so on). Design decisions about inbound connectivity are primarily driven by the placement of such devices (in Azure VMware Solution or in Azure virtual networks). 

- **Outbound internet connectivity**. Outbound internet connectivity is needed when applications running on Azure VMware Solution need access to public endpoints. Typical use cases include downloading software updates, consuming public web sites or APIs, and internet browsing (for example, when Azure VMware Solution is used to run [VDI solutions](/azure/azure-vmware/azure-vmware-solution-horizon)). Azure VMware Solution provides several options for implementing outbound internet connectivity. They might or might not rely on Azure native resources. Security requirements, like firewalling and forward proxying, typically drive design decisions in this area.

Azure VMware Solution provides native functionality to address the most common requirements in each design area, so you don't need to deploy more Azure resources. These native functionalities are covered in the [documentation](/azure/azure-vmware/concepts-networking). However, in enterprise scenarios, it's common for Azure VMware Solution to be part of a larger infrastructure that includes Azure network services, like Azure Firewall and Azure Application Gateway, or third-party network virtual appliances. This guide helps you design these more advanced solutions.

To design advanced Azure VMware Solution network architectures, you need a solid understanding of [Azure VMware Solution networking basics](azure-vmware-solution-network-basics.md). This understanding is a prerequisite to effectively using this guide.

## Design area prioritization and dependencies

The four design areas aren't independent of each other. Design decisions made for one area can limit the available options in other areas. We recommend that you address the four areas in the order shown here:

:::image type="content" source="media/flowchart.png" alt-text="Flowchart that shows the order in which to address each design area." lightbox="media/flowchart.png":::

As shown in the preceding flowchart, we recommend the following four-step approach to network design for Azure VMware Solution:

1. **Design connectivity with on-premises datacenters first.** The key decisions for this area are: 
   - Which connectivity service to use between on-premises sites and the edge of the Microsoft network (internet vs. ExpressRoute).
   - Whether traffic should be routed directly to Azure VMware Solution (recommended) or through virtual devices running in Azure virtual networks.  

   Read [Design phase 1: Connectivity with on-premises sites](on-premises-connectivity.md) to learn the options that Azure VMware Solution supports and how to choose one.

2. **Identify the virtual network connectivity option that's aligned to the design choices made in phase 1.** Determine whether more routing/security configuration is needed in Azure virtual networks. The most typical requirement is firewall inspection for traffic between Azure VMware Solution and Azure native virtual machines. Read [Design phase 2: Azure virtual network connectivity](virtual-network-connectivity.md) to learn how design decisions for connectivity with on-premises sites influence the way an Azure VMware Solution private cloud connects to Azure virtual networks.

3. **Decide how internet-facing applications running on Azure VMware Solution should be published (inbound internet connectivity).** Azure VMware Solution supports using Public IPs associated with either virtual appliances running in Azure VMware Solution or virtual appliances running in an Azure virtual network. Both options can be used regardless of the decisions made for connectivity with on-premises sites and Azure virtual networks during phases 1 and 2. Read [Design phase 3: Inbound internet connectivity](network-design-guide-internet-inbound-connectivity.md) to learn about the options for inbound internet connectivity that Azure VMware Solution supports and how to choose one.

4. **Decide how Azure VMware Solution workloads connect to the internet (outbound internet connectivity).** This design decision might be constrained by the decisions you make for inbound internet connectivity during phase 3. If you use [Public IP on the NSX-T Data Center Edge](/azure/azure-vmware/enable-public-ip-nsx-edge) for inbound connectivity, you need to use it for outbound connections too. If not, more options are available. Read  [Design phase 4: Internet outbound connectivity](network-design-guide-internet-outbound-connectivity.md) to learn about supported options and how to choose one.

## Next steps

Learn about the prerequisite knowledge that you need in order to understand the design areas covered in this guide. 

> [!div class="nextstepaction"]
> [Basics and prerequisites](azure-vmware-solution-network-basics.md)
