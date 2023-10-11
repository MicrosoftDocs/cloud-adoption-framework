---
title: Transition existing Azure environments to the Azure landing zone conceptual architecture
description: Learn how to onboard existing environments to an Azure landing zone conceptual architecture.
author: JefferyMitchell
ms.author: martinek
ms.date: 10/22/2021
ms.topic: conceptual
ms.custom: think-tank, csu
---

<!-- docutune:casing resourceType resourceTypes resourceId resourceIds -->

# Transition existing Azure environments to the Azure landing zone conceptual architecture

Most organizations might have an existing footprint in Azure, one or more subscriptions, and potentially an existing structure of their management groups. Depending on their initial business requirements and scenarios, Azure resources such as hybrid connectivity (for example with site-to-site VPN or Azure ExpressRoute) might have been deployed.

This article provides recommendations to help your organization navigate changes based on your existing Azure environment transitioning into the Azure landing zone conceptual architecture. This article also describes considerations for moving resources in Azure, for example moving a subscription from one existing management group to another management group. These considerations help you evaluate and plan for transitioning your existing Azure environment.

## Move resources in Azure

You can move some resources in Azure post creation. There are different approaches your organization can take that are subject to a user's Azure role-based access control (RBAC) permissions at and across scopes. The following table outlines which resources you can move, at which scope, and the pros and cons associated with each resource.

| Scope | Destination | Pros | Cons |
| ----- | ----------- | ---- | ---- |
| Resources in resource groups | Can be moved to a new resource group in the same or different subscription | Allows you to modify the resource composition in a resource group after deployment | - Not supported by all resourceTypes <br> - Some resourceTypes have specific limitations or requirements <br> - resourceIds are updated and it affects existing monitoring, alerts, and control plane operations <br> - Resource groups are locked during the move period <br> - Requires assessment of policies and RBAC pre-move and post-move operation |
| Subscriptions in a tenant | Can be moved to different management groups | No affect on existing resources within the subscription because no resourceId values are changed | Requires an assessment of policies and RBAC pre-move and post-move operation |

To understand which move strategy you should use, consider the following examples:

## Subscription move

The common use cases for moving subscriptions are to organize subscriptions into management groups or when transferring subscriptions to a new Microsoft Entra ID tenant. Subscription moves focus on moving subscriptions to management groups. Moving a subscription to a new tenant is mainly for [transferring billing ownership](/azure/cost-management-billing/manage/billing-subscription-transfer). For more information about how to move subscriptions across management groups in the same tenant, see [Moving management groups and subscriptions](/azure/governance/management-groups/manage#moving-management-groups-and-subscriptions).

### Azure RBAC requirements

To assess a subscription prior to a move, it's important that the user has the appropriate Azure RBAC. The user might be an owner on the subscription (direct role assignment) and have write permission on the target management group. Built-in roles that support write permission on the target management group are the owner role, the contributor role, and the management group contributor role.

If the user has an inherited owner role permission on the subscription from an existing management group, the subscription can only be moved to the management group where the user is assigned the owner role.

### Policy

Existing subscriptions might be subject to Azure policies that are assigned directly or at the management group where they're currently located. It's important to assess current policies and the policies that might exist in the new management group or the management group hierarchy.

You can use Azure Resource Graph to perform an inventory of existing resources and compare their configuration with the policies that exist at the destination.

After you move subscriptions to a management group with existing Azure RBAC and policies in place, consider the following options:

- Any Azure RBAC that's inherited to the moved subscriptions can take up to 30 minutes before the user tokens in the management group cache are refreshed. To expedite this process, you can refresh the token by signing out and in, or request a new token.
- Any policy where the assignment scope includes the moved subscriptions performs audit operations only on the existing resources. Any existing resource in the subscription that's subject to a:

  - `DeployIfNotExists` policy effect appears as noncompliant and isn't remediated automatically but requires user interaction to perform the remediation manually.
  
  - `Deny` policy effect appears as noncompliant and isn't rejected. A user must manually mitigate this result as appropriate.
  
  - `Append` and `Modify` policy effect appears as noncompliant and requires user interaction to mitigate.
  
  - `Audit` and `AuditIfNotExist` policy effect appears as noncompliant and requires user interaction to mitigate.
  
- All new writes to resources in the moved subscription are subject to the assigned policies at real time like normal.

## Resource move

The primary use cases to perform a resource move is when you want to consolidate resources into the same resource group if they share the same lifecycle, or move resources to a different subscription due to cost, ownership, or Azure RBAC requirements.

When you perform a resource move, the source resource group and the target resource group are locked during the move operation. You can't add, update, or delete resources in the resource groups. A resource move operation doesn't change the location of the resources.

For more information about how to move resources across resource groups and subscriptions in the same tenant, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

### Before you move resources

Prior to a move operation, you must verify that the [resources in scope are supported](/azure/azure-resource-manager/management/move-support-resources), and assess their requirements and dependencies. For instance, when you move a peered virtual network, you have to disable virtual network peering first and reenable the peering after the move operation finishes. This disable and reenable dependency requires planning upfront to understand the affect on any existing workload that might be connected to your virtual networks.

### Post-move operation

When the resources are moved into a new resource group in the same subscription, any inherited Azure RBAC and policies from management group or subscription scope still apply. If you move to a resource group in a new subscription, where the subscription might be subject to other Azure RBAC and policy assignment, the same guidance applies. You have to validate the resource compliance and access controls.

## Scenarios

See the following scenarios about migrating and transitioning an existing environment into the Azure landing zone conceptual architecture.

- **Alignment scenarios**
  - [Single subscription with no management groups to the Azure landing zone conceptual architecture](./../landing-zone/align-scenarios.md)
  - [Single or few management groups to the Azure landing zone conceptual architecture](./../landing-zone/align-scenarios-1.md)
  - [Regional organization to the Azure landing zone conceptual architecture](./../landing-zone/align-scenarios-2.md)

- **Alignment approaches**
  - [A migration approach using duplicate landing zones management group with policies in “Audit only” mode](./../landing-zone/align-approaches-1.md)

> [!div class="nextstepaction"]
> [Review scenarios: Transitioning existing Azure environments to the Azure landing zone conceptual architecture](./../landing-zone/align-scenarios.md)
