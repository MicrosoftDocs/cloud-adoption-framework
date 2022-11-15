---
title: ' Energy HPC Security | Microsoft Docs'
description: 'Azure landing zones for HPC in Energy do not have any specific considerations or recommendations which would impact security related decisions.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Security for energy HPC

Azure landing zones for HPC in Energy do not have any specific considerations or recommendations which would impact security related decisions.

However, it could be important to understand any decisions previously made by the cloud platform team to be aware of existing security recommendations.

## HPC Design consideration:

 - Security rules and policies can be defined and applied based on environment, workflow, VM, physical server, and operator, including:
     - Actions controlled via user permissions and logged for audit reporting. For example, root access privileges are only granted as needed and based on the specified VMs, preventing compromise of other HPC workflows.
     - Isolated workflows where sensitive data cannot be shared with other HPC environments, workflows, or users running on the same underlying hardware.
 - For CycleCloud deployments, additional security practices should be followed:
     - CycleCloud should be installed on a drive with only admin-group access. This will prevent non-admin users from accessing non-encrypted data. Non-admin users should not be included to this group. Ideally, access to the CycleCloud installation should be limited to only administrators.
     - Do not share CycleCloud installation across trust boundaries
     - The RBAC controls within a single CycleCloud installation may not be sufficient in a true multi-tenant environment. Use separate and isolated CycleCloud installations for each tenant with critical data.

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Compute](./compute.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Security Governance Compliance](./security-governance-compliance.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
