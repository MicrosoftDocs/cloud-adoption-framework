---
title: Business justification for cloud migration
description: Use the Cloud Adoption Framework for Azure to learn to start developing a business justification for cloud migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Build a business justification for cloud migration

Developing a business case for moving operations to the cloud includes building a cloud financial plan that provides a view of the technical and financial timeline of your environment. Cloud migration can generate early return on investment (ROI) from cloud transformation efforts. Before you start building your business case and creating your financial plan, it's important to articulate the key principles of cloud economics. These core principles will help you develop a clear business justification with tangible costs and returns.

## Benefits of moving to the cloud

We focus on three kinds of benefits of moving your operations to the cloud:

- Economic benefits
- Financial benefits
- IT and business transformation

![This diagram summarizes benefits of migrating, including economic, financial, and I T and business transformation.](media/cloud-migration-business-case/benefits-cloud-migration.png)

### Economic benefits

Economic benefits are the principles that shift when you migrate from your on-premises architecture to your cloud architecture.

One of the economic benefits of moving to the cloud is the ability to optimize your data center costs to generate value.  Servers make up a large portion of the expense of an on-premises datacenter. If your servers are mostly idle, those expenses are wasted.

On-premises datacenters are frequently over-built to handle usage peaks, which might result in excess capacity and excess spend. If your datacenter operates at a baseline of 30 percent, with regular spikes up to 70 percent, there's room for optimization in the cloud.

An on-premises datacenter must have enough servers to accommodate not only the regular spikes, but also the unknown usage requirements. Adding on-premises datacenter and server capacity requires significant lead time. As a result, you might invest significantly in advance of uncertain demand, which results in under-utilized capacity.

![This diagram shows on-premises costs, datacenter capacity, and server capacity.](media/cloud-migration-business-case/optimize-datacenter-costs.png)

Another clear economic benefit to your organization from moving to the cloud is reducing unused capacity, which creates an opportunity to optimize your spend. You can save money by using hourly pricing for seasonal patterns and occasional bursts. You’re no longer paying for the uncertainty of fluctuating workloads. Your base workloads can use reserved instances, consistently meeting your needs.

Finally, moving to the cloud lowers your sunk costs, because you aren't buying equipment that you might or might not need.

![This diagram shows unused capacity, fluctuations, and base workload.](media/cloud-migration-business-case/optimized-cloud-usage.png)

### Financial benefits

Financial benefits are the structural financial changes that occur when moving to the cloud.

One of the financial benefits of moving to the cloud is budgeting. When you move your workflows from on-premises servers, your capital expenses become operating expenses. This change improves your ability to understand workload level costs and improves predictability in budgeting.

In addition to better budgeting, cost management is another financial benefit of moving to the cloud. A better understanding of workload ROI is possible due to an improved understanding of your cost structure. Tagging and cost management tools in Azure help you gain insights and understand the direct costs to run a service. This gives you direct visibility into project ROI that can be difficult to assess with an on-premises architecture.

Moving to the cloud also improves performance management, offering more predictability and better cash flow timing.

On-premises capital expenses are many times lumpy. For example, purchasing hardware doesn’t always happen on a regular, monthly schedule. This variability drives cash flow and Profit and Loss (P&L) variability.

Be aware of earnings before interest, taxes, depreciation, and amortization (EBITDA), which can be worse after moving to the cloud.

## IT and business transformation

Moving to the cloud offers another benefit - new agility to your organization. Let’s compare traditional IT with cloud support:

|                       | Traditional IT | Cloud support |
|-----------------------|----------------|---------------|
| **Time to provision** | Weeks/months to provision resources | Minutes/hours to provision resources by self-service access |
| **Hardware usage**    | 1 CPU for 100 hours | 100 CPUs for 1 hour |
| **Location**          | Location dependent | Accessible anywhere |

Agility influences not only IT Operations and business units. Agility also impacts finance in the allocation of budgets.

**Time to provision**: It can take weeks or even months in the on-premises world to get budget approval and to provision resources to extend capacity.

In the cloud, you can spin up resources in short order. You can deprovision resources easily or reallocate them to other projects. This agility applies not only to the technical resources but also to the budgetary allocation to support those resources.

**Hardware usage:** In a traditional datacenter, resources are assigned to certain workloads for long periods of time. In the cloud, you can be much more flexible in your hardware usage. This fact enables the increase of business optionality, positive return on investment projects, and the ability to take advantage of new technical opportunities because of reduced sunk investments and technical debt.

**Location:** The on-premises approach is tied to the location of your datacenter. In the cloud, you can have resources accessible anywhere.

## Optimize your Azure investment

As you migrate to the cloud, you’ll have options to make the most of your investment through incremental modernization. Each iteration of modernization has the potential to free up committed cash flows and budgets that can be reinvested into further modernization.

Start with your existing private on-premises cloud. Support legacy workloads, keeping non-end of life or under depreciated gear. As you Lift and Shift to Infrastructure as a Service, Azure virtual machines will host your workloads.

From there, you can migrate some of those workloads to Platform as a Service. As you continue to migrate, you can implement some work as Software as a Service.
As you move more work to the cloud, you free up budget and other resources that you can reinvest into further modernization, getting more out of every dollar of your investment.

## Next steps

> [!div class="nextstepaction"]
> [Create a financial plan](./financial-models.md)
