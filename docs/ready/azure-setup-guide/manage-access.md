---
title: Manage access to resources in Azure
description: Manage access to resources in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
---

# Manage access to resources in Azure

Azure role-based access control (RBAC) defines who can access Azure resources, what actions they can perform, and where they can perform them. This structure improves governance, security, and operational clarity across your cloud environment.

## Apply least privilege to all access assignments

The principle of least privilege ensures users receive only the permissions required to perform their tasks. This approach reduces risk and improves auditability.

1. **Start with built-in roles.** Azure RBAC has [built-in roles](/azure/role-based-access-control/built-in-roles) with permissions that align to common scenarios. Start with the built-in roles and only create custom roles when clearly needed. Start with [job-function roles](/azure/role-based-access-control/role-assignments-steps#job-function-roles) and only use [privileged administrator roles](/azure/role-based-access-control/role-assignments-steps#privileged-administrator-roles) (Owner, Contributor, Reader, Role Based Access Control Administrator, and User Access Administrator) when job-function roles aren't sufficient.

2. **Assign roles with minimal permissions.** Each role includes a set of permissions defined in its role definition. Select roles that grant only the permissions necessary for the user’s responsibilities. Avoid over-provisioning access.

3. **Assign roles at the narrowest possible scope.** Role [scope](/azure/role-based-access-control/scope-overview) determines where permissions apply. Assign roles at the scope needed to perform essential tasks.

    | Role scope           | Description                                                                 |
    |------------------|-----------------------------------------------------------------------------|
    | Management group | Role permissions apply to all subscriptions and resources within the management group. |
    | Subscription     | Role permissions apply to all resource groups and resources within the subscription. |
    | Resource group   | Role permissions apply to all resources within that resource group.        |
    | Resource         | Role permissions apply only to the specific resource (for example, an Azure AI Foundry instance). |

For detailed steps, see [Apply Azure RBAC roles](/azure/role-based-access-control/role-assignments-portal).

## Use groups to manage resource access

Instead of assigning roles to individual users, assign them to Microsoft Entra ID groups. This structure improves scalability, auditability, and governance by centralizing role assignments.

1. **Create security groups based on access scope.** Define security groups that reflect the scope of access, such as at the resource, resource group, or subscription level. For example, create separate groups for development, testing, and production environments, such as AI-Developer-Dev, AI-Developer-Test, AI-Developer-Prod. This structure enforces least privilege and environment isolation. For steps to create a security group, see [Manage Microsoft Entra ID groups](/entra/fundamentals/how-to-manage-groups).

2. **Assign roles to groups at the lowest necessary scope.** Apply the principle of least privilege when assigning roles to groups. Avoid assigning roles at higher scopes unless required. This approach reduces risk and simplifies audits.

3. **Refine group structure as your environment evolves.** Adjust group definitions to reflect changes in workloads, teams, or responsibilities. This refinement ensures continued clarity and control over access. For example:

    | Business role          | Business need                                                      | Group name         | Azure RBAC role | Scope of permissions       |
    |-------------------|------------------------------------------------------------------|--------------------|-----------------|----------------------------|
    | Subscription owners | Manage access control, governance, and billing across the subscription | Subscription-Owners | Owner           | Subscription level         |
    | AI developers         | Build and deploy models in Azure AI Foundry                          | AI-Foundry-Dev     | Contributor      | Resource group level       |
    | Finance            | Review billing, usage, and cost reports                                 | Finance-Readers    | Reader           | Subscription level         |

4. **Limit Owner role assignments.** The Owner role grants full access to manage all resources and assign roles in Azure RBAC. Limit this role to three or fewer users per subscription. Review and adjust the default Owner assignment for subscription creators as needed.

## Review access regularly

Access reviews ensure that permissions remain appropriate as users change roles or projects end.

1. **Schedule monthly or quarterly access reviews.** Review both Microsoft Entra ID roles and Azure RBAC assignments. Remove unnecessary roles promptly to maintain security.

2. **Use automated tools to streamline reviews.** Use tools like [Access Review](/entra/id-governance/access-reviews-overview) (Microsoft Entra ID Premium P2) or export role assignments for manual checks. Treat access governance as ongoing maintenance.

## Next step

> [!div class="nextstepaction"]
> [Manage costs](./manage-costs.md)