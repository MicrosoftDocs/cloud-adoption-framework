---
title: Assess workloads and validate assessment assumptions before migration
description: Use the Cloud Adoption Framework for Azure to learn how to validate assessment assumptions before beginning migration to the cloud.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/16/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Assess workloads and validate assumptions before migration

Many of your existing workloads are ideal candidates for cloud migration. Not every asset, though, is compatible with cloud platforms and not all workloads can benefit from hosting in the cloud. [Digital estate planning](../../../digital-estate/index.md) allows you to generate an overall [migration backlog](../prerequisites/technical-complexity.md#migration-backlog-aligning-business-priorities-and-timing) of potential workloads to migrate. However, this planning effort is high level. It relies on assumptions made by the cloud strategy team and doesn't dig deeply into technical considerations.

As a result, before migrating a workload to the cloud it's critical to assess the individual assets associated with that workload for their migration suitability. Your cloud adoption team should evaluate technical compatibility, required architecture, performance/sizing expectations, and dependencies. Use this information to ensure the migrated workload can be deployed to the cloud effectively.

The *assess* process is the first of four incremental activities that occur within an iteration. As discussed in the [technical complexity and change management article](../prerequisites/technical-complexity.md), a decision should be made in advance to determine how you should run this phase. In particular, will the cloud adoption team complete assessments during the same sprint as the actual migration effort? Or, will a wave or factory model be used to complete assessments in a separate iteration? If the answer to these questions can't be answered by every member of the team, revisit the [Prerequisites](../prerequisites/index.md) section.

## Goals

* Assess a migration candidate.
* Evaluate the workload, associated assets, and dependencies before migration.

## Definition of done

This process is complete when the following are known about a single migration candidate:

- The path from on-premises to cloud, including production promotion approach decision, has been defined.
- Any required approvals, changes, cost estimates, or validation processes have been completed to allow the cloud adoption team to execute the migration.

## Accountability during assessment

The cloud adoption team is accountable for the entire assessment process. However, members of the cloud strategy team have a few responsibilities, as listed in the following section.

## Responsibilities during assessment

Along with the high-level accountability, there are actions that an individual or group needs to be directly responsible for. The following are a few activities that require assignments to responsible parties:

- **Business priority.** The team understands the purpose for migrating this workload, including any intended impact to the business.
  - A member of the cloud strategy team should carry final responsibility for this activity, under the direction of the cloud adoption team.
- **Stakeholder alignment.** The team aligns expectations and priorities with internal stakeholders, identifying success criteria for the migration. What does success look like post-migration?
- **Refined rationalization.** Evaluate the initial assumptions about rationalization. Should a different [rationalization approach](../../../digital-estate/rationalize.md) be used to migrate this specific workload?
- **Modernization decisions.** Whatever the rationalization decision, should the team modernize various assets in the workload to use PaaS-based solutions?
- **Cost.** Estimate the cost of the target architecture, and adjust the overall budget.
- **Migration support.** The team decides how they will complete the technical work of the migration, including decisions about partner or Microsoft support.
- **Evaluation.** The team evaluates the workload for compatibility and dependencies.
  - Assign this activity to a subject matter expert who is familiar with the architecture and operations of the candidate workload.
- **Architect.** The team agrees on the final state architecture for the migrated workload.
- **Migration tooling.** Depending on modernization and architecture approaches, use different kinds of migration tools to automate the migration. Based on the proposed architecture, will this migration use the best [migration tools](../../../decision-guides/migrate-decision-guide/index.md)?
- **Backlog alignment.** The cloud adoption team reviews requirements and commits to the migration of the candidate workload. After commitment, the team updates the release backlog and iteration backlog.
- **Work breakdown structure or work-back schedule.** The team establishes a schedule of major milestones identifying goals for when to complete planning, implementation, and review processes.
- **Final approval.** Any necessary approvers have reviewed the plan and have signed off on the approach to migrate the asset.
  - To avoid surprises later in the process, involve at least one representative of the business in the approval process.

> [!CAUTION]
> This full list of responsibilities and actions can support large and complex migrations involving multiple roles with varying levels of responsibility, and requiring a detailed approval process. Smaller and simpler migration efforts may not require all of roles and actions described here. To determine which of these activities add value and which are unnecessary, your cloud adoption team and the cloud strategy team should use this complete process as part of your first workload migration. After the workload has been verified and tested, the team can evaluate this process and choose which actions to use moving forward.

## Next steps

With a general understanding of the assessment process, you're ready to begin the process by [classifying workloads](./classify.md).

> [!div class="nextstepaction"]
> [Classify workloads](./classify.md)
