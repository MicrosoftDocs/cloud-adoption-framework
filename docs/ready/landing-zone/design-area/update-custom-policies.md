---
title: Update Azure landing zone custom policies
description: Use this guidance to update already-deployed Azure landing zone custom policies and policy initiatives.
author: DaFitRobsta
ms.author: Rolightn
ms.date: 11/15/2022
ms.topic: conceptual
ms.custom: internal, devx-track-bicep, devx-track-terraform, UpdateFrequency2
---

# Update Azure landing zone custom policies

Over time, Azure landing zone custom policies and policy initiatives update to newer versions that you can incorporate into your Azure environment. This article describes how to update your Azure landing zone custom policies and policy initiatives when newer versions release.

The article describes high-level manual update steps, and provides references on handling updates for [Terraform](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale) and [Bicep](https://aka.ms/alz/bicep) modular implementations. To migrate Azure landing zone custom policies to Azure built-in policies with Bicep, see [Migrate Azure landing zone policies to Azure built-in policies](./migrate-azure-landing-zone-policies.md).

The following infographic provides a decision tree and process flow for Azure landing zone custom policy updates:
:::image type="content" source="./media/azure-landing-zone-policy-to-newer-version.png" lightbox="./media/azure-landing-zone-policy-to-newer-version-large.png" alt-text="Diagram that shows a decision tree for the Azure landing zone custom policy update process.":::
> [!CAUTION]
> When you delete existing policy assignments, your environment isn't protected during the time it takes to reassign policies. After you assign updated policies, review your policy compliance section for any unhealthy resources and remediate them.

## Update steps for Azure landing zone environments

This section describes the general high-level steps to update your Azure landing zone custom policies and initiatives to newer versions.

### Detect updates

Use the following authoritative options to determine that one or more of your Azure landing zone custom policies are outdated:

- Periodically review [`What's New`](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new), and note that one or more policies are updated, such as [this example](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new#policy-11).
- Use the [Azure Governance Visualizer](https://aka.ms/alz/azgovviz) and note that one or more policies are marked as outdated.

### Apply updates

To determine whether to apply updated custom policies to your Azure landing zone deployment:

1. Determine whether your Azure estate currently assigns any outdated custom policies at any scope. If you use the [Azure Governance Visualizer](https://aka.ms/alz/azgovviz), you can see your currently assigned policies by checking the **TenantSummary**.
1. Determine whether any of the outdated custom policies are part of an Azure landing zone custom policy initiative.
1. Determine whether your Azure estate currently assigns any of the outdated custom policy initiatives at any scope.

Depending on the result of the above investigations, take the following actions:

#### Policies not assigned

- If the outdated policy isn't assigned in your Azure estate, and isn't part of an existing custom policy initiative, replace the outdated policy definition with the updated policy definition at the Azure landing zone intermediate root management group, such as `Contoso`.

- If a custom policy initiative is updated, but isn't assigned in your Azure estate, replace the outdated custom policy initiative with the updated custom policy initiative at the Azure landing zone intermediate root management group, for example `Contoso`.

#### Policies with unchanged parameters and not part of a custom policy initiative

If the outdated Azure landing zone policy is assigned to any scope in your Azure estate, isn't part of an existing Azure landing zone custom policy initiative, and the parameter names and number haven't changed:

- Replace the existing custom policy definition contents with the updated custom policy definition contents at the Azure landing zone intermediate root management group, for example `Contoso`. For detailed guidance, see the [Azure landing zones user guide](https://aka.ms/alz/custompolicyupdate).

#### Policies with changed parameters and not part of a custom policy initiative

If the outdated Azure landing zone policy is assigned to any scope in your Azure estate, isn't part of an existing Azure landing zone custom policy initiative, and the parameter names and number have changed:

1. Capture all outdated policy assignments, where they're assigned, and their parameter values.
1. Take one of these actions:
   - If the policy assignment includes more than one policy definition, update the policy assignment by removing the outdated policy at all scopes where assigned.
   - If the policy assignment contains only the outdated policy, delete the existing policy assignment at all scopes where assigned.
1. Delete the outdated policy from the Azure landing zone intermediate root management group, for example `Contoso`.
1. Import the updated policy to the Azure landing zone intermediate root management group.
1. Update the existing policy assignments or create new policy assignments by including the updated policy at the prerecorded scopes.
1. After you reassign the updated custom policy, review the policy compliance section to validate that resources are in a healthy state.

For detailed guidance, see the [Azure landing zones user guide](https://aka.ms/alz/custompolicyupdate).

#### Policies with unchanged parameters assigned through a custom policy initiative

If the outdated Azure landing zone policy is part of an existing Azure landing zone custom policy initiative, is assigned to any scope in your Azure estate, and has unchanged parameter names and numbers:

- Replace the existing custom policy definition contents with the updated custom policy definition contents. No further changes need to be made to the custom policy initiative or assignments, because the parameter number and names are unchanged. For detailed guidance, see the [Azure landing zones user guide](https://aka.ms/alz/custompolicyupdate).

#### Policies with changed parameters assigned through a custom policy initiative

If the outdated policy is part of an existing custom policy initiative, is assigned to any scope in your Azure estate, and has changed parameter names and numbers:

1. Capture all policy assignments, where they're assigned, and their parameter values for the custom policy initiative.
1. Delete the existing policy assignments at all scopes where assigned.
1. Delete the outdated policy from the custom policy initiative.

   You can't delete *initiative parameter(s)* from the custom policy initiative. Consider reusing these parameters.

1. Delete the outdated policy from the Azure landing zone intermediate root management group, for example `Contoso`.
1. Import the updated policy to the Azure landing zone intermediate root management group.
1. Add the updated policy to the custom policy initiative.
   - If applicable, reuse the previous initiative parameters.
   - If applicable, add other initiative parameters by following existing naming patterns that the custom policy initiative defines.
1. Reassign the updated custom policy initiative.
1. After you reassign the updated custom policy initiative, review the policy compliance section to validate that resources are in a healthy state.

For detailed guidance, see the [Azure landing zones user guide](https://aka.ms/alz/custompolicyupdate).

#### Updated assigned custom policy initiative

If an Azure landing zone custom policy initiative is completely updated, and is assigned at any scope in your Azure estate:

1. Capture all policy assignments, where they're assigned, and their parameter values for the Azure landing zone custom policy initiative.
1. Delete the existing policy assignments at all scopes where assigned.
1. Delete the outdated custom policy initiative from the intermediate root management group, for example `Contoso`. Before deleting, record all custom policy definition names and IDs, assuming all custom policy definitions are up-to-date.
1. Import the updated custom policy initiative definition with the appropriate policy references.

   You can get updated initiatives at [`policySetDefinitions`](https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization/policySetDefinitions), with a generic `contoso` scope for custom policies. Remember to change the `contoso` scope to your management group hierarchy pseudo root name for each policy definition ID.
1. Reassign the updated custom policy initiative.
1. After you reassign the updated custom policy initiative, review the policy compliance section to validate that resources are in a healthy state.

For detailed guidance, see the [Azure landing zones user guide](https://aka.ms/alz/custompolicyupdate).

## Update steps for Terraform module deployments

If you use the [Azure landing zones Terraform module](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale) to manage your Azure landing zone deployment, this section provides resources for updating Azure landing zone custom policies and initiatives.

### Detect updates with Terraform

Use the methods in [Detect updates](#detect-updates) to determine whether policies have changed. In the Terraform module, you can also see changes to policies on the [releases](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases) page. For an example, see [policy updates for v2.3.0](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases/tag/v2.3.0).

### Update with Terraform

The Azure landing zone Terraform module provides update guidance for deploying breaking changes. Follow the upgrade guidance for your version at [upgrade guides](https://aka.ms/alz/tf/upgrade).

## Update steps for Bicep module deployments

If you use the [ALZ-Bicep modules](https://github.com/Azure/alz-bicep) to manage your Azure landing zone deployment, this section provides resources for updating Azure landing zone custom policies and initiatives.

### Detect updates with Bicep

Use the methods in [Detect updates](#detect-updates) to determine whether policies have changed. You can also see changes to ALZ-Bicep policies in [ALZ-Bicep releases](https://github.com/Azure/ALZ-Bicep/releases).

### Update with Bicep

ALZ-Bicep provides generic guidance for updating Azure landing zone custom policies to newer policies. For more information, see [How to migrate Azure landing zone custom policies to Azure built-in policies](https://github.com/Azure/ALZ-Bicep/wiki/PolicyDeepDive#how-to-migrate-alz-custom-policies-to-azure-built-in-policies).

## Next steps

Regardless of whether you use the Azure portal, Bicep, or Terraform to manage your Azure landing zone infrastructure, you need to manage policy changes over time. Use the flow in this article as a starting point to develop processes around policy management for your Azure landing zone implementation.