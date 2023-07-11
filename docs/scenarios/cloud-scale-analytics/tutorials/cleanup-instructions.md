---
title: Tutorial - Clean up resources
description: Clean up all the resources that were deployed in an Azure subscription during the cloud-scale analytics tutorials.
author: abdale
ms.author: hamoodaleem
ms.date: 07/18/2022
ms.topic: tutorial
s.custom: e2e-data-management, think-tank, devx-track-azurecli
---

# Tutorial: Clean up resources

As you go through the cloud-scale analytics tutorials, you might run into deployment issues. To start over, use the following scripts to remove tutorial resources you created in your Azure subscription.

You also can use the scripts to remove all tutorial resources you created in your subscription when you've finished all steps in the tutorials.

> [!WARNING]
> In the following scripts, a filter identifies and removes resource groups you created in the tutorials. Removing resource groups by using these scripts is *an action that can't be reversed*. Be sure you enter the correct prefix in the scripts. For example, in the tutorials, these placeholders are used to refer to the tutorial resources you deploy:
>
> - `<DMLZ-prefix>` refers to the prefix you entered when you created your *data management landing zone* deployment.
> - `<DLZ-prefix>` refers to the prefix you entered when you created your *data landing zone* deployment.
> - `<DP-prefix>` refers to the prefix you entered when you created your *data product* deployment.

## Use PowerShell for single-resource group cleanup

```powershell
# Clean up PowerShell resources.

$prefix = '<your prefix>'
$subscriptionId = '<subscription ID>'

# Set the subscription.
Set-AzContext -SubscriptionId $subscriptionId

# List all resource groups that will be removed.
Get-AzResourceGroup | ? ResourceGroupName -match $prefix | Select-Object ResourceGroupName

# Remove the resource groups shown in the preceding command.
Get-AzResourceGroup | ? ResourceGroupName -match $prefix | Remove-AzResourceGroup -AsJob -Force
```

## Use Bash in the Azure CLI for single-resource group cleanup

```bash
# Clean up resources for Azure Cloud Shell, macOS, and Linux.

prefix='<prefix>'  
subscription='<subscription ID>'

# Set the subscription.
az account set --subscription $subscription

# Review the query to ensure the resource groups match the specified prefix.
az group list -o tsv  --query "[?contains(@.name, '$prefix')==\`true\`].name"

# Delete resource groups that match the prefix.
for rg in $(az group list -o tsv --query "[?contains(@.name, '$prefix')==\`true\`].name");
do
    az group delete --name $rg -y --no-wait;
done
```

## Use PowerShell for multiple-resource group cleanup

```powershell
# PowerShell commands that use the Azure CLI to remove multiple resource groups that have a common prefix.

# Make sure you're in the correct subscription.
az account show

# Change the subscription, if needed.
az account set -s "<the correct subscription ID>"

# Define the wildcard expression to use to filter your cloud-scale analytics resource groups.
$filter = "*-dev-*"

# Get all resource groups and filter by your prefix.
# Print a list of resource groups to ensure you delete the correct resource groups.
$groups = az group list | ConvertFrom-Json
$groups = $groups | where{$_.name -like $filter}
[array]::Reverse($groups)
$message =  "`n`nThe following resource groups will be deleted:`n"
Foreach ($group in $groups) {
    $message += "   - $($group.name)`n"
}
$message += "`n`n"
Write-Host -ForegroundColor yellow $message

# Delete all peerings for the virtual networks you'll delete.
$subs = az account list | ConvertFrom-Json
$all_vnets = az network vnet list | ConvertFrom-Json
$del_vnets = $all_vnets | where{$_.resourceGroup -like $filter}
$del_vnet_ids = $del_vnets | ForEach-Object { $_.id }
Foreach ($sub in $subs) {
    Write-Host "Looking for vnet peerings in subscription `"$($sub.name)`"..."
    $all_vnets = az network vnet list --subscription $($sub.id) 2> $null | ConvertFrom-Json
    Foreach ($vnet in $all_vnets) {
        $linked_peerings = $vnet.virtualNetworkPeerings | where{$del_vnet_ids.Contains($_.remoteVirtualNetwork.id)}
        Foreach ($peering in $linked_peerings) {
            Write-Host -ForegroundColor red "`tDeleting peering `"$($peering.name)`" for VNet $($vnet.name)"
            az network vnet peering delete --ids $peering.id
        }
    }
}

# Delete all self-hosted integration runtimes from data factories you'll delete.
$factories = az datafactory list --only-show-errors | ConvertFrom-Json
$factories = $factories | where{$_.resourceGroup -like $filter}
Foreach ($factory in $factories) {
    $shirs = az datafactory integration-runtime list --resource-group $factory.resourceGroup --factory-name $factory.name --only-show-errors | ConvertFrom-Json
    $shirs = $shirs | where{$_.properties.type -eq "SelfHosted"}
    Foreach ($shir in $shirs) {
        Write-Host -ForegroundColor red "Deleting SHIR for `"$($factory.name)`" in RG $($factory.resourceGroup)"
        az datafactory integration-runtime delete --resource-group $factory.resourceGroup --factory-name $factory.name --name $shir.name --yes --only-show-errors
    }
}

# Delete the identified resource groups.
Foreach ($group in $groups) {
    Write-Host -ForegroundColor red "Deleting $($group.name)"
    az group delete --name $group.name --yes --no-wait
}

# Check for the resource groups to verify they were deleted.
$allGroups = az group list | ConvertFrom-Json
$allGroups | Where-Object { $groups.name -contains $_.name } | Select-Object name, @{Name="State"; Expression={$_.properties.provisioningState }}
```

## Next steps

- Review the [cloud-scale analytics architectures](../architectures/overview-architectures.md).
- Learn more about the [deployments templates](../architectures/deployment-templates.md) you used in the cloud-scale analytics tutorials.
