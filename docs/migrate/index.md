---
title: Cloud migration
description: Prepare for a successful migration to Azure using an iterative process to assess, migrate, optimize, secure, and manage workloads.
author: Zimmergren
ms.author: tozimmergren
ms.date: 12/01/2023
ms.topic: conceptual
---

# Cloud migration in the Cloud Adoption Framework

This section of the Cloud Adoption Framework explains the principles behind its migration model. Wherever possible, this content attempts to maintain a vendor-neutral position. It guides you through the processes and activities that can be applied to any cloud migration, whatever your chosen cloud vendor.

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

  <br/>

  > [!VIDEO https://www.microsoft.com/videoplayer/embed/RWDpel]

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

## Understand migration motivations

Cloud migration is a portfolio management effort, cleverly disguised as a technical implementation. During the migration process, you'll decide to move some assets, invest in others, and retire obsolete or unused assets. Some assets will be optimized, refactored, or replaced entirely as part of this process. Each of these decisions should align with the motivations behind your cloud migration. The most successful migrations also go a step further and align these decisions with the business outcomes you want.

This model requires your organization to have already completed business readiness processes for cloud adoption. Make sure you've reviewed the [Plan methodology](../plan/index.md) and the [Ready methodology](../ready/index.md) of the Cloud Adoption Framework. These methodologies determine the business drivers or other justification for a cloud migration. They also supply required organizational planning or training needed before executing a migration process at scale.

> [!NOTE]
> While business planning is important, a growth mindset is equally important. In parallel with broader business planning efforts by the cloud strategy team, it's suggested that the cloud adoption team begin migrating a first workload as a precursor to wider scale migration efforts. This initial migration will allow the team to gain practical experience with the business and technical issues involved in a migration.

## Envision an end state

It's important to establish a rough vision of your end state before starting your migration efforts. The following diagram shows an on-premises starting point of infrastructure, applications, and data. These elements define your *digital estate*. During the migration process, those assets are transitioned using a migration strategy described in the [five Rs of rationalization]( ../digital-estate/5-rs-of-rationalization.md).

:::image type="content" source="../_images/migrate/migration-options.png" alt-text="Diagram that shows cloud migration options.":::

Migration and modernization of workloads range from *rehost* migrations, to *refactoring*, to *rearchitecting*. Rehost migrations, or *lift and shift* migrations, use infrastructure as a service (IaaS) capabilities that don't require code and application changes. Refactoring migrations only require minimal changes. Rearchitecting migrations modify and extend code and application functionality to take advantage of cloud technologies.

Cloud-native strategies and platform as a service (PaaS) strategies *rebuild* on-premises workloads using Azure platform offerings and managed services. Your workloads might have equivalent fully managed software as a service (SaaS) cloud-based offerings. These workloads can often be fully *replaced* by these services as part of the migration process.

> [!NOTE]
> During the public preview of the Cloud Adoption Framework, this section of the framework emphasizes a rehost migration strategy. Although PaaS and SaaS solutions are discussed as alternatives when appropriate, the migration of virtual machine-based workloads using IaaS capabilities is the primary focus.
>
> Other sections and future iterations of this content will expand on other approaches. For a high-level discussion on expanding the scope of your migration to include more complicated migration strategies, see the article balancing the portfolio.

## Incremental migration

The Cloud Adoption Framework migration model is based on an incremental cloud transformation process. It assumes that your organization will start with an initial, limited-scope, cloud migration effort. We commonly refer to this migration effort as the first workload. This effort will expand iteratively to include more workloads as your operations teams refine and improve your migration processes.

Cloud migrations tools like [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) can migrate entire datacenters consisting of thousands of virtual machines (VMs). However, the business and existing IT operations often can't handle such a high pace of change. Many organizations break up a migration effort into multiple iterations. They move one workload, or one collection of workloads, per iteration.

The principles behind this incremental model are based on the execution of certain processes and prerequisites. These processes are referenced in the following infographic.

![An infographic that shows the Cloud Adoption Framework migration model.](../_images/migrate/methodology.png)

The consistent application of these principles represents an end goal for your cloud migration processes. They shouldn't be viewed as a required starting point. As your migration efforts mature, refer to the guidance in this section to help define the best process to support your organizational needs.

## Next steps

The steps outlined above and further methodology guidance can help you improve processes within each migration sprint. The [Azure migration guide](./azure-migration-guide/index.md) includes articles that outline the most common tools and approaches needed during your first migration wave.

> [!div class="nextstepaction"]
> [Azure migration guide](./azure-migration-guide/index.md)