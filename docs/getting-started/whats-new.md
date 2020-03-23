--- 
title: What's new 
description: Learn about recent updates to the Microsoft Cloud Adoption Framework for Azure. 
author: JanetCThomas 
ms.author: janet 
ms.date: 03/09/2020 
ms.topic: overview 
ms.service: cloud-adoption-framework 
ms.subservice: overview
---

# What's new in the Microsoft Cloud Adoption Framework for Azure

Here's a list of recent changes made to the Cloud Adoption Framework.

This framework is built in collaboration with customers, partners, and internal Microsoft teams. New and updated content is released when it becomes available. These releases allow you to test, validate, and refine the guidance along with us. We encourage you to partner with us to build the Cloud Adoption Framework for Azure.

## March 20, 2020

We've added prescriptive guidance that includes the tools, programs, and content categorized by persona to drive successful deployment of applications on Kubernetes, from proof of concept to production, followed by scaling and optimization.

### Kubernetes

| Article                                                                                     | Description                                                                                                                                                                           |
|---------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Application development and deployment](../innovate/kubernetes/application-development.md) | **New article** Provides checklists, resources, and best practices for planning application development, configuring DevOps pipelines, and implementing site reliability engineering for Kubernetes. |
| [Cluster design and operations](../innovate/kubernetes/cluster-design-operations.md) | **New article** Provides checklists, resources, and best practices for cluster configuration, network design, future-proof scalability, business continuity, and disaster recovery for Kubernetes. |
| [Cluster and application security](../innovate/kubernetes/cluster-application-security.md) | **New article** Provides checklists, resources, and best practices for Kubernetes security planning, production, and scaling. |

## March 2, 2020

In response to feedback about continuity in the migration approach through multiple sections of the Cloud Adoption Framework, including Strategy, Plan, Ready, and Migrate, we've made the following updates. These updates are designed to make it easier for you to understand planning and adoption refinements as you continue a migration journey.

### Strategy updates

| Article                                                                       | Description                                                                                                                                    |
|-------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| [Balance the portfolio](../strategy/balance-the-portfolio.md)                 | Moved this article to appear earlier in the Strategy methodology. This gives you visibility into the thought process earlier in the lifecycle. |
| [Balancing&nbsp;competing&nbsp;priorities](../strategy/balance-competing-priorities.md) | **New article**: Outlines the balance of priorities across methodologies to help inform your strategy.                                         |

### Plan updates

| Article                                                             | Description                                                                                                                                                                           |
|---------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Assessment&nbsp;best&nbsp;practice](../plan/contoso-migration-assessment.md) | Moved this article to the new "Best Practices" section of the Plan methodology. This gives you visibility into the practice of assessing local environments earlier in the lifecycle. |

### Ready updates

| Article                                                                   | Description                                                                                                              |
|---------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| [What&nbsp;is&nbsp;a&nbsp;landing&nbsp;zone?](../ready/landing-zone/index.md)                 | **New article**: Defines the term landing zone.                                                                          |
| [First landing zone](../ready/landing-zone/first-landing-zone.md)         | **New article**: Expands on the comparison of various landing zones.                                                     |
| [Migrate landing zone](../ready/landing-zone/migrate-landing-zone.md)     | Separated the definition of the Cloud Adoption Framework blueprint from the selection of the first landing zone.         |
| [Terraform landing zone](../ready/landing-zone/terraform-landing-zone.md) | Moved to the new "Landing Zone" section of the Ready methodology, to elevate Terraform in the landing zone conversation. |

### Migration updates

| Article                                                                                          | Description                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Overview](../migrate/azure-migration-guide/index.md)                                            | Updated with a clearer description of the guide and fewer steps.                                                                                                        |
| [Assess](../migrate/azure-migration-guide/assess.md)                                             | Added a "Challenging Assumptions" section to demonstrate how this level of assessment works with the incremental assessment approach mentioned in the Plan methodology. |
| [Classification during assess processes](../migrate/migration-considerations/assess/classify.md) | **New article**: Outlines the importance of classifying every asset and workload prior to migration.                                                                    |
| [Migrate](../migrate/azure-migration-guide/migrate.md)                                           | Added a reference to UnifyCloud in the third-party tool options, in response to feedback at tier 1 conferences.                                                         |
| [Test,&nbsp;optimize,&nbsp;and&nbsp;promote](../migrate/azure-migration-guide/optimize-and-transform.md)        | Aligned the title of this article with other process improvement suggestions.                                                                                           |
| [Assess overview](../migrate/migration-considerations/assess/index.md)                           | Updated to illustrate that the assessment in this phase focuses on assessing the technical fit of a specific workload and related assets.                               |
| [Planning checklist](../migrate/migration-considerations/prerequisites/planning-checklist.md)    | Updated to clarify the importance of operations alignment during planning for migration efforts to ensure a well-managed workload following migration.                  |
