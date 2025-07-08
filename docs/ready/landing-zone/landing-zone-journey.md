---
title: Journey toward the target architecture
description: Learn how to deploy and scale out a cloud environment to ultimately implement the target architecture for Azure landing zones.
author: Zimmergren
ms.author: pnp
ms.date: 11/28/2024
ms.topic: conceptual
ms.custom: internal
---

# Journey toward the target architecture

Adopting cloud technologies is a journey. Business priorities and the need to bring new technologies online to unlock capabilities or features influence the speed at which an organization deploys and scales out a cloud environment.

Over time, an organization iterates and matures the deployed technologies, processes, and skilling needed to progress toward that destination. This iteration doesn't mean you arrive at the destination immediately, however. The journey takes time. The time varies depending on the size of the organization, the current technical footprint, and the skilling maturity within technical teams.

## On-ramps

Consider an analogy of a trip along a freeway. There might be multiple *on-ramps* you can use to join the freeway, but the *destination* is the same.

![Diagram of Azure landing zone journey on-ramps.](../../_images/ready/alz-journey.png)

These on-ramps represent where your organization is today in your cloud adoption plans. They also represent the specific guidance that you need to continue to develop your cloud environment.

| On-ramp | Description | Further guidance |
|--|--|--|
| **Start** | Your organization is at the beginning of the cloud adoption journey, also referred to as *greenfield*, and you want to implement a new cloud environment based on best practices and proven architectural patterns. <br><br> Start with the Azure landing zone conceptual architecture to understand the recommended end state. <br><br> Explore each of the design areas. Understand the key themes in each area that form the considerations and decisions that you need to design and implement a landing zone that best fits your requirements. | - [What is an Azure landing zone?](./index.md) <br><br> - [Azure landing zone design areas](./design-areas.md) |
| **Align** | Your organization has an existing environment that needs modification to align with the Azure landing zone target architecture and best practices, also referred to as *brownfield*. <br><br> See the transition from brownfield guidance to understand the decision points and technical approach to refactor environments and align with guidance in the ready methodology. | - [Refactor a landing zone](./refactor.md) <br><br> - [Transition an existing Azure environment to the Azure landing zone conceptual architecture](./../enterprise-scale/transition.md) <br><br> - [Scenario: Transition a single subscription with no management groups to the Azure landing zone conceptual architecture](./align-scenario-single-subscription.md) <br><br> - [Scenario: Transition management groups to the Azure landing zone conceptual architecture](./align-scenario-multiple-management-groups.md) <br><br> - [Scenario: Transition a regional organization environment to the Azure landing zone conceptual architecture](./align-scenario-regional-org.md) <br><br> - [Scenario: Transition an environment by duplicating a landing zone management group](./align-approach-duplicate-brownfield-audit-only.md) |
| **Enhance** | Your environment is already in line with best practices, but your organization wants to add more controls or features. <br><br> Explore articles that describe considerations to enhance key ongoing processes for cloud environments, such as management, governance, and security. | - [Improve landing zone operations](../considerations/landing-zone-operations.md) <br><br> - [Improve landing zone governance](../considerations/landing-zone-governance.md) <br><br> - [Improve landing zone security](../considerations/landing-zone-security.md) |

## Next steps

For considerations about implementing an Azure landing zone, explore the design areas in an Azure landing zone. Consider specific technical subjects for each landing zone.

> [!div class="nextstepaction"]
> [Azure landing zone design areas](./design-areas.md)
