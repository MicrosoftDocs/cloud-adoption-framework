---
title: Managing the cloud in the retail industry
description: Managing a portfolio of retail applications in the cloud. Use these questions to create a baseline from which to work.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Managing the cloud for the retail industry

The Manage methodology in the Cloud Adoption Framework for Azure offers a path for implementing an operations baseline. You can develop that baseline throughout your cloud adoption lifecycle. For more information, see [Cloud management in the Cloud Adoption Framework](../../manage/index.md).

For retail companies, IT operations are heavily influenced by the company's historical growth patterns. Those growth patterns influence your organizational structures across your technology teams. To understand how history affects operations management, see [Understand common growth patterns for retailers](./organize.md#common-growth-patterns-for-retailers).

## Operations management alignment questions

The [org alignment article](./organize.md#common-growth-patterns-for-retailers) prompts the following questions.

- Which is more important in the future?

  - **Innovation:** Enable high pace of change.
  - **Control and stability:** Limit pace of change to favor security, operations, and control.

- Who is responsible for production changes?

  - **Cloud center of excellence (CCoE):** A mix of central and workload teams.
  - **Central team:** Central IT or central operations.

## Build a baseline

Start by building out a management baseline, as described in the [Manage methodology](../../manage/index.md#get-started).

You can deploy that baseline more quickly using Microsoft's solution, Azure Automanage. For more information, see [Azure Automanage for virtual machines](/azure/automanage/automanage-virtual-machines).

### Align operations

The management baseline sets the tone for all operations management. The baseline automates repetitive tasks that IT staff complete in on-premises datacenters. This change frees up valuable time to tackle other challenges and move toward your cloud maturity targets. For more information, see [Cloud maturity model for retail](./retail-cloud-maturity.md).

Begin by finding tasks that aren't so easy to automate. The alignment questions above help determine what the IT staff focuses on next.

IT is likely to be accountable for performance, reliability, and cost across your technology solutions. The responsibility of delivering the work, executing the processes, and carrying the financial burden can be shared in an enterprise operations model through a CCoE structure.

Consider your answers from the questions above, as your review the following sections. Evaluate whether you can shift some of the operational responsibilities to change the focus on central IT staff.

## Workload operations

If innovation and pace of change is a priority, workload teams and developers need shorter cycles from development to testing, and to production. In enterprise operations, separation of duties and landing zone segmentation allows workload teams to take a more active role in mission-critical workloads. This approach shifts the budget and responsibility for application performance to the line-of-business teams or workload teams. To ease this shift in responsibility, central IT focuses more heavily on development of guardrails through automated governance, platform operations, and enhanced baselines.

If control is a priority, central operations maintains full responsibility for the production environment, control increases, and the pace of changes slows. For security conscious companies, this strategy might be the best. Such a strategy places a higher burden on central IT to deliver the processes for managing mission-critical workload operations. It also reduces the amount of reinvestment that can be made in your cloud maturity.

## Platform operations

Aside from critical workloads, retail companies rely on common technology platforms. SQL databases, containers, SAP, and virtual desktop infrastructure are common examples of shared technology platforms in the retail industry. Your workloads might require other platforms to operate.

These platforms are shared across multiple workloads, so operational responsibility can be easily shifted to workload teams. The cloud offers different paths to reduce the amount of effort required to operate those technology platforms.

To reduce overhead and minimize operational burden:

- Consider platform as a service (PaaS)-based alternatives to modernize many of your shared platforms. This approach is common for platforms like SQL databases or virtual desktop infrastructure.
- Evaluate options to use software as a service (SaaS)-based retail industry applications from the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?search=retail&page=1).
- Follow Cloud Adoption Framework scenarios to automate tasks for complex platforms, such as [SAP](../../scenarios/sap/index.md) or [Azure Virtual Desktop](../../scenarios/wvd/index.md) (formerly Windows Virtual Desktop).

## Enhanced baseline

For all remaining workloads, focus first on platform automation. Use Azure services such as Azure Monitor, Azure Automation, and Azure Policy to enhance your operations baseline and automate common tasks previously completed manually.

## Next steps

The Manage methodology and the retail industry guidance in this article can establish efficient operations in your organizations. They can help move you closer to your target state of retail cloud maturity. To continue on your cloud adoption journey, revisit prior phases and evaluate improvements for your use of the cloud.

- [Cloud adoption strategy for the retail industry](./strategy.md)
- [Cloud adoption plan for the retail industry](./plan.md)
- [Azure landing zones for the retail industry](./ready.md)
- [Migrate common retail industry technologies](./migrate.md)
- [Innovation in the retail industry](./innovate.md)
- [Governance in the retail industry](./govern.md)
- [Management in the retail industry](./manage.md)
