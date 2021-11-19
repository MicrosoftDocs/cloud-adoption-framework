---
title: Enterprise-scale landing zone design principles
description: Learn about Enterprise-scale landing zone design principles which influence the design areas for enterprise-scale landing zone implementations
author: jtracey93
ms.author: jatracey
ms.date: 11/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Enterprise-scale landing zone design principles

The Azure landing zone conceptual architecture prescribed in this guidance are universally applied to any Azure landing zone process or implementation. However, if you choose to deploy the Azure Landing Zone Accelerator or use any version of the Enterprise-scale landing zone code base, those implementations build on the conceptual architecture by applying the design principles described here. These principles serve as a compass for subsequent design decisions across critical technical domains. Familiarize yourself with these principles to better understand their impact and the trade-offs associated with deviation.

Decisions you made during review of each design area made need to be adjusted slightly to adhere to these design principles. Each design principle includes one or more example of how that principle could impact your design area decisions.

## Design Principles

### Subscription democratization

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities to support business areas and portfolio owners to accelerate application migrations and new application development. Subscriptions should be provided to business units to support the design, development, and testing of new workloads and migration of workloads. 

Together alongside a suitable [Management Group hierarchy](./../landing-zone/design-area/resource-org-management-groups.md) subscription can be managed and organized efficiently to enable the organization to operate effectively at scale.

### Policy-driven governance

Azure Policy should be used to provide guardrails and ensure continued compliance with your organization's platform, along with the applications deployed onto it. Azure Policy also provides application owners with sufficient freedom and a secure unhindered path to the cloud.

### Single control and management plane

The Azure landing zone conceptual architecture shouldn't consider any abstraction layers, such as customer-developed portals or tooling. It should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels subject to role-based access and policy-driven controls. Azure can be used to establish a standardized set of policies and controls for governing the entire enterprise estate.

### Application-centric and archetype-neutral

The Azure landing zone conceptual architecture should focus on application-centric migrations and development rather than pure infrastructure lift-and-shift migrations, such as moving virtual machines. It shouldn't differentiate between old and new applications, infrastructure as a service, or platform as a service applications. Ultimately, it should provide a safe and secure foundation for all application types to be deployed onto your Azure platform.

### Align Azure-native design and roadmaps

The Azure landing zone conceptual architecture approach advocates using Azure-native platform services and capabilities whenever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help to inform the migration strategy and The Azure landing zone conceptual trajectory.

## Impact on design deviations

Organizational requirements may dictate specific outcomes or approaches to how an Azure environment is designed, these requirements may lead to your deviating from the principles outlined above

By choosing to deviate from the design principles organizations should consider the trade offs outlined below.

Be prepared to balance requirements and functionality because your journey to the Azure Landing Zone conceptual architecture will evolve over time as requirements change and your learn from your implementation. It is unlikely that everything will be required on day one so use the design principals as a compass for your Azure Landing Zones journey.

For example, utilizing preview services and taking dependencies on service roadmaps can remove technical blockers during adoption.


| Design Principle | Impacts | 
| --------------- | ------- |
| Subscription Democratization | - This principle suggests production operations transitioned to the business units & workload teams.<br> - This allows workload owners to have more control and autonomy of their workloads within the guardrails established by platform foundation. <br>- Customers who require central operations and do not wish to delegate control of production environments to workload teams or business units, may need to make modifications to their [resource organization](./../landing-zone/design-area/resource-org.md) design to deviate from this principle.<br> - This design principle also assumes a specific management group and subscription hierarchy for all operations management subscriptions which may not align with your operating model. <br> - However, as your organization grows and evolves your operational model may change which can led to a migration of resources into separate subscriptions again which can lead to complicated technical migrations. Review the [Align](../../ready/enterprise-scale/transition.md) guidance before committing to an approach. | 
| Policy-driven governance | - By not utilizing Azure Policies to create guardrails within your environment you increase the operation and management overhead of maintaining compliance. <br> - Azure Policies help you to restrict and automate your desired compliance state within your environment.  |
| Single control and management plane | - Choosing a multi-vendor approach to operate control and management planes may introduce complexity of integration and feature support.<br> - Replacing individual components to achieve "best of breed" or multi-vendor operations tooling may have limitation & could cause unintended errors due to inherent dependencies. <br> - For customers who are bringing an existing tooling investment to operations, security, or governance, a review of the Azure services is suggested.   |
| Application-centric and archetype-neutral | - By segmenting your workloads following an organizational structure in your management group hierarchy, you can create a complex policy and access control structure to govern your environment.<br> - This trade off introduces the risk of unintentional policy duplication and thereby exceptions which add to operational and management overheads.<br> - You can read more on this in the FAQ question here: [How do we handle "dev/test/production" workload landing zones in enterprise-scale architecture?](../../ready/enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-enterprise-scale-architecture) | 
| Align Azure-native design and roadmaps | - Similar to "Single control and management plane", by introducing third-party solutions into your Azure environment you create a dependency upon that solutions to provide feature support and integration with Azure first party services. <br> - We recognize that many organizations will choose to bring existing third-party solution investments into their environment so considering this principle and it's trade offs carefully is advised in alignment with your requirements. |
