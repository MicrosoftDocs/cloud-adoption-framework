---
title: "Migrate SAP to Azure"
description: Process for migrating SAP to Azure
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Migrate SAP to Azure

SAP is a powerful platform with specific technical requirements. Given the complexity and strict requirements for security and compliance, this platform can seldom be moved in a standardized migration factory. Azure Migrate and Migration Hub are the de facto toolchains for migrating most platforms and workloads. However, SAP will require a different set of tools and processes, for the replication and deployment of SAP assets. Often times, the SAP migration is completed in parallel to most standard migrations in your migration factory.

Once deployment of the core platform is complete, dependent workloads will resume migration through standard migrations processes and tooling.

## SAP process flow

When migrating SAP, there are a few steps to consider. Some of which deviate from standard migration process tasks.

> [!NOTE]
> Before beginning the migration of your SAP platform, validate that you have [establishd a compatible Azure Landing Zone for the SAP platform](./ready.md)

- Assess the SAP platform and dependent workloads
- SAP platform sizing considerations
- Platform Migration
- Workload Migration

Each of these tasks in the process flow are introduced in this article, with links to take action.

## Assess the SAP platform and dependent workloads

When assessing your SAP Platform and dependent workloads there are a few considerations that aren't commonly factored into the migration process:

- What operating systems and versions are your SAP virtual machines running?
- Is the current inventory of platform assets running operating systems which are supported in Azure? Unsupported operating systems will need to be remediated during or before migration.
- What database management system is your SAP platform running?
- Is the current database management system supported in Azure? Unsupported databases will need to be remediated during or before migration.
- Will you be upgrading all or part of the SAP solution before or during migration?
- How will Platform assets be configured & sized in Azure?
- What workloads have dependencies on the SAP platform?
- What assets and databases are required to support those workloads?

## SAP platform sizing considerations

Prior to deployment of the SAP Platform, there are a number of sizing considerations that should be made. Sizing commonly begins with a comparison to current asset and database sizing requirements. However, sizing should also consider long term platform operations and feature requirements. The following should be considered at a minimum:

- Virtual Machine (VM) Sizing
- VM Storage
- Uptime considerations
- Licensing consideration
- High availability / redundancy considerations
- Database high availability considerations

For examples of various architectures and sizing considerations, see the [SAP on Azure Architecture Guide](https://docs.microsoft.com/azure/architecture/reference-architectures/sap/sap-overview?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json) and associated reference architectures.

## Platform migration

The SAP data points will aid in choosing the appropriate approach to migration: Classical Migration or SAP Database Migration Option (DMO):

**Classical Migration:** SAP’s Software Provisioning Manager (SWPM) is used as the Software Logistics (SL) tool and is exclusively for database migrations. Classical Migration uses a heterogenous system copy approach and is sometimes referred to as two-step migration. This approach is commonly used when the follow data points are observed in the migration plan:

- The operating systems (OS) and database management systems (DBSM) are compatible with Azure.
- There is no other requirement to upgrade/replatform the OS or DBMS systems.

**SAP Database Migration Option (DMO):** DMO facilitates both an SAP upgrade and a database migration to the SAP HANA database using one tool. DMO process is often referred to as a one-step migration. You will see how the Software Update Manager (SUM) tool creates a shadow repository for an existing database while a target database is created in parallel; eventually the shadow repository is copied and the SAP database connection is switched to the target database. This approach is commonly used when the follow data points are observed in the migration plan:

- Existing OS is not supported in Azure, requiring an upgrade/replatform.
- There is a plan to upgrade to S/4HANA during migration.

To learn more about each process for migrating the SAP Platform, see the learn module on [Migrating an SAP platform to Azure](https://docs.microsoft.com/learn/modules/migrate-sap-workloads-azure/).

### Workload Migration

Once the core platform is migrated, each dependent workload may be migrated using standardized [migration factory processes](../../migrate/index.md).
For specific scenarios based on the architecture of each group of workloads, see the [Migration Scenario overview](../index.md).

## Next step: Innovate with SAP

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
