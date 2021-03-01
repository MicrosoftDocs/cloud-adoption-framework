---
title: Create additional subscriptions to scale your Azure environment
description: Use the Cloud Adoption Framework for Azure to learn how to develop a strategy for scaling your environment using multiple Azure subscriptions.
author: alexbuckgit
ms.author: abuck
ms.date: 05/20/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Create additional subscriptions to scale your Azure environment

Organizations often use multiple Azure subscriptions to avoid per-subscription resource limits and to better manage and govern their Azure resources. It's important to define a strategy for scaling your subscriptions.

## Review fundamental concepts

As you expand your Azure environment beyond your [initial subscriptions](./initial-subscriptions.md), it's important to understand Azure concepts such as accounts, tenants, directories, and subscriptions. For more information, see [Azure fundamental concepts](../considerations/fundamental-concepts.md).

Other considerations might necessitate additional subscriptions. Keep the following in mind as you expand your cloud estate.

## Technical considerations

**Subscription limits:** Subscriptions have defined limits for some resource types. For example, the number of virtual networks in a subscription is limited. When a subscription approaches these limits, you'll need to create another subscription and put additional resources there. For more information, see [Azure subscription and service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#general-limits).

**Classic model resources:** If you've been using Azure for a long time, you may have resources that were created using the classic deployment model. Azure policies, Azure role-based access control, resource grouping, and tags cannot be applied to classic model resources. You should move these resources into subscriptions that contain only classic model resources.

**Costs:** There might be some additional costs for data ingress and egress between subscriptions.

## Business priorities

Your business priorities might lead you to create additional subscriptions. These priorities include:

- Innovation
- Migration
- Cost
- Operations
- Security
- Governance

For other considerations about scaling your subscriptions, review the [subscription decision guide](../../decision-guides/subscriptions/index.md) in the Cloud Adoption Framework.

## Moving resources between subscriptions

As your subscription model grows, you might decide that some resources belong in other subscriptions. Many types of resources can be moved between subscriptions. You can also use automated deployments to re-create resources in another subscription. For more information, see [Move Azure resources to another resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription).

## Tips for creating new subscriptions

- Identify who is responsible for creating new subscriptions.
- Decide which resource types are available in a subscription by default.
- Decide what all standard subscriptions should look like. Considerations include Azure RBAC access, policies, tags, and infrastructure resources.
- If possible, [programmatically create new subscriptions](/azure/cost-management-billing/manage/programmatically-create-subscription) via a service principal. You must [grant permission to the service principal](/azure/cost-management-billing/manage/grant-access-to-create-subscription) to create subscriptions. Define a security group that can request new subscriptions via an automated workflow.
- If you're an Enterprise Agreement (EA) customer, ask Azure support to block creation of non-EA subscriptions for your organization.

## Next steps

Create a management group hierarchy to help [organize and manage your subscriptions and resources](./organize-subscriptions.md).

> [!div class="nextstepaction"]
> [Organize and manage your subscriptions and resources](./organize-subscriptions.md)
