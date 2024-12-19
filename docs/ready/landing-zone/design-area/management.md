---
title: Management for Azure environments
description: Learn about some design considerations and recommendations for managing your Azure environment.
author: martinekuan
ms.author: martinek
ms.date: 08/30/2022
ms.topic: conceptual
ms.custom: internal, UpdateFrequency.5
products: azure-monitor
---

# Design area: Management for Azure environments

This design area establishes a foundation for operations management across your Azure, hybrid, or multicloud environments. You can enhance your learning later on using the operations guidance outlined in [Manage methodology](../../../manage/index.md) of the Cloud Adoption Framework.

## Design area review

**Involved roles or functions:** This design area is led by [central IT](../../../organize/central-it.md) or [cloud operations](../../../organize/cloud-operations.md), specifically the [security architects within that team](../../../secure/teams-roles.md). The [cloud platform](../../../organize/cloud-platform.md) and [cloud center of excellence](../../../organize/cloud-center-of-excellence.md) will likely be required to define and implement the technical requirements coming from this exercise. More advanced operations guardrails might also require support from [cloud governance](../../../organize/cloud-governance.md).

**Scope:** The goal of this exercise is to understand operations management requirements and implement those requirements consistently across all workloads in your cloud platform. The primary scope of this exercise focuses on operations tooling. You'll use operations tooling to manage the collective portfolio of workloads with a set of common tools and processes. This initial set of operations tooling is also referred to as your operations baseline.

**Out of scope:** You can use the operations baseline defined in this exercise consistently across all workloads. The operations baseline can also be expanded with other tools and processes as outlined in the [Manage methodology](../../../manage/index.md) of the Cloud Adoption Framework. Doing so helps to improve operations for specific technology platforms or individual workloads.

You can also use the operations baseline with the Azure Well-Architected Framework and Microsoft Azure Well-Architected Review to improve the operations and architecture of individual workloads you deploy within your cloud environment. However, any advanced operations, tech platform operations, or workload operations are out of scope for this exercise.

## Design area overview

For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities.

The management design area focuses on the considerations and recommendations for landing zone design decisions. Also, the [Manage methodology](../../../manage/index.md) of the Cloud Adoption Framework provides further in-depth guidance for holistic management processes and tools.

### Operations baseline

Use the following operations items to evaluate which operations management tooling you need to include in your operations baseline.

|Scope|Context|
|-|-|
|[**Inventory & visibility**](./management-platform.md)|As cloud environments are implemented and scaled out, management controls that span the environment become increasingly important. <br> No matter the services that are running on top of the landing zone, the management of fundamental elements of the platform is necessary to ensure stable, ongoing operations. <br> These management tools should scale as the environments do. <br> They can include a mix of first-party and third-party tools, depending on your existing investments.|
|[**Operational Compliance**](./management-operational-compliance.md)|Requirements for patching and managing configuration drift. <br>Requirements for automatic or centralize resource optimization and sizing. <br>Requirements for workloads that should only be optimized or resized by the assigned workload teams. <br>Processes for ensuring completion of their regular optimization efforts.|
|[**Protect & Recover**](./management-business-continuity-disaster-recovery.md)| Your organization needs to design suitable, platform-level capabilities that application workloads can depend on for a basic level of business continuity and disaster recovery.  <br>  Specifically, these application workloads have requirements related to [recover time objective (RTO)](../../../manage/considerations/protect.md#recovery-time-objectives-rto) and [recovery point objective (RPO)](../../../manage/considerations/protect.md#recovery-point-objectives-rpo). Be sure that you capture disaster recovery (DR) requirements to identify and address needs for advanced operations.|

### Advanced operations

Use the following advanced operations items as discussion points within your cloud architecture and operations teams. These discussions let you explore and agree on the requirements and features to include in your management design.

|Scope|Context|
|-|-|
|[**Platform management**](./management-platform.md)|When evaluating supported workloads, it's common for those workloads to have dependencies on shared platforms, like SAP, Azure Virtual Desktop, AVS, SQL, and so on. When technology platforms are used by multiple workloads, advanced operations can't be delegated to a single workload team. In these instances, centralized operations teams need a plan for the ongoing operations of those shared technology platforms. These responsibilities require extra tooling beyond the operations baseline that supports the overall cloud environment. |
|[**Workload management**](./management-workloads.md)| Workloads built on top of the landing zone platform might have specific management requirements in addition to the tools and processes put in place for the platform services. <br> These requirements should be considered in the context of the platform management to ensure that additions or exceptions are known and documented. <br> It's also important to look at these requirements in the broader context. Often, what is thought to be a requirement for a single workload can become a common pattern. Consider these situations as part of the overall platform toolset to avoid unnecessary duplication of effort. <br> For further information on considerations for workload-specific management, review the [operational excellence](/azure/architecture/framework/#operational-excellence) of the Azure Well-Architected Framework.|
