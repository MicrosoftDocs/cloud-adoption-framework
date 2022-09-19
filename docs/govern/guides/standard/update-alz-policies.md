# Azure Landing Zone governance guide: Update ALZ deployed policies

This article describes how to migrate policies deployed as part of ALZ initial deployment to Azure built-in policies. --Implementations done by ALZ accelerator, ALZ-Bicep or ALZ-Terraform are all covered.-- fixme

## Use case scenario  
You have deployed ALZ at a specific time and are now looking to update the existing policies/initiatives to leverage new or updated functionality with Azure built-in policies, the following scenarios are covered:
1.	Baseline ALZ policies/initiatives has been superseded by newer Azure Built-in policies/initiatives.


fixme azOps disclaimer

fixme to discuss guidance on Bicep with Jack

# For ALZ environments deployed through portal accelerator
## Detect updates
There are the following authoritative options for determining that one or more ALZ policies has been superseded by built-in Azure policies as follows:
- You periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note that one or more policies are indicated as being superseded
- You are leveraging the [AzGovViz tool](https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting) and note that one or more policies are marked as  superseded

## Manual migration steps 
1. Determine if policies or initiatives in scope for migration are currently assigned at any scope in your Azure estate. Also determine if any policies to be migrated are part of a custom initiative which should be updated. Depending on the result of these investigations the following actions should be taken.

### Policies not assigned and not part of ALZ initiative
If the policy to be migrated to builtin is not assigned in your Azure estate, and is not part of an existing initiative, do the following:
1. Delete the ALZ policy definition from ALZ root.

### Policies assigned and not part of ALZ initiative 
If the policy to be migrated to builtin is assigned at any scope in your Azure estate, and is not part of an existing initiative, do the following:
- Create new policy assignments at the relevant scopes leveraging Azure built-in policies/initiatives with similar settings as the ALZ policy/initiative assignments
- Delete existing ALZ policy assignments at all relevant scopes

### Policies assigned through ALZ initiative
If the policy to be migrated to builtin is part of an ALZ initiative and is assigned at any scope in your Azure estate, do the following:
- Delete existing ALZ initiative assignments at all relevant scopes
- Update the ALZ initiative definition with the appropriate policy references. See [here](https://github.com/Azure/Enterprise-Scale/tree/main/src/resources/Microsoft.Authorization) for specific details. For consistency remember to update meta data information as well.
- Re-assign the updated initiative.

# For ALZ environments deployed through ALZ-Bicep
## Detect updates
There are the following authoritative options for determining that one or more ALZ policies has been superseded by built-in Azure policies as follows:
- You periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note that one or more policies are indicated as being superseded
- You follow [ALZ Bicep release guidance](https://github.com/Azure/ALZ-Bicep/releases) and note that one or more policies are indicated as being superseded
- You are leveraging the [AzGovViz tool](https://github.com/JulianHayward/
Azure-MG-Sub-Governance-Reporting) and note that one or more policies are marked as  superseded

## Migration steps 
fixme to be discussed with Jack

# For ALZ environments deployed through ALZ-Terraform
## Detect updates
There are the following authoritative options for determining that one or more ALZ policies has been superseded by built-in Azure policies as follows:
- You periodically review [What's new](https://github.com/Azure/Enterprise-Scale/wiki/Whats-new) and note that one or more policies are indicated as being superseded
- You follow [ALZ Terraform release guidance](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/releases) and note that one or more policies are indicated as being superseded
- You are leveraging the [AzGovViz tool](https://github.com/JulianHayward/
Azure-MG-Sub-Governance-Reporting) and note that one or more policies are marked as  superseded

## Migration steps
The ALZ Terraform module provides update guidance when deploying breaking changes. Follow the update guidance available for your specific version [here](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki).

