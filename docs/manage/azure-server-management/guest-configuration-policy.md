---
title: "Guest Configuration policy"
description: Use the Cloud Adoption Framework for Azure to learn how to use the Azure Policy Guest Configuration extension to audit the configuration settings in an Azure VM.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Guest Configuration policy

You can use the Azure Policy [Guest Configuration](/azure/governance/policy/concepts/guest-configuration) extension to audit the configuration settings in a virtual machine. Guest Configuration is currently supported only on Azure VMs.

To find the list of Guest Configuration policies, search for "Guest Configuration" on the Azure Policy portal page. Or run this cmdlet in a PowerShell window to find the list:

```powershell
Get-AzPolicySetDefinition | where-object {$_.Properties.metadata.category -eq "Guest Configuration"}
```

> [!NOTE]
> Guest Configuration functionality is regularly updated to support additional policy sets. Check for new supported policies periodically and evaluate whether they'll be useful.

<!-- TODOBACKLOG: Update these links when available. 

By default, we recommend that you enable the following policies:

- **Preview:** Audit to verify that password-security settings are correct on Linux and Windows machines.
- Audit to verify that certificates are not nearing expiration on Windows VMs.

-->

## Deployment

Use the following example PowerShell script to deploy these policies to:

- Verify that password security settings in Windows and Linux computers are set correctly.
- Verify that certificates aren't close to expiration on Windows VMs.

 Before you run this script, use the [Connect-AzAccount](/powershell/module/az.accounts/connect-azaccount?view=azps-2.1.0) cmdlet to sign in. When you run the script, you must provide the name of the subscription that you want to apply the policies to.

```powershell

    # Assign Guest Configuration policy.

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
