---
title: Sustainability considerations in your cloud governance strategy
description: Identify sustainability policies as part of a cloud governance strategy.
author: Zimmergren
ms.author: tozimmergren
ms.date: 04/05/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Sustainability considerations in your cloud governance strategy

## Corporate policies for cloud efficiency

Exploring considerations and determining policies for sustainability and cloud efficiency can help both reduce cost as well as help aligning with regulatory compliance frameworks. Listed below are sample policies to help you understand how you can drive for sustainability while benefitting from cost optimizations, and considerations for governing the sustainability discussions in your organization.

### Deploy to low-carbon regions

Many organizations are [setting targets](/azure/cloud-adoption-framework/strategy/business-outcomes/sustainability) to become carbon neutral or even carbon negative. Deploying resources in low-carbon regions can help you achieve these targets by reducing your organization's overall carbon emissions.

The electricity used to power data centers and cloud infrastructure is a major contributor to carbon emissions, and the location of these data centers can impact the carbon intensity of the electricity used. You can reduce your organization's carbon footprint by deploying resources in low-carbon regions.

Deploying resources in low-carbon regions can help your organization meet sustainability goals, reduce carbon emissions, and save costs.

Learn more:

- See the [regional differences](/azure/architecture/framework/sustainability/sustainability-application-platform#regional-differences) section in the Azure Well-Architected Framework sustainability workload guidance.
- Review the [Microsoft data center sustainability fact sheet](https://infrastructuremap.microsoft.com/fact-sheets) to make better informed decisions on where to deploy your Azure solutions.

### Schedule workloads

Defining a policy for scheduling workloads during low-carbon periods can reduce the carbon footprint of your organization's cloud infrastructure. Here are some steps you can take to define a policy for scheduling workloads:

- **Define low-carbon periods**: Determine which periods of the day, week, or year have the lowest carbon intensity in the regions where your cloud infrastructure is located. This could be during periods of high renewable energy generation or when there's less demand for electricity.
- **Identify workloads you can schedule**: Review your organization's workloads and identify and classify which ones should run during low-carbon periods. These could include noncritical workloads such as backups, maintenance tasks, or batch processing.
- **Define scheduling criteria**: Define the requirements for scheduling workloads during low-carbon periods. This could include workload priority, estimated run time, and required resources.
- **Implement automation**: Implement automation tools to schedule workloads during low-carbon periods.
- **Monitor and optimize**: Monitor the performance of your workload scheduling policy and make adjustments as needed to maximize resource utilization and reduce carbon emissions further.

By implementing this policy, you can reduce your organization's carbon footprint and contribute to a more sustainable technical ecosystem.

### Restrict service tiers

Defining a policy restricting which tiers and SKUs can be deployed in your Azure subscriptions can help your organization reduce its carbon footprint and meet sustainability goals. To design an effective policy, you should:

- **Identify carbon impact:** Identify the carbon impact of various SKUs and service tiers.
- **Define the criteria:** Define criteria for the preferred SKU that has lower carbon intensity.
- **Establish rules:** Establish rules for selecting the preferred SKU, such as setting it as the default or requiring an exception or justification for deploying higher carbon intensity SKUs.

**Consider the tradeoffs** of a lower service tier. For example, you can achieve a lower carbon footprint, but might also end up with a solution with reduced performance. Make conscious choices about when and where to restrict service tiers.

With this policy, your organization can allow continued deployments on the cloud platforms you have available, while still establishing basic governance in line with your climate commitments.

### Track and notify

Tracking workload consumption in the cloud is critical to establishing governance around sustainability and cloud efficiency. While it may not be possible to measure carbon emissions directly for specific workloads, tracking consumption in terms of cost can help organizations monitor and optimize their energy usage, which can help reduce their carbon footprint.

By setting thresholds for consumption, organizations can establish a baseline for typical consumption and identify instances where consumption is higher than expected. Using the established baseline, you can indicate that a workload or component isn't optimized, leading to higher energy usage and potentially higher carbon emissions.

To address this issue, organizations can set up alerts to notify relevant owners and teams when consumption rises above a desired threshold. These alerts can serve as an early warning system, allowing teams to investigate and address issues before they escalate.

Learn more about [using cost alerts to monitor usage and spending](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending).
