---
title: Security for HPC in manufacturing industries
description: Azure landing zones in manufacturing industries don't have any specific considerations or recommendations that affect decisions about security.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/23/2022
---

# Security for HPC in manufacturing industries

Azure landing zones for high performance computing (HPC) in manufacturing industries don't have any specific considerations or recommendations that affect decisions about security.

However, it might be important to understand any decisions that your cloud platform team has made so that you're aware of existing recommendations. For more information, see [Design area: Security](../../../ready/landing-zone/design-area/security.md).

## Design consideration for security

You can define and apply security rules and policies that are based on environment, workflow, virtual machine (VM), physical server, and operator. Examples of rules and policies include:

  - Actions that are controlled by user permissions and that are logged for audit reporting. For example, root access is granted only as needed and based on the specified VMs. Scoping access in this way helps to prevent compromising other HPC workflows.

  - Isolated workflows where sensitive data can't be shared with other HPC environments, workflows, or users even if they're on the same underlying hardware.
 
  - Additional security practices for CycleCloud deployments:

    - Only administrators should have access to the drive on which CycleCloud is installed. Limiting access to the administrators' group prevents users who aren't administrators from accessing non-encrypted data.

    - Don't share an installation of CycleCloud across trust boundaries. For more information about trust relationships, see [How trust relationships work for forests in Active Directory](/azure/active-directory-domain-services/concepts-forest-trust).

    - The Azure role-based access control (Azure RBAC) within a single installation of CycleCloud installation might not be sufficient in a true multi-tenant environment. Use separate and isolated installations of CycleCloud for each tenant that has critical data. For more information about Azure RBAC, see [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
   
## HPC Pack user roles and security

  - There are several [roles](/powershell/high-performance-computing/understanding-user-roles) that users may be added to Administrator, User, Job Administrator, and Job Operator.

    
  - Active Directory Domain Services (AD DS) or Microsoft Entra Domain Services is a prerequisite to installing Microsoft HPC Pack because the authentication process for users and computers relies on the services provided by AD DS.

    
  - At installation time, the HPC cluster administrator role is automatically granted to all members of the local Administrators security group on the head node. When an identity is added as an HPC cluster administrator, it is also added to the local Administrators security group.



## Next steps

The following articles provide guidance for specific points in cloud adoption of HPC in manufacturing industries.

- [Manufacturing HPC Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Azure identity and access management for HPC in manufacturing](./identity-access-management.md)
- [Management for HPC in the manufacturing industry](./management.md)
- [Manufacturing HPC network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps for Azure HPC in the manufacturing industry](./platform-automation-devops.md)
- [Manufacturing HPC resource organization](./resource-organization.md)
- [Azure governance for manufacturing HPC](./security-governance-compliance.md)
- [Manufacturing HPC storage](./storage.md)
- [Azure high-performance computing (HPC) landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
