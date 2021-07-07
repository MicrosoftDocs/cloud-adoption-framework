---
title: Migrate an application to Azure App Service and SQL Database
description: Use the Cloud Adoption Framework for Azure to learn how to refactor an application by migrating it to Azure App Service and Azure SQL Database.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

<!-- cSpell:ignore WEBVM SQLVM contosohost vcenter contosodc smarthotel SHWEB SHWCF -->

# Migrate an application to Azure App Service and SQL Database

This article demonstrates how the fictional company Contoso refactors a two-tier Windows .NET application that's running on VMware VMs as part of a migration to Azure. The Contoso team migrates the application front-end virtual machine (VM) to an Azure App Service web app and the application database to Azure SQL Database.

The SmartHotel360 application that we use in this example is provided as open-source software. If you want to use it for your own testing purposes, you can download it from [GitHub](https://github.com/Microsoft/SmartHotel360).

## Business drivers

The Contoso IT leadership team has worked closely with business partners to understand what they want to achieve with this migration:

- **Address business growth.** Contoso is growing, and there is pressure on their on-premises systems and infrastructure.
- **Increase efficiency.** Contoso needs to remove unnecessary procedures and streamline processes for developers and users. The business needs IT to be fast and not waste time or money, thus delivering faster on customer requirements.
- **Increase agility.** To enable their success in a global economy, Contoso IT needs to be more responsive to the needs of the business. It must be able to react more quickly to changes in the marketplace. IT must not get in the way or become a business blocker.
- **Scale.** As the business grows successfully, Contoso IT must provide systems that are able to grow at the same pace.
- **Reduce costs.** Contoso wants to minimize licensing costs.

## Migration goals

To help determine the best migration method, the Contoso cloud team pinned down the following goals:

| Requirements | Details |
| --- | --- |
| **Application** | The application in Azure will remain as critical as it is today on-premises. <br><br> It should have the same performance capabilities as it currently does in VMware. <br><br> The team doesn't want to invest in the application. For now, admins will simply move the application safely to the cloud. <br><br> The team wants to stop supporting Windows Server 2008 R2, which the application currently runs on. <br><br> The team also wants to move away from SQL Server 2008 R2 to a modern platform as a service (PaaS) database, which will minimize the need for management. <br><br> Contoso wants to take advantage of its investment in SQL Server licensing and Software Assurance where possible. <br><br> In addition, Contoso wants to mitigate the single point of failure on the web tier. |
| **Limitations** | The application consists of an ASP.NET application and a Windows Communication Foundation (WCF) service running on the same VM. They want to spread these components across two web apps using the Azure App Service. |
| **Azure** | Contoso wants to move the application to Azure, but they don't want to run it on VMs. Contoso wants to use Azure PaaS services for both the web and data tiers. |
| **DevOps** | Contoso wants to move to a DevOps model that uses Azure DevOps for their builds and release pipelines. |

## Solution design

After pinning down their goals and requirements, Contoso designs and reviews a deployment solution. They also identify the migration process, including the Azure services that they'll use for the migration.

### Current application

- The SmartHotel360 on-premises application is tiered across two VMs, `WEBVM` and `SQLVM`.
- The VMs are located on VMware ESXi host contosohost1.contoso.com version 6.5.
- The VMware environment is managed by vCenter Server 6.5 (`vcenter.contoso.com`), which runs on a VM.
- Contoso has an on-premises datacenter (contoso-datacenter), with an on-premises domain controller (contosodc1).
- The on-premises VMs in the Contoso datacenter will be decommissioned after the migration is done.

### Proposed solution

- For the database tier of the application, Contoso compared Azure SQL Database to SQL Server by referring to the [features comparison: Azure SQL Database and Azure SQL Managed Instance](/azure/azure-sql/database/features-comparison). Contoso decided to use Azure SQL Database for a few reasons:
  - Azure SQL Database is a managed relational database service. It delivers predictable performance at multiple service levels, with near-zero administration. Advantages include dynamic scalability with no downtime, built-in intelligent optimization, and global scalability and availability.
  - Contoso can use the lightweight Data Migration Assistant to assess the on-premises database migration to Azure SQL Database.
  - Contoso can use Azure Database Migration Service to migrate the on-premises database to Azure SQL Database.
  - With Software Assurance, Contoso can exchange existing licenses for discounted rates on a database in SQL Database by using the Azure Hybrid Benefit for SQL Server. This approach could provide a cost saving of up to 30 percent.
  - SQL Database provides security features such as Always Encrypted, dynamic data masking, row-level security, and SQL threat detection.
- For the application web tier, Contoso has decided to use Azure App Service. This PaaS service enables them to deploy the application with just a few configuration changes. Contoso will use Visual Studio to make the change, and they'll deploy two web apps, one for the website and one for the WCF service.
- To meet requirements for a DevOps pipeline, Contoso will use Azure DevOps for source code management with Git repos. They'll use automated builds and release to build the code and deploy it to the Azure App Service.

### Solution review

Contoso evaluates their proposed design by putting together a pros and cons list, as shown in the following table:

| Consideration | Details |
| --- | --- |
| **Pros** | The SmartHotel360 application code doesn't require changes for migration to Azure. <br><br> Contoso can take advantage of their investment in Software Assurance by using the Azure Hybrid Benefit for both SQL Server and Windows Server. <br><br> After the migration, Windows Server 2008 R2 won't need to be supported. For more information, see the [Microsoft Lifecycle Policy](/lifecycle/). <br><br> Contoso can configure the web tier of the application with multiple instances, so that the web tier is no longer a single point of failure. <br><br> The database will no longer depend on the aging SQL Server 2008 R2. <br><br> SQL Database supports the technical requirements. Contoso assessed the on-premises database by using Data Migration Assistant and found that it's compatible. <br><br> Azure SQL Database has built-in fault tolerance that Contoso doesn't have to set up. This ensures that the data tier is no longer a single point of failover. <br><br> If Contoso uses Azure Database Migration Service to migrate their database, it will have the infrastructure ready for migrating databases at scale. |
| **Cons** | Azure App Service supports only one application deployment for each web app. This means that two web apps must be provisioned, one for the website and one for the WCF service. |

## Proposed architecture

![Diagram of the proposed architecture.](./media/contoso-migration-refactor-web-app-sql/architecture.png)

### Migration process

1. Contoso provisions an Azure SQL managed instance and then migrates the SmartHotel360 database to it by using Azure Database Migration Service.
1. Contoso provisions and configures web apps, and deploys the SmartHotel360 application to them.

    ![Diagram of the migration process.](./media/contoso-migration-refactor-web-app-sql/migration-process.png)

### Azure services

| Service | Description | Cost |
| --- | --- | --- |
| [Azure App Service Migration Assistant](/learn/paths/migrate-dotnet-apps-azure/) | A free and simple path to seamlessly migrate .NET web applications from on-premises to the cloud with minimal to no code changes. | It's a downloadable tool, free of charge. |
| [Data Migration Assistant](/sql/dma/dma-overview) | Contoso will use Data Migration Assistant to assess and detect compatibility issues that might affect database functionality in Azure. Data Migration Assistant assesses feature parity between SQL sources and targets, and it recommends performance and reliability improvements. | It's a downloadable tool, free of charge. |
| [Azure Database Migration Service](/azure/dms/dms-overview) | Azure Database Migration Service enables seamless migration from multiple database sources to Azure data platforms with minimal downtime. | Learn about [supported regions](/azure/dms/dms-overview#regional-availability) and [Database Migration Service pricing](https://azure.microsoft.com/pricing/details/database-migration/). |
| [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview) | An intelligent, fully managed relational cloud database service. | Cost is based on features, throughput, and size. [Learn more](https://azure.microsoft.com/pricing/details/azure-sql/sql-managed-instance/single/). |
| [Azure App Service](/azure/app-service/overview) | Helps create powerful cloud applications that use a fully managed platform. | Pricing is based on size, location, and usage duration. [Learn more](https://azure.microsoft.com/pricing/details/app-service/windows/). |
| [Azure DevOps](/azure/azure-portal/tutorial-azureportal-devops) | Provides a continuous integration and continuous deployment (CI/CD) pipeline for application development. The pipeline starts with a Git repository for managing application code, a build system for producing packages and other build artifacts, and a release management system to deploy changes in dev, test, and production environments. |

## Prerequisites

To run this scenario, Contoso must meet the following prerequisites:

| Requirements | Details |
| --- | --- |
| **Azure subscription** | Contoso created subscriptions earlier in this article series. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/). <br><br> If you create a free account, you're the administrator of your subscription and can perform all actions. <br><br> If you use an existing subscription and you're not the administrator, you need to work with the admin to assign you Owner or Contributor permissions. |
| **Azure infrastructure** | Contoso set up their Azure infrastructure as described in [Azure infrastructure for migration](./contoso-migration-infrastructure.md). |

## Scenario steps

Here's how Contoso will run the migration:

> [!div class="checklist"]
>
> - **Step 1: Assess and migrate the web apps.**. Contoso uses the [Azure App Service Migration Assistant](https://azure.microsoft.com/migration/web-applications/) tool to run pre-migration compatibility checks and migrate their web apps to Azure App Service.
> - **Step 2: Provision a database in Azure SQL Database**. Contoso provisions an Azure SQL Database instance. After the application website is migrated to Azure, the WCF service web app will point to this instance.
> - **Step 3: Assess the database**. Contoso assesses the database for migration by using Data Migration Assistant and then migrates it via Azure Database Migration Service.
> - **Step 4: Set up Azure DevOps**. Contoso creates a new Azure DevOps project, and imports the Git repo.
> - **Step 5: Configure connection strings**. Contoso configures connection strings so that the web tier web app, the WCF service web app, and the SQL instance can communicate.
> - **Step 6: Set up build and release pipelines in Azure DevOps**. As a final step, Contoso sets up build and release pipelines in Azure DevOps to create the application, and then deploys them to two separate web apps.

## Step 1: Assess and migrate the web apps

Contoso admins assess and migrate their web app using the [Azure App Service Migration Assistant](https://azure.microsoft.com/migration/web-applications/) tool. They use the [Migrate ASP.NET Apps to Azure learning path](/learn/paths/migrate-dotnet-apps-azure/) as a guide during the process. The admins perform these actions:

- They use the Azure [App Service migration assessment](https://azure.microsoft.com/services/app-service/migration-assistant/) tool to evaluate any dependencies between their web apps and to determine whether there are any incompatibilities between their on-premises web apps and what's supported on Azure App Service.

- They download the Azure App Service Migration Assistant and sign in to their Azure account.

- They choose a subscription, a resource group, and the website's domain name.

## Step 2: Provision a database in Azure SQL Database

1. Contoso admins decide to create an Azure SQL Database instance.

    ![Screenshot showing the SQL Database link.](./media/contoso-migration-refactor-web-app-sql/provision-sql1.png)

1. They specify a database name to match the database, `SmartHotel.Registration`, that's running on the on-premises VM. They place the database in the `ContosoRG` resource group. This is the resource group they use for production resources in Azure.

    ![Screenshot showing SQL Database instance details.](./media/contoso-migration-refactor-web-app-sql/provision-sql2.png)

1. They set up a new SQL Server instance, `sql-smarthotel-eus2`, in the primary region.

    ![Screenshot of the new SQL Server instance.](./media/contoso-migration-refactor-web-app-sql/provision-sql3.png)

1. They set the pricing tier to match their server and database needs. And they select to save money with Azure Hybrid Benefit because they already have a SQL Server license.
1. For sizing, they use vCore-based purchasing and set the limits for their expected requirements.

    ![Screenshot of the vCore sizing requirements.](./media/contoso-migration-refactor-web-app-sql/provision-sql4.png)

1. They create the database instance.

    ![Screenshot of creating a SQL Database instance.](./media/contoso-migration-refactor-web-app-sql/provision-sql5.png)

1. They open the database and note the details they'll need when they use Data Migration Assistant for migration.

    ![Screenshot of the database instance text file.](./media/contoso-migration-refactor-web-app-sql/provision-sql6.png)

**Need more help?**

- [Get help](/azure/azure-sql/database/single-database-create-quickstart) provisioning a SQL database.
- Learn about [vCore resource limits](/azure/azure-sql/database/resource-limits-vcore-elastic-pools).

## Step 3: Assess the database

Contoso admins assess the database by using Data Migration Assistant and then migrate it by using Azure Database Migration Service by referring to the [step-by-step migration tutorial](/azure/dms/tutorial-sql-server-to-azure-sql). They can perform online, offline, and hybrid (preview) migrations.

In brief, the admins do the following:

- They use Data Migration Assistant to discover and resolve any database migration issues.
- They create an Azure Database Migration Service instance with a Premium SKU that's connected to the virtual network.
- They ensure that the instance can access the remote SQL Server via the virtual network. This entails ensuring that all incoming ports are allowed from Azure to SQL Server at the virtual network level, the network VPN, and the machine that hosts SQL Server.
- They configure the instance:
  - Create a migration project.
  - Add a source (on-premises database).
  - Select a target.
  - Select the databases to migrate.
  - Configure advanced settings.
  - Start the replication.
  - Resolve any errors.
  - Perform the final cutover.

## Step 4: Set up Azure DevOps

Contoso needs to build the DevOps infrastructure and pipelines for the application. To do this, Contoso admins create a new DevOps project, import the code, and then set up build and release pipelines.

1. In the Contoso Azure DevOps account, they create a new project, `ContosoSmartHotelRefactor`, and then select **Git** for version control.

    ![Screenshot of creating a new project in Azure DevOps.](./media/contoso-migration-refactor-web-app-sql/vsts1.png)

1. They import the Git repo that currently holds their application code. They download it from the [public GitHub repository](https://github.com/Microsoft/SmartHotel360-Registration).

    ![Screenshot of the **Import a Git repository** pane.](./media/contoso-migration-refactor-web-app-sql/vsts2.png)

1. They connect Visual Studio to the repo and then clone the code to the developer machine by using Team Explorer.

    ![Screenshot of the **Connect to a Project** pane.](./media/contoso-migration-refactor-web-app-sql/devops1.png)

1. They open the solution file for the application. The web app and the WCF service have separate projects within the file.

    ![Screenshot of Solution Explorer, listing the web app and WCF service projects.](./media/contoso-migration-refactor-web-app-sql/vsts4.png)

## Step 5: Configure connection strings

The Contoso admins make sure that the web apps and database can communicate with each other. To do this, they configure connection strings in the code and in the web apps.

1. In the web app for the WCF service, `SHWCF-EUS2`, under **Settings** > **Application settings**, they add a new connection string named **DefaultConnection**.

1. They pull the connection string from the `SmartHotel-Registration` database and then update it with the correct credentials.

    ![Screenshot of the connection string settings pane.](./media/contoso-migration-refactor-web-app-sql/string1.png)

1. In Visual Studio, the admins open the `SmartHotel.Registration.wcf` project from the solution file. In the project, they update the `connectionStrings` section of the `web.config` file with the connection string.

     ![Screenshot of the `connectionStrings` section of the `web.config` file in the `SmartHotel.Registration.wcf` project.](./media/contoso-migration-refactor-web-app-sql/string2.png)

1. They change the `client` section of the `web.config` file for `SmartHotel.Registration.Web` to point to the new location of the WCF service. This is the URL of the WCF web app that hosts the service endpoint.

    ![Screenshot of the client section of the `web.config` file in the `SmartHotel.Registration.wcf` project.](./media/contoso-migration-refactor-web-app-sql/strings3.png)

1. With the code changes now in place, the admins commit and sync them by using Team Explorer in Visual Studio.

## Step 6: Set up build and release pipelines in Azure DevOps

The Contoso admins now configure Azure DevOps to perform the build and release process.

1. In Azure DevOps, they select **Build and release** > **New pipeline**.

    ![Screenshot of the **New pipeline** link in Azure DevOps.](./media/contoso-migration-refactor-web-app-sql/pipeline1.png)

1. They select **Azure Repos Git** and, in the **Repository** drop-down list, they select the relevant repo.

    ![Screenshot of the **Azure Repos Git** button and the selected repository.](./media/contoso-migration-refactor-web-app-sql/pipeline2.png)

1. Under **Select a template**, they select the `ASP.NET` template for their build.

     ![Screenshot of the **Select a template** pane for selecting the ASP.NET template.](./media/contoso-migration-refactor-web-app-sql/pipeline3.png)

1. They use the name `ContosoSmartHotelRefactor-ASP.NET-CI` for the build and then select **Save & Queue**, which kicks off the first build.

     ![Screenshot of the **Save & Queue** button for the build.](./media/contoso-migration-refactor-web-app-sql/pipeline4.png)

1. They select the build number to watch the process. After it's finished, the admins can see the process feedback, and they select **Artifacts** to review the build results.

    ![Screenshot of the build page and the Artifacts link for reviewing the build results.](./media/contoso-migration-refactor-web-app-sql/pipeline5.png)

    The **Artifacts explorer** pane opens, and the **drop** folder displays the build results.

    - The two .zip files are the packages that contain the applications.
    - These .zip files are used in the release pipeline for deployment to Azure App Service.

     ![Screenshot of the **Artifacts explorer** pane.](./media/contoso-migration-refactor-web-app-sql-managed-instance/pipeline6.png)

1. They select **Releases** > **+ New pipeline**.

    ![New pipeline](./media/contoso-migration-refactor-web-app-sql/pipeline7.png)

1. They select the deployment template for Azure App Service.

    ![Screenshot of the Azure App Service deployment template.](./media/contoso-migration-refactor-web-app-sql/pipeline8.png)

1. They name the release pipeline `ContosoSmartHotel360Refactor` and, in the **Stage name** box, specify `SHWCF-EUS2` as the name of the WCF web app.

    ![Screenshot of the stage name of the WCF web app.](./media/contoso-migration-refactor-web-app-sql/pipeline9.png)

1. Under the stages, they select **1 job, 1 task** to configure deployment of the WCF service.

    ![Screenshot of the **1 job, 1 task** option.](./media/contoso-migration-refactor-web-app-sql-managed-instance/pipeline10.png)

1. They verify that the subscription is selected and authorized, and then they select the **app service name**.

     ![Screenshot of selecting the app service name.](./media/contoso-migration-refactor-web-app-sql/pipeline11.png)

1. On the pipeline > **Artifacts**, they select **+ Add an artifact**, then select to build with the `ContosoSmarthotel360Refactor` pipeline.

     ![Screenshot of the **Build** button on the **Add an artifact** pane.](./media/contoso-migration-refactor-web-app-sql/pipeline12.png)

1. To enable the continuous deployment trigger, the admins select the lightning bolt icon on the artifact.

     ![Screenshot of the lightning bolt icon on the artifact.](./media/contoso-migration-refactor-web-app-sql/pipeline13.png)

1. They set the continuous deployment trigger to **Enabled**.

    ![Screenshot showing the continuous deployment trigger set to Enabled.](./media/contoso-migration-refactor-web-app-sql/pipeline14.png)

1. The admins go back to the stage **1 job, 1 task** and then select **Deploy Azure App Service**.

    ![Screenshot of the option to select **Deploy Azure App Service.**](./media/contoso-migration-refactor-web-app-sql/pipeline15.png)

1. In **Select a file or folder**, they expand the **drop** folder, select the `SmartHotel.Registration.Wcf.zip` file that was created during the build, and then select **Save**.

    ![Screenshot of the **Select a file or folder** pane for selecting the WCF file.](./media/contoso-migration-refactor-web-app-sql/pipeline16.png)

1. They select **Pipeline** > **Stages**, and then select **+ Add** to add an environment for `SHWEB-EUS2`. They select another Azure App Service deployment.

    ![Screenshot of the **1 job, 1 task** link for adding an environment.](./media/contoso-migration-refactor-web-app-sql/pipeline17.png)

1. They repeat the process to publish the `SmartHotel.Registration.Web.zip` file to the correct web app, and then select **Save**.

    ![Screenshot of the **Select a file or folder** pane for selecting the WEB file.](./media/contoso-migration-refactor-web-app-sql/pipeline18.png)

    The release pipeline is displayed, as shown here:

     ![Screenshot of the release pipeline summary.](./media/contoso-migration-refactor-web-app-sql/pipeline19.png)

1. They go back to **Build**, select **Triggers**, and then select the **Enable continuous integration** check box. This action enables the pipeline so that when changes are committed to the code, the full build and release occur.

    ![Screenshot highlighting the **Enable continuous integration** check box.](./media/contoso-migration-refactor-web-app-sql/pipeline20.png)

1. They select **Save & Queue** to run the full pipeline. A new build is triggered, which in turn creates the first release of the application to the Azure App Service.

    ![Screenshot of the **Save & Queue** button.](./media/contoso-migration-refactor-web-app-sql/pipeline21.png)

1. Contoso admins can follow the build and release pipeline process from Azure DevOps. After the build finishes, the release starts.

    ![Screenshot of the progress of the build and release apps.](./media/contoso-migration-refactor-web-app-sql/pipeline22.png)

1. After the pipeline finishes, both sites have been deployed, and the application is up and running online.

    ![Screenshot showing that the application is up and running.](./media/contoso-migration-refactor-web-app-sql/pipeline23.png)

    The application has been successfully migrated to Azure.

## Clean up after migration

After migration, Contoso completes these cleanup steps:

- They remove the on-premises VMs from the vCenter inventory.
- They remove the VMs from the local backup jobs.
- They update their internal documentation to show the new locations for the SmartHotel360 application. The documentation shows the database as running in Azure SQL Database and the front end as running in two web apps.
- They review any resources that interact with the decommissioned VMs, and they update any relevant settings or documentation to reflect the new configuration.

## Review the deployment

With the resources now migrated to Azure, Contoso needs to fully operationalize and help secure their new infrastructure.

### Security

- Contoso helps ensure that their new `SmartHotel-Registration` database is secure. [Learn more](/azure/azure-sql/database/security-overview).
- In particular, Contoso updates the web apps to use SSL with certificates.

### Backups

- The Contoso team reviews the backup requirements for the Azure SQL Database. [Learn more](/azure/azure-sql/database/automated-backups-overview).
- They also learn about managing SQL Database backups and restores. Learn more about [automatic backups](/azure/azure-sql/database/automated-backups-overview).
- They consider implementing failover groups to provide regional failover for the database. [Learn more](/azure/azure-sql/database/auto-failover-group-overview).
- For resilience, they consider deploying the web app in the main region (`East US 2`) and the secondary region (`Central US`). The team could configure Traffic Manager to ensure failover during regional outages.

### Licensing and cost optimization

- After all resources are deployed, Contoso assigns Azure tags based on their [infrastructure planning](./contoso-migration-infrastructure.md#set-up-tagging).
- All licensing is built into the cost of the PaaS services that Contoso is consuming. This cost is deducted from the Enterprise Agreement.
- Contoso will use [Azure Cost Management + Billing](/azure/cost-management-billing/cost-management-billing-overview) to ensure that they stay within the budgets established by their IT leadership.

## Conclusion

In this article, Contoso refactored the SmartHotel360 application in Azure by migrating the application front-end VM to two Azure App Service web apps. The application database was migrated to Azure SQL Database.
