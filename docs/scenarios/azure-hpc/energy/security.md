---
title: Security for Azure HPC in energy
description: Learn about security considerations in the Azure landing zone for high-performance computing (HPC) in the energy sector.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/15/2022
---

# Security for Azure HPC in energy

The Azure landing zone for high-performance computing (HPC) doesn't have any specific recommendations that affect security-related decisions in the energy industry.

However, it might be important to understand any decisions that were previously made by the cloud platform team regarding security recommendations.

## Design considerations

Security rules and policies can be defined and applied based on environment, workflow, virtual machine (VM), physical server, and operator, including:
- Actions controlled through user permissions and logged for audit reporting. For example, root access privileges are only granted as needed and are based on the specified VMs, preventing compromise of other HPC workflows.
- Isolated workflows where sensitive data can't be shared with other HPC environments, workflows, or users running on the same underlying hardware.

For CycleCloud deployments, extra security practices should be followed:
- CycleCloud should be installed on a drive with only admin-group access, which prevents non-admin users from accessing non-encrypted data. Non-admin users shouldn't be included in this group. Ideally, access to the CycleCloud installation should be limited to only administrators.
- CycleCloud installations shouldn't be shared across trust boundaries.
- The role-based access controls within a single CycleCloud installation might not be sufficient in a true multi-tenant environment. Use separate and isolated CycleCloud installations for each tenant with critical data.

## Next steps

The following articles provide guidance for each step in the cloud adoption journey for energy HPC environments.

- [Azure billing and Azure Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Compute](./compute.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance for HPC in energy industries](./security-governance-compliance.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
