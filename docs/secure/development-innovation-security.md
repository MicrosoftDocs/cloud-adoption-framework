---
title: Development innovation security
description: Different organizations stress rapid innovation to stay competitive, while others remain intolerant of brand damage—even from an otherwise minor test application that could be compromised.
author: mpvenables
ms.author: mas
ms.date: 03/06/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: secure
ms.custom: internal
---

# Development innovation security

## Balancing innovation speed and security
Calculating your enterprise risk appetite is variable, and dependent on continuously balancing the level of innovation your organization pursues to meet customer demands and your accountability for security to customers, shareholders, and regulators.

Different organizations stress rapid innovation to stay competitive, while others remain intolerant of brand damage—even from an otherwise minor test application that could be compromised.

Balance innovation speed and security in your organization. Make use of [Azure landing zone policy-driven governance](/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance) design, which provides guardrails for your organization's platform (and the applications deployed on it). Read more about how to [adopt policy-driven rails in your resource organization](/azure/cloud-adoption-framework/ready/enterprise-scale/dine-guidance). Read more about the [hierarchy of management groups and subscriptions](/azure/governance/management-groups/overview), and creating [top-level sandbox management groups](/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups#management-group-recommendations).

## Incremental and continuous improvements

1. Involve all your stakeholders in seeking balance to drive innovation with continuous improvement in the development lifecycle. Iteratively improve the process, not just the apps that move through development, across aspects of innovation such as speed, security, etc.
2. Define a successful and sustainable innovation minimum viable product (MVP) for your organization. It must meet minimum critical attributes across DevSecOps domains: 
3. Development—meets business requirements for market and customer relevance and responsiveness to evolving needs
4. Security—ensures safety, confidentiality, integrity, and availability
5. Operations—satisfies quality, performance, and reliability standards
6. This is a massive cultural shift that establishes Shift Left as a natural part of technical ideation and development—the best practice of *integrating security early into the process* because fixing issues earlier is cheaper and more effective than waiting until they are found in production systems (often as attackers exploit the workload and cause business damage).
7. Implementing security + innovation in development practices will require modifying existing DevOps processes—and sometimes adding in new elements that fit naturally into the process.
8. These incremental practices should be fine-tuned to generate healthy friction among team members that generates important bugs to fix, and valuable critical thinking like threat modeling to understand the attacker “user persona” and avoiding unhealthy friction, wasted effort, and antipatterns.

## Native innovation efficiencies

Natively integrate security, identity, compliance standards, and other efficiencies into your development process to create invisible guardrails that do not slow down developer innovation. Educate all teams on innovation efficiencies—and engage all teams on them. 

Remaining flexible is critical in the continuous assembly of innovation. Some innovation and DevOps programs are still unstructured and in process. Ensure that you adapt security elements and tailor the approach to individual developer team and the process maturity/structure stage they are in at that point in time. 

## Integrate security into the development process

![Integrating Security into Development](./media/devops-integrated-security-lifecycle-model.png)

As pictured in the diagram above, DevOps adds agility and speed by bringing together (planning + developing) and (testing+ production). This bias toward speed mitigates enterprise risk through rapid updates, as opposed to a deep scan before release. Security’s role during this innovation motion changes from traditional quality gateway to integral process towards lowering risk (seen as incremental increases of the team's knowledge and education, process updates, etc.).

We recommend that your organization shift from a Waterfall development cycle to a DevOps lifecycle of rapid incremental releases for applications. The DevOps model (illustrated in the diagram above by comparison) increases your ability to rapidly address security concerns without Waterfall's longer planning and testing cycle. And, DevOps brings many non-security benefits, allowing you to increase responsiveness to your customers and internal user requirements in a rapidly evolving marketplace. 

## Shift Left

As time progress, continually look to increase security in your DevOps processes using a Shift-left approach. This security engineering approach continually looks integrates security earlier in the development lifecycle and operations (OSA) processes, which make security issues both easier and easier to fix, rather than catching them late (right) in the process when design, implementation, and operation changes are much more difficult and more expensive to integrate. It's critical to incorporate governance, risk, and compliance considerations into your strategy to ensure security and the Shift-left approach are sustained over time.

## Next steps:

- [Securing DevOps strategy and process](devops-strategy-process-security.md)
