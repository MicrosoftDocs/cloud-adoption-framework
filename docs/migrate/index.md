---
title: Cloud migration in the Cloud Adoption Framework
description: Prepare for a successful migration to Azure using an iterative process to assess, deploy, and release workloads.
author: Zimmergren
ms.author: tozimmergren
ms.date: 04/09/2024
ms.topic: conceptual
---

# Cloud migration in the Cloud Adoption Framework

This part of the Cloud Adoption Framework (CAF) outlines the recommended migration approach and offers tips for a smooth move to the cloud through a step-by-step process: prepare, assess, deploy, and release workloads. It aims to be vendor-neutral, offering advice useful for migrating to any cloud service.

## Migration disciplines

A cloud migration typically requires both good preparation and execution. The Cloud Adoption Framework migration  methodology relies on proven guidance to help you prepare and execute your migration efforts.

![Diagram that shows the Cloud Adoption Framework migration disciplines.](./media/migrate-overview.svg)

To start a cloud migration, you first need to prepare and fulfil any prerequisites, which typically happens once before the migration process begins:

- **Prepare:** You need to focus on organizational alignment, defining clear owners for the migration process, and ensuring you've got the required skills in your teams. In this phase, you build on the work from the [Strategy](../strategy/index.md), [Plan](../plan/index.md), and [Ready](../ready/index.md) portions of CAF. This discipline is critical to the success of your migration effort.

When you've fulfilled the prerequisites and prepared, you can start the migration process. The migration process is an iterative process that includes the following disciplines:

- **Assess workloads:** Assess workloads to evaluate cost, modernization, and deployment tooling. This process focuses on validating or challenging assumptions. You make these assumptions during discovery and assessments by looking more closely at rationalization options. This process is also when user patterns and dependencies are studied more closely to ensure workloads will achieve technical success after migration.
- **Deploy workloads**: After you assess workloads, the existing workload functionality is replicated or improved in the cloud. This replication could involve a *lift and shift* or *rehost* to the cloud. But, more commonly during this phase, many of the assets supporting these workloads are modernized to capitalize on the benefits of the cloud.
- **Release workloads**: Once functionality is replicated to the cloud, workloads can be tested, optimized, documented, and released for ongoing operations. The effort to review the migrated workloads and hand them off is critical during this process. The effort is critical to governance, operations management, and security teams for ongoing workload support.

## Cloud migration checklist

| &nbsp; | Migration discipline | Activity |
|---|---|---|
| &#9744; | [**Prepare**](./prepare/index.md) | <li>Ready your landing zone for migration<br><li>Prepare tools and backlog<br><li>Select Azure regions for a migration<br><li>Align roles and responsibilities<br><li>Skills relevant to migration projects |
| &#9744; | [**Assess**](./assess/index.md) | <li>Classify workloads<br><li>Evaluate workload readiness<br><li>Architect workloads|
| &#9744; | [**Deploy**](./deploy/index.md) | <li>Deploy supporting services<br><li>Remediate assets<br><li>Replicate assets<br><li>Prepare for management<br><li>Migration testing |
| &#9744; | [**Release**](./release/index.md) | <li>Change communication<br><li>Business testing<br><li>Complete migration<br><li>Optimize cost after migration<br><li>Conduct retrospectives |

For more details, see each of the migration disciplines and activities in their respective checklist.

## Audience

The Migrate methodology addresses various roles and functions. Below is an example of the types of roles that might find this guidance helpful:

- **Business decision makers**: Understand the motivations for migrations. Make informed decisions that relates to your overall budget and cloud investments. Learn about relevant skills required in your organization to migrate, and how to get assistance from partners.
- **IT decision makers**: Understand the considerations for migrating into multiple regions, multiple datacenters, the recommended migration tools, and the skills required to migrate.
- **Platform owners / platform architects**: Learn how to prepare your Azure landing zones for migration, and other technical preparations of your Azure estate that might be required before you initiate a migration project.
- **Cloud engineers / cloud architects**: Assess existing workloads and solutions, deploy the required infrastructure in the cloud, and release the workloads into production.

## Next steps

The first step to get started is to familiarize yourself with the prepare discipline.

> [!div class="nextstepaction"]
> [Prepare](./prepare/index.md)
