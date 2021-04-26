---
title: Create a financial plan
description: Create a financial plan for your move to Azure that analyzes that pros and cons, and that provides a guide for the move itself.
author: jameshkramer
ms.author: v-jakram
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.topic: conceptual
ms.date: 04/23/2021
ms.custom: template-concept
---

# Create a financial plan

Your company depends on information technology (IT) for its operations, and probably for creating and supplying its products as well. It's a significant expense. For these reasons, moving some or all of IT activities to the cloud must be carefully considered and carefully planned.

Perhaps the most important resource for a successful move to the cloud is the financial plan. To justify the move, it must provide cost savings and opportunities; the financial plan is where these are described and weighed. Creating such a plan is a complex task that typically requires the efforts of many people. This article will describe what is needed, and where to get tools to assist.

<!-- 3. H2s
Required. Give each H2 a heading that sets expectations for the content that follows. 
Follow the H2 headings with a sentence about how the section contributes to the whole. -->

<!--

V2 articles:

[Create a financial plan](create-financial-plan.md)

https://github.com/MicrosoftDocs/cloud-adoption-framework-pr/pull/1663

[Glossary of common finance terms](finance-vocabulary-terms.md)

[Licensing considerations](licensing-considerations.md)

https://github.com/MicrosoftDocs/cloud-adoption-framework-pr/pull/1616

[Share your strategy](share-your-strategy.md)

https://github.com/MicrosoftDocs/cloud-adoption-framework-pr/pull/1658

[Build a business justification for cloud migration](cloud-migration-business-case)

https://github.com/MicrosoftDocs/cloud-adoption-framework-pr/pull/1647

-->

This article defining some finance terms may be of use: [Glossary of common finance terms](finance-vocabulary-terms.md).


## Nature and purpose of the financial plan

Virtually all business activities have financial considerations, and some kind of financial planning is required. For major activities, the importance of the plan is underscored, and moving your IT activities to the cloud is a major activity.

Here are the purposes of the financial plan:

- Examine desirability and feasibility of the move.
- Support decision making regarding the move itself.
- Guide the activities of the move.

The plan need not, and probably should not, cover all current IT activities.

It contains these elements:

- **The IT activities to be moved to the cloud.**  The activities you move may not, and probably should not, include all IT activities--for planning, cost, and risk control reasons. It's typically better to pick activities which provide the greatest cost and other advantages by being moved.
- **The timeline for the move.** The timeline will include the cutover dates  for the activities. It is best, if possible, to have multiple cutover dates for multiple subgroups of activities so that tasks are simplified and efforts are focused. This reduces risks, and allows later efforts to benefit from lessons learned on earlier ones. Many small, easy steps are better than one big and difficult one.
- **IT costs during the project.** Your IT costs will vary over time, from the onset of the project to the point of normal cloud operations for all activities. Overall costs will increase at the start, because of the costs of planning and executing the move, and cloud costs. The cost savings come as IT activities cut over to the cloud.

The plan evolves as you create it, because of discoveries you make during the process. The evolution continues until you're confident that it is what it should be.

## Learn about the benefits of the cloud

The benefits of moving to the cloud are not exclusively financial. There are also the benefits of increased capability, flexibility, and ease of scaling. It is important to learn about the other benefits, and they should be mentioned in the financial plan--even though they are not the focus--so that they are not lost sight of.

For information on cloud benefits, see [Build a business justification for cloud migration](cloud-migration-business-case).

### Benefits of moving to the cloud

The benefits of moving to the cloud are of three kinds as listed here:

- Economic benefits
- Financial benefits
- IT and business transformation

:::image type="content" source="media\create-financial-plan\benefits-cloud-migration.png" alt-text="This diagram summarizes benefits of migrating, including economic, financial, and I T and business transformation.":::

### Take advantage of solution assessment / cloud economics engagement

Question: **Should any of the following be used? - JHK**

:::image type="content" source="media\create-financial-plan\solution-assessment-cloud-economics-engagement.png" alt-text="The Solution Assessment / Cloud Economics Engagement diagram that lists assessments and engagements for various kinds of modernization.":::

### Get an Azure foundations assessment

Question: **Should any of the following be used? - JHK**

With real-time performance data, we assess cloud readiness, identify and prioritize Azure-ready workloads, and provide cost-consumption estimates

- Cloud-readiness report illustrating what is Azure-ready, and what can be addressed through rehosting, refactoring, replacing, or rebuilding.  
- Identification and prioritization of “low-hanging fruit” migration candidates
- Landing Zone recommendations with key Governance principles enabled to support upcoming Migration
- Cloud Economics cost-consumption estimates with one and three-year options across Pay-as-you-go, Azure Hybrid Use Benefit (AHUB), and Reserved Instances (RI)
- Deep expertise and certification from Azure gold migration partners
- Dedicated support from Microsoft throughout the duration of the engagement to ensure objectives have been met

:::image type="content" source="media\create-financial-plan\azure-foundations-assessment.png" alt-text="Diagram that accompanies the Get an Azure foundations assessment slide.":::

### Azure Migration Program

[Include this?]

[What is Azure Migration Program](https://gearup.microsoft.com/resources/azure-migration-program-overview)

## Contents of a financial plan

<!-- reiteration of customer’s business and financial goals
demonstrate how cloud economics aligns to customer’s financial considerations
possibly include:
    a consumption plan, 
    rapid or moderate cloud financial plan
    (or a depth financial plan-but we aren’t focusing on depth in the content). 
-->

### Differences from Total Cost of Ownership (TCO) or a Business Case

:::image type="content" source="media\create-financial-plan\financial-plan-differ-TCO-business-case.png" alt-text="Line graph that contrasts Total Cost of Ownership (TCO) against a Business Case":::

- TCO is point-in-time focused, intended to provided a financial and business justification for cloud adoption. Business cases and ROI models may also be viewed in the same way.
- Cloud financial plan provides a view of the technical and financial timeline of a customer's environment and can represent the opportunities for re-investment into further modernization.

## Tools used to build financial models

<!-- the tools used to build the financial models to quantify and inform a financial plan with recommendations on Service, Architecture, Optimizations. 
-->

### Costing tools

### Learn about Azure with Microsoft Learn

[Microsoft Learn](/learn) offers many Azure learning paths that you may want to consider.

Especially relevant to the financial plan is this learning path: [Control Azure spending and manage bills with Azure Cost Management + Billing](/learn/paths/control-spending-manage-bills). It contains these 6 modules:

- [Microsoft Azure Well-Architected Framework—Cost Optimization](/learn/modules/azure-well-architected-cost-optimization)
- [Plan and manage your Azure costs](/learn/modules/plan-manage-azure-costs)
- [Analyze costs and create budgets with Azure Cost Management](/learn/modules/analyze-costs-create-budgets-azure-cost-management)
- [Save money with Azure Reserved Instances](/learn/modules/save-money-with-azure-reserved-instances)
- [Optimize Azure costs with data analysis in Power BI](/learn/modules/optimize-costs-data-analysis-powerbi)
- [Configure and manage costs as a Microsoft partner by using Azure Cost Management](/learn/modules/manage-costs-partner-cost-management)

#### Total Cost of Ownership Calculator

Use the [Total Cost of Ownership (TCO) Calculator](https://azure.microsoft.com/pricing/tco/calculator) online tool to estimate the cost savings you can realize when you migrate your workloads to Azure.

You use it as follows:

- Enter details of your on-premises infrastructure (server, database, storage, and networking), licensing assumptions, and costs.
- The Calculator creates a match from Azure Services to obtain a TCO comparison.

The Calculator provides a high-level initial comparison. However, the results of the TCO calculator need to be considered with care, since an on-premises server list is often complex--optimization steps can be taken when considering Azure.

##### Sample cost detail screens

These are cost detail screens from the Total Cost of Ownership Calculator

  :::image type="content" source="media\create-financial-plan\tco-calculator-compute-cost.png" alt-text="Listings from the TCO Calculator of hardware, software, electricity, virtualization, and VM detail costs, with totals.":::

##### Sample cost breakdown screens

These are cost breakdown screens from the Total Cost of Ownership Calculator

  :::image type="content" source="media\create-financial-plan\tco-calculator-cost-breakdown.png" alt-text="Cost breakdowns of total on-premises and total Azure costs. There is a table and a graph for both breakdowns.":::

### Azure Unified Pricing API – Retail Rates endpoint

Azure customers can get retail prices for all Azure services with the Unified Pricing API – Retail Rates endpoint. For more information, see [Azure Retail Prices overview](/rest/api/cost-management/retail-prices/azure-retail-prices).

### Azure Pricing Calculator

- Use the  [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to configure and estimate the costs for Azure products.

### Other Azure cost resources

- [Optimize your Azure costs](https://azure.microsoft.com/overview/cost-optimization)

- Manage your cloud spending with confidence. Monitor and analyze your Azure bill with [Azure Cost Management and Billing](https://azure.microsoft.com/services/cost-management). Set budgets and allocate spending to your teams and projects.

### Example cost analyses

A cost analysis that compares costs of various options

  :::image type="content" source="media\create-financial-plan\azure-cost-analysis.png" alt-text="Table showing costs of various Azure services, with total service costs, for Pay as You Go, Optimized with HUB, Optimized with HUB 1 year R I, and Optimized with HUB 3 year R I":::

- Pay As You Go compute with Azure Services: $500,966
- BYOL and utilize HUB Savings: 400,985 (save $99,981)
- Maximize discounts with 3-YR RI and HUB Savings: $322,479 (save $178,487)

A rapid cost analysis, requiring less input and few decisions, but less precise:

  :::image type="content" source="media\create-financial-plan\azure-rapid-cost-analysis.png" alt-text="Monthly and annual costs, annual released cash flow for various pay options, compared with on-premises.":::

Here is a cost analysis that is very specific to the customer's concerns. It makes use of the Unified Pricing API

  :::image type="content" source="media\create-financial-plan\customized-modeling.png" alt-text="Spreadsheet of various Azure items in various quantities. There is Excel code for one of the cells, showing use of the Unified Pricing API":::

## Next steps

<!-- 4. Next steps
Required. Provide at least one next step and no more than three. Include some 
context so the customer can determine why they would click the link.
-->

<!-- Add a context sentence for the following links
Set goals, Collect data, Financial modeling options, and Resources for projecting spend -->

> [!div class="nextstepaction"]
> [some link here](/)
