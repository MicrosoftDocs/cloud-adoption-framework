---
title: Timelines in a cloud adoption plan
description: Use the Cloud Adoption Framework for Azure to learn how to estimate timelines based on your cloud adoption plan.
author: martinekuan
ms.author: martinek
ms.date: 07/01/2019
ms.topic: conceptual
ms.custom: internal, UpdateFrequency2
---

# Timelines in a cloud adoption plan

In the previous article in this series, workloads and tasks were assigned to [releases and iterations](./iteration-paths.md). Those assignments feed the timeline estimates in this article.

Work breakdown structures are commonly used in sequential project-management tools. They represent how dependent tasks will be completed over time. Such structures work well when tasks are sequential in nature. The interdependencies in tasks found in cloud adoption make such structures difficult to manage. To fill this gap, you can estimate timelines based on iteration-path assignments by hiding complexity.

## Estimate timelines

To develop a timeline, start with releases. Those release objectives create a target date for any business impact. Iterations aid in aligning those releases with specific time durations.

If more granular milestones are required in the timeline, use iteration assignment to indicate milestones. To do this assignment, assume that the last instance of a workload-related task can serve as the final milestone. Teams also commonly tag the final task as a milestone.

For any level of granularity, use the last day of the iteration as the date for each milestone. This ties completion of workload adoption to a specific date. You can track the date in a spreadsheet or a sequential project-management tool like Microsoft Project.

## Delivery plans in Azure DevOps

<!-- docutune:casing "Microsoft Delivery Plans" -->

If you're using Azure DevOps to manage your cloud adoption plan, consider using the [Microsoft Delivery Plans extension](https://marketplace.visualstudio.com/items?itemname=ms.vss-plans). This extension can quickly create a visual representation of the timeline that is based on iteration and release assignments.
