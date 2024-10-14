---
title: Establish Cross-Tenant Network Connectivity For Azure VMware Solution SDDCs
description: Learn how to use Azure Virtual WAN and NVAs to establish network connectivity for Azure VMware Solution SDDCs in a cross-tenant environment.
author: Mahesh-MSFT
ms.author: maksh
ms.date: 10/21/2024
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Establish cross-tenant network connectivity for Azure VMware Solution SDDCs

This article describes how to set up Azure VMware Solution software-defined datacenters (SDDCs) in a cross-tenant environment. It provides guidance about how to establish network connectivity by using Azure Virtual WAN and network virtual appliances (NVAs) that run in a spoke virtual network. The spoke virtual network connects to Virtual WAN.

## Architecture

The following architecture shows the connectivity between cross-tenant Azure VMware Solution SDDCs, Azure, and an on-premises environment.

:::image type="content" source="media/azure-vmware-solution-crosstenant-crossregion-vwan-appliance.png" alt-text="Diagram that shows the cross-tenant Azure VMware Solution SDDCs with Virtual WAN and NVAs." lightbox="media/azure-vmware-solution-crosstenant-crossregion-vwan-appliance.png" border="false":::

## Connectivity

Network connectivity in a cross-tenant environment consists of the following connections.

- [Azure VMware Solution SDDC-to-SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity)
- [Azure VMware Solution SDDC-to-Azure connectivity](#azure-vmware-solution-sddc-to-azure-connectivity)
- [Azure VMware Solution SDDC-to-on-premises connectivity](#azure-vmware-solution-sddc-to-on-premises-connectivity)
- [Azure-to-Azure connectivity](#azure-to-azure-connectivity)
- [Azure-to-on-premises connectivity](#azure-to-on-premises-connectivity)

### Azure VMware Solution SDDC-to-SDDC connectivity

The connectivity between two Azure VMware Solution SDDCs that you deploy across tenants depends on the *pod* in which you deploy them. Use the following instructions to identify the pods in which you deploy SDDCs.

1. In the Azure portal, go to Azure VMware Solution.
1. Select **Manage**, and then select **Clusters**.
1. Select the three dots, and then select **Edit**.
1. Note the host FQDN value. The letter **p** precedes the pod number.

Repeat the same process for other SDDCs. Determine whether they share any common pods. The following image shows SDDC hosts that are deployed in pods 2 and 3.

:::image type="content" source="media/azure-vmware-solution-pod.png" alt-text="Diagram showing the Azure VMware Solution pod." lightbox="media/azure-vmware-solution-pod.png":::

> [!NOTE]
> You can't select a pod during an Azure VMware Solution SDDC deployment. Pod assignment isn't predetermined, so the exact node that a scheduler assigns to a pod can vary each time a process runs.

After you identify the pods that SDDCs share, do one of the following options:

- **Use Azure VMware Solution interconnect (non-Global Reach):** Use this option when two SDDCs are in same Azure region *and* share a common pod between them. This option doesn't provide cross-tenant transitive connectivity for routes that Virtual WAN and its direct spoke virtual networks advertise.

- **Use Azure VMware Solution ExpressRoute Global Reach:** Use this option when two SDDCs are in different Azure regions whether they share a pod or not. This option provides cross-tenant transitive connectivity for routes that Virtual WAN and its direct spoke virtual networks advertise.

Both of these options can establish network connectivity between two SDDCs. The option that you choose the Azure VMware Solution SDDC-to-Azure connectivity.

> [!NOTE]
> You can use a [self-service model](/azure/azure-vmware/connect-multiple-private-clouds-same-region#add-connection-between-private-clouds) to establish network connectivity between two SDDCs. But if SDDCs run on stretched clusters, you should raise a [support ticket](/azure/azure-vmware/deploy-vsan-stretched-clusters#what-are-the-limitations-i-should-be-aware-of).

### Azure VMware Solution SDDC-to-Azure connectivity

In this architecture, each SDDC connects to Virtual WAN, and each Virtual WAN instance runs in its own Microsoft Entra tenant. Use the following procedure to establish connectivity.

1. In the Azure portal, Azure CLI, or PowerShell, create an Azure VMware Solution SDDC authorization key.

1. In Virtual WAN, create a hub and an ExpressRoute gateway.
1. To establish connectivity between the SDDC and Virtual WAN, redeem the authorization key.

Other Azure virtual networks also connect to this Virtual WAN.

- **Direct spoke virtual networks** directly connect to Virtual WAN via the Virtual WAN virtual network connection. A spoke virtual network can run an NVA that's deployed in it. The NVA inspects and controls traffic that goes outbound from Azure and the Azure VMware Solution SDDC.

- **Indirect spoke virtual networks** connect to direct spoke virtual networks. They don't directly connect to Virtual WAN. Indirect spoke virtual networks host workloads that run in Azure. NVAs that run in direct spoke virtual networks inspect network traffic that originates from indirect spoke virtual networks.

Use the following configurations to establish direct and indirect connectivity between SDDCs and virtual networks in Azure.

- *Direct* spokes can connect to an SDDC that runs in their own tenant via connectivity between Virtual WAN and the SDDC.

- *Direct* spokes can connect to an SDDC that runs in the other tenant via Azure VMware Solution interconnect (Global Reach) or Azure VMware Solution Global Reach connectivity.
- *Indirect* spokes don't connect to an SDDC in their tenant by default. You can associate a user-defined route (UDR) with indirect spokes. A UDR has SDDC prefixes in their tenant as the destination network and a direct spoke in their own tenant as the next hop.
- *Indirect* spokes don't connect to an SDDC in the other tenant by default. You can associate a UDR with indirect spokes. A UDR has SDDC prefixes in the other tenant as the destination network and direct spoke in their own tenant as the next hop. This connectivity requires either Azure VMware Solution interconnect (Global Reach) or Azure VMware Solution Global Reach connectivity between SDDCs.

> [!NOTE]
> Use this guidance for a single hub that connects to a spoke virtual network that hosts an NVA solution. If you have multiple hubs that need to connect to an Azure VMware Solution SDDC, use a [full-mesh network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture).

### Azure VMware Solution SDDC-to-on-premises connectivity

Use Global Reach to establish connectivity between each Azure VMware Solution SDDC and the on-premises environment. In this scenario, each SDDC ExpressRoute circuit and on-premises ExpressRoute circuit connect to each other. The on-premises routes that the SDDC ExpressRoute circuit learns via a Global Reach connection are non-transitive. They don't advertise across the tenant, even when [Azure VMware Solution SDDC-to-SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity) exists.

SDDC-to-on-premises connectivity coexists with cross-tenant SDDC-to-SDDC connectivity. In such a setup, one SDDC ExpressRoute circuit learns on-premises routes via a Global Reach connection and also learns cross-tenant Virtual WAN routes via SDDC-to-SDDC connectivity. The cross-tenant Virtual WAN or SDDC must not advertise the on-premises prefixes through other means, such as a static route or a VPN connection. If this occurs, the SDDC ExpressRoute learns duplicate routes for the on-premises environment, which creates a routing loop and breaks connectivity.

If the on-premises environment uses multiple ExpressRoute circuits for redundancy, use the public AS path prepend to prefer one circuit over the other.

> [!NOTE]
> SDDC-to-on-premises connectivity coexists with Azure-to-on-premises connectivity. You can use an ExpressRoute gateway in Virtual WAN to connect with the SDDC ExpressRoute circuit and the on-premises ExpressRoute circuit. But this connectivity isn't transitive.

### Azure-to-Azure connectivity

*Direct* and *indirect* virtual networks need to communicate with each other in same Azure tenant and across the Azure tenants. Use the following methods to establish connections.

#### Establish connections within the same tenant

- Connect *direct* spokes with each other via a Virtual WAN virtual network connection.

- Connect *direct* spokes with *indirect* spokes via virtual network peering.
- Connect *indirect* spokes with *direct* spokes via virtual network peering.
- Connect *indirect* spokes with each other via virtual network peering with a *direct* spoke and a UDR that you associate with the direct spoke. A UDR has an *indirect* spoke prefix as the destination network and an NVA in the *direct* spoke as next hop. Configure the NVA in the *direct* spoke to forward the traffic through its network interface card (NIC).

#### Establish connections across the tenant

- Connect *direct* spokes with cross-tenant *direct* spokes via global virtual network peering.

- Connect *direct* spokes with cross-tenant *indirect* spokes via global virtual network peering between *direct* spokes and UDRs that you associate with the *direct* spoke. A UDR has a cross-tenant *indirect* spoke prefix as the destination network and an NVA in the cross-tenant *direct* spoke as the next hop.
- Connect *indirect* spokes with cross-tenant *direct* spokes via global virtual network peering between *direct* spoke virtual networks and a UDR that you associate with the direct spoke virtual networks. The UDR has a cross-tenant *direct* spoke prefix as the destination network and an NVA in its own *direct* spoke as the next hop.
- Connect *indirect* spokes with cross-tenant *indirect* spokes via global virtual network peering between *direct* spoke virtual networks and a UDR that you associate with the direct spoke virtual networks. The UDR has a cross-tenant *indirect* spoke prefix as the destination network and an NVA in its own *direct* spoke as the next hop.

### Azure-to-on-premises connectivity

Use the on-premises ExpressRoute circuit and the ExpressRoute gateway of Virtual WAN to establish Azure-to-on-premises connectivity. The connectivity between the Azure VMware Solution SDDC ExpressRoute and the same on-premises ExpressRoute gateway is non-transitive. The connection between the direct spoke virtual network and Virtual WAN via global virtual network peering is also non-transitive. The indirect spoke that connects to Virtual WAN must have a UDR that has an on-premises prefix as the destination network and an NVA that runs in the direct spoke as the next hop.

## Scenario details

This article examines the following scenarios. You can apply these scenarios for either cross-tenant migration or workload-access purposes.

- Cross-tenant Azure VMware Solution SDDC-to-SDDC network connectivity
- Cross-tenant Azure-to-Azure connectivity
- Cross-tenant network access between an Azure VMware Solution SDDC and Azure virtual networks
- Cross-tenant network access between an Azure VMware Solution SDDC and an on-premises environment
- Cross-tenant network traffic inspection and control via an NVA that runs in a virtual network that connects to Virtual WAN 

In a cross-tenant environment, the Azure VMware Solution SDDC, its associated Azure ExpressRoute circuit, and Virtual WAN can create a challenging migration or workload-access experience. The ExpressRoute circuit that's associated with the Azure VMware Solution SDDC connects with the SDDC and also with the Virtual WAN ExpressRoute gateway. The ExpressRoute circuit learns the routes that the Azure VMware Solution SDDC and Virtual WAN advertise. The ExpressRoute circuit advertises those routes across the tenant to the other Azure VMware Solution SDDC and Virtual WAN that connect to the circuit. Carefully plan your configuration to avoid cyclic route propagation between Virtual WAN, the SDDC ExpressRoute circuit, and the Virtual WAN ExpressRoute gateway.

## Potential use cases

Consider the following scenarios that might benefit from this architecture:

- Multinational corporations run Azure VMware Solution SDDC in different Microsoft Entra tenants.

- An enterprise undergoes a demerger or divestment process, which results in separate business entities that have separate Microsoft Entra tenants. Each separate business entity requires access to a common on-premises environment and requires cross-tenant access to Azure VMware Solution SDDC and other Azure resources.
- Two separate businesses have their own separate Microsoft Entra tenants but still require cross-tenant access to workloads that run in both Azure VMware Solution SDDCs and Azure.

## Next steps

- [Azure VMware Solution network design guide](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-intro)
- [Networking planning checklist](/azure/azure-vmware/tutorial-network-checklist)

## Related resource

- [Prepare for connectivity for Azure VMware Solution](../../scenarios/azure-vmware/network-get-started.md)

