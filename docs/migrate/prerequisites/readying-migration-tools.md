---
title: Readying migration tools
description: Use this decision tree as high-level guidance for selecting the best tools to use for your Azure migrations based on your migration decisions.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/29/2024
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Readying migration tools

To execute on your migration, you need specific tools for assessment, replication, and tracking your workloads through the iteration, including remediation activities.

While there's various tools available, many are either native to the Azure platform or already commonly available.

Here's a list of common tools necessary for a successful migration project:

|Tool type|Functionality|Native offering|
|---|---|---|
|Discovery & Assessment|Performs automated discovery and assessments of your environment, identifying blockers for migration and identifying dependencies between servers.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Replication|Replicates state data between your on-premises source and a cloud staging environment. Is used to hydrate and migrate the resources.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Tracking|Used to organize project activities, such as group servers into workloads, track remediation activities, and provide status of workload migration.|[Azure DevOps](/azure/devops/user-guide/what-is-azure-devops), Microsoft Excel, and Microsoft Project.|

While you can use tools instead of Azure Migrate, we recommend customers use the native offering unless there's an identified reason. The native offering is built to work seamlessly with the Azure platform and is continuously updated to support the latest features and capabilities.

> [!NOTE]
> **If you're using an existing tool**: If a server is already being replicated to Azure by another tool, it can be disruptive and impact performance to change the tools during this process. If that is the case, you should plan to use the existing tool. You can execute the migration promotion similar to a disaster recovery failover scenario.

## Selecting migration tooling features

Discovery & Assessment and Replication tools can have different methods for operation even inside the same tool.  You should identify which approach after you select your tool.

For example, the [Migration Execution Guide](https://github.com/Azure/migration/) (MEG) guides you on identifying which migration feature to use for Azure Migrate:

> Diagram.

As you execute your workload assessments and execute migrations, you might revise your needs and identify more scenarios to select your migration tools.

## Next steps

> [!div class="nextstepaction"]
> [Migrating from multiple datacenters](./migrate-from-multiple-datacenters.md)
