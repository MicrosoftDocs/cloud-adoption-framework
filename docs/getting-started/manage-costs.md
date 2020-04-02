---
title: "Cost optimization across an enterprise"
description: Learn the basics of managing costs associated with cloud adoption.
author: JanetCThomas
ms.author: janet
ms.date: 03/05/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: overview
---

<!-- cSpell:ignore architected -->

# Getting started: Enterprise cost optimization

One of the core disciplines of cloud governance is cost management. The discipline of cost management focuses on establishing budgets, monitoring cost allocation patterns, and implementing controls to improve cloud spending behaviors across the IT portfolio. However, enterprise cost optimization involves many other roles and functions to minimize cost and balance the demands of scale, performance, security, and reliability. This article maps those various supporting functions into one getting started guide to help create alignment between each of the involved teams.

## Get started

Governance is the cornerstone of cost optimization within any large enterprise. The following outlines cost optimization guidance within the context of governance. The subsequent steps in this checklist help each team get started on steps that target their role in cost optimization. Together, these steps will help get the entire enterprise started on a cohesive cost optimization journey together.

![Getting started with enterprise cost management](../_images/getting-started/cost-getting-started-map.png)

## Enterprise cost optimization begins with governance

The first discipline of cloud governance is cost management, which is a set of corporate policies, processes, and automated controls to monitor cost allocations, identify deviation from budget, and remediate issues which have led to unplanned costs.

**Involved teams:**

- Accountable team: [Cloud Governance Team](../organize/cloud-governance.md)
- Responsible or supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md), [Cloud Adoption Team](../organize/cloud-adoption.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Establish corporate policies and technical implementations to govern cost across the enterprise.
- Establish recurring processes to monitor underutilized or overprovisioned resources and any unplanned expenses.
- Establish reactive processes to work with workload owners to optimize spend.

**Guidance to support deliverable completion:**

- **Build governance capabilities:** If you are new to cloud governance, complete the [Get started with cloud governance guide](../govern/index.md). That guide will help establish a set of baseline governance processes and will demonstrate the cost management discipline within governance.
- **Improve cost management disciplines:** The fourth step of the guide above focuses on implementing cost management practices that will drive optimization of cost across the enterprise. For additional guidance on integrating cost management into governance, see [Improve the Cost Management discipline](../govern/guides/complex/cost-management-improvement.md) or jump to the [implementation guidance](../govern/guides/complex/cost-management-improvement.md#incremental-improvement-of-the-best-practices) for a list of technical suggestions.
- **Go deep on cost management in governance:** For deeper guidance, the [cost management discipline](../govern/cost-management/index.md) articles will drive clarity regarding cost optimization topics around [business risks](../govern/cost-management/business-risks.md), [indicators and metrics](../govern/cost-management/metrics-tolerance.md), [policy adherence processes](../govern/cost-management/compliance-processes.md), [iterative improvements](../govern/cost-management/discipline-improvement.md), [Azure tools](../govern/cost-management/toolchain.md), and a [template for recording decisions](../govern/cost-management/template.md).

## Steps to scale cost optimization

The governance team align can detect and drive significant cost optimization across most enterprises. Basic, data-driven resource sizing can have an immediate and measurable impact on costs.

But, as outlined on the article [Build a cost-conscious organization](../organize/cost-conscious-organization.md), an enterprise-wide focus on cost management and cost optimization can deliver much more value. The following steps each demonstrate ways the various teams can participate in a cost-conscious organization.

## Step 1. Define strategy

Strategic decisions have direct impact on cost controls, which ripple throughout the adoption life-cycle and beyond into long-term operations. Strategic clarity will improve cost optimization efforts driven by the governance team.

<!-- markdownlint-disable MD024 -->

**Involved teams:**

- Accountable team: [Cloud Strategy Team](../organize/cloud-strategy.md)
- Responsible or supporting teams: [Cloud Governance Team](../organize/cloud-governance.md), [Cloud Adoption Team](../organize/cloud-adoption.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Record motivations, outcomes, and business justification in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx). Create your first budget using Azure Cost Management.

**Guidance to support deliverable completion:**

- Strategy: [Understand motivations](../strategy/motivations.md): Critical business events and some migration motivations tend to be cost sensitive, increasing the importance of cost control for all subsequent efforts. Other forward looking motivations related to innovation or growth through migration may be focused more on top-line revenue. Understanding motivations will help understand how high of a priority cost management should be.
- Strategy: [Business outcomes](../strategy/business-outcomes/index.md): Some fiscal outcomes tend to be extremely cost sensitive. When the desired outcomes map to fiscal metrics, it can be wise to invest in the cost management discipline of governance very early.
- Strategy: [Business justification](../strategy/cloud-migration-business-case.md): The business justification serves as a high-level view of the overall financial plan for cloud adoption. This can be a good source for initial budgeting efforts.

## Step 2. Digital estate

The digital estate (or analysis of the existing IT portfolio) can aid in validating the business justification and provide a refined view of budgetary expectations.

**Involved teams:**

- Accountable team: [Cloud Strategy Team](../organize/cloud-strategy.md)
- Responsible or supporting teams: [Cloud Governance Team](../organize/cloud-governance.md), [Cloud Adoption Team](../organize/cloud-adoption.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Update the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) to reflect changes triggered by the digital estate analysis.
- Work with the governance team to align cost models and forecast models, including efforts to start optimizing spend through quantitative analysis.

**Guidance to support deliverable completion:**

- Plan: [Gather Inventory](../digital-estate/inventory.md): Establish a source of data for analysis of the digital estate prior to adoption.
- Plan: [Best Practice - Azure Migrate](../plan/contoso-migration-assessment.md): Use Azure Migrate to gather inventory
- Plan: [Incremental Rationalization](../digital-estate/rationalize.md#incremental-rationalization): During incremental rationalization a quantitative analysis will identify cloud candidates for budgeting purposes.
- Plan: [Align cost models and forecast models](../digital-estate/calculate.md): Use Azure Cost Management to align cost and forecast models by [creating budgets](https://docs.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json).

## Step 3. Adoption plan

The adoption plan provides clarity on the timeline of activities during adoption. Aligning that plan and digital estate analysis provides a means of forecasting growth of spending from month to month. It will also help the governance team align processes and identify spending patterns.

**Involved teams:**

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible or supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md), [Cloud Governance Team](../organize/cloud-governance.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Complete steps 1-6 of building a [cloud adoption plan](../plan/plan-intro.md#build-your-cloud-adoption-plan).
- Work with the cloud governance team to refine budgets and create realistic spending forecasts.

**Guidance to support deliverable completion:**

- Plan: [Build your cloud adoption plan](../plan/plan-intro.md#build-your-cloud-adoption-plan): Steps to build a plan with actionable workload, assets, and timeline details. This will provide the basis for spend over time (or cost forecasting). Spend over time is the initial baseline for all actionable optimization analysis within the Cost Management discipline of governance.

## Step 4. Landing zone best practices

The Ready methodology of the cloud adoption framework focuses heavily on the development of landing zones to host workloads in the cloud. During landing zone implementation, there are a number of cost optimization decisions to be considered.

**Involved teams:**

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md) or [Cloud Platform Team](../organize/cloud-platform.md)
- Responsible or supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md), [Cloud Governance Team](../organize/cloud-governance.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Deploy one or more landing zones capable of hosting workloads in the short term adoption plan.
- Ensure all landing zones meet cost optimization decisions and cost management requirements.

**Guidance to support deliverable completion:**

- Ready: [Track costs](../ready/azure-best-practices/track-costs.md#provide-the-right-level-of-cost-access): Establish a well-managed environment hierarchy, provide the right level of cost access, use additional cost management resources in each landing zone.
- Ready: [Optimize your cloud investment](https://docs.microsoft.com/azure/cost-management-billing/costs/cost-mgt-best-practices?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json): Best practices to optimize investments.
- Ready: [Create and manage budgets](https://docs.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json) Best practices for creating and managing budgets.
- Ready: [Optimize costs from recommendations](https://docs.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json): Best practices for using recommendations to optimize costs.
- Ready: [Monitor usage and spending](https://docs.microsoft.com/azure/cost-management-billing/costs/cost-mgt-alerts-monitor-usage-spending?toc=https://docs.microsoft.com/azure/cloud-adoption-framework/toc.json&bc=https://docs.microsoft.com/azure/cloud-adoption-framework/_bread/toc.json): Best practices for monitoring usage and spending within a landing zone.

## Step 5. Migration

Migration is a repeatable process executed by the cloud adoption team. Throughout that process, there are many opportunities to optimize costs across the portfolio. Many of these in-process decisions are applied to a small group of workloads during each migration wave or iteration.

**Involved teams:**

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible or supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md), [Cloud Governance Team](../organize/cloud-governance.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Benchmark, test, resize, and deploy a collection of fully optimized workloads.

**Guidance to support deliverable completion:**

- Migrate: [Migration-focused cost-controls](../migrate/azure-migration-guide/manage-costs.md) provides insights on the cloud-native cost optimization controls that prove useful during migration.
- Migrate: [Best practice for optimizing cost of migrated workloads](../migrate/azure-best-practices/migrate-best-practices-costs.md) contains a checklist of 14 best practices to follow before and after migration to maximize cost optimization of each workload release.

Long-term operational costs is a common thread across each area of migration process improvements. The following is a short list of process improvements grouped by the phase of the migration process:

- Migrate: [Prerequisites](../migrate/migration-considerations/prerequisites/index.md) provides articles on managing change and the backlog which each influence budgeted and actual cloud costs.
- Migrate: [Assess](../migrate/migration-considerations/assess/index.md) provides six specific processes from validating assumptions to understanding partner options, which each influence cloud optimization opportunities.
- Migrate: [Migrate](../migrate/migration-considerations/migrate/index.md) contains one process suggestion regarding remediating assets, which provide an opportunity to optimize the as-configured state, in favor of an optimized solution.
- Migrate: [Promote](../migrate/migration-considerations/optimize/index.md) from testing to decommissioning retired assets, promotion focuses heavily on testing, resizing, validating, and releasing migrated assets. This is the first clear point at which forecasts and budgets can be tested against actual performance and configuration.

## Step 6. Innovation

Innovation and development of new products requires a much deeper degree of architectural review. The cloud adoption framework provides details on the innovation process and product management thinking. But, cost optimization decisions regarding new innovations are largely out of scope in this guidance.

**Involved teams:**

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible or supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md), [Cloud Governance Team](../organize/cloud-governance.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Make key architectural decisions regarding new innovations to balance cost and other critical design considerations.

**Guidance to support deliverable completion:**

- Use the [Azure Architecture Review](https://docs.microsoft.com/assessments/?id=azure-architecture-review) to understand the balance in architecture decisions.
- Review the [Well-Architected Framework](https://docs.microsoft.com/azure/architecture/framework) for deeper guidance for cost-optimization during innovation.

## Step 7. Manage

Establishing a solid management baseline will collect data and create operational alerts, which can aid in detecting opportunities to optimize costs. The focus of this effort will create balance between resiliency and cost optimization.

**Involved teams:**

- Accountable team: [Cloud Operations Team](../organize/cloud-adoption.md)
- Responsible or supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md), [Cloud Governance Team](../organize/cloud-governance.md), and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

**Deliverables:**

- Monitor the enterprise environment for ongoing recommendations to optimize costs, aligned to the criticality and resiliency classifications of each workload.

**Guidance to support deliverable completion:**

- [Create business alignment](../manage/considerations/business-alignment.md) to gain clarity regarding criticality and appetite for resiliency investments.

## Value statement

Following these steps will help [build a cost-conscious organization](../organize/cost-conscious-organization.md). Through shared ownership and a collaborative focus with the right teams at the right times, cost optimization will be easier to implement.
