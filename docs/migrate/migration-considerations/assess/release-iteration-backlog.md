---
title: Iteration and release backlog
description: Use the Cloud Adoption Framework for Azure to learn how to build an iteration and release backlog to organize your tasks.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/17/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Manage change in an incremental migration effort

This article assumes that migration processes are incremental in nature, and runs parallel to the [govern process](../../../govern/index.md). However, the same guidance could be used to populate initial tasks in a work breakdown structure for traditional waterfall change management approaches.

## Release backlog

A *release backlog* consists of a series of assets (VMs, databases, files, and applications, among others) that must be migrated before a workload can be released for production usage in the cloud. During each iteration, the cloud adoption team documents and estimates the efforts required to move each asset to the cloud.

## Iteration backlog

An *iteration backlog* is a list of the detailed work required to migrate a specific number of assets from the existing digital estate to the cloud. The entries on this list are often stored as work items in an agile management tool such as Azure DevOps.

Prior to starting the first iteration, the cloud adoption team specifies a two to four week iteration duration. The iteration duration is important because it allows each set of committed activities to start and finish. Maintaining consistent execution windows makes it easy to gauge velocity (pace of migration) and alignment to changing business needs.

Prior to each iteration, the team reviews the release backlog and estimates the effort and priorities of assets to be migrated. Next, the team commits to deliver a specific number of agreed-on migrations. Finally, when the cloud adoption team makes an agreement, the list of activities becomes the *current iteration backlog*.

During each iteration, team members work as a self-organizing team to fulfill commitments in the current iteration backlog.

## Next steps

After an iteration backlog is defined and accepted by the cloud adoption team, [change management approvals](./approve.md) can be finalized.

> [!div class="nextstepaction"]
> [Approve architecture changes prior to migration](./approve.md)
