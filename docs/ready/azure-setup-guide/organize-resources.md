---
title: Organize your Azure resources effectively
description: Understand best practices for effectively organizing your Azure resources to simplify resource management.
author: laraaleite
ms.author: brblanch
ms.date: 10/05/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.localizationpriority: high
ms.custom: think-tank, fasttrack-edit, AQC, setup
---

<!-- cSpell:ignore profx fsubscriptions fresource -->

# Organize your Azure resources effectively

Organize your cloud-based resources to secure, manage, and track costs related to your workloads. To organize your resources, define a management group hierarchy, consider and follow a naming convention, and apply resource tagging.

<!-- markdownlint-disable MD024 -->

## Management levels and hierarchy

Azure provides four levels of management: management groups, subscriptions, resource groups, and resources. The following image shows the relationship between these levels.

![Diagram that shows the relationship of management hierarchy levels.](./media/organize-resources/scope-levels.png)

- **Management groups** help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions applied to the management group.
- **Subscriptions** logically associate user accounts with the resources they create. Each subscription has limits or quotas on the amount of resources it can create and use. Organizations can use subscriptions to manage costs and the resources created by users, teams, or projects.
- **Resource groups** are logical containers in which you can deploy and manage Azure resources like web apps, databases, and storage accounts.
- **Resources** are instances of services that you can create, like virtual machines (VMs), storage, or SQL databases.

### Management level settings scope

You can apply management settings like policies and Azure role-based access control (RBAC) at any management level. The management level determines how widely the setting is applied. Lower levels inherit settings from higher levels. For example, when you apply a policy to a subscription, the policy applies to all resource groups and resources in that subscription.

Usually, it makes sense to apply critical settings at higher levels, and project-specific requirements at lower levels. For example, to make sure all resources for your organization are deployed to certain regions, apply a policy to the subscription specifying the allowed locations. The allowed locations are automatically enforced as users in your organization add new resource groups and resources. Learn more about policies in the governance, security, and compliance section of this guide.

It's easy to manage a few subscriptions independently. If your number of subscriptions increases, consider creating a management group hierarchy to simplify subscription and resource management. For more information, see [Organize and manage your Azure subscriptions](../azure-best-practices/organize-subscriptions.md).

Work with people in the following roles to plan your organizational compliance strategy:

- Security and compliance
- IT administration
- Enterprise architecture
- Networking
- Finance
- Procurement

::: zone target="docs"

### Create a management structure

To create a management group, subscription, or resource group, sign in to the [Azure portal](https://portal.azure.com).

- To create a **management group** to help you manage multiple subscriptions, go to [Management groups](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade) and select **Create**.
  
- To create a **subscription** to associate users with resources, go to [Subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade) and select **Add**.
  > [!NOTE]
  > You can also create subscriptions programmatically. For more information, see [Programmatically create Azure subscriptions](/azure/cost-management-billing/manage/programmatically-create-subscription).
  
- To create a **resource group** to hold resources that share the same permissions and policies:
  1. Go to [Resource groups](https://portal.azure.com/#create/Microsoft.ResourceGroup).
  1. In the **Create a resource group** form:
     1. Select the **Subscription** to create the resource group under.
     1. Enter a name for the **Resource group**.
     1. Select a **Region** for the resource group location.
  1. Select **Review + create**, and if the review passes, select **Create**.

::: zone-end

::: zone target="chromeless"

### Actions

- To create a **management group** to help you manage multiple subscriptions, go to **Management groups** and select **Create**.

  ::: form action="OpenBlade[#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade]" submitText="Go to Management groups" :::

- To create another **subscription** to associate users with resources, go to **Subscriptions** and select **Add**.

  ::: form action="OpenBlade[#blade/Microsoft_Azure_Billing/SubscriptionsBlade]" submitText="Go to Subscriptions" :::

- To create a **resource group** to hold resources that share the same permissions and policies:
  1. Go to **Resource groups** and select **Create**.
  1. In the **Create a resource group** form:
     1. Select the **Subscription** to create the resource group under.
     1. Enter a name for the **Resource group**.
     1. Select a **Region** for the resource group location.
  1. Select **Review + create**, and if the review passes, select **Create**.

  ::: form action="Create[#create/Microsoft.ResourceGroup]" submitText="Create a resource group" :::

::: zone-end

## Naming standards

A good naming standard helps identify resources in the Azure portal, on a billing statement, and in automation scripts. Your naming strategy should include business and operational details in resource names.

- Business details should include the organizational information needed to identify teams. Use the resource name along with the business owners who are responsible for the resource costs.

- Operational details in resource names should include information that IT teams need. Include details that identify the workload, application, environment, criticality, and other information useful for managing resources.

Different resource types have different [naming rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules). For more information and recommendations that support enterprise cloud adoption efforts, see the Cloud Adoption Framework [guidance on naming and tagging](../azure-best-practices/naming-and-tagging.md).

The following table shows naming patterns for a few sample Azure resource types:

::: zone target="docs"

> [!NOTE]
> Avoid using special characters like `-` or `_` as the first or last characters in a name, which causes most validation rules to fail.

::: zone-end

| Entity | Scope | Length | Casing | Valid characters | Suggested pattern | Example |
| --- | --- | --- | --- | --- | --- | --- |
| Resource group | Subscription | 1-90 | Case insensitive | Alphanumeric, underscore, parentheses, hyphen, period except at end, and Unicode characters | `<service short name>-<environment>-rg` | `profx-prod-rg` |
| Availability set | Resource group | 1-80 | Case insensitive | Alphanumeric, underscore, and hyphen | `<service-short-name>-<context>-as` | `profx-SQL-as` |
| Tag | Associated entity | 512 (name), 256 (value) | Case insensitive | Alphanumeric | `"Key" : "value"` | `"Department" : "Central IT"` |

## Resource tags

Tags can quickly identify your resources and resource groups. You apply tags to your Azure resources to logically organize them by categories. Tags can include context about the resource's associated workload or application, operational requirements, and ownership information.

Each tag consists of a name and a value. For example, you can apply the name `environment` and the value `production` to all the resources in production.

After you apply tags, you can easily retrieve all the resources in your subscription that have that tag name and value. When you organize resources for billing or management, tags can help you retrieve related resources from different resource groups.

Other common uses for tags include:

- **Metadata and documentation:** Administrators can easily see detail about the resources they're working on by applying a tag like `ProjectOwner`.
- **Automation:** Regularly running scripts can take action based on a tag value like `ShutdownTime` or `DeprovisionDate`.
- **Cost optimization:** You can allocate resources to the teams and resources who are responsible for the cost. In Azure Cost Management + Billing, you can apply the cost center tag as a filter to report charges based on team or department usage.

Each resource or resource group can have a maximum of 50 tag name and value pairs. This limitation only applies to tags directly applied to the resource group or resource.

For more tagging recommendations and examples, see the Cloud Adoption Framework [Recommended naming and tagging conventions](../azure-best-practices/naming-and-tagging.md).

::: zone target="docs"

### Apply a resource tag

To apply a tag to a resource group:

1. Go to [Resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) and select a resource group.
1. Select **Tags** in the left navigation.
1. Enter a new name and value, or select an existing name and value, and then select **Apply**.

::: zone-end

::: zone target="chromeless"

### Action

**Apply a resource tag:**

To apply a tag to a resource group:

1. Go to **Resource groups** and select a resource group.
1. Select **Tags** in the left navigation.
1. Enter a new name and value, or select an existing name and value, and then select **Apply**.

::: form action="OpenBlade[#blade/HubsExtension/Resources/resourceType/Microsoft.Resources%2FSubscriptions%2FResourceGroups]" submitText="Go to resource groups" :::

::: zone-end
## Next steps

To learn more about management levels and organization, see:

- [Azure fundamentals](../considerations/fundamental-concepts.md)
- [Create your initial subscriptions](../azure-best-practices/initial-subscriptions.md)
- [Create additional Azure subscriptions to scale your Azure environment](../azure-best-practices/scale-subscriptions.md)
- [Organize and manage your Azure subscriptions](../azure-best-practices/organize-subscriptions.md)
- [Organize your resources with Azure management groups](/azure/governance/management-groups/overview)
- [Understand resource access management in Azure](../../govern/resource-consistency/resource-access-management.md)
- [Subscription service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits)

To learn more about resource naming and tagging, see"
- [Develop your naming and tagging strategy for Azure resources](../azure-best-practices/naming-and-tagging.md)
- [Use tags to organize your Azure resources](/azure/azure-resource-manager/management/tag-resources).

