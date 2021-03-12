---
title: Optimize migrated workloads
description: Use the Cloud Adoption Framework for Azure to prepare your migrated workload and assets to be promoted to production.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Release workloads

After a collection of workloads and their supporting assets have been deployed to the cloud, it must be prepared before it can be released. In this phase of the migration effort, the collection of workloads are load tested and validated with the business. They're then optimized and documented. Once the business and IT teams have reviewed and signed off on workload deployments, those workloads can be released or handed off to governance, security, and operations teams for ongoing operations.

The objective of "release workloads" is to prepare migrated workloads for promotion to production usage.

## Definition of done

The optimization process is complete when a workload has been properly configured, sized, and deployed to production.

## Accountability during optimization

The cloud adoption team is accountable for the entire optimization process. However, members of the cloud strategy team, the cloud operations team, and the cloud governance team should also be responsible for activities within this process.

## Responsibilities during optimization

In addition to the high-level accountability, there are actions that an individual or group needs to be directly responsible for. The following are a few activities that require assignments to responsible parties:

- **Business testing.** Resolve any compatibility issues that prevent the workload from completing its migration to the cloud.
  - Power users from within the business should participate heavily in testing of the migrated workload. Depending on the degree of optimization attempted, multiple testing cycles may be required.
- **Business change plan.** Development of a plan for user adoption, changes to business processes, and modification to business KPIs or learning metrics as a result of the migration effort.
- **Benchmark and optimize.** Study of the business testing and automated testing to benchmark performance. Based on usage, the cloud adoption team refines sizing of the deployed assets to balance cost and performance against expected production requirements.
- **Ready for production.** Prepare the workload and environment for the support of the workload's ongoing production usage.
- **Promote.** Redirect production traffic to the migrated and optimized workload. This activity represents the completion of a release cycle.

In addition to core activities, there are a few parallel activities that require specific assignments and execution plans:

- **Decommission.** Generally, cost savings can be realized from a migration, when the previous production assets are decommissioned and properly disposed of.
- **Retrospective.** Every release creates an opportunity for deeper learning and adoption of a growth mindset. When each release cycle is completed, the cloud adoption team should evaluate the processes used during migration to identify improvements.

## Next steps

With a general understanding of the optimization process, you're ready to begin the process by [establishing a business change plan for the candidate workload](./business-change-plan.md).

> [!div class="nextstepaction"]
> [Business change plan](./business-change-plan.md)
