---
title: Prepare for cloud adoption
description: Learn about architectures, solutions, and guides that can help you explore the various networking capabilities for Azure VMware Solution
author: sablair
ms.author: sablair
ms.date: 05/31/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank
---
# Prepare for cloud adoption

Before adoption can begin, create a landing zone to host the workloads that you plan to build in or migrate to the cloud. This section of the framework guides you through how to establish connectivity within your landing zone.

The following exercises help guide you through the process of creating a landing zone to support cloud adoption.

| Legend | Design area | Objective |
|--|--|--|
| ![The letter A](./media/diagram-legends/a.png) | [Design Guides]() | Proper foundational creation of the network topology are important early steps. |
| ![The letter B](./media/diagram-legends/b.png) | [Hub & Spoke ](./design-area/identity-access.md) | Azure landing zone conceptual Hub and Spoke that integrate Azure VMware solution with Azure native resources |
| ![The letter C](./media/diagram-legends/c.png) | [Dual Region](./eslz-dual-region-network-topology.md) |Design  disaster resilient network connectivity  across multiple private clouds. |
| ![The letter D](./media/diagram-legends/d.png) | [Example Architectures](./example-architectures.md) | Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture. |
| ![The letter E](./media/diagram-legends/e.png) | [Design Considerations and Recommendations](./eslz-network-topology-connectivity.md) | As cloud adoption scales, considerations and best practices for network design and operational management have an impact on scale, governance, and adoption patterns. |


## Next steps

Examine design considerations and recommendations related to connectivity that are specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Network Considerations and Recommendations for AVS](./eslz-network-topology-connectivity.md)