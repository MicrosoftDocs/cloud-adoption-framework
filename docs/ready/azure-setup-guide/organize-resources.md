---
title: Organize your Azure resources effectively
description: Understand best practices for effectively organizing your Azure resources to simplify resource management.
author: laraaleite
ms.author: martinek
ms.date: 10/04/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, fasttrack-edit, AQC, setup
---

# Organize your Azure resources effectively

Organize your cloud-based resources to secure, manage, and track costs that are related to your workloads. To organize your resources, define a management group hierarchy, consider and follow a naming convention, and apply resource tagging.

<!-- markdownlint-disable MD024 -->

## Management levels and hierarchy

Azure provides four levels of management: management groups, subscriptions, resource groups, and resources. The following diagram shows the relationship between these levels.

:::image type="content" alt-text="Diagram that shows the relationship of management hierarchy levels." source="./media/organize-resources/scope-levels.png":::

- **Management groups** help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions that are applied to the management group.

- **Subscriptions** logically associate user accounts with the resources that they create. Each subscription has limits or quotas on the amount of resources that it can create and use. Organizations can use subscriptions to manage costs and the resources that are created by users, teams, and projects.

- **Resource groups** are logical containers where you can deploy and manage Azure resources like web apps, databases, and storage accounts.

- **Resources** are instances of services that you can create, such as virtual machines, storage, and SQL databases.

### Management settings scope

You can apply management settings, such as policies and role-based access control, at any management level. The level determines how widely the setting is applied. Lower levels inherit settings from higher levels. For example, when you apply a policy to a subscription, that policy applies to all resource groups and resources in that subscription.

Usually, it makes sense to apply critical settings at higher levels and project-specific requirements at lower levels. For example, to make sure that all resources for your organization deploy to certain regions, apply a policy to the subscription that specifies the allowed regions. The allowed locations are automatically enforced when users in your organization add new resource groups and resources. Learn more about policies in [Governance, security, and compliance](govern-org-compliance.md), another article in this setup guide.

Managing a few subscriptions independently is easy. However, for a larger number of subscriptions, consider creating a management group hierarchy to simplify management of subscriptions and resources. For more information, see [Organize and manage multiple Azure subscriptions](../azure-best-practices/organize-subscriptions.md).

Work with people in the following roles as you plan your organizational compliance strategy:

- Security and compliance
- IT administration
- Enterprise architecture
- Networking
- Finance
- Procurement

::: zone target="docs"

### Create a management structure

To create a management group, subscription, or resource group, sign in to the [Azure portal](https://portal.azure.com).

- To create a *management group* to help you manage multiple subscriptions, go to [Management groups](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade) and select **Create**.

- To create a *subscription* to associate users with resources, go to [Subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade) and select **Add**.

  > [!NOTE]
  > You can also create subscriptions programmatically. For more information, see [Programmatically create Azure subscriptions](/azure/cost-management-billing/manage/programmatically-create-subscription).

- To create a *resource group* to hold resources that share the same permissions and policies:

  1. Go to [Create a resource group](https://portal.azure.com/#create/Microsoft.ResourceGroup).
  1. In the **Create a resource group** form:
     1. For **Subscription**, select the subscription in which to create the resource group.
     1. For **Resource group**, enter a name for the new resource group.
     1. For **Region**, select a region in which to locate the resource group.
  1. Select **Review + create**, and after the review passes, select **Create**.

::: zone-end

::: zone target="chromeless"

### Actions

To create a management group, subscription, or resource group, sign in to the [Azure portal](https://portal.azure.com).

- To create a *management group* to help you manage multiple subscriptions, go to [Management groups](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade) and select **Create**.

- To create a *subscription* to associate users with resources, go to [Subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade) and select **Add**.

  > [!NOTE]
  > You can also create subscriptions programmatically. For more information, see [Programmatically create Azure subscriptions](/azure/cost-management-billing/manage/programmatically-create-subscription).

- To create a *resource group* to hold resources that share the same permissions and policies:

  1. Go to [Create a resource group](https://portal.azure.com/#create/Microsoft.ResourceGroup).
  1. In the **Create a resource group** form:
     1. For **Subscription**, select the subscription in which to create the resource group.
     1. For **Resource group**, enter a name for the new resource group.
     1. For **Region**, select a region in which to locate the resource group.
  1. Select **Review + create**, and after the review passes, select **Create**.

::: zone-end

## Naming standards

A good naming standard helps to identify resources in the Azure portal, on a billing statement, and in automation scripts. Your naming strategy should include business and operational details in resource names.

- Business details should include the organizational information that's required to identify teams. Use the resource's short name, along with the names of the business owners who are responsible for the resource costs.

- Operational details in resource names should include information that IT teams need. Include details that identify the workload, application, environment, criticality, and other information that's useful for managing resources.

[Naming rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules) vary by the type of resource. For more information and for recommendations that support cloud adoption by enterprises, see [Develop your naming and tagging strategy for Azure resources](../azure-best-practices/naming-and-tagging.md).

::: zone target="docs"

> [!NOTE]
> - Avoid using special characters, such as hyphen and underscore (`-` and `_`), as the first or last characters in a name. Doing so can cause validation rules to fail.
> - Names of tags are case-insensitive.

::: zone-end

The following table shows restrictions and naming patterns for resource groups, availability sets, and tags.

| | Resource group | Availability set | Tag |
|----------|----------|----------|----------|
| **Scope** | Subscription | Resource group | Associated entity |
| **Length** | 1-90 | 1-80 | 512 (name), 256 (value) |
| **Valid characters** | Alphanumeric, underscore, parentheses, hyphen, and period except at end | Alphanumeric, underscore, and hyphen | Alphanumeric, spaces, and Unicode characters except for angle brackets, percent symbol, ampersand, forward or back slashes, question mark, or period |
| **Suggested pattern** | `<service-short-name>-<environment>-rg` | `<service-short-name>-<context>-as`  | `key` : `value` |
| **Example**           | `profx-prod-rg` | `profx-SQL-as` | `Department` : `Central IT ☺` |


## Resource tags

Tags can quickly identify your resources and resource groups. You apply tags to your Azure resources to logically organize them by categories. Tags can include context about the resource's associated workload or application, operational requirements, and ownership information.

Each tag consists of a name and a value. For example, you can apply the name *environment* and the value *production* to all the resources in production.

After you apply tags, you can easily retrieve all the resources in your subscription that have that tag name and value. When you organize resources for billing or management, tags can help you retrieve related resources from different resource groups.

Other common uses for tags include:

- **Metadata and documentation:** Administrators can easily see detail about the resources they're working on by applying a tag like *ProjectOwner*.
- **Automation:** Regularly running scripts can take action based on a tag value like *ShutdownTime* or *DeprovisionDate*.
- **Cost optimization:** You can allocate resources to the teams and resources who are responsible for the costs. In [Cost Management + Billing](/azure/cost-management-billing/), you can apply your cost center tag as a filter to report charges based on usage by team or department.

Each resource or resource group can have a maximum of 50 pairs of tag names and values. This limitation is only for tags that directly apply to the resource group or resource.

For more tagging recommendations and examples, see [Develop your naming and tagging strategy for Azure resources](../azure-best-practices/naming-and-tagging.md).

::: zone target="docs"

### Apply a resource tag

To apply one or more tags to a resource group:

1. In the Azure portal, go to [Resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) and select the resource group.
1. Select **Assign tags** in the navigation at the top of the page.
1. Enter the name and value for a tag under **Name** and **Value**.
1. Enter more names and values or select **Save**.

### Remove a resource tag

To remove one or more tags from a resource group:

1. In the Azure portal, go to [Resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) and select the ellipses menu for the group, and then select **Edit tags**.
1. Select the trash can icon for each tag that you want to remove.
1. To save your changes, select **Save**.


::: zone-end

::: zone target="chromeless"

### Action

To apply one or more tags to a resource group:

1. In the Azure portal, go to [Resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) and select the resource group.
1. Select **Assign tags** in the navigation at the top of the page.
1. Enter the name and value for a tag under **Name** and **Value**.
1. Enter more names and values or select **Save**.


To remove one or more tags from a resource group:

1. In the Azure portal, go to [Resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) and select the ellipses menu for the group, and then select **Edit tags**.
1. Select the trash can icon for each tag that you want to remove.
1. To save your changes, select **Save**.


::: zone-end

## Next steps

To learn more about management levels and organization, see:

- [Azure fundamentals](../considerations/fundamental-concepts.md)
- [Create your initial Azure subscriptions](../azure-best-practices/initial-subscriptions.md)
- [Create additional subscriptions to scale your Azure environment](../azure-best-practices/scale-subscriptions.md)
- [Organize and manage multiple Azure subscriptions](../azure-best-practices/organize-subscriptions.md)
- [What are Azure management groups?](/azure/governance/management-groups/overview)
- [Resource access management in Azure](../../get-started/how-azure-resource-manager-works.md)
- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits)

For more information about resource naming and tagging, see:

- [Develop your naming and tagging strategy for Azure resources](../azure-best-practices/naming-and-tagging.md)
- [Use tags to organize your Azure resources and management hierarchy](/azure/azure-resource-manager/management/tag-resources)
