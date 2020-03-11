---
title: "Azure migration best practices"
description: Use the Cloud Adoption Framework for Azure to learn how to implement the tools necessary to align with best practices for cloud migration.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/04/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Best practices for cloud migration

The [Azure migration guide](../azure-migration-guide/index.md) in the Cloud Adoption Framework is the suggested starting point if you're interested in migrating to Azure. That guide walks you through a set of tools and basic approaches to migrating virtual machines to the cloud. This section of the Cloud Adoption Framework addresses many best practices that go beyond the basic cloud-native tools.

## Cloud migration best practice checklist

The following checklist outlines the common areas of complexity that could require the scope of the migration to expand beyond the [Azure migration guide](../azure-migration-guide/index.md).

### Business driven scope expansion

- **[Support global markets](./multiple-regions.md):** The business operates in multiple geographic regions with disparate data sovereignty requirements. To meet those requirements, additional considerations should be factored into the prerequisite review and distribution of assets during migration.

### Technology driven scope expansion

- **[VMware migration](./vmware-host.md):** Migrating VMware hosts can accelerate the overall migration process. Each migrated VMware host can move multiple workloads to the cloud using a lift and shift approach. After migration, those VMs and workloads can stay in VMware or be migrated to modern cloud capabilities.
- **[SQL Server migration](./sql-migration.md):** Migrating SQL Servers can accelerate the overall migration process. Each SQL Server migrated can move multiple databases and services, potentially accelerating multiple workloads.
- **[Multiple datacenters](./multiple-datacenters.md):** Migrating multiple datacenters adds significant complexity. During the Assess, Migrate, Optimization, and Manage processes, additional considerations are discussed to prepare for more complex environments.
- **[Data requirements exceed network capacity](./network-capacity-exceeded.md):** Companies frequently choose to migrate to the cloud because the capacity, speed, or stability of an existing datacenter is no longer satisfactory. Unfortunately, those same constraints add complexity to the migration process, requiring additional planning during the assessment and migration processes.
- **[Governance or compliance strategy](./governance-or-compliance.md):** When governance and compliance are vital to the success of a migration, additional alignment between IT governance teams and the cloud adoption team is required.

If any of these complexities are present in your scenario, then this section of the Cloud Adoption Framework will likely provide the type of guidance needed to properly align scope in the migration processes.

Each of these scenarios is addressed by the various articles in this section of the Cloud Adoption Framework.

## Next steps

Browse the table of contents on the left to address specific needs or scope changes. Alternatively, the first scope enhancement on the list, [Support global markets](./multiple-regions.md), is a good starting point when reviewing these scenarios.

> [!div class="nextstepaction"]
> [Support global markets](./multiple-regions.md)
