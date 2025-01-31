---
title: Network topology and connectivity for Oracle Database@Azure - Application Connectivity Design
description: Learn about connecting an application tier to Oracle Database@Azure.
author: moisesjgomez
ms.author: mgomezcortez
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Application Connectivity Design for Oracle Database@Azure - Exadata Database Service

Building on the core network concepts for Oracle Database@Azure - Exadata Database Service, this article offers best practices for configuring and managing Azure networking to connect your application tier to Oracle Database@Azure - Exadata Database Service.

There are two main scenarios for locating the application tier in an architecture design.

1. Colocated in the same virtual network (VNet): Application and database tiers reside within a single VNet.
2. Deployed in a separate VNet and connected via VNet peering: Application and database tiers reside in distinct VNets connected via peering.

The following diagrams represent the 2 options:

**Colocating within the same VNet:**

![Colocating within the same VNet](./media/Same-VNet.png)

Figure 1: CoLocating Database and Application Tier in the Same VNet

**Peered VNets:**

![Directly peered VNets](./media/Separate-VNet.png)

Figure 2: Database and Application Tier in Peered VNets

The colocated option offers simpler management and no extra peering costs, but may be less flexible if multiple teams or applications need separate networks. The peered VNet approach introduces VNet peering costs and slightly more complexity, but provides better isolation, independent scalability, and governance boundaries. This approach can also improve your security posture by providing more granular access control over the involved resources and through enhanced network segmentation.

In a full mesh pattern, each application VNet is directly peered to the database VNet, and both connect to a Hub network for shared services like firewalls or DNS. This design ensures low-latency direct communication while still enabling centralized traffic inspection and management. The following diagram depicts this scenario:

![Full mesh pattern](./media/Separate-vNet-Integrated.png)

Figure 3: Full mesh pattern between database, application, and Hub VNet

This pattern ensures direct connectivity from database and application VNets and protection from other networks.

**Design Considerations**

- **Cost factors:** Colocating the Database and Application tiers in the same VNet incurs no extra network costs.
- **Connectivity options:** When colocating the Database and Application tiers in the same VNet isn't an option, peering between VNets or traversing through a Hub VNet (Standard VNet or VWAN Hub) are options.
- **Known limitations:** Due to a current limitation on connectivity from Oracle Database@Azure to Private Endpoints and serverless applications like Azure Functions, connectivity to these services requires an intermediate hop through a routing device like Azure Firewall or a third party Network Virtual Appliance (NVA).
- **Availability Zone validation:** If deploying the application tier in a separate subscription from the subscription hosting Oracle Database@Azure – Exadata Database Service, Logical Availability Zones may differ from Physical Availability Zones across subscriptions. To validate the correct Availability Zones, use the following command, replacing `eastus` with your desired region:

  ```bash
  az rest --method get --uri '/subscriptions/{subscriptionId}/locations?api-version=2022-12-01' \
    --query 'value' | jq '.[] | .availabilityZoneMappings | .[]? | select(.physicalZone | contains("eastus"))'
  ```

**Design recommendations**

- **Optimize for Bandwidth and Latency:** Colocate workload-related resources within the same availability zones to minimize latency and maximize throughput.
- **Optimize for smaller workload scopes:** Colocate applications and databases in the same virtual network if you have a limited number of Oracle databases serving a small application portfolio managed by a single team. This reduces latency and simplifies the network design.
- **Separate for Complex Environments:** For larger or more complex environments, treat **Oracle Database@Azure - Exadata Database Service as a dedicated service**, deploying in one or more dedicated subscriptions to manage multiple databases for different applications and teams. Deploy application solutions in separate subscriptions and use virtual network peering to connect the application networks to the database networks. This approach enables independent management of application and database resources while maintaining secure and performant connectivity.

## Next Steps

Now that you understand how to connect your application tier to Oracle Database@Azure - Exadata Database Service, proceed to the [BCDR Connectivity Design](./bcdr-connectivity-design.md) guidance. This helps you establish the required network foundations and best practices needed to support business continuity and disaster recovery (BCDR) strategies.
