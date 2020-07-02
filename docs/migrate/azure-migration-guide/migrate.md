---
title: "Migrate assets"
description: Initiate the migration to Azure by identifying the appropriate tools to use, including native tools, third-party tools, and project management tools.
author: matticusau
ms.author: mlavery
ms.date: 08/08/2019
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: fasttrack-new, AQC
ms.localizationpriority: high
---

<!-- cSpell:ignore Cloudamize agentless uncontained SSMA Carbonite Movere -->

# Deploy workloads and assets (infrastructure, apps, and data)

In this phase of the journey, you use the output of the Assess phase to initiate the migration of the environment. This guide helps identify the appropriate tools to reach a completed state, including native tools, third-party tools, and project management tools.

<!-- markdownlint-disable MD025 -->

# [Native migration tools](#tab/Tools)

The following sections describe the native Azure tools available to perform or assist with migration. For information on choosing the right tools to support your migration efforts, see the [Cloud Adoption Framework's Migration tools decision guide](../../decision-guides/migrate-decision-guide/index.md).

## Azure Migrate

Azure Migrate delivers a unified and extensible migration experience. Azure Migrate provides a one-stop, dedicated experience to track your migration journey across the phases of assessment and migration to Azure. It provides you the option to use the tools of your choice and track the progress of migration across these tools.

Azure Migrate provides the following functionality:

1. Enhanced assessment and migration capabilities:
    - Hyper-V assessments.
    - Improved VMware assessment.
    - Agentless migration of VMware virtual machines to Azure.
1. Unified assessment, migration, and progress tracking.
1. Extensible approach with ISV integration (such as Cloudamize).

To perform a migration using Azure Migrate follow these steps:

1. Search for Azure Migrate under **All services**. Select **Azure Migrate** to continue.
1. Select **Add a tool** to start your migration project.
1. Select the subscription, resource group, and geography to host the migration.
1. Select **Select assessment tool** > **Azure Migrate: Server Assessment** >  **Next**.
1. Select **Review + add tools**, and verify the configuration. Select **Add tools** to initiate the job to create the migration project and register the selected solutions.

### Learn more

- [Azure Migrate tutorial - Migrate physical or virtualized servers to Azure](https://docs.microsoft.com/azure/migrate/tutorial-migrate-physical-virtual-machines)

## Azure Site Recovery

The Azure Site Recovery service can manage the migration of on-premises resources to Azure. It can also manage and orchestrate disaster recovery of on-premises machines and Azure VMs for business continuity and disaster recovery (BCDR) purposes.

The following steps outline the process to use Site Recovery to migrate:

> [!TIP]
> Depending on your scenario, these steps may differ slightly. For more information, see the [Migrate on-premises machines to Azure](https://docs.microsoft.com/azure/site-recovery/migrate-tutorial-on-premises-azure) article.

### Prepare Azure Site Recovery service

1. In the Azure portal, select **+Create a resource > Management Tools > Backup and Site Recovery**.
1. If you haven't yet created a recovery vault, complete the wizard to create a **Recovery Services vault** resource.
1. In the **Resource** menu, select **Site Recovery > Prepare Infrastructure > Protection goal**.
1. In **Protection goal**, select what you want to migrate.
    1. **VMware:** Select **To Azure > Yes, with VMware vSphere Hypervisor**.
    1. **Physical machine:** Select **To Azure > Not virtualized/Other**.
    1. **Hyper-V:** Select **To Azure > Yes, with Hyper-V**. If Hyper-V VMs are managed by VMM, select **Yes**.

### Configure migration settings

1. Set up the source environment as appropriate.
1. Set up the target environment.
    1. Select **Prepare infrastructure > Target**, then select the Azure subscription you want to use.
    1. Specify the Resource Manager deployment model.
    1. Site Recovery checks that you have one or more compatible Azure storage accounts and networks.
1. Set up a replication policy.
1. Enable replication.
1. Run a test migration (test failover).

### Migrate to Azure using failover

1. In **Settings > Replicated items** select the machine > **Failover**.
1. In **Failover** select a **Recovery Point** to fail over to. Select the latest recovery point.
1. Configure any encryption key settings as required.
1. Select **Shut down machine before beginning failover**. Site Recovery will attempt to shut down virtual machines before triggering the failover. Failover continues even if shutdown fails. You can follow the failover progress on the Jobs page.
1. Check that the Azure VM appears in Azure as expected.
1. In **Replicated items**, right-click the VM and choose **Complete Migration**.
1. Perform any post-migration steps as required (see relevant information in this guide).

::: zone target="chromeless"

::: form action="Create[#create/Microsoft.RecoveryServices]" submitText="Create a Recovery Services vault" :::

::: zone-end

::: zone target="docs"

For more information, see:

- [Migrate on-premises machines to Azure](https://docs.microsoft.com/azure/site-recovery/migrate-tutorial-on-premises-azure)

::: zone-end

## Azure Database Migration Service

Azure Database Migration Service is a fully managed service that enables seamless migrations from multiple database sources to Azure data platforms, with minimal downtime (online migrations). Database Migration Service performs all of the required steps. You can initiate your migration projects assured that the process takes advantage of best practices recommended by Microsoft.

### Create an Azure Database Migration Service instance

If this is the first time using Azure Database Migration Service, you need to register the resource provider for your Azure subscription:

1. Select **All services**, then **Subscriptions**, and choose the target subscription.
1. Select **Resource providers**.
1. Search for `migration`, and then to the right of **Microsoft.DataMigration**, select **Register**.

::: zone target="chromeless"

::: form action="OpenBlade[#blade/Microsoft_Azure_Billing/SubscriptionsBlade]" submitText="Go to Subscriptions" :::

::: zone-end

After you register the resource provider, you can create an instance of Azure Database Migration Service.

1. Select **+Create a resource** and search the marketplace for **Azure Database Migration Service**.
1. Complete the **Create Migration Service** wizard, then select **Create**.

The service is now ready to migrate the supported source databases (for example, SQL Server, MySQL, PostgreSQL, or MongoDB).

::: zone target="chromeless"

::: form action="Create[#create/Microsoft.AzureDMS]" submitText="Create an Azure Database Migration Service instance" :::

::: zone-end

::: zone target="docs"

For more information, see:

- [Azure Database Migration Service overview](https://docs.microsoft.com/azure/dms/dms-overview)
- [Create an instance of Azure Database Migration Service](https://docs.microsoft.com/azure/dms/quickstart-create-data-migration-service-portal)
- [Azure Migrate in the Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_ManagementGroups/HierarchyBlade)
- [Azure portal: Create a migration project](https://portal.azure.com/#create/Microsoft.AzureMigrate)

::: zone-end

## Data Migration Assistant

Data Migration Assistant helps you upgrade to a modern data platform by detecting compatibility issues that can affect database functionality in your new version of SQL Server or Azure SQL Database. DMA recommends performance and reliability improvements for your target environment and allows you to move your schema, data, and uncontained objects from your source server to your target server.

> [!NOTE]
> For large migrations (in terms of number and size of databases), we recommend that you use Azure Database Migration Service, which can migrate databases at scale.
>

Start using Data Migration Assistant with these steps:

1. Download and install Data Migration Assistant from the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=53595).
1. Create an assessment by selecting the **New (+)** icon, then select the **Assessment** project type.
1. Set the source and target server type, then select **Create**.
1. Configure the assessment options as required (recommend all defaults).
1. Add the databases to assess.
1. Select **Next** to start the assessment.
1. View results in Data Migration Assistant.

For an enterprise, we recommend following the approach outlined in [Assess an enterprise and consolidate assessment reports with DMA](https://docs.microsoft.com/sql/dma/dma-consolidatereports) to assess multiple servers, combine the reports and then use provided Power BI reports to analyze the results.

For more information, including detailed usage steps, see:

- [Data Migration Assistant overview](https://docs.microsoft.com/sql/dma/dma-overview)
- [Assess an enterprise and consolidate assessment reports with DMA](https://docs.microsoft.com/sql/dma/dma-consolidatereports)
- [Analyze consolidated assessment reports created by Data Migration Assistant with Power BI](https://docs.microsoft.com/sql/dma/dma-powerbiassesreport)

## SQL Server Migration Assistant

Microsoft SQL Server Migration Assistant (SSMA) is a tool designed to automate database migration to SQL Server from Microsoft Access, DB2, MySQL, Oracle, and SAP ASE. The general concept is to collect, assess, and then review with these tools, however, due to the variances in the process for each of the source systems we recommend reviewing the detailed [SQL Server Migration Assistant documentation](https://docs.microsoft.com/sql/ssma/sql-server-migration-assistant).

For more information, see:

- [SQL Server Migration Assistant overview](https://docs.microsoft.com/sql/ssma/sql-server-migration-assistant)

## Database Experimentation Assistant

Database Experimentation Assistant (DEA) is a new A/B testing solution for SQL Server upgrades. It will assist in evaluating a targeted version of SQL for a given workload. Customers who are upgrading from previous SQL Server versions (SQL Server 2005 and above) to any new version of the SQL Server can use these analysis metrics.

The Database Experimentation Assistant contains the following workflow activities:

- **Capture:** The first step of SQL Server A/B testing is to capture a trace on your source server. The source server usually is the production server.
- **Replay:** The second step of SQL Server A/B testing is to replay the trace file that was captured to your target servers. Then, collect extensive traces from the replays for analysis.
- **Analysis:** The final step is to generate an analysis report by using the replay traces. The analysis report can help you gain insight about the performance implications of the proposed change.

For more information, see:

- [Overview of Database Experimentation Assistant](https://docs.microsoft.com/sql/dea/database-experimentation-assistant-overview)

## Azure Cosmos DB Data Migration Tool

Azure Cosmos DB Data Migration tool can import data from various sources into Azure Cosmos DB collections and tables. You can import from JSON files, CSV files, SQL, MongoDB, Azure Table storage, Amazon DynamoDB, and even Azure Cosmos DB SQL API collections. The Data Migration tool can also be used when migrating from a single partition collection to a multipartition collection for the SQL API.

For more information, see:

- [Azure Cosmos DB Data Migration Tool](https://docs.microsoft.com/azure/cosmos-db/import-data)

<!-- markdownlint-disable MD025 -->

# [Third-party migration tools](#tab/third-party-tools)

Several third-party migration tools and ISV services can assist you with the migration process. Each offers different benefits and strengths. These tools include:

## UnifyCloud

UnifyCloud is an ISV service that provides assessment, migration and modernization automation tools.

[Learn more](https://www.unifycloud.com)

## Cloudamize

Cloudamize is an ISV service that covers all phases of the migration strategy.

[Learn more](https://www.cloudamize.com)

## Zerto

Zerto provides virtual replication handling both Microsoft Hyper-V and VMware vSphere environments.

[Learn more](https://www.zerto.com/modernize)

## Carbonite

Carbonite provides server and data migration solutions to migrate workloads to, from, or between any physical, virtual, or cloud-based environment.

[Learn more](https://www.carbonite.com/data-protection/data-migration-software)

## Movere

Movere is a discovery solution that provides the data and insights needed to plan cloud migrations and continuously optimize, monitor, and analyze IT environments with confidence.

[Learn more](https://www.movere.io)

## Azure Cosmos DB Partners

You can choose from a variety of experienced systems integrator partners and tools to support your Azure Cosmos DB migrations for your NoSQL database requirements.

[Learn more](https://docs.microsoft.com/azure/cosmos-db/partners-migration-cosmosdb#migration-tools)

Visit the [Azure Migration Center](https://azure.microsoft.com/migration/support) to discover organizations offering ready-to-use partner technology solutions to fit your migration scenarios and learn more about additional third-party migration tools and support services.

Visit the [Azure Database Migration Guide](https://datamigration.microsoft.com) to see a range of database migration options and step-by-step guidance with native and partners.

# [Project management tools](#tab/project-management-tools)

Projects that aren't tracked and managed are more likely to run into problems. To ensure a successful outcome, we think it's important that you use a project management tool. There are many different tools available and project managers in your organization may already have a favorite.

Azure DevOps is the suggested tool for project management during a cloud migration. To accelerate usage of Azure DevOps, the Cloud Adoption Framework includes a tool for automatically deploying a project template. That template includes the tasks commonly executed during a migration effort. Deploy the template using the instructions in [Cloud adoption plan and Azure DevOps](https://docs.microsoft.com/azure/architecture/cloud-adoption/plan/template). You can then modify the template to reflect the [workloads](https://docs.microsoft.com/azure/architecture/cloud-adoption/plan/workloads) and [assets](https://docs.microsoft.com/azure/architecture/cloud-adoption/plan/assets) to be migrated.

Microsoft also offers the following project management tools, which can work together to provide broader capabilities:

- [Microsoft Planner](https://tasks.office.com): A simple, visual way to organize teamwork.
- [Microsoft Project](https://products.office.com/project/project-and-portfolio-management-software): Project and Portfolio Management, Resource Capacity Management, Financial Management, Timesheet and Schedule Management.
- [Microsoft Teams](https://products.office.com/microsoft-teams): Team collaboration and communication tool. Teams also integrates Planner and other tools to improve collaboration.
- [Azure DevOps Services](https://docs.microsoft.com/azure/devops/user-guide/what-is-azure-devops?view=azure-devops): The Cloud Adoption Framework planning template is not required to use Azure DevOps. You can use the service without the template to manage your infrastructure as code or use the work items and boards to perform project management. As you mature, your organization can take advantage of the CI/CD capabilities.

These are not the only tools available. Many other third-party tools are widely used in the project management community.

## Set up for DevOps

As you migrate into cloud technologies this presents a great opportunity to set up your organization for DevOps and CI/CD. Even if your organization is only managing infrastructure, as you begin to manage your infrastructure as code and use the industry patterns and practices for DevOps you can begin to increase your agility through CI/CD pipelines, therefore allowing you to adapt to change, growth, release, and even recovery scenarios faster.

Azure DevOps provides all of the required functionality and integration with Azure, on-premises environments, or even other clouds. For more information, see [Azure DevOps Services](https://docs.microsoft.com/azure/devops/user-guide/what-is-azure-devops?view=azure-devops). For guided training, see [CI/CD with Azure DevOps - Quickstart](https://microsoft.github.io/PartsUnlimited/pandp/200.1x-PandP-CICDQuickstartwithVSTS.html).

## Suggested skills

Microsoft Learn is a new approach to learning. Readiness for the new skills responsibilities that come with cloud adoption doesn't come easily. Microsoft Learn provides a more rewarding approach to hands-on learning that helps you achieve your goals faster. Earn points and levels, and achieve more!

Here is an example of a tailored learning path on Microsoft Learn that complements the setup for DevOps guidance in the Cloud Adoption Framework.

[Build applications with Azure DevOps](https://docs.microsoft.com/learn/paths/build-applications-with-azure-devops): Collaborate with others to build your applications using Azure Pipelines and GitHub. Run automated tests in your pipeline to validate code quality. Scan your source code and third-party components for potential vulnerabilities. Define multiple pipelines that work together to build your application. Build applications using both Microsoft-hosted agents and your own build agents.

# [Cost management](#tab/ManageCost)

As you migrate resources to your cloud environment, it's important to perform periodic cost analysis. This helps you avoid unexpected usage charges, since the migration process can place additional usage requirements on your services. You can also resize resources as needed to balance cost and workload, which is discussed in more detail in the [Optimize and transform](./optimize-and-transform.md)** section.
