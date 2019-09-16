---
title: "Improve your initial cloud governance foundation"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Learn how to incrementally improve your initial cloud governance foundation.
author: BrianBlanchard
ms.author: brblanch
ms.date: 01/03/2019
ms.topic: landing-page
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: governance
layout: LandingPage
---

# Improve your initial cloud governance foundation

This article assumes that you have established an [initial cloud governance foundation](./initial-foundation.md). As your cloud adoption plan is implemented, tangible risks will emerge from the proposed approaches by which teams want to adopt the cloud. As these risks surface in release planning conversations, use the following grid to quickly identify a few recommended practices for getting ahead of the adoption plan to prevent risks from becoming real threats.

## Maturity vectors

At any time, the following prescriptive guidance can be applied to the initial governance foundation to address the risk or need mentioned in the table below.

> [!IMPORTANT]
> Resource organization can affect how this prescriptive guidance is applied. It is important to start with the recommendations that best align with the initial cloud governance foundation you implemented in the previous step.

|Risk/Need | Small-medium enterprise | Large enterprise |
|---|---|---|
|Sensitive data in the cloud|[Prescriptive guidance](./guides/standard/security-baseline-improvement.md)|[Prescriptive guidance](./guides/complex/security-baseline-improvement.md)|
|Mission critical apps in the cloud|[Prescriptive guidance](./guides/standard/resource-consistency-improvement.md)|[Prescriptive guidance](./guides/complex/resource-consistency-improvement.md)|
|Cloud cost management|[Prescriptive guidance](./guides/standard/cost-management-improvement.md)|[Prescriptive guidance](./guides/complex/cost-management-improvement.md)|
|Multicloud|[Prescriptive guidance](./guides/standard/multicloud-improvement.md)|[Prescriptive guidance](./guides/complex/multicloud-improvement.md)|
|Complex/legacy identity management|         |[Prescriptive guidance](./guides/complex/identity-baseline-improvement.md)|
|Multiple layers of governance|         |[Prescriptive guidance](./guides/complex/multiple-layers-of-governance.md)|

## Next steps

In addition to the application of prescriptive guidance, the governance methodology in the Cloud Adoption Framework can be customized to fit unique business constraints. After following the applicable recommendations, [evaluate corporate policy to understand additional customization requirements](./corporate-policy.md).

> [!div class="nextstepaction"]
> [Evaluate corporate policy](./corporate-policy.md)
