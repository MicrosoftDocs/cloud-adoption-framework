---
title: "Get started: Accelerate migration"
description: Recommended steps for stakeholder alignment, migration planning, deploying a landing zone, and migrating your first 10 workloads.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/29/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Get started: Accelerate migration

Proper alignment of business and IT stakeholders helps to overcome migration roadblocks and accelerate migration efforts. This article provides recommended steps for:

- Stakeholder alignment
- Migration planning
- Deploying a landing zone
- Migrating your first 10 workloads

It also helps you implement proper governance and management processes.

Use this guide to streamline the processes and materials required for aligning an overall migration effort. The guide uses the methodologies of the Cloud Adoption Framework that are highlighted in this illustration.

![Get started with migration in Azure](../_images/get-started/migration-map.png)

If your migration scenario is atypical, you can get a personalized assessment of your organization's migration readiness by using the [strategic migration and readiness tool (SMART) assessment](/assessments/?id=strategic-migration-assessment). Use it to identify the guidance that best aligns to your current needs.

## Get started

The technical effort and process required to migrate workloads is relatively straightforward. It's important to complete the migration process efficiently. Strategic migration readiness has an even bigger impact on the timelines and successful completion of the overall migration.

To accelerate adoption, you must take steps to support the cloud adoption team during migration. This guide outlines these iterative tasks to help customers start on the right path toward any cloud migration. To show the importance of the supporting steps, migration is listed as step 10 in this article. In practice, the cloud adoption team is likely to begin their first pilot migration in parallel with steps 4 or 5.

## Step 1: Align stakeholders

To avoid common migration blockers, create a clear and concise business strategy for migration. Stakeholder alignment on motivations and expected business outcomes shapes decisions made by the cloud adoption team.

- [Motivations](../strategy/motivations.md): The first step to strategic alignment is to gain agreement on the motivations that drive the migration effort. Start by understanding and categorizing motivations and common themes from various stakeholders across business and IT.
- [Business outcomes](../strategy/business-outcomes/index.md): After motivations are aligned, it's possible to capture the desired business outcomes. This information provides clear metrics you can use to measure the overall transformation.

**Deliverables:**

- Use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record motivations and desired business outcomes.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud adoption team <li> Cloud center of excellence or central IT team |

## Step 2: Align partner support

Partners, Microsoft Services, or various Microsoft programs are available to support you throughout the migration process.

- [Understand partnership options](../migrate/migration-considerations/assess/partnership-options.md) to find the right level of partnership and support.

**Deliverables:**

- Establish terms and conditions or other contractual agreements before you engage supporting partners.
- Identify approved partners in the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud adoption team <li> Cloud center of excellence or central IT team |

## Step 3: Gather data and analyze assets and workloads

Use discovery and assessment to improve technical alignment and create an action plan for executing your strategy. During this step, validate the business case using data about the current state environment. Then perform quantitative analysis and a deep qualitative assessment of the highest priority workloads.

- [Inventory existing systems](../digital-estate/inventory.md): Use a programmatic data-driven approach to understand the current state. Discover and gather data to enable all assessment activities.
- [Incremental rationalization](../digital-estate/rationalize.md#incremental-rationalization): Streamline assessment efforts to focus on a qualitative analysis of all assets, possibly even to support the business case. Then add a deep qualitative analysis for the first 10 workloads to be migrated.

**Deliverables:**

- Raw data on existing inventory.
- Quantitative analysis on existing inventory to refine the business justification.
- Qualitative analysis of the first 10 workloads.
- Business justification documented in the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team |

## Step 4: Make a business case

Making the business case for migration is likely to be an iterative conversation among stakeholders. In this first pass at building the business case, evaluate the initial high-level return from a potential cloud migration. The goal of this step is to ensure that all stakeholders align around one simple question: based on the available data, is the overall adoption of the cloud a wise business decision?

- [Building a cloud migration business case](../strategy/cloud-migration-business-case.md) is a good starting point for developing a migration business case. Clarity on formulas and tools can aid in business justification.

**Deliverables:**

- Use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record business justification.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud strategy team | <li> Cloud adoption team |

## Step 5: Create a migration plan

A cloud adoption plan provides an accelerated approach to developing a project backlog. The backlog can then be modified to reflect discovery results, rationalization, needed skills, and partner contracting.

- [Cloud adoption plan](../plan/template.md): Define your cloud adoption plan using the basic template.
- [Workload alignment](../plan/workloads.md): Define workloads in the backlog.
- [Effort alignment](../plan/assets.md): Align assets and workloads in the backlog to clearly define effort for prioritized workloads.
- [People and time alignment](../plan/iteration-paths.md): Establish iteration, velocity (people's time), and releases for the migrated workloads.

**Deliverables:**

- Deploy the backlog template.
- Update the template to reflect the first 10 workloads to be migrated.
- Update people and velocity to estimate release timing.
- Timeline risks:
  - Lack of familiarity with Azure DevOps can slow the deployment process.
  - Complexity and data available for each workload can also affect timelines.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team |

## Step 6: Build a skills readiness plan

Existing employees can play a hands-on role in the migration effort, but additional skills might be required. In this step, find ways to develop those skills or use partners to add to those skills.

- [Build a skills-readiness plan](../plan/adapt-roles-skills-processes.md). Quickly evaluate your existing skills to identify what other skills the team should develop.

**Deliverables:**

- Add a skills-readiness plan to the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx).

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team |

## Step 7: Deploy and align a landing zone

All migrated assets are deployed to a landing zone. The landing zone start simple to support smaller workloads, then scales to address more complex workloads over time.

- [Choose a landing zone](../ready/landing-zone/index.md): Find the right approach to deploying a landing zone based on your adoption pattern. Then deploy that standardized code base.
- [Expand your landing zone](../ready/considerations/index.md): Whatever your starting point, identify gaps in the deployed landing zone and add required components for resource organization, security, governance, compliance, and operations.

**Deliverables:**

- Deploy your first landing zone for deploying initial low-risk migrations.
- Develop a refactoring plan with the cloud center of excellence or the central IT team.
- Timeline risks:
  - Governance, operations, and security requirements for the first 10 workloads can slow this process.
  - Refactoring the first landing zone and subsequent landing zones takes longer, but it should happen in parallel with migration efforts.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud platform team | <li> Cloud adoption team <li> Cloud center of excellence or central IT team |

## Step 8: Migrate your first 10 workloads

The technical effort required to migrate your first 10 workloads is relatively straightforward. It's also an iterative process that you repeat as you migrate more assets. In this process, you assess your workloads, deploy your workloads, and then release them to your production environment.

![Phases of iterative migration efforts: assess, deploy, release](../_images/migrate/methodology-effort-only.png)

Cloud migration tools enable migrating all virtual machines in a datacenter in one pass or iteration. It's more common to migrate a smaller number of workloads during each iteration. Breaking up the migration into smaller increments requires more planning, but it reduces technical risks and the impact of organizational change management.

With each iteration, the cloud adoption team gets better at migrating workloads. These steps help the technical team mature their capabilities:

1. Migrate your first workload in a pure infrastructure as a service (IaaS) approach by using the tools outlined in the [Azure migration guide](../migrate/azure-migration-guide/index.md).
2. Expand tooling options to use migration and modernization by using the [migration examples](../migrate/azure-best-practices/contoso-migration-overview.md).
3. Develop your technical strategy by using broader approaches outlined in [Azure cloud migration best practices](../migrate/azure-best-practices/index.md).
4. Improve consistency, reliability, and performance through an efficient migration-factory approach as outlined in [Migration process improvements](../migrate/migration-considerations/index.md).

**Deliverables:**

Continuous improvement of the adoption team's ability to migrate workloads.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud adoption team | <li> Cloud strategy team <li> Cloud center of excellence or central IT team |

## Step 9: Hand off production workloads to cloud governance

Governance is a key factor to the long-term success of any migration effort. Speed to migration and business impact is important. But speed without governance can be dangerous. Your organization needs to make decisions about governance that align to your adoption patterns and your governance and compliance needs.

- [Governance approach](../govern/index.md): This methodology outlines a process for thinking about your corporate policy and processes. After determining your approach, you can build the disciplines required to enable governance across your enterprise cloud adoption efforts.
- [Initial governance foundation](../govern/guides/complex/prescriptive-guidance.md): Understand the disciplines needed to create a governance minimum viable product (MVP) that serves as the foundation for all adoption.
- [Governance benchmark](https://aka.ms/adopt/assess/govern): Identify gaps in your organization's current state of governance. Get a personalized benchmark report and curated guidance on how to get started.

**Deliverables:**

- Deploy an initial governance foundation.
- Complete a governance benchmark to plan for future improvements.
- Timeline risk:
  - Improvement of policies and governance implementation can add one to four weeks per discipline.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud governance team | <li> Cloud strategy team <li> Cloud center of excellence or central IT team |

## Step 10: Hand off production workloads to cloud operations

Operations management is another requirement to reach migration success. Migrating individual workloads to the cloud without an understanding of ongoing enterprise operations is a risky decision. In parallel with migration, you should start planning for longer-term operations.

- [Define business commitments](../manage/considerations/business-alignment.md)
- [Establish a management baseline](../manage/azure-management-guide/index.md)
- [Expand the management baseline](../manage/best-practices.md)
- [Advanced operations and design principles](../manage/design-principles.md)

**Deliverables:**

- Deploy a management baseline.
- Complete the operations management workbook.
- Identify any workloads that require an Microsoft Azure Well-Architected Review assessment.
- Timeline risks:
  - Review the workbook: estimate one hour per application owner.
  - Complete the Microsoft Azure Well-Architected Review assessment: estimate one hour per application.

<br>

| Accountable team | Responsible and supporting teams |
| --- | --- |
| <li> Cloud operations team | <li> Cloud strategy team <li> Cloud center of excellence or central IT team |

## Value statement

These steps help teams accelerate their migration efforts through better change management and stakeholder alignment. These steps also remove common blockers and realize business value more quickly.

## Next steps

The Cloud Adoption Framework is a lifecycle solution that helps you begin a migration journey. It also helps mature the teams that support migration efforts. The following teams can use these next steps to continue to mature their capabilities. These parallel processes aren't linear and shouldn't considered blockers. Instead, each is a parallel value stream to help improve your organization's overall cloud readiness.

| Team | Next iteration |
|--|--|
| Cloud adoption team | Use the [migration model](../migrate/migration-considerations/index.md) to learn about moving toward a migration factory that provides efficient ongoing migration capabilities. |
| Cloud strategy team | Iteratively improve the [Strategy methodology](../strategy/index.md) and the [Plan methodology](../plan/index.md) along with the adoption plan. Review these overviews and continue iterating on your business and technical strategies. |
| Cloud platform team | Revisit the [Ready methodology](../ready/index.md) to continue to advance the overall cloud platform that supports migration or other adoption efforts. |
| Cloud&nbsp;governance&nbsp;team | Use the [Govern methodology](../govern/index.md) to continue to improve governance processes, policies, and disciplines. |
| Cloud operations team | Build on the [Manage methodology](../manage/index.md) to provide richer operations in Azure. |

If your migration scenario is atypical, you can get a personalized assessment of your organization's migration readiness by using the [strategic migration and readiness tool (SMART) assessment](/assessments/?id=strategic-migration-assessment). The answers you provide help identify which guidance aligns best with your current needs.
