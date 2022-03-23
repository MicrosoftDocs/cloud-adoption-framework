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

The Azure landing zone conceptual architecture is universally applied to any Azure landing zone process or implementation. At the foundation of the architecture is a set of core design principles that serve as a compass for subsequent design decisions across critical technical domains. The principles are intentionally aspirational to help you strive for an optimum design of the target architecture. If you choose to deploy an implementation that's an Azure landing zone Accelerator or any version of the enterprise-scale landing zone code base, build on the architecture by applying the design principles described here. 

Decisions made during the review of each design area may need to be adjusted slightly to adhere to these design principles. Each design principle includes one or more examples of how that principle could impact your design area decisions.

> [!IMPORTANT] 
> **Impact of design deviations** 
>
> There might be valid reasons to deviate from the principles. For example, organizational requirements might dictate specific outcomes or approaches to how an Azure environment is designed. In such cases, it's important to understand the impact the deviation will have on the design and future operations. Carefully consider the trade offs outlined for each principle.

Familiarize yourself with these principles to better understand their impact and the trade-offs associated with deviation.

As a general rule, be prepared to balance requirements and functionality because your journey to the  conceptual architecture will evolve over time as requirements change and you learn from your implementation. For example, utilizing preview services and taking dependencies on service roadmaps can remove technical blockers during adoption.

## Subscription democratization

Utilize subscriptions as a unit of management and scale to accelerate application migrations and new application development. Align subscriptions with business needs and priorities to support business areas and portfolio owners. Subscriptions should be provided to business units to support the design, development, and testing of new workloads and migration of existing workloads. 

To enable the organization to operate effectively at scale, support a subscription with suitable [Management Group hierarchy](./../landing-zone/design-area/resource-org-management-groups.md). This will allow the subscription to be managed and organized efficiently.

#### Impact of deviation
- **Decentralized operations**&mdash;One approach for implementing this principle is to transition operations to business units and workload teams. This allows workload owners to have more control and autonomy of their workloads within the guardrails established by platform foundation. Customers who require central operations and don't want to delegate control of production environments to workload teams or business units, might need to make modifications to their [resource organization](./../landing-zone/design-area/resource-org.md) design to deviate from this principle.
- **Misalignment with the operating model**&mdash;This assumes a specific management group and subscription hierarchy for all operations management subscriptions, which might not align with your operating model. However, as your organization grows and evolves, your operational model might change, which can lead to a migration of resources into separate subscriptions again, which can lead to complicated technical migrations. Review the [Align](../../ready/enterprise-scale/transition.md) guidance before committing to an approach.

## Policy-driven governance

Use Azure Policy to provide guardrails and ensure continued compliance with your organization's platform and the applications deployed onto it. Azure Policy also provides application owners with independence and a secure, unhindered path to the cloud.

#### Impact of deviation

**Increase the operation and management overhead**&mdash;By not utilizing Azure Policies to create guardrails within your environment you increase the operation and management overhead of maintaining compliance. Azure Policies help you to restrict and automate your desired compliance state within your environment. 

As part of your design considerations, review [how Azure Policy can be used inside a landing zone implementation](../../ready/enterprise-scale/dine-guidance.md). 

## Single control and management plane

Avoid dependency on abstraction layers, such as customer-developed portals or tooling. Having a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams) is highly recommended. Azure provides a unified and consistent control plane which is subject to role-based access and policy-driven controls. This applies across all Azure resources and provisioning channels. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

#### Impact of deviation

**Increased complexity of integration**&mdash;Choosing a multi-vendor approach to operate control and management planes might introduce complexity of integration and feature support. Replacing individual components to achieve a "best of breed" design or multi-vendor operations tooling might have limitations and could cause unintended errors due to inherent dependencies. 

For customers who are bringing an existing tooling investment to operations, security, or governance, a review of the Azure services and any dependencies is recommended.


## Application-centric and archetype-neutral

Focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. The design choices shouldn't differentiate between old and new applications, infrastructure as a service (IaaS), or platform as a service (PaaS) applications. Strive to provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

#### Impact of deviation

- **Increased complexity in governance policies**&mdash;Segmenting workloads in a way that differs from the [implementation options](implementation-options.md) for management group hierarchy, can create a complex policy and access control structure to govern your environment. For example deviation from the organizational hierarchy structure or grouping by Azure service.

- **Increased operational overhead**&mdash;This trade off introduces the risk of unintentional policy duplication and thereby exceptions, which add to operational and management overheads.

Dev/Test/Production is another common approach considered by customers, you can read more on this in the FAQ question here: [How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture?](../../ready/enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture).


## Align with Azure-native design and roadmaps

Leverage Azure-native platform services and capabilities whenever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and the Azure landing zone conceptual trajectory.

#### Impact of deviation

**Increased complexity in integration**&mdash;Introducing third-party solutions into your Azure environment, can create a dependency upon that solution to provide feature support and integration with Azure first party services. 

Sometimes bringing existing third-party solution investments into an environment is inevitable. Consider this principle and its tradeoffs carefully in alignment with your requirements. 

## Next steps

Organizations may be at different stages of their cloud journey when reviewing this guidance. As a result, the actions and recommendations required to progress toward the outcome detailed above may vary. To understand best next actions in relation to where you are in your cloud adoption, review the journey to the target architecture content.

> [!div class="nextstepaction"]
> [Journey to the target architecture](./landing-zone-journey.md)

When you're choosing the right Azure landing zone implementation option, you should understand the [Azure landing zone design areas](./design-areas.md).

> [!div class="nextstepaction"]
> [Review design areas](./design-areas.md)
