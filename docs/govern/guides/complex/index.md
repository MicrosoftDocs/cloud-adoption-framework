---
title: Governance guide for complex enterprises
description: Follow a fictional complex enterprise through various stages of governance maturity, as it defines a minimum viable product (MVP) based on best practices.
author: martinekuan
ms.author: martinek
ms.date: 06/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Governance guide for complex enterprises

This governance guide follows the experiences of a fictional company through various stages of their governance maturity. The guide is based on real customer experiences, and the suggested best practices are based on the constraints and needs of the fictional company.

## Best practices overview

As a quick starting point, this overview defines a minimum viable product (MVP) for governance based on best practices. It also provides links to some governance improvements that add further best practices as new business or technical risks emerge.

> [!IMPORTANT]
> This MVP is a baseline starting point built on a set of assumptions. Even this minimal set of best practices is based on corporate policies driven by unique business risks and risk tolerances. Read the [longer narrative](./narrative.md) that follows this article to check whether this set of assumptions apply to your situation.

### Governance best practices

These best practices serve as a foundation for your organization to quickly and consistently add governance guardrails across multiple Azure subscriptions.

### Resource organization

Refer to the [management group](../../../ready/landing-zone/design-area/resource-org-management-groups.md) and [subscription](../../../ready/landing-zone/design-area/resource-org-subscriptions.md) organization and governance Cloud Adoption Framework documentation to find detailed guidance relative to designing your cloud environment.  The governance MVP used in this scenario incorporates the recommendations provided in the above documentation and follows the design pattern provided in the [Azure landing zone conceptual architecture](../../../ready/landing-zone/index.md#azure-landing-zone-conceptual-architecture).

The following diagram contains the governance MVP hierarchy for resource organization.

![Diagram of resource organization.](../../../_images/govern/resource-organization.png)

#### Additional recommendations

- Deploy every application in the appropriate area of your management group, subscription, and resource group hierarchy. During deployment planning, your cloud governance team needs to create the necessary nodes in this hierarchy to empower your cloud adoption teams.

- Apply [consistent nomenclature](../../../ready/azure-best-practices/naming-and-tagging.md) within each level of your grouping hierarchy.

- Consider content lifecycle when you deploy resource groups: things that are developed together, managed together, and retire together go together. For more information on resource group best practices, see the [resource consistency decision guide](../../../decision-guides/resource-consistency/index.md).

- Consider [region selection](../../../migrate/azure-best-practices/multiple-regions.md) so you can ensure that networking, monitoring, and auditing are in place for failover/failback and confirmation that [needed SKUs are available in the preferred regions](https://azure.microsoft.com/global-infrastructure/services/).

The Azure landing zone conceptual architecture patterns provide room for growth without unnecessarily complicating your hierarchy.

[!INCLUDE [governance-of-resources](../../../../includes/governance-of-resources.md)]

<!-- TODO: See comments for suggestion to possibly add here -->

## Incremental governance improvements

Once you deploy the MVP, you can incorporate additional layers of governance into the environment quickly. Here are some ways you can improve the MVP to meet specific business needs:

- [Security baseline for protected data](./security-baseline-improvement.md)
- [Resource configurations for mission-critical applications](./resource-consistency-improvement.md)
- [Controls for cost management](./cost-management-improvement.md)
- [Controls for incremental multicloud improvement](./multicloud-improvement.md)

## What does this guidance provide?

Practices and tools from the [Deployment Acceleration discipline](../../deployment-acceleration/index.md) are established in the MVP so you can quickly apply corporate policy. The MVP relies on Azure Blueprints, Azure Policy, and Azure management groups to apply a few basic corporate policies, as defined in the narrative for our example fictional company. You can use Azure Resource Manager templates and Azure policies to apply these corporate policies. establish a small baseline for identity and security.

![Diagram showing an example of an incremental governance MVP.](../../../_images/govern/governance-mvp.png)

## Incremental improvement of governance practices

Over time, you can use this governance MVP to improve governance practices. As adoption advances, business risk grows. Various disciplines within the Cloud Adoption Framework governance model will continue to change to manage those risks. Articles later in this series discuss how incremental improvements to corporate policy affect a fictional company. These improvements are made across four disciplines:

- The Identity Baseline discipline, as you change migration dependencies in the narrative.
- The Cost Management discipline, as you scale your adoption.
- The Security Baseline discipline, as you deploy protected data.
- The Resource Consistency discipline, as your IT operations begin supporting mission-critical workloads.

![Diagram showing an example of incremental improvements to governance practices.](../../../_images/govern/governance-improvement-large.png)

## Next steps

Now that you're familiar with the governance MVP and the forthcoming governance changes, read the supporting narrative for additional context.
> [!div class="nextstepaction"]
> [Read the supporting narrative](./narrative.md)

