---
title: "Azure migration best practices checklist"
description: Explore the Azure Cloud Migration Checklist to learn how to implement the Azure tools used to align with cloud migration best practices.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: azure-migrate-seo
---

# Cloud migration best practices checklist

Start with the [Azure migration guide](../azure-migration-guide/index.md) in the Cloud Adoption Framework if you're interested in migrating to Azure. That guide walks you through a set of tools and basic approaches to migrating virtual machines to the cloud. 

The following checklists provides Azure cloud migration best practices that go beyond the basic cloud-native tools. These outline the common areas of complexity that might require the scope of the migration to expand beyond the [Azure migration guide](../azure-migration-guide/index.md).

## Migration best practices for business driven scope expansion 

- **[Support global markets](./multiple-regions.md):** The business operates in multiple geographic regions with disparate data sovereignty requirements. To meet those requirements, additional considerations should be factored into the prerequisite review and distribution of assets during migration.

## Migration best practices for technology driven scope expansion

- **[VMware migration](./vmware-host.md):** Migrating VMware hosts can accelerate the overall migration process. Each migrated VMware host can move multiple workloads to the cloud using a lift and shift approach. After migration, those VMs and workloads can stay in VMware or be migrated to modern cloud capabilities.
- **[SQL Server migration](./sql-migration.md):** Migrating SQL Servers can accelerate the overall migration process. Each SQL Server migrated can move multiple databases and services, potentially accelerating multiple workloads.
- **[Multiple datacenters](./multiple-datacenters.md):** Migrating multiple datacenters adds significant complexity. During the Assess, Migrate, Optimization, and Manage processes, additional considerations are discussed to prepare for more complex environments.
- **[Data requirements exceed network capacity](./network-capacity-exceeded.md):** Companies frequently choose to migrate to the cloud because the capacity, speed, or stability of an existing datacenter is no longer satisfactory. Unfortunately, those same constraints add complexity to the migration process, requiring additional planning during the assessment and migration processes.
- **[Governance or compliance strategy](./governance-or-compliance.md):** When governance and compliance are vital to the success of a migration, additional alignment between IT governance teams and the cloud adoption team is required.

## Additional migration best practices

- [Set up networking for workloads migrated to Azure](./migrate-best-practices-networking.md)
- [Deploy a migration infrastructure](./contoso-migration-infrastructure.md)
- [costing and sizing workloads migrated to Azure](./migrate-best-practices-costs.md) 
- [Scale a migration to Azure](./contoso-migration-scale.md) 

## Next steps

[Multiple datacenters](./multiple-datacenters.md), is a good starting point when reviewing Azure migration best practices.

> [!div class="nextstepaction"]
> [Multiple datacenters](./multiple-datacenters.md)
