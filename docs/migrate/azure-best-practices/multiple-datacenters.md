---
title: Multiple datacenters
description: Multiple datacenters
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: internal
---

# Multiple datacenters

Often the scope of a migration involves the transition of multiple datacenters. The following guidance expands the scope of the [Azure migration guide](../azure-migration-guide/index.md) to address multiple datacenters.

## General scope expansion

Most of the effort required in this scope expansion occurs during the prerequisites, assess, and optimize processes of a migration.

## Suggested prerequisites

Before starting the migration, you should create epics within the project management tool for each datacenter that's to be migrated. Each epic represents a datacenter. It's important to understand the business outcomes and motivations for this migration. Use those motivations to prioritize the list of epics (or datacenters). For instance, if migration is driven by a desire to exit datacenters before leases must be renewed, then each epic would be prioritized based on lease renewal date.

Within each epic, the workloads to be assessed and migrated are managed as features. Each asset within that workload is managed as a user story. The work required to assess, migrate, optimize, promote, secure, and manage each asset is represented as tasks for each asset.

Sprints or iterations then consist of a series of tasks required to migrate the assets and user stories committed to by the cloud adoption team. Releases then consist of one or more workloads or features to be promoted to production.

## Assess process changes

When you're expanding the scope to address multiple datacenters, the biggest change to the assess process is related to the accurate recording and prioritization of workloads and dependencies across datacenters.

### Suggested action during the assess process

**Evaluate cross-datacenter dependencies:** The [dependency visualization tools in Azure Migrate](/azure/migrate/concepts-dependency-visualization) can help pinpoint dependencies. Using this toolset before migration is generally a best practice. But when dealing with global complexity, it becomes a necessary step in the assessment process. Through [dependency grouping](/azure/migrate/how-to-create-group-machine-dependencies), the visualization can help identify the IP addresses and ports of any assets required to support the workload.

> [!IMPORTANT]
>
> - A subject matter expert with an understanding of asset placement and IP address schemas is required to identify assets that reside in a secondary datacenter.
> - Evaluate both downstream dependencies and clients in the visualization to understand bidirectional dependencies.

## Migration process changes

Migrating multiple datacenters is similar to consolidating datacenters. After migration, the cloud becomes the singular datacenter solution for multiple assets. The most likely scope expansion during the migration process is the validation and alignment of IP addresses.

### Suggested action during the migration process

The following are activities that greatly affect the success of a cloud migration:

- **Evaluate network conflicts:** When you're consolidating datacenters into a single cloud provider, you're likely to create network, DNS, or other conflicts. During migration, it's important to test for conflicts to avoid interruptions to production systems hosted in the cloud.
- **Update routing tables:** Often, modifications to routing tables are required when consolidating networks or datacenters.

## Optimize and promote process changes

During optimization, additional testing might be required.

### Suggested action during the optimize and promote process

Prior to promotion, provide additional levels of testing during this scope expansion. During testing, it's important to test for routing or other network conflicts. Further, it's important to isolate the deployed application, and retest to validate that all dependencies have been migrated to the cloud. In this case, isolation means separating the deployed environment from production networks. Doing so can catch overlooked assets that are still running on-premises.

## Secure and manage process changes

Secure and manage processes are unlikely to be changed by this scope expansion.

## Next steps

Return to the checklist to ensure that your migration method is fully aligned.

> [!div class="nextstepaction"]
> [Migration best practices checklist](./index.md)
