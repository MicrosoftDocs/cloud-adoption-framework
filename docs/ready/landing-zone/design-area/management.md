---
title: Management for Azure environments
description: Learn about some design considerations and recommendations for managing your Azure environment.
author: jtracey93
ms.author: jatracey
ms.date: 12/19/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.custom: internal, UpdateFrequency.5
products: azure-monitor
---

# Design area: Management for Azure environments

This design area establishes a foundation for operations management across your Azure, hybrid, or multicloud environments. You can enhance your learning later on using the operations guidance outlined in [Manage methodology](../../../manage/index.md) of the Cloud Adoption Framework.

## Design area review

**Scope:** The goal of this exercise is to understand operations management requirements and implement those requirements consistently across all workloads in your cloud platform. The primary scope of this exercise focuses on operations tooling. You'll use operations tooling to manage the collective portfolio of workloads with a set of common tools and processes. This initial set of operations tooling is also referred to as your operations baseline.

**Out of scope:** You can use the operations baseline defined in this exercise consistently across all workloads. The operations baseline can also be expanded with other tools and processes as outlined in the [Manage methodology](../../../manage/index.md) of the Cloud Adoption Framework. Doing so helps to improve operations for specific technology platforms or individual workloads.

You can also use the operations baseline with the Azure Well-Architected Framework and Microsoft Azure Well-Architected Review to improve the operations and architecture of individual workloads you deploy within your cloud environment. However, any advanced operations, tech platform operations, or workload operations are out of scope for this exercise.

## Design area overview

For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities.

The management design area focuses on the considerations and recommendations for landing zone design decisions. Also, the [Manage methodology](../../../manage/index.md) of the Cloud Adoption Framework provides further in-depth guidance for holistic management processes and tools.

### Operations baseline

Use the following operations items to evaluate which operations management tooling you need to include in your operations baseline.

| Scope                                                                          | Context                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [**Inventory & visibility**](./management-platform.md)                         | As cloud environments are implemented and scaled out, management controls that span the environment become increasingly important. <br> No matter the services that are running on top of the landing zone, the management of fundamental elements of the platform is necessary to ensure stable, ongoing operations. <br> These management tools should scale as the environments do. <br> They can include a mix of first-party and third-party tools, depending on your existing investments.                  |
| [**Operational Compliance**](./management-operational-compliance.md)           | Requirements for patching and managing configuration drift. <br>Requirements for automatic or centralized resource optimization and sizing. <br>Requirements for workloads that should only be optimized or resized by the assigned workload teams. <br>Processes for ensuring completion of their regular optimization efforts.                                                                                                                                                                                   |
| [**Protect & Recover**](./management-business-continuity-disaster-recovery.md) | Your organization needs to design suitable, platform-level capabilities that application workloads can depend on for a basic level of business continuity and disaster recovery.  <br>  Specifically, these application workloads have requirements related to [recovery time objective (RTO) and recovery point objective (RPO)](../../../manage/protect.md#define-reliability-requirements). Be sure that you capture disaster recovery (DR) requirements to identify and address needs for advanced operations. |
