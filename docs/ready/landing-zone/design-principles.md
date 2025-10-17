---
title: Azure landing zone design principles
description: Learn about the design principles that influence the design areas for enterprise-scale landing zone implementations.
author: jtracey93
ms.author: jatracey
ms.date: 09/03/2025
ms.topic: conceptual
ms.custom: think-tank
---

# Azure landing zone design principles

The Azure landing zone conceptual architecture universally applies to any Azure landing zone process or implementation. At the foundation of the architecture, a set of core design principles serve as a compass for subsequent design decisions across critical technical domains.

The principles are intentionally aspirational, to help you strive for an optimum design of the target architecture. If you choose to deploy an implementation that's an Azure landing zone accelerator, or any version of the enterprise-scale landing zone code base, build on the architecture by applying the design principles this article describes.

Use these principles in your implementation as a useful guide to realize the benefits of cloud technologies. This cloud-oriented or *cloud native* approach represents ways of working and technical options for your organization that legacy technology approaches don't typically offer.

Familiarize yourself with these principles to better understand their impact and the tradeoffs associated with deviation.

## Impact of design deviations

There might be valid reasons to deviate from the design principles. For example, organizational requirements might dictate specific outcomes or approaches for designing an Azure environment. In such cases, it's important to understand the impact the deviation has on the design and future operations. Carefully consider the tradeoffs each principle outlines.

As a general rule, be prepared to balance requirements and functionality. Your journey to a conceptual architecture evolves over time as requirements change, and you learn from your implementation. For example, using preview services and depending on service roadmaps can remove technical blockers during adoption.

## Subscription democratization

Subscription democratization provides a scalable way to accelerate application migrations and new application development. This approach enables workload teams to access and manage Azure subscriptions independently, while staying within platform governance and operational guardrails.

1. **Use subscriptions as units of management.** Subscriptions represent the foundational boundary for organizing and managing Azure resources. Assign subscriptions to business units to support the design, development, testing, and migration of workloads. This alignment with business needs and priorities empowers portfolio owners and workload teams to deliver value faster.

2. **Use subscriptions to separate application environments.** Subscriptions should also be used to control and segregate environments across the software development lifecycle (SDLC), such as development, testing, and production. This separation improves governance, reduces risk, and supports consistent workload management. Follow the guidance in [manage application development environments in Azure landing zones](./../landing-zone/design-area/management-application-environments.md).

3. **Enable a self-service subscription vending process.** Establish a process that allows application and service teams to request and receive subscriptions with minimal friction. A self-service or near self-service model reduces delays caused by manual approvals and complex business sign-offs. Follow the guidance in [subscription vending](./../landing-zone/design-area/subscription-vending.md) to streamline provisioning and accelerate innovation. 

4. **Offer multiple subscription types to support differing requirements.** Provide a range of subscription product lines tailored to different workload scenarios. This flexibility allows teams to choose the most appropriate subscription type for their needs. Refer to [establish common subscription vending product lines](./../landing-zone/design-area/subscription-vending-product-lines.md).

5. **Support subscriptions with a scalable management group hierarchy.** Use a well-defined [Management Group hierarchy](./../landing-zone/design-area/resource-org-management-groups.md) to operate, govern, and secure subscriptions effectively at scale. This hierarchy enables centralized policy enforcement and efficient multi-subscription organization. Follow the [Azure landing zone recommended hierarchy](./../landing-zone/design-area/resource-org-management-groups.md#management-groups-in-the-azure-landing-zone-architecture) and [subscription design considerations and recommendations](./../landing-zone/design-area/resource-org-subscriptions.md) to ensure consistency.

> [!TIP]
> For more information about subscription democratization, see the recent YouTube video [Azure Landing Zones - How many subscriptions should I use in Azure?](https://youtu.be/R-5oeguxFpo)

### Impact of deviation

- [Shared-management vs. centralized operations](../../plan/prepare-organization-for-cloud.md#choose-a-cloud-operating-model). One way to implement this principle transitions operations to business units and workload teams. This reassignment lets workload owners have more control and autonomy over their workloads, within the guardrails of the platform foundation. Organizations that require central operations might not want to delegate control of production environments to workload teams or business units. These organizations might need to modify their [resource organization](./../landing-zone/design-area/resource-org.md) design to deviate from this principle.

- **Operating model misalignment.** Azure landing zone conceptual architecture design assumes a specific management group and subscription hierarchy for all operations management subscriptions. This hierarchy might not align with your [operations approach](../../plan/prepare-organization-for-cloud.md#choose-a-cloud-operating-model). As your organization grows and evolves, your operating model might change. Moving resources into separate subscriptions can lead to complicated technical migrations. Review the [Align](../../ready/enterprise-scale/transition.md) guidance before you commit to an approach.

- **Lack of subscription vending process and automation.** If you do not provide a subscription vending process and associated automation, whether self-service or not, application and service teams will be delayed from delivering value for your organization whilst subscriptions are created for them and placed the appropriate Management Group in the hierarchy. If the process for getting new subscriptions is complicated and takes a long time, application and service teams may choose to create subscriptions by themselves via alternative billing accounts and maybe also in non-managed or governed Microsoft Entra tenants; which means shadow IT is now in existence.

## Policy-driven governance

Use Azure Policy to provide guardrails and ensure that the applications you deploy comply with your organization's security, governance, and regulatory controls that are implementation and configuration tooling agnostic. Azure Policy provides platform teams with the required tooling to implement, enforce, audit, and control Azure control and data plane operations and configurations. This then allows the [subscriptions to be democratized](#subscription-democratization), ideally via a self-service process, to application and service teams so they can deliver business value rapidly for the organization.

For more information on utilizing Azure Policy, review [Adopt policy-driven guardrails](../../ready/enterprise-scale/dine-guidance.md).

### Impact of deviation

**Increased operational and management overhead.** If you don't use Azure Policy to create guardrails within your environment, you increase the operational and management overhead of maintaining compliance. Azure Policy helps you restrict and automate your desired compliance state within your environment.

## Single control and management plane

Avoid dependency on abstraction layers such as customer-developed portals or tooling. It's best to have a consistent experience for both central operations and workload operations. Azure provides a unified and consistent control plane that applies across all Azure resources and provisioning channels, known as [Azure Resource Manager](/azure/azure-resource-manager/management/overview). The control plane is subject to role-based access controls and policy-driven controls. You can use this Azure control plane to establish a standardized set of policies and controls that govern your entire enterprise estate.

### Impact of deviation

**Increased integration complexity.** A multivendor approach to control and management planes might introduce integration and feature support complexity. Replacing individual components to achieve a "best of breed" design or multivendor operations tooling has limitations, and could cause unintended errors due to inherent dependencies.

If you're bringing an existing tooling investment to operations, security, or governance, review the Azure services and any dependencies.

## Application-centric service model

Focus on application-centric migrations and development, rather than pure infrastructure lift-and-shift migrations such as moving virtual machines. Design choices shouldn't differentiate among old and new applications, infrastructure as a service (IaaS) applications, or platform as a service (PaaS) applications.

Regardless of the service model, strive to provide a secure environment for all applications you deploy on the Azure platform.

### Impact of deviation

- **Increased governance policy complexity.** If you segment workloads differently from the management group hierarchy [implementation options](implementation-options.md), you increase complexity in governance policies and access control structures that govern your environment. Examples include deviation from the organizational hierarchy structure or grouping by Azure service.

- **Increased operational overhead.** This tradeoff introduces the risk of unintentional policy duplication and exceptions, which add to operational and management overheads.

- **Dev/Test/Production** is another common approach that organizations consider. For more information, see [How do we handle "dev/test/production" workload landing zones in Azure landing zone architecture](../../ready/enterprise-scale/faq.md#how-do-we-handle-devtestproduction-workload-landing-zones-in-azure-landing-zone-architecture).


## Alignment with Azure-native design and roadmaps

Use Azure-native platform services and capabilities whenever and wherever possible. This approach should align with Azure platform roadmaps to ensure that new capabilities are available within your environments. Azure platform roadmaps should help inform the migration strategy and the Azure landing zone conceptual trajectory.

### Impact of deviation

**Increased integration complexity.** Introducing third-party solutions into your Azure environment can create a dependency on those solutions to provide feature support and integration with Azure first-party services.

Sometimes bringing existing third-party solution investments into an environment is inescapable. Consider this principle and its tradeoffs carefully to align with your requirements.

## Next steps

Organizations might be at different stages of their cloud journeys when they review this guidance. Therefore, the required actions and recommendations to progress toward the preceding outcomes might vary. To understand the best next actions for your cloud adoption stage, review the journey to the target architecture.

> [!div class="nextstepaction"]
> [Journey to the target architecture](./landing-zone-journey.md)

To choose the right Azure landing zone implementation option, understand the Azure landing zone design areas.

> [!div class="nextstepaction"]
> [Review design areas](./design-areas.md)
