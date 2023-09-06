---
title: Azure landing zone for Oracle on Azure VMs landing zone accelerator
description: Learn about Azure landing zone for Oracle on VMs landing zone accelerator.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 07/27/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---

# Azure landing zone for Oracle on Azure VMs landing zone accelerator

The Ready methodology of the Cloud Adoption Framework helps guide the creation of all Azure environments using Azure landing zones. Azure landing zones provide many implementation options built around a set of common design areas.

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with different Azure landing zone implementation options, which will include operations, security, and governance services in the initial environment.

## Azure landing zone conceptual architecture 

When preparing any environment for sustained cloud adoption, we use the Azure landing zones conceptual architecture to represent what a target end state should look like in Azure, see the following diagram.

:::image type="content" source="media/conceptual-architecture-oracle-landing-zone.png" alt-text="Diagram showing the conceptual architecture of Oracle on Azure landing zone accelerator.":::

When developing a long-term vision for landing zones, consider the design above. Working within this scenario, we focus on the most appropriate starting point to meet your strategic and planning requirements for Oracle on Azure. This article is about the starting point, not necessarily all the details required to reach the longer-term target. 

## Strategic & planning considerations for Oracle landing zones

Prioritization decisions made during strategy and plan conversations will have a direct impact on the most appropriate landing zone configuration to support your Oracle workloads implementations. Following are some important questions to consider during the planning phase:

Will the initial deployment require mature processes for operations, security, and governance prior to launch?

What type of migration is planned, big bang or gradual switchover?

Does the migration plan require a smaller initial implementation of Oracle for POC, development, or testing efforts on a shorter timeline?

Are there business continuity requirements to consider during the migration?

These questions will have a direct impact on implementation options.

## Implementation considerations

As most Oracle workload implementations are two/three tier architectures with an Oracle database as the data tier there is no need for special care to be taken with the management group hierarchy for a generic ALZ implementation. An Oracle workload will typically fit into one or more Azure Landing Zone subscriptions with little change from a generic scenario. One thing which must be considered though is requirements for workload database proximity and network latency. This includes considerations for HA and DR. The considerations around this are described in more detail in the BCDR documentation (link), but can be summarized as follows:  

Application workloads should typically be placed within Availability Zones or within the same datacenter with Proximity placement groups for low latency on their dependant database service.

For Azure HA scenarios primary and secondary database should be placed in an availability Set.  Depending business and technical requirements Data Guard can be configured according to RPO and RTO requirements also.

For DR scenarios primary and secondary database should be in different geographical locations. This can be availability zones or regions depending on distance requirements.

## Azure landing zone design areas

Regardless of your initial implementation option, Azure landing zones for Oracle should adhere to a set of common design considerations and recommendations outlined in the following articles. These considerations and recommendations can help the Oracle team evaluate any landing zone to ensure it is ready to host the Oracle platform in production:

Network topology and connectivity  

Management and monitoring  

Business continuity and disaster recovery

Security  

Next step: Migrate an Oracle workload to Azure IaaS 

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting Oracle in Azure.

Migrate your Oracle workload to Azure IaaS