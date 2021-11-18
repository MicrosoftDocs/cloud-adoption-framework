---
title: Management
description: Design area guidance for managing your Azure environment
author: DominicAllen
ms.author: doalle
ms.date: 8/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Design area: Management for Azure environments

This critical design area establishes a foundation for operations management across your Azure, hybrid, &/or multicloud environments. This foundation can later be enhanced with additional operations guidance outlined in the [Cloud Adoption Framework's Manage methodology](../../../manage/index.md).

## Design Area review

**Involved roles or functions:** This design area is led by [Central IT](../../../organize/cloud-security.md) &/or [Cloud Operations](../../../organize/cloud-operations.md). specifically the [security architects within that team](../../../organize/cloud-security-architecture.md). The [Cloud Platform](../../../organize/cloud-platform.md) and [Cloud Center of Excellence](../../../organize/cloud-center-of-excellence.md) will likely be required to define and implement the technical requirements coming from this exercise. More advanced operations guardrails may also require support from [Cloud Governance](../../../organize/cloud-governance.md)

**Scope:** The objective of this exercise is to understand operations management requirements and implement those requirements consistently across all workloads in your cloud platform. The primary scope of this exercise focus on operations tooling which will be used to manage the collective portfolio of workloads with a set of common tools and processes. This initial set of operations tooling is also referred to as your operations baseline.

**Out of scope:** The operations baseline defined in this exercise can be used consistently across all workloads. The operations baseline can also be expanded with additional tools and processes outlined in the [Cloud Adoption Framework's Manage methodology](../../../manage/index.md) to improve operations for specific technology platforms or individual workloads. The operations baseline can also be used in conjunction with the Well-Architected Framework and Well-Architected Review to improve the operations and architecture of individual workloads deployed within your cloud environment. However, any advanced operations, tech platform operations or workload operations are out of scope for this exercise.

## Design Area overview

For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities.

The management design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Manage methodology](/manage/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic management processes and tools.

### Operations Baseline

Use the following operations items to evaluate which operations management tooling will need to be included in your operations baseline.

|Scope|Context|
|-|-|
|[**Inventory & visibility**](./management-platform.md)|As cloud environments are implemented and scaled out, management controls that span the environment become increasingly important. <br> Irrespective of the services that are running on top of the landing zone, there is a need for the management of fundamental elements of the platform to ensure stable, ongoing operations. <br> These management tools should be capable of scaling as the environments do. <br> They may include a mix of first party and third party tools, depending on your existing investments.|
|[**Operational Compliance**](./management-operational-compliance.md)|Requirements for patching & managing configuration drift. Requirements for automatic or centralize resource optimization & sizing. Requirements for workloads which should only be optimized or resized by the assigned workload teams & processes for ensuring completion of their regular optimization efforts.|
|[**Protect & Recover**](./management-bcdr.md)| Your organization needs to design suitable, platform-level capabilities that application workloads can depend on for a basic level of business continuity and disaster recovery.  <br>  Specifically, these application workloads have requirements pertaining to recover time objective (RTO) and recovery point objective (RPO). Be sure that you capture disaster recovery (DR) requirements to identify and address needs for advanced operations.|

### Advanced Operations

Use the following advanced operations items as discussion points within your cloud architecture and operations teams in order to explore and agree on the requirements and features that need to be included in your management design.

|Scope|Context|
|-|-|
|[**Platform management**](./management-platform.md)|When evaluating supported workloads, it is common for those workloads to have dependencies on shared platforms, like SAP, WVD, AVS, SQL, etc... When technology platforms are used by multiple workloads, advanced operations can't be delegated to a single workload team. In these instances, centralized operations teams will need a plan for the ongoing operations of those shared technology platforms. These responsibilities will require additional tooling beyond the operations baseline which supports the overall cloud environment. |
|[**Workload management**](./management-workloads.md)| Workloads built on top of the landing zone platform may have specific management requirements that are in addition to the tools and processes put in place for the platform services. <br> These should be considered in the context of the platform management, to ensure additions or exceptions are known and documented. <br> It is also important to look at these requirements in the broader context as what is thought to be a requirement for a single workload may become a common patterns and should be considered as part of the overall platform toolset to avoid unnecessary duplication of effort. <br> For further information on considerations for workload-specific management, review the [Operational excellence](/azure/architecture/framework/#operational-excellence) of the Well-architected Framework|
