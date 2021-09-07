---
title: Migrate workloads for the retail industry
description: Learn about different options and services for migrating workloads to Azure, like Azure Marketplace for retail.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: internal, e2e-retail
---

# Migrate common retail industry technologies

In the [Migrate methodology](../../migrate/index.md) of the Cloud Adoption Framework for Azure, the primary tool for migration is Azure Migrate. Use this tool to deliver a repeatable process to migrate existing infrastructure and workloads from existing datacenters to the public cloud. The steps outlined in the Migrate methodology apply to any retail industry migration project.

There are many software as a service (SaaS) options available to retailers. These SaaS options can accelerate innovation during the migration process. This article outlines considerations for the retail industry. These considerations might influence what and how you migrate specific workloads in your portfolio to Azure.

## Migration for the retail industry

The migration process is influenced by the target stage of maturity for your retail organization. The target stage is based on the [retail cloud maturity model](./retail-cloud-maturity.md).

:::image type="content" source="./media/maturity-model.png" alt-text="Diagram that shows the stages of digital retail maturity, from left to right, Siloed retail, Connected retail, Analytics-driven retail, and Intelligent retail.":::

To move from siloed retail to connected retail, organizations focus on migration of the existing technology portfolio. This phase of cloud adoption often focuses on migrating existing workloads to an infrastructure as a service (IaaS) solution in Azure.

For companies trying to achieve higher states of maturity, it might include migrating to Microsoft Power Platform and Microsoft 365. These migrations replace many workloads that can be more effectively delivered through SaaS offerings.

## Azure Marketplace for retail

The Azure Marketplace has the most convenient approach to application deployment and migration for many common retail industry applications. Before migrating, review the [retail industry applications in the Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps?search=retail&page=1) to see whether your applications are already available.

Migrating to an approved, pre-packaged deployment of your favorite applications can accelerate your migration process and significantly reduce the time to reach the *connected retail* horizon.

## Standard migration process

The [Migrate methodology](../../migrate/index.md) gives a standard, repeatable process to migrate all of your technology assets to the cloud. Building on that process is a collection of more complex platforms and workloads that can be migrated using standard migration. Read [One Migrate](../../scenarios/index.md) to learn about the options to migrate to Azure using one or more variants of the migration process.

## Next steps

The following articles take you to guidance found at specific points in the cloud adoption journey. This guidance helps you succeed in the cloud adoption scenario.

- [Innovation in the retail industry](./innovate.md)
- [Governance in the retail industry](./govern.md)
- [Management in the retail industry](./manage.md)
