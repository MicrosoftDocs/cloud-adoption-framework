---
title: Prepare for agile change management complexity
description: Use the Cloud Adoption Framework for Azure to prepare cloud architects for a conversation with project management to explain the concept of change management.
author: martinekuan
ms.author: martinek
ms.date: 09/27/2022
ms.reviewer: ssumner
ms.topic: conceptual
s.custom: internal
---

# Prepare for technical complexity: Agile change management

This article outlines a high-level approach to agile change management in a migration effort. We'll discuss the role of migration, release, and iteration backlogs in organizing and executing your migration.

![Diagram that shows the relationship between the migration, release, and iteration backlogs used during the migration process](../../../_images/migrate/backlog-relationships.png)

*Diagram 1: The relationship between the migration, release, and iteration backlogs.*

The three different backlogs map to different levels of planning in a Scrum framework:

- Migration backlog = *Epic*
- Release backlog = *User Stories*
- Iteration backlog = *Tasks*

These backlogs will keep your migration organized and enable you to deliver value faster.

<!-- docutune:ignore INVEST -->

## Defining workloads

Migrations should focus on moving workloads. As a result, your backlog items will be workloads. A workload is a unit of application functionality. It can be a challenge to define a workload. So, we created a simple assessment guide, using the well-known INVEST acronym, to help you define your workloads.

Workloads should be:

- **Independent:** A workload shouldn't have any inaccessible dependencies. All dependencies should be accessible and included in the migration effort before you can migrate a workload. Multi-wave migrations must account for the interim hybrid connectivity.
- **Negotiable:** Your understanding of the workload will likely change during the discovery process. You might find dependencies in discovery that you must include in the workload. Examples include prerelease features, the order of migrated elements in a multi-wave migration, or a single-release migration.
- **Valuable:** Value in a workload is measured by the ability to provide users with access to a production workload.
- **Estimable:** Dependencies, assets, migration time, performance, and cloud costs should all be estimable and should be estimated prior to migration.
- **Small:** The goal is to package workloads in a single iteration. When a single iteration isn't practical, you should plan iterations to minimize the time required to move a workload to production.
- **Testable:** There should always be a defined means of confirming the completion of the migration of a workload.

The workloads you define will be your migration backlog.

## Migration backlog

A migration backlog allows you to track your top-level portfolio of workloads that can be migrated. Prior to migration, the cloud strategy team and the cloud adoption team should review your current [digital estate](../../../digital-estate/index.md) and agree to a prioritized list of workloads to be migrated. This list forms your migration backlog.

Initially, workloads on the migration backlog are unlikely to meet the INVEST criteria outlined in the earlier section. Instead, they'll serve as a logical grouping of assets from an initial inventory as a placeholder for future work. Those placeholders might not be technically correct but are the basis for coordination with the business.

In any migration backlog, the change management team should strive to obtain the following information for any workload in the plan. At a minimum, this data should be available for any workloads prioritized for migration in the next two or three releases.

### Migration backlog data points

- **Business impact.** Understand the effect of missing the expected timeline or reducing functionality during freeze windows.
- **Relative business priority.** A ranked list of workloads based on business priorities.
- **Business owner.** Document the one individual responsible for making business decisions about this workload.
- **Technical owner.** Document the one individual responsible for technical decisions related to this workload.
- **Expected timelines.** When the migration is scheduled for completion.
- **Workload freezes.** Time frames in which the workload should be ineligible for change.
- **Workload name.**
- **Initial inventory.** Any assets supplying functionality to the workload, including VMs, IT appliances, data, applications, deployment pipelines, and others. This information is likely to be inaccurate.

## Release backlog

A migration *release* deploys one or more workloads into production. A release generally covers several iterations or technical work. However, it's a single iteration of business change. After one or more workloads have been prepared for production promotion, a release occurs.

The decision to package a release is made when the workloads migrated represent enough business value to justify injecting change into a business environment. Releases are executed with a [business change plan](../optimize/business-change-plan.md) after [business testing](../optimize/business-test.md) has been completed. The cloud strategy team manages planning and overseeing the execution of a release to ensure that the desired business change is released.

A *release backlog* is the future state plan that defines a coming release. Release backlog is the pivot point between business change management (*migration backlog*) and technical change management (*iteration backlog*). A release backlog consists of a list of workloads from the migration backlog that align to a specific subset of business outcome realization. Definition and submission of a release backlog to the cloud adoption team serve as a trigger for deeper analysis and migration planning. After the cloud adoption team has verified the technical details associated with a release, it can choose to commit to the release and set up a release timeline based on current knowledge.

Given the degree of analysis needed for a release, the cloud strategy team should keep a running list of the next two to four releases. The team should also try to confirm as much of the following information as possible before defining and submitting a release. A disciplined cloud strategy team capable of supporting the next four releases can significantly increase the consistency and accuracy of release timeline estimates.

### Release backlog data points

A partnership between the cloud strategy team and the cloud adoption team collaborates to add the following data points for any workloads in the release backlog:

- **Refined inventory.** Confirm required assets to be migrated. You often confirm assets through log or monitoring data at the host, network, or OS level to ensure a correct understanding of network and hardware dependencies of each asset under standard load.
- **Usage patterns.** An understanding of the patterns of usage from end users. These patterns often include an analysis of end-user geographical distribution, network routes, seasonal usage spikes, daily/hourly usage spikes, and end-user composition (interval versus external).
- **Performance expectations.** Analysis of available log data capturing throughput, page views, network routes, and other performance data needed to replicate the end-user experience.
- **Dependencies.** Analysis of network traffic and application usage patterns to find any other workload dependencies. You should factor these dependencies into sequencing and environmental readiness. Don't include a workload in a release until one of the following criteria can be met:
  - All dependent workloads have been migrated.
  - Network and security configurations have been implemented to allow the workload to access all dependencies in alignment with existing performance expectations.
  - For multi-wave migrations, hybrid connectivity can create temporary performance degradations. You should discuss this possibility with your business leads and create a plan of action before migrating.
- **Desired migration approach.** At the migration backlog level, the assumed migration effort is the only consideration used in analysis. For instance, if the business outcome is an exit from an existing datacenter, all migrations are assumed to be a rehost scenario in the migration backlog. In the release backlog, the cloud strategy team and the cloud adoption team should evaluate the long-term value of extra features, modernization, and continued development investments. It might be better to adopt a more modern approach.
- **Business testing criteria.** After a workload is added to the migration backlog, testing criteria should be mutually agreed on. In some cases, testing criteria can be limited to a performance test with a defined power user group. However, for statistical validation, an automated performance test is desired and should be included. The existing instance of the application often has no automated testing capabilities. It isn't uncommon for the cloud architects to work with power users to create a baseline load test against the existing solution to establish a benchmark to be used during migration.

### Release backlog cadence

In mature migrations, releases come in a regular cadence. The velocity of the cloud adoption team often normalizes, producing a release every two to four iterations (approximately every one or two months). Creating artificial release cadences can negatively affect the cloud adoption team's ability to achieve consistent throughput.

To stabilize the business, the cloud strategy team should set up a monthly release process with the business to keep regular dialogue. They should also set the expectation that it will be several months before a regular release cadence can be predicted.

## Iteration backlog

An *iteration* backlog is a consistent, time-bound unit of work. Iterations are called sprints in Agile Scrum. An iteration is a two to four-week period of time. Time-bound iterations force consistent intervals of effort completion and allow for more frequent adjustment to plans based on new learnings. During an iteration, there are usually tasks for the assessment, migration, and optimization of workloads defined in the migration backlog. You should track and manage those units of work in the same project-management tool as the migration and release backlog. It will help with consistency across each level of change management.

Within an iteration, the cloud adoption team would work to deliver the committed amount of technical work, driving toward the migration of a defined workload. When complete, these efforts can be tested by validating production readiness of a workload staged in the cloud.

### Large or complex iteration structures

For a small migration with a self-contained migration team, a single iteration could include all four phases of a migration for a single workload (*Assess*, *Migrate*, *Optimize*, and *Secure and manage*). More commonly, each of these processes shared by multiple teams in distinct work items across iterations. Depending on the effort type, effort scale, and roles, iterations can have different types. We'll discuss two types:

- **Migration factory.** Large-scale migrations sometimes need an approach that resembles a factory in the execution model. In this model, you assign various teams to execute a specific migration process (or subset of the process). After completion, the output of one team's iteration populates the backlog for the next team. A factory model is good for large-scale "lift-and-shift" migrations. It can effectively migrate workloads with thousands of virtual machines moving through phases of assessment, architecture, remediation, and migration. However, you must have a streamlined change management and approval processes to track the handoffs.
- **Multi-wave migrations.** Another approach that works well for large migrations is a wave model. In this model, division of labor isn't nearly as clear. A team dedicates itself to the migration process execution of individual workloads. However, the nature of each iteration changes. In one iteration, the team might complete assessment and architecture work. In another, it might complete the migration work. In yet another, the focus could be on optimization and production release. This approach allows a core team to stay aligned to workloads, seeing them through the process in its entirety. But the diversity of skills and context switching could reduce the potential velocity of the team, slowing the migration effort. Additionally, roadblocks during approval cycles can cause significant delays. It's important to maintain options in the release backlog to keep the team moving during blocked periods, with this model. It's also important to cross-train team members and to ensure that skills align with the theme of each iteration.

### Iteration backlog data points

The outcome of an iteration captures and documents the changes made to a workload, thus closing the change-management loop. When completed, you should document the following points. Throughout the execution of an iteration, this documentation should be completed in tandem with the technical work items.

- **Assets deployed.** Any assets deployed to the cloud to host the workload.
- **Remediation.** Any changes to the assets to prepare for cloud migration.
- **Configuration.** Chosen configuration of any assets deployed, including any references to configuration scripts.
- **Deployment model.** Approach used to deploy the asset to the cloud, including references to any deployment scripts or tools.
- **Architecture.** Documentation of the architecture deployed to the cloud.
- **Performance metrics.** Output of automated testing or business testing performed to confirm performance at the time of deployment.
- **Unique requirements or configuration.** Any unique aspects of the deployment, configuration, or technical requirements necessary to run the workload.
- **Operational approval.** Approval from the application owner and the IT operations staff responsible for managing the workload after deployment confirming operational readiness.
- **Architecture approval.** Approval from the workload owner and the cloud adoption team to confirm any architecture changes needed to host each asset.

## Next steps

After change management approaches have been set up, it's time to address the final prerequisite, [migration backlog review](./migration-backlog-review.md)

> [!div class="nextstepaction"]
> [Migration backlog review](./migration-backlog-review.md)
