---
title: Achieve more with your cloud investment
description: Use the Cloud Adoption Framework and your cloud business case to reduce costs and reinvest into modernization.
author: WendyRing
ms.author: wering
ms.date: 04/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Achieve more with your investment in the cloud

When migrating to the cloud, it’s important to think differently about how you'll consume and manage your cloud resources. As you build your business case, it’s critical to understand the key principles of cloud economics and transform your mindset. Part of this transformation is discovering technical and financial flexibility, efficiencies, and capabilities that aren’t possible with your on-premises IT infrastructure. When you plan short- and long-term cloud solutions and align them to [business outcomes](./business-outcomes/index.md), you can achieve more with every dollar you invest.

## How does cloud pricing work?

Cloud costs are tied to compute and storage and include the underlying software licensing fees. The cloud uses a pay-for-what-you-consume model versus the up-front server infrastructure and software licensing costs that you would typically pay on-premises in your data center. On-premises, you typically have a combination of upfront costs and operating expenditures. When you move to the cloud, you shift to the pay-as-you-consume model and mainly operating expenditures.

To take advantage of the best pricing in the cloud, you must understand how you'll consume resources for your specific workloads. Once you have a consumption plan, you can establish your fixed and variable cost models to maximize your investment.

## Understand your workloads

On-premises, your architecture is typically provisioned for peak capacity. Migrating from on-premises to the cloud gives you the flexibility of scalability, and you scale up and down as needed. It’s critical to understand your workloads to realize the full benefits of the cloud.

**Idle capacity**: Azure helps eliminate the idle capacity created by overprovisioned architecture for coverage during peak usage. Rightsizing and eliminating workloads you don’t need helps reduce your idle capacity when moving to the cloud. This exercise delivers immediate savings and cash flow reductions.

**Unpredictable workloads**:  You can scale your compute resources up and down in the cloud as the demands of your business change. You're able to scale your capacity up and down and use a variable cost model as opposed to a fixed cost model. This elasticity of the cloud makes the pay-for-what-you-consume model possible and works well for your unpredictable workloads. Consider using virtual machine scale sets and snoozing VMs to only pay for the resources you need when you need them.

**Predictable workloads**: For your predictable workloads, you can take advantage of the cost-savings offers such as Azure Reservations.

:::image type="content" source="./media/achieve-more/capacity-usage-optimization.png" alt-text="Diagram of capacity usage.":::

**Initial clean-up, right-sizing, and optimization**:  When planning to move to Azure, review which workloads are no longer needed. This process of clean-up can help you build a stronger business case and show an immediate effect on your budgets. For workloads you still want to use and bring to the cloud, you can use tools to help optimize them, for example, Azure Migrate.

## Take advantage of cost-savings offers

There are many cost-savings offers the can help reduce your cloud costs:

**Azure Hybrid Benefit**: Reduce the costs of running your workloads in the cloud by using this licensing benefit. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit applies to RedHat and SUSE Linux subscriptions, too. To learn more, see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/).

**Spot virtual machines**: You can use spot virtual machines with deep discounts for workloads that can be interrupted and don't need to complete within a specific time frame. For example, high-performance computing scenarios, batch processing jobs, visual rendering applications, dev/test environments, including continuous integration and continuous delivery workloads, or large-scale stateless applications. To learn more, see [Spot virtual machines](https://azure.microsoft.com/pricing/spot/).

**Reservations**: Receive a discount on your workloads when you reserve your resources in advance. In return, Microsoft passes the savings onto you as discounts of up to 72 percent.1 For more information, see [Azure reservations](https://azure.microsoft.com/reservations/).

**Azure Dev/Test pricing**: Take advantage of discounted rates for your development and testing, including the Microsoft software charges on Azure Virtual Machines and special dev/test pricing on other services. For more information, see [Azure Dev/Test pricing](https://azure.microsoft.com/pricing/dev-test/).

**Extended security updates**: Receive continued support for SQL Server 2008 and SQL Server 2008 R2 in the cloud, which has reached the end of their support lifecycle. You can migrate your on-premises SQL Server instances to Azure Virtual Machines, Azure SQL Database, or stay on-premises and purchase extended security updates. You'll receive free extended security patches by migrating to an Azure Virtual Machine. To learn more, see [Lifecycle FAQ: Extended Security Updates](/lifecycle/faq/extended-security-updates).

## Continually optimize your environment

Microsoft provides frameworks and tools to help you understand your costs and continually optimize your environment:

Understand and forecast your costs: Monitor your bill, set budgets, and allocate costs to teams and projects with Azure Cost Management + Billing.

**Learn more:**

- [Optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations).
- [Prevent unexpected charges](/azure/cost-management-billing/cost-management-billing-overview).

Cost optimize your workloads: Optimize your resources and architecture with Azure best practices from Azure Advisor and the Microsoft Azure Well-Architected Framework.

**Learn more:**

- Read about [Azure Advisor](/azure/advisor/advisor-overview).
- Get [Azure Advisor cost recommendations](/azure/advisor/advisor-cost-recommendations).
- Learn about the [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review).
- Learn about the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/).

Save with Azure offers and licensing terms like the Azure Hybrid Benefit and Azure Reservations.:

**Learn more:**

- Learn about the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/).
- Learn about [Azure Hybrid Benefit for Windows Server](https://azure.microsoft.com/pricing/hybrid-benefit/).
- Review [pricing guidance for SQL Server Azure VMs](/azure/azure-sql/virtual-machines/windows/pricing-guidance).
- Learn about [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations).
- Read the [reserved instances FAQ](https://azure.microsoft.com/pricing/reserved-vm-instances/#faq).

Control your costs: Establish spending goals and policies with guidance from the Microsoft Cloud Adoption Framework for Azure. Implement cost controls with Azure Policy so your teams can go fast while complying with policy. For more information, see [enforce tagging conventions using Azure Policy](/azure/governance/policy/tutorials/govern-tags).

## Understand your financial stories

The core financial benefits of Azure are driven by a fundamental shift in the IT operating model. This shift benefits your organization's core financial statements and frees up cash flow for reinvestment:

**Balance sheet**: When you operate on-premises in datacenters, you typically have invested up front in long-term assets that limit the cash and capital required to grow your business. While in the cloud, you can shift datacenter operations costs into modernization, developing cloud applications, and other projects that drive business growth. This shift can make your balance sheet more agile.

**Cash flow statement**: The pay-for-what-you-consume model and the ability to apply policies and tags to your Azure resources help you improve the predictability of your cash flow statement. This model delays spend and improves your cash flow timing.

**Income statement (profit and loss)**: You can improve profitability over time by taking advantage of Azure's flexibility, low management costs, services, and pricing models.

## Achieve more with your investment

The goal of your cloud business case is to achieve more with every dollar invested. This goal can be accomplished by releasing committed cash flows and budgets that can be reinvested into further modernization. This concept is the velocity of the dollar - you accelerate value per dollar through phased reinvestment driving modernization and value.

The initial technical benefits of a cloud migration focus on the lift and shift model, where you migrate workloads to infrastructure-as-a-service (IaaS) in the cloud. The goal is to get the most out of your on-premises investment, and then move those workloads to IaaS, potentially freeing up cash flow. Historically, this process would be considered a savings opportunity. This approach in the cloud is better viewed as a *reinvestment opportunity*.

As you free up cash flow, continue your cloud adoption, and mature your workloads, you can reinvest the savings to modernize to different service levels. Once you have your initial workloads in IaaS, you might consider shifting some workloads to platform-as-a-service (PaaS). You’ll still provide the same type of service delivery however, you'll deliver it at a lower cost with more features and functionality. The next step in the iterative modernization process is moving some workflows and line-of-business applications to software-as-a-service (SaaS).

When you plan your phases of cloud maturity and the reinvestment of your cloud savings, and align with [business outcomes](./business-outcomes/index.md), you can achieve more with every dollar you invest.

## Next steps

Learn more about how to align your partner strategy when you migrate to the cloud.

> [!div class="nextstepaction"]
> [Strategy for partner alignment](./partner-alignment.md)
