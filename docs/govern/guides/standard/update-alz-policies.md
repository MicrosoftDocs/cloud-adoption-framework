---
title: 'Standard enterprise governance: Update ALZ deployed policies'
description: Use the guidance provided to migrate already deploy ALZ policies to Azure built-in policies.
author: Jfaurskov
ms.author: Janfaurs
ms.date: 09/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---



# Azure Landing Zone governance guide: Update ALZ deployed policies

This article describes how to migrate policies deployed as part of ALZ initial deployment to Azure built-in policies. Implementations done by ALZ accelerator and ALZ-Terraform are covered.

## Use case scenario  
You have deployed ALZ at a specific time and are now looking to update the existing policies/initiatives to leverage new or updated functionality with Azure built-in policies that have superseded the ALZ custom policies, the following scenarios are covered:
- Baseline ALZ policies/initiatives has been superseded by newer Azure Built-in policies/initiatives.

## For ALZ environments deployed through portal accelerator

### Detect updates
There are the following authoritative options for determining that one or more ALZ policies has been superseded by built-in Azure policies as follows:
- You periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note that one or more policies are indicated as being superseded
- You are leveraging the [AzGovViz tool](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) and note that one or more policies are marked as superseded

### Migration steps 
- Determine if ALZ policies in scope for migration are currently assigned at any scope in your Azure estate. 
- Determine if any policies to be migrated are part of an ALZ initiative which should be updated. 
- Determine if ALZ initiatives in scope for migration are currently assigned at any scope in your Azure estate. 

Depending on the result of the above investigations the following actions should be taken.

#### Policies not assigned and not part of ALZ initiative

If the policy to be migrated to builtin is not assigned in your Azure estate, and is not part of an existing ALZ initiative, do the following:

- Delete the ALZ policy definition from the ALZ intermediate root Management Group (for example `Contoso`).

#### Policies assigned and not part of ALZ initiative 
If the policy to be migrated to built-in is assigned to any scope in your Azure estate, and is not part of an existing initiative, do the following:
- Create new policy assignments at the same scopes leveraging the Azure built-in policies with matching settings as per the assignment of the previous ALZ custom policy definition
- Delete existing ALZ policy assignment at all scopes, where assigned
- Delete the ALZ policy definition from the ALZ intermediate root Management Group (for example `Contoso`).


#### Policies assigned through ALZ initiative
If the policy to be migrated to builtin is part of an ALZ initiative and is assigned through that at any scope in your Azure estate, do the following:
- Delete existing ALZ initiative assignments at all relevant scopes. Before deleting the assignments, record the assignment scope location and parameter values if different from ALZ default values
- Update the ALZ initiative definition with the appropriate policy references. See [here](https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization) for specific details. For consistency remember to update meta data information as well.
- Re-assign the updated ALZ initiative.

### Detect updates

There are the following authoritative options for determining that one or more ALZ policies has been superseded by built-in Azure policies as follows:
- You periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note that one or more policies are indicated as being superseded
- You follow [ALZ Terraform release guidance](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BUser-Guide%5D-Module-Releases) and note that one or more policies are indicated as being superseded
- You are leveraging the [AzGovViz tool](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) and note that one or more policies are marked as  superseded

### Migration steps

The ALZ Terraform module provides update guidance when deploying breaking changes. Follow the upgrade guidance available for your specific version [here](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki), look under Upgrade Guides in the sidebar.

