---
title: Resource organization for Azure HPC in the energy industry
description: This article provides naming and tagging recommendations to help you align HPC implementations in the energy industry with Cloud Adoption Framework methodologies. 
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
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

- [Azure Billing and Azure Active Directory Tenants for Energy HPC](./azure-billing-active-directory-tenant.md)
- [Azure Identity and Access Management for Energy HPC](./identity-access-management.md)
- [Management for Energy HPC](./management.md)
- [Network Topology and Connectivity for Energy HPC](./network-topology-connectivity.md)
- [Platform automation and DevOps for Energy HPC](./platform-automation-devops.md)
- [Governance for Energy HPC](.security-governance-compliance.md)
- [Security for Energy HPC](./security.md)
- [Compute for Energy HPC](./compute.md)
- [Storage for Energy HPC](./storage.md)
- [Landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)