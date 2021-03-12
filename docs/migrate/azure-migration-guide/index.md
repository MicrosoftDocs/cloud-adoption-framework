---
title: Introduction to the Azure migration guide
description: Use the Cloud Adoption Framework for Azure to learn how to effectively migrate your organization's services to Azure.
author: matticusau
ms.author: brblanch
ms.date: 02/25/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.localizationpriority: high
ms.custom: think-tank, fasttrack-new, AQC
---

# Azure migration guide overview

The [Cloud Adoption Framework's Migrate methodology](../index.md) guides readers through an iterative process of migrating one workload, or a small collection of workloads per release. In each iteration, the process of assess, migration, and optimize and promote is followed to ensure that workloads are ready to meet production demands. That cloud-agnostic process can guide migration to any cloud provider.

This guide demonstrates a simplified version of that process when migrating from your on-premises environment to **Azure**.

::: zone target="docs"

> [!TIP]
> For an interactive experience, view this guide in the Azure portal. Go to the [Azure Quickstart Center](https://portal.azure.com/?feature.quickstart=true#blade/Microsoft_Azure_Resources/QuickstartCenterBlade) in the Azure portal, select **Azure migration guide**, and then follow the step-by-step instructions.

::: zone-end

## [Migration tools](#tab/MigrationTools)

This guide is the suggested path for your first migration to Azure, as it will expose you to the methodology and the cloud-native tools most commonly used during migration to Azure. Those tools are presented across the following pages:

> [!div class="checklist"]
>
> - **Assess each workload's technical fit.** Validate the technical readiness and suitability for migration.
> - **Migrate your services.** Perform the actual migration, by replicating on-premises resources to Azure.
> - **Manage costs and billing.** Understand the tools required to control costs in Azure.
> - **Optimize and promote.** Optimize for cost and performance balance before promoting your workload to production.
> - **Get assistance.** Get help and support during your migration or post-migration activities.

It is assumed that a landing zone has already been deployed, in alignment with the best practices in the [Cloud Adoption Framework's Ready methodology](../../ready/index.md).

## [When to use this guide](#tab/WhenToUseThisGuide)

While the tools discussed in this guide support a wide variety of migration scenarios, this guide will focus on limited scope efforts with *minimal complexity*. To determine whether this migration guide is suitable for your project, consider whether the following conditions apply to your situation:

- The workloads for initial migration aren't mission critical and don't contain sensitive data.
- You're migrating a homogeneous environment.
- Only a few business units need to align to complete the migration.
- You're not planning to automate the entire migration.
- You're migrating a small number of servers.
- The dependency mapping of the components to be migrated is simple to define.
- Your industry has minimal regulatory requirements relevant to this migration.

<!-- docutune:casing "our Microsoft teams" -->

If any of these conditions don't apply to your situation, you should instead consider other [best practices for cloud migration](../azure-best-practices/index.md). We also recommend you request assistance from one of our Microsoft teams or partners to perform more complex migrations. Customers who engage with Microsoft or certified partners are more successful in these scenarios. More information about requesting assistance is available in this guide.

::: zone target="docs"

For more information, see:

- [Best practices for cloud migration](../azure-best-practices/index.md)

::: zone-end
