---
title: Design areas of a well-architected landing zone
description: Design areas of a well-architected landing zone
author: BrianBlanchard
ms.author: brblanch
ms.date: 06/15/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Modular design areas considered by all Azure landing zones

Each Azure landing zone implementation option provide a deployment approach and defined design principles that helps you implement the following design areas. Before choosing an implementation option, use this article to gain an understanding of those design areas.

> [!NOTE]
> The following design areas outline the things that should be considered prior to deploying a landing zone. This article is purposefully not deep or actionable, but serves as a simple reference. The next step in the [landing zone implementation options](./implementation-options.md) article will be provide opinionated design principles and actionable steps for deployment.  

Regardless of the deployment option, each of the following should be considered and decisions should be made for each design area. Those decisions will impact the platform foundation that each landing zone will depend on.

| Design areas  | Objective  | Relevant methodologies |
|---|---|---|
| Enterprise enrollment | For enterprise customers with an Azure commitment, proper tenant creation and enrollment is an important early step.| Ready |
| Identity | Identity and access management (IAM) is a primary security boundary in the public cloud. It is the foundation for any secure and fully compliant architecture.| Ready |
| Network topology and connectivity | Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture.| Ready |
| Resource organization | As cloud adoption scales, considerations for subscription design and management group hierarchy will have an impact on governance, operations management, and adoption patterns.| Govern |
| Governance disciplines | Automate auditing and enforcement of security, governance, and compliance policies. | Govern |
| Operations baseline | For stable, ongoing operations in the cloud, an operations baseline is required to provide visibility, operations compliance, and protect and recover capabilities. | Manage |
| Business continuity and disaster recovery (BCDR) | BCDR provides the foundation for reliability and rapid recovery. | Manage |
| Deployment options | Align the best tools and templates to deploy your landing zones and supporting resources. | Ready |

## Next steps

As you will see in the next article, these design areas can be implemented over time allowing you to grow into your cloud operating model. Alternatively, there are rich, opinionated implementation options that start with a defined position on each design area.

With an understanding of the modular design areas, the next step is to choose the [landing zone implementation option](./implementation-options.md) that best aligns with your cloud adoption plan and requirements.

> [!div class="nextstepaction"]
> [Choose a implementation option](./implementation-options.md)
