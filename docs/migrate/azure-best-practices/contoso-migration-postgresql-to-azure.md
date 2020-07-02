---
title: Migrating PostgreSQL to Microsoft Azure 
description: Learn how Contoso migrated their on-premises PostgreSQL databases to Azure.
author: deltadan
ms.author: abuck
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---

# Migrating PostgreSQL to Microsoft Azure scenario

This article demonstrates how a fictional company Contoso planned and migrated their on-premises PostgreSQL open source database platform to Azure.

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Big data:** Contoso uses PostgreSQL for several of their big data and AI initiatives, they'd like to be able to build scalable repeatable pipelines to automate many of these analytical workloads.
- **Increase efficiency:** Contoso needs to remove unnecessary procedures, and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, thus delivering quicker on customer requirements.
- **Increase agility:** Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes in the marketplace, to enable the success in a global economy. It mustn't get in the way, or become a business blocker.
- **Scale:** As the business grows successfully, Contoso IT must provide systems that are able to grow at the same pace.
- **Increased security:** Contoso realizes that regulatory issues will cause them to adjust their on-premises strategy based on auditing, logging and compliance requirements.

## Migration goals

The Contoso cloud team has pinned down goals for this migration and will use them to determine the best migration method.

<!-- markdownlint-disable MD033 -->

| Requirements | Details |
| --- | --- |
| **Upgrades** | Contoso would like to ensure that they have the latest patches installed when available but do not want to manage these updates. |
| **Integrations** | Contoso would like to integrate the data in the database with data and AI pipelines for Machine Learning. |
| **Backup and restore** | Contoso is looking for the ability to do point in time restores when and if data updates fail or are corrupted for any reason. |
| **Azure** | They would like to be able to monitor the system and fire alerts based on performance and security |
| **Performance** | In some cases they will have parallel data processing pipelines in different geographic regions and will need to be able to read data from those regions. |

<!-- markdownlint-enable MD033 -->

## Solution design

After pinning down goals and requirements, Contoso designs and review a deployment solution, and identifies the migration process, including the tools and services that they will use for migration.

### Current environment

- PostgreSQL 9.6.7 running on a physical Linux machine (`sql-pg-01.contoso.com`) in the Contoso datacenter.
- Contoso already has an Azure subscription with a site-to-site virtual network gateway to on-premises datacenter network.

### Proposed solution

- Use the Azure Database Migration Service to migrate the database to an Azure Database for PostgreSQL instance.
- Modify all applications and processes to use the new Azure Database for PostgreSQL instance.
- Build new data processing pipeline using Azure Data Factory that connect to the Azure Database for PostgreSQL instance.

### Database considerations

As part of the solution design process, Contoso reviewed the features in Azure for hosting their PostgreSQL data. The following considerations helped them decide to use Azure.

- Similar to Azure SQL Database, Azure Database for PostgreSQL supports firewall rules.
- Azure Database for PostgreSQL can be used with virtual networks to prevent the instance from being publicly accessible.
- Azure Database for PostgreSQL has the required compliance certifications that Contoso must meet.
- Integration with DevOps and Azure Data Factory will allow for automated data processing pipelines to be built.
- Processing performance can be enhanced by using read replicas.
- Support for bring your own key (BYOK) for data encryption.
- Ability to expose the service to internal network traffic only (no-public access) using Private Link.
- The [bandwidth and latency](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways) from the application to the database will be sufficient enough based on the chosen gateway (either ExpressRoute or site-to-site VPN).

### Solution review

Contoso evaluates their proposed design by putting together a pros and cons list.

<!-- markdownlint-disable MD033 -->

| Consideration | Details |
|--- | --- |
| **Pros** | All currently required and in-use features are available in Azure Database for PostgreSQL. <br><br> |
| **Cons** | Contoso will still need to do manual migration from major version of PostgreSQL. |

<!-- markdownlint-enable MD033 -->

## Proposed architecture

![Scenario architecture](./media/contoso-migration-postgresql-to-azure/architecture.png)
_Figure 1: Scenario architecture._

### Migration process

#### Preparation

Before you can migrate your PostgreSQL databases, ensure that those instances meet all the Azure prerequisites for a successful migration.

#### Supported versions

Only migrations to the same or a higher version are supported. For example, migrating PostgreSQL 9.5 to Azure Database for PostgreSQL 9.6 or 10 is supported, but migrating from PostgreSQL 11 to PostgreSQL 9.6 isn't supported.

Microsoft aims to support _n-2_ versions of the PostgreSQL engine in Azure Database for PostgreSQL - single server. The versions would be the current major version on Azure (_n_) and the two prior major versions (_-2_).

For the latest updates on supported versions [see here](https://docs.microsoft.com/azure/postgresql/concepts-supported-versions).

> [!NOTE]
> Automatic major version upgrade is not supported. For example, there is no automatic upgrade from PostgreSQL 9.5 to PostgreSQL 9.6. To upgrade to the next major version, dump the database and restore it to a server created with the target engine version.

#### Network

Contoso will need to set up a virtual network gateway connection from their on-premises environment to the virtual network where their Azure Database for PostgreSQL database is located. This allows the on-premises application to access the database but not be migrated to the cloud.

#### Assessment

Contoso will need to assess the current database for replication issues. These issues include:

- The source database version is compatible for migration to the target database version
- Ensure primary keys exist on all tables to be replicated.
- Database names can't include a semi-colon(;)
- Migration of multiple tables with same name but different case may cause unpredictable behavior

  ![Migration process](./media/contoso-migration-postgresql-to-azure/migration-process.png)
  _Figure 2: The migration process._

#### Migration

Contoso can perform the migration in several ways including:

- [Dump and restore](https://docs.microsoft.com/azure/postgresql/howto-migrate-using-dump-and-restore)
  
- [Azure Database Migration Service](https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online)
  
- [Import/export](https://docs.microsoft.com/azure/postgresql/howto-migrate-using-export-and-import)

Contoso has selected the Azure Database Migration Service to allow them to reuse the migration project whenever they need to perform major-to-major upgrades. Because a single Database Migration Service migration activity only accommodates up to four databases, Contoso sets up several jobs using these steps:

- Preparation:
  
  - Set up a virtual network (VNet) to access the database. You can create a VNet connection using [VPN gateways](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways) in various ways.

  - Create a Database Migration Service resource:
    - In the [Azure portal](https://portal.azure.com), select **Add a resource**.
    - Search for **Azure Database Migration Services** and select it.
    - Select **+ Add**.
    - Select the subscription and resource group for the service.
    - Type a name for the service.
    - Select the closest location to your datacenter or VPN gateway.
    - Select **Azure** for the service mode.
    - Select a pricing tier.
    - Select **Review + create**.

      ![Migration process](./media/contoso-migration-postgresql-to-azure/azure_migration_service_create.png)
      _Figure 3: Review and create._

    - Select **Create**.

  - Create an Azure Database for PostgreSQL instance.

  - On the on-premises server, configure the `postgresql.conf` file.

    - Set the server to listen on the proper IP address that the Database Migration Service will use to access the server and databases.
      - Set the `listen_addresses` variable.
    - Enable SSL.
      - Set the `ssl=on` variable.
      - Verify that you're using a publicly signed SSL certificate for the server that supports tls 1.2. Otherwise, the Database Migration Service tool will raise an error.
    - Update the `pg_hba.conf` file.
      - Add entries that are specific to the Database Migration Service service.
    - Logical replication must be enabled on the source server by modified the values in the `postgresql.conf` file for each server.
      - `wal_level` = `logical`
      - `max_replication_slots` = [at least the maximum number of databases for migration]
        - For example, if you want to migrate four databases, set the value to 4.
      - `max_wal_senders` = [number of databases running concurrently]
        - The recommended value is 10.
  
  - Migration `User` must have the `REPLICATION` role on the source database.
  
  - Add the Database Migration Service IP address to the `PostgreSQLpg_hba.conf` file.
  
  - Export the database schemas.

    - Run the following commands:

    ```cmd
    pg_dump -U postgres -s dvdrental > dvdrental_schema.sql
    ```

    - Copy the file, name the copy `dvdrental_schema_foreign.sql`, remove all non-foreign key and trigger-related items.
    - Remove all foreign key and trigger-related items from the `dvdrental_schema.sql` file.

- Import the database schema (step 1):

  ```cmd
    psql -h {host}.postgres.database.azure.com -d dvdrental -U username -f dvdrental_schema.sql
    ```

- Migration:

  - In the Azure portal, navigate to your Database Migration Service resource.
  - If the service is not started, select **Start Service**.
  - Select **New Migration Project**.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_new_project.png)
    _Figure 4: Starting a new migration._

  - Select **New Activity** > **Online data migration**.
  - Type a name.
  - Select **PostgreSQL** as the source.
  - For the target, select **Azure Database for PostgreSQL**. ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_new_project02.png)
    _Figure 5: A new migration project is highlighted._

  - Select **Save**.
  - Enter the source information.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_source.png)
    _Figure 6: Entering source information._

  - Select **Save**.
  - Enter the target information.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_target.png)
    _Figure 7: Selecting target information._

  - Select **Save**.
  - Select the databases you would like to migrate. The schema for each database should have been migrated previously.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_db.png)
    _Figure 8: Selecting databases._

  - Select **Save**.
  - Configure the advanced settings.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_advanced.png)
    _Figure 9: Configuring advanced settings._

  - Select **Save**.
  - Give the activity a name and select **Run**.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_summary.png)
    _Figure 10: Naming and running the activity._

  - Monitor the migration. You may need to retry it if anything fails (for example, if foreign key references were missing).
  - Once the `Full load completed` matches your table count, select **Start Cutover**.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_complete.png)
    _Figure 11: Monitoring the migration to start the cutover._

  - Stop all transactions from the source server.
  - Select the **Confirm** checkbox, then select **Apply**.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_cutover.png)
    _Figure 12: Running the cutover._

  - Wait for the cutover to complete.

    ![New migration project is highlighted](./media/contoso-migration-postgresql-to-azure/azure_migration_service_finished.png)
    _Figure 13: Completing the cutover._

  > [!NOTE]
  > The above Database Migration Service steps can also be performed via the [Azure CLI](https://docs.microsoft.com/azure/dms/tutorial-postgresql-azure-postgresql-online).

- Import the database schema (step 2):

  ```cmd
    psql -h {host}.postgres.database.azure.com -d dvdrental -U username -f dvdrental_schema_foreign.sql
    ```

- Reconfigure any applications or processes that use the on-premises database to point to the new Azure Database for PostgreSQL database instance.

- Post-migration

  - Once the migration is complete, ensure that you have also set up cross-region read replicas if required.

## Clean up after migration

After migration, Contoso needs to complete these cleanup steps:

- Backup the on-premises database for retention purposes
- Retire the old PostgreSQL server

## Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure their new infrastructure.

### Security

- Contoso needs to ensure that their new Azure Database for PostgreSQL instance and databases are secure. [Learn more](https://docs.microsoft.com/azure/postgresql/concepts-security).
- In particular, Contoso should review the [firewall](https://docs.microsoft.com/azure/postgresql/concepts-firewall-rules) and virtual network configurations you limit connections to only the applications that require it.
- Implement [bring your own key (BYOK)](https://docs.microsoft.com/azure/postgresql/concepts-data-encryption-postgresql) for data encryption.
- Update all applications to [require SSL](https://docs.microsoft.com/azure/postgresql/concepts-ssl-connection-security) connections to the databases.
- Setup [Private Link](https://docs.microsoft.com/azure/postgresql/concepts-data-access-and-security-private-link) so that all database traffic is kept inside Azure and the on-premises network.
- Enable [Azure Advanced Threat Protection (ATP)](https://docs.microsoft.com/azure/postgresql/concepts-data-access-and-security-threat-protection).
- Configure Log Analytics to monitor and alert on security and logs entries of interest.

### Backups

- Ensure that the Azure Database for PostgreSQL databases are backed up using geo-restore. This allows backups to be used in a paired region in case of a regional outage.
- **Important:** Ensure that the Azure Database for PostgreSQL resource has a resource lock to prevent it from being deleted. Deleted servers cannot be restored.

### Licensing and cost optimization

- Azure Database for PostgreSQL can be scaled up or down, therefore performance monitoring of the server and databases is important to ensure you're meeting your needs but also keeping costs at a minimum.
- Both CPU and storage have costs associated. There are several pricing tiers to select from. Be sure the appropriate pricing plan is selected for the data workloads.
- Each read replicas is billed based on the compute and storage selected

## Conclusion

In this article, Contoso migrated their PostgreSQL databases to an Azure Database for PostgreSQL managed instance.
