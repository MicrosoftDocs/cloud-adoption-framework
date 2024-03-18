---
title: Migration release checklist
description: Use the Cloud Adoption Framework for Azure to prepare your migrated workload and assets to be promoted to production.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/22/2024
ms.topic: conceptual
---

# Migration release checklist

This phase guides you through taking your deployed workloads, and releasing them to production use. It includes not just the technical processes of executing your final migration steps, but also the communication to the business, final change approvals, cleaning up resources, and learning from the migration.

## Executing the migration

By this phase, you have your resources deployed into Azure, either as new resources with replicated data and properly configured state, or as a replicated server through a migration tool. From a technical operations, all that remains is initiating any final migration tasks and sending traffic over to the new location.

However, there is more that is needed to make sure you have a successful migration. Clear communication with the business and support teams is critical, as is finalizing activities after migration, including a proper retrospective.

Failure to communicate, test, or successfully migrate resources can create outages and business disruptions. A failure to decommission retired assets or optimize workloads can create a failure to achieve the business outcomes as a migration. As a result, it is important to finish the migration strong.

## Checklist

The table below gives an overview of the activities documented in this phase, along with the roles responsible for execution.

|Activity|Description|Responsible roles|
|---|---|---|
|[Change communication](./change-communication.md)|Contains guidance and examples for how to communicate the upcoming change to the business and IT.|<li>Project Manager.<br><li>Organizational Change Manager.|
|[Business testing](./business-test.md)|Contains guidance on how to conduct business testing to ensure that the functionality and usability of the workload remains the same after migrating to the cloud.|<li>Project Manager.<br><li>Workload Business Owner.<br><li>Workload Architect.<br><li>User Acceptance Tester.|
|[Complete migration](./complete-migration.md)|Contains guidance for how to conduct your migration release window.|<li>Migration Architect.<br><li>Migration Engineer.|
|[Post-migration cost optimization](./post-migration-cost-optimization.md)|Contains resources for optimizing workload costs after the migration.|<li>Workload Architects.<br><li>Cloud Operations Manager.<br><li>Project Manager.|
|[Conduct retrospective](./retrospective.md)|Contains guidance on how to perform retrospectives to improve the migration of future workloads.|<li>Workload Architects.<br><li>Cloud Operations Manager.|

## Next steps

With a general understanding of the optimization process, you're ready to begin communicating the changes.

> [!div class="nextstepaction"]
> [Change communication](./change-communication.md)
