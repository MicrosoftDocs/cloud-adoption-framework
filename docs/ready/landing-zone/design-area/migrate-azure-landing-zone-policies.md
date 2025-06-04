---
title: Migrate Azure landing zone custom policies to Azure built-in policies
description: Learn how to use governance guidance to migrate previously deployed Azure landing zone policies to Azure built-in policies.
author: Jfaurskov
ms.author: janfaurs
ms.date: 01/17/2025
ms.topic: conceptual
ms.custom: internal, devx-track-bicep, devx-track-terraform, UpdateFrequency2
---

# Azure landing zone governance guide: Migrate Azure landing zone policies to Azure built-in policies

Over time, Azure landing zone custom policies and policy initiatives might be deprecated or superseded by Azure built-in policies. If so, they should be removed or migrated. This article describes how to migrate Azure landing zone custom policies and policy initiatives to Azure built-in policies.

The guidance in this article describes the manual, high-level steps to migrate your policies. It also provides references on how to process implementations managed through the Azure Verified Modules for Platform Landing Zones [Terraform](#update-steps-for-terraform-azure-verified-modules-for-platform-landing-zones-module-deployments) or [Bicep](#update-steps-for-alz-bicep-deployments) offerings.

The following infographic shows the update process flow.

:::image type="content" source="./media/azure-landing-zone-policy-to-built-in.png" lightbox="./media/azure-landing-zone-policy-to-built-in-large.png" alt-text="Diagram that shows the policy update process flow going from Azure landing zone custom policies to built-in policies.":::

## Manual update steps for Azure landing zone environments

This section describes the generic, high-level steps to migrate Azure landing zone custom policies and initiatives to Azure built-in policies.

### Detect updates for Azure landing zone policies

You can detect that one or more Azure landing zone policies are superseded by built-in Azure policies with the following options:

- Periodically review [Azure Enterprise Scale What's new wiki](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note any policies indicated as being superseded. See [an example of a superseded policy here](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new#policy-13).
- Use the [Azure Governance Visualizer](https://aka.ms/alz/azgovviz) script and note any policies marked as obsolete.

### Migration steps for Azure landing zone policies

You can migrate Azure landing zone environments with the following steps:

1. Determine if the Azure landing zone policies in scope for migration are currently assigned at any scope in your Azure estate. If you're using the [Azure Governance Visualizer](https://aka.ms/alz/azgovviz), you can determine policy scope by checking the **TenantSummary**.
1. Check if the Azure landing zone policies being migrated are part of a landing zone custom policy initiative that should be updated.
1. See if Azure landing zone custom policy initiatives in scope for migration are currently assigned at any scope in your Azure estate.

Depending on the results of your investigation, take the following actions.

#### Policies not assigned and not part of Azure landing zone custom policy initiative

If the policy being migrated isn't assigned in your Azure estate, and isn't part of an existing Azure landing zone custom policy initiative, you:

- Delete the Azure landing zone policy definition from the Azure landing zone intermediate root management group (for example, `Contoso`).

If an Azure landing zone custom policy initiative is fully superseded by a built-in policy initiative and isn't assigned in your Azure estate, you:

- Delete the Azure landing zone custom policy initiative from the Azure landing zone intermediate root management group (for example, `Contoso`).

#### Policies assigned and not part of Azure landing zone custom policy initiative

If the policy to be migrated is assigned to any scope in your Azure estate, and isn't part of an existing Azure landing zone custom policy initiative, do these steps:

1. Create new policy assignments at the same scopes using the Azure built-in policies with matching settings as per the assignment of the previous Azure landing zone custom policy definition.
1. Delete existing Azure landing zone policy assignment at all scopes, where assigned.
1. Delete the Azure landing zone policy definition from the Azure landing zone intermediate root management group (for example `Contoso`).

For detailed guidance on how to do the previous steps, see [Migrate single Azure landing zone custom policy](https://github.com/Azure/Enterprise-Scale/wiki/Migrate-ALZ-Policies-to-Built%E2%80%90in#migrate-single-alz-custom-policy-to-built-in-policy).

#### Policies assigned through Azure landing zone custom policy initiative

If the policy to be migrated is part of an Azure landing zone custom policy initiative and is assigned through it at any scope in your Azure estate, follow these steps:

1. Update the Azure landing zone custom policy initiative definition with the appropriate policy references. You can find the [updated initiatives here](https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization/policySetDefinitions) with a generic *contoso* scope for custom policies.
1. When you update the policy references, remember to change the *contoso* scope for policy definition IDs to your management group hierarchy pseudo root name. Also, update the metadata information on the Azure landing zone custom policy initiative.

For detailed guidance on how to do the previous steps, see [How to update child definitions in Azure landing zone custom initiatives](https://github.com/Azure/Enterprise-Scale/wiki/Migrate-ALZ-Policies-to-Built%E2%80%90in#how-to-update-child-definitions-in-alz-custom-initiatives).

If an Azure landing zone custom policy initiative is fully superseded by a built-in policy initiative, and assigned at any scope in your Azure estate, follow these steps:

1. Create new policy initiative assignments at the same scopes. Use the Azure built-in policy initiative with matching settings per the assignment of the previous Azure landing zone custom policy initiative.
1. Delete existing Azure landing zone policy initiative assignment at all scopes, where assigned.
1. Delete the Azure landing zone custom policy initiative from the Azure landing zone intermediate root management group (for example, `Contoso`).

## Update steps for Terraform Azure Verified Modules for Platform Landing Zones module deployments

If you use [the Terraform module](https://aka.ms/alz/tf/module), see the [update guide](https://aka.ms/alz/tf/update).

### Migration steps for Azure landing zone Terraform module

The Azure landing zone Terraform module provides update guidance when you deploy breaking changes. Follow the upgrade guidance for your specific version that's at the end of this article.

## Update steps for ALZ-Bicep deployments

If you're using the [ALZ-Bicep](https://github.com/Azure/alz-bicep) to manage your Azure landing zone deployment, this section references resources on how to migrate Azure landing zone custom policies and initiatives to Azure built-in policies.

### Detect updates for ALZ-Bicep policy changes

Use the methods described in [Detect updates for Azure landing zone policies](#detect-updates-for-azure-landing-zone-policies) to determine whether policies have changed in ALZ-Bicep. You'll also see changes to policies in [ALZ-Bicep releases](https://github.com/Azure/ALZ-Bicep/releases).

### Migration steps for ALZ-Bicep policies

ALZ-Bicep provides generic guidance for migrating policies from Azure landing zone custom policies to Azure built-in policies. For more information, see [How to migrate Azure landing zone custom policies to Azure built-in policies](https://github.com/Azure/ALZ-Bicep/wiki/PolicyDeepDive#how-to-migrate-alz-custom-policies-to-azure-built-in-policies).

## Next steps

Whether you use the Azure portal, Bicep, or Terraform to manage your Azure landing zone infrastructure, you need to manage policy changes over time. Use the flow in this article as a starting point to develop processes around policy management for your Azure landing zone implementation.
