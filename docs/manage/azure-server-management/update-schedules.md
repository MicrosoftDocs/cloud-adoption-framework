---
title: Create update schedules
description: Use the Cloud Adoption Framework for Azure to learn how to manage update schedules with the Azure portal or the new PowerShell cmdlet modules.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: internal
---

# Create update schedules

You can manage update schedules by using the Azure portal or the new PowerShell cmdlet modules.

To create an update schedule via the Azure portal, see [Schedule an update deployment](/azure/automation/update-management/deploy-updates#schedule-an-update-deployment).

The `Az.Automation` module now supports configuring Update Management by using Azure PowerShell. The [`New-AzAutomationUpdateManagementAzureQuery`](/powershell/module/az.automation/new-azautomationupdatemanagementazurequery) cmdlet allows you to use tags, location, and saved searches to configure update schedules for a flexible group of machines.

## Example script

The example script in this section illustrates the use of tagging and querying to create dynamic groups of machines that you can apply update schedules to. It performs the following actions. You can refer to the implementations of the specific actions when you create your own scripts.

- Creates an Azure Automation update schedule that runs every Saturday at 8:00 AM.
- Creates a query for any machines that match these criteria:
  - Deployed in the `westus`, `eastus`, or `eastus2` Azure location.
  - Has an `Owner` tag applied with a value set to `JaneSmith`.
  - Has a `Production` tag applied with a value set to `true`.
- Applies the update schedule to the queried machines and sets a two-hour update window.

Before you run the example script, you'll need to sign in by using the [`Connect-AzAccount`](/powershell/module/az.accounts/connect-azaccount) cmdlet. When you start the script, provide the following information:

- The target subscription ID
- The target resource group
- Your Log Analytics workspace name
- Your Azure Automation account name

```powershell

    <#
        .SYNOPSIS
            This script orchestrates the deployment of the solutions and the agents.
        .Parameter SubscriptionName
        .Parameter WorkspaceName
        .Parameter AutomationAccountName
        .Parameter ResourceGroupName

    #>

    param (
        [Parameter(Mandatory=$true)]
        [string] $SubscriptionId,

        [Parameter(Mandatory=$true)]
        [string] $ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [string] $WorkspaceName,

        [Parameter(Mandatory=$true)]
        [string] $AutomationAccountName,

        [Parameter(Mandatory=$false)]
        [string] $scheduleName = "SaturdayCriticalSecurity"
    )

    Import-Module Az.Automation

    $startTime = ([DateTime]::Now).AddMinutes(10)
    $schedule = New-AzAutomationSchedule -ResourceGroupName $ResourceGroupName `
        -AutomationAccountName $AutomationAccountName `
        -StartTime $startTime `
        -Name $scheduleName `
        -Description "Saturday patches" `
        -DaysOfWeek Saturday `
        -WeekInterval 1 `
        -ForUpdateConfiguration

    # Using AzAutomationUpdateManagementAzureQuery to create dynamic groups.

    $queryScope = @("/subscriptions/$SubscriptionID/resourceGroups/")

    $query1Location =@("westus", "eastus", "eastus2")
    $query1FilterOperator = "Any"
    $ownerTag = @{ "Owner"= @("JaneSmith") }
    $ownerTag.Add("Production", "true")

    $DGQuery = New-AzAutomationUpdateManagementAzureQuery -ResourceGroupName $ResourceGroupName `
        -AutomationAccountName $AutomationAccountName `
        -Scope $queryScope `
        -Tag $ownerTag

    $AzureQueries = @($DGQuery)

    $UpdateConfig = New-AzAutomationSoftwareUpdateConfiguration -ResourceGroupName $ResourceGroupName `
        -AutomationAccountName $AutomationAccountName `
        -Schedule $schedule `
        -Windows `
        -Duration (New-TimeSpan -Hours 2) `
        -AzureQuery $AzureQueries `
        -IncludedUpdateClassification Security,Critical
```

## Next steps

See examples of how to implement [common policies in Azure](./common-policies.md) that can help manage your servers.

> [!div class="nextstepaction"]
> [Common policies in Azure](./common-policies.md)
