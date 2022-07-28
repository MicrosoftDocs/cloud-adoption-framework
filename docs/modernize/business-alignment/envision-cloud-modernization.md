---
title: Envision cloud modernization
description: Learn how understanding your cloud adoption motivations help you establish your approach to the modernization horizons, as part of your cloud adoption-related modernization plan.
author: BrianBlanchard
ms.author: chcomley
ms.date: 07/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: envision, motivations, approach, modernization, cloud adoption framework
---
# Envision cloud modernization

Envisioning modernization starts with understanding your cloud adoption motivations. We call these your "modernization triggers." These modernization triggers are your business goals. In this business alignment process, you'll (1) identify your modernization triggers, (2) identify workloads, and (3) algin workload clusters with modernization triggers.

The following steps help you envision your modernization strategy and end state, based on your strategic objectives.

## Step 1: Identify Modernization Triggers

:::image type="content" source="../../_images/modernize/modernization-triggers.png" alt-text="Image showing triggers for modernization.":::

 The reasons you want to modernize are your "modernization triggers." These are motivations behind your [technical](evaluate-modernization-options.md#technical-indicators) [investments](evaluate-modernization-options.md#financial-indicators). Modernization triggers are unique to your business, but commonalities exist across businesses and industries:

**We need to align the following link to this page. The graphics don't line up. [motivations for cloud adoption](../../strategy/motivations.md).**

- **Enabling hybrid work:** Make applications accessible and secure for remote productivity.
- **Faster time to market:** Increase deployment speed to see a faster return-on-investment.
- **Cost-optimizing applications:** Gain operational efficiencies to drive down the cost of ownership.
- **Application innovation:** Adopt new technologies and architectures to enable rapid innovation.
- **Centralize data:** Store application data in a centralized repository to enhance security, reduce redundancy, and drive transparency.

Knowing *why* you are modernizing will determine *what* to modernize.

## Step 2: Identify workloads

A [workload](../../plan/workloads.md) is a collection of IT assets that support a business process. You can separate IT assets into three categories: infrastructure, applications, and data. You can stop thinking about maintaining IT assets as you would in existing data center(s) (*see figure*)

:::image type="content" source="../../_images/modernize/existing-datacenters.png" alt-text="Graphic showing existing data center.":::

 Instead, you should focus on workloads. Prioritize the business processes that will have the most impact on your business. Then, identify the workloads that support these processes. These are the high-priority processes that you will want to target. Once you identify these high-priority workloads, you will want to group them into clusters (*see figure*).

:::image type="content" source="../../_images/modernize/workload-clusters.png" alt-text="Graphic showing workload clusters.":::

 Applying modernizations to clusters of workloads will create the greatest business impact. Avoid rearchitecting individual workloads until you have modernized workload clusters. Follow the [Well-Architected Framework](/well-architected-pr/well-architected/index.md) when rearchitecting individual workloads.

## Step 3: Identify workload clusters that align with your modernization triggers

When you align groups of workloads to your motivations, you have something to track and work against.

:::image type="content" source="../../_images/modernize/align-workload-motivations.png" alt-text="Image showing alignment of workload clusters with motivations.":::

## Next steps

Once you've mapped your motivations to workloads, determine your approach.

> [!div class="nextstepaction"]
> [Approaches to cloud migration and modernization](../../adopt/migrate-modernize-approaches.md).
