---
title: Cloud migration in the Cloud Adoption Framework
description: Prepare for a successful migration to Azure using an iterative process to assess, deploy, and release workloads.
author: Zimmergren
ms.author: tozimmergren
ms.date: 01/09/2024
ms.topic: conceptual
---

# Cloud migration in the Cloud Adoption Framework

> Introduce the methodology.
>
> - Disciplines. Horizontal themes, the "headline messages" to field and customers.
> - Addressable audience. What are their needs, make it clear who should read this, and why.

This section of the Cloud Adoption Framework explains the principles behind its migration model. Wherever possible, this content attempts to maintain a vendor-neutral position. It guides you through the processes and activities that can be applied to any cloud migration, whatever your chosen cloud vendor.

Any enterprise-scale [cloud adoption plan](../plan/index.md) includes workloads that don't deserve significant investments in the creation of new business logic. Those workloads could be moved to the cloud through any number of approaches: lift and shift, lift and optimize, or modernize. Each approach is considered a migration.

## Migration disciplines

> TODO: Add a diagram that shows the migration disciplines.
> Business disciplines, and migration disciplines.

## Migration phases

The actions required to migrate workloads generally falls into three phases for each workload.

- **Assess workloads:** Assess workloads to evaluate cost, modernization, and deployment tooling. This process focuses on validating or challenging assumptions. You make these assumptions during discovery and assessments by looking more closely at rationalization options. This process is also when user patterns and dependencies are studied more closely to ensure workloads will achieve technical success after migration.
- **Deploy workloads**: After you assess workloads, the existing workload functionality is replicated or improved in the cloud. This replication could involve a *lift and shift* or *rehost* to the cloud. But, more commonly during this phase, many of the assets supporting these workloads are modernized to capitalize on the benefits of the cloud.
- **Release workloads**: Once functionality is replicated to the cloud, workloads can be tested, optimized, documented, and released for ongoing operations. The effort to review the migrated workloads and hand them off is critical during this process. The effort is critical to governance, operations management, and security teams for ongoing workload support.

![Diagram that shows the Cloud Adoption Framework migration effort](../_images/migrate/methodology.png)

In a standard two-week iteration, an experienced migration team can complete this process for 2-5 workloads of low-medium complexity. More complex workloads might take several two-week iterations to complete all three phases of migration effort for a single workload.

Experience and complexity both have a significant impact on timelines and migration velocity.

## Roles and responsibilities

## Migration strategies

> TODO: Describe the different migration strategies, such as rehost, refactor, rearchitect, rebuild, and replace, and how they affect the complexity and benefits of cloud migration.

## Next steps

After familiarizing yourself with the migration methodology, you can use the following checklist to help you understand and plan your migration efforts.

> [!div class="nextstepaction"]
> [Cloud migration checklist](./checklist.md)
