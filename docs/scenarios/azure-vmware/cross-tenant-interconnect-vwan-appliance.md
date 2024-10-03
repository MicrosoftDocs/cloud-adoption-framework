---
title: Cross-tenant network connectivity for Azure VMware Solution SDDCs with vWANs and network virtual appliances
description: Get started with cross-tenant Azure VMware Solution SDDCs deployment. Understand how they can be connected with Azure Virtual WAN and used alongside with network virtual appliances.
author: Mahesh-MSFT
ms.author: maksh
ms.date: 10/11/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Cross-tenant network connectivity for Azure VMware Solution SDDCs with vWANs and network virtual appliances

This article describes how to set up Azure VMware Solution software-defined datacenter (SDDC) in a cross-tenant environment. It provides guidance about how to establish network connectivity by using Azure Virtual WAN and network virtual appliances (NVAs) that run in a spoke virtual network that's connected to Virtual WAN.

## Potential use cases

Consider the following scenarios that might use this architecture:

- Multinational corporations run Azure VMware Solution SDDC in different Microsoft Entra tenants.

- An enterprise undergoes a demerger or divestment process, which results in separate business entities that have separate Microsoft Entra tenants. And each separate business entity requires access to a common on-premises environment and cross-tenant access to Azure VMware Solution SDDC and other Azure resources.
- Two separate businesses each have their own separate Microsoft Entra tenants but still require cross-tenant access to workloads that run in both Azure VMware Solution SDDCs and Azure.

## Scenario details

This article examines the following scenarios which can be applied for either cross-tenant migration or workload-access purposes:

- Cross-tenant Azure VMware Solution SDDC to SDDC network connectivity
- Cross-tenant Azure to Azure connectivity
- Cross-tenant network access between Azure VMware Solution SDDC and Azure virtual networks
- Cross-tenant network access between Azure VMware Solution SDDC and an on-premises environment
- Cross-tenant network traffic inspection and control by an NVA that runs inside a virtual network that connects with Virtual WAN 

In a cross-tenant environment, Azure VMware Solution SDDC, its associated ExpressRoute circuit, and Virtual WAN can create a challenging migration or workload-access experience. The ExpressRoute circuit that's associated with Azure VMware Solution SDDC connects with SDDC and also with the Virtual WAN ExpressRoute gateway. In this set up, it learns the routes advertised by Azure VMware Solution SDDC and the Virtual WAN, and also it advertises those routes across the tenant to other Azure VMware Solution SDDC and Virtual WAN connected to it. Carefully plan your configuration to avoid cyclic route propagation between Virtual WAN, the ExpressRoute circuit of SDDC, and the ExpressRoute gateway of Virtual WAN.

## Architecture

The following architecture shows the connectivity between cross-tenant Azure VMware Solution SDDCs, Azure, and an on-premises environment.

:::image type="content" source="media/azure-vmware-solution-crosstenant-crossregion-vwan-appliance.png" alt-text="Diagram that shows the cross-tenant Azure VMware Solution SDDCs with Virtual WAN and NVAs." lightbox="media/azure-vmware-solution-crosstenant-crossregion-vwan-appliance.png" border="false":::

### Components

Network connectivity in a cross-tenant environment has following main components.

- [Azure VMware Solution SDDC to SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity)
- [Azure VMware Solution SDDC to Azure connectivity](#azure-vmware-solution-sddc-to-azure-connectivity)
- [Azure VMware Solution SDDC to on-premises connectivity](#azure-vmware-solution-sddc-to-on-premises-connectivity)
- [Azure to Azure connectivity](#azure-to-azure-connectivity)
- [Azure to on-premises connectivity](#azure-to-on-premises-connectivity)

### Azure VMware Solution SDDC to SDDC connectivity

Connectivity between two Azure VMware Solution SDDCs that you deploy across tenants depends on the *pod* in which you deploy them. Use the following instructions to identify the pods on which you deploy SDDCs

> [!NOTE]
> You can't select a pod during an Azure VMware Solution SDDC deployment. The process of assigning pods is non-deterministic.

1. In the Azure portal, go to Azure VMware Solution.
1. Under **Manage**, select **Clusters**.
1. Select the three dots, and then select **Edit**.
1. Note the host FQDN value. The letter **p** precedes the pod number.

:::image type="content" source="media/azure-vmware-solution-pod.png" alt-text="Diagram showing the Azure VMware Solution pod." lightbox="media/azure-vmware-solution-pod.png":::

In the preceding screenshot, SDDC hosts are deployed in pod 2 and 3. Repeat the same process for other SDDC. Determine whether they share any common pods.

After you identify the pods that SDDCs share, do one of the following options:

1. **Azure VMware Solution Interconnect (Globalreach):** Use this option when two SDDCs are in same Azure region *and* don't share any common pods between them. This option establishes an ExpressRoute circuit Globalreach connection between two SDDC ExpressRoute circuits. This option also enables *transitive* connectivity, which means that routes that the SDDC ExpressRoute circuit learns from the SDDC, Virtual WAN, and its direct spoke virtual networks are advertised across the tenant to other SDDC ExpressRoute circuits and SDDC, Virtual WAN, direct spoke virtual networks that are connected to the circuits.

1. **Azure VMware Solution Interconnect (Non-Globalreach):** Use this option when two SDDCs are in same Azure region *and* also share a common pod between them. This option doesn't provide cross-tenant *transitive* connectivity for routes that are advertised by Virtual WAN and its direct spoke virtual networks.

1. **Azure VMware Solution ExpressRoute GlobalReach:** Use this option when two SDDCs are in different Azure regions whether they share a pod or not. This option provides cross-tenant *transitive* connectivity for routes that are advertised by Virtual WAN and its direct spoke virtual networks.

Any of these options can establish network connectivity between two SDDCs. But the option that you choose affects the Azure VMware Solution SDDC to Azure connectivity.

> [!NOTE]
> You can use a [self-service model](/azure/azure-vmware/connect-multiple-private-clouds-same-region#add-connection-between-private-clouds) to establish network connectivity between two SDDCs. But if SDDCs run on stretched clusters, you should raise a [support ticket](/azure/azure-vmware/deploy-vsan-stretched-clusters#what-are-the-limitations-i-should-be-aware-of).

### Azure VMware Solution SDDC to Azure connectivity

In this architecture, each SDDC connects to Virtual WAN, and each Virtual WAN instance runs in its own Microsoft Entra tenant. Use the following procedure to establish connectivity.

1. Create an Azure VMware Solution SDDC authorization key from the Azure portal, Azure CLI, or PowerShell.

1. Create a hub and an ExpressRoute gateway in Virtual WAN.
1. Redeem the authorization key to establish connectivity between the SDDC and Virtual WAN.

Other Azure virtual networks also connect to this Virtual WAN.

- **Direct spoke virtual networks** *directly* connect to Virtual WAN via the Virtual WAN virtual network connection. A spoke virtual network can run an NVA that's deployed in it. The NVA inspects and controls traffic from Azure and the Azure VMware Solution SDDC to the outside world.

- **Indirect spoke virtual networks** connect to *direct* spoke virtual networks. They don't directly connect with Virtual WAN. Indirect spoke virtual networks host workloads that run in Azure. NVAs that run in *direct* spoke virtual networks inspect network traffic that originates from indirect spoke virtual networks.

You can use the following methods to establish direct and indirect connectivity between SDDCs and virtual networks in Azure.

1. *Direct* spokes can connect with an SDDC that runs in their own tenant via connectivity between Virtual WAN and the SDDC.

1. *Direct* spokes can also connect with an SDDC that runs in the other tenant via Azure VMware Solution Interconnect (Globalreach) or Azure VMware Solution ExpressRoute Globalreach connectivity.
1. *Indirect* spokes don't have connectivity with an SDDC in their tenant by default. A user-defined route (UDR) needs to be associated with them. A UDR has SDDC prefixes in their tenant as the destination network and a *direct* spoke in their own tenant as the next hop.
1. *Indirect* spokes also don't have connectivity with SDDC in the other tenant. A UDR needs to be associated with them. UDR has SDDC prefixes in the other tenant as the destination network and *direct* spoke in their own tenant as the next hop. This connectivity needs either Azure VMware Solution Interconnect (Globalreach) or Azure VMware Solution ExpressRoute Globalreach connectivity between SDDCs.

> [!NOTE]
> This scenario covers a single hub connected with a spoke virtual network hosting NVA solution. If you have multiple hubs that need to connect to Azure VMware Solution SDDC, use a [full-mesh network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture).

### Azure VMware Solution SDDC to on-premises connectivity

Use Azure ExpressRoute Globalreach to establish connectivity between each Azure VMware Solution SDDC and the on-premises environment. In this scenario, each SDDC ExpressRoute circuit and on-premises ExpressRoute circuit connect to each other. When the SDDC ExpressRoute circuit learns on-premises routes via an Azure ExpressRoute Globalreach connection, these routes are *non-transitive*. They don't advertise across the tenant, even when [Azure VMware Solution SDDC to SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity) exists.

SDDC to on-premises connectivity coexists with cross-tenant SDDC to SDDC connectivity. In such a setup, one SDDC ExpressRoute circuit learns on-premises routes via a Globalreach connection and also learns cross-tenant Virtual WAN routes via SDDC to SDDC connectivity. The cross-tenant Virtual WAN or SDDC must not advertise the on-premises prefixes through other means, such as a static route or a VPN connection. If this happens, then the SDDC ExpressRoute learns duplicate routes for the on-premises environment, which creates a routing loop and breaks connectivity.

If the on-premises environment uses multiple ExpressRoute circuits for redundancy, use the public AS path prepend to prefer one circuit over the other.

> [!NOTE]
> SDDC to on-premises connectivity coexists with Azure to on-premises connectivity. You can use an ExpressRoute gateway in Virtual WAN to connect with the SDDC ExpressRoute circuit and the on-premises ExpressRoute circuit. But this connectivity isn't *transitive*.

### Azure to Azure connectivity

*Direct* and *indirect* virtual networks need to communicate with each other in same Azure tenant and across the Azure tenants. Use the following methods to establish connections.

#### Within the same tenant

- *Direct* spokes can connect with each other through a Virtual WAN virtual network connection.

- *Direct* spokes can connect with *indirect* spokes through virtual network peering.
- *Indirect* spokes can connect with *direct* spokes through virtual network peering.
- *Indirect* spokes can connect with each other through virtual network peering with a *direct* spoke and UDR that are associated with them. A UDR has an *indirect* spoke prefix as the destination network and an NVA in the *direct* spoke as next hop. Configure the NVA in the *direct* spoke to forward the traffic through its network interface card (NIC).

#### Across the tenant

- *Direct* spokes can connect with a cross-tenant *direct* spoke via global virtual network peering.

- *Direct* spokes can connect with cross-tenant *indirect* spokes via global virtual network peering between *direct* spokes and UDRs that are associated with the *direct* spoke. A UDR has a cross-tenant *indirect* spoke prefix as the destination network and an NVA in the cross-tenant *direct* spoke as the next hop.
- *Indirect* spokes can connect with cross-tenant *direct* spokes via global virtual network peering between *direct* spoke virtual networks and a UDR that's associated with themselves that has a cross-tenant *direct* spoke prefix as the destination network and an NVA in its own *direct* spoke as the next hop.
- *Indirect* spokes can connect with cross-tenant *indirect* spokes via global virtual network peering between *direct* spoke virtual networks, a UDR that's associated with themselves that has a cross-tenant *indirect* spoke prefix as the destination network and an NVA in its own *direct* spoke as the next hop.

### Azure to on-premises connectivity

Use the on-premises ExpressRoute circuit and the ExpressRoute gateway of the Virtual WAN to establish Azure to on-premises connectivity. This connectivity is *non-transitive* with the Azure VMware Solution SDDC ExpressRoute connected to same ExpressRoute gateway. It's also *non-transitive* over the global virtual network peering between *direct* spoke virtual network connected to Virtual WAN. *Indirect* spoke connected to Virtual WAN needs to have UDR with on-premises prefix as destination network as NVA running in *direct* spoke as the next hop.

## Next steps

- [Azure VMware Solution network design guide](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-intro)
- [Networking planning checklist](/azure/azure-vmware/tutorial-network-checklist)

## Related resource

- [Prepare for connectivity for Azure VMware Solution](../../scenarios/azure-vmware/network-get-started.md)

