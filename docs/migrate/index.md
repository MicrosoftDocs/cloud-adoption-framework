---
title: Cloud migration
description: Prepare for a successful migration to Azure using an iterative process to assess, migrate, optimize, secure, and manage workloads.
author: martinekuan
ms.author: martinek
ms.date: 01/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal, seo-azure-migrate
---

# Cloud migration in the Cloud Adoption Framework

Any enterprise-scale [cloud adoption plan](../plan/index.md) includes workloads that don't deserve significant investments in the creation of new business logic. Those workloads could be moved to the cloud through any number of approaches: lift and shift, lift and optimize, or modernize. Each approach is considered a migration.

Watch the following video to get a quick overview of the lift and shift approach.

<!-- markdownlint-disable MD034 -->

<br/>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWDup6]

<!-- markdownlint-enable MD034 -->

The following exercises help establish the iterative processes to assess, migrate, optimize, secure, and manage those workloads.

To prepare you for this phase of the cloud adoption lifecycle, we recommend the following steps:

| &nbsp; | &nbsp; |
|--|--|
| :::image type="icon" source="../_images/icons/1.png"::: | [Migrate your first workload](./azure-migration-guide/index.md): Use the Azure migration guide to become familiar with the Azure native tools and approach to migration. |
| :::image type="icon" source="../_images/icons/2.png"::: | [Migration scenarios](./azure-best-practices/index.md): Use other migration tools and approaches to act on other migration scenarios. |
| :::image type="icon" source="../_images/icons/3.png"::: | [Best practices](./azure-best-practices/index.md): Address common migration needs through the application of consistent best practices. |
| :::image type="icon" source="../_images/icons/4.png"::: | [Process improvements](./migration-considerations/index.md): Migration is a process heavy activity. As migration efforts scale, use these process improvements to evaluate and mature various aspects of migration. |

The Migrate methodology and the steps above build on the following assumptions:

<!-- docutune:casing "Plan, Ready, and Adopt methodologies" -->
 
- The methodology that migration sprints fit within migration waves or releases. You define migration waves or releases by using the Plan, Ready, and Adopt methodologies. Within each migration sprint, a batch of workloads is migrated to the cloud.
- Before migrating workloads, you've identified, configured, and deployed at least one [landing zone](../ready/index.md) to meet the needs of the near-term cloud adoption plan.
- Migration is commonly associated with the terms *lift and shift* or *rehost*. This methodology and the steps above are built on the belief that no datacenter and few workloads should be migrated using a pure rehost approach. While you can rehost many workloads, customers more often choose to modernize specific assets within each workload. During this iterative process, the balance between speed and modernization is a common discussion point.

## Migration effort

The actions required to migrate workloads generally falls into three efforts, or phases, for each workload: assess workloads, deploy workloads, and release workloads. This section of the Cloud Adoption Framework teaches readers how to maximize the return from each phase required to migrate a workload to production.

In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as SAP, may take several two-week iterations to complete all three phases of migration effort for a single workload. Experience and complexity both have a significant impact on timelines and migration velocity.

![Diagram that shows the Cloud Adoption Framework migration effort](../_images/migrate/methodology.png)

The following bullets provide an overview of the phases of this process (pictured above):

- **Assess workloads:** Assess workloads to evaluate cost, modernization, and deployment tooling. This process focuses on validating or challenging assumptions. You make these assumptions during discovery and assessments by looking more closely at rationalization options. This process is also when user patterns and dependencies are studied more closely to ensure workloads will achieve technical success after migration.

  Watch this video to get a quick overview about completing a comprehensive assessment.

  <!-- markdownlint-disable MD034 -->
 
  <br/>

  > [!VIDEO https://www.microsoft.com/videoplayer/embed/RWDpel]

  <!-- markdownlint-enable MD034 -->

- **Deploy workloads**: After you assess workloads, the existing workload functionality is replicated or improved in the cloud. This replication could involve a *lift and shift* or *rehost* to the cloud. But, more commonly during this phase, many of the assets supporting these workloads will be modernized to capitalize on the benefits of the cloud.

- **Release workloads**: Once functionality is replicated to the cloud, workloads can be tested, optimized, documented, and released for ongoing operations. The effort to review the migrated workloads and hand them off is critical during this process. The effort is critical to governance, operations management, and security teams for ongoing workload support.

> [!NOTE]
> In some early iterations of the migration effort, it's common to limit scope to a single workload. This approach maximizes skills retention and provides the team with more time to experiment and learn.

<!-- -->

> [!NOTE]
> When building a migration factory, some teams may choose to disperse each of the above phases across multiple teams and multiple sprints. This approach can improve repeatability and accelerate migration efforts.

## Migration waves and iterative change management

Migration iterations deliver technical value by migrating assets and workloads. A migration wave is the smallest collection of workloads that deliver measurable business value. Each iteration should result in a report that outlines the technical efforts completed. However, business change and strategic planning typically happen at a slightly higher level. As the cloud adoption team delivers on the migration effort, the cloud strategy team focuses on planning the next 1-2 migration waves. The cloud strategy team also tracks technical progress as a learning metric to better understand the timelines for realizing business value. Migration waves are the iterative change management approach to tracking business outcomes, people, and timelines.

In the previous section, the graphic describes the processes within the [Plan methodology](../plan/index.md), the [Ready methodology](../ready/index.md), and to some extent the [Strategy methodology](../strategy/index.md) of the Cloud Adoption Framework. These methodologies provide guidance on planning and managing the migration waves. The management of those waves defines the migration effort to be delivered by the technical teams.

## Next steps

The steps outlined above and further methodology guidance can help you improve processes within each migration sprint. The [Azure migration guide](./azure-migration-guide/index.md) includes articles that outline the most common tools and approaches needed during your first migration wave.

> [!div class="nextstepaction"]
> [Azure migration guide](./azure-migration-guide/index.md)
