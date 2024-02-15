---
title: Azure migration tools decision guide
description: Use this decision tree as high-level guidance for selecting the best tools to use for your Azure migrations based on your migration decisions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/14/2024
ms.topic: conceptual
ms.custom: internal, engagement-fy23, UpdateFrequency2
---

# Migration tools decision guide

The strategy and tools you use to migrate an application to Azure depend on your business motivations, technology strategies, timelines, and a deep understanding of the actual workload and assets (infrastructure, apps, and data) to migrate.

The following decision tree provides high-level guidance for selecting the best tools based on migration decisions. Treat this decision tree as a starting point.

The choice to replatform by using the platform as a service (PaaS) technology or rehost by using infrastructure as a service (IaaS) is driven by the balance between cost, time, existing technical debt, and long-term returns. IaaS is often the fastest path to the cloud because it requires the fewest changes to the workload. PaaS could require modifications to data structures or source code, but PaaS technology produces substantial long-term returns through reduced operating costs and greater technical flexibility.

In the following diagram, the term *modernize* reflects a decision to modernize an asset during migration and then migrate it to a PaaS platform.

![Example migration tools decision tree.](../../_images/migrate/migration-tools-decision-tree.png)

## Key questions

Answering the following questions allows you to decide based on the above tree.

- **Would modernization of the application platform during migration be a wise investment of time, energy, and budget?**
  Using PaaS technologies like Azure App Service or Azure Functions can enhance deployment flexibility and simplify management of application hosting on virtual machines. However, migrating applications to use these cloud-native capabilities might involve code refactoring, which can substantially increase the time and cost of migration. Applications that can transition to PaaS technologies with minimal modification are likely suitable for modernization. Conversely, migration using IaaS-based virtual machines might be more appropriate for applications that require extensive code refactoring.

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


## Application migration and modernization tools

Application migration and modernization tools help you move existing applications from on-premises or other cloud environments to Azure and optimize them for the cloud. These tools can save you time, effort, and cost by automating migration tasks such as code analysis, file creation, and deployment.

The right tools for your migration depend on your approach (replatform versus rehost), technology, architecture, and requirements. Choosing the right tools can help you achieve your migration goals faster and more efficiently. Many tools are available for application migration and modernization tasks. The following sections list some of the most common tools for replatforming and rehosting and highlight their main features.

### Tools for replatforming

*Replatforming* is the process of modifying existing application code to optimize it for a cloud environment without changing its external behavior. Follow these steps before replatforming an application:

- *Identify the target architecture*: Determine the target architecture for your application. The language, framework, or platform your application uses affects its cloud architecture. For example, Java and .NET applications each have different PaaS solutions available that can affect the workload architecture.
- *Assess the source code*: Ensure that the application's source code is readily available. You need to evaluate and potentially modify the code to fit the target architecture. If the source code isn't available or can't be modified, a rehost strategy is usually the only option. This involves migrating the application without any modifications.
- *Identify replatforming tools*: Use replatforming tools that suit your technology and target architecture. These tools can help in analyzing source code, creating necessary files, and accelerating migration activities (*see table*).

| Tool | Description | Vendor |
| ---- | ----------- | ------ |
| [Azure Draft](https://github.com/Azure/draft/) | A Microsoft tool for creating Kubernetes YAMLs, Helm charts, Docker files, and GitHub Actions from a codebase. | Microsoft |
| [Cloud Suitability Analyzer](https://github.com/vmware-tanzu/cloud-suitability-analyzer) | A VMWare tool that analyzes source code in many languages and provides insights on application cloud readiness. | VMWare |
| [AppCAT](/azure/developer/java/migration/appcat) | A Microsoft tool that analyzes Java source code and provides insights into what must be changed to target containers or other J2EE application servers. AppCAT is based on [Windup](https://windup.github.io/) but supports Azure targets. | Microsoft | 
| [move2kube](https://move2kube.konveyor.io/) | A Cloud Native Computing Foundation (CNCF) project tool for creating Docker files and YAML deployment files that accelerate migration activities. | CNCF project |
| [.NET Upgrade Assistant](/dotnet/core/porting/upgrade-assistant-overview) | A Microsoft tool that helps in migrating from .NET Framework code to .NET. | Microsoft |
| [App Service Migration Assistant](https://azure.microsoft.com/products/app-service/migration-tools/) | A Microsoft tool for .NET (and Java) migrations to Azure App Service. | Microsoft |
| [Azure Migrate App Containerization](/azure/migrate/tutorial-app-containerization-aspnet-kubernetes) | A Microsoft tool for containerizing .NET and Java applications. | Microsoft |

### Tools for rehosting

Rehosting an application when migrating to the cloud means moving the application from its existing hosting environment to a cloud-based virtual machine without any changes to the application code or configuration. Rehosting is the right approach when the application's source code isn't available or can't be modified, or when migration needs to be done quickly and with minimal effort.

You can use [Azure Migrate](/azure/migrate/migrate-overview) to rehost the application in Azure. Azure Migrate is a free service that you can use to assess and migrate applications, infrastructure, and data to Azure. Azure Migrate provides a central hub to track discovery, assessment, and migration of on-premises resources and cloud resources.

## Innovation and migration

In line with the Cloud Adoption Framework's emphasis on [incremental migration](../../migrate/index.md#migration-effort) efforts, an initial decision on migration strategy and tooling doesn't rule out future innovation efforts to update an application to take advantage of opportunities presented by the Azure platform. While an initial migration effort might focus primarily on rehosting using an IaaS approach, you should plan to revisit your cloud-hosted application portfolio regularly to investigate optimization opportunities.

## Learn more

- [Cloud fundamentals: Overview of Azure compute options](/azure/architecture/guide/technology-choices/compute-decision-tree): Provides information on the capabilities of Azure IaaS and PaaS compute options.
- [Cloud fundamentals: Choose the right data store](/azure/architecture/guide/technology-choices/data-store-overview): Discusses PaaS storage options available on the Azure platform.
- [Migration best practices: Data requirements exceed network capacity during a migration effort](../../migrate/azure-best-practices/network-capacity-exceeded.md): Discusses alternative data migration mechanisms for scenarios where data migration is hindered by available network bandwidth.
- [SQL Database: Choose the right SQL Server option in Azure](/azure/azure-sql/azure-sql-iaas-vs-paas-what-is-overview#business-motivations-for-choosing-databases-managed-instances-or-sql-virtual-machines): Discussion of the options and business justifications for choosing to host your SQL Server workloads in a managed infrastructure (IaaS) or a managed service (PaaS) environment.
