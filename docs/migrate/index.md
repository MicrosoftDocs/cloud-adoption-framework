---
title: Cloud migration in the Cloud Adoption Framework
description: Prepare for a successful migration to Azure using an iterative process to assess, deploy, and release workloads.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/11/2024
ms.topic: conceptual
---

# Cloud migration in the Cloud Adoption Framework

This section of the Cloud Adoption Framework (CAF) explains the disciplines and principles behind its proven migration model. It also provides guidance to help you prepare for a successful migration to a cloud provider using an iterative process to first prepare, then assess, deploy, and release workloads.

This content attempts to maintain a vendor-neutral position whenever possible. It guides you through the processes and activities that can be applied to any cloud migration, whatever your chosen cloud vendor.

## Audience

The Migrate methodology addresses various roles and functions. Below is an example of the types of roles that might find this guidance helpful:

- **Business decision makers**: Understand the motivations for migrations. Make informed decisions that relates to your overall budget and cloud investments. Learn about relevant skills required in your organization to migrate, and how to get assistance from partners.
- **IT decision makers**: Understand the considerations for migrating into multiple regions, multiple datacenters, the recommended migration tools, and the skills required to migrate.
- **Platform owners / platform architects**: Learn how to prepare your Azure landing zones for migration, and other technical preparations of your Azure estate that might be required before you initiate a migration project.
- **Cloud engineers / cloud architects**: Assess existing workloads and solutions, deploy the required infrastructure in the cloud, and release the workloads into production.

## Migration strategies

A [cloud adoption plan](../plan/index.md) might include workloads that don't deserve significant investments in the creation of new business logic. Those workloads can be moved to the cloud through any number of approaches: **lift and shift**, **lift and optimize**, or **modernize**.

Each approach is considered a migration that could fall into the scope of this guidance.

## Migration disciplines

A cloud migration typically requires both good preparation and execution. The Cloud Adoption Framework migration  methodology relies on proven guidance to help you prepare and execute your migration efforts.

![Diagram that shows the Cloud Adoption Framework migration effort](../_images/migrate/methodology.png)

To start a cloud migration, you first need to prepare and fulfil any prerequisites, which typically happens once before the migration process begins:

- **0. Prepare:** You need to focus on organizational alignment, defining clear owners for the migration process, and ensuring you've got the required skills in your teams. In this phase, you build on the work from the Strategy, Plan, and Ready portions of CAF. This discipline is critical to the success of your migration effort.

When you've fulfilled the prerequisites and prepared, you can start the migration process. The migration process is an iterative process that includes the following disciplines:

- **1. Assess workloads:** Assess workloads to evaluate cost, modernization, and deployment tooling. This process focuses on validating or challenging assumptions. You make these assumptions during discovery and assessments by looking more closely at rationalization options. This process is also when user patterns and dependencies are studied more closely to ensure workloads will achieve technical success after migration.
- **2. Deploy workloads**: After you assess workloads, the existing workload functionality is replicated or improved in the cloud. This replication could involve a *lift and shift* or *rehost* to the cloud. But, more commonly during this phase, many of the assets supporting these workloads are modernized to capitalize on the benefits of the cloud.
- **3. Release workloads**: Once functionality is replicated to the cloud, workloads can be tested, optimized, documented, and released for ongoing operations. The effort to review the migrated workloads and hand them off is critical during this process. The effort is critical to governance, operations management, and security teams for ongoing workload support.

In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads might take several two-week iterations to complete all three phases of migration effort for a single workload.

Experience and complexity both have a significant impact on timelines and migration velocity.

## Roles and responsibilities

As part of the prepare discipline, you should align roles and responsibilities to drive clarity during the migration process. These are described in the [Roles and responsibilities](./prerequisites/roles-and-responsibilities.md) article.

## Next steps

The first step to get started is to familiarize yourself with the prepare discipline.

> [!div class="nextstepaction"]
> [Prepare](./prerequisites/index.md)
