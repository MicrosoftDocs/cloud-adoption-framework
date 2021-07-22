---
title: Migrate assets
description: Initiate the migration to Azure by identifying the appropriate tools to use, including native tools, third-party tools, and project management tools.
author: matticusau
ms.author: brblanch
ms.date: 09/02/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.localizationpriority: high
ms.custom: think-tank, fasttrack-new, AQC
---

# Deploy workloads and assets (infrastructure, apps, and data)

In this phase of the journey, you use the output of the assessment phase to initiate the migration of the environment. This guide helps identify the appropriate tools to reach a completed state. You'll explore native tools, third-party tools, and project management tools.

## [Native migration tools](#tab/Tools)

The following sections describe the native Azure tools available to perform or assist with migration. For information on choosing the right tools to support your migration efforts, see the [Cloud Adoption Framework's migration tools decision guide](../../decision-guides/migrate-decision-guide/index.md).

### Azure Migrate

Azure Migrate delivers a unified and extensible migration experience. Azure Migrate provides a one-stop, dedicated experience to track your migration journey across the phases of assessment and migration to Azure. It provides you the option to use the tools of your choice and track the progress of migration across these tools.

Azure Migrate is a centralized hub to assess and migrate on-premises servers, infrastructure, applications, and data to Azure. It provides the following functionality:

- Unified platform with assessment, migration, and progress tracking.
- Enhanced assessment and migration capabilities:
  - Assess on-premises servers including SQL Server instances and migrate them to Azure virtual machines or Azure VMware Solution (AVS) (Preview).
  - Agentless migration of VMware virtual machines to Azure.
  - Assess on-premises databases and migrate them to Azure SQL Database or to SQL Managed Instance.
  - Assess on-premises web applications and migrate them to Azure App Service by using the Azure App Service Migration Assistant.
  - Assess your on-premises virtual desktop infrastructure (VDI) and migrate it to Azure Virtual Desktop.
  - Migrate large amounts of data to Azure quickly and cost-effectively using Azure Data Box products.
- Extensible approach with ISV integration (such as Cloudamize).

To perform a migration using Azure Migrate, follow these steps:

1. Search for Azure Migrate under **All services**. Select **Azure Migrate** to continue.
1. 1. In **Overview**, select **Discover, assess and migrate**.
1. Select **Add tools**.
1. In **Project**, select your Azure subscription, then create a resource group if you don't have one.
1. In **Project Details**, specify the project name and geography where you want to create the project, then select **Create**.
1. After creating the project, tools are visible in project and user can start with Discovery.

> [!NOTE]
> For guidance specific to your scenario refer to the tutorials and Azure Migrate [documentation](/azure/migrate/migrate-services-overview).
>

#### Learn more

- [About Azure Migrate](/azure/migrate/migrate-services-overview)
- [Azure Migrate tutorial: Migrate physical or virtualized servers to Azure](/azure/migrate/tutorial-migrate-physical-virtual-machines)

### Azure Database Migration Service

Azure Database Migration Service is a fully managed service that enables seamless migrations from multiple database sources to Azure data platforms, with minimal downtime (online migrations). Database Migration Service performs all of the required steps. You can initiate your migration projects assured that the process takes advantage of best practices recommended by Microsoft.

#### Create an Azure Database Migration Service instance

If this is the first time using Azure Database Migration Service, you need to register the resource provider for your Azure subscription:

1. Select **All services** > **Subscriptions**, and choose the target subscription.
1. Select **Resource providers**.
1. Search for `migration`, and then to the right of **Microsoft.DataMigration**, select **Register**.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/Microsoft_Azure_Billing/SubscriptionsBlade]" submitText="Go to Subscriptions" :::

::: zone-end

<!-- docutune:casing "Create Migration Service wizard" -->

After you register the resource provider, you can create an instance of Azure Database Migration Service.

1. Select **+ Create a resource** and search the marketplace for **Azure Database Migration Service**.
1. Complete the Create Migration Service wizard, then select **Create**.

The service is now ready to migrate the supported source databases to target platforms such as SQL Server, MySQL, PostgreSQL, or MongoDB.

::: zone target="chromeless"

::: form action="Create[#create/Microsoft.AzureDMS]" submitText="Create an Azure Database Migration Service instance" :::

::: zone-end

::: zone target="docs"

For more information, see:

- [Azure Database Migration Service overview](/azure/dms/dms-overview)
- [Create an instance of Azure Database Migration Service](/azure/dms/quickstart-create-data-migration-service-portal)
- [Azure Migrate in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade)
- [Azure portal: create a migration project](https://portal.azure.com/#create/Microsoft.AzureMigrate)

::: zone-end

### Azure App Service Migration Assistant

The Azure App Service Migration Assistant is part of a [larger suite of applications](https://azure.microsoft.com/services/azure-migrate/) that help organizations with their transition to the cloud. The Migration Assistant provides a guided, wizard-like user experience that performs two tasks:

1. It performs an assessment of a specific web app installed on Windows Server by running pre-migration compatibility checks on the web app to determine whether a migration to Azure App Service is possible without modification to the web app.
1. If the assessment proves that the web app can be migrated, the Migration Assistant performs the migration. You'll need to give the Migration Assistant access to your Azure account, select which resource group you want to use, and select a name for the web app, among other details.

Alternatively, the Migration Assistant generates an Azure Resource Manager template that you can use to migrate the web application in a more automated and repeatable way.

#### Migrate a web app to Azure App Service

The Migration Assistant begins the migration process by collecting key details from you about your Azure account and then performs the migration.

First, you'll sign in to your Azure account and associate your Migration Assistant session with your account by using a unique code. Next, you'll choose the subscription, the resource group, and the website's domain name. You can choose to create a new Azure App Service plan to host the web app or select an existing plan. The choice affects the geographical region from which your web app is hosted. You'll also have a chance to associate this migration effort with an existing Azure Migrate project. Finally, you can either choose to skip database setup or choose to set up a hybrid connection to enable a database connection.

After the Migration Assistant collects and verifies your selections, it creates the needed Azure App Service resources in the selected region and resource group. It zips up the web app's source files and uses the Azure App Service deployment API to deploy them. Finally, it performs optional migration steps, like helping you set up a hybrid connection.

After a successful migration, you'll need to perform any post-migration tasks. These might include:

- Manually moving application settings and connection strings in your web.config file to Azure App Service.
- Migrating data from an on-premises SQL Server instance to an Azure SQL Database instance.
- Setting up an SSL certificate.
- Setting up custom domain names.
- Setting up permissions in Azure Active Directory.

You might also decide to change the Azure App Service hosting plan and other settings like autoscaling and deployment slots.

For more information, see:

[Migrate ASP.NET applications to Azure](/learn/paths/migrate-dotnet-apps-azure/)

### Data Migration Assistant

Data Migration Assistant (DMA) helps you upgrade to a modern data platform by detecting compatibility issues that can affect database functionality in your new version of SQL Server or Azure SQL Database. DMA recommends performance and reliability improvements for your target environment and allows you to move your schema, data, and uncontained objects from your source server to your target server.

Data Migration Assistant is integrated with Azure Migrate, allowing you to track all assessment progress in the Azure Migrate dashboard. Launch DMA from Azure Migrate by adding the Azure Migrate: database assessment tool, and add your database assessment to Azure Migrate by selecting the **Upload to Azure Migrate** button in DMA.

> [!NOTE]
> For large migrations (in terms of number and size of databases), we recommend that you use Azure Database Migration Service, which can migrate databases at scale.
>

Start using Data Migration Assistant with these steps:

1. Download and install Data Migration Assistant from the [Microsoft download center](https://www.microsoft.com/download/details.aspx?id=53595).
1. Create an assessment by selecting the **New (+)** icon, then select the **Assessment** project type.
1. Set the source and target server type, then select **Create**.
1. Configure the assessment options as required (recommend all defaults).
1. Add the databases to assess.
1. Select **Next** to start the assessment.
1. View results in Data Migration Assistant.

For an enterprise, we recommend following the approach outlined in [Assess an enterprise and consolidate assessment reports with DMA](/sql/dma/dma-consolidatereports) to assess multiple servers, combine the reports, and then use provided Power BI reports to analyze the results.

For more information, including detailed usage steps, see:

- [Data Migration Assistant overview](/sql/dma/dma-overview)
- [Assess an enterprise and consolidate assessment reports with DMA](/sql/dma/dma-consolidatereports)
- [Analyze consolidated assessment reports created by Data Migration Assistant with Power BI](/sql/dma/dma-consolidatereports)

### SQL Server Migration Assistant

Microsoft SQL Server Migration Assistant (SSMA) is a tool designed to automate database migration to SQL Server from Microsoft access, DB2, MySQL, Oracle, and SAP ASE. The general concept is to collect, assess, and then review with these tools, however, due to the variances in the process for each of the source systems we recommend reviewing the detailed [SQL Server Migration Assistant documentation](/sql/ssma/sql-server-migration-assistant).

For more information, see:

- [SQL Server Migration Assistant overview](/sql/ssma/sql-server-migration-assistant)

### Database Experimentation Assistant

Database Experimentation Assistant (DEA) is a new A/B testing solution for SQL Server upgrades. It will assist in evaluating a targeted version of SQL for a given workload. Customers who are upgrading from previous SQL Server versions (SQL Server 2005 and above) to any new version of the SQL Server can use these analysis metrics.

The Database Experimentation Assistant contains the following workflow activities:

- **Capture:** The first step of SQL Server a/B testing is to capture a trace on your source server. The source server usually is the production server.
- **Replay:** The second step of SQL Server a/B testing is to replay the trace file that was captured to your target servers. Then, collect extensive traces from the replays for analysis.
- **Analysis:** The final step is to generate an analysis report by using the replay traces. The analysis report can help you gain insight about the performance implications of the proposed change.

For more information, see:

- [Overview of Database Experimentation Assistant](/sql/dea/database-experimentation-assistant-overview)

### Azure Cosmos DB data migration tool

Azure Cosmos DB data migration tool can import data from various sources into Azure Cosmos DB collections and tables. You can import from JSON files, CSV files, SQL, MongoDB, Azure Table Storage, Amazon DynamoDB, and even Azure Cosmos DB SQL API collections. The data migration tool can also be used when migrating from a single partition collection to a multipartition collection for the SQL API.

For more information, see:

- [Azure Cosmos DB data migration tool](/azure/cosmos-db/import-data)

## [Third-party migration tools](#tab/third-party-tools)

Several third-party migration tools and ISV services can assist you with the migration process. Each offers different benefits and strengths. These tools include:

### UnifyCloud

UnifyCloud is an ISV service that provides assessment, migration, and modernization automation tools.

[Learn more](https://www.unifycloud.com)

### Cloudamize

Cloudamize is an ISV service that covers all phases of the migration strategy.

[Learn more](https://www.cloudamize.com)

### Zerto

Zerto provides virtual replication handling both Microsoft Hyper-V and VMware vSphere environments.

[Learn more](https://go.microsoft.com/fwlink/?linkid=2152102)

### Carbonite

Carbonite provides server and data migration solutions to migrate workloads to, from, or between any physical, virtual, or cloud-based environment.

[Learn more](https://www.carbonite.com/data-protection/data-migration-software)

### Movere

Movere is a discovery solution that provides the data and insights needed to plan cloud migrations and continuously optimize, monitor, and analyze IT environments with confidence.

[Learn more](https://www.movere.io)

### Azure Cosmos DB partners

You can choose from a variety of experienced systems integrator partners and tools to support your Azure Cosmos DB migrations for your NoSQL database requirements.

[Learn more](/azure/cosmos-db/partners-migration-cosmosdb#migration-tools)

Visit the [Azure migration and modernization center](https://azure.microsoft.com/migration/) to discover organizations offering ready-to-use partner technology solutions to fit your migration scenarios and learn more about additional third-party migration tools and support services.

Visit the [Azure Database Migration Guide](/data-migration/) to see a range of database migration options and step-by-step guidance with native and partners.

## [Project management tools](#tab/project-management-tools)

Projects that aren't tracked and managed are more likely to run into problems. To ensure a successful outcome, we think it's important that you use a project management tool. There are many different tools available and project managers in your organization may already have a favorite.

Azure DevOps is the suggested tool for project management during a cloud migration. To accelerate usage of Azure DevOps, the Cloud Adoption Framework includes a tool for automatically deploying a project template. That template includes the tasks commonly executed during a migration effort. Deploy the template using the instructions in [Cloud adoption plan and Azure DevOps](../../plan/template.md). You can then modify the template to reflect the [workloads](../../plan/workloads.md) and [assets](../../plan/assets.md) to be migrated.

Microsoft also offers the following project management tools, which can work together to provide broader capabilities:

- [Microsoft planner](https://tasks.office.com): A simple, visual way to organize teamwork.
- [Microsoft Project](https://www.microsoft.com/microsoft-365/project/project-management-software): Project and portfolio management, resource capacity management, financial management, timesheet, and schedule management.
- [Microsoft Teams](https://www.microsoft.com/microsoft-teams/group-chat-software): Team collaboration and communication tool. Teams also integrates planner and other tools to improve collaboration.
- [Azure DevOps Services](/azure/devops/user-guide/what-is-azure-devops): The Cloud Adoption Framework planning template is not required to use Azure DevOps. You can use the service without the template to manage your infrastructure as code or use the work items and boards to perform project management. As you mature, your organization can take advantage of the CI/CD capabilities.

These project management tools are not the only tools available. Many other third-party tools are widely used in the project management community.

### Set up for DevOps

As, you migrate into cloud technologies it presents a great opportunity to set up your organization for DevOps and CI/CD. Even if your organization is only managing infrastructure, as you begin to manage your infrastructure as code and use the industry patterns and practices for DevOps you can begin to increase your agility through CI/CD pipelines, therefore allowing you to adapt to change, growth, release, and even recovery scenarios faster.

Azure DevOps provides the required functionality and integration with Azure, on-premises environments, or even other clouds. For more information, see [Azure DevOps](https://azure.microsoft.com/services/devops/). For guided training, see [Quickstart: CI/CD with Azure DevOps](https://microsoft.github.io/PartsUnlimited/pandp/200.1x-PandP-CICDQuickstartwithVSTS.html).

### Suggested skills

Microsoft Learn is a new approach to learning. Readiness for the new skills responsibilities that come with cloud adoption doesn't come easily. Microsoft Learn provides a more rewarding approach to hands-on learning that helps you achieve your goals faster. Earn points and levels, and achieve more!

Here is an example of a tailored learning path on Microsoft Learn that complements the setup for DevOps guidance in the Cloud Adoption Framework.

[Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops/): Collaborate with others to build your applications using Azure Pipelines and GitHub. Run automated tests in your pipeline to validate code quality. Scan your source code and third-party components for potential vulnerabilities. Define multiple pipelines that work together to build your application. Build applications using both Microsoft-hosted agents and your own build agents.

## [Cost management](#tab/ManageCost)

As you migrate resources to your cloud environment, it's important to perform periodic cost analysis. Since the migration process can place additional usage requirements on your services, periodic cost analysis helps you avoid unexpected usage charges. You can also resize resources as needed to balance cost and workload, which is discussed in more detail in the [Optimize and transform](./optimize-and-transform.md) section.
