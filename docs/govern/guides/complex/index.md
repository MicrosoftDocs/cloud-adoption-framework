---
title: Governance guide for complex enterprises
description: Follow a fictional complex enterprise through various stages of governance maturity, as it defines a minimum viable product (MVP) based on best practices.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Governance guide for complex enterprises

## Overview of best practices

This governance guide follows the experiences of a fictional company through various stages of governance maturity. It's based on real customer experiences. The suggested best practices are based on the constraints and needs of the fictional company.

As a quick starting point, this overview defines a minimum viable product (MVP) for governance based on best practices. It also provides links to some governance improvements that add further best practices as new business or technical risks emerge.

> [!WARNING]
> This MVP is a baseline starting point, based on a set of assumptions. Even this minimal set of best practices is based on corporate policies that are driven by unique business risks and risk tolerances. To see whether these assumptions apply to you, read the [longer narrative](./narrative.md) that follows this article.

### Governance best practices

These best practices serve as a foundation for an organization to quickly and consistently add governance guardrails across multiple Azure subscriptions.

### Resource organization

The following diagram shows the governance MVP hierarchy for organizing resources.

![Diagram of resource organization](../../../_images/govern/resource-organization.png)

Every application should be deployed in the proper area of the management group, subscription, and resource group hierarchy. During deployment planning, the cloud governance team will create the necessary nodes in the hierarchy to empower the cloud adoption teams.

1. Define a management group for each business unit with a detailed hierarchy that reflects geography first, then environment type (for example, production or nonproduction environments).

1. Create a production subscription and a nonproduction subscription for each unique combination of discrete business unit or geography. Creating multiple subscriptions requires careful consideration. For more information, see the [subscription decision guide](../../../decision-guides/subscriptions/index.md).

1. Apply [consistent nomenclature](../../../ready/azure-best-practices/naming-and-tagging.md) at each level of this grouping hierarchy.

1. Resource groups should be deployed in a manner that considers its contents lifecycle. Resources that are developed together, managed together, and retired together belong in the same resource group. For more information about best practices for using resource groups, see the [resource consistency decision guide](../../../decision-guides/resource-consistency/index.md).

1. [Region selection](../../../migrate/azure-best-practices/multiple-regions.md) is incredibly important and must be considered so that networking, monitoring, auditing can be in place for failover/failback as well as confirmation that [needed SKUs are available in the preferred regions](https://azure.microsoft.com/global-infrastructure/services/).

![Diagram of large enterprise resource organization](../../../_images/govern/large-enterprise-resource-organization.png)

These patterns provide room for growth without making the hierarchy needlessly complicated.

[!INCLUDE [governance-of-resources](../../../../includes/governance-of-resources.md)]

<!-- TODO: See comments for suggestion to possibly add here -->

## Incremental governance improvements

Once this MVP has been deployed, additional layers of governance can be quickly incorporated into the environment. Here are some ways to improve the MVP to meet specific business needs:

- [Security baseline for protected data](./security-baseline-improvement.md)
- [Resource configurations for mission-critical applications](./resource-consistency-improvement.md)
- [Controls for cost management](./cost-management-improvement.md)
- [Controls for incremental multicloud improvement](./multicloud-improvement.md)

## What does this guidance provide?

In the MVP, practices and tools from the [Deployment Acceleration discipline](../../deployment-acceleration/index.md) are established to quickly apply corporate policy. In particular, the MVP uses Azure Blueprints, Azure Policy, and Azure management groups to apply a few basic corporate policies, as defined in the narrative for this fictional company. Those corporate policies are applied using Azure Resource Manager templates and Azure policies to establish a small baseline for identity and security.

![Diagram showing an example of an incremental governance MVP.](../../../_images/govern/governance-mvp.png)

## Incremental improvements to governance practices

Over time, this governance MVP will be used to incrementally improve governance practices. As adoption advances, business risk grows. Various disciplines within the Cloud Adoption Framework governance model will adapt to manage those risks. Later articles in this series discuss the changes in corporate policy affecting the fictional company. These changes happen across four disciplines:

- The Identity Baseline discipline, as migration dependencies change in the narrative.
- The Cost Management discipline, as adoption scales.
- The Security Baseline discipline, as protected data is deployed.
- The Resource Consistency discipline, as IT operations begins supporting mission-critical workloads.

![Diagram showing an example of incremental improvements to governance practices.](../../../_images/govern/governance-improvement-large.png)

## Next steps

Now that you're familiar with the governance MVP and the forthcoming governance changes, read the supporting narrative for additional context.

> [!div class="nextstepaction"]
> [Read the supporting narrative](./narrative.md)
