---
title: Cloud operation and management antipatterns
description: Introducing or modernizing IT tools doesn't necessarily guarantee faster deliveries or better business outcomes.
author: lpassig
ms.author: brblanch
ms.date: 02/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: manage
ms.custom: think-tank
---

# Cloud operation and management antipatterns

Customers often experience antipatterns during the operation or management phase of cloud adoption. By introducing new or modernized tool chains with caution, you can often avoid these antipatterns.

## Antipattern: Focus on tooling, not business outcomes

Modernized IT tooling can improve work environments by relieving employees of tedious tasks. It's important to measure new IT tooling so that you can identify whether it improves business outcomes. A new or modernized tool chain doesn't automatically provide faster delivery or a better business outcome.

### Example: Introduce a platform that doesn't improve performance

A company introduces a new, improved version of its continuous integration and continuous delivery (CI/CD) platform. The tool makes it easier to define delivery and deployment pipelines, so you can deploy features faster. The IT department is enthusiastic about delivering a platform that speeds up the pipeline configuration. Once a business unit uses the tool, it discovers that the time to market isn't significantly better, compared with the old platform. The final approval and release process isn't changed or improved.

### Preferred outcome: Measure success with business outcomes

To keep your technology and business goals aligned, have leaders from both areas jointly define desired outcomes. Make sure these outcomes and goals are specific, measurable, achievable, reasonable, and time-bound (SMART). Ensure that the outcomes and goals have an impact on technology and the business. The Microsoft Cloud Adoption Framework for Azure can help to [determine a proper commitment within the business](../manage/considerations/commitment.md).

Don't use simple technology outputs (such as faster deployment and pipeline configurations) to measure success. Instead, use technology and business outcomes. For help with this task, see [Developer velocity](https://azure.microsoft.com/overview/developer-velocity/).

## Next steps

- [Business commitment in cloud management](../manage/considerations/commitment.md)
