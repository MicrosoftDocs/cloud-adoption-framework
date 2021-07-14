---
title: Organize and manage multiple Azure subscriptions
description: Use the Cloud Adoption Framework for Azure to learn about creating a management group hierarchy to simplify managing your subscriptions and resources.
author: alexbuckgit
ms.author: abuck
ms.date: 05/20/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Organize and manage multiple Azure subscriptions

If you have only a few subscriptions, then managing them independently is relatively simple. However, if you have many subscriptions, create a management group hierarchy to help manage your subscriptions and resources.

## Azure management groups

Azure management groups help you efficiently manage access, policies, and compliance for your subscriptions. Each management group is a container for one or more subscriptions.

Management groups are arranged in a single hierarchy. You define this hierarchy in your Azure Active Directory (Azure AD) tenant to align with your organization's structure and needs. The top level is called the *root management group*. You can define up to six levels of management groups in your hierarchy. Each subscription is contained by only one management group.

Azure provides four levels of management scope:

- Management groups
- Subscriptions
- Resource groups
- Resources

Any access or policy applied at one level in the hierarchy is inherited by the levels below it. A resource owner or subscription owner can't alter an inherited policy. This limitation helps improve governance.

> [!NOTE]
> Tag inheritance is not yet supported but will be available soon.

This inheritance model lets you arrange the subscriptions in your hierarchy so that each subscription follows appropriate policies and security controls.

![The four scope levels for organizing your Azure resources](../azure-setup-guide/media/organize-resources/scope-levels.png)
*Figure 1: The four scope levels for organizing your Azure resources.*

Any access or policy assignment on the root management group applies to all resources in the directory. Carefully consider which items you define at this scope. Include only the assignments you must have.

## Create your management group hierarchy

When you define your management group hierarchy, first create the root management group. Then move all existing subscriptions in the directory into the root management group. New subscriptions are always created in the root management group. Later, you can move them to another management group.

When you move a subscription to an existing management group, it inherits the policies and role assignments from the management group hierarchy above it. Once you have established multiple subscriptions for your Azure workloads, you can create additional subscriptions to contain Azure services that other subscriptions share.

If you expect your Azure environment to grow, you should create management groups for production and nonproduction now, and apply appropriate policies and access controls at the management group level. New subscriptions will inherit the appropriate controls as they're added to each management group.

![Example of a management group hierarchy](../../_images/ready/management-group-hierarchy-v2.png)
*Figure 2: An example of a management group hierarchy.*

## Example use cases

Some basic examples of using management groups to separate different workloads include:

**Production versus nonproduction workloads:** Use management groups to more easily manage different roles and policies between production and nonproduction subscriptions. For example, developers might have contributor access in nonproduction subscriptions but only reader access in production subscriptions.

**Internal services versus external services:** Enterprises often have different requirements, policies, and roles for internal services versus external customer-facing services.

## Related resources

Review the following resources to learn more about organizing and managing your Azure resources.

- [Organize your resources with Azure management groups](/azure/governance/management-groups/)
- [Elevate access to manage all Azure subscriptions and management groups](/azure/role-based-access-control/elevate-access-global-admin)
- [Move Azure resources to another resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription)

## Next steps

Review [recommended naming and tagging conventions](./naming-and-tagging.md) to follow when deploying your Azure resources.

> [!div class="nextstepaction"]
> [Recommended naming and tagging conventions](./naming-and-tagging.md)
