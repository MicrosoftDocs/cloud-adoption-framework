---
title: "Migrating MariaDB to Azure (Scenario)"
description: Learn how Contoso migrates their on-premises MariaDB Databases to Azure
author: deltadan
ms.author: abuck
ms.date: 05/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
services: azure-migrate
---
# Migrating MariaDB to Azure (Scenario)

This article demonstrates how a fictional company Contoso planned and migrated their on-premises MariaDB open source database platform to Azure.  

Contoso is using MariaDB over MySQL due to its myriad of storage engines, cache and index performance, open source support with features and extensions, and its Analytics ColumnStore support. Their goal in migrating is to continue to utilize MariaDB, but not worry about managing the environment needed to support it.

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Increase Availability.** Contoso has had availability issues with their MariaDB on-premises environment, the business requires the applications that utilize this data store to be more reliable.

- **Increase efficiency.** Contoso needs to remove unnecessary procedures, and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, thus delivering faster on customer requirements.

- **Increase agility.**  Contoso IT needs to be more responsive to the needs of the business. It must be able to react faster than the changes in the marketplace, to enable the success in a global economy. It mustn't get in the way, or become a business blocker.

- **Scale.** As the business grows successfully, Contoso IT must provide systems that are able to grow at the same pace.

## Migration goals

The Contoso cloud team has pinned down goals for this migration and will use them to determine the best migration method.

**Requirements** | **Details**
--- | ---
**Availability** | Currently internal staff are having a hard time with the hosting environment for the MariaDB instance. Contoso would like to have as close to 99.99% availability for the database layer.
**Scalability** | The on-premises database host is quickly running out of capacity, Contoso needs a way to scale their instances past their current limitations or scale it down if the business environment changes to save on costs.
**Performance** | Contoso HR have several reports they run on a daily, weekly and monthly basis.  When they run these reports, they notice considerable performance issues with the LAMP app.  They need to be able to run the reports without affecting the employee facing application.
**Security** | Contoso needs to know that the database will only be accessible to their internal applications and not visible or accessible via the internet.
**Monitoring** | Contoso currently uses tools to monitor the metrics of the MariaDB and provide notifications when CPU, Memory or storage are having issues.  They would like to have this same capability in Azure.
**Business Continuity** | The HR application data store is an important part of Contoso's daily operations and if it were to become corrupted or need to be restored they would like as minimum of downtime as possible.
**Azure** | Contoso wants to move the app to Azure, but doesn't want to run it on VMs. Contoso requirements state to use Azure PaaS services for the data tier.

## Solution design

After pinning down goals and requirements, Contoso designs and review a deployment solution, and identifies the migration process, including the tools and services that they will use for migration.

### Current app

- The MariaDB hosts employee data that is used for all aspects of the companies Human Resources (HR) department. A LAMP (Linux, Apache, MySQL/MariaDB, PHP/Perl/Python) application is used as the front end to handle employee HR requests.
- Contoso has 100K employees located all over the world, so uptime is very important for their databases.

### Proposed solution

- Evaluate the environments for migration compatibility.
- Utilize common open source tools to migrate the database(s) to MariaDB for Azure instance.
- Modify all applications and processes to utilize the new MariaDB for Azure instance.

### Database considerations

As part of the solution design process Contoso did a review of the features in Azure for hosting their MariaDB data.  The following considerations helped them decide to utilize Azure.

- Similar to Azure SQL, Azure MariaDB allows for [firewall rules](https://docs.microsoft.com/azure/mariadb/concepts-firewall-rules).
- Azure MariaDB can be utilized with [Virtual Networks](https://docs.microsoft.com/azure/mariadb/concepts-data-access-security-vnet) to prevent the instance from being publicly accessible
- Azure MariaDB has the required compliance and privacy certifications that Contoso must meet for their auditors.
- Report and application processing performance will be enhanced by utilizing read replicas.
- Ability to expose the service to internal network traffic only (no-public access) using [Private Link](https://docs.microsoft.com/azure/mariadb/concepts-data-access-security-private-link).
- They chose not to move to Azure Database for MySQL as they are looking at potentially using the MariDB ColumnStore and GraphDBMS database model in the future.
- The [bandwidth and latency](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways) from the application to the database will be sufficient enough based on the chosen gateway (either ExpressRoute or Site-To-Site VPN).

### Solution review

Contoso evaluates their proposed design by putting together a pros and cons list.

<!-- markdownlint-disable MD033 -->

**Consideration** | **Details**
--- | ---
**Pros** | Azure Database for MariaDB offers a 99.99% financially backed service level agreement (SLA) for [high availability](https://docs.microsoft.com/azure/mariadb/concepts-high-availability).<br/><br/>Azure offers the ability to scale up or down during peak load times each quarter.  Contoso can save even more buy purchasing [reserved capacity](https://docs.microsoft.com/azure/mariadb/concept-reserved-pricing).<br/><br/>Azure provides Point-in-time restore and Geo-restore capabilities for Azure Database for MariaDB.<br/><br/>
**Cons** | Contoso is limited to the MariaDB release versions that are supported in Azure which are currently 10.2 and 10.3.<br/><br/>Azure Database for MariaDB does have some [limitations](https://docs.microsoft.com/azure/mariadb/concepts-limits) such as scaling down storage.

## Proposed architecture

![Scenario architecture](./media/contoso-migration-mariadb-to-azure/architecture.png)

### Migration process

#### Preparation

Before you can migrate your MariaDB databases, you will need to ensure that those instances meet all the Azure pre-requisites for a successful migration.

- Supported Versions

  - MariaDB uses the X.Y.Z naming scheme. X is the major version, Y is the minor version, and Z is the patch version.

  - Azure currently supports 10.2.25 and 10.3.16.

  - Azure automatically manages upgrades for patch updates. For example, 10.2.21 to 10.2.23. Minor and major version upgrades aren't supported. For example, upgrading from MariaDB 10.2 to MariaDB 10.3 isn't supported. If you'd like to upgrade from 10.2 to 10.3, take a database dump and restore it to a server created with the target engine version.

- Network

  - Contoso will need to setup a Virtual Network Gateway connection from their on-premises environment to the Virtual Network where their MariaDB database is located.  This will allow the on-premises application to be able to access the database over the gateway when the connection strings are updated.

  ![Migration process](./media/contoso-migration-mariadb-to-azure/migration-process.png)

#### Migration

Since MariaDB is very similar to MySQL, they can use the same common utilities and tools such as MySQL Workbench, mysqldump, Toad or Navicat to connect to and migrate data to Azure Database for MariaDB.

Contoso utilized the following steps to migrate their databases.

- Determined the on-premises MariaDB version by running the following commands and observing the output. In most cases, your version should not matter much in terms of the schema and data dump. However, if you are using features at the application level, you should ensure those applications are compatible with the target version in Azure.
  
  ```cmd
    mysql -h localhost -u root -P
  ```

  ![Migration process](./media/contoso-migration-mariadb-to-azure/mariadb_version.png)

- Create a new MariaDB instance in Azure
 
  - Open the [Azure Portal](https://portal.azure.com)
  - Select **Add a resource**
  - Search for `MariaDB`

    ![Migration process](./media/contoso-migration-mariadb-to-azure/azure-mariadb-create.png)

  - Select **Create**
  - Select your subscription and resource group
  - Select a server name and location
  - Select your target version (10.2 or 10.3)
  - Select your compute and storage
  - Enter an admin username and password
  - Select **Review + create**
  
    ![Migration process](./media/contoso-migration-mariadb-to-azure/azure_mariadb_create.png)
  
  - Select **Create**
  - Record the server hostname, username and password
  - Select **Connection Security**
  - Select **Add Client IP** (the IP from which you will be restoring the database from)
  - Select **Save**

- Run the following commands to export the database called `Employees`.  Repeat for each database:

    ```cmd
    mysqldump -h localhost -u root -p -–skip-triggers -–single-transaction –-extended-insert -–order-by-primary -–disable-keys Employees > Employees.sql
    ```

- Restore the database. Replace with the endpoint for your Azure MariaDB instance and the username

  ```cmd
  mysql -h {name}.mariadb.database.azure.com -u user@{name} -p –ssl
  create database employees;
  use database employees;
  source employees.sql;
  ```

- Using PhpAdmin or a similar tool (MySql workbench, Toad, Navicat), verify the restore by checking record counts in each table
  
- Update all application connection strings to point to the migrated database

- Test all applications for proper operation

## Clean up after migration

After a verified successful migration, Contoso needs to complete these cleanup steps:

- Backup and store the on-premises database backup files for retention purposes
- Retire the on-premises MariaDB server

## Review the deployment

With the migrated resources in Azure, Contoso needs to fully operationalize and secure their new infrastructure.

### Security

- Contoso needs to ensure that their new Azure MariaDB instance and databases are secure. [Learn more](https://docs.microsoft.com/azure/mariadb/concepts-security).
- In particular, Contoso should review the [Firewall](https://docs.microsoft.com/azure/mariadb/concepts-firewall-rules) and virtual network configurations you limit connections to only the applications that require it.
- Configure any outbound IP requirements to allow connections to the MariaDB [gateway IP Addresses](https://docs.microsoft.com/azure/mariadb/concepts-connectivity-architecture)
- Update all applications to [require SSL](https://docs.microsoft.com/azure/mariadb/concepts-ssl-connection-security) connections to the databases
- Setup [Private Link](https://docs.microsoft.com/azure/mariadb/concepts-data-access-security-private-link) so that all database traffic is kept inside Azure and the on-premises network
- Enable [Advanced Thread Protection (ATP)](https://docs.microsoft.com/azure/mariadb/concepts-data-access-and-security-threat-protection)
- Configure log analytics to monitor and alert on security and logs entries of interest

### Backups

- Ensure that the Azure MariaDB databases are backed up using geo-restore.  This allows backups to be used in a paired region in case of a regional outage.
- **Important** Ensure that the Azure MariaDB server resource has a [resource lock](https://docs.microsoft.com/azure/azure-resource-manager/management/lock-resources) to prevent it from being deleted.  Deleted servers cannot be restored.

### Licensing and cost optimization

- Azure MariaDB can be scaled up or down, therefore performance monitoring of the server and databases is important to ensure you are meeting your needs but also keeping costs at a minimum.
- Both CPU and Storage have costs associated. There are several pricing tiers to select from.  Be sure the appropriate pricing plan is selected for the data workloads.
- Each read replica is billed based on the compute and storage selected
- Utilize reserved capacity to save on costs

## Conclusion

In this article, Contoso migrated their MariaDB databases to an Azure MariaDB managed instance.
