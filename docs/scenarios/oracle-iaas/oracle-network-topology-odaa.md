---
title: Network topology and connectivity for Oracle Database@Azure
description: Learn about key design considerations and recommendations for Oracle Database@Azure network topology and connectivity.
author: jfaurskov
ms.author: janfaurs
ms.date: 04/26/2024
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Network topology and connectivity for Oracle Database@Azure

This article builds on several considerations and recommendations that are defined in the [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md). It provides key design considerations and recommendations for Oracle Database@Azure networking and connectivity.

## Design considerations

Consider the following guidance when you design your network topology for Oracle Database@Azure:

- You can physically place the Oracle Database@Azure service in Azure datacenters or in an Azure availability zone. Availability zones are subscription-specific, which affects network latency and resiliency. For instance, an availability zone doesn't necessarily have the same physical datacenter from one subscription to another subscription. For more information, see [What are availability zones?](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones).

- Every Oracle Database@Azure SKU can have up to eight virtual machine (VM) clusters. You must have a virtual network before you create a VM cluster. You can connect VM clusters to either the same virtual network or to different virtual networks.

- The Oracle Database@Azure service deploys to private subnets in Azure and isn't immediately accessible from the internet.

- The minimum size subnet that you need for the Oracle Database@Azure service depends on the SKU that you use. For more information, see [Network setup for Exadata Cloud Infrastructure instances](https://docs.oracle.com/iaas/exadatacloud/exacs/ecs-network-setup.html#ECSCM-GUID-D5C577A1-BC11-470F-8A91-77609BBEF1EA).

- Unlike regular subnets, subnets that you delegate to the Oracle Database@Azure solution have constraints. For more information, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#constraints).

- Database nodes don't have a default name registration or resolution because Oracle Database@Azure runs only in private subnets.

## Design recommendations

Consider the following recommendations when you design your network topology for Oracle Database@Azure:

- Don't route traffic between the application and database subnets by using Azure network virtual appliances (NVAs), firewalls (such as Azure Firewall), Azure Virtual WAN hub, or partner NVAs. This configuration adds network latency. Instead, you can use direct communication between subnets within the same virtual network for efficient traffic flow. If the application and database subnets are in different virtual networks, use direct virtual network peering instead of transitive routing through the hub.

- Colocate the application portfolio and database services in the same virtual network if you have a limited number of databases that service a limited application portfolio that's managed by a single team. Colocation reduces latency and simplifies the network design.

- Treat the Oracle Database@Azure solution as a dedicated service if you have multiple databases that service different applications that are managed by different teams. Deploy the Oracle Database@Azure solution in one or more dedicated subscriptions. Deploy the application solutions in separate subscriptions and use virtual network peering to connect the application networks to the database networks. Use this configuration to manage the application and database subnets independently.

- Ensure that you place application and database components in the same region and availability zone to reduce latency between your application and database. If your application components are in different subscriptions from your database components, see [Physical and logical availability zones](/azure/reliability/availability-zones-overview#physical-and-logical-availability-zones). Use the `AvailabilityZoneMappings` property to identify the specific physical availability zone for colocating the services.

- Oracle Database@Azure subnets don't support Azure network security groups (NSGs). Instead, use the [Oracle Cloud NSG](https://docs.oracle.com/iaas/Content/Network/Concepts/networksecuritygroups.htm) that gets created in the Oracle Database@Azure OCI Virtual Cloud Network (VCN) to control traffic to and from the Exadata/ADBS system.
  
- Use Azure private DNS zones for name resolution between application and database subnets. For more information, see [Private DNS](/azure/dns/private-dns-overview).

The following example network topology is for a complex application portfolio that's served by a single or multiple databases.

:::image type="content" source="media/oracle-network-topology-odaa/exadata-network-single-app.png" alt-text="Diagram that shows the suggested network architecture for a simple application portfolio that's served by a single database.":::

:::image type="content" source="media/oracle-network-topology-odaa/exadata-network-multiple-app.png" alt-text="Diagram that shows the suggested network architecture for a complex application portfolio that's served by a single or multiple databases.":::

## Next steps

- [Identity and access management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
- [Business continuity and disaster recovery (BCDR) for Oracle Database@Azure](oracle-disaster-recovery-odaa.md)
