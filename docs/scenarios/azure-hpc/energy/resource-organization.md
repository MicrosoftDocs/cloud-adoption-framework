---
title: Resource organization for Azure HPC in the energy industry
description: This article provides naming and tagging recommendations to help you align HPC implementations in the energy industry with Cloud Adoption Framework methodologies.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/14/2022
---

# Resource organization for HPC in the energy industry

To align with the [Ready methodology](../../../ready/index.md) of the Cloud Adoption Framework for Azure, implement a naming and tagging strategy that includes business and operational details as components of resource names and metadata tags.

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information that you need to identify the associated teams. Include the business owners who are responsible for resource costs. The operational side ensures that names and tags include information that IT teams can use to identify the workload, application, environment, criticality, and other information that's useful for managing resources.

Resources to name include VMs, load balancers, DNS labels, availability sets, virtual networks, subnets, Azure ExpressRoute, NSGs, application security groups, tags, route tables, managed disks, and public IPs. For example, you could label all development VMs with the tag `Dev`. Doing so makes it easier to pull billing reports and other reports for development VMs. For more information, see [Develop your naming and tagging strategy for Azure resources](../../../ready/azure-best-practices/naming-and-tagging.md).

## Next steps

The following articles provide guidance that you might find helpful at various points during your cloud adoption process. They can help you succeed in your cloud adoption scenario for HPC in the energy industry.

- [Azure Billing and Microsoft Entra tenants for energy HPC](./azure-billing-active-directory-tenant.md)
- [Identity and access management for Azure HPC in energy](./identity-access-management.md)
- [Management for Azure HPC in energy](./management.md)
- [Network topology and connectivity for Azure HPC in energy](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in energy](./platform-automation-devops.md)
- [Governance for HPC in energy industries](./security-governance-compliance.md)
- [Security for Azure HPC in energy](./security.md)
- [Compute large-scale HPC application workloads in Azure VMs](./compute.md)
- [Storage for HPC energy environments](./storage.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
