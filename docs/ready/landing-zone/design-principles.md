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

# Design principles

Applying well-architected pillars to a cloud platform and each landing zone, requires a few design principles to be factored into landing zone design and the design of the supporting _platform foundation_.

The following principles define a target future-state architecture for the environment supporting your workload. After this article, the series will outline approaches to deploy and scale your environment to fulfill those principles.

## Modular design principles

The following design principles can be addressed during landing zone design for "greenfield" adoption. For customers who are further along on their cloud adoption journey, each principle can be addressed in associated Cloud Adoption Framework methodology.

|Methodology module  |Design Principle  |Objective  |
|---------|---------|---------|
|Ready |Enterprise enrollment|For enterprise customers with a cloud commitment, proper tenant creation and enrollment is an important first step.|
|Ready |Identity|Identity and access management (IAM) is a primary security boundary in the public cloud. It is the foundation for any secure and fully compliant architecture.|
|Ready |Network topology and connectivity|Networking and connectivity decisions are an equally important foundational aspect of any cloud architecture.|
|Govern |Resource organization|As cloud adoption scales, considerations for subscription design and management group hierarchy will have an impact on governance, operations management, and adoption patterns.|
|Govern |Governance disciplines|Automate auditing and enforcement of security, governance, and compliance policies.|
|Manage |Operations baseline|For stable, on-going operations in the cloud, an operations baseline is required to provide visibility, operations compliance, and protect/recover capabilities.|
|Manage |Business continuity and disaster recovery (BCDR)|BCDR provides the foundation for reliability and rapid recovery.|
|Ready |Deployment options|Align the best tools and templates to deploy your landing zones and supporting resources.|

## Next steps

As you will see in the next article, these design principles can be implemented over time allowing you to grow into your cloud operating model. Alternatively, there are rich, opinionated deployment options that can implement all three modules in one deployment.

With an understanding of the core modular design principles, the next step is to choose the [landing zone deployment option](./deployment-option.md) that best aligns with your cloud adoption plan and requirements.

> [!div class="nextstepaction"]
> [Choose a deployment option](./deployment-option.md)
