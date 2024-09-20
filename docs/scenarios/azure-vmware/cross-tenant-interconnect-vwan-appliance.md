---
title: Cross-tenant network connectivity for Azure VMware Solution SDDCs with vWANs and Network Virtual Appliances (NVAs)
description: Get started with cross-tenant Azure VMware Solution SDDCs deployment. Understand how they can be connected with Azure Virtual WAN (vWAN) and used alongside with Network Virtual Appliances (NVAs).
author: Mahesh-MSFT
ms.author: maksh
ms.date: 11/23/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-azure-vmware
---

# Cross-tenant network connectivity for Azure VMware Solution SDDCs with vWANs and NVAs

This article provides guidance on setting up Azure VMware Solution (AVS) Software-Defined Data Center (SDDC) in a cross-tenant environment. It provides guidance on establishing network connectivity using Azure Virtual WAN (vWAN) and Network Virtual Appliance (NVA) running in a spoke Virtual Network (VNet) connected to Azure Virtual WAN (vWAN).

## Potential use cases

Guidance in this article can be used in following use cases:

1. Multinational corporations running Azure VMware Solution SDDC in different Azure Entra tenants.
1. An enterprise undergoes a demerger or divestment process, resulting in separate business entities with separate Azure Entra tenants. Additionally, each separate business entity requires access to a common on-premises environment and cross-tenant access to Azure VMware Solution SDDC and other Azure resources.
1. Two separate businesses, each having their own separate Azure Entra tenants, but still requiring cross tenant access to workloads running in both Azure VMware Solution SDDCs and Azure.

## Scenario details

This article examines the following scenarios which can be applied for either cross-tenant migration or workload access purposes:

1. Cross-tenant Azure VMware Solution SDDC to SDDC network connectivity.
1. Cross-tenant Azure to Azure connectivity.
1. Cross-tenant network access between Azure VMware Solution SDDC and Azure VNets.
1. Cross-tenant network access between Azure VMware Solution SDDC and on-premises environment.
1. Cross-tenant network traffic inspection and control by an NVA running inside of a VNet connected with vWAN.  

Combined behavior of Azure VMware Solution SDDC, its associated Expressroute circuit and vWAN in a cross-tenant environment can potentially create a challenging migration/workload access experience. Expressroute circuit associated with Azure VMware Solution SDDC not only connects with SDDC but also with Expressroute gateway of vWAN. In this set up, it learns the routes advertised by Azure VMware Solution SDDC and the vWAN, and also it advertises those routes across the tenant to other Azure VMware Solution SDDC and vWAN connected to it. Careful planning is needed to avoid cyclic route propagation between vWAN, Expressroute circuit of SDDC and Expressroute gateway of vWAN.

## Architecture

The architecture depicting connectivity between cross-tenant Azure VMware Solution SDDCs, Azure and on-premises environment is as shown below.

:::image type="content" source="media/azure-vmware-solution-crosstenant-crossregion-vwan-appliance.png" alt-text="Diagram showing the cross-tenant AVS SDDCs with vWAN and Network Virtual Appliance." lightbox="media/azure-vmware-solution-crosstenant-crossregion-vwan-appliance.png":::

### Components

Network connectivity in a cross-tenant environment has following main components.

- [Azure VMware Solution SDDC to SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity)
- [Azure VMware Solution SDDC to Azure connectivity](#azure-vmware-solution-sddc-to-azure-connectivity)
- [Azure VMware Solution SDDC to on-premises connectivity](#azure-vmware-solution-sddc-to-on-premises-connectivity)
- [Azure to Azure connectivity](#azure-to-azure-connectivity)
- [Azure to on-premises connectivity](#azure-to-on-premises-connectivity)

### Azure VMware Solution SDDC to SDDC connectivity

Connectivity between two Azure VMware Solution SDDCs deployed across tenants depends upon the "pod" in which they're deployed. It's possible to identify the pods on which SDDC is deployed with instructions below.

> [!NOTE]
> It is not possible to select pod at the time of Azure VMware Solution SDDC deployment. Process of assigning pods is non-deterministic.

1. Navigate to Azure VMware Solution service in Azure portal.
1. Select "Clusters" menu under "Manage" menu category.
1. Select "Edit" button on the three dots menu.
1. Observe the Host FQDN value. Pod number is followed by letter p.

:::image type="content" source="media/azure-vmware-solution-pod.png" alt-text="Diagram showing the Azure VMware Solution pod." lightbox="media/azure-vmware-solution-pod.png":::

In the picture above, SDDC hosts are deployed in pod 2 and 3. Repeat the same process for other SDDC. Note down if they share any common pod or not.

Once the pod sharing between SDDCs is identified, proceed with one of the options discussed below.

1. Azure VMware Solution Interconnect (Globalreach): Use this option when two SDDCs are in same Azure region AND don't share any common pod between them. An Expressroute circuit Globalreach connection between two SDDC Expressroute circuits is established in this option. This option also enables *transitive* - meaning routes learnt by SDDC Expressroute circuit from SDDC and vWAN and its direct spoke VNets - are also advertised across the tenant to other SDDC Expressroute circuit and SDDC and vWAN and direct spoke VNets connected to it.

1. Azure VMware Solution Interconnect (Non-Globalreach): Use this option when two SDDCs are in same Azure region AND also share a common pod between them. There's no cross-tenant *transitive* connectivity for routes advertised by vWAN and its direct spoke VNets in this option.

1. Azure VMware Solution Expressroute GlobalReach: Use this option when two SDDCs are in different Azure regions. Whether they share a pod or not, doesn't matter in this case. There's a cross-tenant *transitive* connectivity for routes advertised by vWAN and its direct spoke VNets in this option.

Any of the options discussed above can establish network connectivity between two SDDCs. However, option used for such connectivity also affects the Azure VMware Solution SDDC to Azure connectivity as discussed in later sections of this article.

> [!NOTE]
> While it is possible to establish network connectivity between two SDDCs using [self-service model](/azure/azure-vmware/connect-multiple-private-clouds-same-region#add-connection-between-private-clouds), in case of SDDCs running on stretched clusters, a [support ticket](/azure/azure-vmware/deploy-vsan-stretched-clusters#what-are-the-limitations-i-should-be-aware-of) should be raised.

### Azure VMware Solution SDDC to Azure connectivity

As shown in the architecture diagram above, each SDDC is also connected with vWAN running in its own Azure Entra tenant. This connectivity is established using following procedure.

1. Create an Azure VMware Solution SDDC Authorization Key from Azure portal/Azure CLI/Powershell.
1. Create a hub and an Expressroute gateway in Azure vWAN.
1. Redeem the Authorization key to establish connectivity between SDDC and vWAN

Along with connectivity between SDDC and vWAN, other Azure Virtual Networks (VNets) are also connected to this vWAN. These VNets could be of following different types.

1. Direct Spoke VNets: These are VNets *directly* connected to vWAN - hence referred as *Direct* spoke VNets - using vWAN VNet connection. A spoke VNet can potentially run an NVA deployed in it. Purpose of NVA is to inspect and control traffic from Azure and Azure VMware Solution SDDC to outside world.
1. Indirect Spoke VNets: These are VNets connected to *direct* spoke VNets. They're referred as *Indirect* because they aren't directly connected with vWAN. They're used to host workloads running in Azure. Network traffic originated from them is inspected by NVAs running in *direct* spoke VNets.

Connectivity between SDDCs and VNets (Direct and Indirect) in Azure is established using following options.

1. *Direct* spokes can connect with SDDC running in their own tenant using connectivity between vWAN and SDDC.
1. *Direct* spokes can also connect with SDDC running in the other tenant by using Azure VMware Solution Interconnect (Globalreach) or Azure VMware Solution Expressroute Globalreach connectivity.
1. *Indirect* spokes don't have connectivity with SDDC in their tenant by default. A User Defined Route (UDR) needs to be associated with them. UDR will have SDDC prefixes in their tenant as destination network and *direct* spoke in their own tenant as the next hop.
1. *Indirect* spokes don't have connectivity with SDDC in other tenant as well. A User Defined Route (UDR) needs to be associated with them. UDR will have SDDC prefixes in other tenant as destination network and *direct* spoke in their own tenant as the next hop. This connectivity needs either Azure VMware Solution Interconnect (Globalreach) or Azure VMware Solution Expressroute Globalreach connectivity between SDDCs.

> [!NOTE]
> Scenario discussed here covers a single hub connected with a spoke VNet hosting NVA solution. If there are multiple hubs which need connectivity to AVS SDDC then a [full mesh network architecture](/azure/virtual-wan/virtual-wan-global-transit-network-architecture) will be required.

### Azure VMware Solution SDDC to on-premises connectivity

Connectivity between each Azure VMware Solution SDDC and on-premises environment should be established using Azure Expressroute Globalreach. Each SDDC Expressroute circuit and on-premises Expressroute circuits are connected in such a setup. When SDDC Expressroute circuit learns on-premises routes using Azure Expressroute Globalreach connection, these routes are *non-transitive* - hence aren't advertised across the tenant - even when [Azure VMware Solution SDDC to SDDC connectivity](#azure-vmware-solution-sddc-to-sddc-connectivity) exists.

SDDC to on-premises connectivity coexists with cross tenant SDDC to SDDC connectivity. In such a setup, one SDDC Expressroute circuit learns on-premises routes using Globalreach connection and also learns cross tenant vWAN routes through SDDC to SDDC connectivity. It's important that cross tenant vWAN or SDDC doesn't advertise the on-premises prefixes through other means such as static route, VPN connection or any other means. If this happens, then SDDC Expressroute learns duplicate routes for on-premises environment resulting in routing loop breaking connectivity with it.

If on-premises environment uses multiple Expressroute circuits for redundancy, then public AS path prepend should be used for preferring one circuit over the other.

> [!NOTE]
> SDDC to on-premises connectivity coexists with Azure to on-premises connectivity as well. An Expressroute gateway in vWAN can be used for connecting with SDDC Expressroute circuit as well as on-premises Expressroute circuit. However, this connectivity is not *transitive*.

### Azure to Azure connectivity

*Direct* and *Indirect* VNets need to communicate with each other in same Azure tenant and across the Azure tenants. This is established as discussed below.

#### Within the same tenant

1. *Direct* spokes can connect with each other through vWAN VNet connection.
1. *Direct* spokes can connect with *Indirect* spokes through VNet peering.
1. *Indirect* spokes can connect with *Direct* spokes through VNet peering.
1. *Indirect* spokes can connect with each other through VNet peering with *Direct* spoke and UDR associated with them. UDR will have *indirect* spoke prefix as destination network and NVA in *direct* spoke as next hop. NVA in *Direct* spoke should be configured to forward the traffic through its Network Interface Card (NIC).

#### Across the tenant

1. *Direct* spoke can connect with cross-tenant *direct* spoke by using Global VNet Peering.
1. *Direct* spokes can connect with cross-tenant *Indirect* spokes through Global VNet peering between *direct* spokes and UDR associated with *direct* spoke. UDR will have cross-tenant *indirect* spoke prefix as destination network and NVA in cross-tenant *direct* spoke as next hop.
1. *Indirect* spokes can connect with cross-tenant *direct* spokes through Global VNet Peering between *direct* spoke VNets, UDR associated with themselves with cross-tenant *direct* spoke prefix as destination network and NVA in its own *direct* spoke as next hop.
1. *Indirect* spokes can connect with cross-tenant *indirect* spokes through Global VNet Peering between *direct* spoke VNets, UDR associated with themselves with cross-tenant *indirect* spoke prefix as destination network and NVA in its own *direct* spoke as next hop.

### Azure to on-premises connectivity

Azure to on-premises connectivity is established using on-premises Expressroute circuit and the Expressroute gateway of the vWAN. This connectivity is *non-transitive* with the Azure VMware Solution SDDC Expressroute connected to same Expressroute gateway. It's also *non-transitive* over the global VNet peering between *direct* spoke VNet connected to vWAN. *Indirect* spoke connected to vWAN needs to have UDR with on-premises prefix as destination network as NVA running in *direct* spoke as the next hop.

## Next steps

See the following guidance about other Azure VMware Solution architectural options:

- [Azure VMware Solution - Network Design Guide](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-design-guide-intro)

## Related resources

Refer to the following related resources:

- [Prepare for connectivity for Azure VMware Solution](/azure/cloud-adoption-framework/scenarios/azure-vmware/network-get-started)
- [Networking planning checklist](/azure/azure-vmware/tutorial-network-checklist)
