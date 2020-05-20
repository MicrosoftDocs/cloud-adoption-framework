---
title: Expand your landing zone
description: Use the Cloud Adoption Framework for Azure to learn how to expand a landing zone.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: overview
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Expand your landing zone

This section of the Ready methodology builds on the principles of [landing zone refactoring](../landing-zone/refactor.md). As outlined in that article, a refactoring approach to infrastructure as code removes blockers to business success while minimizing risk. This series of articles assumes that you've deployed your first landing zone and would now like to expand that landing zone to meet enterprise requirements.

## Shared architecture principles

Expanding your landing zone provides a code-first approach to embedding the following principles into the landing zone and more broadly into your overall cloud environment.

![Shared architecture principles](../../_images/ready/shared-principles.png)

These same architecture principles are shared by [Azure Advisor](https://docs.microsoft.com/azure/advisor/advisor-overview), [Microsoft Azure Well-Architected Framework](https://docs.microsoft.com/azure/architecture/framework), and the solutions in the [Azure Architecture Center](https://docs.microsoft.com/azure/architecture).

## Applying these principles to your landing zone improvements

To better align with the methodologies of the Cloud Adoption Framework, the principles above are grouped into actionable landing zone improvements:

- Basic considerations: Refactor a landing zone to refine hosting, fundamentals, and other foundational elements.
- Operations expansions: Add operations management configurations to improve **performance, reliability, and operational excellence**.
- Governance expansions: Add governance configurations to improve **cost, reliability, security**, and consistency.
- Security expansions: Add **security** configurations to improve protection of sensitive data and critical systems.

> [!WARNING]
> Adoption teams who have a mid-term objective (within 24 months) to **host more than 1,000 assets (apps, infrastructure, or data assets) in the cloud** should consider each of these expansions early in their cloud adoption journey. For all other adoption patterns, landing zone expansions could be a parallel iteration, allowing for early business success.

## Next steps

Before refactoring your first landing zone, it is important to understand [test-driven development of landing zones](./test-driven-development.md).

> [!div class="nextstepaction"]
> [Test-driven development of landing zones](./test-driven-development.md)
