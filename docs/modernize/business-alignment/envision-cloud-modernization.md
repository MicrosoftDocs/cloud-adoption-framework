---
title: Envision your cloud modernization possibilities
description: Learn how understanding your cloud adoption motivations help you establish your approach to the modernization horizons, as part of your cloud adoption-related modernization plan.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: envision, motivations, approach, modernization, cloud adoption framework
---
# Envision your cloud modernization possibilities

Envisioning modernization starts with understanding your motivations. You have reasons for wanting to adopt the cloud, and these reasons are the key to modernization. Knowing your motivations lets you determine what you should modernize.

:::image type="content" source="../../_images/modernize/envision/envision-938.png" alt-text="Image showing where you are in the business alignment process.":::

Follow these three steps to envision your cloud modernization possibilities.

## Step 1 - Identify your modernization motivations

Identify your modernization motivations. Discover the reasons you want to modernize with the cloud. Your motivations will be unique to your goals. But commonalities exist across businesses and industries (*see figure*).

:::image type="content" source="../../_images/modernize/envision/modernization-motivations.png" alt-text="Image showing modernization motivations.":::

Some of the most common modernization motivations are:

- *Enabling hybrid work:* Make applications accessible and secure for remote productivity.
- *Faster time to market:* Increase deployment speed to see a faster return-on-investment.
- *Cost-optimizing applications:* Gain operational efficiencies to drive down the cost of ownership.
- *Application innovation:* Adopt new technologies and architectures to enable rapid innovation.
- *Centralize data:* Store application data in a centralized repository to enhance security, reduce redundancy, and drive transparency.

Knowing *why* you're modernizing will determine *what* to modernize. So make sure you have a good understanding of your motivations before moving on.

## Step 2 - Identify your workloads

Identify the workloads you want to modernize.

**1. What is a workload?** A [workload](../../plan/workloads.md) is a collection of IT assets (infrastructure, applications, and data) that support a business function. Data centers encourage you to manage IT assets separately (*see figure*).

:::image type="content" source="../../_images/modernize/envision/data-center-it-assets-small.png" alt-text="Graphic showing existing data center." :::

But the cloud lets you focus on workloads instead of separate IT assets. Modernizing infrastructure, applications, and data together as workloads let you streamline your modernization processes. You'll be able to reuse these processes. You can apply these processes to each workload requiring the same modernization strategy.

:::image type="content" source="../../_images/modernize/envision/workload_300.png" alt-text="Image showing workload as a combination of applications, infrastructure, and data." :::

**2. How to identify workloads** Identify workloads by first making a list of business functions. Business functions are the key components of your business. With these business functions, find the IT assets that support each business function. The group of IT assets that support a specific business function is a workload (*see table for simplified examples*).

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span>
| --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment system|
|Factory Production|Machine/Robot<br>IOT device<br>Programmable logic controller<br>Monitoring<br>Server

## Step 3 - Align your modernization motivations and workloads

Align your modernization motivations and workloads so you can evaluate their readiness in the next step.

**1. Map motivations and workloads**  Map your motivations and workloads using the list of modernization motivations you created in step 1. Start mapping these motivations to the table you made in step 2 (*see table for examples*).

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |
| --- | --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment System|Application innovation
|Factory Production|Machine/Robot<br>IOT device<br>Programmable Logic Controller<br>Monitoring<br>Server|Centralizing Data
|

**2. Assign one motivation to each workload** Assign one motivation to each workload. Assigning a single motivation to a workload will enable you to create streamlined processes for achieving the outcomes you want. It helps you organize your work.When you [modernize your process](/docs/modernize/modernize-strategies/devops-practices-modernization.md), it will be clearer why a single motivation is helpful.

**3. When a single motivation is unclear**  When a single motivation is unclear, [conduct a well-architected review on the workload](/assessments/?mode=pre-assessment&id=azure-architecture-review&session=e88fbec1-a73c-4d4f-8192-e2633676d3b9). The well-architected review will help you figure out what your motivation should be. After running the review, return to this step and complete step 3.

## Next steps

When you have a single motivation for each workload, you can move to the evaluate step.

> [!div class="nextstepaction"]
> [Evaluate](../../modernize/business-alignment/evaluate-modernization-options.md).
