---
title: Create a financial plan
description: Create a business case for your migration to the cloud that provides technical and financial timeline of your environment and can represent the opportunities for re-investment into further modernization.
author: WendyRing
ms.author: wering
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.topic: conceptual
ms.date: 04/23/2021
ms.custom: template-concept
---

# Building your business case

Your organization depends on information technology (IT) for its operations, and probably for creating and supplying its products as well. It's a significant expense. For these reasons, a move to the cloud must be carefully considered and planned.

One of the most important resources for a successful move to the cloud is a strong business case. A key reason to build your business case is it helps you plan for your migration. To justify a move to the cloud, your business case must demonstrate cost savings, cash-flow impact analysis, a financial roadmap for modernization, and the data needed to assess the benefits of a cloud migration.

## What is a business case?

A business case provides a view of the technical and financial timeline of your environment and can represent the opportunities for re-investment into further modernization.
Virtually all business activities have financial considerations, and some kind of financial planning is required. For major activities, the importance of a financial plan is underscored, and moving your IT activities to the cloud is a major activity.

### Learn about the benefits of the cloud

The benefits of moving to the cloud are not exclusively financial. There are also the benefits of increased capability, flexibility, and ease of scaling. It is important to learn about the other benefits, and they should be mentioned in the financial plan--even though they are not the focus--so that they are not lost sight of.

For information on cloud benefits, see [Build a business justification for cloud migration](cloud-migration-business-case.md).

### Differences between a Total Cost of Ownership (TCO) and a Business Case

:::image type="content" source="media\create-financial-plan\financial-plan-differ-TCO-business-case.png" alt-text="Line graph that contrasts Total Cost of Ownership (TCO) against a Business Case":::

- TCO is point-in-time focused, intended to provide a financial and business justification for cloud adoption. ROI models may also be viewed in the same way.
- A cloud business case provides a view of the technical and financial timeline of your environment and can represent the opportunities for re-investment into further modernization.

## Key components of a business case

When you are planning your business case to migrate to the cloud, there several key components to consider.

**Environment scope (technical and financial)**: As you build out the on-premises view of your environment, think about how your environment scope, from both a technical and financial perspective, is aligned. You want to be sure the technical environment you are using for your plan matches up to the financial data.

**Baseline financial data: Cost to run today**: When you build out your business case, it’s important to pull your baseline financial data. Common questions you can ask to gather the financial data needed are:

- How much does it cost to run my environment today?
- What am I spending on servers in an average year?
- What am I spending in my data center operations categories, for example, power or lease costs?
- When is the next hardware refresh?

**Projections: On-premises costs in on-premises scenario**: Forecast what your on-premises costs will be if you don’t migrate to the cloud.

**Projections: On-premises costs in Azure scenario**: Forecast what your on-premises costs will be when you migrate to the cloud in an Azure scenario.

**Projections: Migration timeline and Azure costs (optimized)**: Project what migration timeline and the Azure costs will be with a given environment. Consider how you can optimize and get the most out of your Azure investment. For example, use reserved instances, scale capacity up and down, use the Azure hybrid benefit, and right-size your resources.

 :::image type="content" source="media/create-financial-plan/optimization-opportunity.png" alt-text="Diagram that summarizes core benefits of cloud migration, including technical and financial benefits.":::

A business case is not just a point-in-time view. It’s a plan for a period of time. As you shift to the cloud, you reduce your spend over-time and create a cloud migration plan. You can model out what the ramp-down in spend will be on-premises over time associated with your cloud migration plan.

:::image type="content" source="media/create-financial-plan/optimized-consumption-plan.png" alt-text="Diagram of optimized Azure consumption plan.":::

Once on-premises workloads and cost structure have been identified, you can then build out your optimized Azure consumption plan

:::image type="content" source="media/create-financial-plan/cloud-on-premises-comparison.png" alt-text="Diagram of comparison of cloud to on-premises or status quo.":::

As a final step, when you create your business case, you want to compare the cloud environment to an on-premises or status quo scenario.
The Azure view will be comprised of on-premises costs that are being reduced over time, your Azure environment costs, and any migration costs associated with shifting to a cloud environment. It takes resources and time to shift your environment to the cloud, so it’s important to also take those into account in the business case. When you build out the Azure scenario, be sure to take into consideration all of the core benefits that Microsoft can address, and that the Azure billing models provide.

Cloud billing models and offers differ from on-premises however, they can create meaningful savings opportunities you can take advantage of to reduce cloud costs:

- **Azure Hybrid Benefit**: Reduce the costs of running your workloads in the cloud by using this licensing benefit. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit applies to RedHat and SUSE Linux subscriptions, too. To learn more, see Azure Hybrid Benefit, see [Azure Hybrid Benefit].

- **Spot virtual machines**: Deep discounts are available for interruptible workloads that do not need to be completed within a specific time frame by using spot virtual machines. For example, high-performance computing scenarios, batch processing jobs, or visual rendering applications, dev and test environments, including continuous integration and continuous delivery workloads or large-scale stateless applications. To learn more, see [Spot virtual machines].

- **Reservations**: Receive a discount on your workloads when you reserve your resources in advance. In return, Microsoft passes the savings onto you as discounts of up to 72 percent.1 For more information about Azure reservations, see [Azure reservations].

- **Azure dev and test pricing**: Take advantage of discounted rates for your development and testing, including the Microsoft software charges on Azure Virtual Machines and special dev and test pricing on other services.

- **Extended security updates**: Receive continued support for SQL Server 2008 and SQL Server 2008 R2 in the cloud, which have reached the end of their support (EOS) life cycle. You can migrate your on-premises SQL Server instances to Azure Virtual Machines, Azure SQL Database, or stay on-premises and purchase extended security updates. You'll receive free extended security patches by migrating to an Azure Virtual Machine.

You can take your Azure view and compare it to your on-premises or status quo scenario where there is no migration so you can assess the benefit of migrating to the cloud.

### Create financial models

Once you have identified your business and financial goals, you can create financial models to help demonstrate your cloud savings.

A rapid model is a form of financial modeling that focuses on the technical transformation of your organization. It can be lift and shift focused and based on the number of compute units. The rapid model has a pre-optimized cost structure and it highlights cash flow and savings.

A moderate model is a form of financial modeling that focuses on the financial transformation. It typically includes a cash-flow impact analysis and a financial roadmap for iterative modernization. The moderate model can include bridging more workloads to PaaS and SaaS.

## Costing tools

### Tools used to build financial models

There are many valuable tools and calculators you can use to prepare a business case and the financial models for your cloud migration.

**Azure Total Cost of Ownership (TCO) Calculator**: Use the [Total Cost of Ownership (TCO) Calculator](https://azure.microsoft.com/pricing/tco/calculator/)
 online tool to estimate the cost savings you can realize when you migrate your workloads to Azure.

Enter details of your on-premises infrastructure into the tool including servers, databases, storage, and networking, licensing assumptions and costs.

The Calculator creates a match from Azure Services to create a high-level initial TCO comparison. However, the results of the TCO calculator need to be considered with care, since an on-premises server list is often complex and optimization steps can be taken when considering Azure.

**Unified Pricing API**: Use the Retail Rates Prices API to get retail prices for all Azure services. Previously, the only way that you could retrieve prices for Azure services was to either use the Azure Pricing Calculator or use the Azure portal. This API gives you an unauthenticated experience to get retail rates for all Azure services. Use the API to explore prices for Azure services against different regions and different SKUs. The programmatic API can also help you create your own tools for internal analysis and price comparison across SKUs and regions.

**Azure Pricing Calculator**: Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator) to configure and estimate the costs for Azure products.

**Partner toolsets**: Microsoft Partners have tools in the [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/home) that can help create a cost analysis, for example, Cloud Recon and CloudLab.

**[Solution Assessment engagements](https://www.microsoft.com/solutionassessments/solutionassessments.aspx?rtc=1)**: Get assistance from a Microsoft solutions assessment expert or qualified partner.

**Azure Migration Program**: Join the  [Azure Migration Program](https://azure.microsoft.com/migration/migration-program/)to get the guidance and expert help you need at every stage of the cloud migration journey. Migrate infrastructure, databases, and apps—and move forward with confidence.

## Examples of cost analysis

### Sample cost detail screens

Here is an example of the cost detail output from the Total Cost of Ownership Calculator:

  :::image type="content" source="media/create-financial-plan/tco-calculator-compute-cost.png" alt-text="Listings from the TCO Calculator of hardware, software, electricity, virtualization, and VM detail costs, with totals.":::

### Sample cost breakdown screens

Here is an example of the cost breakdown from the Total Cost of Ownership Calculator:

  :::image type="content" source="media/create-financial-plan/tco-calculator-cost-breakdown.png" alt-text="Cost breakdowns of total on-premises and total Azure costs. There is a table and a graph for both breakdowns.":::

### Azure Unified Pricing API – Retail Rates endpoint

Azure customers can get retail prices for all Azure services with the Unified Pricing API – Retail Rates endpoint. For more information, see [Azure Retail Prices overview](/rest/api/cost-management/retail-prices/azure-retail-prices).

### Azure Pricing Calculator

- Use the  [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator) to configure and estimate the costs for Azure products.

### Other Azure cost resources

- [Optimize your Azure costs](https://azure.microsoft.com/overview/cost-optimization).

- Manage your cloud spending with confidence. Monitor and analyze your Azure bill with [Azure Cost Management and Billing](https://azure.microsoft.com/services/cost-management). Set budgets and allocate spending to your teams and projects.

### Example cost analysis

A custom Azure cost analysis compares costs of various options tailored to your environment.

  :::image type="content" source="media/create-financial-plan/azure-cost-analysis.png" alt-text="Table showing costs of various Azure services, with total service costs, for Pay as You Go, Optimized with HUB, Optimized with HUB 1 year R I, and Optimized with HUB 3 year R I":::

A rapid cost analysis focuses on technical transformation and it requires less input and fewer decisions. The key consideration with this financial model is it's a point-in-time and less precise.

  :::image type="content" source="media/create-financial-plan/azure-rapid-cost-analysis.png" alt-text="Monthly and annual costs, annual released cash flow for various pay options, compared with on-premises.":::

Here is a cost analysis that is very specific to your environment. It makes use of the Unified Pricing API.

  :::image type="content" source="media/create-financial-plan/customized-modeling.png" alt-text="Spreadsheet of various Azure items in various quantities. There is Excel code for one of the cells, showing use of the Unified Pricing API":::

### Learn about Azure with Microsoft Learn

[Microsoft Learn](/learn) offers many Azure learning paths that you might want to consider as you build you business case.

Especially relevant to the financial plan and building a business case is this learning path: [Control Azure spending and manage bills with Azure Cost Management + Billing](/learn/paths/control-spending-manage-bills).

- [Microsoft Azure Well-Architected Framework—Cost Optimization](/learn/modules/azure-well-architected-cost-optimization)
- [Plan and manage your Azure costs](/learn/modules/plan-manage-azure-costs)
- [Analyze costs and create budgets with Azure Cost Management](/learn/modules/analyze-costs-create-budgets-azure-cost-management)
- [Save money with Azure Reserved Instances](/learn/modules/save-money-with-azure-reserved-instances)
- [Optimize Azure costs with data analysis in Power BI](/learn/modules/optimize-costs-data-analysis-powerbi)
- [Configure and manage costs as a Microsoft partner by using Azure Cost Management](/learn/modules/manage-costs-partner-cost-management)

## Next steps

Learn more about Common finance vocabulary terms.

> [!div class="nextstepaction"]
> [Common finance vocabulary terms](./financevocabularyterms.md)
