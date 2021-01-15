---
title: "Cloud operations and management Antipatterns"
description: Just because a new or modernized tooling-chain is introduced it does not equate to faster delivery or better business outcome.
author: lpassig
ms.author: brblanch
ms.date: 01/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
ms.custom: think-tank
---

# Cloud operations and management Antipatterns

Customers frequently experience a number of common cloud adoption antipatterns while in the operations or management phase of cloud adoption. Be cautious when introducing a new or modernized tool-chain. 

## Antipattern: Focusing on tooling rather than business outcomes

Introducing or modernizing IT tooling can be very exciting and pain-relieving. However, new IT tooling should be measured to identify how it will improve the business outcome. Just because a new or modernized tool-chain is introduced it doesn't always mean you'll get faster delivery or better business outcome when you use it.

### Example of this antipattern

Contoso introduced a new and improved version of their continuous integration and continuous delivery (CI/CD) platform. The tool made it easier to define delivery and deployment pipelines and therefore the features were deployed faster. The IT department was happy to have delivered a platform that speeds up the pipeline configuration. However, once the business units used the tool, they measured that the time to market was not significantly better compared to the old platform. In fact, the final approval and release process was neither changed nor improved.

### Preferred outcome: define business outcomes

To avoid a misalignment between technology and business goals, leaders from both areas should jointly define desired outcomes. These outcomes and goals should be Specific, Measurable, Achievable, Reasonable, Time-bound (SMART) and have an impact on technology and the business. The Cloud Adoption Framework can help to [determine a proper commitment within the business](/azure/cloud-adoption-framework/manage/considerations/commitment).

Simple technology outputs (faster deployment pipelines configuration) shouldn't be used to measure success and should be replaced by technology as well as business outcomes. A helpful tool for this task is the [Developer Velocity Assessment](https://azure.microsoft.com/overview/developer-velocity/).

## Next step

- [Business commitment in cloud management](/azure/cloud-adoption-framework/manage/considerations/commitment)