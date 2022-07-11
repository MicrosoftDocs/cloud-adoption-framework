---
title: Govern methodology for the cloud
description: Use an incremental governance approach based on a minimum viable product (MVP) to support corporate policies and move quickly toward cloud adoption.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Govern methodology for the cloud

Adopting the cloud is a journey, not a destination. Along the way, there are clear milestones and tangible business benefits. The final state of cloud adoption is unknown when a company begins the journey. Cloud governance creates guardrails that keep the company on a safe path throughout the journey.

The Cloud Adoption Framework provides governance guides. These guides describe the experiences of fictional companies based on the experiences of real customers. Each guide follows the customer through the governance aspects of their cloud adoption.

## Envision an end state

A journey without a target destination is just wandering. It's important to establish a rough vision of the end state before taking the first step. The following infographic provides a frame of reference for the end state. It's not your starting point, but it shows your potential destination.

![Infographic of the Cloud Adoption Framework governance model.](../_images/operational-transformation-govern-large.png)

The Cloud Adoption Framework governance model identifies key areas of importance during the journey. Each area relates to different types of risks the company must address as it adopts cloud services. Within this framework, the governance guide identifies required actions for the cloud governance team. Along the way, each principle of the Cloud Adoption Framework governance model is described further. Broadly, these include:

### Corporate policies

Corporate policies drive cloud governance. The governance guide focuses on specific aspects of corporate policy:

- **Business risks:** Identifying and understanding corporate risks.
- **Policy and compliance:** Converting risks into policy statements that support any compliance requirements.

### Processes

- Ensuring adherence to the stated policies.

**Five Disciplines of Cloud Governance:** These disciplines support the corporate policies. Each discipline protects the company from potential pitfalls:

- Cost Management discipline
- Security Baseline discipline
- Resource Consistency discipline
- Identity Baseline discipline
- Deployment Acceleration discipline

Essentially, corporate policies serve as an early warning system to detect potential problems. The disciplines help the company manage risks and create guardrails.

## Grow to the end state

Governance requirements might change throughout the cloud adoption journey, so a different approach to governance is required. Companies can't wait for a small team to build guardrails and roadmaps on every highway before taking the first step. Business results are expected more quickly and smoothly. IT governance must also move quickly, keep pace with business demands, and stay relevant during cloud adoption to avoid Shadow IT.

An incremental governance approach empowers these traits. Incremental governance relies on a small set of corporate policies, processes, and tools to establish a foundation for adoption and governance. That foundation is called a minimum viable product (MVP). An MVP allows the governance team to quickly incorporate governance into implementations throughout the adoption lifecycle. You can establish an MVP at any point during the cloud adoption process. It's a good practice to adopt an MVP as early as possible.

The ability to respond rapidly to changing risks empowers the cloud governance team to engage in new ways. The cloud governance team can join the cloud strategy team as scouts. Governance teams are then ahead of the cloud adoption teams, plotting routes, and quickly establishing guardrails to manage risks associated with adoption plans. These just-in-time governance layers are known as governance iterations. With this approach, governance strategy grows one step ahead of the cloud adoption teams.

The following diagram shows a simple governance MVP and three governance iterations. During the iterations, additional corporate policies are defined to remediate new risks. The Deployment Acceleration discipline then applies those changes across each deployment.

![Diagram that shows an example of incremental governance improvement.](../_images/govern/incremental-governance-example.png)

> [!NOTE]
> Governance isn't a replacement for key functions such as security, networking, identity, finance, DevOps, or operations. Along the way, there will be interactions and dependencies on members from each function. Include those members on the cloud governance team to accelerate decisions and actions.

## Next steps

Learn to use the Cloud Adoption Framework governance benchmark tool to assess your transformation journey. This might help you identify gaps in your organization across six key domains, as defined in the framework.

> [!div class="nextstepaction"]
> [Assess your transformation journey](./benchmark.md)
