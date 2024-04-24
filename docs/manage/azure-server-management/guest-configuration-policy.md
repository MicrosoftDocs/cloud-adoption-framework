---
title: Azure Policy guest configuration extension
description: Use the Cloud Adoption Framework for Azure to learn how to use the Azure Policy guest configuration extension to audit the configuration settings in an Azure VM.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/06/2023
ms.topic: conceptual
ms.custom: internal, devx-track-azurepowershell
---

# Azure Policy guest configuration extension

You can use the [Azure Policy guest configuration extension](/azure/governance/policy/concepts/guest-configuration) to audit the configuration settings in a virtual machine. Guest configuration supports Azure VMs natively and non-Azure physical and virtual servers through [Azure Arc-enabled servers](/azure/azure-arc/servers/overview).

To find the list of guest configuration policies, search for *guest configuration* on the Azure Policy portal page, or run this cmdlet in a PowerShell window to find the list:

```powershell
Get-AzPolicySetDefinition | Where-Object {$_.Properties.metadata.category -eq "Guest Configuration"}
```

> [!NOTE]
> Guest configuration functionality is regularly updated to support additional policy sets. Check for new supported policies periodically and evaluate whether they'll be useful.

## Deployment

Use the following example PowerShell script to deploy these policies to:

- Verify that password security settings in Windows and Linux computers are set correctly.
- Verify that certificates aren't close to expiration on Windows VMs.

Before you run this script, use the [`Connect-AzAccount`](/powershell/module/az.accounts/connect-azaccount) cmdlet to sign in. When you run the script, you must provide the name of the subscription that you want to apply the policies to.

```powershell

    # Assign guest configuration policy.

    param (
        [Parameter(Mandatory=$true)]
        [string] $SubscriptionName
    )

    $Subscription = Get-AzSubscription -SubscriptionName $SubscriptionName
    $scope = "/subscriptions/" + $Subscription.Id

    $PasswordPolicy = Get-AzPolicySetDefinition -Name "3fa7cbf5-c0a4-4a59-85a5-cca4d996d5a6"
    $CertExpirePolicy = Get-AzPolicySetDefinition -Name "b6f5e05c-0aaa-4337-8dd4-357c399d12ae"

    New-AzPolicyAssignment -Name "PasswordPolicy" -DisplayName "[Preview]: Audit that password security settings are set correctly inside Linux and Windows machines" -Scope $scope -PolicySetDefinition $PasswordPolicy -AssignIdentity -Location eastus

    New-AzPolicyAssignment -Name "CertExpirePolicy" -DisplayName "[Preview]: Audit that certificates are not expiring on Windows VMs" -Scope $scope -PolicySetDefinition $CertExpirePolicy -AssignIdentity -Location eastus

```

## Next steps

Learn how to [enable change tracking and alerting](./enable-tracking-alerting.md) for critical file, service, software, and registry changes.

> [!div class="nextstepaction"]
> [Enable tracking and alerting for critical changes](./enable-tracking-alerting.md)
