---
title: Migrate an SAP platform to Azure
description: Understand how to migrate an SAP platform to Azure.
author: deepakonics
ms.author: martinek
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-sap
---

# Migrate an SAP platform to Azure

SAP is a powerful platform with specific, complex, and strict technical, security, and compliance requirements; this platform is unlikely to move in a standard migration factory. Azure Migrate features tools that can migrate most platforms and workloads, but SAP workloads require different tools and processes to replicate and deploy their assets. Once the core platform is deployed, standard processes and tools help dependent workloads to resume and finish migrating.

## SAP process flow

There are a few steps to consider when migrating SAP workloads, some of which deviate from standard migration tasks:

> [!NOTE]
> Before you start to migrate your SAP platform, validate that you have [established a compatible Azure landing zone for the SAP platform](./ready.md) and:

- Assess the SAP platform and dependent workloads.
- Evaluate sizing considerations for the SAP platform.
- Migrate the platform.
- Migrate the workload.

## Assess the SAP platform and dependent workloads

Organizations typically don't consider the following questions when assessing an SAP platform and dependent workloads:

- What operating systems and versions are your SAP virtual machines running?

- Do current platform assets run operating systems that are supported in Azure? Unsupported operating systems need to be remediated during or before migration.

- What database management system (DBMS) is your SAP platform running?

- Is the current DBMS supported in Azure? Unsupported databases need to be remediated during or before migration.

- Will you be upgrading all or part of the SAP solution before or during migration?

- How will platform assets be configured and sized in Azure?

- What workloads depend on the SAP platform?

- What assets and databases are required to support those workloads?

## Evaluate sizing considerations for the SAP platform

Several sizing considerations should be made prior to deploying an SAP platform. Organizations typically start by evaluating sizing requirements for current assets and databases, and they should also consider long-term platform operations and feature requirements. The following should be considered at a minimum:

- Virtual machine (VM) sizing
- VM storage
- Uptime factors
- Licensing factors
- High-availability/redundancy factors
- Database high-availability factors

Explore the [SAP on Azure Architecture Guide](/azure/architecture/reference-architectures/sap/sap-overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) to see examples of reference architectures and sizing considerations.

## Migrate the platform

Based on the kind of SAP workload and requirements, the SAP workload's data points help to choose the appropriate migration approach: classical or an SAP Database Migration Option (DMO). Some of the critical data points to consider include:

- Requirement to perform Unicode conversion (non-Unicode to Unicode).
- The DBMS that needs to be either changed or the internal format of the same DBMS system needs to change to the little-endian format supported in the Intel world; for example, migrating from the IBM pSeries to Azure.

**Classical migration:** The SAP Software Provisioning Manager is a software logistics tool for database migrations. Classical migration uses a homogeneous or heterogenous system copy approach, sometimes called a *two-step migration*. This approach is commonly used when the following observations surface in the migration plan:

- The operating systems (OS) and DBMS are compatible with Azure.
- There aren't other requirements to upgrade or replatform the OS or DBMS systems.

**DMO:** DMO uses one tool to upgrade an SAP workload and a database migration to the SAP HANA database, and this process is often called a *one-step migration*. The SAP Software Update Manager tool creates a shadow repository for the current database while creating a target database simultaneously. It eventually copies the shadow repository and switches the SAP database connection to the target database. This approach is commonly used when the following data points are observed in the migration plan:

- The current OS or DBMS isn't supported in Azure, requiring an upgrade or replatform.
- There's a plan to upgrade to SAP S/4HANA during migration.

Explore [Migrating an SAP platform to Azure](/training/modules/migrate-sap-workloads-azure/) to learn more about each process for migrating the SAP platform.

## Migrate the workload

After migrating the core platform, you can use standardized [migration factory processes](../../migrate/index.md) to migrate each dependent workload. See the [introduction to an SAP adoption scenario](./index.md) for individual workload group architectures and their unique scenarios.

## Next step: Innovate with SAP

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting SAP in Azure.

- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)

Learn more about operating systems, database management systems, and other [SAP software supported for Azure deployments](/azure/virtual-machines/workloads/sap/sap-supported-product-on-azure).
