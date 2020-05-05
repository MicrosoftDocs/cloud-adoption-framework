---
title: "Design Principles"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF enterprise-scale landing zone - Design Principles
author: rkuehfus
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# Design principles

The Cloud Adoption Framework (CAF) enterprise-scale landing zone architecture recommended within this guide is upheld by key design principals that serve as a compass for subsequent design decisions across critical technical domains. Readers are advised to familiarize themselves with these principles to understand their impact, how to best follow them, and the trade-offs associated with non-adherence.

**Subscription democratization**

Subscriptions best support business areas and portfolio owners when they're used as a unit of management to accelerate application migrations and net-new application development. Their scale should align with business needs and priorities, and they should be provided to lines of business to uphold design and development/testing for both migrating and net-new workloads.

**Policy-driven governance**

Azure policy should be used to provide “guard rails” and ensure that the customer platform and applications deployed onto it continue to comply while also providing application owners sufficient freedom and a secure, unhindered path to the cloud.

**Single-control and management plane**

The CAF enterprise-scale landing zone architecture shouldn't consider any abstraction layers such as customer developed portals or tooling and should provide a consistent experience for both centrally managed operation teams, AppOps, and dedicated application operation teams, DevOps. Azure provides a unified and consistent control plane across all Azure resources and provisioning channels used to establish a consistent set of policies and controls for governing the entire customer estate and subject to RBAC and policy-driven controls.

**Application-centric and archetype-neutral**

The CAF enterprise-scale landing zone architecture should focus on application-centric migrations and development rather than a pure infrastructure “lift-and-shift” migration (for example, moving virtual machines) and shouldn't differentiate between old/new applications or IaaS/PaaS applications. Ultimately, it should provide the foundation for all application types to be deployed onto the customer Azure platform securely and safely.

**Azure-native design and roadmap aligned**

The CAF enterprise-scale landing zone architecture strongly advocates the use of native platform services and capabilities wherever possible, which should be fully aligned with Azure platform roadmaps from the offset to ensure new capabilities are swiftly made available within customer environments. More specifically, Azure platform roadmaps should help to inform the migration strategy and "CAF enterprise-scale landing zone" trajectory.

- Be prepared to trade off functionality, as not everything will likely be required on day one.
- Optimize preview services and take dependencies on service roadmaps in order to remove technical blockers.

## Next steps

Review the [design guidelines](./design-guidelines.md)

> [!div class="nextstepaction"]
> [Design Guidelines](./design-guidelines.md)
