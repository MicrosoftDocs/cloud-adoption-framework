---
title: Azure landing zone design principles
description: Learn about the design principles that influence the design areas for enterprise-scale landing zone implementations
author: jtracey93
ms.author: jatracey
ms.date: 11/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Azure landing zone - design principles

The Azure landing zone conceptual architecture is universally applied to any Azure landing zone process or implementation. At the foundation of the architecture is a set of core design principles that serve as a compass for subsequent design decisions across critical technical domains. If you choose to deploy an implementation that's an Azure Landing Zone Accelerator or any version of the Enterprise-scale landing zone code base, build on the architecture by applying the design principles described here. 

Familiarize yourself with these principles to better understand their impact and the trade-offs associated with deviation. Decisions made during the review of each design area may need to be adjusted slightly to adhere to these design principles. Each design principle includes one or more examples of how that principle could impact your design area decisions.

> [!IMPORTANT]
> **Impact of design deviations** 
> There might be valid reasons to deviate from the principles. For example, organizational requirements might dictate specific outcomes or approaches to how an Azure environment is designed. In such cases, it's important to understand the impact the deviation will have on the design and future operations. Carefully consider the trade offs outlined for each principle.

As a general rule, be prepared to balance requirements and functionality because your journey to the  conceptual architecture will evolve over time as requirements change and you learn from your implementation. For example, utilizing preview services and taking dependencies on service roadmaps can remove technical blockers during adoption.

### Subscription democratization

Utlilize subscriptions as a unit of management and scale to accelerate application migrations and new application development. Align subscriptions with business needs and priorities to support business areas and portfolio owners. Subscriptions should be provided to business units to support the design, development, and testing of new workloads and migration of existing workloads. 

To enable the organization to operate effectively at scale, support a subscription with suitable [Management Group hierarchy](./../landing-zone/design-area/resource-org-management-groups.md). This will allow the subscription to be managed and organized efficiently.

#### Impact of design deviations
- One approach for implementing this principle is to transition operations to business units and workload teams. This allows workload owners to have more control and autonomy of their workloads within the guardrails established by platform foundation. Customers who require central operations and do not wish to delegate control of production environments to workload teams or business units, might need to make modifications to their [resource organization](./../landing-zone/design-area/resource-org.md) design to deviate from this principle.
- This assumes a specific management group and subscription hierarchy for all operations management subscriptions, which might not align with your operating model. However, as your organization grows and evolves, your operational model might change, which can lead to a migration of resources into separate subscriptions again, which can lead to complicated technical migrations. Review the [Align](../../ready/enterprise-scale/transition.md) guidance before committing to an approach.

### Policy-driven governance

Use Azure Policy to provide guardrails and ensure continued compliance with your organization's platform and the applications deployed onto it. Azure Policy also provides application owners with independence and a secure, unhindered path to the cloud.

### Single control and management plane

Avoid dependency on abstraction layers, such as customer-developed portals or tooling. Having a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams) is highly recommended. Azure provides a unified and consistent control plane, across all Azure resources and provisioning channels, which is subject to role-based access and policy-driven controls. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

### Application-centric and archetype-neutral

Focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. The design choices shouldn't differentiate between old and new applications, infrastructure as a service (IaaS), or platform as a service (PaaS) applications. Strive to provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

### Align Azure-native design and roadmaps

Leverage Azure-native platform services and capabilities whenever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and The Azure landing zone conceptual trajectory.

## Impact of design deviations
You might identify valid reasons why you need to deviate from the principles outlined above. It's important to first understand the impact that this will have on the design and future operations.

For example, organizational requirements might dictate specific outcomes or approaches to how an Azure environment is designed.

By choosing to deviate from the design principles, organizations should consider the trade offs outlined below.

Be prepared to balance requirements and functionality because your journey to the Azure Landing Zone conceptual architecture will evolve over time as requirements change and you learn from your implementation. It is unlikely that everything will be required on day one so use the design principals as a compass for your Azure Landing Zones journey.

For example, utilizing preview services and taking dependencies on service roadmaps can remove technical blockers during adoption.

| Design Principle | Impacts | 
| --------------- | ------- |
| Subscription Democratization | - This principle suggests production operations transitioned to the business units and workload teams.<br> - This allows workload owners to have more control and autonomy of their workloads within the guardrails established by platform foundation. <br>- Customers who require central operations and do not wish to delegate control of production environments to workload teams or business units, might need to make modifications to their [resource organization](./../landing-zone/design-area/resource-org.md) design to deviate from this principle.<br> - This design principle also assumes a specific management group and subscription hierarchy for all operations management subscriptions, which might not align with your operating model. <br> - However, as your organization grows and evolves, your operational model might change, which can lead to a migration of resources into separate subscriptions again, which can lead to complicated technical migrations. Review the [Align](../../ready/enterprise-scale/transition.md) guidance before committing to an approach. | 
| Policy-driven governance | - By not utilizing Azure Policies to create guardrails within your environment you increase the operation and management overhead of maintaining compliance. <br> - Azure Policies help you to restrict and automate your desired compliance state within your environment. <br> - As part of your design considerations you should review [how Azure Policy can be used inside a landing zone implementation](../../ready/enterprise-scale/dine-guidance.md) |
| Single control and management plane | - Choosing a multi-vendor approach to operate control and management planes might introduce complexity of integration and feature support.<br> - Replacing individual components to achieve "best of breed" or multi-vendor operations tooling might have limitations and could cause unintended errors due to inherent dependencies. <br> - For customers who are bringing an existing tooling investment to operations, security, or governance, a review of the Azure services and any dependencies is recommended.   |
| Application-centric and archetype-neutral | - By segmenting your workloads following a structure that differs from the example shown in the conceptual architecture in your management group hierarchy (such as an organizational hierarchy structure or grouping by Azure service), you can create a complex policy and access control structure to govern your environment.<br> - This trade off introduces the risk of unintentional policy duplication and thereby exceptions, which add to operational and management overheads.<br> - Dev/Test/Production is another common approach considered by customers, you can read more on this in the FAQ question here: [How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture?](../../ready/enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture) | 
| Align Azure-native design and roadmaps | - Similar to "Single control and management plane", by introducing third-party solutions into your Azure environment, you create a dependency upon that solution to provide feature support and integration with Azure first party services. <br> - We recognize that many organizations will choose to bring existing third-party solution investments into their environment so consider this principle and its tradeoffs carefully is advised in alignment with your requirements. |