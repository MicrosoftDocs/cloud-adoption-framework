---
title: Azure migration tools decision guide
description: Use this decision tree as high-level guidance for selecting the best tools to use for your Azure migrations based on your migration decisions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 07/07/2023
ms.topic: conceptual
s.custom: internal, engagement-fy23, UpdateFrequency2
---

# Migration tools decision guide

The strategy and tools you use to migrate an application to Azure depend on your business motivations, technology strategies, timelines, and a deep understanding of the actual workload and assets (infrastructure, apps, and data) to migrate.

The following decision tree provides high-level guidance for selecting the best tools based on migration decisions. Treat this decision tree as a starting point.

The choice to migrate using the platform as a service (PaaS) or infrastructure as a service (IaaS) technologies is driven by the balance between cost, time, existing technical debt, and long-term returns. IaaS is often the fastest path to the cloud with the least required changes to the workload. PaaS could require modifications to data structures or source code but produces substantial long-term returns through reduced operating costs and greater technical flexibility.

In the following diagram, the term *modernize* reflects a decision to modernize an asset during migration and then migrate it to a PaaS platform.

![Example migration tools decision tree.](../../_images/migrate/migration-tools-decision-tree.png)

## Key questions

Answering the following questions allows you to decide based on the above tree.

- **Would modernization of the application platform during migration be a wise investment of time, energy, and budget?**
  Utilizing PaaS technologies like Azure App Service or Azure Functions can enhance deployment flexibility and simplify the management of application hosting on virtual machines. However, migrating applications to use these cloud-native capabilities might involve refactoring, which can substantially increase the time and cost of the migration process. If your application can transition to PaaS technologies with minimal modifications, it's likely suitable for modernization. Conversely, if extensive refactoring is required, opting for a migration using IaaS-based virtual machines might be a more favorable choice.

- **Would modernization of the data platform during migration be a wise investment of time, energy, and budget?**
  As with application migration, Azure PaaS managed storage options, such as Azure SQL Database, Azure Cosmos DB, and Azure Storage, offer significant management and flexibility benefits, but migrating to these services might require refactoring of existing data and the applications that use that data. Data platforms typically require less refactoring than the application platform would. Therefore, it's common for the data platform to be modernized, even though the application platform remains the same. If your data can be migrated to a managed data service with minimal changes, it's a good candidate for modernization. Data requiring extensive time or cost to refactor to use these PaaS services might be better migrated using IaaS-based virtual machines to match existing hosting capabilities better.

- **Is your existing application running on dedicated virtual machines or sharing hosting with other applications?**
  Application running on dedicated virtual machines might be more easily migrated to PaaS hosting options than applications running on shared servers.

- **Will your data migration exceed your network bandwidth?**
  Network capacity between your on-premises data sources and Azure can be a bottleneck in data migration. If the data you need to transfer face bandwidth limitations that prevent efficient or timely migration, you might need to look into alternative or offline transfer mechanisms. The Cloud Adoption Framework's [article on migration replication](../../migrate/migration-considerations/migrate/replicate.md#replication-risks-physics-of-replication) discusses how replication limits can affect migration efforts. As part of your migration assessment, consult your IT teams to verify that your local and WAN bandwidth can handle your migration requirements. Also, see the [migration scenario for handling storage requirements that exceed network capacity during a migration](../../migrate/azure-best-practices/network-capacity-exceeded.md#suggested-prerequisites).

- **Does your application make use of an existing DevOps pipeline?**
  In many cases, Azure Pipelines can be easily refactored to deploy applications to cloud-based hosting environments.

- **Does your data have complex data storage requirements?**
  Production applications usually require data storage that is highly available and offers always-on functionality and similar service uptime and continuity features. Azure PaaS-based managed database options, such as Azure SQL Database, Azure Database for MySQL, and Azure Cosmos DB, offer 99.99 percent uptime service-level agreements. Conversely, IaaS-based SQL Server on Azure VMs offers single-instance service-level agreements of 99.95 percent. If your data can't be modernized to use PaaS storage options, guaranteeing higher IaaS uptime involves more complex data storage scenarios such as running SQL Server Always On clusters and continuously syncing data between instances. This can involve significant hosting and maintenance costs, so balancing uptime requirements, modernization effort, and overall budgetary impact is essential when considering your data migration options.

## Innovation and migration

In line with the Cloud Adoption Framework's emphasis on [incremental migration](../../migrate/index.md#migration-effort) efforts, an initial decision on migration strategy and tooling doesn't rule out future innovation efforts to update an application to take advantage of opportunities presented by the Azure platform. While an initial migration effort might focus primarily on rehosting using an IaaS approach, you should plan to revisit your cloud-hosted application portfolio regularly to investigate optimization opportunities.

## Learn more

- [Cloud fundamentals: Overview of Azure compute options](/azure/architecture/guide/technology-choices/compute-decision-tree): Provides information on the capabilities of Azure IaaS and PaaS compute options.
- [Cloud fundamentals: Choose the right data store](/azure/architecture/guide/technology-choices/data-store-overview): Discusses PaaS storage options available on the Azure platform.
- [Migration best practices: Data requirements exceed network capacity during a migration effort](../../migrate/azure-best-practices/network-capacity-exceeded.md): Discusses alternative data migration mechanisms for scenarios where data migration is hindered by available network bandwidth.
- [SQL Database: Choose the right SQL Server option in Azure](/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview#business-motivations-for-choosing-databases-managed-instances-or-sql-virtual-machines): Discussion of the options and business justifications for choosing to host your SQL Server workloads in a managed infrastructure (IaaS) or a managed service (PaaS) environment.
