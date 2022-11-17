---
title: Subscription decision guide
description: Learn about subscription design strategies and management group hierarchy to organize your Azure assets.
author: alexbuckgit
ms.author: martinek
ms.date: 10/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: decision-guide
ms.custom: internal
---

# Subscription decision guide

Effective subscription design helps organizations to establish a structure to organize and manage assets in Azure while migrating to the cloud. The purpose of this guide is to help you decide when to create more subscriptions, and also to help you expand the hierarchy of your management group to support your business priorities.

## Prerequisites

To start your adoption of Azure cloud:

- [Create your initial subscriptions](../../ready/azure-best-practices/initial-subscriptions.md).
- [Create more subscriptions](../../ready/azure-best-practices/scale-subscriptions.md) to scale your Azure environment.
- [Organize and manage multiple subscriptions](../../ready/azure-best-practices/organize-subscriptions.md) by using Azure management groups.

For an overview of these concepts, see [Azure fundamental concepts](../../ready/considerations/fundamental-concepts.md).

## Model your organization

Because every organization is different, Azure management groups are designed to be flexible. For example, you can model your cloud estate on your organization's hierarchy. This method helps you define and apply policies at higher levels of the hierarchy. You can then rely on inheritance to ensure that those policies are automatically applied to management groups that are lower in the hierarchy. Although you can move subscriptions from one management group to another, it's helpful to design an initial hierarchy for management groups that reflects your expected organizational needs.

Before completing your subscription design, consider how [resource consistency](../resource-consistency/index.md) might influence your design choices.

> [!NOTE]
> With an Azure Enterprise Agreement (EA), you can define another organizational hierarchy for billing purposes. This hierarchy is distinct from the hierarchy of your management groups, which focuses on providing an inheritance model for easily applying suitable policies and access control to your resources.

## Subscription design strategies

To address your business priorities, consider the following design strategies for your subscriptions:

- Workload separation
- Application category
- Functional role
- Business unit
- Geographic location

### Workload separation strategy

An organization often adds new workloads to the cloud. Varying ownership of subscriptions or basic separation of responsibilities might result in multiple subscriptions in both production and nonproduction management groups. This approach provides basic workload separation. However, it doesn't make good use of the inheritance model to automatically apply policies across a subset of your subscriptions.

:::image type="content" source="../../_images/ready/management-group-hierarchy-v2.png" alt-text="Diagram that shows the workload separation strategy.":::

### Application category strategy

As the size of their cloud footprint grows, organizations typically create more subscriptions to support more applications. These applications usually have fundamental differences in business criticality, compliance requirements, access controls, and data protection needs. These application categories depend on subscriptions that are typically built from the initial production and nonproduction subscriptions, and they're organized under either the production or nonproduction management group as applicable. These subscriptions are typically owned and administered by the operations staff of a central IT team.

:::image type="content" alt-text="Diagram that shows the application category strategy."source="../../_images/decision-guides/decision-guide-subscriptions-hierarchy.png" lightbox="../../_images/decision-guides/decision-guide-subscriptions-hierarchy.png":::

How organizations categorize their applications varies. Organizations often separate subscriptions based on specific applications or services, or by application archetypes. This categorization is designed to support workloads that are likely to consume most of the resource limits of a subscription. It might also separate mission-critical workloads to ensure that they don't compete with other workloads under these limits. Some workloads that might justify a separate subscription include:

- Mission-critical workloads.

- Applications that are part of cost of goods sold (COGS) within your company.

  For example, every widget that a company manufactures could contain an Azure IoT module that sends telemetry. To be part of the COGS, processing that telemetry might require a dedicated subscription for accounting or governance purposes.

- Applications that are subject to regulatory requirements, such as [HIPAA](https://www.hhs.gov/hipaa/index.html) or [FedRAMP](https://www.fedramp.gov/).

### Functional strategy

The *functional* strategy organizes subscriptions and accounts along functional lines, like finance, sales, or IT support. This organization strategy uses a management group hierarchy.

### Business unit strategy

The *business unit* strategy groups subscriptions and accounts based on profit and loss category, division, or a similar business structure by using a management group hierarchy.

### Geographic strategy

For organizations with global operations, the *geographic* strategy groups subscriptions and accounts based on geographic regions by using a management group hierarchy.

## Mixed subscription strategies

Management group hierarchies can be up to six levels deep. This depth gives you the flexibility to create a hierarchy that combines several design strategies to meet your organizational needs. For example, the following diagram shows an organizational hierarchy that combines a business unit strategy with a geographic strategy.

:::image type="content" alt-text="Diagram that shows the mixed subscription strategy." source="../../_images/decision-guides/decision-guide-subscriptions-hierarchy-mixed.png" lightbox="../../_images/decision-guides/decision-guide-subscriptions-hierarchy-mixed.png":::

## Related resources

- [Resource access management in Azure](../../govern/resource-consistency/resource-access-management.md)
- [Governance guide for complex enterprises: Multiple layers of governance](../../govern/guides/complex/multiple-layers-of-governance.md)
- [Azure regions decision guide](../../migrate/azure-best-practices/multiple-regions.md)

## Next steps

Subscription design is just one infrastructure component that requires architectural decisions during cloud adoption. To learn about other strategies to use when designing other types of infrastructure, see the overview in the architectural decision guides.

> [!div class="nextstepaction"]
> [Architectural decision guides](../index.md)
