---
title: Evaluate modernization readiness
description: Learn how to evaluate your technical and financial indicators to determine which workloads you want to modernize during cloud adoption.
author: stephen-sumner
ms.author: ssumner
ms.date: 07/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: evaluate, technical, financial indicators, workloads, modernize, cloud adoption framework
---
<!--Primary Deliverable: CAF/Modernize/Evaluate-Modernization-Options.md​-->
# Evaluate your readiness for cloud modernization

Evaluate if you're ready to modernize in the cloud.

:::image type="content" source="../../_images/modernize/evaluate/evaluate.png" alt-text="Image showing where you are in the business alignment process.":::

## Step 1: Evaluate financial readiness

Financial motivations are the key drivers of cloud modernization. Businesses know that modernizations done right can increase operational efficiency and generate new revenue.

Explore the following questions for each workload. These are just example questions to get you thinking along the right lines. These questions are designed for specific workloads. They are not a general assessment or your organization or entire portfolio.

Answering *yes* to all questions means you're likely ready to modernize. If you answer *no*, we recommend you conduct a [Well-Architected Review](/assessments/?mode=pre-assessment&session=local) of your workload. Return to this step when you're ready.

|Question|Yes|No|
|--|--|--|
|*Can you quantify the business<br> value of modernizing this workloads?*|Modernize|Review|
*Do you know what your <br>modernization cost will be?*|Modernize<br>|Review|
|*Are these workloads business-critical?*|Modernize|Review|
|*Does the cost of modernization<br> meet your desired cost savings?*|Modernize|Review|

## Step 2. Evaluate your technical readiness

Explore the following questions with your organization to determine your technical readiness. You already determined that your workload(s) were financial ready. Now, you can begin evaluating the technical readiness of your workload(s). The technical readiness assessment will help you figure out what cloud adoption strategy to take.

|Question|Yes|No|
|--|--|--|
|*Can you modernize the workload?*|Modernize| Migrate|
|*Is the business actively investing<br> in these workloads?*|Modernize|Replace|
|*Will these modernized workloads <br>need to operate in hybrid or<br> multi-cloud environment?* |Modernize|Migrate|
|*Are your workloads portable?*|Modernize|Migrate
|*Do you plan to keep the current architecture?*|Modernize|Review|

For a workload that pass this readiness assessments, you can now align it with a modernization discipline.

## Step 3. Align workload with a modernization discipline

Align your workload with a modernization strategy.

|Motivation| Modernization |
| --- | --- |
|Enabling hybrid work|Application platforms|
|Faster time to market|Application platforms|
|Cost optimization|Application platforms<br>Database platforms|
|Application innovation|Developer alignment|
|Centralizing data|Database platform|
|

## Next steps

> [!div class="nextstepaction"]
> [Commit](commit-to-modernization-plan.md)
