---
title: Azure landing zone journey
description: Explore the journey towards the target architecture for Azure Landing Zones.
author: DominicAllen
ms.author: doalle
ms.date: 06/1/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Journey towards the target architecture

Adopting cloud technologies is a journey.

Business priorities and the need to bring new technologies online in order to unlock capabilities or features will influence the speed at which an organization deploys and scales out a cloud environment.

Over time, the organization iterates and matures the deployed technologies, processes and skilling to progress towards that destination.

However, this doesn't mean you arrive at the destination immediately, the journey takes time - which will vary depending on the size of the organization, the current technical footprint and the skilling maturity within technical teams.

If we use the analogy of a trip along a freeway there might be a number of different *on-ramps* to join onto the freeway - but the *destination* is the same.

![Azure Landing Zone journey on-ramps](../../_images/ready/alz-journey.png)

Those on-ramps represent where organizations are today in their cloud adoption plans and the specific guidance needed to continue to develop the cloud environment:

| On-ramp | Description | Further guidance |
|---------|---------|---------|
|**Start** |Starting completely from scratch (also referred to as 'greenfield')| [Azure Landing Zone Design areas](./design-areas.md) |
|**Refactor** | Starting with an existing environment that needs modification to adopt the best practices (also referred to as 'brownfield)|[Transition from brownfield](./refactor.md) |
|**Enhance** | Starting with an environment that is already in line with the best practices but the organization is looking to add additional controls or features| [Enhance guidance for management](../considerations/landing-zone-operations.md) <br> [Enhance guidance for governance](../considerations/landing-zone-governance.md) <br> [Enhance guidance for security](../considerations/landing-zone-security.md) |

## Next steps

To understand the decisions you need to make when implementing an Azure landing zone, explore the Azure landing zone design areas in order to understand the specific technical topics to consider.

> [!div class="nextstepaction"]
> [Azure Landing Zone design areas](./design-areas.md)