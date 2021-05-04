---
title: Business justification for cloud migration
description: Use the Cloud Adoption Framework to learn about the benefits of Azure and to develop a business justification for cloud migration.
author: WendyRing
ms.author: wering
ms.date: 04/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Build a business justification for cloud migration

Developing a business case for moving to the cloud includes building a financial plan that takes technical considerations into account and aligns with [business outcomes](business-outcomes/index.md). This plan provides key components to help you gain support and buy-in from your Finance team. Their support helps accelerate your organization's cloud migration and enables business [agility](business-outcomes/agility-outcomes.md). Before you start building your business case, it's important to understand the key principles of [Cloud economics](https://www.microsoft.com) that you can use to develop a clear business justification with tangible costs and returns.

## Why move to the cloud?

The cloud drives technical and financial benefits, efficiencies, and capabilities that aren’t possible with on-premises IT infrastructure.

  :::image type="content" source="media/cloud-migration-business-case/benefits-cloud-migration-v2.png" alt-text="Diagram that summarizes core benefits of cloud migration, including technical and financial benefits.":::

### Technical benefits

**Scalability**: There's abilities that are limited on-premises and more accessible in the cloud, one of them being scalability. In the cloud, you can scale your resources up or down depending on usage, utilization, and demand. Your time to provision will decrease, hardware utilization improves, and your Azure resources can be accessible everywhere due to the availability of multiple Azure regions.

**Availability**: Availability is another technical benefit of migrating to the cloud. It's more costly to build highly available infrastructure on-premises than to architect highly available infrastructure in the cloud.

**Security and compliance**: Security and compliance is a technical benefit of moving to Azure. Security infrastructure and toolsets keep you up to date with security threats on global networks. You benefit from corporate learnings around securing the platform, methodologies of intrusions and attacks, and learnings from multiple services beyond Azure.

**Capacity optimization**: Capacity optimization, where you pay only for what you consume over time, is another technical benefit of moving to the cloud. Your capacity can fluctuate depending on your business demands. You can scale your resources up or down to depending on what’s required, and decrease the time to provision or deprovision resources because it’s done dynamically. On-premises datacenters are frequently over-built to handle usage peaks, which might result in excess capacity and excess spend. For example, if your datacenter operates at a baseline of 30 percent, with regular spikes up to 70 percent, there's room for optimization in the cloud.

The initial technical benefits focus on the lift and shift model, where  you migrate workloads to infrastructure-as-a-service (IaaS) in the cloud. As you free up cash flow, continue your cloud adoption, and mature your workloads, you can reinvest the savings to modernize to different service levels. The goal is to get the most out of your on-premises investment, and then move those workloads to IaaS, potentially freeing up 20% to 30% of the overall required cash flow. Historically, this process would be considered a savings opportunity. This approach in the cloud is better viewed as a reinvestment opportunity.

Once you have your initial workloads in IaaS, you might think about moving some workloads to platform-as-a-service (PaaS). You’ll still provide the same type of service delivery however, you'll deliver it at a lower cost with more features and functionality. The next step in the iterative modernization process is moving some workflows and line-of-business applications to software-as-a-service (SaaS).

### Financial benefits

**OPEX pricing models**: One of the financial benefits of the cloud is the shift from capital expenditure (CAPEX) to operational expenditure (OPEX) and improved cashflow timing. In an on-premises environment, spend is typically in the capital expenditure category. When you move to the cloud, you frequently see a transition to operating expenses, where spend is spread out over time. With an operational expense (OPEX) model, the cloud allows you to create resources as needed, and only pay for what you use.

An important consideration when planning your move to the cloud is earnings before interest, taxes, depreciation, and amortization (EBITDA). EBITDA is a financial key performance indicator (KPI) that organization’s use to measure profitability. When moving to the cloud, EBITDA is affected because the metric can’t ignore costs like server depreciation. You can use other financial metrics that better measure increased business value, for example, cash flows or operating income. For more information about EBITDA, see the [Glossary of common finance terms](finance-vocabulary-terms.md).

**Reduced datacenter footprint**: Another financial benefit is you can reduce your datacenter footprint with cloud optimizations. On-premises data centers are frequently overbuilt for peaks, resulting in excess capacity and excess spend. Acquiring on-premises datacenter and server capacity has a significant lead-time. As a result, customers frequently invest well in advance of demand, resulting in under-utilized capacity. Capital sits in server spend, buildings, data center costs, power and cooling, and head count.

**Increased productivity and service delivery**: Another financial benefit of the cloud is increased productivity and service delivery. One of the key improvements that the cloud can unlock is better DevOps processes. DevOps is the ability for continuous delivery, that enables the delivery of your products to the end user. The cloud provides faster time-to-market, increases in revenue, and increases in staff productivity. These improvements can have a direct economic impact on your business by driving efficiencies.

**Sustainability**: The cloud can help you reduce your carbon footprint. Many customers are focused on investing in becoming more green, improving their sustainability, and reducing their carbon footprint. As a takeaway from Microsoft’s sustainability journey, when we migrated to the cloud we reduced our carbon emissions and we took advantage of key technologies that Microsoft has built into our data centers. We use an internal carbon tax to fund innovation and drive proper behavior. Smart water approaches have also helped to reduce water usage, and our remote work processes and procedures have also accelerated some of those carbon reductions.

## Next steps

> [!div class="nextstepaction"]
> [Create your business case](./create-financial-plan.md)
