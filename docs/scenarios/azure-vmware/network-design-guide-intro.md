---
title: Azure VMware Solution Network Design Guide
description: Learn how to design network connectivity for Azure VMware Solution.
author: fguerri
ms.author: fguerri
ms.date: 06/06/2023
ms.topic: conceptual
ms.service: caf
ms.subservice: caf-scenario-vmware
ms.custom: think-tank, e2e-azure-vmware
---

# Azure VMware Solution Landing Zone Accelerator Network Design Guide
This guide covers network design for the Azure VMware Solution landing zone accelerator. It encompasses four design areas, summarized below.

1. **Connectivity with on-premises datacenters**. Connectivity between Azure VMware Solution private clouds and on-premises sites supports a broad set of use cases: HCX migrations, hybrid applications, remote vCenter or NSX-T Data Center administration. Azure VMware Solution supports multiple options for hybrid connectivity, including Azure ExpressRoute circuits and internet-based IPSec VPNs. 

2. **Connectivity with Azure Virtual Networks**. Azure VMware Solution runs on bare-metal VMware vSphere clusters that can be connected to native Azure Virtual Networks through Azure ExpressRoute. ExpressRoute connections between Azure VMware Solution private clouds and Azure virtual networks enable building applications that span the two environments or using “jump-box” virtual machines in Azure to log into vCenter (vSphere Client) and NSX-T Manager console for administration purposes.

3. **Inbound Internet connectivity**. Inbound Internet connectivity enables applications running on Azure VMware Solution to be exposed to the Internet behind public IP addresses. Internet-facing applications are almost invariably published through security devices (application delivery controllers, web application firewalls, L3/L4 next-gen firewalls, …). Design decisions about inbound connectivity are primarily driven by the placement of such devices (in Azure VMware Solution or in Azure virtual networks). 

4. **Outbound Internet connectivity**. Outbound Internet connectivity is needed when applications running on Azure VMware Solution require access to public endpoints. Typical use cases include downloading software updates, consuming public web sites or APIs, Internet browsing (for example, when Azure VMware Solution is used to run [VDI solutions](/azure/azure-vmware/azure-vmware-solution-horizon)). Azure VMware Solution provides several options to implement outbound Internet connectivity, which may or may not rely on Azure native resources. Security requirements (firewalling, forward proxying, …) typically drive design decisions in this area. 

Azure VMware Solution provides native functionality to address the most common requirements in each design area, with no need for you to deploy more Azure resources. These native functionalities are covered in the [official documentation](/azure/azure-vmware/concepts-networking). However, in enterprise scenarios, it is common for Azure VMware Solution to be part of a larger infrastructure that includes 1st-party network services (Azure Firewall, Azure Application Gateway, …) or third-party Network Virtual Appliances (NVAs). This guide helps you design these more advanced solutions.

Designing advanced Azure VMware Solution network architectures requires a solid understanding of [Azure VMware Solution networking basics](network-design-guide-avs-networking-basics.md), which are prerequisite knowledge for an effective use of this guide.

## Design area prioritization and dependencies
The four design areas are not independent of each other. Design decisions made for one area may limit the options available in other areas. It is recommended to tackle the four areas in the order they have been introduced in the previous section. 

:::image type="content" source="media/network-design-guide-figure1.png" alt-text="Figure 1. Flowchart that defines the design area prioritization recommended in this guide." lightbox="media/network-design-guide-figure1.png":::
*Design area prioritization recommended in this guide.*

As shown in the flow chart, this guide advocates the following 4-phased approach to network design for Azure VMware Solution.
1. **Design connectivity with on-premises datacenters first.** The key decisions for this area are: 
   - Which connectivity service to use between on-premises sites and the edge of the Microsoft network (Internet vs. ExpressRoute)
   - Whether traffic should be routed directly to Azure VMware Solution (recommended) or through virtual devices running in Azure virtual networks.  

   Read the [Design phase #1: Connectivity with on-premises sites article](network-design-guide-onprem-connectivity.md) to learn what options Azure VMware Solution supports and how to choose one.

2. **Identify the virtual network connectivity option aligned to the design choices made in Phase #1.** Determine if more routing/security configuration is needed in Azure Virtual Networks. The most typical requirement is firewall inspection for traffic between Azure VMware Solution and Azure native virtual machines. Read [Design phase #2: Azure virtual network connectivity](network-design-guide-vnet-connectivity.md) to learn how design decisions for connectivity with on-premises sites influence the way an Azure VMware Solution private cloud connects to Azure virtual networks.

3. **Decide how Internet-facing applications running on Azure VMware Solution should be published (inbound Internet connectivity).** Azure VMware Solution allows using Azure Public IPs associated with either virtual appliances running in Azure VMware Solution, or virtual appliances running in an Azure virtual network. Both options can be used irrespective of the decisions made for connectivity with on-premises sites and Azure virtual networks in Phase #1 and Phase #2. Read [Design phase #3: Internet inbound connectivity](network-design-guide-internet-inbound-connectivity.md) to learn what options for inbound Internet connectivity Azure VMware Solution supports, and how to choose one.

4. **Decide how Azure VMware Solution workloads connect to the Internet (outbound Internet connectivity).** This design decision may be constrained by the previous decisions made for inbound Internet connectivity (Design Phase #3). If [Azure Public IPs to the NSX-T edge](/azure/azure-vmware/enable-public-ip-nsx-edge) are used for inbound connectivity, then they must be used for outbound connections too. If not, more options exist. Read  [Design phase #4: Internet outbound connectivity](network-design-guide-internet-outbound-connectivity.md) to learn about supported options and how to choose one.

## Next Steps

Learn about the prerequisite knowledge you'll need for understanding the design areas covered in this design guide. 

> [!div class="nextstepaction"]
> [Basics and prerequisites](./network-design-guide-avs-networking-basics.md)
