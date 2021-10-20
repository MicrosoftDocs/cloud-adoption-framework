---
title: Azure landing zone design areas
description: Evaluate a set of standard considerations which are used to define all Azure landing zones.
author: DominicAllen
ms.author: doalle
ms.date: 07/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

<!-- TODO: Refactor terms: "design area", "well-architected" -->

# Azure landing zone design areas

Each Azure landing zone implementation option provides a deployment approach and defined design principles. Before choosing an implementation option, use this article to gain an understanding of the design areas listed in the following table.

> [!NOTE]
> These design areas describe what you should consider prior to deploying a landing zone. Use it as a simple reference. Explore each of the design areas in this section for further guidance on each of the key themes for landing zone design.

## Environment design areas

Regardless of the deployment option, you should carefully consider each design area. Your decisions affect the platform foundation on which each landing zone depends.

| Design areas | Objective | Relevant methodologies |
|--|--|--|
| Azure billing and Active Directory tenant | Proper tenant creation, enrollment, and billing setup are important early steps. | Ready |
| Identity and access management | Identity and access management is a primary security boundary in the public cloud. It's the foundation for any secure and fully compliant architecture. | Ready |
| Network topology and connectivity | Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture. | Ready |
| Resource organization | As cloud adoption scales, considerations for subscription design and management group hierarchy have an impact on governance, operations management, and adoption patterns. | Govern |

## Compliance design areas

Security, governance, and compliance are key topics when designing and building an Azure environment, not only to start from strong foundations, but also to ensure solid ongoing processes and controls are in place.

Alongside the controls that help maintain and demonstrate compliance, the tools and processes implemented for managing environments play an important role in detecting and responding to issues that require action.

![Compliance design areas](./design-area/media/compliance-design-areas.png)

As the organization's cloud environment develops, these compliance design areas will be the focus for iterative refinement. This may be as a result of new applications that introduce specific new requirements, or the business requirements changing (for example in response to a new compliance standard).

| Design areas | Objective | Relevant methodologies |
|--|--|--|
| Governance | Automate auditing and enforcement of governance policies. | Govern |
| Security | Implement controls and process to protect your cloud environments | Secure |
| Management | For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities. | Manage |
| Platform automation and DevOps | Align the best tools and templates to deploy your landing zones and supporting resources. | Ready |


## Next steps

You can implement these design areas over time so that you can grow into your cloud operating model. Review the methodologies related to each of the design areas to understand in more detail the considerations and decisions required to implement a landing zone.

Within each design area you'll find considerations to help shape your internal discussions and recommendations that provide specific guidance to help align your journey to the Azure landing zone conceptual architecture.

Alternately, there are rich, opinionated implementation options that start with a defined position on each design area.

With an understanding of the modular design areas, the next step is to choose the landing zone implementation option that best aligns with your cloud adoption plan and requirements.

> [!div class="nextstepaction"]
> [Choose an implementation option](./implementation-options.md)
