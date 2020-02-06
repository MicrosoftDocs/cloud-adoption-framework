---
title: "Standard enterprise governance guide"
description: Standard enterprise governance guide
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/05/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: governance
---

# Standard enterprise governance guide

## Overview of best practices

This governance guide follows the experiences of a fictional company through various stages of governance maturity. It is based on real customer experiences. The best practices are based on the constraints and needs of the fictional company.

As a quick starting point, this overview defines a minimum viable product (MVP) for governance based on best practices. It also provides links to some governance improvements that add further best practices as new business or technical risks emerge.

> [!WARNING]
> This MVP is a baseline starting point, based on a set of assumptions. Even this minimal set of best practices is based on corporate policies driven by unique business risks and risk tolerances. To see if these assumptions apply to you, read the [longer narrative](./narrative.md) that follows this article.

### Governance best practices

These best practices serve as a foundation for an organization to quickly and consistently add governance guardrails across your subscriptions.

### Resource organization

The following diagram shows the governance MVP hierarchy for organizing resources.

![Diagram of resource organization](../../../_images/govern/resource-organization.png)

Every application should be deployed in the proper area of the management group, subscription, and resource group hierarchy. During deployment planning, the cloud governance team will create the necessary nodes in the hierarchy to empower the cloud adoption teams.

1. One management group for each type of environment (such as production, development, and test).
2. Two subscriptions, one for production workloads and another for nonproduction workloads.
3. [Consistent nomenclature](../../../ready/azure-best-practices/naming-and-tagging.md) should be applied at each level of this grouping hierarchy.
4. Resource groups should be deployed in a manner that considers its contents lifecycle: everything that is developed together, is managed together, and retires together goes together. For more information on resource group best practices, [see here](../../../decision-guides/resource-consistency/index.md).
5. [Region selection](../../../decision-guides/regions/index.md) is incredibly important and must be considered so that networking, monitoring, auditing can be in place for failover/failback as well as confirmation that [needed SKUs are available in the preferred regions](https://azure.microsoft.com/global-infrastructure/services).

Here is an example of this pattern in use:

![Resource organization example for a mid-market company](../../../_images/govern/mid-market-resource-organization.png)

These patterns provide room for growth without complicating the hierarchy unnecessarily.

[!INCLUDE [governance-of-resources](../../../../includes/caf-governance-of-resources.md)]

## Iterative governance improvements

Once this MVP has been deployed, additional layers of governance can be incorporated into the environment quickly. Here are some ways to improve the MVP to meet specific business needs:

- [Security Baseline for protected data](./security-baseline-improvement.md)
- [Resource configurations for mission-critical applications](./resource-consistency-improvement.md)
- [Controls for Cost Management](./cost-management-improvement.md)
- [Controls for multicloud evolution](./multicloud-improvement.md)

<!-- markdownlint-disable MD026 -->

## What does this guidance provide?

In the MVP, practices and tools from the [Deployment Acceleration](../../deployment-acceleration/index.md) discipline are established to quickly apply corporate policy. In particular, the MVP uses Azure Blueprints, Azure Policy, and Azure management groups to apply a few basic corporate policies, as defined in the narrative for this fictional company. Those corporate policies are applied using Resource Manager templates and Azure policies to establish a small baseline for identity and security.

![Example of an incremental governance MVP](../../../_images/govern/governance-mvp.png)

## Incremental improvement of governance practices

Over time, this governance MVP will be used to improve governance practices. As adoption advances, business risk grows. Various disciplines within the Cloud Adoption Framework governance model will change to manage those risks. Later articles in this series discuss the incremental improvement of corporate policy affecting the fictional company. These improvements happen across three disciplines:

- Cost Management, as adoption scales.
- Security Baseline, as protected data is deployed.
- Resource Consistency, as IT Operations begins supporting mission-critical workloads.

![Example of an incremental governance MVP](../../../_images/govern/governance-improvement.png)

## Next steps

Now that you're familiar with the governance MVP and have an idea of the governance improvements to follow, read the supporting narrative for additional context.

> [!div class="nextstepaction"]
> [Read the supporting narrative](./narrative.md)
