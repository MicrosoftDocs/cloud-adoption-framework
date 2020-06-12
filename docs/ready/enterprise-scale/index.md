---
title: Start with enterprise-scale landing zones
description: Start with enterprise-scale landing zones.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Start with enterprise-scale landing zones

The enterprise-scale architecture represents the strategic design path and target technical state for the customer's Azure environment. It will continue to evolve alongside the Azure platform and is ultimately defined by the various design decisions that organizations must make to define their Azure journey.

Not all enterprises adopt Azure in the same way, so the enterprise-scale architecture may vary between customers. Ultimately, the technical considerations and design recommendations of the enterprise-scale architecture may lead to different trade-offs based on the customer's scenario. Some variation is expected, but if core recommendations are followed, the resulting target architecture will put the customer on a path to sustainable scale.

## Prescriptive guidance

The enterprise-scale architecture provides prescriptive guidance coupled with Azure best practices, and it follows design principles across the critical design areas for the customer's Azure environment.

## Qualifiers: Should I start with enterprise scale?

The enterprise-scale architecture is modular by design and allow customers to start with foundational landing zones that support their application portfolios, regardless of whether the applications are being migrated or are newly developed and deployed to Azure. The architecture can scale alongside the customer's business requirements regardless of scale point.

## Start with an enterprise-scale landing zone

The enterprise-scale approach to construct landing zones includes four sets of assets to support cloud teams:

- [Design guidelines](./design-guidelines.md): Guide to the critical decisions that drive the design of the CAF enterprise-scale landing zone.
- [Architecture](./architecture.md): Conceptual reference architecture that demonstrates design areas and best practices.
- [Implementations](./implementation.md): Azure Resource Manager template of the architecture to accelerate adoption.

<!-- TODO: Reinstate once template.md is ready. 
- [Template](./template.md): A documentation template to quickly capture decisions and any deviation from the suggested architecture or implementation.
-->

## Community

<!-- docsTest:ignore "Cloud Solutions Unit" -->

This guide is developed largely by Microsoft architects and the broader Cloud Solutions Unit technical community. This community actively advances this guide to share lessons learned during enterprise-scale adoption efforts.

While this guide shares the same design principles as the standard Ready methodology, it expands upon those principles to integrate topics such as governance and security earlier in the planning process. Expanding the standard process is necessary because of a few natural assumptions that can be made when an adoption effort requires large-scale enterprise change.

## Next steps

[Implement a CAF enterprise-scale landing zone](./implementation.md)

> [!div class="nextstepaction"]
> [Implement a CAF enterprise-scale landing zone](./implementation.md)
