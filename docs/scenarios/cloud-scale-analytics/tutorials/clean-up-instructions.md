---
title: Clean-up instructions
description: Clean all the resources from Azure subscription deployed during the tutorial. 
author: andrehass
ms.author: anhass
ms.date: 03/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Clean-up instructions

As you go through the tutorial, you might run into deployment issues, to start over fresh, please use the steps below to remove the resources created in your subscription.

Also, once all the steps in the tutorial are completed, you can use the  scripts below to remove all resources that have been created in your subscription.

## Before you run the scripts

>[!Warning]
>Please ensure you selected the correct prefix as a filter. The filter parameter will be used to remove the resource groups created during the Workshop Labs. Removing resource groups with this scripts is a irreversible operation.

```powershell

$prefix = '<your prefix>'
$subscriptionId = '<subscription ID>'

# Set Subscription
Set-AzContext -SubscriptionId $subscriptionId

# Lists all Resource Groups that will be removed
Get-AzResourceGroup | ? ResourceGroupName -match $prefix | Select-Object ResourceGroupName

# Removes the list of Resource Groups shown in the previous command
Get-AzResourceGroup | ? ResourceGroupName -match $prefix | Remove-AzResourceGroup -AsJob -Force

```

```bash
# Cloud Shell, MacOS and Linux bash script with az cli 

prefix='<prefix>'  
subscription='<subscription ID>'

# Set Subscription
az account set --subscription $subscription

# Visual Review to ensure the resource groups matches with specified prefix. 
az group list -o tsv  --query "[?contains(@.name, '$prefix')==\`true\`].name"

# Delete Resource Groups that matches with prefix. 
for rg in $(az group list -o tsv --query "[?contains(@.name, '$prefix')==\`true\`].name"); 
do 
    az group delete --name $rg -y --no-wait; 
done
```

```powershell

#------------------------------------------------------------------------------
# PowerShell commands that use Azure CLI to remove resource groups with a common
# prefix
#--------------------------------------------------------------------------------

# Make sure I'm in the right subscription...
az account show

# If I need to change subscriptions...
# az account set -s "<the right sub ID>"

# Define the wildcard expression I want to use to filter my cloud-scale analytics resource groups
$filter = "*-dev-*"

# Get all RG's and filter by my prefix.  Print out the list of RG's so I can be sure I'm deleting the right stuff
$groups = az group list | ConvertFrom-Json
$groups = $groups | where{$_.name -like $filter}
[array]::Reverse($groups)
$message =  "`n`nThe following resource groups will be deleted:`n"
Foreach ($group in $groups) {
	$message += "   - $($group.name)`n"
}
$message += "`n`n"
Write-Host -ForegroundColor yellow $message


# Delete all peerings for the vnets we're about to delete
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


# Delete all of the Self-Hosted Integration Runtimes (SHIR) from the data factories
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


# Now that we have the blocking resources deleted, we can delete the resource groups we listed above
Foreach ($group in $groups) {
	Write-Host -ForegroundColor red "Deleting $($group.name)"
	az group delete --name $group.name --yes --no-wait
}



# Check for the groups supposedly deleted
$allGroups = az group list | ConvertFrom-Json
$allGroups | Where-Object { $groups.name -contains $_.name } | Select-Object name, @{Name="State"; Expression={$_.properties.provisioningState }}

```