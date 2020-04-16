---
title: Start with enterprise-scale landing zones
description: Start with enterprise-scale landing zones
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Start with enterprise-scale landing zones

At times, it is unwise for a cloud platform team to start small and scale. Teams worked for years within the constraints of the company's existing on-premises environment to reach the current state of maturity across security, operations, and governance. It will take time to replicate the desired processes, tools, and architectures based on the new constraints of any cloud environment. To accelerate that learning process, a slightly different starting point is required. Comparing the image below to the [early refactoring guidance within this methodology](../landing-zone/refactor.md), the fundamental change is the starting point, which is now more complex, more to follow later in this article.

![Landing zone refactoring illustration - described in later section of this article](../../_images/ready/refactor-enterprise-scale.png)

<!-- markdownlint-disable MD026 -->

## Qualifiers: Should I start with enterprise scale?

For most adoption patterns, a "start small and expand" approach is preferable, as it allows the team to learn from real experiences. For companies that fit into the references in this article a more robust approach is required.

### Scale and speed

When the adoption team has a midterm objective (within 24 months) to host more than 1,000 assets (apps, infrastructure, or data assets) in the cloud, there isn't enough time to learn through hands-on approaches only. Multiple criteria will need to be preset to deliver the necessary speed and scale for a large enterprise.

### Security, compliance, and culture

Multiple business motivations might require an enterprise-scale landing zone and shared-services architecture before any adoption can begin. The need for an enterprise-scale landing zone solution can be obvious for companies whose businesses are built around sensitive data and complex interdependent architectures. It may also be obvious when companies require cloud environments that meet strict third-party requirements before using the cloud. Cultures with deeply rooted Central IT control models might also need an architecture that starts with centralized control to pass change-control requirements.

### All-in on the cloud

The most common driver for an enterprise-scale landing zone comes from companies who decide to go "all-in" on the cloud. This can be a result of a datacenter termination or a mass movement to be more agile as a business. Regardless of the driver, this business decision typically demands both scale of adoption and speed of adoption. This combination of demands makes it difficult to take the time required to learn and prepare for sensitive data and mission critical hosting in the cloud.

### Skill requirements

Starting with enterprise scale assumes that the cloud platform team has enterprise-scale budgets. This qualifier assumes the team has deeper skills in the cloud than most other companies. Those skills can come from an existing history of smaller scale cloud adoption within the company. The skills can also be added by attracting experienced staff or working with highly experienced partners. For either direction, the following skills will be required to start with enterprise scale.

Suggested skills:

- Deep knowledge on architecture in the chosen cloud provider.
- Extensive hands-on experience with cloud-based, infrastructure as code approaches.
- Moderate familiarity with GitHub or other source code repositories, including branching and pull request strategies.
- Actionable experience with automated deployments from source code to the cloud provider.

If these skills aren't available within the cloud platform team (through staff, partners, or other support mechanisms), a "start small and expand" approach is likely to reach enterprise readiness faster with a higher-quality output. Such an approach would allow for less costly, skills acquisition within the existing team.

## Start with an enterprise-scale landing zone

The enterprise-scale approach to landing zone development includes four sets of assets to support cloud teams: [Implementations](./implementation.md) | [Architecture](./architecture.md) | [Design Guidelines](./design-guidelines.md) | [Template](./template.md)

- [Implementations](./implementation.md): Scripted implementations of the architecture to accelerate adoption.*
- [Architecture](./architecture.md): Conceptual reference architecture to demonstrate design areas and best practices.
- [Design Guidelines](./design-guidelines.md): Guide to the critical design areas and decisions that drive CAF enterprise-scale landing zone.
- [Template](./template.md): Documentation template to quickly capture decisions and any deviation from the suggested architecture and/or implementation.

## Community

This guide is developed largely by **Microsoft Cloud Solutions Architects and the broader Cloud Solutions Unit technical community**. This community actively advances this guide to share lessons learned during enterprise-scale adoption efforts.

While this guide shares the same design principles as the standard Ready methodology, it expands upon those principles to integrate topics like governance and security, earlier in the planning process. This expansion of the standard process is necessary because of a few natural assumptions that can be made when an adoption effort requires large-scale enterprise change.

## Next steps

[Implement CAF enterprise-scale landing zone](./implementation.md)

> [!div class="nextstepaction"]
> [Implement CAF enterprise-scale landing zone](./implementation.md)
