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

This AVS Landing zone connectivity section consists of sample architectures, solutions, and guides that can help you explore hybrid networking with Azure VMware Solution. 

Azure VMware solution provides a wide range of networking tools and capabilities for connecting with on-premises environments and Azure native workloads. 

Design areas include:

- **Hybrid integration**: Establishing connectivity with on-premises, multicloud, edge, and global users from the Software Defined Datacenter (SDDC).
- **Performance and reliability at scale**: Designing for a scalable, consistent, and low-latency experience.
- **Zero-trust-based network security** for network perimeter and secure traffic flows. For more information, see [Network security strategies on Azure](/azure/architecture/framework/security/design-network).
- **Extensibility** to easily expand networks while avoiding redesign.

## General Design Considerations and Recommendations

[Network Topology and Connectivity](./eslz-network-topology-connectivity.md) This section details general design considerations around ip addressing, bandwidth, and individual components (e.g Expressroute, VNETs)


## Outbound connectivity from AVS

This [Egress natively from AVS](./egress-from-avs.md) section shows how to establish outbound, hybrid connectivity from your AVS environment. This section includes integration with workloads in Azure and also datacenters or branch offices from the SDCC. 



## Example Architectures 

The Azure Landing Zone accelerator provides an additional [reference guides](./example-architectures.md)  for some common use patterns for connecting to Azure including: 

- Default route propagation using [Secured Virtual VWAN Hub](./example-architectures.md#secured-virtual-wan-hub-with-default-route-propagation)
- [Inspect traffic between Azure and AVS](./example-architectures.md#network-virtual-appliance-in-azure-virtual-network-to-inspect-all-network-traffic) using an NVA in a Hub VNET
- Default route propagation for AVS from [on-premises](./example-architectures.md#egress-from-azure-vmware-solution-through-00000-advertisement-from-on-premises) 

## Multiregion Design (Coming Soon)

This section explores considerations for hybrid connectivity across two or more regions. 

## Next steps

Examine design considerations and recommendations related to connectivity that are specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Connectivity and Network Topologies for AVS](./eslz-network-topology-connectivity.md)