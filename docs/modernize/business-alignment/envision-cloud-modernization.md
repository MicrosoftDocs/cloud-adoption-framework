---
title: Envision cloud modernization possibilities
description: Learn how understanding your cloud adoption motivations help you establish your approach to the modernization horizons, as part of your cloud adoption-related modernization plan.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: envision, motivations, approach, modernization, cloud adoption framework
---
# Envision cloud modernization possibilities

Envisioning modernization starts with understanding your cloud adoption motivations. These modernization motivations are your business goals. Your motivations will determine what you should modernize. Follow these steps to identify your motivations and the workloads you should modernize.

:::image type="content" source="../../_images/modernize/envision/envision.png" alt-text="Image showing where you are in the business alignment process.":::

## Step 1: Identify modernization motivations

 Modernization motivations are the reasons you want to modernize. They drive revenue, improve productivity, and increase margins. Your motivations will be unique to your business goals. But commonalities exist across businesses and industries (*see figure*).

:::image type="content" source="../../_images/modernize/envision/modernization-motivations.png" alt-text="Image showing modernization motivations.":::

**Explaining Motivations:** Here are a some of the most common modernization triggers across industries:

- *Enabling hybrid work:* Make applications accessible and secure for remote productivity.
- *Faster time to market:* Increase deployment speed to see a faster return-on-investment.
- *Cost-optimizing applications:* Gain operational efficiencies to drive down the cost of ownership.
- *Application innovation:* Adopt new technologies and architectures to enable rapid innovation.
- *Centralize data:* Store application data in a centralized repository to enhance security, reduce redundancy, and drive transparency.

Knowing *why* you are modernizing will determine *what* to modernize.

## Step 2: Identify workloads

The cloud frees you to focus on workloads. After assessing your motivation triggers, start identifying your workloads. A [workload](../../plan/workloads.md) is a collection of IT assets (infrastructure, applications, and data) that support an aspect of your business. In a data center, IT assets are logically separate (*see figure*).

:::image type="content" source="../../_images/modernize/envision/data-center-it-assets.png" alt-text="Graphic showing existing data center." :::

The cloud enables you to envision IT assets as workloads. Modernizing infrastructure, applications, and data together as workloads enables your business to modernize at scale.

:::image type="content" source="../../_images/modernize/envision/workload_small.png" alt-text="Image showing workload as a combination of applications, infrastructure, and data." :::

**How to identify workloads:** List your primary business functions. Then, list the IT assets that support those functions. The supporting IT assets are your workloads (*see table for examples*).

|Business Function<span title="Business Function">&nbsp;</span> |Workload (Supporting IT Assets)<span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |
| --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|
|Factory Production|Machine/Robot<br>IOT device<br>Programmable Logic Controller<br>Monitoring<br>Server
|

## Step 3: Align modernization motivations and workloads

Return to list of modernization motivations that you created in Step 1. Start mapping one modernize motivation to each workloads (*see table*).

|Business Function<span title="Business Function">&nbsp;</span> |Workload (Supporting IT Assets)<span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |
| --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|App innovation
|Factory Production|Machine/Robot<br>IOT device<br>Programmable Logic Controller<br>Monitoring<br>Server|Data centralization
|

**Assign one motivation:** You'll likely have multiple motivations for modernizing each workload. But try to assign a single motivation to each workload.  Aligning a single motivation to a workload will enable you to create streamlined processes for achieving the outcomes you want.

**Single motivation is unclear:** For workloads that have multiple motivations, you will want to add an additional step. [Conduct a well-architected review on the workload](/assessments/?mode=pre-assessment&id=azure-architecture-review&session=e88fbec1-a73c-4d4f-8192-e2633676d3b9). The guidance will help you determine what your primary motivation should be. Once you have a single motivation, you can move on the to the evaluate step.

## Next steps

> [!div class="nextstepaction"]
> [Evaluate](../../modernize/business-alignment/evaluate-modernization-options.md).
