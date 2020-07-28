---
title: "One Migration approach to Azure adoption"
description: Follow the One Migration approach of Azure Migrate to migrate and modernize entire IT portfolios.
author: BrianBlanchard
ms.author: brblanch
ms.date: 10/10/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- docsTest:ignore "One Migration" -->
<!-- cSpell:ignore HANA -->

# One migration approach to migrating the IT portfolio

Azure and Azure Migrate are both well known for hosting Microsoft technologies. But you might not know about Azure's ability to support migrations beyond Windows and SQL Server. The migration scenarios captured in the Migrate methodology demonstrate the same set of consistent guidelines and processes for migrating both Microsoft and third-party technologies.

## Migration scenarios

The image and list below outline a number of migration scenarios that follow the same iterative methodology for migration and modernization.

![Cloud Adoption Framework migration model](../_images/migrate/one-migrate.png)

### Links to migration scenarios

| | | | |
|---------|---------|---------|---------|
| **Virtual machines** | [Virtual machines](../migrate/azure-best-practices/contoso-migration-rehost-vm.md) | [Linux servers](../migrate/azure-best-practices/contoso-migration-rehost-linux-vm.md) | [Virtual desktops](./wvd/index.md) |
| **Applications** | [ASP.NET](../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql.md) | [Java](https://docs.microsoft.com/azure/java/migration-overview?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) | [PHP](../migrate/azure-best-practices/contoso-migration-refactor-linux-app-service-mysql.md) |
| **Data** | [SQL Server](../migrate/azure-best-practices/contoso-migration-rehost-vm-sql-managed-instance.md) | [Open source databases](../migrate/azure-best-practices/sql-migration.md) | Analytics |
| **Hybrid** | [Azure Stack](./azure-stack/index.md) | [VMware](../migrate/azure-best-practices/vmware-host.md) | |
| **Additional scenarios** | [Secure workloads](../migrate/azure-best-practices/migrate-best-practices-security-management.md) | [Mainframes](../infrastructure/mainframe-migration/index.md) | NetApp and SAP HANA |

## Migrate methodology

In each of the migration scenarios, the same consistent processes guide migration efforts when moving existing workloads to the cloud.

![Cloud Adoption Framework migration model](../_images/migrate/methodology.png)

Structure migration waves to guide releases of multiple workloads. Establishing a cloud adoption plan and Azure landing zones through the plan and Ready methodologies helps add structure to your migration waves.

During each iteration, follow the Migrate methodology to assess workloads, deploy workloads, and release workloads. To modify those processes to fit your specific scenarios, click on any of the migration scenarios listed above.

## Next steps

If you aren't migrating a specific scenario, start by following the [four step CAF migration process](../migrate/index.md).
