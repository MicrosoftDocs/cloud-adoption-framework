---
title: Business priorities during a transformation process
description: Use the Cloud Adoption Framework for Azure to learn to maintain business alignment during long-term transformation process.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Business priorities during a transformation process

 At the board level, change can look like a dramatic transformation. For people who work through the process of change in an organization, transformation is a bit misleading. Under the surface, transformation is better described as a series of properly executed transitions from one state to another.

The amount of time required to rationalize or transition a workload will vary, depending on the technical complexity involved. Even when applied to a single workload or group of applications quickly, the process takes time to produce significant changes among a user base. It takes longer for changes to propagate through various layers of existing business processes. If transformation is expected to shape behavior patterns in consumers, the results can take longer to produce significant results.

Unfortunately, the market doesn't wait for businesses to transition. Consumer behavior patterns change on their own. These changes are often unexpected. The market's perception of a company and its products can be swayed by social media or a competitor's positioning. Unexpected market changes require companies to be responsive.

The ability to execute processes and technical transitions requires consistent effort. Quick decisions and nimble actions are needed to respond to market conditions. These two ideals are at odds, making it easy for priorities to fall out of alignment. This article describes approaches to maintaining transitional alignment during migration efforts.

## How can business and technical priorities stay aligned during a migration?

The cloud adoption team and the cloud governance team focus on the execution of the current iteration and current release. Iterations provide stable increments of technical work, avoiding costly disruptions that would otherwise slow the progress of migration efforts. Releases ensure that the technical effort and energy stay focused on the business goals of the workload migration. A migration project could require many releases over an extended period. By the time it's completed, market conditions have likely changed significantly.

In parallel, the cloud strategy team focuses on executing the business change plan and preparing for the next release. The cloud strategy team generally looks at least one release ahead. It monitors for changing market conditions and adjusts the migration backlog as appropriate. This focus of managing transformation and adjusting the plan creates natural pivots around the technical work. When business priorities change, adoption is only one release behind, creating technical and business agility.

## Business alignment questions

The following questions can help the cloud strategy team shape and prioritize the migration backlog. It helps ensure that the transformation effort best aligns with current business needs.

- Has the cloud adoption team identified a list of workloads ready for migration?
- Has the cloud adoption team selected a single candidate for an initial migration from that list of workloads?
- Do the cloud adoption team and the cloud governance team have the data about the workload they need to be successful?
- Does the candidate workload deliver the most relevant impact for the business in the next release?
- Are there other workloads that are better candidates for migration?

## Tangible actions

During the execution of the business change plan, the cloud strategy team monitors for positive and negative results. When those observations require technical change, the changes are added as work items to the release backlog. The items are then added to the next iteration.

When the market changes, the cloud strategy team works with the business to understand how to best respond to the changes. If that response requires a change in migration priorities, the migration backlog is adjusted. This adjustment moves up workloads that were previously lower in priority.

## Next steps

With properly aligned business priorities, the cloud adoption team can confidently begin to [evaluate workloads](./evaluate.md) to develop architecture and migration plans.

> [!div class="nextstepaction"]
> [Evaluate workloads](./evaluate.md)
