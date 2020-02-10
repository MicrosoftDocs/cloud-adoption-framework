---
title: "Design Principles"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: CAF NorthStar landing zone - Design Principles
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---


# Design Principles

The CAF NorthStar architecture prescribed within this guide is underpinned by following fundamental design principals, which serve as a compass for subsequent design decisions across critical technical domains. Readers are strongly advised to familiarize themselves with these principals to better understand their impact and the trade-offs associated with non-adherence.

**Subscription Democratization**

Subscriptions should be used as a unit of management and scale aligned with business needs and priorities, to support business areas and portfolio owners to accelerate application migrations and net-new application development. Subscriptions should be provided to business lines to support the design and development/testing of both migrating and net-new workloads.

**Policy Driven Governance**

Azure Policy should be used to provide the “guard-rails” and ensure the continued compliance of the customer platform and applications deployed onto it, whilst also providing application owners sufficient freedom and a secure unhindered path to cloud.

**Single Control and Management Plane**

The CAF NorthStar architecture should not consider any abstraction layers such as customer developed portals or tooling and should provide a consistent experience for both AppOps (centrally managed operation teams) and DevOps (dedicated application operation teams). Azure provides a unified and consistent control plane across all Azure resources and provisioning channels which should be used to establish a consistent set of policies and controls for governing the entire customer estate, subject to RBAC and policy driven controls.

**Application Centric and Archetype-Neutral**

The CAF NorthStar architecture should focus on application centric migrations and development rather than a pure infrastructure “lift and shift” migration (i.e. movement of virtual machines) and should not differentiate between old/new applications or IaaS/PaaS applications. Ultimately, it should provide the foundation for all application types to be deployed onto the customer Azure platform securely and safely.

**Azure Native Design and Roadmap Aligned**

The CAF NorthStar architecture strongly advocates the use of native platform services and capabilities wherever possible, which should be fully aligned with Azure platform roadmaps from the offset to ensure new capabilities are swiftly made available within customer environments. More specifically, Azure platform roadmaps should help to inform the migration strategy and ”NorthStar” trajectory.

- Be prepared to trade off functionality as not everything will likely be required on day one.
- Leverage preview services and take dependencies on service roadmaps in order to remove technical blockers.

## Next steps

Review the [Design Guidelines](./design-guidelines.md)

> [!div class="nextstepaction"]
> [Design Guidelines](./design-guidelines.md)
