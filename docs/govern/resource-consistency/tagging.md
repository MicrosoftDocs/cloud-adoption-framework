---
title: Tagging guidance in the Resource Consistency discipline
description: Use the tagging guidance in the Cloud Adoption Framework for Azure for guidance on what to tag, how to enforce and audit compliance with your tagging standards.
author: robbagby
ms.author: robbag
ms.date: 10/05/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Tagging overview

Tags allow you to assign metadata to Azure resources. Use this metadata to organize and classify your resources for reporting and management purposes. Some examples of the uses of tags are:

- Managing and monitoring costs
- Identifying workloads
- Determining the workload environment
- Classifying data hosted within resource
- Identifying ownership of or who operates the resource

Tags can be used in the following systems:

- Azure portal
- Kusto queries
- Azure CLI / PowerShell
- Data extracts
- Power BI

The tags you need to apply will vary according to workload and organizational requirements. The following guidance provides recommendations for developing your organization's tagging strategy.

## Guidance

Your tags should include context about the resource's associated workload or application, operational requirements, and ownership. Only use tags when Azure resource graph or Azure Resource Manager can't provide the data.

Use the following resources to help define your tagging strategy:

- Apply the [minimum suggested tags](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging#minimum-suggested-tags) listed in the ready methodology.
- Use an owner tag to capture the owner of the resource.
- Consider implementing relevant [other common tagging examples](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging#other-common-tagging-examples) from the ready methodology.

## Enforce

You can use [Azure Policy](/azure/governance/policy/overview) to enforce compliance with your tagging standards. Use the [built-in tag policies](/azure/governance/policy/samples/built-in-policies#tags) to require, inherit, add, or append tags to the appropriate resources, resource groups or subscriptions.

## Audit

Use [Azure Resource Graph](/azure/governance/resource-graph/overview) queries to identify resources that aren't compliant with your tagging standards.

The following Azure Resource Graph example query identifies resources that are missing the environment tag.

```azurecli
Resources
| where tags !has "environment"
| project tags, name, resourceGroup, subscriptionId
```
