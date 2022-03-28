---
title: Envision cloud modernization
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 3/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
---
<!--Acrolinx:98, TODO: meta description, more info for bulleted list? lines 30-35-->
# Envision cloud modernization

Modernization of your workloads can help you achieve the [common modernization motivations](../strategy/business-outcomes/data-innovations.md#data-innovations). Before you begin modernization efforts, it's important to understand your motivations and workloads. Then, you can start aligning or grouping workloads based on how they impact the strategy.

- What are the limitations of your current state workloads?

Understand the limitations of your current state workloads and best paths to modernization to help you set realistic expectations. Every cloud adoption plan contains three horizons: [Migrate](../get-started/migrate.md), [Modernize](index.md), and [Innovate](../get-started/innovate.md). These horizon efforts align to your modernization strategy. How do you determine whether to modernize or migrate first? We explore these options in [Migrate and modernization approaches](../adopt/migrate-modernize-approaches.md).

The following steps will help you envision your modernization strategy and end state, based on your strategic objectives.

## Step 1: Understand your corporate & strategic motivations for modernization

[Why are we moving to the cloud?](../strategy/motivations.md)? It's critical that you understand the limitations of your current state workloads and the best paths toward modernization. This understanding helps you set realistic expectations.

:::image type="content" source="../_images/modernize/modernization-triggers.png" alt-text="Image showing triggers for modernization.":::

It's likely that many of the following triggers apply to your [Motivations for cloud adoption](../strategy/motivations.md). Identify which of the following triggers are most important. This way you'll get your strategies down, so you'll better understand why you're moving to the cloud.

- Enabling hybrid work: enabling scale, access across networks, developer agility and productivity
- Faster time to market: PaaS + DevOps accelerates time to market
- Cost-optimizing applications: Reducing overall spend with PaaS
- Application innovation: Transformation of products or services, new technical capabilities
- Centralizing data by migrating web apps and infrastructure
- Operational modernization: to reduce business impact events, improving customer experience and engagement

<!--Further expand on each of these?-->
## Step 2: Flag workloads, which could better deliver on those motivations if they were to be modernized

What are you moving? We don't modernize assets, we modernize workloads, so conceptually reorganize your infrastructure, data stores, and apps into workloads.

:::image type="content" source="../_images/modernize/assets-to-workloads.png" alt-text="Image showing existing data center with multiple workloads, and then modernized workloads and assets grouped accordingly.":::

<!--link to breaking down adopt flow-->

If you've already done a migration and followed the "plan" best practices, you've likely done this exercise. If not (if you're starting with a modernization action), do the following actions:

- See [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization) to understand what cloud rationalization is. You'll also learn how to conceptually break down your environment, make sense of dependencies and cross references, and so on.
- [Perform a digital estate assessment](../plan/contoso-migration-assessment.md) to help map assets to workloads.
- [Assess workloads and refine plans](/migrate/azure-migration-guide/assess.md).
- [Review migration and modernization approaches](migrate-modernize-approaches.md) to understand the three adoption horizons,  and how to prioritize.
- Review the adoption horizons, [Migrate](../../migrate/index.md), [Modernize](index.md), and [Innovate](../../innovate/index.md) to help you prioritize your goals.

## Step 3: Define & track *clusters* of workloads based on the motivation

 We aren't modernizing or rearchitecting individual workloads. We're applying tactics that scale to a cluster of workloads, to change them all in similar ways. Align groups of workloads to your motivations, which gives you something to track and work against.

:::image type="content" source="../_images/modernize/align-workloads-motivations.png" alt-text="Image showing alignment of workload clusters with motivations.":::

## Next steps

Prepare for modernization: look across your clusters of workloads and decide what to modernize.
<!--link-->
