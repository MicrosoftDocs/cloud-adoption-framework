---
title: Create a business case for cloud migration
description: Learn how to create a cloud-migration business case that forecasts cost savings compared to on-premises resources.
author: martinekuan
ms.author: martinek
ms.date: 08/05/2022
ms.topic: conceptual
ms.custom: internal, template-concept, UpdateFrequency2
---

# Create a business case for cloud migration

Your organization depends on information technology (IT) for its operations, and probably for creating and supplying its products as well. It's a significant expense. Migrating IT resources to the cloud offers the potential for cost savings.

However, a move to the cloud must be carefully considered and planned. Creating a business case for cloud migration can help foster support from your Finance team and other areas of the business. It can also help accelerate cloud migration and promote business [agility](./business-outcomes/agility-outcomes.md).

A business case provides a view of the technical and financial timeline of your environment. Developing a business case includes building a financial plan that takes technical considerations into account and aligns with [business outcomes](./business-outcomes/index.md). 

## Key components of a business case

There are several key components to consider when you plan a business case.

**Environment scope:** As you build out the on-premises view of your environment, think about how your environment scope&mdash;from both a technical and financial perspective&mdash;is aligned. You want to be sure the technical environment you're using for your plan matches up to the financial data.

**Baseline financial data:** Common questions you can ask to gather needed financial data are:

- How much does it cost to run my environment today?
- What am I spending on servers in an average year?
- What am I spending in my data center operations categories, for example, power or lease costs?
- When is the next hardware refresh?

**On-premises cost scenario:** Forecast your on-premises costs if you don't migrate to the cloud.

:::image type="content" source="./media/create-financial-plan/optimization-opportunity.png" alt-text="Diagram of on-premises or status quo.":::

**Azure scenario for on-premises costs:** Forecast your on-premises costs when you migrate to the cloud in an Azure scenario. It takes resources and time to shift your environment to the cloud, so it's important to account for them in the business case. Include all of the core benefits that the cloud provides.

:::image type="content" source="./media/create-financial-plan/optimized-consumption-plan.png" alt-text="Diagram of on-premises costs in Azure scenario.":::

**Migration timeline and Azure costs:** Forecast the migration timeline and estimated costs for a given environment. Consider how you can optimize and get the most out of your Azure investment. For example, use reserved instances, scale capacity up and down, use the Azure hybrid benefit, and right-size your resources.

A business case isn't just a moment-in-time view. It's a plan that covers a period of time. As you shift to the cloud, your costs begin to decrease. You can forecast the ramp-down in on-premises spending over time associated with your cloud migration plan.

Once on-premises workloads and cost structure have been identified, you can then build out your optimized Azure consumption plan.

As a final step, compare the cloud environment to an on-premises or status quo scenario so you can assess the benefit of migrating to the cloud. The Azure view will show reduced on-premises costs over time, your Azure environment costs, and any costs associated with the cloud migration.

:::image type="content" source="./media/create-financial-plan/cloud-on-premises-comparison.png" alt-text="Diagram of comparison of cloud to on-premises or status quo.":::

## Cloud savings

Migrating resources to the cloud can save organizations money. Cloud billing models differ from on-premises, creating meaningful savings opportunities to reduce costs. Savings can then be reinvested into new technology initiatives.

Cloud costs are flexible, and they can be reduced with:

**Azure hybrid benefit:** Reduce the costs of running workloads in the cloud by using [this licensing benefit](https://azure.microsoft.com/pricing/hybrid-benefit/). You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit also applies to RedHat and SUSE Linux subscriptions.

**Spot virtual machines:** You can use [spot virtual machines](https://azure.microsoft.com/services/virtual-machines/spot/) with deep discounts for workloads that can be interrupted and don't need to complete within a specific time frame. For example, high-performance computing scenarios, batch processing jobs, visual rendering applications, dev/test environments including continuous integration and continuous delivery workloads, or large-scale stateless applications.

**Reservations:** Receive a discount on your workloads when you [reserve resources in advance](https://azure.microsoft.com/reservations/). In return, Microsoft passes the savings onto you as discounts of up to 72 percent.

**Azure savings plan for compute:** Azure savings plan for compute is a flexible cost-saving plan that generates significant savings on pay-as-you-go prices with a one-year or three-year contract. Eligible compute services include virtual machines, dedicated hosts, container instances, Azure premium functions, and Azure app services. Savings apply to these compute services regardless of the region, instance size, or operating system. To further optimize cost and flexibility, you can combine an Azure savings plan with Azure Reservations. For more information, see [Azure savings plan overview](https://azure.microsoft.com/pricing/offers/savings-plan-compute/#benefits-and-features) and [Azure savings plan documentation](/azure/cost-management-billing/savings-plan/savings-plan-compute-overview).

**Azure dev/test pricing:** Take advantage of [discounted rates for development and testing](https://azure.microsoft.com/pricing/dev-test/). It includes the Microsoft software charges on Azure Virtual Machines and special dev/test pricing on other services.

**Extended security updates:** Receive [continued support](/lifecycle/faq/extended-security-updates) for SQL Server 2008 and SQL Server 2008 R2 even though they've reached the end of their support lifecycle. You can migrate your on-premises SQL Server instances to Azure Virtual Machines, Azure SQL Database, or stay on-premises and purchase extended security updates. You receive free extended security patches by migrating to an Azure VM.

## Tools and calculators

There are many valuable tools and calculators you can use to help prepare a business case for your cloud migration.

**Azure Total Cost of Ownership (TCO) Calculator:** Use the [TCO calculator](https://azure.microsoft.com/pricing/tco/calculator/) to estimate the cost savings you can realize when you migrate your workloads to Azure.

You can enter details of your on-premises infrastructure, including servers, databases, storage, and networking, licensing assumptions and costs. The calculator creates a match from Azure Services to create a high-level initial TCO comparison. However, the results of the TCO calculator need to be considered with care, since an on-premises server list is often complex and optimization steps can be taken when considering Azure.

**Retail Rates Prices API:** Use the [Retail Rates Prices API](/rest/api/cost-management/retail-prices/azure-retail-prices) to retrieve retail prices for all Azure services. Previously, the only way that you could retrieve prices for Azure services was to either use the Azure Pricing Calculator or use the Azure portal. This API gives you an unauthenticated experience to get retail rates for all Azure services. Use the API to explore prices for Azure services against different regions and different SKUs. The programmatic API can also help you create your own tools for internal analysis and price comparison across SKUs and regions.

**Azure VM cost estimator:** This Power BI model allows you to estimate your cost savings against pay-as-you-go pricing by optimizing Azure offers and benefits for VMs like Azure Hybrid Benefit and reserved instances. 

Download the following files to use the Power BI model:

- [Power BI template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/strategy/azure-virtual-machine-cost-estimator.pbix)
- [Excel file](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/strategy/on-premises-compute-unit-lists.xlsx)

**Azure Pricing Calculator:** Use the [pricing calculator](https://azure.microsoft.com/pricing/calculator/) to estimate your hourly or monthly costs for Azure products.

**Partner toolsets:** Microsoft Partners have tools in the [Azure Marketplace](https://azuremarketplace.microsoft.com/home) that can help create a migration cost analysis.

**Solution assessments:** Get assistance from a Microsoft solutions assessment expert or qualified partner as part of a [solution assessment engagement](https://www.microsoft.com/solutionassessments/).

**Azure Migration and Modernization Program:** Join [this program](https://azure.microsoft.com/migration/migration-modernization-program/) to get guidance and expert help at every stage of the cloud migration journey. Migrate infrastructure, databases, and apps so you can move forward with confidence.

### Learn about Azure

[Microsoft Learn training](/training/) offers many learning paths for Azure that you might want to consider as you build your business case.

- [Control Azure spending and manage bills with Azure Cost Management + Billing](/training/paths/control-spending-manage-bills/).
- [Microsoft Azure Well-Architected Framework - Cost Optimization](/training/modules/azure-well-architected-cost-optimization/)
- [Plan and manage your Azure costs](/training/modules/plan-manage-azure-costs/)
- [Analyze costs and create budgets with Azure Cost Management](/training/modules/analyze-costs-create-budgets-azure-cost-management/)
- [Configure and manage costs as a Microsoft partner by using Azure Cost Management](/training/modules/manage-costs-partner-cost-management/)

## Next steps

Learn more about how to share your strategy and business case to migrate to the cloud:

> [!div class="nextstepaction"]
> [Share your strategy](./share-your-strategy.md)
