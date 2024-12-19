---
title: Resource Organization for Azure HPC
description: This article provides naming and tagging recommendations to help you align HPC implementations with Cloud Adoption Framework methodologies.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/14/2024
---

# Resource organization for Azure HPC

This article provides recommendations that can help you align HPC implementations with the [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure.

## Single vs. multiple Azure subscriptions

In Microsoft Entra ID, a tenant represents an organization. It's a dedicated instance of Microsoft Entra ID that an organization receives and owns when it signs up to use Azure. Each Microsoft Entra tenant is distinct and separate from other Microsoft Entra tenants. An Azure tenant can have multiple subscriptions, and each subscription can use the same Microsoft Entra instance.

The needs of your organization determine whether you should use a single subscription or multiple subscriptions:

- Multiple subscriptions enable you to easily view billing for each subscription. They also allow you to limit who can access the Azure services associated with each subscription. For example, you could have production and nonproduction subscriptions, or internal and external subscriptions.
- Using multiple subscriptions can help you plan for [subscriptions limits](/azure/azure-resource-manager/management/azure-subscription-service-limits).

For more information about the decision-making process, see [Subscription decision guide](../../ready/landing-zone/design-area/resource-org-subscriptions.md).

We also recommend that you consider ARM throttling limits when you make decisions about subscriptions. For more information, see [Throttling Resource Manager requests](/azure/azure-resource-manager/management/request-limits-and-throttling).

## Use Azure resource naming and tagging conventions

Implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

The business side of this strategy ensures that resource names and tags include the organizational information that you need to identify the associated teams. Include the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams can use to identify the workload, application, environment, criticality, and other information that's useful for managing resources.

Resources to name include VMs, load balancers, DNS labels, availability sets, virtual networks, subnets, Azure ExpressRoute, NSGs, application security groups, tags, route tables, managed disks, and public IPs. For example, you could label all development VMs with the tag `Dev`. Doing so makes it easier to pull billing reports and other reports for development VMs. For more information, see [Develop your naming and tagging strategy for Azure resources](../../ready/azure-best-practices/naming-and-tagging.md).
 
## Next steps

The following articles provide guidance that you might find helpful at various points during your cloud adoption process. They can help you succeed in your cloud adoption scenario for HPC environments.

- [Azure billing offers and Microsoft Entra tenants](../../ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant.md)
- [Identity and access management](identity-access-management.md)
- [Management](./manage.md)
- [HPC network topology and connectivity](./network-topology-connectivity.md)
- [Security](./secure.md)
- [Compute large-scale HPC application workloads in Azure VMs](./compute.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc/azure-hpc-landing-zone-accelerator.md) 