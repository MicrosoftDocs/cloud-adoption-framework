---
title: "Getting started: Build new products and services"
description: Learn about the innovate methodology as an approach to guide the development of new cloud products and services.
author: JanetCThomas
ms.author: janet
ms.date: 04/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Getting started: Accelerate innovation in the cloud

Creating new products and services in the cloud requires a different approach than migration. The innovate methodology in the Cloud Adoption Framework establishes an approach that guides the development of new products and services.

## Get started

This guide utilizes the sections of the Cloud Adoption Framework that are highlighted in the following illustration. While innovation is less predictable than a standard migration, it still fits within the context of the broader cloud adoption plan.  This guide will help enterprises provide the support needed to innovate and structure required to create a balanced portfolio throughout cloud adoption.

![Getting Started with accelerating innovation in the cloud](../_images/getting-started/innovation-getting-started.png)

## Step 1: Document the business strategy

To avoid common migration blockers, create a clear and concise business strategy for migration. Stakeholder alignment on motivations and expected business outcomes will shape decisions made by the cloud adoption team.

Involved teams

- Accountable team: [Cloud Strategy Team](../organize/cloud-strategy.md)
- Responsible/Supporting teams: [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

Deliverable

- Use the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) to record motivations and desired business outcomes.

Guidance to support deliverable completion

- [Motivations](../strategy/motivations.md): The first step to strategic alignment is to gain consensus on the motivations driving the migration effort. Start by understanding and categorizing motivations and common themes from various stakeholders across business and IT.
- [Business Outcomes](../strategy/business-outcomes/index.md): Once motivations are aligned, it's possible to capture the desired business outcomes. This provides clear metrics by which the overall transformation can be measured.
- [Balance the portfolio](../strategy/balance-the-portfolio.md): Innovation isn't the right adoption path for every workload. This approach to adoption is more relevant to new custom-built applications or workloads which **require** re-architecture or full re-builds. When motivations heavily favor innovation of all workloads, it is important to evaluate the portfolio to ensure those investments can produce the desired ROI. Modernization of specific resources & smaller scaler re-build efforts can be innovative, but may be better served by following the [migration getting started guide](./migrate.md).

## Step 2: Evaluate the business justification

In this first pass at building the business case, evaluate the initial, high-level return from a potential cloud adoption effort. The goal of this step is to ensure that all stakeholders align around one simple question, "Based on the available date, is the overall adoption of the cloud a wise business decision?". Building on that question, the team can better align on how this innovation project helps meet the end users' projected needs within the goal of adopting the cloud.

Involved teams

- Accountable team: [Cloud Strategy Team](../organize/cloud-strategy.md)
- Responsible/Supporting teams: [Cloud Adoption Team](../organize/cloud-adoption.md)

Deliverable

- Use the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) to record business justification.

Guidance to support deliverable completion

- [Business justification](../strategy/cloud-migration-business-case): Before evaluating each opportunity to innovate in the cloud, a high level business justification should be completed to establish stakeholder alignment regarding the overall adoption plan.
- [Business value consensus](../innovate/business-value.md): Quantifying the value of an innovation can be difficult early in the process. The exercise in this article can aid in evaluating alignment on the business value of a specific innovation effort.

## Step 3: Gather data and analyze assets and workloads

In most enterprises, innovation can be accelerated through the use of existing assets (applications, vms, and data). When planning for innovation, it is important to understand how & when those assets will be migrated to the cloud.

Involved teams

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible/Supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md)

Deliverable

- Raw data on existing inventory (Applications, VMs, and Data)
- If the proposed innovation has dependencies on existing inventory, complete the following deliverables
    - Quantitative analysis on any supporting inventory required to support the planned innovation
    - Qualitative analysis of any supporting workloads required to deliver the innovation
- Calculate cost of new inventory required to support the innovation effort
- Update business justification in the [Strategy and Planning Template](https://archcenter.blob.core.windows.net/cdn/fusion/readiness/Microsoft-Cloud-Adoption-Framework-Strategy-and-Plan-Template.docx) with refined calculations.

Guidance to support deliverable completion

Discovery and assessment provide a deeper level of technical alignment to create an actionable plan to migrate any dependent workloads required by the planned innovation. This is very common when companies have existing data sources, centralized applications, or required service layers which would be needed to deliver the innovation within the context of the rest of the enterprise. When there are dependent systems the following articles can guide the discovery and assessment.

- [Inventory existing systems](../digital-estate/inventory.md): Understanding the current state from a programmatic, data-driven approach is the first step. Discover and gather data to enable all assessment activities.
- [Incremental rationalization](../digital-estate/rationalize.md#incremental-rationalization): Streamline assessment efforts to focus on a qualitative analysis of all assets (possibly even to support the business case). Then add a deep qualitative analysis for the first 10 workloads to be migrated.

## Step 4: Plan for migration of dependent assets

When new innovation depends on existing workloads or assets, the cloud adoption plan template provides an accelerated approach to developing a project backlog. The backlog can then be modified to reflect discovery results, rationalization, skilling, and partner contracting.

Involved teams

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible/Supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md)

Deliverable

- Deploy the backlog template
- Update the template to reflect first 10 workloads to be migrated
- Update people and velocity to estimate release timing
- Timeline risk: Familiarity with Azure DevOps can slow the deployment process. Complexity and data available for each workload can also impact timelines.

Guidance to support deliverable completion

- [Cloud adoption plan template](../plan/template.md): Deploy the basic template
- [Workload alignment](../plan/workloads.md): Define workloads in the backlog
- [Effort alignment](../plan/assets.md): Align assets and workloads in the backlog to clearly define effort for prioritized workloads
- [People & time alignment](../plan/iteration-paths.md): Establish iteration, velocity (people's time), and releases for the migrated workloads

## Step 5: Align governance requirements to your adoption plan

Discussing planned innovations with the governance team can avoid a number of blockers before they arise. At times innovative new solutions may require practices that are discouraged in sound governance practices. Some of those required features may even be blocked through automated governance enforcement tooling.

Involved teams

- Accountable team: [Cloud Governance Team](../organize/cloud-governance.md) and [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible/Supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

Deliverable

- Create transparency and understanding between innovation needs and governance constraints
- When necessary, update policies and processes to reflect any changes or exceptions to existing governance constraints

Guidance to support deliverable completion

The following two links will help the adoption team understand the approach taken by the cloud governance team.

- [Governance approach](../govern/index.md): This methodology outlines a process for thinking about corporate policy and processes. Then building the disciplines required to deliver on governance across your cloud enterprise efforts.
- [Define corporate policy](../govern/corporate-policy.md): Identify and mitigate business risks.

## Step 6: Define operations needs and business commitments

Define the plan for long-term operational responsibilities regarding the planned innovation. Will the established management baseline be sufficient to meet your operations needs? If not, evaluate options for funding advanced operations specific to the technology supporting this innovation.

Involved teams

- Accountable team: [Cloud Operations Team](../organize/cloud-operations.md) and [Cloud Adoption Team](../organize/cloud-adoption.md) 
- Responsible/Supporting teams: [Cloud Strategy Team](../organize/cloud-strategy.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

Deliverable

- Complete the [Azure Architecture Review](https://docs.microsoft.com/assessments/?id=azure-architecture-review) to assess various architecture and operation decisions.
- Adjust the [Operations Management workbook](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/manage/opsmanagementworkbook.xlsx) to reflect any required advanced operations.

Guidance to support deliverable completion

- [Expand the management baseline](../manage/best-practices.md): This section of the Cloud Adoption Framework guides you through various transitions into operational management in the cloud.
- [Get specific with advanced operations](../manage/design-principles.md): Discover ways to go beyond your management baseline.
- If advanced operations are required to support your operations needs, evaluate the [business commitments](/manage/considerations/business-alignment.md) to determine operational responsibilities for both teams.

## Step 7: Deploy an aligned a landing zone

All assets hosted in the cloud live within a landing zone. That landing zone may have explicit governance, security, and operations requirements. Or it may be a brand new subscription, with no support from other teams. In either scenario, its important to start with a landing zone which aligns to governance and operation requirements from the beginning. Starting with an approved landing zone will help the team discover policy violations early in development, instead of when the solution is released to production. This early discovery will help remove blockers & will provide the adoption team and governance team with the time required to implement change.

Involved teams

- Accountable team: [Cloud Platform Team](../organize/cloud-platform.md) and [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible/Supporting teams: [Cloud Adoption Team](../organize/cloud-adoption.md) and [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

Deliverable

- Deploy a first landing zone for initial, low-risk experimentation during early innovation
- Develop a plan to refactor with the CCoE or Central IT to ensure governance, security, and operational alignment
- Timeline risk: Governance, operations, and security requirements for the first 10 workloads can significantly slow this process. Actual refactoring of the first landing zone and subsequent landing zones will take considerably longer, but should happen in parallel to migration efforts.

Guidance to support deliverable completion

- [Choose a landing zone](../ready/landing-zone/first-landing-zone.md): Use this article to find the right approach to deploying a landing zone based on your adoption pattern. Then deploy that standardized code base.
- [Expand your landing zone](../ready/considerations/index.md): Regardless of the starting point, identify gaps in the deployed landing zone to add required components for resource organization, security, governance, compliance, operations, and so on.

## Step 7: Innovate in the cloud

The Innovation methodology provides guidance on the tools and product management approaches most commonly used to innovate in the cloud. The following steps will help you get started with this approach.

Involved teams

- Accountable team: [Cloud Adoption Team](../organize/cloud-adoption.md)
- Responsible/Supporting teams: [Cloud center of excellence](../organize/cloud-center-of-excellence.md)/[Central IT](../organize/central-it.md)

Deliverable

- Technology-based solutions which enrich your customers lives and drives value for the business
- Processes and tools to iterate on those solutions faster & add more value by leveraging the cloud
    - Iterative development approaches
    - Custom-built applications
    - Technology-based experiences
    - Integration of physical products and technology using IoT
    - Ambient intelligence: Integration of nonintrusive technology into an environment
    - Cognitive Services: Big Data, AI, Machine Learning, and predictive solutions

Guidance to support deliverable completion

- [Business value consensus](../innovate/business-value.md): If more than 3 months have passed since the last business value consensus, or if one has never been completed, start here.
- [Azure Innovate guide](../innovate/innovation-guide/index.md): Use the Azure innovation guide to accelerate the deployment of innovative solutions, by understanding the tools and processes that can help you create a minimum viable product (MVP).
- [Innovation best practices](../innovate/best-practices/index.md): Learn how to combine Azure services to create a toolchain for digital invention.
- [Feedback loops](../innovate/considerations/adoption.md): Develop improved feedback loops to quickly deliver impactful innovations to your customers.

## Value statement

The steps outlined in this getting started guide can help you and your teams create innovative solutions in the cloud that create business value, are governed appropriately, and are well architected.

## Next steps

The Cloud Adoption Framework is a lifecycle solution. It can help you begin an innovation journey, but can also help you advance the maturity of the teams that support the innovation efforts. The following teams can use these next steps to continue to advance the maturity of their efforts. These parallel processes are not linear and shouldn't be viewed as blockers. Instead, each is a parallel value stream to help mature your company's overall cloud readiness.

|Team  |Next Iteration|
|---------|---------|
|Cloud&nbsp;Adoption&nbsp;Team|[Process improvements](../innovate/considerations//index.md) provides insight about approaches to deliver on innovations that impact customers and drive recurring adoption.|
|Cloud&nbsp;Strategy&nbsp;Team|[Strategy](../strategy/index.md) and [Plan](../plan/index.md) are iterative processes that evolve with the adoption plan. Return to these overview pages and continue to iterate on your business and technical strategies.|
|Cloud&nbsp;Platform&nbsp;Team|Revisit the [Ready](../ready/index.md) methodology to continue to advance the overall cloud platform that supports migration or other adoption efforts.|
|Cloud&nbsp;Governance&nbsp;Team|Leverage the [Govern](../govern/index.md) methodology to continue to improve governance processes, policies, and disciplines.|
|Cloud&nbsp;Operations&nbsp;Team|Build on the [Manage](../manage/index.md) methodology to provide richer operations in Azure|
