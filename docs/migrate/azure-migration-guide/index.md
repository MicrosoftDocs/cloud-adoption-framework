---
title: Introduction to the Azure migration guide
description: Use the Cloud Adoption Framework for Azure to learn how to effectively migrate your organization's services to Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 06/12/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, fasttrack-new, AQC, UpdateFrequency2
---

# Azure migration guide overview

The [Migrate methodology](../index.md) of the Cloud Adoption Framework guides readers through an iterative process of migrating one workload or a small collection of workloads per release. In each iteration, you follow a process to assess, migrate, optimize, and promote to ensure that workloads are ready to meet production demands. That cloud-agnostic process can guide migration to any cloud provider.

This article guides you through a simplified migration process to Azure.

> [!TIP]
> For an interactive experience, view this guide in the Azure portal. Go to the [Azure Quickstart Center](https://portal.azure.com/?feature.quickstart=true#blade/Microsoft_Azure_Resources/QuickstartCenterBlade) in the Azure portal, select **Azure migration guide**, and then follow the step-by-step instructions.

## Migration tools

This guide is the suggested path for your first migration to Azure. It exposes you to the methodology and the cloud-native tools most commonly used during migration to Azure. Those tools are presented across the following pages:

> [!div class="checklist"]
>
> - [**Assess.**](assess.md) Assess workloads, refine plans, and validate technical readiness and suitability for migration.
> - [**Deploy.**](migrate.md) Migrate your services and assets. Perform the actual migration by replicating on-premises resources to Azure. This can, as an example, involve a _lift and shift_ or _rehost_ to the cloud.
> - [**Manage costs and billing.**](manage-costs.md) Understand the tools required for migration-focused cost control mechanisms in Azure.
> - [**Release workloads.**](optimize-and-transform.md) Optimize for cost and performance balance before you release your workload to production.
> - [**Get assistance.**](assistance.md) Get help and support during your migration or post-migration activities.

In alignment with the best practices in the [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework, deploy a landing zone before you continue with this guide.

## When to use this guide

The tools discussed in this guide support a wide variety of migration scenarios. You can use this guide as a baseline for most migrations, and this format works well for planning and migrating most workloads. 

To determine whether this migration guide is suitable for your project, consider whether the following conditions apply to your situation:

- The workloads for initial migration aren't mission-critical and don't contain sensitive data.
- You're migrating a homogeneous environment.
- Only a few business units need to align to complete the migration.
- You're not planning to automate the entire migration.
- You're migrating a small number of servers.
- The dependency mapping of the components to be migrated is simple to define.
- Your industry has minimal regulatory requirements relevant to this migration.

<!-- docutune:casing "our Microsoft teams" -->

If any of these conditions don't apply to your situation, consider other [best practices for cloud migration](../azure-best-practices/index.md). For more complex migrations, we recommend that you request assistance from one of our Microsoft teams or partners. Customers who engage with Microsoft or certified partners are more successful in these scenarios. More information about requesting assistance is available in this guide.

For more information, see:

- [Best practices for cloud migration](../azure-best-practices/index.md)
