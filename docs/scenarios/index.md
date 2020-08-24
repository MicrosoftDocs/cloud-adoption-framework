---
title: "The One Migration approach to Azure adoption"
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

# The One Migration approach to migrating the IT portfolio

Azure and Azure Migrate are both well known for hosting Microsoft technologies. But you might not be aware of Azure's ability to support migrations beyond Windows and SQL Server. The *One Migration* scenarios captured in the Migrate methodology demonstrate the same set of consistent guidelines and processes for migrating both Microsoft and third-party technologies.

## Migration scenarios

The following diagram and table outline a number of scenarios that follow the same iterative Migrate methodology for migration and modernization.

![Diagram of the Cloud Adoption Framework migration model.](../_images/migrate/one-migrate.png)

| | | | |
|---------|---------|---------|---------|
| **Virtual machines** | [Virtual machines](../migrate/azure-best-practices/contoso-migration-rehost-vm.md) | [Linux servers](../migrate/azure-best-practices/contoso-migration-rehost-linux-vm.md) | [Virtual desktops](./wvd/index.md) |
| **Applications** | [ASP.NET](../migrate/azure-best-practices/contoso-migration-refactor-web-app-sql.md) | [Java](/azure/java/migration-overview?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json) | [PHP](../migrate/azure-best-practices/contoso-migration-refactor-linux-app-service-mysql.md) |
| **Data** | [SQL Server](../migrate/azure-best-practices/contoso-migration-rehost-vm-sql-managed-instance.md) | [Open source databases](../migrate/azure-best-practices/sql-migration.md) | Analytics |
| **Hybrid** | [Azure Stack](./azure-stack/index.md) | [VMware](../migrate/azure-best-practices/vmware-host.md) | |
| **Additional scenarios** | [Secure workloads](../migrate/azure-best-practices/migrate-best-practices-security-management.md) | [Mainframes](../infrastructure/mainframe-migration/index.md) | NetApp and SAP HANA |

## Migration methodology

In each of the preceding migration scenarios, the same basic process will guide your efforts as you move your existing workloads to the cloud, as shown here:

![Diagram of the Cloud Adoption Framework migration model.](../_images/migrate/methodology.png)

In each scenario, you'll structure migration waves to guide the releases of multiple workloads. Establishing a cloud adoption plan and Azure landing zones through the Plan and Ready methodologies helps to add structure to your migration waves.

During each iteration, follow the Migrate methodology to assess, deploy, and release workloads. To modify those processes to fit your organization's specific scenario, select any of the migration scenarios listed in the table.

## Next steps

If you aren't migrating a specific scenario, start by following the [four-step Cloud Adoption Framework migration process](../migrate/index.md).
