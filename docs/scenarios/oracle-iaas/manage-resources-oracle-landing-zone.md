---
title: Organize resources for Oracle on Azure Virtual Machines landing zone 
description: Learn about organizing resources for Oracle on Azure Virtual Machines landing zone.
author: jjaygbay1
ms.author: jacobjaygbay
ms.reviewer: ramakoni
ms.date: 01/10/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: 
  - think-tank
  - e2e-oracle
  - engagement-fy24
---


#  Organize resources for Oracle on Azure Virtual Machines landing zone

This article describes how to manage resources for Oracle on Azure Virtual Machines landing zone accelerator. Azure landing zones for Oracle don't have specific recommendations that impact [Resource organization design area decisions](../../ready/landing-zone/design-area/resource-org.md).

However, it's important to understand decisions previously made by the cloud platform team to determine resource organization requirements.

## Use Azure resource naming and tagging conventions

The business side of this strategy ensures that resource names and tags include the organizational information you need to identify the teams. Use a resource name along with the business owners who are responsible for resource costs.

The operational side ensures that names and tags include information that IT teams use to identify the workload, application, environment, criticality, and other useful information for managing resources.

## Next steps

- [Network topology and connectivity for Oracle on Azure Virtual Machines landing zone](oracle-network-topology.md).