---
title: Container Apps Landing Zone Accelerator
description: Landing Zone Accelerator for Azure Container Apps
author: craigshoemaker
ms.author: cshoe
ms.date: 11/01/2023
ms.topic: conceptual
---

# Container Apps Landing Zone Accelerator

Azure Container Apps landing zone accelerator is your resource as you prepare to build and deploy applications in a typical enterprise landing zone design.

## What's in the accelerator

The landing zone accelerator is a set of design considerations and reference architecture backed by a specific implementation. Design areas cover considerations and recommendations for common technical areas that integrate with the centralized services.

- [Identity](identity.md)
- [Networking](networking.md)
- [Security](security.md)
- [Management and operations](management.md)

## Integration with platform landing zones

The platform landing zones have shared services that centralized teams manage, so you can focus on application development and workload resources.

As you integrate a landing zone, make sure you have a strong understanding of the integration points between the shared resources and workload resources. If the platform requires changes, work with the centralized team to implement changes together. For example, communicate the expected potential of the workload early so that the central networking team can allocate a virtual network with address space that's large enough to accommodate that growth.
