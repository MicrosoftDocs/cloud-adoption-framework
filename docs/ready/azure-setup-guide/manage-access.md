---
title: Manage access to resources in Azure
description: Manage access to resources in Azure
author: stephen-sumner
ms.author: pnp
ms.date: 08/15/2025
ms.topic: conceptual
---

# Manage access to resources in Azure

This article shows you how to manage access to Azure resources. Managing Azure resource access means defining who can view, create, or modify resources such as subscriptions, resource groups, and resources like Azure AI Foundry, App Service, Storage Accounts. These permissions determine how your cloud environment is deployed, operated, and secured.

You manage resource access through Azure role-based access control (Azure RBAC). Azure RBAC assigns roles at different scopes—subscription, resource group, or individual resource—to define what actions users or groups can perform. Azure RBAC is separate from Entra ID RBAC but integrates with Entra ID identities.

## Start with built-in roles

Rather than creating custom roles, which are more difficult to secure, use built-in Azure RBAC roles. Microsoft provides roles for common scenarios. See [Azure RBAC built-in roles](/azure/role-based-access-control/role-assignments-portal) for details. For example:

    | Common roles | Permissions | Use Case |
    |--------------|-------------|----------|
    | Owner | Full access to manage everything, including access control | Assign to 2-3 subscriptions owners who need full control over all resources. |
    | Contributor | Can create and manage resources but cannot assign roles | Assign to users or teams responsible for managing resources without needing access control. |
    | Reader | Can view resources but cannot make changes | Assign to users who only need to monitor or review resources, such as auditors or analysts. |

## Limit the number of Owner roles on subscriptions

The Owner role at the subscription level allows full control over all resources and access assignments in that subscription. The Owner role grants full control at the subscription level. Keep it to three or fewer per subscription. By default, the account that creates a subscription becomes an Owner.

## Use groups to manage resource access

Instead of assigning roles to individual users, create Microsoft Entra ID security groups. These groups must align with the scopes of access required. For very small teams, one group per function (“Developers”, “Finance”, “Ops”) might be enough. As your environment grows, refine groups based on scope of access:

    | Use Case                          | Description                                                                 | Example Group Name       | Role Assignment | Scope               |
    |-----------------------------------|-----------------------------------------------------------------------------|--------------------------|-----------------|---------------------|
    | Engineering team manages all resources | Developers need to deploy and manage services across the entire subscription | Engineering-Contributors | Contributor     | Subscription level  |
    | Specific team manages a project workload | A product or feature team needs to manage resources in a dedicated resource group | RG-DataTeam or RG-WebTeam | Contributor     | Resource group level |
    | Finance or leadership needs visibility | Finance, operations, or leadership needs to monitor costs and usage without making changes | Finance-Readers          | Reader          | Subscription level  |

For detailed steps, see [Assign Azure roles](/azure/role-based-access-control/role-assignments-portal).

## Plan to review access regularly

Schedule periodic reviews (monthly or quarterly) of both Microsoft Entra ID roles and Azure RBAC assignments. Remove unnecessary roles promptly when users change teams or projects end. Use tools like [Access Reviews](/entra/id-governance/access-reviews-overview) (Microsoft Entra ID Premium P2) or export role assignments for manual checks. Treat access governance as ongoing maintenance to keep your environment secure as it grows.

## Next step

