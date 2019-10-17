---
title: "Business criticality - Cloud Management and Operations"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Business criticality - Cloud Management and Operations
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/07/2019
ms.topic: article
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Business impact in cloud management

Assume the best, prepare for the worst. In IT management, it is safe to assume that the workloads required to support business operations will be available and will perform within agreed upon constraints, based on the selected criticality. However, to manage investments wisely, it's important to understand the impact experienced by the business when an outage or performance degradation does occur. This importance is illustrated in the follow graph which maps potential business interruptions of specific workloads to business impact of outages across a relative value scale.

![Impact of business interruptions](../../_images/manage/time-value-impact.png)

To create a fair basis of comparison for the impact to various workloads across a portfolio, a time/value metric is suggested. The Time/Value metric captures the adverse impact of a workload outage. Generally, this impact is recorded as a direct loss of revenue or operating revenue during a typical outage period. More specifically, calculating the amount of lost revenue for a unit of time. The most common time/value metric is "Impact per hour", which measures operating revenue losses per hour of outage.

There are a few approaches that can be used to calculate impact. Any of the options in the following sections can be leveraged with similar outcomes. It is important to use the same approach for each workload when calculating protected losses across a portfolio.

## Start with estimates

Current operating models may make it difficult to determine an accurate impact. Fortunately, few systems need a highly accurate loss calculation. In the prior step: Classify Criticality, it was suggested that all workloads start with a default of "Medium Criticality". Medium criticality workloads will generally receive a standard level of management support with a relatively low operating cost impact. Only when a workload requires additional operational management resources would an accurate financial impact be required.

For all standardized workloads, business impact serves as a prioritization variable when recovering systems during an outage. Outside of those limited situations, the business impact will create little to no change in the operations management experience. 

## Calculating time

Depending on the nature of the workload, losses could be calculated differently. For high-paced transactional systems like a real-time trading platform, losses per millisecond could be significant. Less frequently used systems, like payroll, may not be used every hour. Whether frequency of usage is high or low, it is important to normalize the time variable when calculating financial impact.

## Calculating total impact

When additional management investments are desired, it is more important that the business impact be more accurate. The follow bullets outline approaches to calculating losses, in order of most accurate (from most accurate to least accurate):

- **Adjusted losses:** If the business has experienced a major loss event in the past, like a hurricane or other natural disaster, a claims adjuster may have calculated actual losses during the outage. These calculations are based on insurance industry standards for loss calculation and risk management. Using adjusted losses as the total amount of losses in a specific time frame can lead to highly accurate projections.

- **Historical losses:** If the on-premises environment has suffered from historically outages due to infrastructure instability, it can be a bit harder to calculate losses. But, the adjuster formulas can still be leveraged internally. To calculate historical loses, compare the deltas in sales, gross revenue, and operating costs across three time frames: before, during, and after outage. Examining these deltas can identify accurate loses when no other data is available.

- **Complete loss calculation:** If no historical data is available, a comparative loss value can be derived. In this model, determine the average gross revenue per hour for the business unit. Assuming a complete system outage equates to 100% loss of revenue is a poor assumption when projecting loss avoidance investments. But, it can be used as a rough basis for comparing loss impacts and prioritizing investments.

Before making assumptions regarding loss calculations, work with your finance department to determine the best approach to calculate potential losses associated with a workload outage.

## Calculating workload impact

When leveraging historical data to calculate losses, there may be enough information to clearly determine the impact of each workload on those losses. This evaluation is where the partnership with the business is absolutely critical. Once a total impact has been calculated, that impact must be attributed across each workload. That distribution of impact should come from the business stakeholders, who should agree on the relative and cumulative impact of each workload. Further, the team should solicit feedback from business executives to validate alignment. Unfortunately, the end result is equal parts emotion and subject matter expertise. The importance of this exercise is that it represents the logic and beliefs of the business stakeholders who should have a say in budget allocation.

## Using the template

The following steps apply to readers who are using the [Ops Management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to plan for cloud management.

1. Each workload in the "Example" or "Clean Template" should be updated by the business with the "Time/Value Impact" of each workload. By default, "Time/Value Impact" represents the projected losses per hour associated with an outage of the workload.

## Next steps

Once impact is defined, [commitments can be aligned](./commitment.md).

> [!div class="nextstepaction"]
> [Align management commitments with the business](./commitment.md)
