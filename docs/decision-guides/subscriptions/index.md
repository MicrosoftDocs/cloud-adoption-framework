---
title: Subscription decision guide
description: Learn about subscription design strategies and management group hierarchy to organize your Azure assets.
author: alexbuckgit
ms.author: abuck
ms.date: 10/12/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Subscription decision guide

Effective subscription design helps organizations establish a structure to organize and manage assets in Azure during cloud adoption. This guide will help you decide when to create more subscriptions. It will also help you expand your management group hierarchy to support your business priorities.

## Prerequisites

To start your Azure adoption:

- [Create your initial subscriptions](../../ready/azure-best-practices/initial-subscriptions.md).
- [Create more subscriptions](../../ready/azure-best-practices/scale-subscriptions.md) to scale your Azure environment.
- [Organize and manage your subscriptions](../../ready/azure-best-practices/organize-subscriptions.md) using Azure management groups.

For an overview of these concepts, see [Azure fundamental concepts](../../ready/considerations/fundamental-concepts.md).

## Model your organization

Because every organization is different, Azure management groups are designed to be flexible. For example, you can model your cloud estate to reflect your organization's hierarchy. This method helps you define and apply policies at higher levels of the hierarchy. You can then rely on inheritance to ensure that those policies are automatically applied to management groups lower in the hierarchy. Although subscriptions can be moved between different management groups, it's helpful to design an initial management group hierarchy that reflects your expected organizational needs.

Before completing your subscription design, also consider how [resource consistency](../resource-consistency/index.md) considerations might influence your design choices.

> [!NOTE]
> With an Azure Enterprise Agreement (EA), you can define another organizational hierarchy for billing purposes. This hierarchy is distinct from your management group hierarchy, which focuses on providing an inheritance model for easily applying suitable policies and access control to your resources.

## Subscription design strategies

Consider the following subscription design strategies to address your business priorities.

### Workload separation strategy

An organization often adds new workloads to the cloud. Different ownership of subscriptions or basic separation of responsibility might result in multiple subscriptions in both the production and nonproduction management groups. This approach provides basic workload separation. But it doesn't take good advantage of the inheritance model to automatically apply policies across a subset of your subscriptions.

:::image type="content" source="../../_images/ready/management-group-hierarchy-v2.png" alt-text="Diagram that shows the workload separation strategy.":::

### Application category strategy

As an organization's cloud footprint grows, more subscriptions are typically created to support applications. These applications have fundamental differences in business criticality, compliance requirements, access controls, or data protection needs. Built from the initial production and nonproduction subscriptions, the subscriptions that support these application categories are organized under either the production or nonproduction management group as applicable. These subscriptions are typically owned and administered by the operations staff of a central IT team.

:::image type="content" source="../../_images/decision-guides/decision-guide-subscriptions-hierarchy.png" alt-text="Diagram that shows the application category strategy.":::

Each organization categorizes their applications differently. They often separate subscriptions based on specific applications or services, or by application archetypes. This categorization is designed to support workloads that are likely to consume most of the resource limits of a subscription. It might also separate mission-critical workloads to ensure they don't compete with other workloads under these limits. Some workloads that might justify a separate subscription include:

- Mission-critical workloads.
- Applications that are part of cost of goods sold (COGS) within your company. For example, every widget manufactured by a company contains an Azure IoT module that sends telemetry. This process might require a dedicated subscription for accounting or governance purposes to be part of COGS.
- Applications subject to regulatory requirements like the Health Insurance Portability and Accountability Act of 1996 (HIPAA) or the Federal Risk and Authorization Management Program (FedRAMP).

### Functional strategy

The functional strategy organizes subscriptions and accounts along functional lines like finance, sales, or IT support. This organization is done by using a management group hierarchy.

### Business unit strategy

The business unit strategy groups subscriptions and accounts based on profit and loss category, division, or a similar business structure by using a management group hierarchy.

### Geographic strategy

For organizations with global operations, the geographic strategy groups subscriptions and accounts based on geographic regions using a management group hierarchy.

## Mix subscription strategies

Management group hierarchies can be up to six levels deep. This depth gives you the flexibility to create a hierarchy that combines several of these strategies to meet your organizational needs. For example, the following diagram shows an organizational hierarchy that combines a business unit strategy with a geographic strategy.

:::image type="content" source="../../_images/decision-guides/decision-guide-subscriptions-hierarchy-mixed.png" alt-text="Diagram that shows the mixed subscription strategy.":::

## Related resources

- [Resource access management in Azure](../../govern/resource-consistency/resource-access-management.md)
- [Multiple layers of governance in large enterprises](../../govern/guides/complex/multiple-layers-of-governance.md)
- [Multiple geographic regions](../../migrate/azure-best-practices/multiple-regions.md)

## Next steps

Subscription design is just one infrastructure component that requires architectural decisions during cloud adoption. Visit the architectural decision guides overview to learn about other strategies used when making design decisions for other types of infrastructure.

> [!div class="nextstepaction"]
> [Architectural decision guides](../index.md)
