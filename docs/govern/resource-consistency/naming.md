---
title: Naming guidance for resources in the Resource Consistency discipline
description: Learn how to implement well-defined naming conventions help to quickly locate and manage resources.
author: robbagby
ms.author: robbag
ms.date: 10/05/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal, UpdateFrequency2
---

# Naming overview

Well-defined naming conventions  provide consistency, prevent naming clashes and, along with [resource tagging](tagging.md), allow administrators to quickly locate and manage resources. [Define your naming convention](../../ready/azure-best-practices/resource-naming.md) notes that an effective naming convention composes resource names from important information about each resource, such as:

- Resource type
- Workload
- Environment
- Azure region

For example, a public IP resource for a production SharePoint workload in the West US region might be pip-sharepoint-prod-westus-001.

![Diagram that shows the components of an Azure resource name.](../../_images/ready/resource-naming.png)

*Diagram 1: Components of an Azure resource name from [Define your naming convention](../../ready/azure-best-practices/resource-naming.md).*

Naming rules and restrictions, such as scope, name length, or valid characters, differ by resource type in Azure. The example in the table below illustrates how resources have differing constraints. 

| Entity | Scope | Length | Valid Characters |
| --- | --- | --- | --- |
| Microsoft.Storage.storageAccounts | global | 3-24 | Lowercase letters and numbers. |
| Microsoft.Network.virtualNetworks | resource group | 2-64 | Alphanumerics, underscores, periods, and hyphens. <br />Start with alphanumeric. End alphanumeric or underscore. |

*Table 1: Example resource rules and restrictions*

Accurate naming is critical when responding to security incidents. The logs and alerts from security services such as Microsoft Defender for Cloud and Microsoft Sentinel reference resources by their resource name. A well-defined resource name will allow administrators to quickly identify the affected system, determine whether it's production or not, and assess the associated business impact.

## Guidance

Establish a comprehensive naming convention before you begin any large cloud deployment. Define your naming strategy as early as possible, because changing resource names can be difficult. The naming convention should take into account the unique naming rules and restrictions for different resource types.

Use the following resources to understand the components of a good naming convention, determine abbreviations for resource types, understand naming constraints for resources, and naming resources.

- Read [Define your naming convention](../../ready/azure-best-practices/resource-naming.md) to learn about the important components of a well-defined naming convention, and see some example names for common Azure resource types.
- Read or reference [Abbreviation examples for Azure resources](../../ready/azure-best-practices/resource-abbreviations.md) to help determine the abbreviations you'll use for the Azure resources you're using.
- Read or reference [Naming rules and restrictions for Azure resources](/azure/azure-resource-manager/management/resource-name-rules) to understand the rules and restrictions on names for the Azure resources you're using.
- Install and configure the [Azure Naming Tool](https://github.com/mspnp/AzureNamingTool) with the organizational standards you determined above. Use the tool to generate names for resources.

## Enforce

Azure Policy can be used to enforce and audit compliance of your naming standards. Because there are no pre-defined standards for naming, there are no built-in policies to enforce naming. You can create custom policies to enforce the standards you determine.

The following snippet from a [custom policy example in Azure Samples](https://github.com/Azure-Samples/Governance/blob/master/src/policy/naming-convention/policy.json) denies an Azure virtual machine deployment based on a naming standard.

```json
{
    "if": {
        "allOf": [
            {
                "field": "name",
                "notMatch": "[concat('vm', parameters('Application'), parameters('DataCenterCountry'), parameters('DataCenterLocation'), parameters('Environment'), parameters('WebTier'), '#')]"
            },
            {
                "field": "name",
                "notMatch": "[concat('vm', parameters('Application'), parameters('DataCenterCountry'), parameters('DataCenterLocation'), parameters('Environment'), parameters('LogicTier'), '#')]"
            },
            {
                "field": "name",
                "notMatch": "[concat('vm', parameters('Application'), parameters('DataCenterCountry'), parameters('DataCenterLocation'), parameters('Environment'), parameters('DataTier'), '#')]"
            },
            {
                "field": "type",
                "equals": "Microsoft.Compute/virtualMachines"
            }
        ]
    },
    "then": {
        "effect": "deny"
    }
}
```

## Audit

Use [Azure Resource Graph](/azure/governance/resource-graph/overview) queries to identify resources that aren't compliant with your naming standards. Because there are no predefined naming standards, you will custom graph queries.

The following Azure Resource Graph example query identifies improperly named virtual networks as per [resource naming guidance](../../ready/azure-best-practices/resource-naming.md).

```azurecli
Resources
| where type == 'microsoft.network/virtualNetworks'
| project name, id
| extend valid = name matches regex @"(^vnet-\w+-(prod|dev)-\w+-\d\d\d$)"
| where valid == false
```
