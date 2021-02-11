---
title: "Enterprise-Scale support for hybrid and multicloud"
description: Describe how enterprise-scale can accelerate adoption of AKS
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise-scale support for hybrid and multicloud
  
Enterprise-scale landing zones provide a specific architectural approach, reference architecture, and reference implementations to prepare your landing zones for mission critical technology platforms and any supported workloads. 

Enterprise-scale was built with hybrid and multicloud in mind. Supporting hybrid and multicloud requires three simple additions to the reference architecture:

- Hybrid: Add hybrid network connectivity
- Multicloud: Add multicloud network connectivity
- Unified Operations: Add Azure Arc to extend governance and operations support 

## Prerequisite

This article assumes that enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review the enterprise-scale [overview](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) and [implementation guidance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) before deploying the AKS construction set.

## Design guidelines

Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. There are 6 critical design areas that can be used to review and modify your enterprise-scale landing zone or any other Azure Landing Zone implementation:

- [Identity and Access Management](../../ready/enterprise-scale/identity-and-access-management.md)
- [Network topology and connectivity](../../ready/enterprise-scale/network-topology-and-connectivity.md)
- [Management and monitoring](../../ready/enterprise-scale/management-and-monitoring.md)
- [Business continuity and disaster recovery](../../ready/enterprise-scale/business-continuity-and-disaster-recovery.md)
- [Security, governance and compliance](../../ready/enterprise-scale/security-governance-and-compliance.md)
- [Platform automation and DevOps](../../ready/enterprise-scale/platform-automation-and-devops.md)

## Implementation additions

To extend enterprise-scale to address hybrid and multicloud needs, consider the following simple additions to your implementation:

- Hybrid: Apply the relevant design guidance from the network topology and connectivity design area.
    - Or start with the VWan or Hub/spoke reference implementations to begin with connectivity considerations in place. TODO: Add links
- Multicloud: Add multicloud connectivity to any enterprise-scale implementation TODO: Add links
- Unified Operations: Add Azure Arc & onboard assets from other cloud platforms to apply the standard governance and operations tools to those non-Azure assets. TODO: Add link to Manage
