---
title: Prepare for cloud migration
description: Understand the prerequisites that help you prepare for migration to the cloud, and help you avoid common reasons for migration failures.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/15/2024
ms.topic: conceptual
ms.custom: internal
---

# Prepare for cloud migration

Prior to starting a new migration, it's important to prepare your technical and business environments, both which are crucial to succeed with migration projects.

You **technical environment** is typically your cloud provider platform, and your **business environment** is typically your business culture, context, and objectives for driving the migration, including the required mindset shift and ensuring cultural readiness.

## Objective

The objective of the preparation discipline is to ensure business, culture, and technical readiness prior to beginning an iterative migration plan.

## Review business drivers

Before beginning any cloud migration, review the [Plan methodology](../../plan/index.md) and the [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework to ensure your organization is prepared for cloud adoption and migration processes. In particular, review the business requirements and expected outcomes driving the migration:

- [Why are we moving to the cloud?](../../strategy/motivations.md)

## Definition of done

The preparation discipline is typically completed when the following are true:

- **Business readiness:** TBD.
- **Culture readiness:** Roles, responsibilities, expectations, workload owners informed, etc.
- **Technical readiness:** Your landing zone, or allocated hosting space in the cloud, meets the minimum requirements to host the first migrated workload.

## Accountability and responsibility

Two teams are **accountable** for readiness when completing prerequisites:

- **Cloud strategy team:** This team is responsible for identifying and prioritizing the first two or three workloads to serve as migration candidates.
- **Cloud adoption team:** This team is responsible for validating readiness of the technical environment and the feasibility of migrating the proposed workloads.

A single member of each team should be identified as accountable for each of the three definitions of done statements in the prior section.

In addition to the high-level accountability, there are actions that an individual or group needs to be directly **responsible** for. The following are a few such responsibilities that affect these activities:

- **Business prioritization.** Make business decisions regarding the workloads to be migrated and general timing constraints. For more information, see [Cloud migration business motivations](../../strategy/motivations.md).
- **Change management readiness.** Establish and communicate the plan for tracking technical change during migration.
- **Business user alignment.** Establish a plan for readying the business user community for migration execution.
- **Digital estate inventory and analysis.** Execution of the tools required to inventory and analyze the digital estate. See the Cloud Adoption Framework discussion of the [digital estate](../../digital-estate/index.md) for more information.
- **Cloud readiness.** Evaluate the target deployment environment to ensure that it complies with requirements of the first few workload candidates. See the [Azure setup guide](../../ready/azure-setup-guide/index.md) for more information.

The remaining articles in this series help with the execution of each.

## Next steps

Understand how to prepare your landing zone for migrations.

> [!div class="nextstepaction"]
> [Readying your landing zone](./ready-alz.md)
