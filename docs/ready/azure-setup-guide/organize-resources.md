---
title: Organize your Azure resources effectively
description: Understand best practices for effectively organizing your Azure resources to simplify resource management.
author: laraaleite
ms.author: kfollis
ms.date: 04/09/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: fasttrack-edit, AQC, setup
ms.localizationpriority: high
---

<!-- cSpell:ignore laraaleite profx fsubscriptions fresource -->

# Organize your Azure resources effectively

Organizing your cloud-based resources is critical to securing, managing, and tracking the costs related to your workloads. To organize your resources, define a management group hierarchy, follow a well-considered naming convention and apply resource tagging.

<!-- markdownlint-disable MD024 MD025 -->

## [Azure management groups and hierarchy](#tab/AzureManagementGroupsAndHierarchy)

Azure provides four levels of management scope: management groups, subscriptions, resource groups, and resources. The following image shows the relationship of these levels.

   ![Diagram that shows the relationship of management hierarchy levels](./media/organize-resources/scope-levels.png)
    _Figure 1: How the four management-scope levels relate to each other._

- **Management groups:** These groups are containers that help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions applied to the management group.
- **Subscriptions:** A subscription logically associates user accounts and the resources that were created by those user accounts. Each subscription has limits or quotas on the amount of resources you can create and use. Organizations can use subscriptions to manage costs and the resources that are created by users, teams, or projects.
- **Resource groups:** A resource group is a logical container into which Azure resources like web apps, databases, and storage accounts are deployed and managed.
- **Resources:** Resources are instances of services that you create, like virtual machines, storage, or SQL databases.

### Scope of management settings

You can apply management settings like policies and role-based access control at any of the management levels. The level you select determines how widely the setting is applied. Lower levels inherit settings from higher levels. For example, when you apply a policy to a subscription, that policy is also applied to all resource groups and resources in that subscription.

Usually, it makes sense to apply critical settings at higher levels and project-specific requirements at lower levels. For example, you might want to make sure all resources for your organization are deployed to certain regions. To do that, apply a policy to the subscription that specifies the allowed locations. As other users in your organization add new resource groups and resources, the allowed locations are automatically enforced. Learn more about policies in the governance, security, and compliance section of this guide.

If you have only a few subscriptions, it's relatively simple to manage them independently. If the number of subscriptions you use increases, consider creating a management group hierarchy to simplify the management of your subscriptions and resources. For more information, see [Organize and manage your Azure subscriptions](../azure-best-practices/organize-subscriptions.md).

As you plan your compliance strategy, work with people in your organization with these roles: security and compliance, IT administration, enterprise architecture, networking, finance, and procurement.

::: zone target="docs"

### Create a management level

You can create a management group, additional subscriptions, or resource groups.

#### Create a management group

Create a management group to help you manage access, policy, and compliance for multiple subscriptions.

1. Go to [management groups](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade).
2. Select **Add management group**.

#### Create a subscription

Use subscriptions to manage costs and resources that are created by users, teams, or projects.

1. Go to [subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade).
2. Select **Add**.

> [!NOTE]
> Subscriptions can also be created programmatically. For more information, see [Programmatically create Azure subscriptions](/azure/azure-resource-manager/management/programmatically-create-subscription?tabs=azure-powershell).

#### Create a resource group

Create a resource group to hold resources like web apps, databases, and storage accounts that share the same lifecycle, permissions, and policies.

1. Go to [resource groups](https://portal.azure.com/#create/Microsoft.ResourceGroup).
1. Select **Add**.
1. Select the **Subscription** that you want your resource group created under.
1. Enter a name for the **Resource group**.
1. Select a **Region** for the resource group location.

### Learn more

To learn more, see:

- [Azure fundamentals](../considerations/fundamental-concepts.md)
- [Create your initial subscriptions](../azure-best-practices/initial-subscriptions.md)
- [Create additional Azure subscriptions to scale your Azure environment](../azure-best-practices/scale-subscriptions.md)
- [Organize and manage your Azure subscriptions](../azure-best-practices/organize-subscriptions.md)
- [Organize your resources with Azure management groups](/azure/azure-resource-manager/management-groups-overview)
- [Understand resource access management in Azure](../../govern/resource-consistency/resource-access-management.md)
- [Subscription service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits)

::: zone-end

::: zone target="chromeless"

### Actions

**Create a management group:**

Create a management group to help you manage access, policy, and compliance for multiple subscriptions.

1. Go to **Management groups**.
1. Select **Add management group**.

::: form action="OpenBlade[#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade]" submitText="Go to Management groups" :::

**Create an additional subscription:**

Use subscriptions to manage costs and resources that are created by users, teams, or projects.

1. Go to **Subscriptions**.
1. Select **Add**.

::: form action="OpenBlade[#blade/Microsoft_Azure_Billing/SubscriptionsBlade]" submitText="Go to Subscriptions" :::

**Create a resource group:**

Create a resource group to hold resources like web apps, databases, and storage accounts that share the same lifecycle, permissions, and policies.

1. Go to **Resource groups**.
1. Select **Add**.
1. Select the **Subscription** that you want your resource group created under.
1. Enter a name for the **Resource group**.
1. Select a **Region** for the resource group location.

::: form action="Create[#create/Microsoft.ResourceGroup]" submitText="Create a resource group" :::

::: zone-end

## [Naming standards](#tab/NamingStandards)

A good naming standard helps to identify resources in the Azure portal, on a billing statement, and in automation scripts. Your naming strategy should include business and operational details as components of resource names:

The business-related side of this strategy should ensure that resource names include the organizational information that's needed to identify the teams. Use a resource along with the business owners who are responsible for resource costs.

The operational side should ensure that names include information that IT teams need. Use the details that identify the workload, application, environment, criticality, and other information that's useful for managing resources.

Different resource types have different [naming rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules). For more information and recommendations aimed specifically at supporting enterprise cloud adoption efforts, see the Cloud Adoption Framework's [guidance on naming and tagging](../azure-best-practices/naming-and-tagging.md).

The following table includes naming patterns for a few sample types of Azure resources.

::: zone target="docs"

>[!TIP]
> Avoid using any special characters (`-` or `_`) as the first or last character in any name. These characters cause most validation rules to fail.

::: zone-end

| Entity | Scope | Length | Casing | Valid characters | Suggested pattern | Example |
| --- | --- | --- | --- | --- | --- | --- |
| Resource group | Subscription | 1-90 | Case insensitive | Alphanumeric, underscore, parentheses, hyphen, period (except at end), and Unicode characters | `<service short name>-<environment>-rg` | `profx-prod-rg` |
| Availability set | Resource group | 1-80 | Case insensitive | Alphanumeric, underscore, and hyphen | `<service-short-name>-<context>-as` | `profx-SQL-as` |
| Tag | Associated entity | 512 (Name), 256 (value) | Case insensitive | Alphanumeric | `"Key" : "value"` | `"Department" : "Central IT"` |

## [Resource tags](#tab/ResourceTags)

Tags are useful to quickly identify your resources and resource groups. You apply tags to your Azure resources to logically organize them by categories. Each tag consists of a name and a value. For example, you can apply the name "environment" and the value "production" to all the resources in production. Tags should include context about the resource's associated workload or application, operational requirements, and ownership information.

After you apply tags, you can retrieve all the resources in your subscription with that tag name and value. When you organize resources for billing or management, tags can help you retrieve related resources from different resource groups.

You can also use tags for many other things. Common uses include:

- **Metadata and documentation:** Administrators can easily see detail about the resources they're working on by applying a tag like `projectowner`.
- **Automation:** You might have regularly running scripts that can take an action based on a tag value like `shutdowntime` or `deprovisiondate`.
- **Cost optimization:** You can allocate resources to the teams and resources who are responsible for the cost. In the Azure Cost Management and Billing, you can apply the cost center tag as a filter to report the charges based on a team or department usage.

Each resource or resource group can have a maximum of 50 tag name and value pairs. This limitation only applies to tags directly applied to the resource group or resource.

For more tagging recommendations and examples, see [Recommended naming and tagging conventions](../azure-best-practices/naming-and-tagging.md) in the Cloud Adoption Framework.

::: zone target="docs"

### Apply a resource tag

To apply a tag to a resource group:

1. Go to [resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups).
1. Select a resource group.
1. Select **Assign tags**.
1. Enter a new name and value, or use the drop-down list to select an existing name and value.

### Learn more

To learn more, see [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources).

::: zone-end

::: zone target="chromeless"

### Action

**Apply a resource tag:**

To apply a tag to a resource group:

1. Go to **Resource groups**.
1. Select a resource group.
1. Select **Tags**.
1. Enter a new name and value, or select an existing name and value.

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Resources%2FSubscriptions%2FResourceGroups]" submitText="Go to resource groups" :::

::: zone-end
