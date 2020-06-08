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

It is sometimes unwise for a cloud platform team to start small and scale. Teams worked for years within the constraints of the company's existing on-premises environment to reach the current state of maturity across security, operations, and governance. It will take time to assess the new constraints of any cloud environment and replicate its desired processes, tools, and architectures. To accelerate this learning process, a slightly different starting point is required. When comparing the image below to the [early refactoring guidance within this methodology](../landing-zone/refactor.md), the fundamental change is the starting point, and it's now more complex. More information follows later in this article.

![Landing zone refactoring illustration - described in later section of this article](../../_images/ready/refactor-enterprise-scale.png)
_Figure 1: Landing zone refactoring._

<!-- markdownlint-disable MD026 -->

## Qualifiers: Should I start with enterprise scale?

For most adoption patterns, a "start small and expand" approach is preferable, as it allows the team to learn from real experiences. For companies who mirror the examples in this article, a more robust approach is required.

### Scale and speed

When an adoption team has a mid-term objective to host more than 1,000 assets (apps, infrastructure, or data assets) in the cloud within 24 months, there isn't enough time to learn solely through a hands-on approach. Multiple criteria will need to deliver the speed and scale that large enterprises require.

### Security, compliance, and culture

Multiple business motivations might require an enterprise-scale landing zone and shared-services architecture before any adoption can begin. The need for an enterprise-scale landing zone solution might be obvious for companies whose businesses are built around sensitive data and complex interdependent architectures. It may also be clear when companies require cloud environments that meet strict third-party requirements before using the cloud. Cultures with deeply rooted centralized IT control models might also need an architecture that starts with centralized control to pass change-control requirements.

### All-in on the cloud

The most common driver for an enterprise-scale landing zone comes from companies who decide to go all-in on the cloud, often due to a datacenter termination or a mass shift toward greater business agility. Regardless of the driver, this business decision typically demands both scale and speed during adoption. This combination of demands makes it difficult to take the time required to learn and prepare for sensitive data and mission-critical hosting in the cloud.

### Skill requirements

Starting with enterprise scale assumes that the cloud platform team has enterprise-scale budgets. This qualifier assumes that the team has deeper skills in the cloud than other companies. These skills can come from an existing history of smaller-scale cloud adoption within the company, and they can also be added by attracting experienced staff or working with highly experienced partners. For either direction, the following skills will be required to start with enterprise scale.

Suggested skills include:

- Deep knowledge of architecture in the chosen cloud provider.
- Extensive hands-on experience with cloud-based infrastructure-as-code approaches
- Moderate familiarity with GitHub or other source code repositories, including branching and pull request strategies.
- Actionable experience with automated deployments from source code to the cloud provider.

If these skills aren't available within the cloud platform team through staff, partners, or other support mechanisms, a "start small and expand" approach is likely to reach enterprise readiness faster with a higher-quality output. This approach would allow the existing team to incur fewer costs for acquiring skills.

## Start with an enterprise-scale landing zone

The enterprise-scale approach to landing-zone development includes four sets of assets to support cloud teams:

- [Implementations](./implementation.md): Scripted implementations of the architecture to accelerate adoption.
- [Architecture](./architecture.md): Conceptual reference architecture to demonstrate design areas and best practices.
- [Design guidelines](./design-guidelines.md): Guide to the critical design areas and decisions that drive the CAF enterprise-scale landing zone.
- [Template](./template.md): A documentation template to quickly capture decisions and any deviation from the suggested architecture or implementation.

## Community

<!-- docsTest:ignore "Cloud Solutions Unit" -->

This guide is developed largely by Microsoft architects and the broader Cloud Solutions Unit technical community. This community actively advances this guide to share lessons learned during enterprise-scale adoption efforts.

While this guide shares the same design principles as the standard Ready methodology, it expands upon those principles to integrate topics such as governance and security earlier in the planning process. Expanding the standard process is necessary because of a few natural assumptions that can be made when an adoption effort requires large-scale enterprise change.

## Next steps

[Implement a CAF enterprise-scale landing zone](./implementation.md)

> [!div class="nextstepaction"]
> [Implement a CAF enterprise-scale landing zone](./implementation.md)
