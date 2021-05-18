---
title: Common Azure Policy examples
description: Use the Cloud Adoption Framework for Azure to ensure compliance to governance policy requirements by creating policies with PowerShell cmdlets.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Common Azure Policy examples

[Azure Policy](/azure/governance/policy/overview) can help you apply governance to your cloud resources. This service can help you create guardrails that ensure company-wide compliance to governance policy requirements. To create policies, use either the Azure portal or PowerShell cmdlets. This article provides PowerShell cmdlet examples.

> [!NOTE]
> With Azure Policy, enforcement policies (`DeployIfNotExists`) aren't automatically deployed to existing VMs. Remediation is required to keep VMs in compliance. For more information, see [Remediate noncompliant resources with Azure Policy](/azure/governance/policy/how-to/remediate-resources).

## Common policy examples

The following sections describe some commonly used policies.

### Restrict resource regions

Regulatory and policy compliance often depends on control of the physical location where resources are deployed. You can use a built-in policy to allow users to create resources only in certain allowed Azure regions.

To find this policy in the portal, search for "location" on the policy definition page. Or run this cmdlet to find the policy:

```powershell
Get-AzPolicyDefinition | Where-Object { ($_.Properties.policyType -eq 'BuiltIn') `
  -and ($_.Properties.displayName -like '*location*') }
```

The following script shows how to assign the policy. Change the `$SubscriptionID` value to point to the subscription that you want to assign the policy to. Before you run the script, use the [`Connect-AzAccount`](/powershell/module/az.accounts/connect-azaccount) cmdlet to sign in.

```powershell

# Specify the value for $SubscriptionID.

$SubscriptionID = <subscription ID>
$scope = "/subscriptions/$SubscriptionID"

# Replace the -Name GUID with the policy GUID you want to assign.

$AllowedLocationPolicy = Get-AzPolicyDefinition -Name "e56962a6-4747-49cd-b67b-bf8b01975c4c"

# Replace the locations with the ones you want to specify.

$policyParam = '{ "listOfAllowedLocations":{"value":["eastus","westus"]}}'
New-AzPolicyAssignment -Name "Allowed Location" -DisplayName "Allowed locations for resource creation" -Scope $scope -PolicyDefinition $AllowedLocationPolicy -Location eastus -PolicyParameter $policyParam
```

You can also use this script to apply the other policies that are discussed in this article. Just replace the GUID in the line that sets `$AllowedLocationPolicy` with the GUID of the policy that you want to apply.

### Block certain resource types

Another common built-in policy that's used to control costs can also be used to block certain resource types.

To find this policy in the portal, search for "allowed resource types" on the policy definition page. Or run this cmdlet to find the policy:

```powershell
Get-AzPolicyDefinition | Where-Object { ($_.Properties.policyType -eq "BuiltIn") -and ($_.Properties.displayName -like "*allowed resource types") }
```

After you identify the policy that you want to use, you can modify the PowerShell sample in the [Restrict resource regions](#restrict-resource-regions) section to assign the policy.

### Restrict VM size

Azure offers a wide range of VM sizes to support various workloads. To control your budget, you could create a policy that allows only a subset of VM sizes in your subscriptions.

### Deploy antimalware

You can use this policy to deploy the Microsoft Antimalware Extension with a default configuration to VMs that aren't protected by antimalware.

The policy GUID is `2835b622-407b-4114-9198-6f7064cbe0dc`.

The following script shows how to assign the policy. To use the script, change the `$SubscriptionID` value to point to the subscription that you want to assign the policy to. Before you run the script, use the [`Connect-AzAccount`](/powershell/module/az.accounts/connect-azaccount) cmdlet to sign in.

```powershell

# Specify the value for $SubscriptionID.

$subscriptionID = <subscription ID>
$scope = "/subscriptions/$subscriptionID"

$antimalwarePolicy = Get-AzPolicyDefinition -Name "2835b622-407b-4114-9198-6f7064cbe0dc"

# Replace location "eastus" with the value that you want to use.

New-AzPolicyAssignment -Name "Deploy Antimalware" -DisplayName "Deploy default Microsoft IaaSAntimalware extension for Windows Server" -Scope $scope -PolicyDefinition $antimalwarePolicy -Location eastus -AssignIdentity

```

## Next steps

Learn about other server-management tools and services that are available.

> [!div class="nextstepaction"]
> [Azure server management tools and services](./tools-services.md)
