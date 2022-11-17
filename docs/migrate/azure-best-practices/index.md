---
title: Azure cloud migration best practices checklist
description: Explore the Azure cloud migration checklist to learn how to implement the Azure tools used to align with cloud migration best practices.
author: BrianBlanchard
ms.author: martinek
ms.date: 02/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal, seo-azure-migrate
---

# Azure cloud migration best practices checklist

Start with the [Azure migration guide](../azure-migration-guide/index.md) in the Cloud Adoption Framework if you're interested in migrating to Azure. That guide walks you through a set of tools and basic approaches to migrating virtual machines to the cloud.

The following resources provide Azure cloud migration best practices that go beyond the basic cloud-native tools. These guides and checklists outline the common areas of complexity that can require the scope of your migration to expand beyond the [Azure migration guide](../azure-migration-guide/index.md).

## Migration best practices for business-driven scope expansion

- [Support global markets](./multiple-regions.md): Your business might operate in multiple geographic regions with disparate data sovereignty requirements. The review and distribution of assets both require extra consideration during migration.

## Migration best practices for technology-driven scope expansion

- [VMware migration](../../scenarios/azure-vmware/index.md): Migrating VMware hosts can accelerate the overall migration process. Each migrated VMware host can move multiple workloads to the cloud. After migration, those VMs and workloads can stay in VMware, or be migrated to modern cloud capabilities.
- [SQL Server migration](./sql-migration.md): Migrating instances of SQL Server can accelerate the overall migration process. Each migrated instance can move multiple databases and services, potentially accelerating multiple workloads.
- [Multiple datacenters](./multiple-datacenters.md): Migrating multiple datacenters adds significant complexity. During each process of the move (assess, migrate, optimize, and manage), there are extra considerations that must be addressed.
- [Data requirements exceed network capacity](./network-capacity-exceeded.md): Companies frequently choose to migrate to the cloud because the capacity, speed, or stability of an existing datacenter is no longer satisfactory. Unfortunately, those same constraints add complexity to the migration process, requiring more planning during the assessment and migration processes.
- [Governance or compliance strategy](./governance-or-compliance.md): When governance and compliance are vital to the success of a migration, IT governance teams and the cloud adoption team must ensure full alignment with one another.

## Additional migration best practices

- [Set up networking for workloads migrated to Azure](./migrate-best-practices-networking.md)
- [Deploy a migration infrastructure](./contoso-migration-infrastructure.md)
- [Cost and size workloads migrated to Azure](./migrate-best-practices-costs.md)
- [Scale a migration to Azure](./contoso-migration-scale.md)

## Next steps

Review the following guide to learn about migrating multiple datacenters to the cloud.

> [!div class="nextstepaction"]
> [Multiple datacenters](./multiple-datacenters.md)
