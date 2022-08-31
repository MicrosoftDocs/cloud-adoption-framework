---
title: Evaluate cloud modernization readiness
description: Learn how to evaluate your technical and financial indicators to determine which workloads you want to modernize during cloud adoption.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice:
ms.custom: internal, seo-caf-modernize
keywords: evaluate, technical, financial indicators, workloads, modernize, cloud adoption framework
---
# Evaluate cloud modernization readiness

Once you've envisioned your cloud modernization possibilities, evaluate whether you're ready to modernize in the cloud.

:::image type="content" source="../../_images/modernize/evaluate/evaluate-300.png" alt-text="Image showing where you are in the business alignment process." border="false":::

Evaluating your readiness for modernization has to components. You need to assess you financial readiness and technical readiness.

- *Financial readiness assessment* - helps you determine if you need more time to review your applications.
- *Technical readiness assessment* - helps you determine if you need to choose a different adoption path other than modernize.

## Step 1 - Evaluate the financial readiness of each workload

A financial readiness assessment helps you determine if it makes business sense to modernize your workload. Financial motivations are the key drivers of cloud modernization. Cloud modernizations can improve margins through efficiencies and generate new revenue streams. To realize those benefits, you need to evaluate the financial aspects of the effort.

For each workload you want to modernize, answer the following questions to assess your financial readiness.

Answering *yes* to all questions means you're likely ready to modernize. If you answer *no* to any of the questions, we recommend you conduct an [Azure Well-Architected Review](/assessments/?mode=pre-assessment&session=local) of your workload.

|Question|Yes|No|
|--|--|--|
|*Can you quantify the business<br> value of modernizing the workload?*|Modernize|Conduct Azure Well-Architected Review|
|*Do you know what your <br>modernization cost will be?*|Modernize<br>|Conduct Azure Well-Architected Review|
|*Are these workloads business-critical?*|Modernize|Conduct Azure Well-Architected Review|
|*Does the cost of modernization<br> meet your desired cost savings?*|Modernize|Conduct Azure Well-Architected Review|

If you answered *yes* to all the financial readiness questions, the workload is likely ready to adopt the cloud. The next step, [technical readiness evaluation](#step-2---evaluate-the-technical-readiness-of-each-workload), will help you determine if you're ready to modernize or take another adoption path.

## Step 2 - Evaluate the technical readiness of each workload

A technical readiness assessment helps you determine if your workload is ready for modernization or is better fit for a different cloud adoption strategy.

For each workload you want to modernize, answer the following questions to begin assess your technical readiness.

|Question|Yes|No|
|--|--|--|
|*Do you have enough control over the workload to modernize it?*|Modernize| Migrate|
|*Is your business actively investing<br> in these workloads?*|Modernize|Replace|
|*Will these modernized workloads <br>need to operate in hybrid or<br> multicloud environment?* |Modernize|Migrate|
|*Are your workloads portable?*|Modernize|Migrate|
|*Do you plan to keep the current architecture?*|Modernize|Conduct Azure Well-Architected Review|

If you answered *yes* to all the technical-readiness questions, you're likely ready to modernize the workload.

## Next steps

You've [envisioned](envision-cloud-modernization.md) and [evaluated](evaluate-modernization-options.md). It's time to commit to a modernization path.

> [!div class="nextstepaction"]
> [How to commit to modernization](commit-to-modernization-plan.md)
