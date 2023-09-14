---
title: Plan for IP addressing
description: Examine important design considerations and recommendations to ensure IP address space doesn't overlap across on-premises locations and Azure regions.
author: JefferyMitchell
ms.author: martinek
ms.date: 12/07/2021
ms.topic: conceptual
ms.custom: think-tank
---

<!-- docutune:ignore "Azure VPN Gateway" -->

# Plan for IP addressing

It's important your organization plans for IP addressing in Azure. Planning ensures the IP address space doesn't overlap across on-premises locations and Azure regions.

**Design considerations:**

- Overlapping IP address spaces across on-premises and Azure regions creates major contention challenges.

- Azure VPN Gateway can connect overlapping, on-premises sites with overlapping IP address spaces through network address translation (NAT) capability. This feature is generally available in [Azure Virtual WAN](/azure/virtual-wan/nat-rules-vpn-gateway) and standalone [Azure VPN Gateway](/azure/vpn-gateway/nat-howto).

  :::image type="content" source="./media/vpn-nat.png" alt-text="{Diagram that shows how NAT works with VPN Gateway.}":::

- You can add address space after you create a virtual network. This process doesn't need an outage if the virtual network is already connected to another virtual network via virtual network peering. Instead, each remote peering needs a [resync operation](/azure/architecture/networking/prefixes/add-ip-space-peered-vnet) done after the network space has changed.

- Azure [reserves five IP addresses](/azure/virtual-network/virtual-networks-faq#are-there-any-restrictions-on-using-ip-addresses-within-these-subnets) within each subnet. Factor in those addresses when you're sizing virtual networks and encompassed subnets.

- Some Azure services require [dedicated subnets](/azure/virtual-network/virtual-network-for-azure-services#services-that-can-be-deployed-into-a-virtual-network). These services include Azure Firewall and Azure VPN Gateway.

- You can delegate subnets to certain services to create instances of a service within the subnet.

**Design recommendations:**

- Plan for non-overlapping IP address spaces across Azure regions and on-premises locations in advance.

- Use IP addresses from the address allocation for private internet, known as RFC 1918 addresses.

- Don't use the following address ranges:
  - `224.0.0.0/4` (multicast)
  - `255.255.255.255/32` (broadcast)
  - `127.0.0.0/8` (loopback)
  - `169.254.0.0/16` (link-local)
  - `168.63.129.16/32` (internal DNS)

- For environments that have limited availability of private IP addresses, consider using IPv6. Virtual networks can be IPv4-only or dual stack [IPv4+IPv6](/azure/virtual-network/ip-services/ipv6-overview).

  ![Diagram that shows IPv4 and IPv6 dual stack.](./media/azure-ipv4-ipv6.png)

- Don't create large virtual networks like `/16`. It ensures that IP address space isn't wasted. The smallest supported IPv4 subnet is `/29`, and the largest is `/2` when using classless inter-domain routing (CIDR) subnet definitions. IPv6 subnets must be exactly `/64` in size.

- Don't create virtual networks without planning the required address space in advance.

- Don't use public IP addresses for virtual networks, especially if the public IP addresses don't belong to your organization.

- Take the services you're going to use into consideration, there are some services with reserved IPs (IP Addresses), like [AKS with CNI networking](/azure/aks/configure-azure-cni#prerequisites)

- Use [nonroutable landing zone spoke virutal networks](azure/architecture/guide/networking/ipv4-exhaustion#method-1-nonroutable-landing-zone-spoke-virtual-networks) and [Azure Private Link service](/azure/architecture/guide/networking/ipv4-exhaustion#method-2-azure-private-link-services) to prevent IPv4 exhaustion.

## IP Address Management (IPAM) tools

Using an IPAM tool can assist you with IP address planning in Azure as it provides centralized management and visibility, preventing overlaps and conflicts in IP address spaces. This section guides you through essential considerations and recommendations when adopting an IPAM tool.

**Design considerations:**

Numerous IPAM tools are available for your consideration, depending on your requirements and the size of your organization. The options spans from having a basic Excel-based inventory to open-source community-driven solution or comprehensive enterprise products with advanced features and support.

- Consider these factors when evaluating what IPAM tool to implement:
  - Minimum features required by your organization
  - Total cost of ownership (TCO), including licensing and ongoing maintenance
  - Audit trails, logging, and role-based access controls
  - Authentication and authorization through Azure AD (Entra ID)
  - Accessible via API
  - Integrations with other network management tools and systems
  - Active community support or the level of support from the software provider

- Consider evaluating an open-source IPAM tool like [Azure IPAM](https://azure.github.io/ipam). Azure IPAM is a lightweight solution built on the Azure platform. It automatically discovers IP address utilization within your Azure tenant and enables you to manage it all from a centralized UI or via a RESTful API.

- Consider your organizations operating model and the ownership of the IPAM tool. The goal of implementing an IPAM tool is to streamline the process of requesting new IP address spaces for application teams without dependencies and bottlenecks.

- An important part of the IPAM tool functionality is to inventory IP address space usage and logically organize it.

**Design recommendations:**

- The process of reserving non-overlapping IP address spaces should support requesting different sizes based on the needs of the individual application landing zones.
  - For example, you could adopt T-shirt sizing to make it easy for application teams to describe their needs:
    - Small - `/24` - 256 IP addresses
    - Medium - `/22` - 1,024 IP addresses
    - Large - `/20` - 4,096 IP addresses

- Your IPAM tool should have an API for reserving non-overlapping IP address spaces to support an Infrastructure as Code (IaC) approach. This feature is also crucial for seamless integration of IPAM into your [subscription vending process](../landing-zone/design-area/subscription-vending.md), thereby reducing the risk of errors and the need for manual intervention.
  - An example of an IaC approach is [Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) with its deployment script functionality or [Terraform](/azure/developer/terraform/overview) data sources to dynamically fetch data from the IPAM API.

- Create a systematic arrangement for your IP address spaces by structuring them according to Azure regions and workload archetypes, ensuring a clean and traceable network inventory.

- The decommissioning process for workloads should include the removal of IP address spaces that is no longer used, which can later be repurposed for upcoming new workloads, promoting efficient resource utilization.
