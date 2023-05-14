---
title: Networking Architecture Design for Azure VMware Solution 
description: Learn about sample architectures, solutions, and guides that can help you explore the various networking capabilities for Azure VMware Solution
author: sablair
ms.author: martinek
ms.date: 04/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---

# Networking architecture design

The Azure VMware Solution (AVS) for Azure Landing Zones connectivity section consists of sample architectures, solutions, and guides that can help you to explore hybrid networking with Azure VMware Solution. 

Azure VMware Solution provides a wide range of networking tools and capabilities for connecting with on-premises environments and Azure native workloads. 

Design areas include:

- **Hybrid integration**: Establishing connectivity with on-premises, multicloud, edge, and global users from the Software Defined Datacenter (SDDC).
- **Performance and reliability at scale**: Designing for a scalable, consistent, and low-latency experience.
- **Zero-trust-based network security** for network perimeter and secure traffic flows. For more information, see [Network security strategies on Azure](/azure/architecture/framework/security/design-network).
- **Extensibility** to easily expand networks while avoiding redesign.

## General Design Considerations and Recommendations

[Network Topology and Connectivity:](./eslz-network-topology-connectivity.md) This section details general design considerations around IP addressing, bandwidth, and individual components (e.g ExpressRoute, VNETs)


## Hub & Spoke

The [Egress natively from AVS](./networking-hubspoke.md) section shows how to establish hybrid connectivity from your AVS environment in a hub & spoke topology in a single region. This section includes integration with workloads in Azure and also datacenters or branch offices with the SDCC. 



## Example Architectures 

The Azure Landing Zone accelerator provides an additional [reference guides](./example-architectures.md)  for some common use patterns for connecting to Azure including: 

- Default route propagation using [Secured Virtual VWAN Hub](./example-architectures.md#secured-virtual-wan-hub-with-default-route-propagation)
- [Inspect traffic between Azure and AVS](./example-architectures.md#third-party-firewall-solutions-in-a-hub-virtual-network-with-azure-route-server) using an NVA in a Hub VNET
- Default route propagation from within the [Azure VMware Solution](./example-architectures.md#egress-from-azure-vmware-solution-with-or-without-nsx-t-or-nva) datacenter. 

## Multiregion Design 

[Dual connectivity hub & spoke:](./eslz-dual-region-network-topology.md) This section explores considerations for hybrid connectivity across two or more regions. 

## Next steps

Examine design considerations and recommendations related to connectivity that are specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Connectivity and Network Topologies for AVS](./eslz-network-topology-connectivity.md)