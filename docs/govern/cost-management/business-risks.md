---
title: Motivations and business risks in the Cost Management discipline
description: Understand and see samples of typical customer adoption of a Cost Management discipline within a cloud governance strategy.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

<!-- cSpell:ignore prepurchases -->

# Motivations and business risks in the Cost Management discipline

This article discusses the reasons that customers typically adopt a Cost Management discipline within a cloud governance strategy. It also provides a few examples of business risks that drive policy statements.

## Relevance

In terms of cost governance, cloud adoption creates a paradigm shift. Managing costs in a traditional on-premises world is based on refresh cycles, datacenter acquisitions, host renewals, and recurring maintenance issues. You can forecast, plan, and refine these costs to align with annual capital expenditure budgets.

For cloud solutions, many businesses tend to take a more reactive approach to cost management. In many cases, businesses will prepurchase, or commit to use, a set amount of cloud services. This model assumes that maximizing discounts, based on how much the business plans on spending with a specific cloud vendor, creates the perception of a proactive, planned cost cycle. That perception will only become reality if the business also implements a mature Cost Management discipline.

The cloud offers self-service capabilities that were previously unheard of in traditional on-premises datacenters. These new capabilities empower businesses to be more agile, less restrictive, and more open to adopt new technologies. The downside of self-service is that end users can unknowingly exceed allocated budgets. Conversely, the same users can experience a change in plans and unexpectedly not use the amount of cloud services forecasted. The potential of shift in either direction justifies investment in a Cost Management discipline within the governance team.

## Business risk

The Cost Management discipline attempts to address core business risks related to expenses incurred when hosting cloud-based workloads. Work with your business to identify these risks and monitor each of them for relevance as you plan for and implement your cloud deployments.

Risks will differ between organization, but the following serve as common cost-related risks that you can use as a starting point for discussions within your cloud governance team:

- **Budget control:** Not controlling budget can lead to excessive spending with a cloud vendor.
- **Utilization loss:** Prepurchases or precommitments that go unused can result in lost investments.
- **Spending anomalies:** Unexpected spikes in either direction can be indicators of improper usage.
- **Overprovisioned assets:** When assets are deployed in a configuration that exceed the needs of an application or virtual machine (VM), they can create waste.

## Next steps

Use the [Cost Management policy template](./template.md) to document business risks that are likely to be introduced by the current cloud adoption plan.

After you've gained an understanding of realistic business risks, the next step is to document the business's tolerance for risk and the indicators and key metrics to monitor that tolerance.

> [!div class="nextstepaction"]
> [Understand indicators, metrics, and risk tolerance](./metrics-tolerance.md)
