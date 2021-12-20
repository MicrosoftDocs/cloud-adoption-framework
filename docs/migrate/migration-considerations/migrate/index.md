---
title: Executing a migration
description: Get an overview of the articles that explain the various activities that may be involved in migrating a workload in Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/17/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Deploy workloads

After workloads have been assessed, they can be deployed to the cloud or staged for release. This series of articles explains the various activities that might be involved in the migration effort.

## Objective

The goal of a migration is to migrate a single workload to the cloud.

## Definition of done

The migration phase is complete when a workload is staged and ready for testing in the cloud. The migration phase includes all dependent assets required for the workload to function. During the optimize process, the workload is prepared for production usage.

The *definition of done* can vary depending on your testing and release processes. The next article in this series covers [deciding on a promotion model](./promotion-models.md) and can help you understand when it's best to promote a migrated workload to production.

## Accountability during migration

The cloud adoption team is accountable for the entire migration process. However, members of the cloud strategy team also have a few responsibilities.

## Responsibilities during migration

In addition to the high-level accountability, there are actions that an individual or group must be directly responsible for. The following are a few activities that require assignments to responsible parties:

- **Remediation.** Resolve any compatibility issues that prevent the workload from being migrated to the cloud.
  - As discussed in the article about [technical complexity and change management](../prerequisites/technical-complexity.md), a decision must be made in advance to determine how this activity is executed.
  - For example, is remediation completed by the cloud adoption team during the same sprint as the actual migration effort?
  - Also, is a wave or factory model used to complete remediation in a separate iteration? If the answer to this basic process question can't be answered by every member of the team, it might be wise to revisit the section on [prerequisites](../prerequisites/index.md).
- **Replication.** Create a copy of each asset in the cloud to synchronize VMs, data, and applications with resources in the cloud.
  - Depending on the promotion model, different tools might be required to complete this activity.
- **Staging.** After all assets for a workload are replicated and verified, the workload can be staged for business testing and execution of a business change plan.

## Next steps

With a general understanding of the migration process, you're ready to [decide on a promotion model](./promotion-models.md).

> [!div class="nextstepaction"]
> [Decide on a promotion model](./promotion-models.md)
