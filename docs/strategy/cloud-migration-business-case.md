---
title: Create a business case
description: Create a business case for your migration to the cloud that provides a technical and financial timeline of your environment and can represent the opportunities for reinvestment into further modernization.
author: WendyRing
ms.author: wering
ms.date: 04/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal, template-concept
---

# What is a business case?

Your organization depends on information technology (IT) for its operations, and probably for creating and supplying its products as well. It's a significant expense. For these reasons, a move to the cloud must be carefully considered and planned.

A business case provides a view of the technical and financial timeline of your environment and can represent the opportunities for reinvestment into further modernization. Developing a business case includes building a financial plan that takes technical considerations into account and aligns with [business outcomes](./business-outcomes/index.md). It helps you foster support from your Finance team and other areas of the business, helps accelerate cloud migration, and enables business [agility](./business-outcomes/agility-outcomes.md).

## Key components of a business case

When you're planning your business case to migrate to the cloud, there are several key components to consider.

**Environment scope, technical and financial:** As you build out the on-premises view of your environment, think about how your environment scope, from both a technical and financial perspective, is aligned. You want to be sure the technical environment you're using for your plan matches up to the financial data.

**Baseline financial data: Cost to run today:** When you build out your business case, it’s important to pull your baseline financial data. Common questions you can ask to gather the financial data needed are:

- How much does it cost to run my environment today?
- What am I spending on servers in an average year?
- What am I spending in my data center operations categories, for example, power or lease costs?
- When is the next hardware refresh?

**Projections: On-premises costs in on-premises scenario:** Forecast what your on-premises costs will be if you don’t migrate to the cloud.

:::image type="content" source="./media/create-financial-plan/optimization-opportunity.png" alt-text="Diagram of on-premises or status quo.":::

**Projections: On-premises costs in Azure scenario:** Forecast what your on-premises costs will be when you migrate to the cloud in an Azure scenario. It takes resources and time to shift your environment to the cloud, so it’s important to account for them in the business case. When you build out the Azure scenario, be sure to take into consideration and include all of the core benefits the cloud provides.

:::image type="content" source="./media/create-financial-plan/optimized-consumption-plan.png" alt-text="Diagram of on-premises costs in Azure scenario.":::

**Projections: Migration timeline and Azure costs (optimized):** Project what migration timeline and the Azure costs will be with a given environment. Consider how you can optimize and get the most out of your Azure investment. For example, use reserved instances, scale capacity up and down, use the Azure hybrid benefit, and right-size your resources.

A business case isn't just a point-in-time view. It’s a plan for a period of time. As you shift to the cloud, you reduce your spend over-time and create a cloud migration plan. You can model out what the ramp-down in spend will be on-premises over time associated with your cloud migration plan.

Once on-premises workloads and cost structure have been identified, you can then build out your optimized Azure consumption plan.

As a final step, when you create your business case, you want to compare the cloud environment to an on-premises or status quo scenario. You can take your Azure view and compare it to your on-premises or status quo scenario with no migration so you can assess the benefit of migrating to the cloud. The Azure view will show on-premises costs that are being reduced over time, your Azure environment costs, and any migration costs associated with shifting to a cloud environment.

:::image type="content" source="./media/create-financial-plan/cloud-on-premises-comparison.png" alt-text="Diagram of comparison of cloud to on-premises or status quo.":::

## Cloud savings provide for future investment

Cloud billing models and offers differ from on-premises however, they can create meaningful savings opportunities you can take advantage of to reduce cloud costs. Saved costs from cloud adoption can be reinvested into iterative modernization. Cloud costs are flexible, and can be reduced with:

**Azure Hybrid Benefit:** Reduce the costs of running your workloads in the cloud by using this licensing benefit. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit applies to RedHat and SUSE Linux subscriptions, too. To learn more, see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/).

**Spot virtual machines:** You can use spot virtual machines with deep discounts for workloads that can be interrupted and don't need to complete within a specific time frame. For example, high-performance computing scenarios, batch processing jobs, visual rendering applications, dev/test environments including continuous integration and continuous delivery workloads, or large-scale stateless applications. To learn more, see [Spot virtual machines](https://azure.microsoft.com/pricing/spot/).

**Reservations:** Receive a discount on your workloads when you reserve your resources in advance. In return, Microsoft passes the savings onto you as discounts of up to 72 percent. For more information, see [Azure reservations](https://azure.microsoft.com/reservations/).

**Azure Dev/Test pricing:** Take advantage of discounted rates for your development and testing, including the Microsoft software charges on Azure Virtual Machines and special dev/test pricing on other services. For more information, see [Azure Dev/Test pricing](https://azure.microsoft.com/pricing/dev-test/).

**Extended security updates:** Receive continued support for SQL Server 2008 and SQL Server 2008 R2 in the cloud, which has reached the end of their support lifecycle. You can migrate your on-premises SQL Server instances to Azure Virtual Machines, Azure SQL Database, or stay on-premises and purchase extended security updates. You'll receive free extended security patches by migrating to an Azure Virtual Machine. To learn more, see [Lifecycle FAQ: Extended security updates](/lifecycle/faq/extended-security-updates).

## Tools

There are many valuable tools and calculators you can use to help prepare a business case for your cloud migration.

**Azure Total Cost of Ownership (TCO) Calculator:** Use the [Total Cost of Ownership (TCO) Calculator](https://azure.microsoft.com/pricing/tco/calculator/)
 online tool to estimate the cost savings you can realize when you migrate your workloads to Azure.

Enter details of your on-premises infrastructure into the tool including servers, databases, storage, and networking, licensing assumptions and costs.

The Calculator creates a match from Azure Services to create a high-level initial TCO comparison. However, the results of the TCO calculator need to be considered with care, since an on-premises server list is often complex and optimization steps can be taken when considering Azure.

**Retail Rates Prices API:** Use the Retail Rates Prices API to retrieve retail prices for all Azure services. Previously, the only way that you could retrieve prices for Azure services was to either use the Azure Pricing Calculator or use the Azure portal. This API gives you an unauthenticated experience to get retail rates for all Azure services. Use the API to explore prices for Azure services against different regions and different SKUs. The programmatic API can also help you create your own tools for internal analysis and price comparison across SKUs and regions. To learn more, see [Retail Rates Prices API](/rest/api/cost-management/retail-prices/azure-retail-prices).

**Azure Pricing Calculator:** Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to configure and estimate the costs for Azure products.

**Partner toolsets:** Microsoft Partners have tools in the [Azure Marketplace](https://azuremarketplace.microsoft.com/home) that can help create a migration cost analysis.

**Solution assessments:** Get assistance from a Microsoft solutions assessment expert or qualified partner as part of a [Solution Assessment engagement](https://www.microsoft.com/solutionassessments/solutionassessments.aspx).

**Azure Migration and Modernization Program:** Join the  [Azure Migration and Modernization Program](https://azure.microsoft.com/migration/migration-program/) to get the guidance and expert help you need at every stage of the cloud migration journey. Migrate infrastructure, databases, and apps—and move forward with confidence.

### Learn about Azure with Microsoft Learn

[Microsoft Learn](/learn/) offers many Azure learning paths that you might want to consider as you build your business case.

- [Control Azure spending and manage bills with Azure Cost Management + Billing](/learn/paths/control-spending-manage-bills/).
- [Microsoft Azure Well-Architected Framework—Cost Optimization](/learn/modules/azure-well-architected-cost-optimization/)
- [Plan and manage your Azure costs](/learn/modules/plan-manage-azure-costs/)
- [Analyze costs and create budgets with Azure Cost Management](/learn/modules/analyze-costs-create-budgets-azure-cost-management/)
- [Save money with Azure Reserved Instances](/learn/modules/save-money-with-azure-reserved-instances/)
- [Optimize Azure costs with data analysis in Power BI](/learn/modules/optimize-costs-data-analysis-powerbi/)
- [Configure and manage costs as a Microsoft partner by using Azure Cost Management](/learn/modules/manage-costs-partner-cost-management/)

## Next steps

Learn more about how to share your strategy and business case to migrate to the cloud:

> [!div class="nextstepaction"]
> [Share your strategy](./share-your-strategy.md)
