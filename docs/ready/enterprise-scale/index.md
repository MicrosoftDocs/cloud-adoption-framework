---
title: Start with Cloud Adoption Framework enterprise-scale landing zones
description: Start with enterprise-scale landing zones using the Microsoft Cloud Adoption Framework for Azure.
author: JefferyMitchell
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank
---

# Start with Cloud Adoption Framework enterprise-scale landing zones

The enterprise-scale architecture represents the strategic design path and target technical state for your Azure environment. It will continue to evolve alongside the Azure platform and is defined by the various design decisions that your organization must make to map your Azure journey.

Not all enterprises adopt Azure in the same way, so the Cloud Adoption Framework for Azure enterprise-scale landing zone architecture varies between customers. The technical considerations and design recommendations of the enterprise-scale architecture might lead to different trade-offs based on your organization's scenario. Some variation is expected, but if you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale.

## Prescriptive guidance

The enterprise-scale architecture provides prescriptive guidance coupled with best practices for your Azure control plane. It follows design principles across the critical design areas for an organization's Azure environment.

## Qualifiers: Should I start with enterprise-scale?

The enterprise-scale architecture is modular by design. It allows you to start with a foundational landing zone control plane that support your application portfolios, no matter whether the applications are being migrated or are newly developed and deployed to Azure. The architecture can scale alongside your business requirements regardless of scale point.

## Start with a Cloud Adoption Framework enterprise-scale landing zone

The enterprise-scale approach to construct landing zones includes three sets of assets to support cloud teams:

- [Design guidelines](./design-guidelines.md): Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone.
- [Architecture](./architecture.md): Conceptual reference architecture that demonstrates design areas and best practices.
- [Implementations](./implementation.md): Azure Resource Manager template of the architecture to accelerate adoption.

<!-- TODO: Reinstate once template.md is ready.
- [Template](./template.md): A documentation template to quickly capture decisions and any deviation from the suggested architecture or implementation.
-->

## Community

<!-- docutune:ignore "Cloud Solutions Unit" -->

This guide is developed largely by Microsoft architects and the broader Cloud Solutions Unit technical community. This community actively advances this guide to share lessons learned during enterprise-scale adoption efforts.

This guide shares the same design principles as the standard Ready methodology. It expands on those principles to integrate subjects such as governance and security earlier in the planning process. Expanding the standard process is necessary because of a few natural assumptions that can be made when an adoption effort requires large-scale enterprise change.

## Next steps

[Implement a Cloud Adoption Framework enterprise-scale landing zone](./implementation.md)
