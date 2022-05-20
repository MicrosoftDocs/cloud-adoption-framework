---
title: Envision cloud modernization
description: Learn how understanding your cloud adoption motivations help you establish your approach to the modernization horizons, as part of your cloud adoption-related modernization plan.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/20/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal, seo-caf-modernize
keywords: envision, motivations, approach, modernization, cloud adoption framework
---
# Envision cloud modernization

Before you begin modernization efforts, it's important to share a clear *vision* of your goals and objectives. Moving forward without a vision is like sailing a ship without a compass: The ship is going somewhere, but where? Do the crew members know where they're going? Will the passengers arrive to where they paid to go?

Envisioning modernization starts with understanding your cloud adoption motivations and how they relate to the workloads that you'll modernize. These motivations help you envision and establish your approach to the [modernization horizons](../../adopt/index.md).

Every cloud adoption plan contains three horizons: [Migrate](../../get-started/migrate.md), [Modernize](index.md), and [Innovate](../../get-started/innovate.md). These horizons align to your modernization strategy. How do you determine whether to modernize or migrate first? We explore these options in [Migration and modernization approaches](../../adopt/migrate-modernize-approaches.md).

The following steps help you envision your modernization strategy and end state, based on your strategic objectives.

## Step 1: Understand your corporate & strategic motivations for modernization

Some of the common modernization triggers include the need to deliver applications and features faster, urgent capacity needs, or a software or hardware refresh.

:::image type="content" source="../../_images/modernize/modernization-triggers.png" alt-text="Image showing triggers for modernization.":::

The modernize methodology in the Cloud Adoption Framework focuses on motivations aligned to technology.
It's likely that many of the following triggers apply to your [motivations for cloud adoption](../../strategy/motivations.md). Identify which of the following triggers signal that you're looking to modernize and identify inside your business what's most important to you. Likely, multiple triggers apply.

- **Enable hybrid work:** Hybrid helps you to scale and move across networks, which allows internal people to jump in and get to applications the way they need to, and when they need to. Hybrid increases developer agility and productivity.
- **Faster time to market:** PaaS gives you faster acceleration to get an application and application updates out to market, especially when you couple with some DevOps strategies.
- **Cost-optimizing applications:** Reduce the overall spending of individual apps or workloads with PaaS.
- **Application innovation:** With the transformation of products or services and new technical capabilities, you have less dependency on infrastructure. You gain the ability to have portable applications, so you can start to innovate applications beyond boundaries.
- **Centralize data:** Migrate your web apps and infrastructure to the cloud and modernize the underlying data set.

There are many other motivations that you might be considering when you go to the cloud. Evaluating your modernization options includes exploring your motivations from a [technical](evaluate-modernization-options.md#technical-indicators) and [financial](evaluate-modernization-options.md#financial-indicators) perspective. It's good to understand those motivations including your modernization triggers versus [innovation types of triggers](/azure/cloud-adoption-framework/innovate/).

When you know *why* you're moving to the cloud, you can make better technical decisions.

## Step 2: Flag workloads, which could better deliver on those motivations if they were to be modernized

Modernization of your workloads can help you achieve the [common modernization motivations](../../strategy/business-outcomes/data-innovations.md#data-innovations).

It's critical that you understand the limitations of your current state workloads and the best paths toward modernization. This understanding helps you set realistic expectations. *What are you moving?* We don't modernize assets, we modernize workloads, so conceptually reorganize your infrastructure, data stores, and apps into workloads. Then, you can start aligning or grouping workloads based on how they impact the strategy.

<!--link to breaking down adopt flow-->

If you've already done a migration and followed the "plan" best practices, you've likely done this exercise. If not (if you're starting with a modernization action), do the following tasks:

- See [Cloud rationalization](/azure/cloud-adoption-framework/digital-estate/5-rs-of-rationalization) to understand what cloud rationalization is. You'll also learn how to conceptually break down your environment, make sense of dependencies and cross references, and so on.
- [Perform a digital estate assessment](../../plan/contoso-migration-assessment.md) to help map assets to workloads.
- [Assess workloads and refine plans](../../migrate/azure-migration-guide/assess.md).
- [Review migration and modernization approaches](../../adopt/migrate-modernize-approaches.md) to understand the three adoption horizons and how to prioritize.
- Review the adoption horizons, [Migrate](./../../migrate/index.md), [Modernize](index.md), and [Innovate](../../innovate/index.md) to help you prioritize your goals.

## Step 3: Define & track *clusters* of workloads based on the motivation

In any existing datacenter, you have lots of information from different data sources and many applications. When you move to the cloud and approach modernization, you need to rethink about your datacenter from a context of workloads. We aren't modernizing or rearchitecting individual workloads, we're applying tactics that scale to a cluster of workloads, to change them all in similar ways.

Generally, a workload is a combination of apps and data coming together to solve a business problem. You'll want to classify those assets that you have in your data center today. The following image shows an example of an existing data center's apps, infrastructure, and data.

:::image type="content" source="../../_images/modernize/existing-datacenters.png" alt-text="Graphic showing existing data center.":::

Inside of a workload classification system, if you've already done a migration and you followed the best practices in your plan, you already have clusters of workloads, like in the following image.

:::image type="content" source="../../_images/modernize/workload-clusters.png" alt-text="Graphic showing workload clusters.":::

When you align groups of workloads to your motivations, you have something to track and work against.

:::image type="content" source="../../_images/modernize/align-workload-motivations.png" alt-text="Image showing alignment of workload clusters with motivations.":::

## Next steps

Once you've mapped your motivations to workloads, you'll need to determine your approach.

> [!div class="nextstepaction"]
> [Migration and modernization approaches](../../adopt/migrate-modernize-approaches.md)
