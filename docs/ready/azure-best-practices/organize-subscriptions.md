---
title: Organize and manage multiple Azure subscriptions
description: Use the Cloud Adoption Framework for Azure to learn about creating a management group hierarchy to simplify managing your subscriptions and resources.
author: alexbuckgit
ms.author: abuck
ms.date: 09/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Organize and manage multiple Azure subscriptions

If you have only a few subscriptions, then managing them independently is relatively simple. But what if you have many subscriptions? Then you can create a management group hierarchy to help manage your subscriptions and resources.

## Azure management groups

Azure management groups help you efficiently manage access, policies, and compliance for your subscriptions. Each management group is a container for one or more subscriptions.

Management groups are arranged in a single hierarchy. You define this hierarchy in your Azure Active Directory (Azure AD) tenant to align with your organization's structure and needs. The top level is called the *root management group*. You can define up to six levels of management groups in your hierarchy. Each subscription is contained by only one management group.

Azure provides four levels of management scope:

- Management groups
- Subscriptions
- Resource groups
- Resources

Any access or policy that's applied at one level in the hierarchy is inherited by the levels below it. A resource owner or subscription owner can't alter an inherited policy. This limitation helps improve governance.

> [!NOTE]
> Tag inheritance isn't yet supported, but it'll be available soon.

This inheritance model lets you arrange the subscriptions in your hierarchy so that each subscription follows appropriate policies and security controls.

:::image type="content" source="../azure-setup-guide/media/organize-resources/scope-levels.png" alt-text="Diagram that shows the four scope levels for organizing your Azure resources.":::
*Figure 1: The four scope levels for organizing your Azure resources.*

Any access or policy assignment on the root management group applies to all resources in the directory. Carefully consider which items you define at this scope. Include only the assignments you must have.

## Create your management group hierarchy

When you define your management group hierarchy, first create the root management group. Then move all existing subscriptions in the directory into the root management group. New subscriptions are always created in the root management group. Later, you can move them to another management group.

What happens when you move a subscription to an existing management group? The subscription inherits the policies and role assignments from the management group hierarchy above it. Establish multiple subscriptions for your Azure workloads. Then create other subscriptions to contain Azure services that other subscriptions share.

Do you expect your Azure environment to grow? Then create management groups for production and nonproduction now, and apply appropriate policies and access controls at the management group level. New subscriptions will inherit the appropriate controls as they're added to each management group.

:::image type="content" source="../../_images/ready/management-group-hierarchy-v2.png" alt-text="Diagram that shows an example of a management group hierarchy.":::
*Figure 2: An example of a management group hierarchy.*

## Example use cases

Some basic examples of using management groups to separate different workloads include:

**Production versus nonproduction workloads:** Use management groups to more easily manage different roles and policies between production and nonproduction subscriptions. For example, developers might have contributor access in nonproduction subscriptions, but only reader access in production subscriptions.

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
