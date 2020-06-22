---
title: "Migrating PostgreSQL to Azure (Scenario)"
description: Learn how Contoso migrates their on-premises PostgreSQL Databases to Azure
author: deltadan
ms.author: abuck
ms.date: 05/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

# Migrating PostgreSQL to Azure (Scenario)

This article demonstrates how a fictional company Contoso planned and migrated their on-premises PostgreSQL open source database platform to Azure.

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Big data** - Contoso uses PostgreSQL for several of their Big Data and AI initiatives, they'd like to be able to build scalable repeatable pipelines to automate many of these analytical workloads.
- **Increase efficiency** - Contoso needs to remove unnecessary procedures, and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, thus delivering quicker on customer requirements.
- **Increase agility** - Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes in the marketplace, to enable the success in a global economy. It mustn't get in the way, or become a business blocker.
- **Scale** - As the business grows successfully, Contoso IT must provide systems that are able to grow at the same pace.
- **Increased security** - Contoso realizes that regulatory issues will cause them to adjust their on-premises strategy based on auditing, logging and compliance requirements.

## Migration goals

The Contoso cloud team has pinned down goals for this migration and will use them to determine the best migration method.

**Requirements** | **Details**
--- | ---
**Upgrades** | Contoso would like to ensure that they have the latest patches installed when available but do not want to manage these updates.
**Integrations** | Contoso would like to integrate the data in the database with Data and AI pipelines for Machine Learning.
**Backup and restore** | Contoso is looking for the ability to do point in time restores when and if data updates fail or are corrupted for any reason.
**Azure** | They would like to be able to monitor the system and fire alerts based on performance and security
**Performance** | In some cases they will have parallel data processing pipelines in different geographic regions and will need to be able to read data from those regions.

## Solution design

After pinning down goals and requirements, Contoso designs and review a deployment solution, and identifies the migration process, including the tools and services that they will use for migration.

### Current environment

- PostgreSQL 9.6.7 running on a physical linux machine (sql-pg-01.contoso.com) in the Contoso data center
- Contoso already has an Azure subscription with a site-to-site virtual network gateway to on-premises data center network

### Proposed solution

- Use the Azure Data Migration Service (DMS) to migrate the database to PostgreSQL for Azure instance
- Modify all applications and processes to utilize the new PostgreSQL for Azure instance
- Build new data processing pipeline using Azure Data Factory (ADF) that connect to the PostgreSQL for Azure instance

### Database considerations

As part of the solution design process Contoso did a review of the features in Azure for hosting their PostgreSQL data.  The following considerations helped them decide to utilize Azure.

- Similar to Azure SQL, Azure PostgreSQL allows for firewall rules
- Azure PostgreSQL can be utilize with Virtual networks to prevent the instance from being publicly accessible
- Azure PostgreSQL has the required compliance certifications that Contoso must meet
- Integration with DevOps and Azure Data Factory will allow for automated data processing pipelines to be built.
- Processing performance can be enhanced by utilizing read replicas
- Support for Bring-Your-Own-Key (BYOK) for data encryption
- Ability to expose the service to internal network traffic only (no-public access) using Private Link
- The [bandwidth and latency](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways) from the application to the database will be sufficient enough based on the chosen gateway (either ExpressRoute or Site-To-Site VPN)

### Solution review

Contoso evaluates their proposed design by putting together a pros and cons list.

**Consideration** | **Details**
--- | ---
**Pros** | All currently required and in use features are available in Azure PostgreSQL.<br/><br/>
**Cons** | Contoso will still need to do manual migration from major version of PostgreSQL.

## Proposed architecture

![Scenario architecture](./media/contoso-migration-postgresql-to-azure/architecture.png)

### Migration process

#### Preparation

Before you can migrate your PostgreSQL databases, you will need to ensure that those instances meet all the Azure pre-requisites for a successful migration.

#### Supported Versions

Only migrations to the same or a higher version are supported. For example, migrating PostgreSQL 9.5 to Azure Database for PostgreSQL 9.6 or 10 is supported, but migrating from PostgreSQL 11 to PostgreSQL 9.6 isn't supported.

Microsoft aims to support n-2 versions of the PostgreSQL engine in Azure Database for PostgreSQL - Single Server. The versions would be the current major version on Azure (n) and the two prior major versions (-2).

For the latest updates on supported versions [see here](https://docs.microsoft.com/azure/postgresql/concepts-supported-versions).

> **NOTE** Automatic major version upgrade is not supported. For example, there is not an automatic upgrade from PostgreSQL 9.5 to PostgreSQL 9.6. To upgrade to the next major version, take a database dump and restore it to a server created with the target engine version.

#### Network

Contoso will need to setup a Virtual Network Gateway connection from their on-premises environment to the Virtual Network where their Azure Database for PostgreSQL database is located.  This will allow the on-premises application to be able to access the database but not be migrated to the cloud.

#### Assessment

Contoso will need to assess the current database for replication issues.  These would include:

- The source database version is compatible for migration to the target database version
- Ensure primary keys exist on all tables to be replicated.
- Database names can't include a semi-colon(;)
- Migration of multiple tables with same name but different case may cause unpredictable behavior

  ![Migration process](./media/contoso-migration-postgresql-to-azure/migration-process.png)

#### Migration

Contoso can perform the migration in several ways including:

- Dump and Restore - https://docs.microsoft.com/azure/postgresql/howto-migrate-using-dump-and-restore
  
- Azure Data Migration Service (DMS) - https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online
  
- Import / Export - https://docs.microsoft.com/azure/postgresql/howto-migrate-using-export-and-import

Contoso has chosen to use the Azure Data Migration Service as it will allow them to reuse the migration project for when they need to perform major to major upgrades. A single DMS migration activity only accommodates up to four databases, Contoso setup several jobs using these steps:

- Preparation
  
  - Setup a Virtual Network to access the database

    - You can create a VNet connection using [VPN Gateways](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways) in various ways

  - Create a Data Migration Service (DMS) resource
    - Open your [Azure Portal](https://portal.azure.com)
    - Select **Add a resource**
    - Search for **Azure data migration service**, select it
    - Select **Create**
    - Select the subscription and resource group
    - Type a name for the service
    - Select a location that is closest to your data center or VPN Gateway
    - Select **Azure** for the service mode
    - Select a pricing tier
    - Select **Review + create**

      ![Migration process](./media/contoso-migration-postgresql-to-azure/azure_migration_service_create.png)

    - Select **Create**

  - Create an Azure Database for PostgreSQL instance

  - On the on-premises server(s), configure the `postgresql.conf` file

    - Set the server to listen on the proper IP address that DMS will use to access the server and databases
      - Set the `listen_addresses` variable
    - Enable SSL
      - Set the `ssl=on` variable
      - Make sure that you are using a publicly signed SSL certificate for the server that supports TLS 1.2, otherwise the DMS tool will error
    - Update the `pg_hba.conf` file
      - Add entries that are specific to the DMS service
    - Logical replication must be enabled on the source server by modified the values in the `postgresql.conf` file for each server
      - `wal_level` = logical
      - `max_replication_slots` = [at least max number of databases for migration]; if you want to migrate four databases, set the value to 4.
      - `max_wal_senders` = [number of databases running concurrently]; the recommended value is 10
  
  - Migration `User` must have the REPLICATION role on the source database
  
  - Add the DMS IP address to the `PostgreSQLpg_hba.conf` file
  
  - Export the database schema(s)

    - Run the following commands

    ```cmd
    pg_dump -U postgres -s dvdrental > dvdrental_schema.sql
    ```

    - Copy the file, name the copy dvdrental_schema_foreign.sql, remove all non-foreign key and trigger related items
    - Remove all foreign key and trigger related items from the dvdrental_schema.file

- Import the database schema (Step 1)
  
    ```cmd
    psql -h {host}.postgres.database.azure.com -d dvdrental -U username -f dvdrental_schema.sql
    ```

- Migration

  - Switch to your Azure Portal, navigation to your DMS resource
  - If not started, select **Start Service**
  - Select **New Migration Project**

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_new_project.png)

  - Select **New Activity -> Online data migration**
  - Type a name
  - Select **PostgreSQL** as the source
  - For the target, select **Azure Database for PostgreSQL**
  
    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_new_project02.png)

  - Select **Save**
  - Enter the source information

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_source.png)

  - Select **Save**
  - Enter the target information
  
    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_target.png)

  - Select **Save**
  - Select the database(s) you would like to migrate.  Each should have had their schema's migrated previously

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_db.png)

  - Select **Save**
  - Configure the advanced settings

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_advanced.png)

  - Select **Save**
  - Give the activity a name, select **Run**

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_summary.png)

  - Monitor the migration, you may need to re-try it if anything fails (such as your forgot foreign key references, etc)
  - Once the `Full load completed` matches your table count, select **Start Cutover**

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_complete.png)

  - Stop all transactions from the source server
  - Select the **Confirm** checkbox, then select **Apply**

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_cutover.png)

  - Wait for the cutover to complete

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_finished.png)

  > **Note** The above DMS steps can also be performed via [Azure Cli](https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online)

- Import the database schema (Step 2)
  
    ```cmd
    psql -h {host}.postgres.database.azure.com -d dvdrental -U username -f dvdrental_schema_foreign.sql
    ```

- Reconfigure any applications or processes that were using the on-premises database to point to the new Azure PostgreSQL database instance.

- Post Migration

  - Once the migration has been completed, you will need to ensure that you have also setup cross region read replicas if you require them

## Clean up after migration

After migration, Contoso needs to complete these cleanup steps:

- Backup the on-premises database for retention purposes
- Retire the old PostgreSQL server

## Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure their new infrastructure.

### Security

- Contoso needs to ensure that their new Azure PostgreSQL instance and databases are secure. [Learn more](https://docs.microsoft.com/azure/postgresql/concepts-security).
- In particular, Contoso should review the [Firewall](https://docs.microsoft.com/azure/postgresql/concepts-firewall-rules)  and virtual network configurations you limit connections to only the applications that require it.
- Implement [Bring-Your-Own-Key (BYOK)](https://docs.microsoft.com/azure/postgresql/concepts-data-encryption-postgresql) for data encryption
- Update all applications to [require SSL](https://docs.microsoft.com/azure/postgresql/concepts-ssl-connection-security) connections to the databases
- Setup [Private Link](https://docs.microsoft.com/azure/postgresql/concepts-data-access-and-security-private-link) so that all database traffic is kept inside Azure and the on-premises network
- Enable [Advanced Thread Protection (ATP)](https://docs.microsoft.com/azure/postgresql/concepts-data-access-and-security-threat-protection)
- Configure log analytics to monitor and alert on security and logs entries of interest

### Backups

- Ensure that the Azure PostgreSQL databases are backed up using geo-restore.  This allows backups to be used in a paired region in case of a regional outage.
- **Important** Ensure that the Azure PostgreSQL server resource has a resource lock to prevent it from being deleted.  Deleted servers cannot be restored.

### Licensing and cost optimization

- Azure PostgreSQL can be scaled up or down, therefore performance monitoring of the server and databases is important to ensure you are meeting your needs but also keeping costs at a minimum.
- Both CPU and Storage have costs associated. There are several pricing tiers to select from.  Be sure the appropriate pricing plan is selected for the data workloads.
- Each read replicas is billed based on the compute and storage selected

## Conclusion

In this article, Contoso migrated their PostgreSQL databases to an Azure PostgreSQL managed instance.
