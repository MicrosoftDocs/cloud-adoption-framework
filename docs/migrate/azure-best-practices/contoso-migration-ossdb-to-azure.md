---
title: "Migrating Open Source Databases to Azure (Scenario)"
description: Learn how Contoso migrates their on-premises Open Source Databases to Azure
author: deltadan
ms.author: abuck
ms.date: 05/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---
# Migrating Open Source Databases to Azure (Scenario)

This article demonstrates how a fictional company Contoso assessed, planned and migrated their various on-premises open source databases to Azure.

As Contoso considers migrating to Azure, the company needs a technical and financial assessment to determine whether its on-premises workloads are good candidates for cloud migration. In particular, the Contoso team wants to assess machine and database compatibility for migration.  Additionally, it wants to estimate capacity and costs for running Contoso's resources in Azure.

## Business drivers

Contoso is having various issues with maintaining all the wide array of versions of open source database workloads that exist on their network. After the latest investor's meeting, the CFO and CTO have made the decision to move all these workloads to Azure. This will allow them to shift from a structured capital expense model to a fluid operating expense model.

The IT leadership team has worked closely with business partners to understand the business and technical requirements:

- **Increase security** Contoso needs to be able to monitor and protect all data resources in a more timely and efficient manner.  They would also like to get a more centralized reporting system setup on database access patterns.

- **Optimize compute resources** Contoso has deployed a large on-premises server infrastructure. They have several SQL Server instances that consume but do not really use the underlying CPU, Memory and Disk allocated in efficient ways.

- **Increase efficiency** Contoso needs to remove unnecessary procedures, and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, thus delivering faster on customer requirements. Database administration should be reduced and/or minimized after the migration.

- **Increase agility**  Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes in the marketplace, to enable the success in a global economy. It mustn't get in the way, or become a business blocker.

- **Scale** As the business grows successfully, Contoso IT must provide systems that are able to grow at the same pace.

- **Costs** Business and applications owners want to know they won't be stuck with high cloud costs as compared to running the applications on-premises.

## Migration goals

The Contoso cloud team has pinned down goals for the various migrations. These goals were used to determine the best migration methods.

<!-- markdownlint-disable MD033 -->

**Requirements** | **Details**
--- | ---
**Performance** | After migration, apps in Azure should have the same performance capabilities that apps have today in Contoso's on-premises environment. Moving to the cloud doesn't mean that app performance is less critical.
**Compatibility** | Contoso needs to understand the compatibility of its applications and databases with Azure. Contoso also needs to understand its Azure hosting options.
**Data sources** | All databases will be moved to Azure with no exceptions.  Based on the database and application analysis of the SQL features being used, they will move to PaaS or IaaS. All databases must move.
**App** | Apps will need to be moved to the cloud where possible. If they cannot move, then they will be allowed to connect to the migrated database over the Azure network through private connections only.
**Costs** | Contoso wants to understand not only its migration options, but also the costs associated with the infrastructure after it moves to the cloud.
**Management** | Resource Management groups will need to be created for the various departments along with Resource Groups to managed all databases that are migrated. All resources will need to be tagged with department information for charge-back requirements.
**Limitations** | Initially, not all branch offices that run applications will have a direct ExpressRoute link to Azure, so these offices will need to connect through Virtual Network Gateways.

<!-- markdownlint-enable MD033 -->

## Solution design

Contoso has already performed a [migration assessment](https://docs.microsoft.com//azure/cloud-adoption-framework/plan/contoso-migration-assessment) of their digital estate using [Azure Migrate](https://docs.microsoft.com//azure/migrate/migrate-services-overview) with the [Service Map](https://docs.microsoft.com//azure/azure-monitor/insights/service-map) feature.

![Migration process](./media/contoso-migration-ossdb-to-azure/migration-process.png)

### Solution Review

Contoso evaluates their proposed design by putting together a pros and cons list.

**Consideration** | **Details**
--- | ---
**Pros** | Azure will provide a single pane of glass into the database workloads<br/><br/>Costs will be monitored via Cost Management<br/><br/>Business charge-back billing will be easy to perform with the Billing API<br/><br/>Server and software maintenance will be reduced to only the IaaS based environments.
**Cons** | Due to the requirement of IaaS-based Virtual Machines, there will still need to be management of the software on those machines.

### Budget and Management

Before the migration can occur, the necessary Azure structure is required to be in place to support the administration and billing aspects of the solution.

For the management requirements, several [management groups](https://docs.microsoft.com/azure/governance/management-groups/overview) were created to support the organizational structure.

For the billing requirements, each of the Azure Resources are then [tagged](https://docs.microsoft.com/azure/azure-resource-manager/management/tag-resources) with the appropriate billing tags.

### Migration Process

Data migrations follow a standard repeatable pattern.  This involves the following steps based on [Microsoft best practices](https://datamigration.microsoft.com/):

- Pre-migration
  - Discovery - Inventory database assets and application stack
  - Assess - Assess workloads and fix recommendations
  - Convert - Convert source schema to work in the target
- Migration
  - Migrate - Migrate the source schema, source data and objects to target
  - Sync Data - Sync Data (for minimal downtime)
  - Cutover - Cut over the source to target
- Post-migration
  - Remediate Applications - Iteratively make and necessary changes to your applications
  - Perform Tests - Iteratively run functional and performance tests
  - Optimize - Based on tests, address performance issues and then retest to confirm performance improvements
  - Retire Assets - Old VMs and hosting environments are backed up and retired

#### Step 1 - Discovery


Contoso utilized Azure Migrate with the Service Map to surface the dependencies across the Contoso environment. Azure Migrate automatically discovered application components on Windows and Linux systems and mapped the communication between services. Using the Service Map feature of Azure Migrate they surfaced the connections between Contoso servers, processes, inbound and outbound connection latency, and ports across their TCP-connected architecture.  Contoso was only required to install the [Microsoft Monitoring Agent](https://docs.microsoft.com/azure/log-analytics/log-analytics-agent-windows) and [Microsoft Dependency](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-enable-hybrid-cloud#install-the-dependency-agent-on-windows) agents.

With the Azure Migration, Contoso has identified over 300 database instances that must be migrated.  Of these instances, roughly 40% can be moved to PaaS based services. Of the remaining 60%, they must be moved to an IaaS-based approach with a Virtual Machine running the respective database software.

#### Step 2 - Application Assessment

The results from the assessment provided Contoso with the visibility that they utilizes primarily Java, PHP and NodeJS applications. They have identified the following:

- 100 Java applications
- ~50 NodeJS applications
- ~25 PHP applications

#### Step 3- Database Assessment

As the databases were inventoried each type of database was reviewed to determine the method to migrate it to Azure. The following guidelines were followed on the database migrations.

**Database Type** | **Details** | **Target** | **Migration Guide**
| --- | --- | --- | --- |
**MySQL** | All supported versions, upgrade to a supported version before migration | MySQL Database for Azure (Paas) | [Guide](https://docs.microsoft.com/azure/dms/tutorial-mysql-azure-mysql-online)
**PostgreSQL** | All supported versions, upgrade to a supported version before migration | PostgreSQL Database for Azure (PaaS) | [Guide](https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online)
**MariaDB** | All supported versions, upgrade to a supported version before migration | MariaDB Database for Azure (PaaS) | [Guide](https://datamigration.microsoft.com/scenario/mariadb-to-azuremariadb?step=1)

<!-- markdownlint-enable MD033 -->

#### Step 4 - Migration Planning

Due to the large number of databases, Contoso setup a project management office (PMO) to keep track of every database migration instance. [Accountability and responsibilities](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/migration-considerations/assess/) were assigned to each business and application team.

Contoso also performed a [workload readiness review](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/migration-considerations/assess/evaluate). This review examined the infrastructure, database and network components.

#### Step 5 - Test Migrations

The first part of the migration preparation involved a test migration of each of the databases to the pre-setup environments. In order to save time, they scripted all of the operations for the migrations and recorded the timings for each.  In order to speed up the migration, they identified what migration operations could be run concurrently.

Any rollback procedures were identified for each of the database workloads in case of some unexpected failures.

For the IaaS-based workloads, they pre-setup all the required 3rd party software.

After the test migration, Contoso was able to utilize the various Azure [cost estimation tools](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/migration-considerations/assess/estimate) to get a more accurate picture of the future operational costs of their migration.

#### Step 6 - Migration

For the production migration, Contoso identified the time-frames for all database migrations and what could be sufficiently executed in a weekend window (midnight Friday through midnight Sunday) with minimal downtime to the business.

### Clean up after migration

Contoso identified the archival window for all database workloads.  As the window expires, the resources will be de-allocated from the on-premises infrastructure.

This would include:

- Remove the production data from on-premises servers
- Retire the hosting server when the last workload window expires

### Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure their new infrastructure.

#### Security

- Contoso needs to ensure that their new Azure database workloads are secure. [Learn more](https://docs.microsoft.com/azure/sql-database/sql-database-security-overview).
- In particular, Contoso should review the Firewall and virtual network configurations.
- Setup Private Link so that all database traffic is kept inside Azure and the on-premises network
- Enable Advanced Thread Protection (ATP)

#### Backups

- Ensure that the Azure databases are backed up using geo-restore.  This allows backups to be used in a paired region in case of a regional outage.
- **Important** Ensure that the Azure server resource has a [resource lock](https://docs.microsoft.com/azure/azure-resource-manager/management/lock-resources) to prevent it from being deleted.  Deleted servers cannot be restored.

#### Licensing and cost optimization

- Many Azure database workloads can be scaled up or down, therefore performance monitoring of the server and databases is important to ensure you are meeting your needs but also keeping costs at a minimum.
- Both CPU and Storage have costs associated. There are several pricing tiers to select from.  Be sure the appropriate pricing plan is selected for the data workloads.
- Each read replica is billed based on the compute and storage selected
- Utilize reserved capacity to save on costs

## Conclusion

In this article, Contoso assessed, planned and migrated their open source databases to Azure PaaS and IaaS solutions.
