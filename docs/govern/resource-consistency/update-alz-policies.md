---
title: Migrate Azure Landing Zone custom policies to Azure built-in policies
description: Learn how to use governance guidance to migrate previously deployed Azure Landing Zone policies to Azure built-in policies.
author: Jfaurskov
ms.author: Janfaurs
ms.date: 12/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Azure Landing Zone governance guide: Migrate Azure Landing Zone policies to Azure built-in policies

Over time, Azure Landing Zone custom policies and policy initiatives might be deprecated or superseded by Azure built-in policies. If so, they should be removed or migrated. This article describes how to migrate Azure Landing Zone custom policies and policy initiatives to Azure built-in policies.

The guidance in this document describes the manual, high-level steps for your migration. It also provides references on how to process implementations managed through the [Azure Landing Zone Terraform module](#update-steps-for-azure-landing-zone-terraform-module-deployments) or [Azure Landing Zone Bicep](#update-steps-for-azure-landing-zone-bicep-deployments).

The following infographic shows the update process flow.

:::image type="content" source="../../_images/govern/design/alz-policy_to_builtin_update.jpg" lightbox="../../_images/govern/design/alz-policy_to_builtin_update.jpg" alt-text="Diagram that shows the policy update process flow going from Azure Landing Zone custom policies to built-in policies.":::

## Manual update steps for Azure Landing Zone environments

This section describes the generic, high-level steps to migrate Azure Landing Zone custom policies and initiatives to Azure built-in policies.

### Detect updates for Azure Landing Zone policies

You can detect that one or more Azure Landing Zone policies are superseded by built-in Azure policies with the following options:

- Periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note any policies indicated as being superseded. See an example [here](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new#policy-13).
- Use the [Azure Governance Visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) script and note any policies marked as obsolete.

### Migration steps for Azure Landing Zone policies

You can migrate Azure Landing Zone environments with the following steps:

- Determine if the Azure Landing Zone policies in scope for migration are currently assigned at any scope in your Azure estate. If you're using the [Azure Governance Visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting), you can determine policy scope by checking the **TenantSummary**.
- Check if the Azure Landing Zone policies being migrated are part of a landing zone custom policy initiative that should be updated.
- See if Azure Landing Zone custom policy initiatives in scope for migration are currently assigned at any scope in your Azure estate.

Depending on the results of your investigation, take the following actions.

#### Policies not assigned and not part of Azure Landing Zone custom policy initiative

If the policy being migrated isn't assigned in your Azure estate, and isn't part of an existing Azure Landing Zone custom policy initiative, you:

- Delete the Azure Landing Zone policy definition from the Azure Landing Zone intermediate root Management Group (for example, `Contoso`).

If an Azure Landing Zone custom policy initiative is fully superseded by a built-in policy initiative and isn't assigned in your Azure estate, you:

- Delete the Azure Landing Zone custom policy initiative from the Azure Landing Zone intermediate root Management Group (for example, `Contoso`).

#### Policies assigned and not part of Azure Landing Zone custom policy initiative

If the policy to be migrated is assigned to any scope in your Azure estate, and isn't part of an existing Azure Landing Zone custom policy initiative, do these steps:

- Create new policy assignments at the same scopes using the Azure built-in policies with matching settings as per the assignment of the previous Azure Landing Zone custom policy definition.
- Delete existing Azure Landing Zone policy assignment at all scopes, where assigned.
- Delete the Azure Landing Zone policy definition from the Azure Landing Zone intermediate root Management Group (for example `Contoso`).

For detailed guidance on how to do the previous steps, see [Migrate single Azure Landing Zone custom policy](https://github.com/Azure/Enterprise-Scale/wiki/migrate-alz-policies-to-builtin#migrate-single-alz-custom-policy-to-built-in-policy).

#### Policies assigned through Azure Landing Zone custom policy initiative

If the policy to be migrated is part of an Azure Landing Zone custom policy initiative and is assigned through it at any scope in your Azure estate, do these steps:

- Update the Azure Landing Zone custom policy initiative definition with the appropriate policy references. You can find the updated initiatives [here](https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization/policySetDefinitions) with a generic *contoso* scope for custom policies.
- When you update the policy references, remember to change the *contoso* scope for policy definition IDs to your management group hierarchy pseudo root name. Also, remember to update the metadata information on the Azure Landing Zone custom policy initiative.

For detailed guidance on how to do the previous steps, see [How to update child definitions in Azure Landing Zone custom initiatives](https://github.com/Azure/Enterprise-Scale/wiki/migrate-alz-policies-to-builtin#how-to-update-child-definitions-in-alz-custom-initiatives).

If an Azure Landing Zone custom policy initiative is fully superseded by a built-in policy initiative, and assigned at any scope in your Azure estate, do these steps:

- Create new policy initiative assignments at the same scopes. Use the Azure built-in policy initiative with matching settings per the assignment of the previous Azure Landing Zone custom policy initiative.
- Delete existing Azure Landing Zone policy initiative assignment at all scopes, where assigned.
- Delete the Azure Landing Zone custom policy initiative from the Azure Landing Zone intermediate root Management Group (for example `Contoso`).

## Update steps for Azure Landing Zone Terraform module deployments

If you're using the [Azure Landing Zone Terraform module](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale) to manage your Azure Landing Zone deployment, this section references resources on how to migrate Azure Landing Zone custom policies and initiatives to Azure built-in policies.

### Detect updates and Terraform module changes

Use the methods described in [Detect updates](#detect-updates) to determine whether policies have changed. In the Terraform module, you'll see changes to policies in the [Azure Landing Zone Terraform releases page](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases). See an example [here](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases/tag/v2.3.0).

### Migration steps for Azure Landing Zone Terraform module

The Azure Landing Zone Terraform module provides update guidance when deploying breaking changes. Follow the upgrade guidance available for your specific version [here](https://aka.ms/alz/tf/upgrade) at the bottom of the page.

## Update steps for Azure Landing Zone Bicep deployments

If you're using the [Azure Landing Zone Bicep](https://github.com/Azure/alz-bicep) to manage your Azure Landing Zone deployment, this section references resources on how to migrate Azure Landing Zone custom policies and initiatives to Azure built-in policies.

### Detect updates and Azure Landing Zone Bicep policy changes

Use the methods described in [Detect updates](#detect-updates) to determine whether policies have changed. In Azure Landing Zone Bicep, you'll also see changes to policies in the [Azure Landing Zone-Bicep releases](<https://github.com/Azure/Azure> Landing Zone-Bicep/releases).

### Migration steps for Azure Landing Zone Bicep policies

Azure Landing Zone Bicep provides generic guidance for migrating policies from Azure Landing Zone custom policies to Azure built-in policies. For more information, see [How to migrate Azure Landing Zone custom policies to Azure built-in policies](<https://github.com/Azure/Azure> Landing Zone-Bicep/wiki/PolicyDeepDive#how-to-migrate-alz-custom-policies-to-azure-built-in-policies).

## Next steps

Regardless of whether you use Azure portal, Bicep, or Terraform to manage your Azure Landing Zone infrastructure, policies change over time. You'll need to manage them. Use the flow described in this article as a starting point to develop processes around policy management for your specific Azure Landing Zone implementation.
