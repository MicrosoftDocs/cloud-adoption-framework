---
title: "Getting started: An accelerated migration journey in Azure"
description: Getting started on a migration journey in Azure
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Getting started: An accelerated migration journey in Azure

For some customers, migration is a purely technical process. If technology alone is enough, the [Migrate methodology](../migrate/index.md) could be sufficient to start migrating existing vms.

## Accelerating migration

Addressing migration as an IT-only process can lead to a number of roadblocks, which can only be overcome through proper alignment between various stakeholders. This getting started guide represents the smallest unit of effort required to **align business and IT** to **accelerate migration success**. Use this guide as a checklist to evaluate where you are at in your migration maturity & to find actionable steps that you may have missed. At the end of this article are a few suggested process improvements you may want to consider after you've mastered your first migration to Azure.

## Actionable steps checklist

The following steps reduce the amount of materials and the processes required during initial efforts to align an overall migration effort.

![Getting Started with Migration in Azure](../_images/getting-started/migration-getting-started-map.png)

> [!NOTE]
> The following checklist helps find opportunities to take action to ensure you are ready for migration. For a deeper, personalized assessment of migration readiness, use the Strategic Migration and Readiness Tool or [SMART Assessment](/assessments/?id=Strategic-Migration-Assessment) to identify the specific steps that best align to your current state needs.

1. **Business strategy:** Are all stakeholders aligned on the motivations and business outcomes expected?
2. **Business case:** Are all stakeholders aligned on the overall business justification?
3. **Partner support:** Are partners and other support models properly aligned for success of the migration effort?
4. **Discovery & assessment:** Has the team completed a discovery of existing inventory? Has an initial rationalization/assessment been completed?
5. **Technical skilling:** Does the team have a skills plan in place?
6. **Migration plan:** Is there a defined plan for the migration of the next 10 workloads & related assets, including clarity on people allocations?
7. **Landing zone:** Does the deployed landing zone align with the needs of the adoption plan?
8. **Migration execution:** Is the adoption team prepared to execute the technical migration effort?
9. **Governance:** Is the governance team aligned with the approach to governing the cloud environment?
10. **Management:** Is there a post-migration plan for on-going operations of any production workloads?

While working through the first 6 steps, the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) can help capture critical decisions.

## Implementation details for each actionable steps

Each of these steps pulls from the broader cloud adoption framework, allowing readers to start fast and scale efforts overtime.

### 1. Business strategy

Creation of a clear and concise business strategy for migration can remove many common migration blockers.

- Strategy: [Understand motivations](../strategy/motivations.md): The first step to strategic alignment is to gain a consensus on the motivations driving the migration effort. This article outlines common motivations and themes to help capture the overall desires of the various stakeholders across business and IT.
- Strategy: [Business Outcomes](../strategy/business-outcomes/index.md): Once motivations are aligned, its possible to capture the desired business outcomes. This provides clear metrics by which the overall transformation can be measured.

**Effort Details**

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Minimum Output:** Record motivations and outcomes in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)
- **Minimum time to complete:** 3 hours
    - Motivation discussion: 1 hour
    - Outcomes discussion: 1 hour
    - Document & review: 1 hour
    - Timeline risks: Stakeholder alignment may require multiple iterations

### 2. Business case

Making the business case for migration will likely be an iterative conversation amongst stakeholders. In this first pass at building the business case, evaluate the initial, high-level return from a potential cloud migration.

- Strategy: [Building a cloud migration business case](../strategy/cloud-migration-business-case.md) is a good starting point for developing a migration business case, with clarity on formulas and tools that can aid in business justification.

**Effort Details**

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md)
- **Minimum Output:** Record business justification in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)
- **Minimum time to complete:** 2 hours
    - Calculate business justification: 1 hour
    - Document & review: 1 hour
    - Timeline risks: If required, inventory discovery and initial assessment can slow justification.

### 3. Partner support

Support from partners, support, Microsoft services, and various Microsoft programs may be available throughout the migration process.

- Migrate: [Understand Partnership options](../migrate/migration-considerations/assess/partnership-options.md) provides a number of ways to find the right level of partnership and support.

**Effort Details**

- **Accountable team:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Responsible/Supporting teams:** [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Minimum Output:** Execute Terms and Conditions (or other contractual agreements required before engaging a supporting partners)
- **Minimum time to complete:** 4 hours
    - Evaluate partnership options: 1 hour
    - Evaluate partner capabilities & ability to support: 2 hours
    - Review & execute contractual agreements: 1 hours
    - Timeline risks: Legal reviews and evaluation of multiple partners/options

### 4. Discovery & assessment

Discovery and assessment provides a deeper level of technical alignment to create an actionable plan to deliver on the strategy. During this step, the business case is validated using data about the current state environment, quantitative analysis of that data, and a deep qualitative assessment of the highest priority workloads.

- Plan: [Inventory existing systems](../digital-estate/inventory.md): Understanding the current state from a programatic, data-driven approach is the first step. Discover and gather data to enable all assessment activities.
- Plan: [Incremental rationalization](../digital-estate/rationalize.md#incremental-rationalization): Streamline assessment efforts to focus on a qualitative analysis of all assets (possibly even to support the business case). Then add a deep qualitative analysis for the first 10 workloads to be migrated.

**Effort Details**

- **Accountable team:** [Cloud Adoption Team](../organize/cloud-adoption.md)
- **Responsible/Supporting teams:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Minimum Output:**
    - Raw data on existing inventory
    - Quantitative analysis on existing inventory to refine the business justification
    - Qualitative analysis of the first 10 workloads
    - Update business justification in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)
- **Minimum time to complete:** 2-4 weeks
    - Inventory discovery: 1-2 weeks
    - Quantitative analysis: 2-4 hours
    - Qualitative analysis: 1-2 days per workload
    - Document & review: 1 hour
    - Timeline risks: Complexity of the existing environment (including access complexity) can significantly slow discovery. Type/depth of analysis can also slow the process.

### 5. Technical skilling

Existing employees can play a hands-on role in the migration effort. But, additional skills will likely be required.

- Plan: [Build a skills readiness plan](/plan/adapt-roles-skills-processes.md): A quick evaluation of the required skills and existing skills amongst the team will aid in understanding what skilling requirements need to be addressed. 

**Effort Details**

- **Accountable team:** [Cloud Adoption Team](../organize/cloud-adoption.md)
- **Responsible/Supporting teams:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Minimum Output:** 
    - Add skills readiness plan to the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx)
- **Minimum time to complete:** 2 hours + 1-2 hours per team member
    - Self-assess skills: 1 hour per team member
    - Team review & validation: 1 hour per team member
    - Establish skilling plans & investments: 2 hours

### 6. Migration plan

The cloud adoption plan template provides an accelerated approach to develop a project backlog. That backlog can then be modified to reflect discovery results, rationalization, skilling, and partner contracting.

- Plan: [Cloud adoption plan template](../plan/template.md): Deploy the basic template
- Plan: [Workload alignment](../plan/workloads.md): Define workloads in the backlog
- Plan: [Effort alignment](../plan/assets.md): Align assets and workloads in the backlog to clearly define effort for prioritized workloads
- Plan: [People & time alignment](../plan/iteration-paths.md): Establish iteration, velocity (people's time), and releases of migrated workloads

**Effort Details**

- **Accountable team:** [Cloud Adoption Team](../organize/cloud-adoption.md)
- **Responsible/Supporting teams:** [Cloud Strategy Team](../organize/cloud-strategy.md)
- **Minimum Output:** 
    - Deploy a backlog template
    - Update the template to reflect first 10 workloads to be migrated
    - Update people/velocity to estimate release timing
- **Minimum time to complete:** 2 hours + 1-2 hours per workload
    - Deploy template & setup editing spreadsheets: 1 hour
    - Update workloads and assets: 1 hours per workload
    - Timeline risk: Familiarity with Azure DevOps can slow the deployment process. Complexity & data available for each workload can impact timelines

### 7. Landing zone

All migrated assets are deployed within a landing zone. Initially, the landing zone will be simplistic to support smaller workloads. Over time, it will scale to address more complex workloads.

- Ready: [Choose a landing zone](../ready/landing-zone/first-landing-zone.md): Use this article to find the right approach to deploying a landing zone based on your adoption pattern. Then deploy that standardized code base.
- Ready: [Expand your landing zone](../ready/considerations/index.md): Regardless of the starting point, identify gaps in the deployed landing zone to add required components for resource organization, security, governance, compliance, operations, etc...

**Effort Details**

- **Accountable team:** [Cloud Adoption Team](../organize/cloud-adoption.md)
- **Responsible/Supporting teams:** [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Minimum Output:** 
    - Deploy a first landing zone for initial, low-risk migrations
    - Develop a plan to refactor with the CCoE and/or Central IT
- **Minimum time to complete:** 2 hours
    - Deploy landing zone: 1 hour
    - Develop refactoring plan: 1 hour
    - Timeline risk: Governance, operations, and security requirements of the first 10 workloads can significantly slow this process. Actual refactoring of the first landing zone & subsequent landing zones will take considerably longer, but should happen in parallel to migration efforts.

### 8. Migration execution

For the majority of customer adoption patterns, the proceeding steps prepare the broader organization and platform for the migration work in this step. If migration is simply a technical process, skipping to this step may be perfectly acceptable. Some adoption patterns call for a one-time migration, wherein all assets are moved in a single motion, if that is the case you might be able to jump to this step as well.

Migration execution is an iterative process of its own. Many people also refer to migration execution as a migration factory, because each release and each iteration is similar to running a set of workloads and assets through a conveyor belt, migrating each to the cloud.

For more information on this step, see the [overview page for the Migration methodology](../migrate/index.md).

**Effort Details**

- **Accountable team:** [Cloud Adoption Team](../organize/cloud-adoption.md)
- **Responsible/Supporting teams:** [Cloud Strategy Team](../organize/cloud-strategy.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Minimum Output:** 
    - Migrate first workload
    - Establish iterative processes (or migration factory) to continue a stream of workload releases
- **Minimum time to complete:** Variable - Estimates required
    - First workload: Generally 1 - 2 weeks to allow for learning opportunities
    - Additional workloads: 1 or more per 2 week sprint
    - Timeline risk: Compliance requirements, architectural complexity, migration scenario, change control processes & many other dependencies can impact the team's velocity.

### 9. Governance

Governance is a key factor to the long-term success of any migration effort. Speed to migration and business impact is important. But, speed without governance can be dangerous. Each organization will need to make decisions about governance, which align to their adoption patterns and governance/compliance needs.

- Govern: [Approach](../govern/index.md): This methodology outlines a process for thinking about corporate policy and processes. Then building the disciplines required to deliver on governance across the cloud enterprise adoption efforts.
- Govern: [Initial foundation](../govern/guides/complex/prescriptive-guidance.md): Similar to the landing zone article, this article will guide readers through the addition of governance to existing adoption efforts. The story-based article series follows a common set of customer stories & shows how to add governance controls in parallel to adoption needs.

**Effort Details**

- **Accountable team:** [Cloud Governance Team](../organize/cloud-governance.md)
- **Responsible/Supporting teams:** [Cloud Strategy Team](../organize/cloud-strategy.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Minimum Output:**
    - Deploy an initial governance foundation
    - Complete a governance benchmark to plan for future improvements
- **Minimum time to complete:** 4 hours
    - Understand the approach & methodology: 1 hour
    - Review the initial set of policies against adoption plans: 1 hour
    - Deploy a governance foundation: 1 hour
    - Complete the governance benchmark assessment: 1 hour
    - Timeline risks: Improve policies and governance implementation can add 1-4 weeks per discipline

### 10. Management

Operations Management is another requirement to reach migration success. Migrating to the cloud without an understanding of on-going operations is a risky decision. In parallel to migration, it is suggested that customers start planning for longer-term operations. The Manage methodology of CAF adds clarity to operations management in the cloud:

- Manage: [Management Baseline](../manage/index.md):
- Manage: [Define business commitments](../manage/considerations/business-alignment.md):
- Manage: [Expand the management baseline](../manage/best-practices.md):
- Manage: [Get specific with advanced operations](../manage/design-principles.md):

**Effort Details**

- **Accountable team:** [Cloud Operations Team](../organize/cloud-operations.md)
- **Responsible/Supporting teams:** [Cloud Strategy Team](../organize/cloud-strategy.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)
- **Minimum Output:**
    - Deploy a management baseline
    - Complete the Ops Management Workbook
    - Identify any workloads which will require an Azure Architecture Review assessment
- **Minimum time to complete:** 2-4 days
    - Deploy the Azure Server Management guide: 1-2 days
    - Complete the workbook: 1-2 days
    - Timeline risks:
        - Review the workbook: 1 hour per application owner
        - Complete the Azure Architecture Review assessment: 1 hour per application

## Common outcomes

The steps outlined in this getting started guide will help teams accelerate migration efforts, through better change management and stakeholder alignment. Following these steps may slow the process. But these steps will remove common blockers accelerating realization of business value. As you move through this guide, you may also see some of the common outcomes.

## Next Steps

Migration involves a number of supporting teams and organizations. In parallel to the core migration efforts, the following teams can use these next steps to continue to advance the maturity of supporting efforts. These parallel processes are not linear & shouldn't be viewed as blockers. Instead, each is a parallel value stream to aid in maturing the company's overall cloud readiness. The table below outlines common next steps for each team.

The Cloud Adoption Framework is a lifecycle solution. It is designed to help readers who are just beginning their journey and as well as readers who are deep into their migration. These next steps represent iterative approaches to help with various needs throughout the journey.

|Team  |Next Iteration|
|---------|---------|
|Cloud&nbsp;Migration&nbsp;Team|[Process improvements](../migrate/migration-considerations/index.md) provide insights to mature towards a migration factory with efficient on-going migration capabilities.|
|Cloud&nbsp;Strategy&nbsp;Team|[Strategy](../strategy/index.md) and [Plan](../plan/index.md) are iterative processes, which will evolve with the adoption plan. Return to those overview pages to continue to iterate on the business and technical strategies.|
|Cloud&nbsp;Platform&nbsp;Team|Revisit the [Ready](../ready/index.md) methodology to continue to advance the overall cloud platform that supports migration or other adoption efforts.|
|Cloud&nbsp;Governance&nbsp;Team|Leverage the [Govern](../govern/index.md) methodology to continue to improve governance processes, policies, and disciplines|
|Cloud&nbsp;Operations&nbsp;Team|Build on the [Manage](../manage/index.md) methodology to provide richer operations in Azure|
