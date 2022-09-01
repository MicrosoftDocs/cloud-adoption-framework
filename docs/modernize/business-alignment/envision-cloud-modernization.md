---
title: Envision your cloud modernization possibilities
description: Learn how understanding your cloud adoption motivations help you establish your approach to the modernization horizons, as part of your cloud adoption-related modernization plan.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/31/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: envision, motivations, approach, modernization, cloud adoption framework
---
# Envision your cloud modernization possibilities

Envisioning your cloud modernization possibilities starts with understanding your motivations. You have reasons for wanting to adopt the cloud, and these reasons are the key to modernization. Knowing your motivations lets you determine what you should modernize.

:::image type="content" source="../../_images/modernize/envision/envision-300.png" alt-text="Image showing where you are in the business alignment process." border="false":::

Follow these three steps to envision your cloud modernization possibilities.

## Step 1 - Identify your modernization motivations

Discover the reasons you want to modernize with the cloud. Your motivations will be unique to your goals. The following commonalities exist across businesses and industries (*see figure*).

:::image type="content" source="../../_images/modernize/envision/modernization-motivations.png" alt-text="Image showing modernization motivations." border="false":::

Some of the most common modernization motivations are:

- *Enabling hybrid work:* Make applications accessible and secure for remote productivity.
- *Getting to market faster:* Increase deployment speed to see a faster return-on-investment.
- *Optimizing cost of applications:* Gain operational efficiencies to drive down the cost of ownership.
- *Innovating applications:* Adopt new technologies and architectures to enable rapid innovation.
- *Centralizing data:* Store application data in a centralized repository to enhance security, reduce redundancy, and drive transparency.

Knowing *why* you're modernizing helps you determine *what* to modernize. So, make sure you have a good understanding of your motivations before moving forward.

## Step 2 - Identify your workloads

Identify the workloads you want to modernize.

*What is a workload?* A [workload](../../plan/workloads.md) is a collection of IT assets (infrastructure, applications, and data) that support a business function. Data centers encourage you to manage IT assets separately (*see figure*).

:::image type="content" source="../../_images/modernize/envision/data-center-it-assets-400.png" alt-text="Graphic showing existing data center." border="false":::

The cloud lets you focus on workloads instead of separate IT assets. Modernizing infrastructure, applications, and data together as workloads lets you streamline your modernization processes. You can reuse these processes and apply them to each workload requiring the same modernization strategy.

*How to identify workloads*. Identify workloads by making a list of business functions. Business functions are the key components of your business.

Identify the IT assets that support each business function. The group of IT assets that support a specific business function is a workload (*see table for simplified examples*).

|Business Function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span>
| --- | --- |
|E-commerce<br>Website| Web App<br>Business logic<br>Database<br>Servers<br>Payment system|
|Factory Production|Machine/Robot<br>IOT device<br>Programmable logic controller<br>Monitoring<br>Server

## Step 3 - Align your modernization motivations and workloads

Align your modernization motivations and workloads so you can evaluate their readiness in the next step.

*Map motivations and workloads*. Map your modernization motivations (step 1) to the workloads you identified (step 2).

*Assign one motivation to each workload.* Assigning a single modernization motivation to each workload will help you organize your work when it's time to modernize (*see table for examples*).

|Business function<span title="Business Function">&nbsp;</span> |Workload <span title="Supporting IT Assets">&nbsp;</span> |Motivation<span title="Motivation">&nbsp;</span> |
| --- | --- | --- |
|E-commerce<br>website| Web app<br>Business logic<br>Database<br>Servers<br>Payment System|Application innovation
|Factory production|Machine/Robot<br>IOT device<br>Programmable Logic Controller<br>Monitoring<br>Server|Centralizing data|

*When a single motivation is unclear, [conduct a well-architected review on the workload](/assessments/?mode=pre-assessment&id=azure-architecture-review&session=e88fbec1-a73c-4d4f-8192-e2633676d3b9).* The well-architected review will help you figure out what your motivation should be. After running the review, return to this step and complete step 3.

## Next steps

When you have a single motivation for each workload, you can evaluate your options.

> [!div class="nextstepaction"]
> [Evaluate](../../modernize/business-alignment/evaluate-modernization-options.md)
