---
title: Share your cloud strategy
description: Learn how to communicate your team's cloud strategy, such as a financial roadmap and multi-year plan, to your finance team.
author: wering
ms.author: wering
ms.service: cloud-adoption-framework
ms.topic: conceptual 
ms.date: 4/15/2021
ms.custom: template-concept 
---

# Share your strategy

After your team has decided on the strategy and roadmap for your cloud adoption plan, you'll need to pitch your idea to your organization's finance team. Your goal is to showcase the benefits and cost-saving measures of moving services to the cloud from an on-premises plan.

It's important to remember that your finance team might not understand much of the technical side of cloud adoption. Try to keep explanations at a high-level, with the main focus on the benefits of moving to the cloud.

## Get started

The information in the following topics is a reminder of tasks to complete before pitching your strategy for cloud migration to the finance team.

### Gather customer data

Augment your pitch with as much data as possible. Personalizing your pitch specifically to your organization gives your finance team a view of how the cloud can benefit your organization. It helps to review your most recent balance sheet, income statement, and cashflow statement.

### Identify a focus

What's most important to your organization? Cost savings and business agility are some of the topics you might focus on. Customize your pitch to your organization's goals, greatest needs, and concerns.

### Use finance terminology

Use terms and acronyms familiar to the finance team in your pitch, for example, capital expenditure (CAPEX), operational expenditure (OPEX), and double mortgage period. Using these terms keeps your pitch streamlined and prevents over-explanation. See the [finance glossary](finance-vocabulary-terms.md) for detailed descriptions of the most common finance terms.

## Start your pitch

### Explain the benefits of moving to the cloud

What are the immediate and long-term financial costs and savings from your plan? Chief Financial Officers (CFO) and finance teams want to know both the initial cost and potential savings from adopting cloud services. Keep the initial explanations brief. Catch the team's attention before jumping into the details. For a review of the benefits of moving to the cloud and building the business justification, see [Build a business justification].

:::image type="content" source="media/share-your-strategy/core-cloud-benefits.png" alt-text="Screenshot that shows the technical and financial benefits of cloud migration.":::

#### Technical benefits

There are immediate technical benefits to your organization's overhead costs when switching to cloud services.

Using on-premises data centers requires maintaining excess server capacity in case of peak usage. In times of normal usage, you might only use 30% of your capacity. The costs in network, personnel, power, building, and server usage don't shrink based on actual use. If you have expectations of further growth, you'll have to pre-buy equipment to meet demand.

:::image type="content" source="media/share-your-strategy/onpremises-cloud-service-utilization-graph.png" alt-text="Screenshot that shows a graph of on-premises utilization versus a pay-as-you-go cloud plan.":::

Cloud services allow for elasticity. If you anticipate a higher usage need, such as during a seasonal product release, cloud usage lets you quickly expand based on that need without expensive (possibly temporary) hardware expansions. Your organization will only ever pay for the capacity you actually use.

The main benefit to IT resources is agility. The following table shows the advantages of cloud supported IT versus traditional (on-premises) IT.

|          | Traditional IT | Cloud supported IT |
|----------|----------------|--------------------|
| **Time to provision** | Weeks or months to provision resources | Minutes or hours to provision resources with self-service access |
| **Hardware usage** | 1 CPU for 100 hours | 100 CPUs for 1 hour |
| **Location** | Location dependent | Accessible everywhere |

Instead of generating costs, your IT center can become an asset in generating profits. The creation of reusable processes, toolsets, scripts, and compute images make your organization more agile and innovative.

On-premise cost tracking per workload might be fuzzy. With the cloud, there are better means to target the costs per workload or application, resulting in higher efficiency.

#### Financial benefits

When you're making the shift to the cloud and planning a migration, there are financial benefits that can be realized.

One benefit of moving to the cloud is the shift from CAPEX to OPEX. Your overall budget allocation moves from a CAPEX investment to OPEX pricing models that can fluctuate more based on capacity or utilization of the cloud environment.

You'll also have a reduced data center footprint. Amortized facilities, or co-location or hosting agreements that you might have in place are no longer required.

Another financial benefit is an increase in staff productivity. One of the key things that cloud adoption can help unlock is better DevOps processes.

You also immediately benefit from a sustainability perspective. Data centers that are hosting cloud services, such as Azure, are done at such scale that you benefit from overall sustainability with the least amount of environmental impact.

### Present your business case and financial plan

You've shown the finance team a brief overview of the benefits, now it's time to show them the detailed costs and potential returns on their investment. Share a financial roadmap that supports a hybrid datacenter deployment and modernization. Now is where you dig into the details.

Show the finance team your financial plan. Your plan should reiterate your organization's business and financial goals, and demonstrate how cloud economics aligns to their financial considerations.

Your plan should be tailored to your organization's goals. It might be a consumption, rapid, moderate, or depth cloud financial plan. For help with building your plan, see [Create a financial plan](financial-models.md) and [Strategy for partner alignment](partner-alignment.md).

Use the following topics as guidelines when you present your plan. They contain important information to point out to the finance team, depending on the focus you've identified.

#### Measure the financial impact of the cloud over time

Show the team the monetary value that comes from switching to the cloud over a period of time. Use images, graphs, and tables to provide emphasis. Show what the costs are today versus cloud costs in the future, detailing the migration timeline and ultimate costs for an optimized Azure scenario. 10 years is a good general number to use.

For example, the following image shows how cashflow changes over a decade, shifting from CAPEX and on-premise OPEX to a hybrid cloud OPEX.

:::image type="content" source="media/share-your-strategy/capex-to-opex-cloud-graph.png" alt-text="Screenshot that shows the cashflow change when moving from an on-premise to a hybrid on-premise and cloud system.":::

The next image clearly shows the Cloud Transformation Value, or the cost savings over time after cloud adoption. In this example, the cost savings stabilize at 6 years.

:::image type="content" source="media/share-your-strategy/cost-savings-over-time.png" alt-text="Screenshot that shows the difference in cost between an on-premise and hybrid cloud system.":::

Finally, show a comparison of cashflow and Profit and Loss (P&L). P&L has a large impact on your organization, and it takes longer to achieve savings due to historical depreciation. All of this information helps your finance team understand when they can expect benefits from a cloud shift.

:::image type="content" source="media/share-your-strategy/cashflow-pandl-comparison.png" alt-text="Screenshot that shows the comparison of cashflow and P&L.":::

See [Create a financial plan](financial-models.md) to find tools that you can use to calculate the financial impact.

#### Show how cloud savings provide for future investment

Saved costs from cloud adoption can be reinvested, also known as iterative modernization. Licensing considerations are a big part of this reinvestment. Cloud costs are flexible, and can be reduced with:

**Reservations**: Reduce costs up to 72 percent compared to pay-as-you-go prices by using 1-3 year terms on Azure services like Windows and Linux virtual machines (VMs), CosmosDB, Azure Synapse, and many others.

**Azure Hybrid Benefit (AHB) for Windows and SQL Server**: AHB helps get more value from your Windows Server licenses and save up to 40 percent on virtual machines.

**Dev/Test pricing**: Discounted rates on Azure to support your ongoing development and testing. It includes no Microsoft software charges on VMs and significant pricing discounts on a variety of other Azure services.

**Spot VM pricing**: With Azure Spot Virtual Machines (Spot VMs), you can access unused Azure compute capacity at steep discounts. Up to 90 percent compared to pay-as-you-go prices.

To learn more about how to you can achieve more with your Azure investment and reduce costs, see [Achieve more with your investment](achieve-more.md).

### Implement the business case

There’s one more factor to consider after sharing your business case with your finance team, and that’s how you implement the business case.

:::image type="content" source="media/share-your-strategy/implement-business-case.png" alt-text="Screenshot that shows the focus on optimization for a business case implementation.":::

A move to the cloud is focused on continuous cost optimization and cost management. Similar to how DevOps is a continuous cycle, the cloud also has a cycle for cost optimization and cost management.

When you're moving to the cloud, you want to make sure that you're reducing on-premises asset acquisitions. You're avoiding some of that capital spend that you would otherwise incur. There’s an initial cleanup and rightsizing for optimization, but you also want to continuously review those environments. Use the tools that Microsoft offers in order to make sure that your deployments are effective and tailored to your environment’s needs.

For example, you can use resource tagging, which allows you to categorize spend in a more granular way than you might have been able to do in an on-premises environment. You also have cloud-native billing models and the Azure hybrid benefit, which allow you to take advantage of some of the unique capabilities and pricing models that the cloud has to offer.

:::image type="content" source="media/share-your-strategy/microsoft-cloud-solutions-optimization.png" alt-text="Screenshot that shows Microsoft solutions for optimization.":::

Microsoft provides solutions to help you continually optimize your environment. You can use frameworks and tools like Azure Cost management to help you understand and forecast your costs. You can also control your costs using Azure policies. Implementing policies lets your teams deploy quickly and comply with the policies at the same time. These policies provide constraints that keep resource usage in check so that it doesn’t “spin out of control”.

## Answer questions

You've completed your pitch, but it's likely that the finance team has questions that you'll need to answer. Some of these questions might be challenging, so it's an effective practice to consider what you might be asked and prepare in advance to answer those questions. Consider the common goals, drivers, and expected outcomes of a Chief Technology Officer (CTO), Chief Information Officer (CIO), or CFO and the finance team.

:::image type="content" source="media/share-your-strategy/cloud-migration-goals-drivers-outcomes.png" alt-text="Screenshot that shows the goals, drivers, and expected outcomes of the finance team and CTO/CIO.":::

## Next steps
