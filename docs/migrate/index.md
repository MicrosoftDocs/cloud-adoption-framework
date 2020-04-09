---
title: "Cloud migration"
description: Learn how to establish the iterative processes to assess, migrate, optimize, secure, and manage the workloads you want to migrate to the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2020
ms.topic: landing-page
ms.service: cloud-adoption-framework
ms.subservice: migrate
layout: LandingPage
---

# Cloud migration in the Cloud Adoption Framework

Any enterprise-scale [cloud adoption plan](../plan/index.md), will include workloads that do not warrant significant investments in the creation of new business logic. Those workloads could be moved to the cloud through any number of approaches: lift and shift; lift and optimize; or modernize. Each of these approaches is considered a migration. The following exercises will help establish the iterative processes to assess, migrate, optimize, secure, and manage those workloads.

## Getting started

To prepare you for this phase of the cloud adoption lifecycle, the framework recommends the following exercises:

<!-- markdownlint-disable MD033 -->
<ul class="panelContent cardsF">
    <li style="display: flex; flex-direction: column;">
        <a href="./azure-migration-guide/index.md">
            <div class="cardSize">
                <div class="cardPadding" style="padding-bottom:10px;">
                    <div class="card" style="padding-bottom:10px;">
                        <div class="cardImageOuter">
                            <div class="cardImage">
                                <img alt="" src="../_images/icons/1.png" data-linktype="external">
                            </div>
                        </div>
                        <div class="cardText" style="padding-left:0px;">
                            <h3>Migrate your first workload</h3>
                        Use the Azure migration guide to become familiar with the Azure native tools and approach to migration.
                        </div>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li style="display: flex; flex-direction: column;">
        <a href="./azure-best-practices/index.md">
            <div class="cardSize">
                <div class="cardPadding" style="padding-bottom:10px;">
                    <div class="card" style="padding-bottom:10px;">
                        <div class="cardImageOuter">
                            <div class="cardImage">
                                <img alt="" src="../_images/icons/2.png" data-linktype="external">
                            </div>
                        </div>
                        <div class="cardText" style="padding-left:0px;">
                            <h3>Migration scenarios</h3>
                            Use additional migration tools and approaches to act on other migration scenarios.
                        </div>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li style="display: flex; flex-direction: column;">
        <a href="./azure-best-practices/index.md">
            <div class="cardSize">
                <div class="cardPadding" style="padding-bottom:10px;">
                    <div class="card" style="padding-bottom:10px;">
                        <div class="cardImageOuter">
                            <div class="cardImage">
                                <img alt="" src="../_images/icons/3.png" data-linktype="external">
                            </div>
                        </div>
                        <div class="cardText" style="padding-left:0px;">
                            <h3>Best practices</h3>
                            Address common migration needs through the application of consistent best practices.
                        </div>
                    </div>
                </div>
            </div>
        </a>
    </li>
    <li style="display: flex; flex-direction: column;">
        <a href="./migration-considerations/index.md">
            <div class="cardSize">
                <div class="cardPadding" style="padding-bottom:10px;">
                    <div class="card" style="padding-bottom:10px;">
                        <div class="cardImageOuter">
                            <div class="cardImage">
                                <img alt="" src="../_images/icons/4.png" data-linktype="external">
                            </div>
                        </div>
                        <div class="cardText" style="padding-left:0px;">
                            <h3>Process improvements</h3>
                            Migration is a process heavy activity. As migration efforts scale, use these process improvements to evaluate and mature various aspects of migration.
                        </div>
                    </div>
                </div>
            </div>
        </a>
    </li>
</ul>
<!-- markdownlint-enable MD033 -->

This methodology and the steps above build on the following assumptions:

- The methodology governing migration sprints fits within migration waves or releases, which are defined using the Plan, Ready, and Adopt methodologies. Within each migration sprint, a batch of workloads is migrated to the cloud.
- Before migrating workloads, at least one [landing zone](../ready/index.md) has been identified, configured, and deployed to meet the needs of the near-term cloud adoption plan.
- Migration is commonly associated with the terms _lift and shift_ or _rehost_. This methodology and the above steps are built on the belief that no data center (and few workloads) should be migrated using a pure rehost approach. While many workloads can be rehosted, customers more often choose to modernize specific assets within each workload. During this iterative process, the balance between speed and modernization is a common discussion point.

## Migration effort

The effort required to migrate workloads generally falls into three types of effort (or phases) for each workload: Assess workloads, Deploy workloads, and Release workloads. This section of the Cloud Adoption Framework teaches readers how to maximize the return from each phase required to migrate a workload to production.

In a standard two-week long iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads, such as SAP, may take several two-week iterations to complete all three phases of migration effort for a single workload. Experience and complexity both have a significant impact on timelines and migration velocity.

![Cloud Adoption Framework migration effort](../_images/migrate/methodology.png)

The following bullets provide an overview of the phases of this process (pictured above):

- **Assess workloads:** Assess workloads to evaluate cost, modernization, and deployment tooling. This process focuses on validating or challenging the assumptions made during earlier discovery and assessments by looking more closely at rationalization options. This is also when user patterns and dependencies are studied more closely to ensure workloads will achieve technical success post migration.
- **Deploy workloads:** After workloads are assessed, the existing functionality of those workloads is replicated (or improved) in the cloud. This could involve a _lift and shift_ or _rehost_ to the cloud. But more commonly during this phase, many of the assets supporting these workloads will be modernized to capitalize on the benefits of the cloud.
- **Release workloads:** Once functionality is replicated to the cloud, workloads can be tested, optimized, documented, and released for ongoing operations. Critical during this process, is the effort to review the migrated workloads and hand them off to governance, operations management, and security teams for ongoing support of those workloads.

> [!NOTE]
> In some early iterations of migration effort, it is common to limit scope to a single workload. This approach maximizes skills retention and provides the team with more time to experiment and learn.
> [!NOTE]
> When building a migration factory, some teams may choose to disperse each of the above phases across multiple teams &/or multiple sprints. This approach can improve repeatability and accelerate migration efforts.

## Migration waves

Migration iterations will deliver technical value by migrating assets and workloads. A migration wave is the smallest collection of workloads, which deliver tangible and measurable business value. Each iteration should end in a report outlining the technical efforts completed. But, business change and strategic planning generally happens at a slightly higher level. As the cloud adoption team delivers on the migration effort, the cloud strategy team focuses on planning the next 1-2 migration waves. The cloud strategy team also tracks technical progress as a learning metric to better understand the timelines for realizing business value. In that regard, migration waves are the iterative change management approach to tracking business outcomes, people, and timelines.

As outlined in the graphic in the prior section, processes within the [Plan](../plan/index.md) methodology, the [Ready](../ready/index.md) methodology, and to some extent the [Strategy](../strategy/index.md) methodology of the Cloud Adoption Framework provide guidance on planning and managing the migration waves. The management of those waves will prioritize and define the migration effort to be delivered by the technical teams.

## Next steps

The "Getting Started" steps above, and subsequent guidance found in the Migrate methodology, will help develop skills to improve execution of the processes within each migration sprint. The [Azure migration guide](./azure-migration-guide/index.md) is a brief series of articles that outlines the most common tools and approaches needed during your first migration wave.

> [!div class="nextstepaction"]
> [Azure migration guide](./azure-migration-guide/index.md)
