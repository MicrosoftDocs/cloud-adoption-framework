---
title: Refactor a Linux application to Azure App Service, Traffic Manager, and Azure Database for MySQL
description: Use the Cloud Adoption Framework for Azure to learn how to refactor a Linux service desk app to Azure App Service and Azure Database for MySQL.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

<!-- cSpell:ignore WEBVM SQLVM contosohost vcenter contosodc OSTICKETWEB OSTICKETMYSQL osTicket contosoosticket trafficmanager InnoDB binlog DBHOST DBUSER CNAME -->

# Refactor a Linux application to multiple regions using Azure App Service, Traffic Manager, and Azure Database for MySQL

This article shows how the fictional company Contoso refactors a two-tier [LAMP-based](https://wikipedia.org/wiki/LAMP_(software_bundle)) application, migrating it from on-premises to Azure using Azure App Service with GitHub integration and Azure Database for MySQL.

osTicket, the service desk application used in this example is provided as open source. If you'd like to use it for your own testing purposes, you can download it from the [osTicket repo in GitHub](https://github.com/osTicket/osTicket).

## Business drivers

The IT leadership team has worked closely with business partners to understand what they want to achieve:

- **Address business growth.** Contoso is growing and moving into new markets. It needs additional customer service agents.
- **Scale.** The solution should be built so that Contoso can add more customer service agents as the business scales.
- **Improve resiliency.** In the past, issues with the system affected internal users only. With the new business model, external users will be affected, and Contoso need the application up and running at all times.

## Migration goals

The Contoso cloud team has pinned down goals for this migration, in order to determine the best migration method:

- The application should scale beyond current on-premises capacity and performance. Contoso is moving the application to take advantage of Azure's on-demand scaling.
- Contoso wants to move the application code base to a continuous delivery pipeline. As application changes are pushed to GitHub, Contoso wants to deploy those changes without tasks for operations staff.
- The application must be resilient with capabilities for growth and failover. Contoso wants to deploy the application in two different Azure regions, and set it up to scale automatically.
- Contoso wants to minimize database admin tasks after the application is moved to the cloud.

## Solution design

After pinning down their goals and requirements, Contoso designs and reviews a deployment solution, and identifies the migration process, including the Azure services that will be used for the migration.

## Current architecture

- The application is tiered across two VMs (`OSTICKETWEB` and `OSTICKETMYSQL`).
- The VMs are located on VMware ESXi host `contosohost1.contoso.com` (version 6.5).
- The VMware environment is managed by vCenter Server 6.5 (`vcenter.contoso.com`), running on a VM.
- Contoso has an on-premises datacenter (`contoso-datacenter`), with an on-premises domain controller (`contosodc1`).

![Current architecture](./media/contoso-migration-refactor-linux-app-service-mysql/current-architecture.png)

## Proposed architecture

Here's the proposed architecture:

- The web tier application on `OSTICKETWEB` will be migrated by building an Azure App Service in two Azure regions. Azure App Service for Linux will be implemented using the PHP 7.0 docker container.
- The application code will be moved to GitHub, and the Azure App Service web app will be configured for continuous delivery with GitHub.
- Azure App Service will be deployed in both the primary region (`East US 2`) and secondary region (`Central US`).
- Traffic Manager will be set up in front of the two web apps in both regions.
- Traffic Manager will be configured in priority mode to force the traffic through `East US 2`.
- If the Azure app server in `East US 2` goes offline, users can access the failed over application in `Central US`.
- The application database will be migrated to the Azure Database for MySQL service using Azure Database Migration Service. The on-premises database will be backed up locally, and restored directly to Azure Database for MySQL.
- The database will reside in the primary region (`East US 2`) in the database subnet (`PROD-DB-EUS2`) of the production network (`VNET-PROD-EUS2`):
- Since they're migrating a production workload, Azure resources for the application will reside in the production resource group `ContosoRG`.
- The Traffic Manager resource will be deployed in Contoso's infrastructure resource group `ContosoInfraRG`.
- The on-premises VMs in the Contoso datacenter will be decommissioned after the migration is done.

![Scenario architecture](./media/contoso-migration-refactor-linux-app-service-mysql/proposed-architecture.png)

## Migration process

Contoso will complete the migration process as follows:

1. As a first step, Contoso admins set up the Azure infrastructure, including provisioning Azure App Service, setting up Traffic Manager, and provisioning an Azure Database for MySQL instance.
2. After preparing the Azure infrastructure, they migrate the database using Azure Database Migration Service.
3. After the database is running in Azure, they up a GitHub private repository for Azure App Service with continuous delivery, and load it with the osTicket application.
4. In the Azure portal, they load the application from GitHub to the docker container running Azure App Service.
5. They tweak DNS settings, and configure autoscaling for the application.

![Migration process](./media/contoso-migration-refactor-linux-app-service-mysql/migration-process.png)

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure App Service](https://azure.microsoft.com/services/app-service) | The service runs and scales applications using the Azure PaaS service for websites. | Pricing is based on the size of the instances, and the features required. [Learn more](https://azure.microsoft.com/pricing/details/app-service/windows). |
| [Traffic Manager](https://azure.microsoft.com/services/traffic-manager) | A load balancer that uses DNS to direct users to Azure, or external websites and services. | Pricing is based on the number of DNS queries received, and the number of monitored endpoints. | [Learn more](https://azure.microsoft.com/pricing/details/traffic-manager). |
| [Azure Database Migration Service](https://docs.microsoft.com/azure/dms/dms-overview) | Azure Database Migration Service enables seamless migration from multiple database sources to Azure data platforms with minimal downtime. | Learn about [supported regions](https://docs.microsoft.com/azure/dms/dms-overview#regional-availability) and [Database Migration Service pricing](https://azure.microsoft.com/pricing/details/database-migration). |
| [Azure Database for MySQL](https://docs.microsoft.com/azure/mysql) | The database is based on the open-source MySQL database engine. It provides a fully managed, enterprise-ready community MySQL database for application development and deployment. | Pricing based on compute, storage, and backup requirements. [Learn more](https://azure.microsoft.com/pricing/details/mysql). |

## Prerequisites

Here's what Contoso needs to run this scenario.

| Requirements | Details |
| --- | --- |
| **Azure subscription** | Contoso created subscriptions earlier in this article series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, you need to work with the admin to assign you Owner or Contributor permissions. |
| **Azure infrastructure** | Contoso set up their Azure infrastructure as described in [Azure infrastructure for migration](./contoso-migration-infrastructure.md). |

## Scenario steps

Here's how Contoso will complete the migration:

> [!div class="checklist"]
>
> - **Step 1: Provision Azure App Service.** Contoso admins will provision web apps in the primary and secondary regions.
> - **Step 2: Set up Traffic Manager.** They set up Traffic Manager in front of the web apps, for routing and load balancing traffic.
> - **Step 3: Provision MySQL.** In Azure, they provision an instance of Azure Database for MySQL.
> - **Step 4: Migrate the database.** They migrate the database using Azure Database Migration Service.
> - **Step 5: Set up GitHub.** They set up a local GitHub repository for the application web sites/code.
> - **Step 6: Deploy the web apps.** They deploy the web apps from GitHub.

## Step 1: Provision Azure App Service

Contoso admins provision two web apps (one in each region) using Azure App Service.

1. They create a web app resource (`osticket-eus2`) in the primary region (`East US 2`) via the Azure Marketplace.
2. They put the resource in the production resource group `ContosoRG`.

    ![Azure web app](./media/contoso-migration-refactor-linux-app-service-mysql/azure-app1.png)

3. They create a new App Service plan (`APP-SVP-EUS2`) in the primary region, using the standard size.

     ![Azure App](./media/contoso-migration-refactor-linux-app-service-mysql/azure-app2.png)

4. They select a Linux OS with PHP 7.0 runtime stack, which is a docker container.

    ![Azure App](./media/contoso-migration-refactor-linux-app-service-mysql/azure-app3.png)

5. They create a second web app (`osticket-cus`) and Azure App Service plan for `Central US`.

    ![Azure App](./media/contoso-migration-refactor-linux-app-service-mysql/azure-app4.png)

**Need more help?**

- Learn about [Azure App Service web apps](https://docs.microsoft.com/azure/app-service/overview).
- Learn about [Azure App Service on Linux](https://docs.microsoft.com/azure/app-service/containers/app-service-linux-intro).

## Step 2: Set up Traffic Manager

Contoso admins set up Traffic Manager to direct inbound web requests to the web apps running on the osTicket web tier.

1. They create a Traffic Manager resource (`osticket.trafficmanager.net`) from the Azure Marketplace. They use priority routing so that `East US 2` is the primary site. They place the resource in their infrastructure resource group (`ContosoInfraRG`). Note that Traffic Manager is global and not bound to a specific location.

    ![Traffic Manager](./media/contoso-migration-refactor-linux-app-service-mysql/traffic-manager1.png)

2. Now, they configure Traffic Manager with endpoints. They add the web app in `East US 2` as the primary site (`osticket-eus2`), and the web app in `Central US` as the secondary site (`osticket-cus`).

    ![Add endpoints in Traffic Manager](./media/contoso-migration-refactor-linux-app-service-mysql/traffic-manager2.png)

3. After adding the endpoints, they can monitor them.

    ![Monitor endpoints in Traffic Manager](./media/contoso-migration-refactor-linux-app-service-mysql/traffic-manager3.png)

**Need more help?**

- Learn about [Traffic Manager](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-overview).
- Learn about [routing traffic to a priority endpoint](https://docs.microsoft.com/azure/traffic-manager/traffic-manager-configure-priority-routing-method).

## Step 3: Provision Azure Database for MySQL

Contoso admins provision a MySQL database instance in the primary region (`East US 2`).

1. In the Azure portal, they create an Azure Database for MySQL resource.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/mysql-1.png)

2. They add the name `contosoosticket` for the Azure database. They add the database to the production resource group `ContosoRG`, and specify credentials for it.
3. The on-premises MySQL database is version 5.7, so they select this version for compatibility. They use the default sizes, which match their database requirements.

     ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/mysql-2.png)

4. For **Backup Redundancy Options**, they select to use **Geo-Redundant**. This option allows them to restore the database in their secondary region (`Central US`) if an outage occurs. They can only configure this option when they provision the database.

    ![Redundancy](./media/contoso-migration-refactor-linux-app-service-mysql/db-redundancy.png)

5. They set up connection security. In the database > **Connection security**, they set up firewall rules to allow the database to access Azure services.

6. They add the local workstation client IP address to the start and end IP addresses. This allows the web apps to access the MySQL database, along with the database client that's performing the migration.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/mysql-3.png)

## Step 4: Migrate the database

There are several ways to move the MySQL database. Each option requires you to create an Azure Database for MySQL instance for the target. Once created, you can perform the migration using two paths:

- Step 4a: Azure Database Migration Service
- Step 4b: MySQL Workbench backup and restore

### Step 4a: Migrate the database via Azure Database Migration Service

Contoso admins migrate the database via Azure Database Migration Service by following the [step-by-step migration tutorial](https://docs.microsoft.com/azure/dms/tutorial-mysql-azure-mysql-online). They can perform online, offline, and hybrid (preview) migrations using MySQL 5.6 or 5.7.

> [!NOTE]
> MySQL 8.0 is supported in Azure Database for MySQL, but the Database Migration Service tool does not yet support this version.

As a summary, you must perform the following:

- Ensure all migration prerequisites are met:
  - The MySQL database server source must match the version that Azure Database for MySQL supports. Azure Database for MySQL supports MySQL Community Edition, the InnoDB storage engine, and migration across source and target with same versions.
  - Enable binary logging in `my.ini` (Windows) or `my.cnf` (Unix). Failure to do this will cause `error in binary logging. Variable binlog_row_image has value 'minimal'. Please change it to 'full'. For more information, see https://go.microsoft.com/fwlink/?linkid=873009` during the migration wizard.
  - The user must have `ReplicationAdmin` role.
  - Migrate the database schemas without foreign keys and triggers.
- Create a virtual network that connects via ExpressRoute or VPN to your on-premises network.
- Create an Azure Database Migration Service with a `Premium` SKU that is connected to the VNet.
- Ensure that Azure Database Migration Service can access the MySQL database via the virtual network. This would entail ensuring that all incoming ports are allowed from Azure to MySQL at the virtual network level, the network VPN, and the machine that hosts MySQL.
- Run the Database Migration Service tool:
  - Create a migration project based on the **Premium SKU**.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-new-project.png)

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-new-project-02.png)

  - Add a source (on-premises database).

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-source.png)

  - Select a target.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-target.png)

  - Select the databases to migrate.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-databases.png)

  - Configure advanced settings.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-settings.png)

  - Start the replication and resolve any errors.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-monitor.png)

  - Perform the final cutover.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-cutover.png)

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-cutover-complete.png)

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-cutover-complete-02.png)

  - Reinstate any foreign keys and triggers.

  - Modify applications to use the new database.

    ![MySQL](./media/contoso-migration-refactor-linux-app-service-mysql/migration-dms-cutover-apps.png)

### Step 4b: Migrate the database (MySQL Workbench)

1. They check the [prerequisites and downloads MySQL Workbench](https://dev.mysql.com/downloads/workbench/?utm_source=tuicool).
2. They install MySQL Workbench for Windows in accordance with the [installation instructions](https://dev.mysql.com/doc/workbench/en/wb-installing.html). The machine on which they install must be accessible to the `OSTICKETMYSQL` VM, and Azure via the internet.
3. In MySQL Workbench, they create a MySQL connection to `OSTICKETMYSQL`.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench1.png)

4. They export the database as `osticket`, to a local self-contained file.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench2.png)

5. After the database has been backed up locally, they create a connection to the Azure Database for MySQL instance.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench3.png)

6. Now, they can import (restore) the database in the Azure Database for MySQL instance, from the self-contained file. A new schema (`osticket`) is created for the instance.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench4.png)

7. After data is restored, it can be queried using MySQL Workbench, and appears in the Azure portal.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench5.png)

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench6.png)

8. Finally, they need to update the database information on the web apps. On the MySQL instance, they open **Connection Strings**.

     ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench7.png)

9. In the strings list, they locate the web app settings, and select to copy them.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench8.png)

10. They open a Notepad window and paste the string into a new file, and update it to match the osticket database, MySQL instance, and credentials settings.

     ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench9.png)

11. They can verify the server name and login from **Overview** in the MySQL instance in the Azure portal.

    ![MySQL Workbench](./media/contoso-migration-refactor-linux-app-service-mysql/workbench10.png)

## Step 5: Set up GitHub

Contoso admins create a new private GitHub repo and set up a connection to the osTicket database in Azure Database for MySQL. Then, they load the web app into Azure App Service.

1. They browse to the OsTicket software public GitHub repo, and fork it to the Contoso GitHub account.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github1.png)

2. After forking, they navigate to the `include` folder, and find the `ost-config.php` file.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github2.png)

3. The file opens in the browser and they edit it.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github3.png)

4. In the editor, they update the database details, specifically for `DBHOST` and `DBUSER`.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github4.png)

5. Then they commit the changes.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github5.png)

6. For each web app (`osticket-eus2` and `osticket-cus`), they modify the **Application settings** in the Azure portal.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github6.png)

7. They enter the connection string with the name `osticket`, and copy the string from Notepad into the **value area**. They select **MySQL** in the dropdown list next to the string, and save the settings.

    ![GitHub](./media/contoso-migration-refactor-linux-app-service-mysql/github7.png)

## Step 6: Configure the web apps

As the final step in the migration process, Contoso admins configure the web apps with the osTicket web sites.

1. In the primary web app (`osticket-eus2`), they open **Deployment option** and set the source to **GitHub**.

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app1.png)

2. They select the deployment options.

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app2.png)

3. After setting the options, the configuration shows as pending in the Azure portal.

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app3.png)

4. After the configuration is updated and the osTicket web app is loaded from GitHub to the docker container running the Azure App Service, the site shows as active.

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app4.png)

5. They repeat the above steps for the secondary web app (`osticket-cus`).
6. After the site is configured, it's accessible via the Traffic Manager profile. The DNS name is the new location of the osTicket application. [Learn more](https://docs.microsoft.com/azure/app-service/app-service-web-tutorial-custom-domain#map-a-cname-record).

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app5.png)

7. Contoso wants a DNS name that's easy to remember. They create an alias record (CNAME) `osticket.contoso.com` that points to the Traffic Manager name, in the DNS on their domain controllers.

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app6.png)

8. They configure both the `osticket-eus2` and `osticket-cus` web apps to allow the custom host names.

    ![Configure app](./media/contoso-migration-refactor-linux-app-service-mysql/configure-app7.png)

### Set up autoscaling

Finally, they set up automatic scaling for the application. This ensures that as agents use the application, the application instances increase and decrease according to business needs.

1. In app service `APP-SRV-EUS2`, they open **Scale Unit**.
2. They configure a new autoscale setting with a single rule that increases the instance count by one when the CPU percentage for the current instance is above 70% for 10 minutes.

    ![Autoscale](./media/contoso-migration-refactor-linux-app-service-mysql/autoscale1.png)

3. They configure the same setting on `APP-SRV-CUS` to ensure that the same behavior applies if the application fails over to the secondary region. The only difference is that they set the default instance to 1 since this is for failovers only.

   ![Autoscale](./media/contoso-migration-refactor-linux-app-service-mysql/autoscale2.png)

## Clean up after migration

With migration complete, the osTicket application is refactored to running in an Azure App Service web app with continuous delivery using a private GitHub repo. The application runs in two regions for increased resilience. The osTicket database is running in Azure Database for MySQL after migration to the PaaS platform.

For cleanup, Contoso needs to do the following:

- Remove the VMware VMs from the vCenter inventory.
- Remove the on-premises VMs from local backup jobs.
- Update internal documentation show new locations and IP addresses.
- Review any resources that interact with the on-premises VMs, and update any relevant settings or documentation to reflect the new configuration.
- Reconfigure monitoring to point at the `osticket-trafficmanager.net` URL, to track that the application is up and running.

## Review the deployment

With the application now running, Contoso need to fully operationalize and secure their new infrastructure.

### Security

The Contoso security team reviewed the application to determine any security issues. They identified that the communication between the osTicket application and the MySQL database instance isn't configured for SSL. They will need to do this to ensure that database traffic can't be hacked. [Learn more](https://docs.microsoft.com/azure/mysql/howto-configure-ssl).

### Backups

- The osTicket web apps don't contain state data and thus don't require backup.
- They don't need to configure backup for the database. Azure Database for MySQL automatically creates server backups and stores. They selected to use geo-redundancy for the database, so it's resilient and production-ready. Backups can be used to restore your server to a point-in-time. [Learn more](https://docs.microsoft.com/azure/mysql/concepts-backup).

### Licensing and cost optimization

- There are no licensing issues for the PaaS deployment.
- Contoso will use [Azure Cost Management and Billing](https://docs.microsoft.com/azure/cost-management-billing/cost-management-billing-overview) to ensure they stay within budgets established by their IT leadership.
