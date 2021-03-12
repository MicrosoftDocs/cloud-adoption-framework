---
title: Azure landing zone design areas
description: Evaluate a set of standard considerations which are used to define all Azure landing zones.
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- TODO: Refactor terms: "design area", "well-architected" -->

# Azure landing zone design areas

Each Azure landing zone implementation option provides a deployment approach and defined design principles. Before choosing an implementation option, use this article to gain an understanding of the design areas listed in the following table.

> [!NOTE]
> These design areas describe what you should consider prior to deploying a landing zone. Use it as a simple reference. See the [landing zone implementation options](./implementation-options.md) for design principles and actionable steps for deployment.

## Design areas

Regardless of the deployment option, you should carefully consider each design area. Your decisions affect the platform foundation on which each landing zone depends.

| Design areas | Objective | Relevant methodologies |
|---|---|---|
| Enterprise enrollment | For enterprise customers with an Azure commitment, proper tenant creation and enrollment is an important early step. | Ready |
| Identity | Identity and access management is a primary security boundary in the public cloud. It's the foundation for any secure and fully compliant architecture. | Ready |
| Network topology and connectivity | Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture. | Ready |
| Resource organization | As cloud adoption scales, considerations for subscription design and management group hierarchy have an impact on governance, operations management, and adoption patterns. | Govern |
| Governance disciplines | Automate auditing and enforcement of security, governance, and compliance policies. | Govern |
| Operations baseline | For stable, ongoing operations in the cloud, an operations baseline is required to provide visibility, operations compliance, and protect and recover capabilities. | Manage |
| Business continuity and disaster recovery (BCDR) | Resiliency is key for smooth functioning of applications. BCDR is an important component of resiliency. BCDR involves protection of data via backups and protection of applications from outages via disaster recovery. | Manage |
| Deployment options | Align the best tools and templates to deploy your landing zones and supporting resources. | Ready |

## Next steps

You can implement these design areas over time so that you can grow into your cloud operating model. Alternately, there are rich, opinionated implementation options that start with a defined position on each design area.

With an understanding of the modular design areas, the next step is to choose the [landing zone implementation option](./implementation-options.md) that best aligns with your cloud adoption plan and requirements.

> [!div class="nextstepaction"]
> [Choose an implementation option](./implementation-options.md)
