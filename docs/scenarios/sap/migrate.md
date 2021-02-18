---
title: Migrate an SAP platform to Azure
description: Understand how to migrate an SAP platform to Azure.
author: deepakonics
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank
---

# Migrate an SAP platform to Azure

SAP is a powerful platform with specific, complex, and strict technical, security, and compliance requirements; this platform is seldom moved in a standard migration factory. Azure Migrate features tools that can migrate most platforms and workloads, but SAP workloads require different tools and processes to replicate and deploy their assets. Once the core platform is deployed, standard processes and tools will help dependant workloads to resume and finish migrating.

## SAP process flow

There are a few steps to consider when migrating SAP workloads, some of which deviate from standard migration tasks:

> [!NOTE]
> Before you start to migrate your SAP platform, validate that you have [established a compatible Azure landing zone for the SAP platform](./ready.md) and:

- Assess the SAP platform and dependant workloads.
- Evaluate sizing considerations for the SAP platform.
- Migrate the platform.
- Migrate the workload.

## Assess the SAP platform and dependant workloads

A few considerations aren't commonly factored into the migration process when an SAP platform and dependant workloads are assessed:

- What operating systems and versions are your SAP virtual machines running?

- Do current platform assets run operating systems that are supported in Azure? Unsupported operating systems will need to be remediated during or before migration.

- What database management system (DBMS) is your SAP platform running?

- Is the current DBMS supported in Azure? Unsupported databases will need to be remediated during or before migration.

- Will you be upgrading all or part of the SAP solution before or during migration?

- How will platform assets be configured and sized in Azure?

- What workloads depend on the SAP platform?

- What assets and databases are required to support those workloads?

## Evaluate sizing considerations for the SAP platform

A number of sizing considerations should be made prior to deploying an SAP platform. Organizations typically start by evaluating sizing requirements for current assets and databases, and they should also consider long-term platform operations and feature requirements. The following should be considered at a minimum:

- Virtual Machine (VM) Sizing
- VM Storage
- Uptime factors
- Licensing factors
- High availability/redundancy factors
- Database high-availability factors

Explore the [SAP on Azure Architecture Guide](https://docs.microsoft.com/azure/architecture/reference-architectures/sap/sap-overview?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json) to see examples of reference architectures and sizing considerations.

## Migrate the platform

The DBMS needs to be changed, or the internal format of the same DBMS system needs to change to the little endian format supported in the Intel world; for example, migrating from the IBM pSeries to Azure. The SAP workload's datapoints help to choose the appropriate migration approach: classical or an SAP Database Migration Option (DMO).

**Classical migration:** The SAP Software Provisioning Manager is used specifically as a software logistics tool for database migrations. Classical migration uses a heterogenous system copy approach and is sometimes called a  _two-step migration_. This approach is commonly used when the following observations surface in the migration plan:

- The operating systems (OS) and DBMS are compatible with Azure.
- There aren't other requirements to upgrade/replatform the OS or DBMS systems.

**DMO:** DMO uses one tool to upgrade an SAP workload and a database migration to the SAP HANA database, and this process is often called a _one-step migration_. The SAP Software Update Manager, SUM, tool creates a shadow repository for current database while also creating a target database at the same time. It eventually copies the shadow repository and switches the SAP database connection to the target database. This approach is commonly used when the follow data points are observed in the migration plan:

- The current OS isn't supported in Azure, requiring an upgrade/replatform.
- There is a plan to upgrade to SAP S/4HANA during migration.

Explore the [Migrating an SAP platform to Azure](https://docs.microsoft.com/learn/modules/migrate-sap-workloads-azure/) Microsoft Learn module to learn more about each process for migrating the SAP platform.

## Migrate the workload

After migrating the core platform, you can use standardized [migration factory processes](../../migrate/index.md) to migrate each dependant workload. See the [introduction to an SAP adoption scenario](./index.md) for individual workload group architectures and their unique scenarios.

## Next step: Innovate with SAP

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting SAP in Azure.

- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)

Learn more about operating systems, DBMSs, and other [SAP software supported for Azure deployments](/azure/virtual-machines/workloads/sap/sap-supported-product-on-azure).
