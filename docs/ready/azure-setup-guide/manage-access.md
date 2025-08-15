---
title: Manage access to resources in Azure
description: Manage access to resources in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
---

# Manage access to resources in Azure

This article shows you how to manage access to Azure resources. When you first set up your Azure environment, one of the most important tasks is managing who can access and control your resources. This includes subscriptions, resource groups, and services like Azure AI Foundry, App Service, and Storage Accounts. Proper access management helps ensure your environment is secure, organized, and scalable.

Azure uses role-based access control (RBAC) to manage permissions. With Azure RBAC, you assign roles to users, groups, or applications at different scopes—such as a subscription, resource group, or individual resource. Azure RBAC works alongside Microsoft Entra ID, which handles identity management.

## Start with built-in roles

Start with Azure’s built-in roles—they’re designed for common scenarios and are easier to manage securely than custom roles. For details, see [Azure RBAC built-in roles](/azure/role-based-access-control/role-assignments-portal) for details. Here are three common roles:

| Common roles | Permissions | Use Case |
|--------------|-------------|----------|
| Owner | Full access to manage everything, including access control | Assign to 2-3 subscriptions owners who need full control over all resources. |
| Contributor | Can create and manage resources but cannot assign roles | Assign to users or teams responsible for managing resources without needing access control. |
| Reader | Can view resources but cannot make changes | Assign to users who only need to monitor or review resources, such as auditors or analysts. |

## Limit the number of Owner roles on subscriptions

The Owner role provides unrestricted access to all resources and access controls within a subscription. To reduce risk, limit this role to three or fewer users per subscription. By default, the account that creates a subscription is assigned the Owner role.

## Use groups to manage resource access

Instead of assigning roles to individual users, use Microsoft Entra ID security groups. This approach makes access easier to manage, audit, and scale. Always follow the principle of least privilege. Grant only the permissions necessary for each group to perform its tasks. Always assign roles to groups at the lowest scope necessary, resource group if possible, subscription only when needed.

So you need to great groups for each subscription, aligned to the scope of access required. For small teams, broad groups like “Developers”, “Finance”, or “Ops” may be sufficient.

| Function          | Description                                                      | Group name         | Azure RBAC role | Scope of permissions       |
|-------------------|------------------------------------------------------------------|--------------------|-----------------|----------------------------|
| Subscription owners | Administrators who manage access control, governance, and billing across the subscription | Subscription-Owners | Owner           | Subscription level         |
| Developers         | Engineering team builds and deploys models and pipelines in Azure AI Foundry | AI-Foundry-Dev     | Contributor      | Resource group level       |
| Finance            | Finance team reviews billing, usage, and cost reports across the subscription | Finance-Readers    | Reader           | Subscription level         |

As your team and Azure environment grow, refine groups based on specific workloads, scopes, or functions. For detailed steps, see [Assign Azure roles](/azure/role-based-access-control/role-assignments-portal).

## Plan to review access regularly

Schedule periodic reviews (monthly or quarterly) of both Microsoft Entra ID roles and Azure RBAC assignments. Remove unnecessary roles promptly when users change teams or projects end. Use tools like [Access Reviews](/entra/id-governance/access-reviews-overview) (Microsoft Entra ID Premium P2) or export role assignments for manual checks. Treat access governance as ongoing maintenance to keep your environment secure as it grows.

## Next step

> [!div class="nextstepaction"]
> [Manage costs](./manage-costs.md)