---
title: "Cloud migration expanded scope checklist"
titleSuffix: Microsoft Cloud Adoption Framework for Azure
description: Cloud migration expanded scope checklist
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/10/2019
ms.topic: guide
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Expanded scope for cloud migration

The [Azure migration guide](../azure-migration-guide/index.md) in the Cloud Adoption Framework is the suggested starting point for readers who are interested in a rehost migration to Azure, also known as a "lift and shift" migration. That guide walks you through a series of prerequisites, tools, and approaches to migrating virtual machines to the cloud.

While this guide is an effective baseline to familiarize you with this type of migration, it makes several assumptions. Those assumptions align the guide with many of the Cloud Adoption Framework's readers by providing a simplified approach to migrations. This section of the Cloud Adoption Framework addresses some expanded scope migration scenarios, which help guide efforts when those assumptions don't apply.

## Cloud migration expanded scope checklist

The following checklist outlines the common areas of complexity which could require the scope of the migration to be expanded beyond the [Azure migration guide](../azure-migration-guide/index.md).

### Business driven scope expansion

- **[Balance the portfolio](./balance-the-portfolio.md):** The cloud strategy team is interested in investing more heavily in migration (rehosting existing workloads and applications with a minimum of modifications) or innovation (refactoring or rebuilding those workloads and applications using modern cloud technology). Often, a balance between the two priorities is the key to success. In this guide, the topic of balancing the cloud adoption portfolio is a common one, addressed in each of the migrate processes.
- **[Support global markets](../../decision-guides/regions/index.md):** The business operates in multiple geographic regions with disparate data sovereignty requirements. To meet those requirements, additional considerations should be factored into the prerequisite review and distribution of assets during migration.

### Technology driven scope expansion

- **[VMware migration](./vmware-host.md):** Migrating VMware hosts can accelerate the overall migration process. Each migrated VMware host can move multiple workloads to the cloud using a lift and shift approach. After migration, those VMs and workloads can stay in VMware or be migrated to modern cloud capabilities.
- **[SQL Server migration](./sql-migration.md):** Migrating SQL Servers can accelerate the overall migration process. Each SQL Server migrated can move multiple databases and services, potentially accelerating multiple workloads.
- **[Multiple datacenters](./multiple-datacenters.md):** Migrating multiple datacenters adds a lot of complexity. During the Assess, Migrate, Optimization, and Manage processes, additional considerations are discussed to prepare for more complex environments.
- **[Data requirements exceed network capacity](./network-capacity-exceeded.md):** Companies frequently choose to migrate to the cloud because the capacity, speed, or stability of an existing datacenter is no longer satisfactory. Unfortunately, those same constraints add complexity to the migration process, requiring additional planning during the assessment and migration processes.
- **[Governance or compliance strategy](./governance-or-compliance.md):** When governance and compliance are vital to the success of a migration, additional alignment between IT governance teams and the cloud adoption team is required.

If any of these complexities are present in your scenario, then this section of the Cloud Adoption Framework will likely provide the type of guidance needed to properly align scope in the migration processes.

Each of these scenarios is addressed by the various articles in this section of the Cloud Adoption Framework.

## Next steps

Browse the table of contents on the left to address specific needs or scope changes. Alternatively, the first scope enhancement on the list, [Balance the portfolio](./balance-the-portfolio.md), is a good starting point when reviewing these scenarios.

> [!div class="nextstepaction"]
> [Balance the portfolio](./balance-the-portfolio.md)
