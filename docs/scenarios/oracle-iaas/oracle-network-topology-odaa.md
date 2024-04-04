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

This article builds on several considerations and recommendations defined in [Azure landing zone design area for network topology and connectivity](../../ready/landing-zone/design-area/network-topology-and-connectivity.md). It offers key design considerations and recommendation for Oracle Database@Azure networking and connectivity.

## Design considerations

Consider the following when designing your network topology for Oracle Database@Azure:

- Oracle Database@Azure service is physically placed in Azure Datacenters and can be placed in an Azure Availability Zone. In light of this it is important to remember that availability zones are specific to a subscription, i.e. availability zone 1 is not necessarily the same physical datacenter in one subscription as availability zone 1 in another subscription. This is described in more detail in [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones).
- The scope for an Oracle Database@Azure solution is constrained to the Azure subscription where it is deployed. This means that all VM Clusters and networking resources are deployed in the same subscription.
- Regardless of the Oracle Database@Azure SKU deployed, you can deploy up to 8 VM clusters. Each VM cluster can be connected to a VNet which needs to exist prior to creating the VM Cluster. VM clusters can be connected to the same or different VNets.
- The Oracle Database@Azure service is deployed in private subnets in Azure only. The service is not immediately accessible from the Internet.
- Minimum size of Oracle Database@Azure subnet depends on the SKU. See [Network Setup for Exadata Cloud Infrastructure Instances](https://docs.oracle.com/en-us/iaas/exadatacloud/exacs/ecs-network-setup.html#ECSCM-GUID-D5C577A1-BC11-470F-8A91-77609BBEF1EA) for details.
- Any subnets delegated to the Oracle Database@Azure solution have constraints compared to regular subnets. See [Network planning for Oracle Database@Azure](/azure/oracle/oracle-db/oracle-database-network-plan#constraints) for more details.
- As the Oracle Database@Azure is deployed in private subnets only, there is no default name registration or resolution for database nodes.

## Design recommendations

- Do not route traffic between application and database subnets through network appliances or firewalls of any kind, including Azure Firewall, as this will introduce latency. Instead leverage either direct subnet to subnet communication inside the same VNet or use VNet peering to connect the application and database subnets if they are in different VNets.
- If you have implemented Virtual WAN, and application and database subnets are in different VNets, use VNet peering to connect the application and database subnets. Do not use Virtual WAN to connect the application and database VNets as this will introduce latency due to the traffic being routed through the Virtual WAN hub.
- If you have one or a limited number of databases servicing a limited application portfolio managed by a single team, you should consider co-locating the application portfolio and database services in the same VNet. This will reduce latency and simplify the network design as well as meet Azure landing zone recommended practices for subscription democratization.
- If you have multiple databases servicing different applications managed by different teams, you should consider treating the Oracle Database@Azure solution as a dedicated service. This means that you should deploy the Oracle Database@Azure solution in one or more dedicated subscriptions, with application solutions in separate subscriptions, using VNet peering to connect the application and database subnets. This will allow you to manage the application and database subnets independently and meet Azure landing zone recommended practices for subscription democratization.
- To minimize latency between application and database, ensure that the application and database components are in the same region and availability zone. Specifically if you have application components in different subscriptions than the database components, leverage the code found in [What are availability zones](/azure/reliability/availability-zones-overview?tabs=azure-cli#physical-and-logical-availability-zones) and from the availabilityZoneMappings property determine the physical availability zone where the services should be co-located.
- Since NSGs are not supported on the Oracle Database@Azure subnet, ensure that the following measures are taken:
  - Leverage NSGs on the application subnets to control traffic to and from the application subnets.
  - Leverage on-platform firewall products on the Oracle Database@Azure VM clusters such as SELinux and cellwall to control traffic to the service.
- Leverage Azure Private DNS for name resolution between application and database subnets. See [Azure Private DNS](/azure/dns/private-dns-overview) for details.

See below for potential network topologies for Oracle Database@Azure.

:::image type="content" source="media/exadata-network-single-app.png" alt-text="Suggested network architecture for simple application portfolio served by single database":::

:::image type="content" source="media/exadata-network-multiple-app.png" alt-text="Suggested network architecture for complex application portfolio served by single or multiple databases":::

## See also

[Identity and Access Management for Oracle Database@Azure](oracle-iam-odaa.md)
[Security guidelines for Oracle Database@Azure](oracle-security-odaa.md)
