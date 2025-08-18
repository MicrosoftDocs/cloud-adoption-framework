---
title: Manage access to resources in Azure
description: Manage access to resources in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
---

# Manage access to resources in Azure

Role-based access control (RBAC) defines who can access Azure resources, what actions they can perform, and where they can perform them. This structure improves governance, security, and operational clarity across your cloud environment.

## Apply least privilege to all access assignments

The principle of least privilege ensures users receive only the permissions required to perform their tasks. This approach reduces risk and improves auditability.

1. **Start with built-in roles.** Azure RBAC has [built-in roles](/azure/role-based-access-control/built-in-roles) with permissions that align to common scenarios. Start with the built-in roles and only create custom roles when clearly needed. Start with the following Azure RBAC roles: Owner, Contributor, Reader, Role Based Access Control Administrator, and User Access Administrator. For more information, see [Overview of common Azure roles](/azure/role-based-access-control/rbac-and-directory-admin-roles#azure-roles).

2. **Assign roles with minimal permissions.** Each role includes a set of permissions defined in its role definition. Select roles that grant only the permissions necessary for the user’s responsibilities. Avoid over-provisioning access.

3. **Assign roles at the narrowest possible scope.** Role [scope](/azure/role-based-access-control/scope-overview) determines where permissions apply. Assign roles at the resource or resource group level when possible. Avoid assigning roles at broader scopes like subscriptions or management groups unless absolutely necessary.

    | Role scope           | Description                                                                 |
    |------------------|-----------------------------------------------------------------------------|
    | Management group | Role permissions apply to all subscriptions and resources within the management group. |
    | Subscription     | Role permissions apply to all resource groups and resources within the subscription. |
    | Resource group   | Role permissions apply to all resources within that resource group.        |
    | Resource         | Role permissions apply only to the specific resource (for example, an Azure AI Foundry instance). |

For detailed steps, see [Apply Azure RBAC roles](/azure/role-based-access-control/role-assignments-portal).

## Use groups to manage resource access

Instead of assigning roles to individual users, assign them to Microsoft Entra ID security groups. This structure improves scalability, auditability, and governance by centralizing role assignments.

1. **Create security groups based on access scope.** Define groups that reflect the scope of access—resource, resource group, or subscription. For example, create separate groups for development, testing, and production environments (AI-Developer-Dev, AI-Developer-Test, AI-Developer-Prod). This structure enforces least privilege and environment isolation.

1. **Create security groups that match the required access scope.** Define groups based on the scope of access needed, such as to a resource, resource group, or subscription. For example, if developers need access across dev, test, and prod subscriptions, create separate groups for each environment (AI-Developer-Dev, AI-Developer-Test, AI-Developer-Prod). This separation enforces least privilege and environment isolation. For steps to create security group, see [Manage Microsoft Entra groups](/entra/fundamentals/how-to-manage-groups).

1. **Assign Azure roles to groups at the lowest necessary scope.** Use the principle of least privilege to assign roles only where needed. Avoid assigning roles at higher scopes unless absolutely required. This minimizes risk and simplifies audits.

1. **Refine group structure as your environment evolves.** As workloads and teams grow, adjust group definitions to reflect specific functions, scopes, or workloads. This ensures continued clarity and control over access. Example group structure:

    | Business role          | Business need                                                      | Group name         | Azure RBAC role | Scope of permissions       |
    |-------------------|------------------------------------------------------------------|--------------------|-----------------|----------------------------|
    | Subscription owners | Administrators who manage access control, governance, and billing across the subscription | Subscription-Owners | Owner           | Subscription level         |
    | AI developers         | Engineering team builds and deploys models and pipelines in Azure AI Foundry | AI-Foundry-Dev     | Contributor      | Resource group level       |
    | Finance            | Finance team reviews billing, usage, and cost reports across the subscription | Finance-Readers    | Reader           | Subscription level         |

1. **Limit the number of Owner roles on subscriptions.** The Owner role provides unrestricted access to all resources and access controls within a subscription. To reduce risk, limit this role to three or fewer users per subscription. By default, the user account that creates a subscription is assigned as the Owner role. Keep or remove the Owner role assignment from the user account that created the subscription as needed.

## Review access regularly

Schedule periodic reviews (monthly or quarterly) of both Microsoft Entra ID roles and Azure RBAC assignments. Remove unnecessary roles promptly when users change teams or projects end. Use tools like [Access Reviews](/entra/id-governance/access-reviews-overview) (Microsoft Entra ID Premium P2) or export role assignments for manual checks. Treat access governance as ongoing maintenance to keep your environment secure as it grows.

## Next step

> [!div class="nextstepaction"]
> [Manage costs](./manage-costs.md)