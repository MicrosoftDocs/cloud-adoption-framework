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

## Overview

For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities.

The management design area focusses on the considerations and recommendations for design decisions as part of the landing zone. In addition to this, the [Manage methodology](/manage/index.md) in the Cloud Adoption Framework provides further in-depth guidance for holistic management processes and tools. 

Use the following items as discussion points within your cloud architecture and operations teams in order to explore and agree on the requirements and features that need to be included in your management design.

|Scope|Context|
|-|-|
|[**Platform management**](./management-platform.md)|As cloud environments are implemented and scaled out, management controls that span the environment become increasingly important. <br> Irrespective of the services that are running on top of the landing zone, there is a need for the management of fundamental elements of the platform to ensure stable, ongoing operations. <br> These management tools should be capable of scaling as the environments do. <br> They may include a mix of first party and third party tools, depending on your existing investments.|
|[**Workload management**](./management-workloads.md)| Workloads and services built on top of the landing zone platform may have specific management requirements that are in addition to the tools and processes put in place for the platform services. <br> These should be considered in the context of the platform management, to ensure additions or exceptions are known and documented. <br> It is also important to look at these requirements in the broader context as what is thought to be a requirement for a single workload may become a common patterns and should be considered as part of the overall platform toolset to avoid unnecessary duplication of effort. <br> For further information on considerations for workload-specific management, review the [Operational excellence](/azure/architecture/framework/#operational-excellence) of the Well-architected Framework|
|[**Business continuity and disaster recovery**](./management-bcdr.md)| Your organization needs to design suitable, platform-level capabilities that application workloads can consume to meet their specific requirements.  <br>  Specifically, these application workloads have requirements pertaining to recover time objective (RTO) and recovery point objective (RPO). Be sure that you capture disaster recovery (DR) requirements in order to design capabilities appropriately for these workloads.
