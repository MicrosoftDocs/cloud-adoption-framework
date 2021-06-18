---
title: Cloud migration
description: Prepare for a successful migration to Azure using an iterative process to assess, migrate, optimize, secure, and manage workloads.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/04/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal, seo-azure-migrate
---

# Cloud migration in the Cloud Adoption Framework

Any enterprise-scale [cloud adoption plan](../plan/index.md), will include workloads that do not warrant significant investments in the creation of new business logic. Those workloads could be moved to the cloud through any number of approaches: lift and shift; lift and optimize; or modernize. Each of these approaches is considered a migration.

Watch the following video to get a quick overview of the lift and shift approach.

<!-- markdownlint-disable MD034 -->

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWDup6]

<!-- markdownlint-enable MD034 -->

The following exercises will help establish the iterative processes to assess, migrate, optimize, secure, and manage those workloads.

To prepare you for this phase of the cloud adoption lifecycle, we recommend the following:

| <span title="Icon">&nbsp;</span> | <span title="Description">&nbsp;</span> |
|--|--|
| <br> :::image type="icon" source="../_images/icons/1.png"::: | <br> [Migrate your first workload](./azure-migration-guide/index.md): Use the Azure migration guide to become familiar with the Azure native tools and approach to migration. |
| <br> :::image type="icon" source="../_images/icons/2.png"::: | <br> [Migration scenarios](./azure-best-practices/index.md): Use additional migration tools and approaches to act on other migration scenarios. |
| <br> :::image type="icon" source="../_images/icons/3.png"::: | <br> [Best practices](./azure-best-practices/index.md): Address common migration needs through the application of consistent best practices. |
| <br> :::image type="icon" source="../_images/icons/4.png"::: | <br> [Process improvements](./migration-considerations/index.md): Migration is a process heavy activity. As migration efforts scale, use these process improvements to evaluate and mature various aspects of migration. |

The Migrate methodology and the steps above build on the following assumptions:

<!-- docutune:casing "Plan, Ready, and Adopt methodologies" -->

- The methodology governing migration sprints fits within migration waves or releases, which are defined using the Plan, Ready, and Adopt methodologies. Within each migration sprint, a batch of workloads is migrated to the cloud.
- Before migrating workloads, at least one [landing zone](../ready/index.md) has been identified, configured, and deployed to meet the needs of the near-term cloud adoption plan.
- Migration is commonly associated with the terms *lift and shift* or *rehost*. This methodology and the above steps are built on the belief that no datacenter and few workloads should be migrated using a pure rehost approach. While many workloads can be rehosted, customers more often choose to modernize specific assets within each workload. During this iterative process, the balance between speed and modernization is a common discussion point.

## Migration effort

The actions required to migrate workloads generally falls into three efforts (or phases) for each workload: assess workloads, deploy workloads, and release workloads. This section of the Cloud Adoption Framework teaches readers how to maximize the return from each phase required to migrate a workload to production.

In a standard two-week long iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as SAP, may take several two-week iterations to complete all three phases of migration effort for a single workload. Experience and complexity both have a significant impact on timelines and migration velocity.

![Cloud Adoption Framework migration effort](../_images/migrate/methodology.png)

The following bullets provide an overview of the phases of this process (pictured above):

- **Assess workloads:** Assess workloads to evaluate cost, modernization, and deployment tooling. This process focuses on validating or challenging the assumptions made during earlier discovery and assessments by looking more closely at rationalization options. This is also when user patterns and dependencies are studied more closely to ensure workloads will achieve technical success after migration.

  Watch this video to get a quick overview about completing a comprehensive assessment.

  <!-- markdownlint-disable MD034 -->

  > [!VIDEO https://www.microsoft.com/videoplayer/embed/RWDpel]

  <!-- markdownlint-enable MD034 -->

- **Deploy workloads:** After workloads are assessed, the existing functionality of those workloads is replicated (or improved) in the cloud. This could involve a *lift and shift* or *rehost* to the cloud. But more commonly during this phase, many of the assets supporting these workloads will be modernized to capitalize on the benefits of the cloud.

- **Release workloads:** Once functionality is replicated to the cloud, workloads can be tested, optimized, documented, and released for ongoing operations. Critical during this process, is the effort to review the migrated workloads and hand them off to governance, operations management, and security teams for ongoing support of those workloads.

> [!NOTE]
> In some early iterations of migration effort, it is common to limit scope to a single workload. This approach maximizes skills retention and provides the team with more time to experiment and learn.

<!-- -->

> [!NOTE]
> When building a migration factory, some teams may choose to disperse each of the above phases across multiple teams and multiple sprints. This approach can improve repeatability and accelerate migration efforts.

## Migration waves and iterative change management

Migration iterations deliver technical value by migrating assets and workloads. A migration wave is the smallest collection of workloads that deliver tangible and measurable business value. Each iteration should result in a report outlining the technical efforts completed. However, business change and strategic planning typically happen at a slightly higher level. As the cloud adoption team delivers on the migration effort, the cloud strategy team focuses on planning the next 1-2 migration waves. The cloud strategy team also tracks technical progress as a learning metric to better understand the timelines for realizing business value. In that regard, migration waves are the iterative change management approach to tracking business outcomes, people, and timelines.

As outlined in the graphic in the prior section, processes within the [Plan methodology](../plan/index.md), the [Ready methodology](../ready/index.md), and to some extent the [Strategy methodology](../strategy/index.md) of the Cloud Adoption Framework provide guidance on planning and managing the migration waves. The management of those waves will prioritize and define the migration effort to be delivered by the technical teams.

## Next steps

The steps outlined above, and subsequent guidance in the Migrate methodology, can help you develop skills to improve processes within each migration sprint. The [Azure migration guide](./azure-migration-guide/index.md) is a brief series of articles that outlines the most common tools and approaches needed during your first migration wave.

> [!div class="nextstepaction"]
> [Azure migration guide](./azure-migration-guide/index.md)
