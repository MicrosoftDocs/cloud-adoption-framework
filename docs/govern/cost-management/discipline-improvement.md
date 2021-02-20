---
title: Cost Management discipline improvement
description: Understand the potential tasks a company performs to develop and mature its Cost Management discipline in each phase of cloud adoption.
author: BrianBlanchard
ms.author: brblanch
ms.date: 09/17/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: govern
ms.custom: internal
---

# Cost Management discipline improvement

The Cost Management discipline attempts to address core business risks related to expenses incurred when hosting cloud-based workloads. Within the Five Disciplines of Cloud Governance, the Cost Management discipline is involved in controlling cost and usage of cloud resources with the goal of creating and maintaining a planned cost cycle.

This article outlines potential tasks your company perform to develop and mature your Cost Management discipline. These tasks can be broken down into planning, building, adopting, and operating phases of implementing a cloud solution. The tasks are then iterated on to allow the development of an [incremental approach to cloud governance](../guides/index.md#an-incremental-approach-to-cloud-governance).

![Phases of an incremental approach to cloud governance.](../../_images/govern/adoption-phases.png)
*Figure 1: Phases of an incremental approach to cloud governance.*

No single document can account for the requirements of all businesses. As such, this article outlines suggested minimum and potential example activities for each phase of the governance maturation process. The initial objective of these activities is to help you build a [policy MVP](../guides/index.md#an-incremental-approach-to-cloud-governance) and establish a framework for incremental policy improvement. Your cloud governance team will need to decide how much to invest in these activities to improve your Cost Management discipline capabilities.

> [!CAUTION]
> Neither the minimum or potential activities outlined in this article are aligned to specific corporate policies or third-party compliance requirements. This guidance is designed to help facilitate the conversations that will lead to alignment of both requirements with a cloud governance model.

## Planning and readiness

This phase of governance maturity bridges the divide between business outcomes and actionable strategies. During this process, the leadership team defines specific metrics, maps those metrics to the digital estate, and begins planning the overall migration effort.

**Minimum suggested activities:**

- Evaluate your [Cost Management toolchain](./toolchain.md) options.
- Develop a draft document for architecture guidelines and distribute to key stakeholders.
- Educate and involve the people and teams affected by the development of architecture guidelines.

**Potential activities:**

- Ensure budgetary decisions that support the business justification for your cloud strategy.
- Validate learning metrics that you use to report on the successful allocation of funding.
- Understand the desired cloud accounting model that affects how cloud costs should be accounted for.
- Become familiar with the digital estate plan and validate accurate costing expectations.
- Evaluate buying options to determine whether it's better to "pay as you go" or to make a precommitment by purchasing an Enterprise Agreement.
- Align business goals with planned budgets and adjust budgetary plans as necessary.
- Develop a goals and budget reporting mechanism to notify technical and business stakeholders at the end of each cost cycle.

## Build and predeployment

Several technical and nontechnical prerequisites are required to successfully migrate an environment. This process focuses on the decisions, readiness, and core infrastructure that proceeds a migration.

**Minimum suggested activities:**

- Implement your [Cost Management toolchain](./toolchain.md) by rolling out in a predeployment phase.
- Update the architecture guidelines document and distribute to key stakeholders.
- Develop educational materials and documentation, awareness communications, incentives, and other programs to help drive user adoption.
- Determine whether your purchase requirements align with your budgets and goals.

**Potential activities:**

- Align your budgetary plans with the [subscription strategy](../../decision-guides/subscriptions/index.md) that defines your core ownership model.
- Use the [Resource Consistency discipline strategy](../../decision-guides/resource-consistency/index.md) to enforce architecture and cost guidelines over time.
- Determine whether any cost anomalies affect your adoption and migration plans.

## Adopt and migrate

Migration is an incremental process that focuses on the movement, testing, and adoption of applications or workloads in an existing digital estate.

**Minimum suggested activities:**

- Migrate your [Cost Management toolchain](./toolchain.md) from predeployment to production.
- Update the architecture guidelines document and distribute to key stakeholders.
- Develop educational materials and documentation, awareness communications, incentives, and other programs to help drive user adoption.

**Potential activities:**

- Implement your cloud accounting model.
- Ensure that your budgets reflect your actual spending during each release and adjust as necessary.
- Monitor changes in budgetary plans and validate with stakeholders if additional sign-offs are needed.
- Update changes to the architecture guidelines document to reflect actual costs.

## Operate and post-implementation

After the transformation is complete, governance and operations must live on for the natural lifecycle of an application or workload. This phase of governance maturity focuses on the activities that commonly come after the solution is implemented and the transformation cycle begins to stabilize.

**Minimum suggested activities:**

- Customize your [Cost Management toolchain](./toolchain.md) based on your organization's changing needs.
- Consider automating any notifications and reports to reflect actual spending.
- Refine architecture guidelines to guide future adoption processes.
- Educate affected teams on a periodic basis to ensure ongoing adherence to the architecture guidelines.

**Potential activities:**

- Execute a quarterly cloud business review to communicate value delivered to the business and associated costs.
- Adjust plans quarterly to reflect changes to actual spending.
- Determine financial alignment to P&Ls for business unit subscriptions.
- Analyze stakeholder value and cost reporting methods on a monthly basis.
- Remediate underused assets and determine whether they're worth continuing.
- Detect misalignments and anomalies between the plan and actual spending.
- Assist the cloud adoption teams and the cloud strategy team with understanding and resolving these anomalies.

## Next steps

Now that you understand the concept of cloud cost governance, review the Cost Management discipline best practices to find ways to reduce your overall spend.

> [!div class="nextstepaction"]
> [Cost Management discipline best practices](./best-practices.md)
