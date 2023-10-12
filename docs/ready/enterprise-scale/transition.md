---
title: Transition existing Azure environments to the Azure landing zone conceptual architecture
description: Learn how to onboard existing environments and move resources to the Azure landing zone conceptual architecture.
author: JefferyMitchell
ms.author: martinek
ms.date: 10/22/2021
ms.topic: conceptual
ms.custom: think-tank, csu
---

<!-- docutune:casing resourceType resourceTypes resourceId resourceIds -->

# Transition an existing Azure environment to the Azure landing zone conceptual architecture

Most organizations might have an existing Azure footprint, one or more subscriptions, and potentially an existing management group structure. Depending on their business requirements and scenarios, they might have Azure resources deployed, such as hybrid connectivity via services such as Azure VPN Gateway or Azure ExpressRoute.

This article provides recommendations to help your organization navigate changes based on your existing Azure environment that's transitioning into the Azure landing zone conceptual architecture. This article also describes considerations for moving resources in Azure, for example moving a subscription from one existing management group to another management group. Consider these recommendations to help you evaluate and plan the transition of your existing Azure environment.

## Move resources in Azure

You can move some resources in Azure post creation. There are different approaches that are subject to a user's Azure role-based access control (RBAC) permissions at and across scopes. The following table outlines which resources you can move, at which scope, and the pros and cons associated with each resource.

| Scope | Destination | Pro | Con |
| ----- | ----------- | ---- | ---- |
| Resources in resource groups. | You can move to a new resource group in the same or different subscription. | You can modify the resource composition in a resource group after deployment. | Not supported by all resourceTypes. <br><br> Some resourceTypes have specific limitations or requirements. <br><br> resourceIds are updated and it affects existing monitoring, alerts, and control plane operations. <br><br> Resource groups are locked during the move period. <br><br> Requires an assessment of policies and RBAC pre-move and post-move operation. |
| Subscriptions in a tenant. | You can move to different management groups. | No effect on existing resources within the subscription because resourceId values don't change. | Requires an assessment of policies and RBAC pre-move and post-move operation. |

To understand which move strategy you should use, consider the following examples.

## Move subscriptions

Typically, you move subscriptions to organize them into management groups or to transfer subscriptions to a new Microsoft Entra ID tenant. Moving a subscription to a new tenant is mainly for [transferring billing ownership](/azure/cost-management-billing/manage/billing-subscription-transfer). For more information about how to move subscriptions across management groups in the same tenant, see [Moving management groups and subscriptions](/azure/governance/management-groups/manage#moving-management-groups-and-subscriptions).

### Azure RBAC requirements

To assess a subscription prior to a move, it's important that the user has the appropriate Azure RBAC. The user might be an owner on the subscription (direct role assignment) and have write permission on the target management group. Built-in roles that support write permission on the target management group are the owner role, the contributor role, and the management group contributor role.

If the user has an inherited owner role permission on the subscription from an existing management group, you can only move the subscription to the management group in which the user is assigned the owner role.

### Policies

Existing subscriptions might be subject to Azure policies that are directly assigned or assigned at the management group where they're currently located. It's important to assess current policies and the policies that might exist in the new management group or the management group hierarchy.

You can use Azure Resource Graph to perform an inventory of existing resources and compare their configuration with the policies that exist at the destination.

After you move subscriptions to a management group with existing Azure RBAC and policies in place, consider the following factors:

- For any Azure RBAC that's inherited to the moved subscriptions, the user tokens in the management group cache might take up to 30 minutes to refresh. To expedite this process, you can refresh the token by signing out and in, or request a new token.

- A policy in which the assignment scope includes the moved subscriptions performs an audit only on the existing resources. An existing resource in the subscription that's subject to a:

  - `DeployIfNotExists` policy effect appears as noncompliant and isn't automatically remediated. A user must manually perform the remediation.
  
  - `Deny` policy effect appears as noncompliant and isn't rejected. A user must manually mitigate this result as appropriate.
  
  - `Append` and `Modify` policy effect appears as noncompliant and requires a user to mitigate.
  
  - `Audit` and `AuditIfNotExist` policy effect appears as noncompliant and requires a user to mitigate.
  
- All new writes to resources in the moved subscription are subject to the assigned policies in real time like normal.

## Move resources

Typically, you move resources when you want to consolidate resources into the same resource group if they share the same lifecycle. Or if you want to move resources to a different subscription due to cost, ownership, or Azure RBAC requirements.

When you move resources, the source resource group and the target resource group are locked during the move operation. You can't add, update, or delete resources in the resource groups. A resource move operation doesn't change the location of the resources.

For more information about how to move resources across resource groups and subscriptions in the same tenant, see [Move resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

### Before you move resources

Prior to a move operation, you must verify that the [resources are supported](/azure/azure-resource-manager/management/move-support-resources), and assess their requirements and dependencies. For example, when you move a peered virtual network, you have to disable virtual network peering first, and re-enable peering after the move operation finishes. Plan in advance for the disable and re-enable dependency so you understand the effect on existing workloads that might be connected to your virtual networks.

### After you move resources

When you move the resources into a new resource group in the same subscription, any inherited Azure RBAC and policies from the management group or subscription still apply. This also applies if you move to a resource group in a new subscription where the subscription might be subject to other Azure RBAC and policy assignment. You have to validate the resource compliance and access controls.

## Scenarios

The following scenarios describe how to migrate and transition an existing environment into the Azure landing zone conceptual architecture.

- **Alignment scenarios**
  - [Transition a single subscription with no management groups to the Azure landing zone conceptual architecture](./../landing-zone/align-scenario-single-subscription.md)
  - [Transition management groups to the Azure landing zone conceptual architecture](./../landing-zone/align-scenario-multiple-management-groups.md)
  - [Transition a regional organization to the Azure landing zone conceptual architecture](./../landing-zone/align-scenario-regional-org.md)

- **Alignment approaches**
  - [Migrate an environment by duplicating a landing zone management group](./../landing-zone/align-approach-duplicate-brownfield-audit-only.md)

> [!div class="nextstepaction"]
> [Journey toward the target architecture](./../landing-zone/landing-zone-journey.md)
