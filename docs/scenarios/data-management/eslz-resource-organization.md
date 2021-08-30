---
title: Resource organization for enterprise-scale data management and analytics on Azure
description: Learn how this enterprise-scale scenario can improve management group and subscription organization of data management and analytics.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Resource organization for data management and analytics on Azure

To align with the Ready methodology of the Cloud Adoption Framework, implement a naming and tagging strategy. Your strategy should include business and operational details as components of resource names and metadata tags. For more information, see [Ensure the environment is prepared for the cloud adoption plan](../../ready/index.md).

Enterprise-scale for analytics and AI includes a data management landing zone subscription. This subscription has the standard services of an [enterprise-scale framework](/azure/cloud-adoption-framework/ready/enterprise-scale/). It's connected to the data landing zones and connectivity subscriptions by using virtual network peering. For more information on the subscriptions in enterprise-scale for analytics and AI, see [Data management landing zone](./architectures/data-management-landing-zone.md) and [data landing zone](./architectures/data-landing-zone.md).

You can further enforce organizational standards based on business rules by using the Azure Policy service. Assign these policies to a scope of resources, such as management groups, subscriptions, resource groups, or individual resources. Enterprise-scale for analytics and AI contains custom policies that apply to the data management landing zone and data landing zone subscriptions. For more information, see [Policies](./eslz-policies.md).

## Resource naming and tagging conventions

On the business side, ensure resource names and tags include the organizational information. These names identify your teams. Use a resource name along with the business owners who are responsible for resource costs. The operational side ensures names and tags include information for IT teams. These names identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include the following items:

- Virtual machines
- Load balancers
- DNS labels
- Availability sets
- Virtual networks
- Subnets
- ExpressRoute
- Network security groups
- Application security groups
- Tags
- Route tables
- Managed disks
- Public IP addresses

For example, tag all Azure development virtual machines with `Dev`. This strategy makes it easy to create a report for billing operations for all things `Dev`. For more information, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).

## Next steps

- [Security, governance, and compliance for data management and analytics](./eslz-security-governance-and-compliance.md)
- [Management and monitoring for data management and analytics](./eslz-management-and-monitoring.md)
