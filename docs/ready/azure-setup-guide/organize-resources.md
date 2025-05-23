---
title: Organize your Azure resources effectively
description: Understand best practices for effectively organizing your Azure resources to simplify resource management.
author: Zimmergren
ms.author: pnp
ms.date: 01/20/2025
ms.topic: conceptual
ms.custom: AQC
---

# Organize your Azure resources effectively

Organize your cloud-based resources to secure, manage, and track costs related to your workloads. To organize your resources, define a management group hierarchy, consider and follow a naming convention, and apply resource tagging.

<!-- markdownlint-disable MD024 -->

## Management levels and hierarchy

Azure provides four levels of management: management groups, subscriptions, resource groups, and resources. The following diagram shows the relationship between these levels.

:::image type="content" alt-text="Diagram that shows the relationship of management hierarchy levels." source="./media/organize-resources/scope-levels.png":::

- **Management groups** help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions applied to the management group.

- **Subscriptions** logically associate user accounts with the resources they create. Each subscription has limits or quotas on the amount of resources it can create and use. Organizations can use subscriptions to manage costs and the resources created by users, teams, and projects.

- **Resource groups** are logical containers where you can deploy and manage Azure resources like virtual machines, web apps, databases, and storage accounts.

- **Resources** are instances of services you can create in a resource group, such as virtual machines, storage, and SQL databases.



  > [!NOTE]
  > To understand and minimize the effect of regional outages, see [Select Azure regions](/azure/cloud-adoption-framework/ready/azure-setup-guide/regions).

### Management settings scope

You can apply management settings, such as policies and role-based access control, at any management level. The level determines how widely the setting is applied. Lower levels inherit settings from higher levels. For example, when you apply a policy to a subscription, that policy applies to all resource groups and resources in that subscription, unless explicitly excluded.

Start with applying critical settings at higher levels and project-specific requirements at lower levels. For example, to make sure that all resources for your organization deploy to certain regions, apply a policy to the subscription that specifies the allowed regions. The allowed locations are automatically enforced when users in your organization add new resource groups and resources.

> [!TIP]
> Use management groups to organize and govern your Azure subscriptions. As the number of your subscriptions increases, management groups provide critical structure to your Azure environment and make it easier to manage your subscriptions.
> To learn more, see [Management groups design considerations and recommendations](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

::: zone target="docs"

### Create a management structure

To create a management group, subscription, or resource group, sign in to the [Azure portal](https://portal.azure.com).

- To create a *management group* to help you manage multiple subscriptions, go to [Management groups](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade) and select **Create**.

- To create a *subscription* to associate users with resources, go to [Subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade) and select **Add**.

- To create a *resource group* to hold resources that share the same permissions and policies:

  1. Go to [Create a resource group](https://portal.azure.com/#create/Microsoft.ResourceGroup).
  1. In the **Create a resource group** form:
     1. For **Subscription**, select the subscription in which to create the resource group.
     1. For **Resource group**, enter a name for the new resource group.
     1. For **Region**, select a region in which to locate the resource group.
  1. Select **Review + create**, and after the review passes, select **Create**.

  > [!NOTE]
  > You can also create resources programmatically. For examples, see [Programmatically create Azure subscriptions](/azure/cost-management-billing/manage/programmatically-create-subscription) and [Create a management group with Azure PowerShell
](/azure/governance/management-groups/create-management-group-powershell) .


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

- Business details should include the organizational information required to identify teams. For example a business unit, such as `fin`, `mktg`, or `corp` might be used.
- Follow the guidance for [abbreviations for resource types](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations).
- Use a consistent naming convention for all resources. For example, use a prefix that identifies the subscription or resource group, workload type, the environment the resource is deploy in, and the Azure region.
- Operational details in resource names should include information that IT and workload teams need. Include details that identify the workload, application, environment, criticality, and other information that's useful for managing resources.

To learn more about naming Azure standards and recommendations, see [Develop your naming and tagging strategy for Azure resources](../azure-best-practices/naming-and-tagging.md).

::: zone target="docs"

> [!NOTE]
>
> - Avoid using special characters, such as hyphen and underscore (`-` and `_`), as the first or last characters in a name. Doing so can cause validation rules to fail.
> - Names of tags are case-insensitive.

::: zone-end

## Resource tags

Tags can quickly identify your resources and resource groups. You apply tags to your Azure resources to logically organize them by categories. Tags can include context about the resource's associated workload or application, operational requirements, and ownership information.

Each tag consists of a name and a value. For example, you can apply the name *environment* and the value *production* to all the resources in production.

After you apply tags, you can easily retrieve all the resources in your subscription that have that tag name and value. When you organize resources for billing or management, tags can help you retrieve related resources from different resource groups.

Other common uses for tags include:

- **Workload name:** Name of the workload that a resource supports.
- **Data classification:** Sensitivity of the data that a resource hosts.
- **Cost center:** The accounting cost center or team associated with the resource. In [Microsoft Cost Management](/azure/cost-management-billing/), you can apply your cost center tag as a filter to report charges based on usage by team or department.
- **Environment:** The environment in which the resource is deployed, such as, development, test, or production.

For more tagging recommendations and examples, see [Define your tagging strategy](../azure-best-practices/resource-tagging.md).

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

- [Management group design considerations and recommendations](../landing-zone/design-area/resource-org-management-groups.md)
- [Subscription considerations and recommendations](../landing-zone/design-area/resource-org-subscriptions.md)
- [Resource access management in Azure](../../get-started/how-azure-resource-manager-works.md)

For more information about resource naming and tagging, see:

- [Define your tagging strategy](../azure-best-practices/resource-tagging.md)
- [Use tags to organize your Azure resources and management hierarchy](/azure/azure-resource-manager/management/tag-resources)
