---
title: Network topology and connectivity for Oracle Database@Azure
description: Learn about network topology and connectivity for Oracle Database@Azure.
author: jfaurskov
ms.author: janfaurs
ms.date: 11/08/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
---

# Network topology and connectivity for Oracle Database@Azure

This article builds on several considerations and recommendations defined in [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md). It offers key design considerations and recommendations for Oracle Database@Azure networking and connectivity.

## Design considerations

Consider the following when designing your network topology for Oracle Database@Azure:

- Oracle Database@Azure service is physically placed in Azure Datacenters and can be placed in an Azure Availability Zone. In light of this it is important, both from a network latency and a resiliency standpoint, to remember that availability zones are specific to a subscription. Availability zone 1 is not necessarily the same physical datacenter in one subscription as availability zone 1 in another subscription. This is described in more detail in [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones).
- The scope for an Oracle Database@Azure solution is its Azure subscription. All virtual machine clusters and networking resources are in one subscription.
- Every Oracle Database@Azure SKU can have up to eight virtual machine clusters. Before you create a VM cluster, you must have a virtual network. You can connect virtual machine cluster to either the same virtual network or to different virtual networks.
- The Oracle Database@Azure service deploys to private subnets in Azure and isn't immediately accessible from the Internet.
- The minimum size subnet you need for the Oracle Database@Azure service depends on the SKU you use. For more information, see [Network setup for Exadata Cloud Infrastructure Instances](https://docs.oracle.com/en-us/iaas/exadatacloud/exacs/ecs-network-setup.html#ECSCM-GUID-D5C577A1-BC11-470F-8A91-77609BBEF1EA) for details.
- Any subnets delegated to the Oracle Database@Azure solution have constraints compared to regular subnets. For more information, see [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#constraints).
- There's no default name registration or resolution for database nodes since Oracle Database@Azure only runs in private subnets.

## Design recommendations

- Avoid routing traffic between the application and database subnets through network appliances or firewalls, such as Azure Firewall. These devices can cause latency. Instead, use direct communication between subnets within the same virtual network for efficient traffic flow. If the application and database subnets are in different virtual networks, use direct virtual network peering, not transitive routing through the hub.
- If you have implemented Virtual WAN and application and database subnets are in different virtual networks, use virtual network peering to connect the application and database subnets. Do not use Virtual WAN to connect the application and database virtual networks. Virtual WAN adds latency because it routes traffic through the Virtual WAN hub.
- If you have one or a limited number of databases servicing a limited application portfolio managed by a single team, you should co-locate the application portfolio and database services in the same virtual network. Co-location reduces latency and simplifies the network design.
- If you have multiple databases servicing different applications managed by different teams, treat the Oracle Database@Azure solution as a dedicated service. This means that you deploy the Oracle Database@Azure solution in one or more dedicated subscriptions, with application solutions in separate subscriptions, using virtual network peering to connect the applications' networks to the databases' networks. This will allow you to manage the application and database subnets independently.
- To reduce latency between your application and database, ensure both components are located in the same region and availability zone. If your application components are in different subscriptions from your database components, refer to the code in [What are availability zones](/azure/reliability/availability-zones-overview#physical-and-logical-availability-zones). Use the `availabilityZoneMappings` property to identify the specific physical availability zone for co-locating the services.
- Oracle Database@Azure subnets don't support network security groups (NSGs). Follow these recommendations for security:
  - Use NSGs on the application subnets to control traffic to and from the application subnets.
  - Use on-platform firewall products, such as SELinux and cellwall, on the Oracle Database@Azure virtual machine clusters to control traffic to the service.
- Use Azure Private DNS for name resolution between application and database subnets. For more information, see [Azure Private DNS](/azure/dns/private-dns-overview).

Consider the following network topologies for Oracle Database@Azure.

:::image type="content" source="media/exadata-network-single-app.png" alt-text="Suggested network architecture for simple application portfolio served by single database":::

:::image type="content" source="media/exadata-network-multiple-app.png" alt-text="Suggested network architecture for complex application portfolio served by single or multiple databases":::

## Additional resources

- [Identity and Access Management for Oracle Database@Azure](oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](oracle-security-overview-odaa.md)
