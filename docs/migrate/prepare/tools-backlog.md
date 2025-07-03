---
title: Prepare tools and initial migration backlog
description: Learn how to prepare an initial migration backlog and migration tools to help you migrate your workloads to Azure.
author: Zimmergren
ms.author: pnp
ms.date: 04/10/2024
ms.topic: conceptual
ms.collection: 
 - migration
---

# Prepare tools and initial migration backlog

To implement your migration, you need the right tools and a comprehensive backlog of workloads to migrate. This article provides guidance on how to prepare for your migration by defining the necessary tools and building an initial migration backlog.

## Prepare migration tools

To successfully complete your migration, you need specific tools for assessing, replicating, and tracking your workloads through iterations, including remediation activities.

Various migration tools are available. Many are either native to the Azure platform or are already commonly available.

Here's a list of common tools or offerings that you need for a successful migration project:

|Tool type|Functionality|Tool|
|---|---|---|
|Discovery and assessment|Performs automated discovery and assessments of your environment. Identifies blockers for migration and identifies dependencies between servers.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Replication|Replicates data state between your on-premises source and a cloud staging environment. Used to hydrate and migrate the resources.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Tracking|Used to organize project activities, such as to group servers into workloads, track remediation activities, and provide the status of a workload migration.|[Azure DevOps](/azure/devops/user-guide/what-is-azure-devops), Excel, and Microsoft Project|
|Migration guide|Helps you identify which migration feature to use for Azure Migrate. The Migration Execution Guide is a project resource that can guide you step by step through the decisions and the implementation of your migration.|[Migration Execution Guide](https://github.com/Azure/migration/)|

Although you can use other tools instead of Azure Migrate, we recommend that you use a native offering unless there's an identified reason. The native offering Azure Migrate is built to work seamlessly with the Azure platform and is continuously updated to support the latest features and capabilities.

> [!NOTE]
> If you use an existing tool to replicate a workload to Azure, changing tools during this process can disrupt and decrease performance. In this scenario, continue to use the existing tool. Later, you can run the migration promotion like a disaster recovery failover scenario.

## Initial migration backlog

The following sections describe the prerequisite activities that you should perform to build an initial migration backlog.

The cloud strategy team is accountable for the care and maintenance of the digital estate. However, addressing the backlog generated from mapping a digital estate falls under the shared responsibility of all roles involved in the migration process. The cloud strategy team and the cloud adoption team should review and understand the migration backlog before the teams begin to plan individual workload activities. During review, members of both teams must gain sufficient knowledge to articulate the following key points about the migration backlog.

### Business outcomes and metrics

Every member of the team should understand the intended business outcomes. Migrations take time. It's easy for team members to become distracted by urgent but less strategic activities at different stages of a migration. Establishing and reinforcing intended outcomes helps team members understand the prioritization and relative importance of migration activities so that they make better decisions over time.

Tracking migration progress is equally important both to the migration team's motivation and to continued stakeholder support. Track progress through migration KPIs and by monitoring metrics. Regardless of how you track the effort, it's important for the team to be aware of key metrics so that it can evaluate performance during subsequent iterations.

### Business priorities

Sometimes, prioritizing one workload over another might not seem logical or even beneficial to the cloud adoption team. Understanding the business priorities that drive workload prioritization decisions can help the team maintain critical motivation. It also helps the team make a stronger contribution during the prioritization decision-making process.

### Core assumptions

[Digital estate rationalization](../../digital-estate/rationalize.md) discusses the agility and time-saving impact of working from basic assumptions when you evaluate a digital estate. To fully realize those values, the cloud adoption team needs to understand the assumptions, and the reasons that assumptions were established. That knowledge better equips the team to challenge assumptions for effectiveness and savings.

### Capture the backlog

Capture the backlog in a location that you can share with all members of the cloud adoption team. From a shared location, different team members can align their knowledge and work to the backlog, and you can keep the backlog current throughout the migration process.

You can both use tools that are familiar in your organization, and build on the tools that you use to complete your digital estate rationalization.

If you're looking for prebuilt templates, the [Migration Execution Guide](https://github.com/Azure/migration) has spreadsheet templates that can help you organize your backlog.

It's important to associate workloads with servers, so you can track a workload itself through individual server migrations in the backlog. You can also use the backlog to showcase dependencies between workloads as you complete the assessment. When you [remediate assets](../deploy/remediate.md) and complete testing, you merge the backlog with a remediation plan.

The backlog is used throughout the migration process. Maintaining the backlog is critical.

### Plan the backlog for multiple datacenters

Before you begin your migration, you should create epics in the project management tool for each datacenter that you migrate. In a datacenter epic, you can group associated work so that you can track the status of each datacenter location.

If you don't use epics to manage your migration, you can use top-level goals or groupings for datacenters. The key is that you can filter, organize, and track each datacenter as a separate location.

It's important to understand the business outcomes and motivations for your migration. Use those motivations to prioritize the list of epics (or datacenters). For example, if the intention to migrate from an on-premises datacenter before the end of your current lease drives your migration, prioritize epics by using lease renewal dates.

Within each epic, manage workloads that you assess and migrate as features. Manage each asset within that workload as a user story. Tasks represent work to assess, migrate, optimize, promote, secure, and manage each asset.

A sprint or iteration is a series of tasks that are required to migrate the assets and user stories that the cloud adoption team commits to. A sprint typically is a segment of time, like a fiscal quarter or a calendar month. A release represents one or more workloads or features that are promoted to production.

## Next step

> [!div class="nextstepaction"]
> [Plan for resilience](./select-regions-migration.md)
