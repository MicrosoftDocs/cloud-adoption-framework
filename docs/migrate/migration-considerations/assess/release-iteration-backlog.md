---
title: Iteration and release backlog
description: Use the Cloud Adoption Framework for Azure to learn how to build an iteration and release backlog to organize your tasks.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Manage change in an incremental migration effort

This article assumes that migration processes are incremental in nature, and runs parallel to the [govern process](../../../govern/index.md). The same guidance could be used to populate initial tasks, which break down the structure for traditional waterfall change management approaches.

## Release backlog

A *release backlog* is a series of assets, such as VMs, databases, files, and applications. These assets must be migrated before a workload can be used for production in the cloud. During each iteration, the cloud adoption team documents and estimates the efforts required to move each asset to the cloud.

## Iteration backlog

An *iteration backlog* is a list of detailed work that's required to migrate a specific number of assets from an existing digital estate to the cloud. The entries on this list are often stored as work items in an agile management tool such as Azure DevOps.

Before starting the first iteration, the cloud adoption team specifies an iteration duration, usually two to four weeks. The duration is important because it creates a start and finish to each set of committed activities. Maintaining consistent execution windows makes it easy to gauge velocity (pace of migration) and alignment to changing business needs.

Before each iteration, the team reviews the release backlog and estimates the effort and priorities of assets to be migrated. Next, the team commits to deliver a specific number of agreed-on migrations. Finally, when the cloud adoption team agrees on this delivery plan, the list of activities becomes the *current iteration backlog*.

During each iteration, team members work as a self-organizing team to fulfill commitments in the current iteration backlog.

## Next steps

After an iteration backlog is defined and accepted by the cloud adoption team, [change management approvals](./approve.md) can be finalized.

> [!div class="nextstepaction"]
> [Approve architecture changes prior to migration](./approve.md)
