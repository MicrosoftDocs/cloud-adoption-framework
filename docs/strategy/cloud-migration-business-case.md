---
title: Business justification for cloud migration
description: Use the Cloud Adoption Framework for Azure to develop a business case for cloud migration.
author: WendyRing
ms.author: wering
ms.date: 04/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Build a business justification for cloud migration

Developing a business case for moving to the cloud includes building a financial plan. This plan provides key components that help you plan your migration. Before you start building your business case and creating your financial plan, it's important to understand the key principles of cloud economics. These core principles will help you develop a clear business justification with tangible costs and returns.

## Benefits of moving to the cloud

The cloud drives two core benefits:

- Technical benefits
- Financial benefits

  :::image type="content" source="media\cloud-migration-business-case\benefits-cloud-migration-v2.png" alt-text="Diagram that summarizes core benefits of cloud migration, including technical and financial benefits.":::

### Technical benefits

**Scalability**: There's abilities that are limited on-premises and more accessible in the cloud, one of them being scalability. In the cloud, you can scale your resources up or down depending on usage, utilization, and demand.

:::image type="content" source="media\cloud-migration-business-case/scalability-time-deploy.png" alt-text="iagram that shows a comparison between traditional IT and cloud for scalability and time to deploy":::

**Availability**: Availability is another technical benefit of migrating to the cloud. It's more costly to build highly available infrastructure on-premises than to architect highly available infrastructure in the cloud.

**Security and compliance**: Security and compliance is a technical benefit of moving to Azure. Security infrastructure and toolsets keep you up to date with security threats on global networks. You benefit from corporate learnings around securing the platform, methodologies of intrusions and attacks, and learnings from multiple services beyond Azure.

**Capacity optimization**: Capacity optimization, where you pay only for what you consume over time, is another technical benefit of moving to the cloud. Your capacity can fluctuate depending on your business demands. You can scale your resources up or down to depending on what’s required.
The cloud improves how you deploy and provision or deprovision resources because it’s done dynamically. On-premises datacenters are frequently over-built to handle usage peaks, which might result in excess capacity and excess spend. For example, if your datacenter operates at a baseline of 30 percent, with regular spikes up to 70 percent, there's room for optimization in the cloud.

:::image type="content" source="media\cloud-migration-business-case/capacity-usage-optimization.png" alt-text="Diagram that shows capacity can be optimized in a cloud native environment":::

The initial technical benefits focus on the lift and shift model, where  you migrate workloads to infrastructure-as-a-service (IaaS) in the cloud. As you free up cash flow, continue your cloud adoption, and mature your workloads, you can reinvest the savings to modernize to different service levels. The goal is to get the most out of your on-premises investment, and then move those workloads to IaaS, potentially freeing up 20% to 30% of the overall required cash flow. Historically, this process would be considered a savings opportunity. This approach in the cloud is better viewed as a reinvestment opportunity.

Once you have your initial workloads in IaaS, think about moving some workloads to platform-as-a-service (PaaS). You’ll still provide the same type of service delivery however, you'll deliver it at a lower cost with more features and functionality. The next step in the iterative modernization process is moving some workflows and line-of-business applications to software-as-a-service (SaaS).

When you plan the phases of maturity for your workloads and create a plan for the reinvestment of your cloud savings, you can achieve more with every dollar you invest.

### Financial benefits

A digital transformation goes hand in hand with a financial transformation. When you're planning a migration to the cloud, there are financial considerations around how the cloud will affect your financial position, accounting, KPIs, and processes.

Different cost models are used in the cloud in comparison to on-premises. On-premises uses fixed cost models, where the cloud uses more variable cost models. In the cloud, you must think about the opportunities there are to unlock value. Take advantage of the technical benefits, that will in turn increase your financial benefits.

Cloud pricing and the variable cost model are fundamentally different from on-premises pricing and the fixed cost model. Understanding the opportunities the cloud can provide and how to unlock them is a critical step in evaluating your digital transformation plans.

When you move from on-premises to the cloud, you're shifting how you acquire capacity. You're moving from an upfront cash flow, to an upfront spend for your capacity in the cloud, in a pay-for-what-you-consume model, over time. On-premises, your cost structure and your capacity are fixed whatever your demand looks like. If revenue goes down and you need to reduce your IT costs, your options might be limited.

You can scale up and down in the cloud as demands of your business change. You're able to scale your capacity up and down and use a variable cost model as opposed to a fixed cost model. The elasticity of the cloud makes the pay-for-what-you-consume model possible. For your static workloads, you can take advantage lower costs by using the reserved instance pricing available in the cloud.

**OPEX pricing models**: One of the financial benefits of the cloud is the shift from CAPEX to OPEX and improved cashflow timing. In an on-premises environment, spend is typically in the capital expenditure category. When you move to the cloud, you frequently see a transition to operating expenses, where spend is spread out over time. Rather than paying for a resource up-front, you pay for the resource as you need it, resulting in improved cashflow timing. The transition from CAPEX to OPEX requires a shift from capital budgets to operating expense budgets, however, you can move cash flows out to the future.

An important consideration when planning your move to the cloud is EBITDA. EBITDA is a financial KPI that organization’s use to measure profitability. This metric ignores real costs like server spend. When moving to the cloud, EBITDA is affected because the metric can’t ignore costs like server depreciation. You can use other financial metrics that better measure increased business value, for example, cash flows, operating income, or cost of goods sold.  For more information about EBITDA, see the [Glossary of common finance terms](finance-vocabulary-terms.md).

**Reduced datacenter footprint**: Another financial benefit is you can reduce your datacenter footprint with cloud optimizations. On-premises data centers are frequently overbuilt for peaks, resulting in excess capacity and excess spend. Acquiring on-premises datacenter and server capacity has a significant lead-time. As a result, customers frequently invest well in advance of demand, resulting in under-utilized capacity. Capital sits in server spend, buildings, data center costs, power and cooling, and head count.

For example, you might have five megawatts of capacity are available in your datacenter. You might only be using three of those megawatts. The data center capacity is there and readily available for when demand increases. The spend for the extra capacity is for an entire environment when you're using only a portion of it.
When you migrate to the cloud, you reduce your data center footprint and offload excess capacity and lead time requirements to Microsoft. Microsoft makes sure the capacity is there for you to scale up and down as you need it. You no longer need to provision the capacity ahead of time.

**Increased productivity and service delivery**: Another financial benefit of the cloud is increased productivity and service delivery. One of the key improvements that the cloud can unlock is better DevOps processes. DevOps is the ability for continuous delivery, that enables the delivery of your products to the end user. The cloud provides faster time-to-market, increases in revenue, and increases in staff productivity. These improvements can have a direct economic impact on your business by driving efficiencies.

**Sustainability**: The cloud can help you reduce your carbon footprint. Many customers are focused on investing in becoming more green, improving their sustainability, and reducing their carbon footprint. As a takeaway from Microsoft’s sustainability journey, when we migrated to the cloud we reduced our carbon emissions and we took advantage of key technologies that Microsoft has built into our data centers. We use an internal carbon tax to fund innovation and drive proper behavior. Smart water approaches have also helped to reduce water usage, and our remote work processes and procedures have also accelerated some of those carbon reductions.

## Next steps

> [!div class="nextstepaction"]
> [Create a financial plan](./financial-models.md)
