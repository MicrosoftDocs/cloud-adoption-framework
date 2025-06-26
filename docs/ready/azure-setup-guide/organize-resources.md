---
title: Organize your Azure resources effectively
description: Learn how to structure Azure resources using management hierarchies, naming conventions, and tags to streamline operations and cost management.
author: stephen-sumner
ms.author: pnp
ms.date: 06/18/2025
ms.topic: conceptual
ms.custom: AQC
---

# Organize your Azure resources effectively

This article explains how to organize Azure resources for optimal security, management, and cost tracking. Proper resource organization enables consistent governance, simplified operations, and clear cost attribution across your workloads.

## Establish a consistent naming convention

A naming convention provides standardized identification across Azure resources, billing statements, and automation scripts. Consistent naming reduces management overhead and prevents resource conflicts across teams. You must define a naming standard and use it consistently.

1. **Understand name permanence.** Azure resource names cannot be changed after creation. Include only information that remains constant in the name. Use tags to capture other details.

1. **Follow Azure naming rules.** There are [naming rules for every Azure resource](/azure/azure-resource-manager/management/resource-name-rules). Azure names must follow three general principles:

    - Names need to be unique within the scope of the Azure resource (varies between resource).
    - Names need to meet length requirements (varies between resources).
    - Names can only contain valid characters (varies between resources).

1. **Use abbreviations.** Use [Azure resource abbreviations](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) to keep resource names within length limits.

1. **Define a naming convention.** You need a standardized way to name Azure resources. Tailor the naming convention to your specific needs. such as `{Azure resource abbreviation}{workload name, parent resource, or purpose}{environment}{region}{instance}`. Not every resource name needs to include the same information. For example, management groups and subscriptions often contain department information while workload resources don't. Use a hyphen `-` between naming components to make the name more readable, but, note, not all Azure resources allow you to use a hyphen. For more information and examples, see [Define your naming convention](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming).

## Apply resource tags

Resource tags provide name-value metadata for resource identification, cost allocation, and operational tracking. Tags supplement naming conventions with flexible categorization that supports business processes and automation workflows. Implement a consistent tagging strategy to achieve comprehensive resource visibility and management.

Tags simplify resource searches and management. Use tags to capture relevant information such as resource type, application name, environment, department, and location. See [steps to apply tags](/azure/azure-resource-manager/management/tag-resources-portal).

| Name           | Value               |
|---------------|---------------------|
| Azure resource | `resource: storage account`<br>`resource: sql database` |
| Application name | `app : training`<br>`app : webapp` |
| Environment    | `env : dev`<br>`env : prod` |
| Department     | `dept : finance`<br>`dept : sales` |
| Location       | `region : eastus`<br>`region : westus` |

For a mature tagging approach, see [Define your tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

## Build a management hierarchy

A management hierarchy defines governance boundaries and inheritance patterns for Azure resources. Azure provides four management levels where policies, access controls, and budgets flow from higher to lower levels. You must structure this hierarchy to align with your organizational requirements and enable consistent governance across all resources.

1. **Create management groups for workload types.** Establish [management groups](/azure/governance/management-groups/create-management-group-portal) for distinct workload categories like corporate applications or internet-facing services. This structure simplifies governance and compliance management. Use functional names such as "Workloads," "Platform," "Online," and "Corporate." Each management group inherits settings from the [root management group](/azure/governance/management-groups/overview#root-management-group-for-each-directory).

1. **Create subscriptions for environment separation.** Separate Azure subscriptions for development, testing, and production environments to ensure isolation and cost tracking. This strategy prevents cross-environment dependencies and enables environment-specific policies. See [steps to create Azure subscriptions](/azure/cost-management-billing/manage/create-subscription) and [programmatic subscription creation](/azure/cost-management-billing/manage/programmatically-create-subscription).

1. **Use resources groups to group resources by lifecycle.** Place resources with shared lifecycles into the same [resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups). This approach streamlines deployment, updates, and deletions. Use infrastructure-as-code templates for consistent deployment. See [steps to deploy resources](/azure/azure-resource-manager/management/manage-resources-portal#deploy-resources-to-a-resource-group).

1. **Align resource locations with the resource group.** Place resources in the same region as their resource group to optimize performance and simplify management. For details, see [Resource group location alignment](/azure/azure-resource-manager/management/overview#resource-group-location-alignment). If resources span multiple regions, move them to a [new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

For a more mature resource hierarchy, see [Azure landing zone resource organization](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

## Tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Naming Strategy | [Resource abbreviations guide](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) | Provides standardized abbreviations for Azure resource types |
| Management Groups | [Azure management groups](/azure/governance/management-groups/overview) | Enables hierarchical organization of subscriptions with inherited governance |
| Resource Organization | [Azure Resource Manager](/azure/azure-resource-manager/management/overview) | Manages resource deployment and organization within subscriptions |
| Tagging Strategy | [Azure resource tags](/azure/azure-resource-manager/management/tag-resources) | Supports metadata application for cost tracking and resource management |

## Next steps

> [!div class="nextstepaction"]
> [Management group design considerations and recommendations](../landing-zone/design-area/resource-org-management-groups.md)
