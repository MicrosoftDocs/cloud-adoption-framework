---
title: "Codename: CAF NorthStar"
titleSuffix: Cloud Adoption Framework
description: Codename - CAF NorthStar
author: uday31in
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: csu
---

# Codename: CAF NorthStar

![CAF CAF NorthStar architecture guide](./media/icon.png)

The CAF NorthStar is a journey which customers can follow to leverage the principals of the Cloud Adoption Framework to meet the specific yet common needs of a subset of cloud adoption teams.

## What is Codename: CAF NorthStar?

When navigating long distances, the North Star (Ursae Minoris or Polaris) has long been used to help travelers find true north and stay on course. Likewise, the CAF NorthStar establishes a true north (or a suggested end state) for platform architecture. This effort helps keep the iterative efforts throughout the Cloud Adoption Framework focused towards a clear destination along a linear path. In short, the NorthStar architecture is a prescriptive guidance on how to build a production ready and future proof Azure data center, based on best practices from strategic projects at customers.

## What guidance and tools are provided in this journey?

Codename: CAF NorthStar includes four sets of assets to support cloud teams: [Implementations](./implementation.md) | [Architecture](./architecture.md) | [Design Guidelines](./design-guidelines.md) | [Template](./template.md)

- [Implementations](./implementation.md): Scripted implementations of the architecture to accelerate adoption.*
- [Architecture](./architecture.md): Conceptual reference architecture to demonstrate design areas and best practices.
- [Design Guidelines](./design-guidelines.md): Guide to the critical design areas and decisions that drive CAF NorthStar.
- [Template](./template.md): Documentation template to quickly capture decisions and any deviation from the suggested architecture and/or implementation.

## Who should follow the guidance outlined in this journey?

This journey is designed for teams whose adoption plan calls for a mid-term objective (within 24 months) to host **more than 1,000 assets (apps, infra, or data assets) in the cloud**.

This journey is especially relevant for customer who also have a heightened responsibility to maintain governance, security, and operational management requirements within the cloud environment. This journey is even more relevant when workload hosting requirements are likely to require a high number of "[landing zones](../../ready/considerations/index.md)", as it will help provide a mechanism for the creation and management of new landing zones.

## Why should the defined audience follow this journey?

The Cloud Adoption Framework provides distinct methodologies to guide architectural decisions across the full cloud adoption life cycle. For most customers, cloud governance, cloud management, cloud platform, and cloud adoption teams will each mature at their own pace to deliver on the company's digital transformation strategy. For most teams that maturity is an ongoing, iterative process of identifying and addressing opportunities to learn and improve.

For companies to be successful in the large scale adoption efforts described above require all platform, governance, and management to reach a minimum level of maturity in unison and early in the lifecycle. Codename CAF NorthStar pulls forward and adds to each methodology in the form of a single, united implementation. This implementation of a common architecture ensures that specific standards are met across all landing zones.

## How should I use this journey?

How you use this guidance depends on where you are in your journey:

- **New to the cloud**: If you are new to the cloud, the implementations provide a rich starting point. From there an understanding of the architecture and design guidelines will help you customize that code base to fit your needs.
- **10 or less existing landing zones**: As long as the code base for your landing zones is manageable, it may be possible to refactor those landing zones to align with an implementation of the core architecture in the listed implementations of CAF NorthStar.
- **Extensive existing implementation**: When refactoring is not possible, consider using the architecture as a long-term roadmap. Reference that architecture and the design areas to evaluate gaps in your current platform implementation. Some of the implementation options, like the collection of defined policies may be compatible with your existing landing zones immediately. Other implementation modules, like shared services, may require more time and consideration. Using this journey will help keep you on a linear path as you extend all of your existing landing zones.

## Community

This guide is developed largely by **Microsoft Cloud Solutions Architects and the broader Cloud Solutions Unit technical community**. This community actively advances this guide to share lessons learned during enterprise-scale adoption efforts.

While this guide shares the same design principles as the standard Ready methodology, it expands upon those principles to integrate topics like governance and security, earlier in the planning process. This expansion of the standard process is necessary because of a few natural assumptions that can be made when an adoption effort requires large-scale enterprise change.

## Next steps

[Implement CAF NorthStar](./implementation.md)

> [!div class="nextstepaction"]
> [Implement CAF NorthStar](./implementation.md)
