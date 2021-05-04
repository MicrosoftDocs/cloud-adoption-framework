---
title: Share your cloud strategy
description: Learn how to communicate your team's cloud strategy, such as a financial roadmap and multi-year plan, to your finance team.
author: WendyRing
ms.author: wering
ms.service: cloud-adoption-framework
ms.topic: conceptual 
ms.date: 4/15/2021
ms.custom: template-concept 
---

# Share your strategy

After your team has decided on the strategy and roadmap for your cloud adoption plan, you'll need to share your strategy with your organization's finance team and gain their support. Your goal is to showcase the benefits and cost-saving measures of moving services to the cloud from an on-premises plan.

## Get started

The information in the following guidance is a reminder of tasks to complete before sharing your strategy for cloud migration with the finance team.

### Gather data

Augment your business case with as much data as possible. Personalizing it specifically to your organization gives your finance team a view of how the cloud can benefit your organization. It helps to review your most recent balance sheet, income statement, and cashflow statement.

### Identify a focus

What's most important to your organization? What business outcomes do you want to achieve? Cost savings and business agility are some of the topics you might focus on. Customize and align your strategy to your organization's goals, business outcomes, and greatest needs.

### Use finance terminology

Use terms and acronyms familiar to the finance team, for example, capital expenditure (CAPEX), operational expenditure (OPEX), and double mortgage period. Using these terms keeps your your business case streamlined and prevents over-explanation. See the [finance glossary](finance-vocabulary-terms.md) for detailed descriptions of the most common finance terms.

## Share your business case

### Explain the benefits of moving to the cloud

What are the immediate and long-term financial costs and savings from your plan? Chief Financial Officers (CFO) and finance teams want to know both the initial cost and potential savings from adopting cloud services. Keep the initial explanations brief. Catch the team's attention before jumping into the details. For a review of the benefits of moving to the cloud and building the business justification, see [Build a business justification](cloud-migration-business-case.md).

#### Technical benefits

There are immediate technical benefits to your organization's overhead costs when shifting to cloud services.

Using on-premises data centers requires maintaining excess server capacity in case of peak usage. In times of normal usage, you might only use 30% of your capacity. The costs in network, personnel, power, building, and server usage don't shrink based on actual use. If you have expectations of further growth, you'll have to pre-buy equipment to meet demand.

Cloud services allow for elasticity. If you anticipate a higher usage need, such as during a seasonal product release, cloud usage lets you quickly expand based on that need without expensive (possibly temporary) hardware expansions. Your organization will only ever pay for the capacity you actually use.

The main benefit to IT resources is agility. The following table shows the advantages of cloud supported IT versus traditional on-premises IT.

|          | Traditional IT | Cloud supported IT |
|----------|----------------|--------------------|
| **Time to provision** | Weeks or months to provision resources | Minutes or hours to provision resources with self-service access |
| **Hardware usage** | 1 CPU for 100 hours | 100 CPUs for 1 hour |
| **Location** | Location dependent | Accessible everywhere |

Instead of generating costs, your IT center can become an asset in generating profits. The creation of reusable processes, toolsets, scripts, and compute images make your organization more agile and innovative.

On-premises cost tracking per workload might be fuzzy. With the cloud, there are better means to target the costs per workload or application, resulting in higher efficiency.

#### Financial benefits

When you're making the shift to the cloud and planning a migration, there are financial benefits that can be realized.

One benefit of moving to the cloud is the shift from CAPEX to OPEX. Your overall budget allocation moves from a CAPEX investment to OPEX pricing models that can fluctuate more based on capacity or utilization of the cloud environment.

You'll also have a reduced data center footprint. Amortized facilities, or co-location or hosting agreements that you might have in place are no longer required.

Another financial benefit is an increase in staff productivity. One of the key things that cloud adoption can help unlock is better DevOps processes.

You also immediately benefit from a sustainability perspective. Data centers that are hosting cloud services, such as Azure, are done at such scale that you benefit from overall sustainability with the least amount of environmental impact.

### Present your business case

You've shown the finance team a brief overview of the benefits, now it's time to show them the detailed costs and potential returns on their investment. Share a financial roadmap that supports a hybrid datacenter deployment and modernization. Now is where you dig into the details.

Show the finance team your financial plan. Your plan should reiterate your organization's business and financial goals, and demonstrate how cloud economics aligns to their financial considerations.

Your business case should be tailored to your organization's goals and business outcomes. For help with building your business case, see [Create your business case](financial-models.md) and [Strategy for partner alignment](partner-alignment.md).

Use the following guidelines when you present your plan. They contain important information to point out to the finance team, depending on the focus you've identified.

#### Measure the financial impact of the cloud over time

Show the team the monetary value that comes from shifting to the cloud over a period of time. Use images, graphs, and tables to provide emphasis. Show what the costs are today versus cloud costs in the future, detailing the migration timeline and ultimate costs for an optimized Azure scenario. Ten years is a good general number to use.

For example, the following image shows how cashflow changes over a decade, shifting from CAPEX and on-premise OPEX to a hybrid cloud OPEX.

:::image type="content" source="media/share-your-strategy/capex-to-opex-cloud-graph.png" alt-text="Screenshot that shows the cashflow change when moving from an on-premise to a hybrid on-premise and cloud system.":::

The next image clearly shows the Cloud Transformation Value, or the cost savings over time after cloud adoption. In this example, the cost savings stabilize at 6 years.

:::image type="content" source="media/share-your-strategy/cost-savings-over-time.png" alt-text="Screenshot that shows the difference in cost between an on-premise and hybrid cloud system.":::

Finally, show a comparison of cashflow and Profit and Loss (P&L). P&L has a large impact on your organization, and it takes longer to achieve savings due to historical depreciation. All of this information helps your finance team understand when they can expect benefits from a cloud shift.

:::image type="content" source="media/share-your-strategy/cashflow-pandl-comparison.png" alt-text="Screenshot that shows the comparison of cashflow and P&L.":::

See [Create a financial plan](create-financial-plan.md) to find tools that you can use to calculate the financial impact.

#### Show how cloud savings provide for future investment

Saved costs from cloud adoption can be reinvested into iterative modernization. Cloud costs are flexible, and can be reduced with:

**Azure Hybrid Benefit**: Reduce the costs of running your workloads in the cloud by using this licensing benefit. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit applies to RedHat and SUSE Linux subscriptions, too. To learn more, see [Azure Hybrid Benefit](/pricing/hybrid-benefit/).

**Spot virtual machines**: You can use spot virtual machines with deep discounts for workloads that can be interrupted and don't need to complete within a specific time frame. For example, high-performance computing scenarios, batch processing jobs, visual rendering applications, dev and test environments, including continuous integration and continuous delivery workloads, or large-scale stateless applications. To learn more, see [Spot virtual machines](/azure/virtual-machines/spot-vms).

**Reservations**: Receive a discount on your workloads when you reserve your resources in advance. In return, Microsoft passes the savings onto you as discounts of up to 72 percent. For more information, see [Azure reservations](/reservations/).

**Azure Dev/Test pricing**: Take advantage of discounted rates for your development and testing, including the Microsoft software charges on Azure Virtual Machines and special dev and test pricing on other services. For more information, see [Azure Dev/Test pricing](/pricing/dev-test/).

**Extended security updates**: Receive continued support for SQL Server 2008 and SQL Server 2008 R2 in the cloud, which has reached the end of their support (EOS) life cycle. You can migrate your on-premises SQL Server instances to Azure Virtual Machines, Azure SQL Database, or stay on-premises and purchase extended security updates. You'll receive free extended security patches by migrating to an Azure Virtual Machine. To learn more, see [Lifecycle FAQ - Extended Security Updates](/lifecycle/faq/extended-security-updates).

To learn more about how to you can achieve more with your Azure investment and reduce costs, see [Achieve more with your investment](achieve-more.md).

## Implement the business case

There’s one more factor to consider after sharing your business case with your finance team, and that’s how you implement the business case. A move to the cloud requires a continuous optimization and cost management. The focus will be on:

- **Reduced on-premises asset acquisition**. When you're moving to the cloud, you want to make sure that you're reducing on-premises asset acquisitions. You're avoiding some of that capital spend that you would otherwise incur.
- **Initial clean-up, right-sizing, and optimization**. There’s an initial cleanup and rightsizing for optimization.
- **Continuous cost optimization**. Continuously review environments for cost optimization potential. Microsoft provides solutions to help you continually optimize your environment. You can use frameworks and tools like Azure Cost management to help you understand and forecast your costs. You can control your costs using Azure policies. Implementing policies enables teams to deploy quickly and comply with policies at the same time.
- **Resource tagging and spend categorization**. Use the tools that Microsoft offers to make sure your deployments are effective and tailored to your environment’s needs. For example, you can use resource tagging, which allows you to categorize spend in a more granular way than you might have been able to do in an on-premises environment.
- **Take advantage of cloud native billing models**. There are unique capabilities and pricing models the cloud has to offer.
- **Azure Hybrid Benefit**. Reduce the costs of running your workloads in the cloud by using this licensing benefit. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit also applies to RedHat and SUSE Linux subscriptions.

## Answer questions

You've shared your strategy and it's likely that the finance team has questions that you'll need to answer. Some of these questions might be challenging, so it's an effective practice to consider what you might be asked and prepare in advance to answer those questions.

### Common goals, drivers, and expected outcomes

Consider the common goals, drivers, and expected outcomes of a Chief Technology Officer (CTO), Chief Information Officer (CIO), Chief Financial Officer (CFO), and the finance team:

|          | CTO/CIO view | CFO view |
|----------|----------------|--------------------|
| **Flexibility** | Cloud enables dynamic reallocation of IT resources from lower value IT projects to high value projects. | Cloud enables flexible budgetary allocation |
| **Resiliency** | More fault-tolerant options for backup, disaster recovery, and security | Lower required cashflow to support disaster recovery and backup |
| **Agility** | Higher capability of new technology adoption | New technology adoption without new budgetary allocation |
| **Strategic value** | Change IT from a cost center to a profit center. IT personnel evolve into consultants to business units, providing means to innovation, and time to market.| IT as an asset for CFO. New reusable processes, toolsets, scripts, compute images, and ways to increase business agility and innovation |
| **Efficiency** | More rapid service delivery to the business units, with focus on driving strategic value. | More granular activity-based costing (ABC), as on-premises cost tracking per workload may be fuzzy. Easier to target the costs per workload or application in the cloud. |
| **Financial benefits** | Cloud enables doing more with less, as budgets given to CTO and CIOs are typically constant or shrinking.| Reduced cost. Enables reinvestment opportunities into higher value projects. |

## Next steps

Learn more about how the cloud can advance your business strategy.

> [!div class="nextstepaction"]
> [Using cloud economics to advance your business strategy](./index.md)
