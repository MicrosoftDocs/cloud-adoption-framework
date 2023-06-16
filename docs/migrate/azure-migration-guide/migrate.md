---
title: Migrate assets
description: Learn how to start the migration to Azure by identifying the best tools to use, including native tools, third-party tools, and project management tools.
author: matticusau
ms.author: martinek
ms.date: 08/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, fasttrack-new, AQC
---

# Migrate assets

In this phase of the adoption journey, use the output of the assessment phase to begin migrating your environment. Migrating your environment involves deploying workloads and assets, like infrastructure, apps, and data. This article helps you find the best tools for your migration. Explore native tools, third-party tools, and project management tools.

## Native migration tools

The following sections describe the native Azure tools that perform or help with migration. To learn how to choose the right tools to support your migration efforts, see the [Cloud Adoption Framework's migration tools decision guide](./migration-tools-decision-guide.md).

### Azure Migrate

Azure Migrate is a one-stop, extensible migration experience. Use Azure Migrate to track your Azure migration journey from assessment to migration. You can choose your migration tools, and track your migration progress in the tools.

Azure Migrate is a centralized hub where you can assess and then migrate on-premises servers, infrastructure, applications, and data to Azure. Azure Migrate offers these features:

- Unified platform, with assessment, migration, and progress tracking.
- Enhanced assessment and migration capabilities:
  - Assess on-premises servers, including SQL Server instances, and migrate them to Azure Virtual Machines or Azure VMware Solution.
  - Agentless migration of VMware virtual machines to Azure.
  - Assess on-premises databases and migrate them to Azure SQL Database or Azure SQL Managed Instance.
  - Assess on-premises web applications and migrate them to Azure App Service by using Azure App Service Migration Assistant.
  - Assess your on-premises virtual desktop infrastructure and migrate it to Azure Virtual Desktop.
  - Migrate large amounts of data to Azure quickly and cost-effectively using Azure Data Box products.
- Extensible approach with ISV integration (such as Cloudamize).

To perform a migration using Azure Migrate, follow these steps:

1. Search for Azure Migrate under **All services**. Select **Azure Migrate** to continue.
1. In **Get started**, select **Discover, assess and migrate**.
1. Select **Add tools**.
1. In **Project**, select your Azure subscription, then create a resource group if you don't have one.
1. In **Project Details**, specify the project name and geography where you want to create the project, then select **Create**.
1. After you create the project, tools are visible in the project, and the user can start with discovery.

> [!NOTE]
> For guidance specific to your scenario, see the tutorials and [Azure Migrate documentation](/azure/migrate/migrate-services-overview).
>

#### Learn more

- [About Azure Migrate](/azure/migrate/migrate-services-overview)
- [Azure Migrate tutorial: Migrate physical or virtualized servers to Azure](/azure/migrate/tutorial-migrate-physical-virtual-machines)

### Azure Database Migration Service

Azure Database Migration Service is a fully managed service that enables seamless migrations from multiple database sources to Azure data platforms, with minimal downtime (online migrations). Database Migration Service performs all of the required steps. You can initiate your migration projects assured that the process takes advantage of best practices recommended by Microsoft.

#### Create an Azure Database Migration Service instance

The first time you use Azure Database Migration Service, you must register the resource provider for your Azure subscription:

1. Select **All services**. Under **General**, select **Subscriptions**, and choose the subscription to use.
1. Select **Resource providers**.
1. Search for `migration`. In the search results, to the right of **Microsoft.DataMigration**, select **Register**.

<!-- docutune:casing "Create Migration Service wizard" -->

After you register the resource provider, create an instance of Azure Database Migration Service.

1. Select **+ Create a resource** and search Marketplace for **Azure Database Migration Service**.
1. Complete the Create Migration Service wizard, then select **Create**.

The service is now ready to migrate the supported source databases to target platforms such as SQL Server, MySQL, PostgreSQL, or MongoDB.

For more information, see:

- [Azure Database Migration Service overview](/azure/dms/dms-overview)
- [Create an instance of Azure Database Migration Service](/azure/dms/quickstart-create-data-migration-service-portal)
- [Azure Migrate in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade)
- [Azure portal: create a migration project](https://portal.azure.com/#create/Microsoft.AzureMigrate)

### Azure App Service Migration Assistant

The Azure App Service Migration Assistant is part of a [larger suite of applications](https://azure.microsoft.com/services/azure-migrate/) that help organizations with their transition to the cloud. The Migration Assistant provides a guided, wizard-like experience that performs two tasks.

1. Azure App Service Migration Assistant assesses a specific web app that's installed on a computer running Windows Server. Migration Assistant runs pre-migration compatibility checks on the web app to see whether it can migrate to Azure App Service without modification.
1. If the assessment shows that the web app can be migrated without being modified, Migration Assistant migrates the app. You'll need to give Migration Assistant access to your Azure account. You also select the resource group to use and enter a name for the web app, among other details.

Alternatively, the Migration Assistant generates an Azure Resource Manager template that you can use to migrate the web application in a more automated and repeatable way.

#### Migrate a web app to Azure App Service

The Migration Assistant begins the migration process by collecting key details from you about your Azure account and then does the migration.

First, you'll sign in to your Azure account and associate your Migration Assistant session with your account by using a unique code. Next, you'll choose the subscription, the resource group, and the website's domain name. You can choose to create a new Azure App Service plan to host the web app or select an existing plan. The choice you make affects the geographical region from which your web app is hosted. You'll also have a chance to associate this migration effort with an existing Azure Migrate project. Finally, you can either choose to skip database setup or choose to set up a hybrid connection to enable a database connection.

After the Migration Assistant collects and verifies your selections, it creates required Azure App Service resources in the selected region and resource group. It zips the web app's source files and uses the Azure App Service deployment API to deploy the files. It completes final, optional migration steps, like helping you set up a hybrid connection.

After a successful migration, some post-migration tasks might include:

- Manually move application settings and connection strings in your `web.config` file to Azure App Service.
- Migrate data from an on-premises SQL Server instance to an Azure SQL Database instance.
- Set up an SSL certificate.
- Set up custom domain names.
- Set up permissions in Azure Active Directory.

You might also decide to change the Azure App Service hosting plan and other settings like autoscaling and deployment slots.

For more information, see [Migrate ASP.NET applications to Azure](/training/paths/migrate-dotnet-apps-azure/).

### Data Migration Assistant

Data Migration Assistant helps you upgrade to a modern data platform. It detects compatibility issues that can affect database functionality in your new version of SQL Server or Azure SQL Database. Data Migration Assistant recommends performance and reliability improvements for your target environment. You can use Data Migration Assistant to move your schema, data, and uncontained objects from your source server to your target server.

Data Migration Assistant is integrated with Azure Migrate, so you can track assessment progress in the Azure Migrate dashboard. Open Data Migration Assistant in Azure Migrate by adding the Azure Migrate database assessment tool. Add your database assessment to Azure Migrate by selecting **Upload to Azure Migrate** in Data Migration Assistant.

> [!NOTE]
> For large migrations (in terms of number and size of databases), we recommend that you use Azure Database Migration Service, which can migrate databases at scale.
>

To begin using Data Migration Assistant:

1. Download and install Data Migration Assistant from the [Microsoft download center](https://www.microsoft.com/download/details.aspx?id=53595).
1. Create an assessment by selecting the **New (+)** icon, then select the **Assessment** project type.
1. Set the source and target server type, then select **Create**.
1. Configure the assessment options as required (recommend all defaults).
1. Add the databases to assess.
1. Select **Next** to start the assessment.
1. View results in Data Migration Assistant.

For an enterprise, we recommend following the approach outlined in [Assess an enterprise and consolidate assessment reports with DMA](/azure/migrate/tutorial-assess-sql). You assess multiple servers, combine the reports, and then use provided Power BI reports to analyze the results.

For more information, including detailed usage steps, see these resources:

- [Data Migration Assistant overview](/sql/dma/dma-overview)
- [Assess an enterprise and consolidate assessment reports with DMA](/azure/migrate/tutorial-assess-sql)
- [Analyze consolidated assessment reports created by Data Migration Assistant with Power BI](/azure/migrate/tutorial-assess-sql)

### SQL Server Migration Assistant

Microsoft SQL Server Migration Assistant (SSMA) automates database migration to SQL Server from Microsoft access, DB2, MySQL, Oracle, and SAP ASE. The general concept is to collect, assess, and then review with these tools. But due to the variances in the process for each of the source systems, review the detailed [SQL Server Migration Assistant documentation](/sql/ssma/sql-server-migration-assistant).

For more information, see [SQL Server Migration Assistant overview](/sql/ssma/sql-server-migration-assistant).

### Database Experimentation Assistant

Database Experimentation Assistant is an A/B testing solution for SQL Server upgrades. Database Experimentation Assistant helps you evaluate a targeted version of SQL for a specific workload. If you're upgrading from an earlier version of SQL Server (SQL Server 2005 and later) to any current version of SQL Server, you can use these analysis metrics.

The Database Experimentation Assistant contains the following workflow activities:

- **Capture:** The first step of SQL Server A/B testing is to capture a trace on your source server. Usually, the source server is the production server.
- **Replay:** The second step of SQL Server A/B testing is to replay the trace file that was captured to your target servers. Then, collect extensive traces from the replays for analysis.
- **Analysis:** The final step is to generate an analysis report by using the replay traces. The analysis report can help you gain insight about the performance implications of the proposed change.

For more information, see [Overview of Database Experimentation Assistant](/sql/dea/database-experimentation-assistant-overview).

### Azure Cosmos DB data migration tool

Azure Cosmos DB data migration imports data from various sources into Azure Cosmos DB collections and tables. You can import from JSON files, CSV files, SQL, MongoDB, Azure Table Storage, Amazon DynamoDB, and even Azure Cosmos DB for NoSQL collections. You can also use the data migration tool when migrating from a single partition collection to a multipartition collection in Azure Cosmos DB for NoSQL.

For more information, see [Azure Cosmos DB data migration tool](/azure/cosmos-db/import-data).

### Migrate to Azure Storage (blob) or Azure Data Lake Store with Azure Data Factory

Migrate data at scale with Azure Data Factory (ADF). ADF offers a serverless architecture that allows parallelism at different levels, which maximizes data movement throughput for your environment. ADF supports both initial snapshot migration and delta data migration.

For more information, see the following links:

- [Why Azure Data Factory can be used for data migration](/azure/data-factory/data-migration-guidance-overview).
- [Migrate data from AWS S3 to Azure](/azure/data-factory/data-migration-guidance-s3-azure-storage).
- [Migrate data from on-premises hadoop cluster to Azure](/azure/data-factory/data-migration-guidance-hdfs-azure-storage)
- [Migrate data from on-premises Netezza server to Azure](/azure/data-factory/data-migration-guidance-netezza-azure-sqldw).

## Third-party migration tools

Several third-party migration tools and ISV services can help you with the migration process. Each offers different benefits and strengths. These tools include:

### UnifyCloud

UnifyCloud is an ISV service that provides assessment, migration, and modernization automation tools.

For more information, see [UnifyCloud](https://www.unifycloud.com).

### Cloudamize

Cloudamize is an ISV service that covers all phases of the migration strategy.

For more information, see [Cloudamize](https://www.cloudamize.com).

### Zerto

Zerto provides virtual replication handling for both Microsoft Hyper-V and VMware vSphere environments.

For more information, see [Zerto](https://go.microsoft.com/fwlink/?linkid=2152102).

### Carbonite

Carbonite provides server and data migration solutions to migrate workloads to, from, or between any physical, virtual, or cloud-based environment.

For more information, see [Carbonite](https://www.carbonite.com/data-protection/data-migration-software).

### Movere

Movere, acquired by Microsoft in 2019, is a discovery solution that provides the required data and insights to plan cloud migrations and continuously optimize, monitor, and analyze IT environments with confidence.

For more information, see [Movere](https://www.movere.io).

### Azure Cosmos DB partners

You can choose between multiple experienced systems, integrator partners, and tools to support your Azure Cosmos DB migrations for your NoSQL database requirements.

For more information, see [Azure Cosmos DB partners migration](/azure/cosmos-db/partners-migration-cosmosdb#migration-tools).

Visit the [Azure migration and modernization center](https://azure.microsoft.com/migration/) to discover ready-to-use partner technology solutions to fit your migration scenarios. And you can also learn about other third-party migration tools and support services.

Visit the [Azure Database Migration Guide](/data-migration/) to see a range of database migration options and step-by-step guidance with native and partners.

## Project management tools

Projects that aren't tracked and managed are more likely to run into problems. To ensure a successful outcome, it's important to use a project management tool. There are many different tools available. Project managers in your organization might already have a favorite.

Azure DevOps is the suggested tool for project management during a cloud migration. To accelerate usage of Azure DevOps, the Cloud Adoption Framework includes a tool for automatically deploying a project template. That template includes the tasks commonly run during a migration effort. Deploy the template using the instructions in [Cloud adoption plan and Azure DevOps](../../plan/template.md). You can then modify the template to reflect the [workloads](../../plan/workloads.md) and [assets](../../plan/assets.md) to be migrated.

Microsoft also offers the following project management tools, which can work together to provide broader capabilities:

- [Microsoft planner](https://tasks.office.com): A simple, visual way to organize teamwork.
- [Microsoft Project](https://www.microsoft.com/microsoft-365/project/project-management-software): Project and portfolio management, resource capacity management, financial management, timesheet, and schedule management.
- [Microsoft Teams](https://www.microsoft.com/microsoft-teams/group-chat-software): Team collaboration and communication tool. Teams also integrates planner and other tools to improve collaboration.
- [Azure DevOps Services](/azure/devops/user-guide/what-is-azure-devops): The Cloud Adoption Framework planning template isn't required to use Azure DevOps. You can use the service without the template to manage your infrastructure as code. Or you can use the work items and boards to do your project management. As your solution matures, your organization can also take advantage of the CI/CD capabilities.

These project management tools aren't the only tools available. Many other third-party tools are widely used in the project management community.

### Set up for DevOps

When you migrate into cloud technologies, it presents a great opportunity to set up your organization for DevOps and CI/CD. Even if your organization is only managing infrastructure, consider the following points. As you begin to manage your infrastructure as code and use the industry patterns and practices for DevOps, you can start to increase your agility through CI/CD pipelines. You'll be able to adapt to change, growth, release, and even recovery scenarios faster.

Azure DevOps provides the required functionality and integration with Azure, on-premises environments, or even other clouds. For more information, see [Azure DevOps](https://azure.microsoft.com/services/devops/). For guided training, see [Quickstart: CI/CD with Azure DevOps](https://microsoft.github.io/PartsUnlimited/pandp/200.1x-PandP-CICDQuickstartwithVSTS.html).

### Suggested skills

Microsoft Learn is a new approach to learning. The skills and responsibilities that come with cloud adoption don't necessarily come easily. Microsoft Learn provides rewarding, hands-on learning modules that help you reach your goals faster. Earn points and levels while you learn and achieve more.

Here's an example of a tailored learning path that complements the setup for DevOps guidance in the Cloud Adoption Framework.

[Build applications with Azure DevOps](/training/paths/build-applications-with-azure-devops/): Collaborate with others to build your applications using Azure Pipelines and GitHub. Run automated tests in your pipeline to validate code quality. Scan your source code and third-party components for potential vulnerabilities. Define multiple pipelines that work together to build your application. Build applications using both Microsoft-hosted agents and your own build agents.

## Cost management

As you migrate resources to your cloud environment, it's important to perform periodic cost analysis. Since the migration process can place other usage requirements on your services, periodic cost analysis helps you avoid unexpected charges. You can also resize resources as needed to balance cost and workload, which is discussed in more detail in the [Optimize and transform](./optimize-and-transform.md) section.
