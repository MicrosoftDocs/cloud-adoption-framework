---
title: 'Get started: Manage cloud costs'
description: Learn the basics of managing costs associated with cloud adoption.
author: martinekuan
ms.author: martinek
ms.date: 05/15/2020
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# Get started: Manage cloud costs

The Cost Management focuses on establishing budgets, monitoring cost allocation patterns, and implementing controls to improve cloud spending behaviors across the IT portfolio.

However, enterprise cost optimization involves many other roles and functions to minimize cost and balance the demands of scale, performance, security, and reliability. This article maps those supporting functions to help create alignment between the involved teams. The subsequent steps help each team take actions that target its role in cost optimization. Together, these steps will help your organization get started on a journey toward cost optimization.

## Step 1: Define a strategy

Strategic decisions directly affect cost controls, rippling through the adoption lifecycle and into long-term operations. Strategic clarity will improve cost optimization efforts, driven by the governance team.

**Deliverables:**

- Record motivations, outcomes, and business justification in the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).
- Create your first budget by using Microsoft Cost Management.

**Guidance to support deliverable completion:**

- [Understand motivations](../strategy/motivations.md). Critical business events and some migration motivations tend to be cost sensitive, increasing the importance of cost control for all later efforts. Other forward-looking motivations related to innovation or growth through migration might focus more on top-line revenue. Understanding motivations will help you decide how high to prioritize your cost management.
- [Business outcomes](../strategy/business-outcomes/index.md). Some fiscal outcomes tend to be extremely cost-sensitive. When the desired outcomes map to fiscal metrics, you should invest in Cost Management.
- [Business justification](../strategy/cloud-migration-business-case.md). The business justification serves as a high-level view of the financial plan for cloud adoption. This is a good source for initial budgeting efforts.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud governance team <li> Cloud adoption team <li> Cloud center of excellence or central IT team |

## Step 2: Develop a cloud adoption plan

The adoption plan provides clarity on the timeline of activities during adoption. Aligning the plan and the digital estate analysis allows you to forecast your monthly growth in spending. It also helps your cloud governance team align processes and identify spending patterns.

**Deliverables:**

- Complete steps 1 through 6 of building a [cloud adoption plan](../plan/plan-intro.md#build-your-cloud-adoption-plan).
- Work with your cloud governance team to refine budgets and create realistic spending forecasts.

**Guidance to support deliverable completion:**

- [Gather inventory](../digital-estate/inventory.md). Establish a source of data for analysis of the digital estate before adoption.
- [Best practice: Azure Migrate](../migrate/assess/index.md). Use Azure Migrate to gather inventory.
- [Incremental rationalization](../digital-estate/rationalize.md#incremental-rationalization). During incremental rationalization and quantitative analysis, identify cloud candidates for budgeting purposes.
- [Align cost models and forecast models](../digital-estate/calculate.md). Use Microsoft Cost Management to align cost and forecast models by [creating budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).
- [Build your cloud adoption plan](../plan/plan-intro.md#build-your-cloud-adoption-plan). Build a plan with actionable workload, assets, and timeline details. This plan provides the basis for spending over time (or cost forecasting). *Spending over time* is the initial baseline for all actionable optimization analysis within the Cost Management .

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Step 3: Implement best practices for landing zones

The Ready methodology of the Microsoft Cloud Adoption Framework for Azure focuses heavily on the development of landing zones to host workloads in the cloud. During implementation of landing zones, an organization should consider various decisions for cost optimization.

**Deliverables:**

- Deploy one or more landing zones that can host workloads in the short-term adoption plan.
- Ensure that all landing zones meet cost optimization decisions and cost management requirements.

**Guidance to support deliverable completion:**

- [Track costs](../ready/azure-best-practices/track-costs.md#provide-the-right-level-of-cost-access). Establish a well-managed environment hierarchy, provide the right level of cost access, and use additional cost management resources in each landing zone.
- [Optimize your cloud investment](/azure/cost-management-billing/costs/cost-mgt-best-practices?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Understand best practices for optimizing investments.
- [Create and manage budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Understand best practices for creating and managing budgets.
- [Optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Understand best practices for using recommendations that will optimize costs.
- [Monitor usage and spending](/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json). Understand best practices for monitoring usage and spending within a landing zone.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Step 4: Complete waves of migration effort

Migration is a repeatable process executed by the cloud adoption team. Throughout this process, there are many opportunities to optimize costs across your portfolio. Many of these in-process decisions are applied to a small group of workloads during each migration wave or iteration.

**Deliverables:**

- Benchmark, test, resize, and deploy a collection of fully optimized workloads.

**Guidance to support deliverable completion:**

- [Migration-focused cost-control mechanisms](../migrate/azure-migration-guide/manage-costs.md) provides insights about the cloud-native cost optimization controls that help during migration.
- [Best practices for optimizing cost of migrated workloads](../migrate/azure-best-practices/migrate-best-practices-costs.md) contains a checklist of 14 best practices to follow before and after migration to maximize cost optimization of each workload release.

Long-term operational costs are a common theme in each area of migration process improvements. This list of process improvements is organized by the phase of the migration process:

- [Prerequisites](../migrate/migration-considerations/prerequisites/index.md) provides information on managing change and the backlog, which influences both budgeted and actual cloud costs.
- [Assess](../migrate/migration-considerations/assess/index.md) provides six specific processes, from validating assumptions to understanding partner options. Each process influences cloud optimization opportunities.
- [Migrate](../migrate/migration-considerations/migrate/index.md) contains one process suggestion about remediating assets. This suggestion provides an opportunity to optimize the as-configured state, in favor of an optimized solution.
- [Promote](../migrate/migration-considerations/optimize/index.md) focuses heavily on testing, resizing, validating, and releasing migrated assets, along with decommissioning retired assets. This is the first clear point at which forecasts and budgets can be tested against actual performance and configuration.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Step 5: Drive customer-focused innovation

Innovation and development of new products require a much deeper degree of architectural review. The Cloud Adoption Framework provides details on the innovation process and product management thinking. Cost optimization decisions about innovations are largely out of scope in this guidance.

**Deliverables:**

- Make key architectural decisions about innovations to balance cost and other critical design considerations.

**Guidance to support deliverable completion:**

- Use the [Microsoft Azure Well-Architected Review](/assessments/?id=azure-architecture-review) to understand the balance in architecture decisions.
- Review the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) for deeper guidance on cost optimization during innovation.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Step 6: Implement sound operations

Establishing a solid management baseline will help you collect data and create operational alerts. This effort can aid in detecting opportunities to optimize costs. It will create a balance between resiliency and cost optimization.

**Deliverables:**

- Monitor your enterprise environment for ongoing recommendations to optimize costs, aligned to the criticality and resiliency classifications of each workload.

**Guidance to support deliverable completion:**

- [Create business alignment](../manage/considerations/business-alignment.md) to gain clarity regarding criticality and appetite for resiliency investments.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud operations team | <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Value statement

Following these steps helps you [build a cost-conscious organization](../organize/cost-conscious-organization.md). Simplify cost optimization by using shared ownership and driving collaboration with the right teams at the right times.
