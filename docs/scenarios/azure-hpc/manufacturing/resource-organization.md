---
title: 'Manufacturing HPC Resource organization in Azure'
description: Learn how to align with the Ready methodology of the Cloud Adoption Framework by using a naming and tagging strategy that includes business and operations details.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/15/2022
---

# Manufacturing HPC resource organization

To align with the [Ready methodology](../../../ready/index.md) of the Cloud Adoption Framework, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

## Use single versus multiple Azure subscriptions

 - In Microsoft Entra ID, a tenant is representative of an organization. It's a dedicated instance of the Microsoft Entra service that an organization receives and owns when it signs up for using Azure. Each Microsoft Entra tenant is distinct and separate from other Microsoft Entra tenants. An Azure tenant can have multiple subscriptions and each subscription can use the same Microsoft Entra ID.
 - You can choose single or multiple subscriptions based on your organization's needs.
     - Multiple subscriptions allow for easy view billing for each subscription and limit who can access the Microsoft Azure services associated with that subscription. For example, production versus non-production subscriptions, internal versus external, and so on.
     - Using multiple subscriptions helps in planning for subscriptions limits. For more information on the decision-making process for subscriptions, see [Subscription decision guide](../../../ready/landing-zone/design-area/resource-org-subscriptions.md?source=recommendations).
     - It's recommended that you consider Azure Resource Manager throttle limits when going with multiple versus single subscriptions. For more information on throttle limits, see [Throttling Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling).

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

Resources to name include:

- VMs
- Load balancers
- DNS labels
- Availability sets
- Virtual networks
- Subnets
- ExpressRoute
- NSGs
- Application security groups
- Tags
- Route tables
- Managed disks
- Public IPs

A sample use case would be to tag all Azure development VMs with the tag of Dev. This tag eases reporting and billing operations because you can pull a report for all things Dev. For more information on a naming and tagging strategy, see [Develop your naming and tagging strategy for Azure resources](../../../ready/azure-best-practices/naming-and-tagging.md).

## Next steps

The following articles provide guidance on each step in the cloud adoption journey for manufacturing HPC environments.

- [Manufacturing HPC Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Azure identity and access management for HPC in manufacturing](./identity-access-management.md)
- [Management for HPC in the manufacturing industry](./management.md)
- [Manufacturing HPC network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in the manufacturing industry](./platform-automation-devops.md)
- [Azure governance for manufacturing HPC](./security-governance-compliance.md)
- [Security for HPC in manufacturing industries](./security.md)
- [Manufacturing HPC storage](./storage.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
