---
title: 'Migrate ALZ custom policies to Azure built-in policies'
description: Use the guidance provided to migrate already deploy ALZ policies to Azure built-in policies.
author: Jfaurskov
ms.author: Janfaurs
ms.date: 11/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---



# Azure Landing Zone governance guide: Migrate Azure Landing Zone policies to Azure Built-in policies

Over time Azure Landing Zone (ALZ) custom policies and policy initiatives, may become deprecated or superseded by Azure built-in policies, and so should be removed or migrated. This article describes how to migrate ALZ custom policies and policy initiatives to Azure built-in policies. The guidance provided in this document describes manual high-level steps for performing the migration, as well as references on how to handle the process for implementations managed through the [ALZ Terraform module](#update-steps-for-azure-landing-zone-terraform-module-deployments) or [ALZ Bicep](#update-steps-for-azure-landing-zone-bicep-deployments).

The following infographic provides a frame of reference for the update process flow.

:::image type="content" source="../../_images/govern/design/alz-policy_to_builtin_update.jpg" lightbox="../../_images/govern/design/alz-policy_to_builtin_update.jpg" alt-text="Diagram showing policy update process flow going from ALZ custom policies to built-in policies.":::


## Manual update steps for Azure Landing Zone environments

This section describes the generic high-level steps you would need to undertake to migrate ALZ custom policies and initiatives to Azure built-in policies. 

### Detect updates

There are the following authoritative options for determining that one or more ALZ policies has been superseded by built-in Azure policies as follows:
- You periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note that one or more policies are indicated as being superseded. An example can be seen [here](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new#policy-13)
- You use the [Azure Governance Visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) and note that one or more policies are marked as obsolete. 

### Migration steps

- Determine if the ALZ policies in scope for migration are currently assigned at any scope in your Azure estate. If using the [Azure Governance Visualizer](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting), this can be determined by checking the **TenantSummary**.
- Determine if any ALZ policies to be migrated are part of an ALZ custom policy initiative which should be updated.
- Determine if ALZ custom policy initiatives in scope for migration are currently assigned at any scope in your Azure estate. 

Depending on the result of the above investigations the following actions should be taken.

#### Policies not assigned and not part of Azure Landing Zone custom policy initiative

If the policy to be migrated to built-in is not assigned in your Azure estate, and is not part of an existing ALZ custom policy initiative, do the following:

- Delete the ALZ policy definition from the ALZ intermediate root Management Group (for example `Contoso`)

If an ALZ custom policy initiative is fully superseded by a built-in policy initiative and is not assigned in your Azure estate, do the following:

- Delete the ALZ custom policy initiative from the ALZ intermediate root Management Group (for example `Contoso`)

#### Policies assigned and not part of Azure Landing Zone custom policy initiative

If the policy to be migrated to built-in is assigned to any scope in your Azure estate, and is not part of an existing ALZ custom policy initiative, do the following:
- Create new policy assignments at the same scopes leveraging the Azure built-in policies with matching settings as per the assignment of the previous ALZ custom policy definition
- Delete existing ALZ policy assignment at all scopes, where assigned
- Delete the ALZ policy definition from the ALZ intermediate root Management Group (for example `Contoso`).

For detailed guidance on how to achieve the above, please refer to [this article](https://github.com/Azure/Enterprise-Scale/wiki/migrate-alz-policies-to-builtin#migrate-single-alz-custom-policy-to-built-in-policy). 

#### Policies assigned through Azure Landing Zone custom policy initiative

If the policy to be migrated to built-in is part of an ALZ custom policy initiative and is assigned through that at any scope in your Azure estate, do the following:
- Update the ALZ custom policy initiative definition with the appropriate policy references. Updated initiatives are available [here](https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization/policySetDefinitions) with a generic *contoso* scope for custom policies. When doing this, remember to change the *contoso* scope for policy definition ids to your management group hierarchy pseudo root name. Also remember to update the metadata information on the ALZ custom policy initiative

For detailed guidance on how to achieve the above, please refer to [this article](https://github.com/Azure/Enterprise-Scale/wiki/migrate-alz-policies-to-builtin#how-to-update-child-definitions-in-alz-custom-initiatives). 

If an ALZ custom policy initiative is fully superseded by a built-in policy initiative, and the ALZ custom policy initiative is assigned at any scope in your Azure estate, do the following:
- Create new policy initiative assignments at the same scopes leveraging the Azure built-in policy initiative with matching settings as per the assignment of the previous ALZ custom policy initiative
- Delete existing ALZ policy initiative assignment at all scopes, where assigned
- Delete the ALZ custom policy initiative from the ALZ intermediate root Management Group (for example `Contoso`)

## Update steps for Azure Landing Zone Terraform module deployments

If you are using the [ALZ Terraform module](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale) to manage you ALZ deployment, this section references resources on how to migrate ALZ custom policies and initiatives to Azure built-in policies.

### Detect updates

In addition to the methods described in [Detect updates](#detect-updates) on how to determine whether policies has changed, in the Terraform Module, you will also be able to see changes to policies in the [ALZ Terraform releases page](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases). An example can be seen [here](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases/tag/v2.3.0).

### Migration steps

The ALZ Terraform module provides update guidance when deploying breaking changes. Follow the upgrade guidance available for your specific version [here](https://aka.ms/alz/tf/upgrade) shown at the bottom of the page.


## Update steps for Azure Landing Zone Bicep deployments

If you are using the [ALZ Bicep](https://github.com/Azure/alz-bicep) to manage you ALZ deployment, this section references resources on how to migrate ALZ custom policies and initiatives to Azure built-in policies.

### Detect updates

In addition to the methods described in [Detect updates](#detect-updates) on how to determine whether policies has changed, in ALZ Bicep, you will also be able to see changes to policies in the [ALZ-Bicep releases](https://github.com/Azure/ALZ-Bicep/releases). 

### Migration steps

ALZ Bicep provides generic guidance for migrating policies from ALZ custom policies to Azure built-in policies. For more details refer to [How to migrate ALZ custom policies to Azure built-in policies](https://github.com/Azure/ALZ-Bicep/wiki/PolicyDeepDive#how-to-migrate-alz-custom-policies-to-azure-built-in-policies).

## Next steps

Regardless of whether you use Azure Portal, Bicep or Terraform to manage your ALZ infrastructure, policies will change over time and will need to be managed. Use the flow described in this article as a starting point to develop processes around policy management for your specific ALZ implementation. 


