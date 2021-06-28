---
title: "Azure Enterprise Scale Analytics management group and subscription organization for 'data management and analytics'"
description: Describe how this enterprise-scale scenario can improve management group and subscription organization of 'data management and analytics'
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Resource organization for 'data management and analytics' on Azure

To align with the [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

Enterprise Scale Analytics and AI includes a Data Management Landing Zone subscription which has the standard services of an [Enterprise Scale framework](/azure/cloud-adoption-framework/ready/enterprise-scale/). It is  connected to the Data Landing Zone(s) and connectivity subscriptions via Virtual Network Peering. For further reading on the subscriptions in Enterprise Scale Analytics and AI, see the [Data Management Landing Zone](data-management-landing-zone.md) and [Data Landing Zone](data-landing-zone.md) sections.

Organizational standards can be further enforced by implementing guard rails that are based on business rules by using **Azure Policies**. These policies can be assigned to a scope of resources such as management groups, subscriptions, resource groups or individual resources. Enterprise Scale Analytics and AI contains custom Azure Policies which apply to the Data Management Landing Zone and Data Landing Zone subscriptions. For further reading, see [Policies](policies.md).

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include VMs, load balancers, DNS labels, availability sets, virtual networks, subnets, ExpressRoute, NSGs, application security groups, tags, route tables, managed disks, and public IPs. A sample use case could be to tag all Azure development VMs with the tag `Dev`. This eases reporting and billing operations to pull a report for all things `Dev`. For more information, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).