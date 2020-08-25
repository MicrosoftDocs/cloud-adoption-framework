---
title: What's new
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure.
author: JanetCThomas
ms.author: janet
ms.date: 07/21/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

<!-- docsTest:ignore "internal Microsoft teams" OneMigrate -->
<!-- cSpell:ignore MSPs Teradata Netezza Exadata mlops -->
<!-- markdownlint-disable MD024 -->

# What's new in the Microsoft Cloud Adoption Framework for Azure

Here's a list of recent changes made to the Cloud Adoption Framework.

This framework is built in collaboration with customers, partners, and internal Microsoft teams. New and updated content is released when it becomes available. These releases allow you to test, validate, and refine the guidance along with us. We encourage you to partner with us to build the Cloud Adoption Framework for Azure.

## July 17, 2020

This release adds a number of new scenarios to make cloud adoption more actionable.

### Migration scenarios

The new [migration scenarios overview page](../scenarios/index.md) builds on the CAF Migrate methodology to demonstrate how Azure delivers on the "#OneMigrate" promise. It provides approaches to migrating multiple first and third-party scenarios to Azure. This includes three new migration scenarios:

| Article | Description |
|---|---|
| [Windows Virtual Desktop](../scenarios/wvd/index.md) | This scenario enables productivity boosts and accelerates the migration of various workloads to support the end-user experience. |
| [Azure Stack](../scenarios/azure-stack/index.md) | Learn about deploying Azure in your datacenter using Azure Stack Hub. |

### Analytics in the Cloud Adoption Framework

Analytics solutions are now included in the Microsoft Cloud Adoption Framework. These new topics highlight best practices for enabling analytics solutions during your cloud adoption journey.

| Article | Description |
|---|---|
| [Analytics solution for Teradata, Netezza, Exadata](../migrate/azure-best-practices/analytics/analytics-solutions-overview.md) | Learn about migrating legacy on-premises environments including Teradata, Netezza, and Exadata to modern analytics solutions. |
| [High availability for Azure Synapse](../migrate/azure-best-practices/analytics/azure-synapse.md) | Learn about one of the key benefits of a modern cloud-based infrastructure, built-in high availability and disaster recovery. |
| [Schema migration data definition languages (DDL)](../migrate/azure-best-practices/analytics/schema-migration-ddl.md) | Learn about the database objects and associated processes when preparing to migrate existing data. |

### AI in the Cloud Adoption Framework

AI solutions and best practices are now integrated into the Microsoft Cloud Adoption Framework. These AI solutions can help accelerate innovation with predictions about customer's needs, automate business processes, discover information, find new ways to engage with customers, and deliver better experiences during your cloud adoption journey.

| Article | Description |
|---|---|
| [Responsible AI](../strategy/responsible-ai.md) | Learn about the AI principles you should consider when implementing AI solutions and learn how to establish a responsible AI strategy. |
| [Azure innovation guide: Innovate with AI](../innovate/innovation-guide/predict.md) | Learn about how you can innovate with AI and find the best solution based on your implementation needs. |
| [AI in the Cloud Adoption Framework](../innovate/ai/index.md) | Review a prescriptive framework that includes the tools, programs, and content (best practices, configuration templates, and architecture guidance) to simplify adoption of AI and cloud-native practices at scale. |
| [MLOps with Azure Machine Learning](../manage/mlops-machine-learning.md) | Learn about Machine Learning operations (MLOps) best practices. |
| [Innovate with AI](../innovate/best-practices/predict.md) | Learn about AI solutions (Machine Learning, AI applications and agents, knowledge mining) and best practices that can accelerate digital invention. |

## June 15, 2020

Proper configuration of the cloud environment is often the first and most common technical blocker during cloud adoption. This release focuses heavily on guidance that accelerates deployment of cloud environments. To overcome this common blocker, the Cloud Adoption Framework for Azure introduces **Azure landing zones**.

| Article | Description |
|---|---|
| [Azure landing zones](../ready/landing-zone/index.md) | Azure landing zones create a common set of design areas and implementation options to accelerate environment creation aligned to the cloud adoption plan and cloud operating model. This new article defines Azure landing zones more clearly. |
| [Azure landing zones: Design areas](../ready/landing-zone/design-areas.md) | All Azure landing zones share a common set of 8 design areas. Before deploying any of the Azure landing zones, customers should consider each of these design to make critical decisions. |
| [Azure landing zones: Implementation options](../ready/landing-zone/implementation-options.md) | Choose the best Azure landing zone implementation option, depending on your cloud adoption plan and cloud operating model. |

The existing CAF blueprint definitions and CAF Terraform modules provide a starting point for Azure landing zone implementation. However, some customers need a richer implementation option that can meet the demands of enterprise-scale cloud adoption plans. This release adds **CAF enterprise-scale** to the Azure landing zone implementation options to fill that need. The following lists a few of the articles to get you started with the CAF enterprise-scale architecture and reference implementations.

| Article | Description |
|---|---|
| [Enterprise-scale overview](../ready/enterprise-scale/index.md) | Overview to enterprise-scale |
| [Implement CAF enterprise-scale landing zones](../ready/enterprise-scale/implementation.md) | Rapid implementation options and GitHub examples |
| [Enterprise-scale architecture](../ready/enterprise-scale/architecture.md) | Understand the architecture behind enterprise-scale |
| [Enterprise-scale design principles](../ready/enterprise-scale/design-principles.md) | Understand the architectural design principles that guide decisions during implementation to evaluate whether this approach fits your cloud operating model |
| [Enterprise-scale design guideline](../ready/enterprise-scale/design-guidelines.md) | Evaluate the enterprise-scale guidelines for fulfilling the common design areas of Azure landing zones |
| [Implementation guidelines](../ready/enterprise-scale/implementation-guidelines.md) | Review the activities required for an enterprise-scale implementation before deployment |

Partners are an important aspect of successful cloud adoption. Throughout the Cloud Adoption Framework guidance, we have added references to show the important role that partners play and how customers can better engage partners. For a list of validated CAF partners, see the [CAF-aligned partner offers](https://aka.ms/adopt/partneroffers), [Azure expert managed service providers (MSPs)](https://www.microsoft.com/azure/partners/azureexpertmsp?filters=all), or [advanced specialist partners](https://www.microsoft.com/azure/partners/advspec).

## May 15, 2020

Based on feedback, we've created new content to get you started using the Cloud Adoption Framework. The new getting started guides help you navigate the framework based on what you want to accomplish. We've also create a new landing page to make it easier to find the guidance, tools, learn modules and programs that support a successful cloud adoption journey.

| Article | Description |
|---|---|
| [Cloud Adoption Framework for Azure](../index.yml) | The Cloud Adoption Framework landing page has been redesigned to make it easier to find the guidance, tools, learn modules and programs that support a successful cloud adoption journey. |
| [Get started with the Cloud Adoption Framework](./index.md) | Choose a getting started guide that's aligned with your cloud adoption goals. These common scenarios provide a roadmap through the Microsoft Cloud Adoption Framework for Azure. |
| [Understand and document foundational alignment decisions](./cloud-concepts.md) | Learn about the initial decisions that every team involved in cloud adoption should understand. |
| [Understand and align the portfolio hierarchy](../reference/fundamental-concepts/hosting-hierarchy.md) | Learn how a portfolio hierarchy shows how your workloads and supporting services all fit together. |
| [How do Azure products support the portfolio hierarchy?](../reference/fundamental-concepts/hierarchy-azure-tools.md) | Learn about the Azure tools and solutions that support your portfolio hierarchy. |
| [Manage organizational alignment](../organize/index.md) | Establish well-staffed organizational structures that an effective operating model for the cloud. |

## April 14, 2020

We've brought all the cloud adoption tools and templates together in one place to make them easier to find.

| Article | Description |
|----------|-------------|
| [Tools and templates](../reference/tools-templates.md) | Find the tools, templates, and assessments that can help you accelerate your cloud adoption journey. |

## April 4, 2020

Continued iteration of refinement to the Migrate methodology and the Ready methodology, to more tightly align them with feedback from Microsoft customers, partners, and internal programs.

### Migrate updates

| Article                                                                                                                 | Description                                                                                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Migrate methodology](../migrate/index.md)                       | These changes streamline the phases of the migration effort (assess workloads, deploy workloads, and release workloads). The changes also remove the details regarding the migration backlog. Removing those details and referencing plan, ready, and Adopt methodologies instead creates flexibility for various different cloud adoption programs to better align with the methodology. |
| Updated table of contents | The table of contents for the Azure migration guide and process improvements have been updated to reflect the changes to the methodology. |

### Ready updates

| Article                                                                                                                 | Description                                                                                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Refactor landing zones](../ready/landing-zone/refactor.md)                       | **New article:** Drawing from Ready methodology workshops, this article demonstrates the theory of starting with an initial template, using decision trees and refactoring to expand the landing zone, and moving toward a future state of enterprise readiness. |
| [Expand your landing zone](../ready/considerations/index.md)                       | **New article:** Builds on the parallel iterations section of the refactoring article to show how various types of landing zone expansions would embed shared principles into the supporting platform. The original content for this overview has been moved to the [basic landing zone considerations](../ready/considerations/basic-considerations.md) node in the table of contents. |
| [Test-driven development (TDD) for landing zones](../ready/considerations/test-driven-development.md)                       | **New article:** The refactoring approach is much improved through the adoption of a test-driven development cycle to guide landing zone development and refactoring. |
| [Landing zone TDD in Azure](../ready/considerations/azure-test-driven-development.md)                       | **New article:** Azure governance tools provide a rich platform for TDD cycles or red/green tests. |
| [Improve landing zone security](../ready/considerations/landing-zone-security.md)                       | **New article:** Overview of the best practices in this section, related back to the TDD cycle. |
| [Improve landing zone operations](../ready/considerations/landing-zone-operations.md)                       | **New article:** List of best practices in the Manage methodology, with a transition to that modular approach to improving operations, reliability, and performance. |
| [Improve landing zone governance](../ready/considerations/landing-zone-governance.md)                       | **New article:** List of best practices related to Govern methodology, with a transition to that modular approach to improving governance, cost management, and scale. |
| [Start with enterprise scale](../ready/enterprise-scale/index.md)                       | **New article:** Demonstrate an approach that shows the differences in the process, when a customer starts with CAF enterprise-scale landing zone templates. This article helps customers understand qualifiers that would support this decision. |
| Table of contents update                       | The table of contents was updated to reflect the new articles. |

## March 27, 2020

We've added guidance about the initial subscriptions you should create when you adopt Azure.

### Ready updates

| Article                                                                                                                 | Description                                                                                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Create your initial Azure subscriptions](../ready/azure-best-practices/initial-subscriptions.md)                       | **New article:** Create your initial production and nonproduction subscriptions, and decide whether to create sandbox subscriptions, as well as a subscription to contain shared services. |
| [Create additional subscriptions to scale your Azure environment](../ready/azure-best-practices/scale-subscriptions.md) | Learn about reasons to create additional subscriptions, moving resources between subscriptions, and tips for creating new subscriptions.                                                   |
| [Organize and manage multiple Azure subscriptions](../ready/azure-best-practices/organize-subscriptions.md)             | Create a management group hierarchy to help organize, manage, and govern your Azure subscriptions.                                                                                         |

## March 20, 2020

We've added prescriptive guidance that includes the tools, programs, and content categorized by persona to drive successful deployment of applications on Kubernetes, from proof of concept to production, followed by scaling and optimization.

### Kubernetes

| Article                                                                                     | Description                                                                                                                                                                           |
|---------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Application development and deployment](../innovate/kubernetes/application-development.md) | **New article:** Provides checklists, resources, and best practices for planning application development, configuring CI/CD pipelines, and implementing site reliability engineering for Kubernetes. |
| [Cluster design and operations](../innovate/kubernetes/cluster-design-operations.md) | **New article:** Provides checklists, resources, and best practices for cluster configuration, network design, future-proof scalability, business continuity, and disaster recovery for Kubernetes. |
| [Cluster and application security](../innovate/kubernetes/cluster-application-security.md) | **New article:** Provides checklists, resources, and best practices for Kubernetes security planning, production, and scaling. |

## March 2, 2020

<!-- docsTest:ignore "Strategy, Plan, Ready, and Migrate" -->

In response to feedback about continuity in the migration approach through multiple sections of the Cloud Adoption Framework, including strategy, plan, ready, and migrate, we've made the following updates. These updates are designed to make it easier for you to understand planning and adoption refinements as you continue a migration journey.

### Strategy updates

| Article                                                                       | Description                                                                                                                                    |
|-------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [Balance the portfolio](../strategy/balance-the-portfolio.md)                 | Moved this article to appear earlier in the Strategy methodology. This gives you visibility into the thought process earlier in the lifecycle. |
| [Balancing&nbsp;competing&nbsp;priorities](../strategy/balance-competing-priorities.md) | **New article:** Outlines the balance of priorities across methodologies to help inform your strategy.                                         |

### Plan updates

| Article                                                                       | Description                                                                                                                                                                           |
|-------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Assessment&nbsp;best&nbsp;practice](../plan/contoso-migration-assessment.md) | Moved this article to the new "best practices" section of the Plan methodology. This gives you visibility into the practice of assessing local environments earlier in the lifecycle. |

### Ready updates

| Article                                                                   | Description                                                                                                              |
|---------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| [What&nbsp;is&nbsp;a&nbsp;landing&nbsp;zone?](../ready/landing-zone/index.md)                 | **New article:** Defines the term landing zone.                                                      |
| First landing zone         | **New article:** Expands on the comparison of various landing zones.                                                     |
| [CAF Migration landing zone](../ready/landing-zone/migrate-landing-zone.md) | Separated the blueprint definition from the selection of the first landing zone.         |
| [CAF Terraform modules](../ready/landing-zone/terraform-landing-zone.md) | Moved to the new "landing zone" section of the Ready methodology, to elevate Terraform in the landing zone conversation. |

### Migration updates

| Article                                                                                          | Description                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Overview](../migrate/azure-migration-guide/index.md)                                            | Updated with a clearer description of the guide and fewer steps.                                                                                                        |
| [Assess](../migrate/azure-migration-guide/assess.md)                                             | Added a "challenging assumptions" section to demonstrate how this level of assessment works with the incremental assessment approach mentioned in the Plan methodology. |
| [Classification during assess processes](../migrate/migration-considerations/assess/classify.md) | **New article:** Outlines the importance of classifying every asset and workload prior to migration.                                                                    |
| [Migrate](../migrate/azure-migration-guide/migrate.md)                                           | Added a reference to UnifyCloud in the third-party tool options, in response to feedback at tier 1 conferences.                                                         |
| [Test, &nbsp;optimize, &nbsp;and&nbsp;promote](../migrate/azure-migration-guide/optimize-and-transform.md)        | Aligned the title of this article with other process improvement suggestions.                                                                                           |
| [Assess overview](../migrate/migration-considerations/assess/index.md)                           | Updated to illustrate that the assessment in this phase focuses on assessing the technical fit of a specific workload and related assets.                               |
| [Planning checklist](../migrate/migration-considerations/prerequisites/planning-checklist.md)    | Updated to clarify the importance of operations alignment during planning for migration efforts to ensure a well-managed workload following migration.                  |

<!-- docsTest:ignoreNextStep -->
