---
title: Enterprise Scale support for hybrid and multicloud
description: Learn how Enterprise Scale can accelerate adoption of hybrid or multi-cloud architectures.
author: LauraNicolas
ms.author: doalle
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-hybrid
---

# Introduction to Enterprise Scale Landing Zone for hybrid and multicloud

Enterprises are currently building and running applications across a variety of ecosystems that can be on-premises, in multiple public clouds and on the edge. On these distributed environments it is critical to ensure compliance and find an effective way to manage servers, applications and data at scale while maintaining agility.

[Enterprise Scale Landing Zone provide a specific architectural approach](../../ready/enterprise-scale/architecture.md), reference architecture, and reference implementations to prepare your Landing Zones for mission-critical technology platforms and any supported workloads.

[PLACEHOLDER]

Enterprise Scale was built with hybrid and multicloud in mind. Supporting hybrid and multicloud requires two simple additions to the reference architecture:

* Hybrid and multicloud connectivity: understand key network design considerations and recommendations when working with Azure Arc.
* Unified operations: include Azure Arc enabled resources to extend governance and operations support with consistent tooling.

## Why hybrid?

As organizations look to adopt modern cloud services and the benefits they bring, there will be an inevitable period of parallel-running alongside the legacy on-premises infrastructure.

Furthermore, as cloud services are evaluated, or as business requirements dictate, organizations may choose to run services in more than one public cloud service.

A distributed heterogeneous estate requires simplified consolidated management and governance in order to reduce the operational impact.

Landing Zone concepts introduced as part of the Cloud Adoption Framework guidance can be used to establish patterns for building out hybrid architectures and introducing standards for connectivity, governance, and monitoring.

This is helpful if the strategic intent is to simplify and consolidate the infrastructure and services following migration projects as setting standards for management processes and tools means workloads will not have to be retrofitted after moving into Azure.

## Prerequisite

This article assumes that you are familiar with Enterprise Scale Landing Zone. For more information on this prerequisite, review the Enterprise Scale [overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md).

## Azure Arc

As described in this article, Azure provides organizations with various management tools that enable infrastructure and applications to be monitored and governed at scale. When implementing a hybrid Landing Zone, these Azure tools should be extended to control infrastructure and applications running outside of Azure.

This provides a single management plane and a single view on the entire hybrid estate in order to make monitoring and management at scale as straightforward as possible.

![Azure Arc high level architecture](./media/azure-arc-high-level-architecture.png)

[Azure Arc](/azure/azure-arc/) simplifies governance and management by delivering a consistent multi-cloud and on-premises management platform. Azure Arc enables you to manage your entire environment, with a single pane of glass, by projecting your existing resources into [Azure Resource Manager](/azure/azure-resource-manager/management/overview).

You can now manage virtual machines, Kubernetes clusters, and databases as if they are running in Azure. Regardless of where they live, you can use familiar Azure services and management capabilities. Azure Arc enables you to continue using traditional ITOps, while introducing DevOps practices to support new cloud native patterns in your environment.

## Design guidelines

Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure Enterprise Scale Landing Zone in a hybrid a multicloud environment. There are six critical design areas that need to be considered as part of your Enterprise Scale Landing Zone implementation when working with Azure Arc:

* [Network topology and connectivity](PLACEHOLDER): design considerations when working with Azure Arc-enabled servers and how to securely connect them to your Enterprise Scale Landing Zone.
* [Identity and access management](PLACEHOLDER): best practices for right access controls design to secure hybrid resources as they are centrally managed from Azure using Azure Arc.
* [Security, governance and compliance](PLACEHOLDER): the [Cloud Adoption Framework's Enterprise Scale Landing Zone architecture](../../ready/enterprise-scale/architecture.md) includes patterns for standardizing the deployment of [Azure Policy](/azure/governance/policy/overview) and [Role-based Access Controls (RBAC)](../../ready/azure-setup-guide/manage-access.md) through structured use of management groups to segment resources into logical groupings. These patterns can be extended using technologies such as Azure Arc.
* [Management and monitoring](PLACEHOLDER): similar to governance techniques, Azure Management services can also be extended out to other environments, such as on-premises and other cloud platforms through Azure Arc. Enterprise Scale provides guidance on how operationally maintain Azure Arc-enabled servers on Azure enterprise estate, with centralized management and monitoring at the platform level
* [Platform automation](PLACEHOLDER): Azure Arc enables organizations to manage their digital state hosted outside of Azure with the same level of experience and automation as a native Azure resource. As part of your Enterprise Scale Landing Zone implementation you should plan for agent onboarding, lifecycle management, and expansion of the Azure control plane capabilities via Azure Arc with as much automation as posible.
* [Cost Management](PLACEHOLDER): keep track of ungoverned and unmonitored resources that prevent you from to increase accountability with budgets, cost allocation, and chargebacks.
