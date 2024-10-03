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

As shown in the architecture diagram above, each SDDC is also connected with Virtual WAN running in its own Azure Entra tenant. This connectivity is established using following procedure.

1. Create an Azure VMware Solution SDDC Authorization Key from Azure portal/Azure CLI/Powershell.
1. Create a hub and an ExpressRoute gateway in Virtual WAN.
1. Redeem the Authorization key to establish connectivity between SDDC and Virtual WAN

Along with connectivity between SDDC and Virtual WAN, other Azure Virtual Networks (VNets) are also connected to this Virtual WAN. These VNets could be of following different types.

1. Direct Spoke VNets: These are VNets *directly* connected to Virtual WAN - hence referred as *Direct* spoke VNets - using Virtual WAN virtual network connection. A spoke virtual network can potentially run an NVA deployed in it. Purpose of NVA is to inspect and control traffic from Azure and Azure VMware Solution SDDC to outside world.
1. Indirect Spoke VNets: These are VNets connected to *direct* spoke VNets. They're referred as *Indirect* because they aren't directly connected with Virtual WAN. They're used to host workloads running in Azure. Network traffic originated from them is inspected by NVAs running in *direct* spoke VNets.

Connectivity between SDDCs and VNets (Direct and Indirect) in Azure is established using following options.

1. *Direct* spokes can connect with SDDC running in their own tenant using connectivity between Virtual WAN and SDDC.
1. *Direct* spokes can also connect with SDDC running in the other tenant by using Azure VMware Solution Interconnect (Globalreach) or Azure VMware Solution ExpressRoute Globalreach connectivity.
1. *Indirect* spokes don't have connectivity with SDDC in their tenant by default. A User Defined Route (UDR) needs to be associated with them. UDR will have SDDC prefixes in their tenant as destination network and *direct* spoke in their own tenant as the next hop.
1. *Indirect* spokes don't have connectivity with SDDC in other tenant as well. A User Defined Route (UDR) needs to be associated with them. UDR will have SDDC prefixes in other tenant as destination network and *direct* spoke in their own tenant as the next hop. This connectivity needs either Azure VMware Solution Interconnect (Globalreach) or Azure VMware Solution ExpressRoute Globalreach connectivity between SDDCs.

> [!NOTE]
> Scenario discussed here covers a single hub connected with a spoke virtual network hosting NVA solution. If there are multiple hubs which need connectivity to Azure VMware Solution SDDC then a [full mesh network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture) will be required.

### Azure VMware Solution SDDC to on-premises connectivity

Connectivity between each Azure VMware Solution SDDC and on-premises environment should be established using Azure ExpressRoute Globalreach. Each SDDC ExpressRoute circuit and on-premises ExpressRoute circuits are connected in such a setup. When SDDC ExpressRoute circuit learns on-premises routes using Azure ExpressRoute Globalreach connection, these routes are *non-transitive* - hence aren't advertised across the tenant - even when [Azure VMware Solution SDDC to SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity) exists.

SDDC to on-premises connectivity coexists with cross tenant SDDC to SDDC connectivity. In such a setup, one SDDC ExpressRoute circuit learns on-premises routes using Globalreach connection and also learns cross tenant Virtual WAN routes through SDDC to SDDC connectivity. It's important that cross tenant Virtual WAN or SDDC doesn't advertise the on-premises prefixes through other means such as static route, VPN connection or any other means. If this happens, then SDDC ExpressRoute learns duplicate routes for on-premises environment resulting in routing loop breaking connectivity with it.

If on-premises environment uses multiple ExpressRoute circuits for redundancy, then public AS path prepend should be used for preferring one circuit over the other.

> [!NOTE]
> SDDC to on-premises connectivity coexists with Azure to on-premises connectivity as well. An ExpressRoute gateway in Virtual WAN can be used for connecting with SDDC ExpressRoute circuit as well as on-premises ExpressRoute circuit. However, this connectivity is not *transitive*.

### Azure to Azure connectivity

*Direct* and *Indirect* VNets need to communicate with each other in same Azure tenant and across the Azure tenants. This is established as discussed below.

#### Within the same tenant

1. *Direct* spokes can connect with each other through Virtual WAN virtual network connection.
1. *Direct* spokes can connect with *Indirect* spokes through virtual network peering.
1. *Indirect* spokes can connect with *Direct* spokes through virtual network peering.
1. *Indirect* spokes can connect with each other through virtual network peering with *Direct* spoke and UDR associated with them. UDR will have *indirect* spoke prefix as destination network and NVA in *direct* spoke as next hop. NVA in *Direct* spoke should be configured to forward the traffic through its Network Interface Card (NIC).

#### Across the tenant

1. *Direct* spoke can connect with cross-tenant *direct* spoke by using Global virtual network Peering.
1. *Direct* spokes can connect with cross-tenant *Indirect* spokes through Global virtual network peering between *direct* spokes and UDR associated with *direct* spoke. UDR will have cross-tenant *indirect* spoke prefix as destination network and NVA in cross-tenant *direct* spoke as next hop.
1. *Indirect* spokes can connect with cross-tenant *direct* spokes through Global virtual network Peering between *direct* spoke VNets, UDR associated with themselves with cross-tenant *direct* spoke prefix as destination network and NVA in its own *direct* spoke as next hop.
1. *Indirect* spokes can connect with cross-tenant *indirect* spokes through Global virtual network Peering between *direct* spoke VNets, UDR associated with themselves with cross-tenant *indirect* spoke prefix as destination network and NVA in its own *direct* spoke as next hop.

### Azure to on-premises connectivity

Azure to on-premises connectivity is established using on-premises ExpressRoute circuit and the ExpressRoute gateway of the Virtual WAN. This connectivity is *non-transitive* with the Azure VMware Solution SDDC ExpressRoute connected to same ExpressRoute gateway. It's also *non-transitive* over the global virtual network peering between *direct* spoke virtual network connected to Virtual WAN. *Indirect* spoke connected to Virtual WAN needs to have UDR with on-premises prefix as destination network as NVA running in *direct* spoke as the next hop.

## Next steps

See the following guidance about other Azure VMware Solution architectural options:

- [Azure VMware Solution - Network Design Guide](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-intro)

## Related resources

Refer to the following related resources:

- [Prepare for connectivity for Azure VMware Solution](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-get-started)
- [Networking planning checklist](/azure/azure-vmware/tutorial-network-checklist)
