---
title: Prepare tools and initial migration backlog
description: Learn how to prepare an initial migration backlog and migration tools to help you migrate your workloads to Azure.
author: Zimmergren
ms.author: tozimmergren
ms.date: 02/29/2024
ms.topic: conceptual
---

# Prepare tools and initial migration backlog

Executing on your migration requires the right tools and a comprehensive backlog of workloads to migrate. This article provides guidance on how to prepare for your migration by defining the necessary tools and building an initial migration backlog.

## Preparing migration tools

To execute on your migration, you need specific tools for assessment, replication, and tracking your workloads through the iteration, including remediation activities.

While there's various tools available, many are either native to the Azure platform or already commonly available.

Here's a list of common tools necessary for a successful migration project:

|Tool type|Functionality|Native offering|
|---|---|---|
|Discovery & Assessment|Performs automated discovery and assessments of your environment, identifying blockers for migration and identifying dependencies between servers.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Replication|Replicates state data between your on-premises source and a cloud staging environment. Is used to hydrate and migrate the resources.|[Azure Migrate](/azure/migrate/migrate-services-overview)|
|Tracking|Used to organize project activities, such as group servers into workloads, track remediation activities, and provide status of workload migration.|[Azure DevOps](/azure/devops/user-guide/what-is-azure-devops), Microsoft Excel, and Microsoft Project.|
|Migration Execution Guide|The Migration Execution Guide (MEG) guides you on identifying which migration feature to use for Azure Migrate. The MEG is a project resource that can guide you step by step through the decisions and execution steps of your migration.|The[Migration Execution Guide](https://github.com/Azure/migration/)|

While you can use tools instead of Azure Migrate, we recommend customers use the native offering unless there's an identified reason. The native offering is built to work seamlessly with the Azure platform and is continuously updated to support the latest features and capabilities.

> [!NOTE]
> **If you're using an existing tool**: If a server is already being replicated to Azure by another tool, it can be disruptive and impact performance to change the tools during this process. If that is the case, you should plan to use the existing tool. You can execute the migration promotion similar to a disaster recovery failover scenario.

## Initial migration backlog

This section serves as a milestone to complete prerequisite activities for building an initial migration backlog.

The cloud strategy team is accountable for the care and maintenance of the digital estate. However, the realization of the resultant backlog is the responsibility of every member of the migration effort. As a final prerequisite, the cloud strategy team and the cloud adoption team should review and understand the migration backlog before planning individual workload activities. During that review, the members of both teams must gain sufficient knowledge to articulate the following key points in the migration backlog.

### Business outcomes and metrics

Every member of the team should understand the desired business outcomes. Migrations take time. It's easy for team members to become distracted by urgent but less important activities during migration. Establishing and reinforcing the desired outcomes helps the team understand the priority and relative importance of the migration, enabling better decision-making over time.

Tracking migration progress is equally important to the team's motivation and to continued stakeholder support. Progress can be tracked through migration KPIs and learning metrics. Regardless of how the effort is tracked, it's important that the team is aware of these metrics so that they can evaluate performance during subsequent iterations.

### Business priorities

Sometimes, prioritizing one workload over another might seem illogical to the cloud adoption team. Understanding the business priorities that drove those decisions can help maintain the team's motivation. It also allows the team to make a stronger contribution to the prioritization process.

### Core assumptions

The article on [digital estate rationalization](../../digital-estate/rationalize.md) discusses the agility and time-saving impact of basic assumptions when evaluating a digital estate. To fully realize those values, the cloud adoption team needs to understand the assumptions and the reasons that they were established. That knowledge better equips the cloud adoption team to challenge those assumptions.

### Capturing the backlog

The backlog needs to be captured in a location that can be shared so that different team member can align to it, and it can be updated throughout the migration process. You can use tools that your organization is comfortable with, and build upon the tools you used to perform your digital estate rationalization.

If you're looking for prebuilt templates, the [Migration Execution Guide](https://github.com/Azure/migration) (MEG) has prebuilt spreadsheets to help you organize your backlog.

It's important to associate individual servers with the workload, so that you can track the workload itself through individual server migrations. You can also use this backlog to showcase dependencies between workloads as you complete the assessment. When you get to [remediate assets](../deploy/remediate.md) and perform testing, you merge this with a remediation plan.

This backlog is used throughout the migration process, so maintaining it's critical.

### Backlog planning for multiple datacenters

Before starting the migration, you should create epics within the project management tool for each datacenter that's to be migrated.  Each datacenter epic allows you to group the associated work, allowing you to understand the status of each location.

If you are not using epics, these can be top level goals or grouping.  The important thing is that you must be able to filter and organize each datacenter on its own, as well as review status of each location.

It's important to understand the business outcomes and motivations for this migration. Use those motivations to prioritize the list of epics (or datacenters). For instance, if migration is driven by a desire to exit datacenters before leases must be renewed, then each epic would be prioritized based on lease renewal date.

Within each epic, the workloads to be assessed and migrated are managed as features. Each asset within that workload is managed as a user story. The work required to assess, migrate, optimize, promote, secure, and manage each asset is represented as tasks for each asset.

Sprints or iterations then consist of a series of tasks required to migrate the assets and user stories committed to by the cloud adoption team. Releases then consist of one or more workloads or features to be promoted to production.

## Next steps

> [!div class="nextstepaction"]
> [Planning for resilience](./planning-for-resilience.md)
