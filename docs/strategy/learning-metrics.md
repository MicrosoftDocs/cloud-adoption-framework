---
title: Align technical efforts to outcome metrics
description: Understand how to align efforts to measure and communicate transformation's impact on the business.
author: mpvenables
ms.author: brblanch
ms.date: 12/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# How can we align technical efforts to meaningful outcome metrics?

The [business outcomes overview](./business-outcomes/index.md) discussed ways to communicate and measure the efficacy that digital transformation will have on your business. It could take years for your organization's business outcomes to produce measurable results. Your company's leadership could be dissatisfied with board room presentations displaying data that shows a 0 percent change for long periods.

Outcome metrics are relevant performance and impact measures collected across your organization, and address the question "_how successfully_ have I achieved my change goal [x]—are these changes observable and quantifiable?" These outcome metrics can be accounted for in shorter-term increments—and then linked to progress towards your organization's longer-term business outcomes. Outcome metrics map effectively to the growth perspective of the C-suite and boardroom, and can help position company culture to become more resilient. Rather than pointing to potential lack of progress toward a long-term business goal, outcome metrics highlight early success outcomes that mark incremental progress towards long-term goals. These metrics also highlight early failure outcomes, which can produce opportunities for you to learn and adjust the strategic approach.

You're most likely already familiar with the [transformation journey](../govern/guides/index.md) that most closely aligns with your desired business outcomes. To illustrate the overall concept, we provide outcome metrics for each transformation journey.

## Cloud migration

This transformation focuses on cost, complexity, and efficiency, with an emphasis on IT operations. The most easily measured data behind this transformation is the movement of assets to the cloud. In this kind of transformation, the digital estate is measured by virtual machines (VMs), racks or clusters that host those VMs, datacenter operational costs, required capital expenses to maintain systems, and depreciation of those assets over time.

As VMs are moved to the cloud, dependence on on-premises legacy assets is reduced. The cost of asset maintenance is also reduced. Unfortunately, businesses can't realize the cost reduction until clusters are deprovisioned and datacenter leases expire. In many cases, the full value of the effort isn't realized until the depreciation cycles are complete.

Always align with the CFO or finance office before making financial statements. However, IT teams can generally estimate current monetary cost and future monetary cost values for each VM based on CPU, memory, and storage consumed. You can then apply that value to each migrated VM to estimate the immediate cost savings and future monetary value of the migration effort.

## Application innovation

Cloud-enabled application innovation focuses largely on the customer experience and the customer's willingness to consume products and services provided by the company. It takes time for increments of change to affect consumer or customer buying behaviors. But application innovation cycles tend to be much shorter than they are in the other forms of transformation. We suggest starting with an understanding of the behaviors you wish to influence and use those behaviors as outcome metrics. In an e-commerce application, the total purchases or add-on purchases could be the target outcome, and for a video company, perhaps the time spent watching video streams.

Customer outcome metrics can be influenced by external variables, so it's important to include statistical data that's in process of being measured—release cadence, bugs resolved per release, code coverage of unit tests, page views, page throughput, page load time, and metrics relevant to application performance. Each statistic can show different activities and changes to the code base and the customer experience to correlate with higher-level patterns of customer outcomes.

## Data innovation

Changing an industry, disrupting markets, or transforming products and services can take years. In a cloud-enabled data innovation effort, experimentation is key to measuring success outcomes. Be transparent by sharing prediction metrics like percent probability, the number of failed experiments, and the number of models trained. Failures will accumulate faster than successes. These outcome metrics can be discouraging, and the executive team must understand the time and investment needed to utilize them properly.

Positive outcomes associated with data-driven discovery are often: centralization of heterogeneous data sets, data ingress, and democratization of data. While your cross-functional teams continuously gather more data about tomorrow's omnichannel customer, you can produce observable results today. Supporting outcome metrics might include:

- Number of models available.
- Number of partner data sources consumed.
- Devices producing ingress data.
- Volume of ingress data.
- Types of data.

An even more valuable outcome metric is the number of dashboards created from combined data sources. This number reflects current-state business processes that are affected by new data sources. By sharing new data sources openly, your business can take advantage of the data by using reporting tools like Power BI to produce incremental insights and drive business change.

## Next steps

After you align your outcome metrics, you're ready to start [measuring business outcomes](./business-outcomes/okr.md) using objectives and key results (OKRs).

> [!div class="nextstepaction"]
> [Measure business outcomes](./business-outcomes/okr.md)