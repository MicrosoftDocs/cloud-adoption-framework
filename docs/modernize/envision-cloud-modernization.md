---
title: Envision cloud modernization
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 3/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
---

 <!--
Approach and examples of how modernization of workloads can help customers achieve the common modernization motivations (listed under Innovation in the motivations articles in CAF Strategy). Should include guidance on establishing Horizons based on strategic objectives to determine when to focus on migration vs modernization.
But before making decisions about modernization, we need to start aligning or grouping workloads based on how they impact the strategy.
From CAF
- Operational modernization to reduce business impact events
- Preparation for new technical capabilities
- Building new technical capabilities
- Scaling to meet market demands
- Scaling to meet geographic demands
- Improved customer experiences and engagements
- Transformation of products or services
- Market disruption with new products or services
- Democratization and/or self-service environments
From Modernization assessment
- Increase agility
- Developer productivity
- Cost
- Security
- Increase speed of innovation
Understand limitations of current state workloads & best paths to modernization to help customers set realistic expectations.
-->

# Envision cloud modernization

Before you begin modernization efforts, it's important to understand your business motivations and  workloads, and then map those workloads to the outcomes that you want to achieve.

<!--to determine when to focus on migration vs modernization. Every cloud adoption plan contains three horizons: [Migrate](../get-started/migrate.md), Modernize, and [Innovate](../get-started/innovate.md). It's important to understand the limitations of your current state workloads and best paths to modernization to help you set realistic expectations. CAF Strategy outlines motivations and strategic considerations. Within Modernize, we're working on Horizon efforts, which align to a modernization strategy.-->

The following steps will help you envision your modernization strategy and end state, based on your strategic objectives.

## Step 1: Understand your corporate & strategic motivations for modernization

*Why* are you moving to the cloud? It's critical that you understand the limitations of your current state workloads and the best paths toward modernization. This helps you set realistic expectations. For more information, see [Why are we moving to the cloud?](../strategy/motivations.md).

:::image type="content" source="../_images/modernize/modernization-triggers.png" alt-text="Image showing triggers for modernization.":::

It's likely that many of the following triggers apply to your scenario. Identify which triggers are most important.

- Enabling hybrid work: enabling scale, access across networks
- Faster time to market: PaaS + DevOps accelerates time to market
- Cost-optimizing applications: Reducing overall spend with PaaS
- Application innovation
- Centralizing data by migrating web apps and infrastructure

<!--Further expand on each of these.
Get your strategies down, so you understand why you're moving.-->
## Step 2: Flag workloads which could better deliver on those motivations if they were to be modernized

What are you moving? You don't modernize assets, you modernize workloads, so conceptually reorganize your infrastructure, data stores and apps into workloads.

:::image type="content" source="../_images/modernize/assets-to-workloads.png" alt-text="Image showing existing data center with multiple workloads, and then modernized workloads and assets grouped accordingly.":::

<!--link to breaking down adopt flow-->

If you've already done a migration and followed the "plan" best practices, you have likely done this exercise. If not (if you're starting with a modernization action):

- See [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization) to understand what cloud rationalization is, how to conceptually break down your environment, make sense of dependencies and cross references, and so on.
- [Perform a digital estate assessment](../plan/contoso-migration-assessment.md) to help map assets to workloads.
- [Assess workloads and refine plans](/migrate/azure-migration-guide/assess.md).
- [Review migration and modernization approaches](migrate-modernize-approaches.md).
- Review the adoption horizons, [Migrate](../../migrate/index.md), [Modernize](index.md), and [Innovate](../../innovate/index.md).

## Step 3: Define & track *clusters* of workloads based on the motivation

 We aren't modernizing or rearchitecting individual workloads. We're applying tactics that scale to a cluster of workloads, to change them all in similar ways. Align groups of workloads to your motivations. This gives you something to track and work against.

:::image type="content" source="../_images/modernize/align-workloads-motivations.png" alt-text="Image showing alignment of workload clusters with motivations.":::

## Next steps

Prepare for modernization: look across your clusters of workloads and decide what to modernize.
<!--link-->
