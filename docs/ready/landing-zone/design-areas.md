---
title: Design principles
description: Understand the design principles that drive landing zone deployment
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Design areas

All Azure landing zones provide a deployment approach and reference architecture that helps you realize the following design areas. Before choosing an Azure landing zone, it's important to understand these design areas to find the Azure landing zone that's right for your cloud adoption plan.

> [!WARNING]
> The following design areas outline considerations. They are purposefully not actionable. The next step choose a landing zone option will be provide opinionated design principles to  

## Modular design areas

To have a well-architected environment, each of the following must be considered. Depending on your cloud adoption plan, you may choose to implement all of these principles before any adoption begins. Alternatively, its equally common to start small & integrate each principle as your cloud adoption efforts scale. Either way, all Azure landing zones provide a path to support your needs.

Regardless of the deployment option, each of the following should be considered & decisions should be made for each design area. Those decisions will impact the platform foundation that each landing zone will depend on.

|Design areas  |Objective  | Relevant methodologies |
|---------|---------|---------|
|Enterprise enrollment|For enterprise customers with an Azure commitment, proper tenant creation and enrollment is an important early step.| Ready |
|Identity|Identity and access management (IAM) is a primary security boundary in the public cloud. It is the foundation for any secure and fully compliant architecture.| Ready |
|Network topology and connectivity|Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture.| Ready |
|Resource organization|As cloud adoption scales, considerations for subscription design and management group hierarchy will have an impact on governance, operations management, and adoption patterns.| Govern |
|Governance disciplines|Automate auditing and enforcement of security, governance, and compliance policies.| Govern |
|Operations baseline|For stable, on-going operations in the cloud, an operations baseline is required to provide visibility, operations compliance, and protect/recover capabilities.| Manage |
|Business continuity and disaster recovery (BCDR)|BCDR provides the foundation for reliability and rapid recovery.| Manage |
|Deployment options|Align the best tools and templates to deploy your landing zones and supporting resources.|Ready |

## Next steps

As you will see in the next article, these design principles can be implemented over time allowing you to grow into your cloud operating model. Alternatively, there are rich, opinionated deployment options that can implement all three modules in one deployment.

With an understanding of the core modular design principles, the next step is to choose the [landing zone implementation option](./implementation-options.md) that best aligns with your cloud adoption plan and requirements.

> [!div class="nextstepaction"]
> [Choose a implementation option](./implementation-options.md)
