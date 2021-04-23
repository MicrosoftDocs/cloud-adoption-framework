---
title: "Management in the Retail industry"
description: Describe the scenario's impact on operations management
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: operate
---

# Managing the cloud for the Retail industry

The [Manage methodology](../../manage/index.md) in the Cloud Adoption Framework for Azure outlines a path for implementing an operations baseline and developing that baseline throughout your cloud adoption lifecycle.

For retail companies, IT operations will be heavily influenced by the companies historical growth patterns; more specifically, the impact those growth patterns have had on your organizational structures across your technology teams. To understand how this influences operations management, review the article on [Initial organizational alignment](./organize.md#understand-common-growth-patterns-for-retailers).

## Operations management alignment questions

The [org alignment article](./organize.md#understand-common-growth-patterns-for-retailers) prompts for an answer to the following questions.

- Which is more important going forward: Innovation (Enable high pace of change) or Control/Stability (Limit pace of change to favor security, operations, and control)?
- Who is responsible for production changes: CCoE (Mix of central and workload teams) or Central team (Central IT or Central operations)

## First step: Build a baseline

Regardless of your desired end state for operations or the alignment questions above, you will want to start by building out a management baseline, as described in the [Manage methodology](../../manage/index.md).

As stated in that methodology, you could also deploy that baseline more quickly using Microsoft's opinionated solution, [Azure Automanage](/azure/automanage/automanage-virtual-machines).

## Align operations

The management baseline sets the tone for all operations management, by automating many of the repetitive tasks that IT staff are required to complete in on-prem datacenters. This frees up valuable time for some of your smartest people to tackle other challenges & move you closer to your [cloud maturity targets](./retail-cloud-maturity.md).

But first you have to account for some tasks that aren't so easy to automate. This is where the alignment questions above come into play. They help determine what the IT staff will focus on next.

Regardless of your answers above, IT is likely to hold accountability for performance, reliability, and cost across your portfolio of technology solutions. But the responsibility of delivering the work, executing the processes, and carrying the financial burden can be shared in an enterprise operations model through a CCoE structure.

Considers your answers from the questions above, as your review the following sections. Evaluate if you can shift some of the operational responsibilities to change the focus on Central IT staff.

## Workload operations

**Innovation:** If innovation & pace of change is a priority, then workload teams and developers need shorter cycles from development to testing and finally to production. In enterprise operations, separation of duty and landing zone segmentation allow workload teams to take a more active role in operations of mission-critical workloads. This shifts the budget and responsibility for application performance to the line of business teams or workload teams. To facilitate this shift in responsibility, Central IT focuses more heavily on development of guardrails through automated governance, platform operations, and enhanced baselines.

**Control:** If Central operations maintains full responsibility for the production environment, control increases and pace of changes slows. For security conscious companies, this may be the best strategy. But it does place a higher burden on Central IT to deliver the processes for managing mission-critical workload operations. It also reduces the amount of re-investment that can be made in your cloud maturity.

## Platform operations

Aside from mission critical workloads, retail companies rely on common technology platforms which drive the business. SQL Server, Containers, SAP, and Virtual Desktop are each common examples of share technology platforms in the retail industry. But, you probably have your own list of backend systems that a number of workloads require to operate.

These platforms are shared across multiple workloads, so operational responsibility can be easily shifted to workload teams. But, the cloud offers a variety of paths to reduce the amount of effort required to operate those technology platforms.

To reduce overhead and minimize operational burden:

- Consider PaaS-based alternatives to modernize many of your shared platforms. This is a common approach for platforms like SQL or Virtual Desktop.
- Evaluate options to use SaaS based [retail industry applications in the Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?search=retail&page=1)
- Follow CAF Scenarios to automate governance and operations tasks for more complex tech platforms, such as [SAP](../../scenarios/sap) or [WVD](../../scenarios/wvd).

## Enhanced baseline

For all remaining workloads, focus first on platform automation. Use the services available in Azure, such as, Azure Monitor, Azure Automation, Azure Policy, and others to enhance your operations baseline and automate common tasks previously completed manually from Central IT.

## Next step: Your next migration iteration

The [Manage methodology](../../manage/index.md) and the retail industry guidance above will establish efficient operations in your organizations & help move you closer to your target state of [retail cloud maturity](./retail-cloud-maturity.md). To continue on your journey, revisit any of the prior phases of cloud adoption & evaluate new ways improve your use of the cloud.

- [Cloud adoption strategy for the Retail industry](./strategy.md)
- [Cloud adoption plan for the Retail industry](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate common Retail industry technologies](./migrate.md)
- [Innovation in the Retail industry](./innovate.md)
- [Governance in the Retail industry](./govern.md)
- [Management in the Retail industry](./manage.md)