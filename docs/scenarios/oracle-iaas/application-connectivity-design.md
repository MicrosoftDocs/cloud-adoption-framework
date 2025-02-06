---
title: Network Topology and Connectivity for Oracle Database@Azure - Application Connectivity Design
description: Learn how to connect an application tier to Oracle Database@Azure - Exadata Database Service. This article covers core network concepts and best practices for efficient integration between application and database tiers in colocated and peered virtual networks.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 02/10/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure - Application connectivity design

This article builds on the core network concepts for Oracle Database@Azure - Exadata Database Service. It describes best practices for how to configure and manage Azure networking to connect your application tier to Oracle Database@Azure - Exadata Database Service.

## Locate application tiers

The following two main scenarios are used to locate the application tier in an architecture design.

1. **Colocated in the same virtual network:** Application and database tiers reside within a single virtual network.

1. **Deployed in a separate virtual network and connected via virtual network peering:** Application and database tiers reside in distinct virtual networks that are connected via peering.

The colocated approach provides simpler management and no extra peering costs, but might be less flexible if multiple teams or applications need separate networks.

:::image type="content" source="./media/same-virtual-network.svg" alt-text="Diagram that shows the colocation of the database and application tiers in the same virtual network." border="false" lightbox="./media/same-virtual-network.svg":::

*Figure 1: The previous diagram shows the colocation of the database and application tiers in the same virtual network.*

The peered virtual network approach adds virtual network peering costs and more complexity, but provides better isolation, independent scalability, and governance boundaries. This approach can also improve your security posture by providing more granular access control over the resources and through enhanced network segmentation.

:::image type="content" source="./media/separate-virtual-network.svg" alt-text="Diagram that shows directly peered virtual networks." border="false" lightbox="./media/separate-virtual-network.svg":::

*Figure 2: The previous diagram shows the database and application tiers in directly peered virtual networks.*

In a full mesh pattern, each application virtual network is directly peered to the database virtual network, and both connect to a hub network for shared services like firewalls or DNS. This design helps ensure low-latency direct communication while enabling centralized traffic inspection and management.

:::image type="content" source="./media/separate-virtual-network-integrated.svg" alt-text="Diagram that shows the full mesh pattern between the database, application, and hub virtual network." border="false" lightbox="./media/separate-virtual-network-integrated.svg":::

*Figure 3: The previous diagram shows the full mesh pattern between the database, application, and hub virtual network.*

This pattern helps ensure direct connectivity from database and application virtual networks and protection from other networks.

## Design considerations

- **Cost factors:** Colocating the database and application tiers in the same virtual network incurs no extra network costs.

- **Connectivity options:** When you can't colocate the database and application tiers in the same virtual network, peering between virtual networks or traversing through a hub virtual network, like the standard virtual network or Virtual WAN hub, are options.

- **Known limitations:** Because of connectivity limitations from Oracle Database@Azure to Private Endpoints and serverless applications like Azure Functions, connectivity to these services requires an intermediate hop through a routing device like Azure Firewall or a non-Microsoft network virtual appliance.

- **Availability zone validation:** If you deploy the application tier in a separate subscription from the subscription that hosts Oracle Database@Azure – Exadata Database Service, logical availability zones might differ from physical availability zones across subscriptions. To validate the correct availability zones, use the following command and replace `eastus` with your desired region:

  ```bash
  az rest --method get --uri '/subscriptions/{subscriptionId}/locations?api-version=2022-12-01' \
    --query 'value' | jq '.[] | .availabilityZoneMappings | .[]? | select(.physicalZone | contains("eastus"))'
  ```

## Design recommendations

- **Optimize for bandwidth and latency:** Colocate workload-related resources within the same availability zones to minimize latency and maximize throughput.

- **Optimize for smaller workload scopes:** Colocate applications and databases in the same virtual network if you have a limited number of Oracle databases that serve a small application portfolio that a single team manages. This approach reduces latency and simplifies the network design.

- **Use segmentation for complex environments:** For larger or more complex environments, treat Oracle Database@Azure - Exadata Database Service as a dedicated service by deploying it in one or more dedicated subscriptions to manage multiple databases for different applications and teams. Deploy application solutions in separate subscriptions and use virtual network peering to connect the application networks to the database networks. This approach enables independent management of application and database resources while helping to maintain secure and performant connectivity.

## Next step

Now that you understand how to connect your application tier to Oracle Database@Azure - Exadata Database Service, see the [BCDR connectivity design](./bcdr-connectivity-design.md) guidance. This guidance helps you establish the required network foundations and best practices needed to support business continuity and disaster recovery strategies.
