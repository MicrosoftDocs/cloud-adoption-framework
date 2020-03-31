---
title: "Cloud migration"
description: Learn how to establish the iterative processes to assess, migrate, optimize, secure, and manage the workloads you want to migrate to the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2019
ms.topic: landing-page
ms.service: cloud-adoption-framework
ms.subservice: migrate
layout: LandingPage
---

# Cloud migration in the Cloud Adoption Framework

Any enterprise-scale [cloud adoption plan](../plan/index.md), will include workloads which do not warrant significant investments in the creation of new business logic. Those workloads could be moved to the cloud through any number of approaches: lift and shift; lift and optimize; or modernize. Each of these approaches is considered a migration. The following exercises will help establish the iterative processes to assess, migrate, optimize, secure, and manage those workloads.

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
        <a href="./expanded-scope/index.md">
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

- Before migrating workloads, at least one [landing zone](../ready/index.md) has been identified, configured, and deployed to meet the needs of the near-term cloud adoption plan.
- Migration is commonly associated with the terms _lift and shift_ or _rehost_. This methodology and the above steps are built on the belief that no data center (and very few workloads) should be migrated using a pure rehost approach. While many workloads can be rehosted, customers more often choose to modernize specific assets within each workload. During this iterative process, the balance between speed and modernization is a common discussion point.

## Iterative migration process

At its core, migration to the cloud consists of four simple phases: Assess, Migrate, Optimize, and Secure & Manage. This section of the Cloud Adoption Framework teaches readers to maximize the return from each phase of the process and align those phases with your cloud adoption plan. The following graphic illustrates those phases in an iterative approach:

![Cloud Adoption Framework migration model](../_images/migrate/methodology.png)

## Create a balanced cloud portfolio

Any balanced technology portfolio has a mixture of assets in various states. Some applications are scheduled for retirement and given minimal support. Other applications or assets are supported in a maintenance state, but the features of those solutions are stable. For newer business processes, changing market conditions will likely spur ongoing feature enhancements or modernization. When opportunities to drive new revenue streams arise, new applications or assets are introduced into the environment. At each stage of an asset's lifecycle, the impact any investment has on revenue and profit will change. The later the lifecycle stage, the less likely a new feature or modernization effort will yield a strong return on investment.

The cloud provides various adoption mechanisms, each with similar degrees of investment and return. Building cloud-native applications can significantly reduce operating expenses. Once a cloud-native application is released, development of new features and solutions can iterate faster. Modernizing an application can yield similar benefits by removing legacy constraints associated with on-premises development models. Unfortunately, these two approaches are labor-intensive and depend on the size, skill, and experience of software development teams. Often, labor is misaligned&mdash;people with the skills and talent to modernize applications would rather build new applications. In a labor-constrained market, large-scale modernization projects can suffer from an employee satisfaction and talent issue. In a balanced portfolio, this approach should be reserved for applications that would receive significant feature enhancements if they remained on-premises.

## Envision an end state

An effective journey needs a target destination. Establish a rough vision of the end state before taking the first step. This infographic outlines a starting point consisting of existing applications, data, and infrastructure, which defines the digital estate. During the migration process, each asset is transitioned via one of the options on the right.

## Migration implementation

These articles outlines two journeys, each with a similar goal&mdash;to migrate a large percentage of existing assets to Azure. However, the business outcomes and current state will significantly influence the processes required to get there. Those subtle deviations result in two radically different approaches to reaching a similar end state.

![Cloud Adoption Framework migration model](../_images/migrate/methodology.png)

To guide incremental execution during the transition to the end state, this model separates migration into two areas of focus.

**Migration preparation:** Establish a rough migration backlog based largely on the current state and desired outcomes.

- **Business outcomes:** The key business objectives driving this migration.
- **Digital estate estimate:** A rough estimate of the number and condition of workloads to be migrated.
- **Roles and responsibilities:** A clear definition of the team structure, separation of responsibilities, and access requirements.
- **Change management requirements:** The cadence, processes, and documentation required to review and approve changes.

These initial inputs shape the migration backlog. The output of the migration backlog is a prioritized list of applications to migrate to the cloud. That list shapes the execution of the cloud migration process. Over time, it will also grow to include much of the documentation needed to manage change.

**Migration process:** Each cloud migration activity is contained in one of the following processes, as it relates to the migration backlog.

- **Assess:** Evaluate an existing asset and establish a plan for migration of the asset.
- **Migrate:** Replicate the functionality of an asset in the cloud.
- **Optimize:** Balance the performance, cost, access, and operational capacity of a cloud asset.
- **Secure and manage:** Ensure a cloud asset is ready for ongoing operations.

The information gathered during development of a migration backlog determines the complexity and level of effort required within the cloud migration process during each iteration and for each release of functionality.

## Transition to the end state

The goal is a smooth and partly automated migration to the cloud. The migration process uses the tools provided by a cloud vendor to rapidly replicate and stage assets in the cloud. Once verified a simple network change reroutes users to the cloud solution. For many use cases, the technology to achieve this goal is largely available. There are example cases that demonstrate the speed at which 10,000 VMs can be replicated in Azure.

However, an incremental migration approach is still required. In most environments, the long list of VMs to be migrated must be decomposed into smaller units of work for a migration to be successful. There are many factors that limit the number of VMs that can be migrated in a given period. Outbound network speed is one of the few technical limits; most of the limits are imposed the business's ability to validate and adapt to change.

The incremental migration approach of the Cloud Adoption Framework helps build an incremental plan that reflects and documents technical and cultural limitations. The goal of this model is to maximize migration velocity while minimizing overhead from both IT and the business. Provided below are two examples of an incremental migration execution based on the migration backlog.

## Next steps

Get started by familiarizing yourself with the [Azure migration guide](./azure-migration-guide/index.md)

> [!div class="nextstepaction"]
> [Azure migration guide](./azure-migration-guide/index.md)
