---
title: 'Manufacturing HPC Azure billing and Active Directory tenants'
description: Azure landing zones for HPC don't have specific considerations or recommendations that affect billing offer decisions, enterprise enrollment, or Active Directory tenant decisions.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/11/2022
---

# Manufacturing HPC Azure billing and Active Directory tenants

Azure landing zones for HPC don't have specific considerations or recommendations that affect billing offer decisions, enterprise enrollment, or Azure Active Directory tenant decisions.

But it might be important to understand decisions previously made by the cloud platform team and the existing [enterprise enrollment or Azure Active Directory tenant decisions](../../../ready/landing-zone/design-area/azure-billing-ad-tenant.md).

## Review identity management and resource organization considerations

Review the [identity and access management considerations](../../sap/eslz-identity-and-access-management.md) to understand how to apply the Active Directory tenant in the design of authentication and authorization solutions. You might also want to evaluate the [resource organization considerations](../../sap/eslz-resource-organization.md) to understand how to organize enrollment into management groups, subscriptions, and resource groups.

## Next steps

The following articles provide guidance on each step in the cloud adoption journey for energy HPC environments.

- [Azure Identity and Access Management for Manufacturing HPC](./identity-access-management.md)
- [Management for Manufacturing HPC](./management.md)
- [Network topology and connectivity for Manufacturing HPC](./network-topology-connectivity.md)
- [Platform automation and DevOps for Manufacturing HPC](./platform-automation-devops.md)
- [Resource organization for Manufacturing HPC](./resource-organization.md)
- [Azure governance for Manufacturing HPC](./security-governance-compliance.md)
- [Security for Manufacturing HPC](./security.md)
- [Storage for Manufacturing HPC](./storage.md)
- [Landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)