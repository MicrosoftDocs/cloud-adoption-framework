---
title: Envision cloud modernization
description: TODO
author: nickwalkmsft
ms.author: nickwalk
ms.date: 2/25/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
---

 Envision cloud modernization

The "envision" phase of the "modernize" methodology is the first phase of business alignment for modernization. For more information, see [Modernize overview](index.md).

Before you begin modernization at scale, understand business outcomes/motivations, understand your workloads, and map them to the outcomes you want to achieve. It's important to establish a rough vision of your end state before you begin your migration efforts. This article provides guidance on establishing Horizons based on your strategic objectives and to determine when to focus on migration vs. modernization.Every cloud adoption plan contains three horizons: [Migrate](../get-started/migrate.md), Modernize, and [Innovate](../get-started/innovate.md). It's important to understand the limitations of your current state workloads and best paths to modernization to help you set realistic expectations.

Before you make any decisions about modernization, align or group your workloads based on how they impact your strategy. Understand the following three key elements about envisioning a modernization strategy:

- [Understand your corporate & strategic motivations for modernization](#understand-your-corporate--strategic-motivations-for-modernization)
- [Flag workloads which could better deliver on those motivations if they were to be modernized](#flag-workloads-which-could-better-deliver-on-those-motivations-if-they-were-to-be-modernized)
- [Define & track *clusters* of workloads based on the motivation](#define--track-clusters-of-workloads-based-on-the-motivation)
- [Next steps](#next-steps)

## Understand your corporate & strategic motivations for modernization

*Why* are you moving to the cloud? Which motivations should drive you to modernize instead of migrate?

:::image type="content" source="../_images/modernize/modernization-triggers.png" alt-text="img":::

Identify which of the following triggers are most important to you. It's likely that multiple triggers apply.

- Enabling hybrid work: enabling scale, access across networks
- Faster time to market: PaaS + DevOps accelerates time to market
- Cost-optimizing applications: Reducing overall spend with PaaS
- Application innovation
- Centralizing data by migrating web apps and infrastructure
<!-->
Further expand on each of these.
-->
In addition to the triggers shown here, there are other motivations that are good to understand. For a larger perspective on motivations for moving to the cloud, see [Motivations](../strategy/motivations.md).

## Flag workloads which could better deliver on those motivations if they were to be modernized

*What* are you moving? You don't modernize *assets*, you modernize *workloads*, so conceptually reorganize your infrastructure, data stores, and apps into workloads.

:::image type="content" source="../_images/modernize/assets-to-workloads.png" alt-text="img":::

If you've already done a migration and followed the "plan" best practices, you have likely done this exercise. If not (if you're starting with a modernization action), see the following articles:

- [Cloud rationalization](../digital-estate/5-rs-of-rationalization.md) to understand what cloud rationalization is, how to conceptually break down your environment, make sense of dependencies and cross references, and so on.
- [Perform a digital estate assessment](../plan/contoso-migration-assessment.md) to help map assets to workloads.

## Define & track *clusters* of workloads based on the motivation

Align groups of workloads to motivations. This gives you something to track and work against.

:::image type="content" source="../_images/modernize/align-workloads-motivations.png" alt-text="img":::

## Next steps

After you get these workloads aligned to motivations, what are you going to modernize?

NEXTSTEPACTION
> [!div class="nextstepaction"]
> [Evaluate your clusters of workloads](.................)