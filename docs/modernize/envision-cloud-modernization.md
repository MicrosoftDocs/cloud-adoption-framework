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

*This article or (or set of articles it may become) is the primary deliverable of the "envision" portion of the modernize methodology documentation. Depending on how the three subsections develop, they may need to be broken into separate articles, and this one would serve as an index/introduction that link to all three.*

# Envision cloud modernization

This is a drill-down on the "envision" phase of the "modernize" methodology. It's phase 1 of business alignment for modernize. *This article should link to the [modernize overview](index.md).*

**Key takeaway of this article (or set of articles)**: Before beginning modernization at scale, understand business outcomes/motivations, understand your workloads, and map them to the outcomes you want to achieve.

Three key steps the customer should understand about envisioning a modernization strategy:

1. Understand your corporate & strategic motivations for modernization
1. Flag workloads which could better deliver on those motivations if they were to be modernized. Include links to establishing-cloud-horizons and migrate-modernize-approaches
1. Define & track *clusters* of workloads based on the motivation. Important to focus on the "clusters" aspect.

## Understand your corporate & strategic motivations for modernization

*Why* are you moving to the cloud? Which motivations should drive you to modernize instead of migrate?

:::image type="content" source="../_images/modernize/modernization-triggers.png" alt-text="img":::

- Enabling hybrid work: enabling scale, access across networks
- Faster time to market: PaaS + DevOps accelerates time to market
- Cost-optimizing applications: Reducing overall spend with PaaS
- Application innovation
- Centralizing data by migrating web apps and infrastructure

Further expand on each of these. For any given customer, it's likely that multiple apply.

In addition to the triggers shown here, there are other motivations that are good to understand. For a larger perspective on motivations for moving to the cloud, see [Motivations](../strategy/motivations.md).

## Flag workloads which could better deliver on those motivations if they were to be modernized

*What* are you moving? You don't modernize *assets*, you modernize *workloads*, so conceptually reorganize your infra, data stores and apps into workloads.

:::image type="content" source="../_images/modernize/assets-to-workloads.png" alt-text="img":::

If you've already done a migration and followed the "plan" best practices, you have likely done this exercise. If not (if you're starting with a modernization action):

- See [Cloud rationalization](../digital-estate/5-rs-of-rationalization.md) to understand what cloud rationalization is, how to conceptually break down your environment, make sense of dependencies and cross references, etc.
- [Perform a digital estate assessment](../plan/contoso-migration-assessment.md) to help map assets to workloads.

## Define & track *clusters* of workloads based on the motivation

Align groups of workloads to motivations. This gives you something to track and work against.

:::image type="content" source="../_images/modernize/align-workloads-motivations.png" alt-text="img":::

## Summary

*Key takeaway of this article (or set of articles)*: Before beginning modernization at scale, understand business outcomes/motivations, understand your workloads, and map them to the outcomes you want to achieve.

Next step is preparing for modernization: look across clusters of workloads and decide what to modernize.