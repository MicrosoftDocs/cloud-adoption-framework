---
title: 'Get started: Ensure consistent performance across a portfolio'
description: Learn the basics of managing performance across a portfolio, including maintaining performance, setting expectations, and creating organizational alignment.
author: Zimmergren
ms.author: tozimmergren
ms.date: 05/15/2020
ms.topic: conceptual
ms.custom: internal, UpdateFrequency3
---

# Get started: Ensure consistent performance across a portfolio

How do you ensure adequate performance across a portfolio of workloads? The steps in this guide can help you establish processes for maintaining that level of performance.

Performance also depends on other roles and functions. This article maps those supporting functions to help you create alignment among the involved teams.

Centralized operations management is the most common approach to consistent performance across the portfolio. Decisions about operational practices define the operations baseline and any holistic enhancements.

The first step in this guide helps the operations team get started. The subsequent steps help the entire enterprise get started on a shared journey toward enterprise performance across the portfolio of workloads.

## Step 1: Establish operations management requirements

Understand how to [manage your Azure cloud estate](../manage/index.md).

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud operations team | <li> Cloud strategy team <li> Cloud adoption team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Step 2: Administer your Azure estate

[Administer](../manage/administer.md) your Azure cloud estate.

**Guidance to support deliverable completion:**

- Ensure that all workloads and resources follow [proper naming and tagging conventions](../ready/azure-best-practices/naming-and-tagging.md). [Enforce tagging conventions by using Azure Policy](/azure/governance/policy/tutorials/govern-tags), with a specific emphasis on tags for `criticality`.
- If you're new to cloud governance, establish [governance policies, processes, and disciplines](../govern/index.md) by using the Govern methodology.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud strategy team <li> Cloud operations team <li> Cloud center of excellence or central IT team |

## Step 3: Define strategy

Strategic decisions directly affect performance, rippling through the adoption lifecycle and into long-term operations. Strategic clarity improves performance efforts across the portfolio. That clarity also helps the operations team understand which workloads need a degree of workload specialization and advanced operations.

**Deliverables:**

- Record motivations, outcomes, and business justification in your adoption strategy and plan documents.
- Ensure that the management baseline provides operational support that aligns with the strategic direction of cloud adoption.

**Guidance to support deliverable completion:**

- [Understand motivations](../strategy/motivations.md): Critical business events and some migration motivations tend to be cost sensitive, which increases the importance of cost control for all later efforts. Other forward-looking motivations related to innovation or growth through migration might be focused more on top-line revenue. Understanding motivations can help you decide how high to prioritize your cost management.
- [Business outcomes](../strategy/business-outcomes/index.md): Some fiscal outcomes tend to be extremely cost sensitive. When the desired outcomes map to fiscal metrics, you should invest in the Cost Management governance discipline early.
- [Business justification](../strategy/cloud-migration-business-case.md): The business justification serves as a high-level view of the financial plan for cloud adoption. This can be a good source for initial budgeting efforts.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or central IT team |

## Step 4: Assess and plan for workload adoption

The digital estate (or analysis of the existing IT portfolio) can aid in validating the business justification and provide a refined view of the IT portfolio. The adoption plan provides clarity on the timeline of activities during adoption. Aligning that plan and digital estate analysis provides a means of planning for future dependencies on operations management.

Understanding the plan also invites the cloud operations team into the development cycle. The team can then evaluate and plan for any changes to the management baseline that are required to provide workload operations.

**Deliverables:**

- Update adoption and plan documents to reflect changes triggered by the digital estate analysis.
- Work with the cloud operations team to clearly define the criticality and business impact of each workload in the near-term and long-term adoption plan.
- Work with the cloud operations team to establish a timeline for operations readiness.

**Guidance to support deliverable completion:**

- [Gather inventory](../digital-estate/inventory.md): Establish a source of data for analysis of the digital estate before adoption.
- [Best practice: Azure Migrate](../migrate/assess/index.md): Use Azure Migrate to gather inventory.
- [Incremental rationalization](../digital-estate/rationalize.md#incremental-rationalization): During incremental rationalization, use a quantitative analysis to identify cloud candidates for budgeting purposes.
- [Align cost models and forecast models](../digital-estate/calculate.md): Use Microsoft Cost Management to align cost and forecast models by [creating budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json).
- [Build your cloud adoption plan](../plan/plan-intro.md#build-your-cloud-adoption-plan): Build a plan with actionable workload, asset, and timeline details.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud governance team <li> Cloud operations team <li> Cloud center of excellence or central IT team |

## Step 5: Expand the landing zones

The Ready methodology of the Cloud Adoption Framework focuses heavily on the development of landing zones to host workloads in the cloud. During landing zone implementation, various decisions can affect operations.

Consult the cloud operations team to help review the landing zone for operations improvements. Also consult the cloud governance team to understand Resource Consistency policies and design guidance, which can affect the landing zone design.

**Deliverables:**

- Deploy one or more landing zones that can host workloads in the short-term adoption plan.
- Ensure that all landing zones meet operations decisions and resource consistency requirements.

**Guidance to support deliverable completion:**

- [Improve landing zone operations](../ready/considerations/landing-zone-operations.md): Best practices for improving operations within a landing zone.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud operations team <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Step 6: Adoption

Long-term operations might be affected by the decisions that you make during migration and innovation efforts. Maintaining consistent alignment early in adoption processes helps remove barriers to production release. It also reduces the effort required to onboard new solutions into operations management practices.

**Deliverables:**

- Test operational readiness of production deployments by using Resource Consistency policies.
- Validate adherence to design guidance for resource consistency and to operations requirements.
- Document any advanced operations requirements in the [operations management workbook](https://raw.githubusercontent.com/Microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx).

**Guidance to support deliverable completion:**

- [Environmental readiness checklist](../migrate/migration-considerations/prerequisites/planning-checklist.md)
- [Pre-promotion checklist](../migrate/migration-considerations/optimize/ready.md)
- [Production release checklist](../migrate/migration-considerations/optimize/promote.md)

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud operations team <li> Cloud strategy team <li> Cloud governance team <li> Cloud center of excellence or central IT team |

## Value statement

The preceding steps will help you implement controls and processes to ensure performance across the enterprise and all hosted resources.
