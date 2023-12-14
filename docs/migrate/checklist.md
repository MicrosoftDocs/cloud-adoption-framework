---
title: Cloud adoption - Migration checklist
description: Get an overview of the Migrate methodology of cloud adoption and the decisions that you need to make for successful migration projects.
author: Zimmergren
ms.author: tozimmergren
ms.date: 11/22/2023
ms.topic: conceptual
ms.custom: UpdateFrequency2
---

# Cloud adoption - Migration checklist

These checklists covers considerations and recommendations for approaching migration projects. The checklists are based on the guidance throughout the Migrate methodology and can be used as a guide for your migration projects.

## Prerequisites

| Code | Guidance |
|---|---|
| [MIG:01](./prerequisites/index.md) | **Prerequisites overview.** Set objectives, review business drivers, clarify your definition of done, define responsibilities and accountability, and more. |
| [MIG:02](./prerequisites/ready-alz.md) | **Readying your landing zone for migration.** Prepare your Azure landing zones for your migrations, including establishing hybrid connectivity, prepare identity, enable hybrid DNS, configure hub firewall, routing, monitoring, and more. |
| [MIG:03](./prerequisites/migration-tools-decision-guide.md) | **Migration tools decision guide.** Use this decision tree to evaluate potential tools to use for your migration projects. |
| [MIG:04](./prerequisites/multiple-datacenters.md) | **Understanding multiple datacenters.** This article expands on guidance where multiple datacenters are in scope for your migration. |
| [MIG:05](./prerequisites/multiple-regions.md) | **Multiple regions.** This article outlines considerations and recommendations for a multi-region migration, if you're migrating workloads to more than one region. |
| [MIG:06](./prerequisites/roles-and-responsibilities.md) | **Align roles and responsibilities.** Understand and define the common roles and responsibilities, including the business functions, and how they map to each phase of the migration process. |
| [MIG:07](./prerequisites/migration-backlog-review.md) | **Migration backlog review.** Use this guidance as a milestone to complete the prerequisite activities before your migrations start. |
| [MIG:08](./prerequisites/suggested-skills.md) | **Skills relevant to migrate.** Investing in the right skills to get the job done is essential. Make sure you've got the required skills in your teams before your migration projects start. |
| [MIG:09](./prerequisites/partnership-options.md) | **Understand partnership options.** Make sure you understand the available partnership options available to you, including guided self-service, FastTrack for Azure, and Solutions partners. |
| [MIG:10](./prerequisites/assistance.md) | **Get assistance.** Understand where to find the right help at the right time for your migration projects, including Microsoft Support, online communities, and Microsoft partners. |

## Assess

| Code | Guidance |
|---|---|
| [MIG:20](./assess/index.md) | **Assess overview.** Set goals, define success, define responsibilities and accountability, identify stakeholders, and more. |
| [MIG:21](./assess/classify.md) | **Classify workloads.** Evaluate data sensitivity and mission criticality of each workload before migration. |
| [MIG:22](./assess/evaluate.md) | **Evaluate workload readiness.** Evaluate assumptions, infrastructure, databases, and network readiness. |
| [MIG:23](./assess/architect.md) | **Architect workloads.** Understand architecture assumptions, potential roadblocks, and how to accelerate business value with the right hosting strategy. |
| [MIG:24](./migration-considerations/assess/estimate.md) | **Update and refine initial cloud estimates.** During migration, there are several factors that can affect decisions and execution activities. Understand your digital estate size, and your accounting models. |

## Deploy

| Code | Guidance |
|---|---|
| [MIG:40](./deploy/index.md) | **Deploy overview.** In this phase of the adoption journey, use the output of the assessment phase to begin migrating your environment. Understand migration tools, project management tools, set responsibilities and accountability, and prepare to deploy your workloads. |
| [MIG:41](./deploy/remediate.md) | **Remediate assets.** During the migration assessment process, the team identifies any configurations that might make an asset incompatible with the chosen cloud provider. Remediate is a checkpoint in the migration process, which ensures that any incompatibilities are resolved. |
| [MIG:42](./deploy/replicate.md) | **Replicate assets.** Understand the role of replication in the migration process, including prerequisites and replication risks. |
| [MIG:43](./deploy/stage.md) | **Stage workloads.** Staging is the point at which assets have been migrated to the cloud. However, they're not ready to be promoted to production yet. This is often the last step in the migrate process of a migration. |
| [MIG:44](./deploy/network-capacity-exceeded.md) | **Data requirements exceed network capacity.** Understand best practices and options when data requirements exceed network capacity during a migration effort. |

## Release

| Code | Guidance |
|---|---|
| [MIG:60](./release/index.md) | **Release overview.** After a collection of workloads and their supporting assets have been deployed to the cloud, it must be prepared before it can be released. In this phase of the migration effort, the collection of workloads are load tested and validated with the business. They're then optimized and documented. Once the business and IT teams have reviewed and signed off on workload deployments, those workloads can be released or handed off to governance, security, and operations teams for ongoing operations. |
| [MIG:61](./release/business-change-plan.md) | **Business change plan.** Before a migrated workload is promoted to production, implementing a broader approach to user adoption is suggested. This article outlines the ways in which a business change plan adds to a standard user adoption plan. |
| [MIG:62](./release/business-test.md) | **Business testing.** Understand business testing (User Acceptance Test) during migration, including the relevant business and IT activities. |
| [MIG:63](./release/promotion-models.md) | **Promotion models.** One of the last activities in a migration is the promotion of an asset to production. Understand the impact of promotion models on migrate and optimize activities, including single-step promotion, staged promotion, and flight promotion. |
| [MIG:64](./release/prepare-for-promotion.md) | **Prepare for promotion.** To prepare for promotion, validate the business change plan, perform final technical readiness tests, and a final business validation. |
| [MIG:65](./release/promote.md) | **Promote to production.** Understand what's required to promote a migrated resource to production, including prerequisites and best practices to execute prior to promotion. |
| [MIG:66](./release/decommission.md) | **Decommission retired assets.** Understand the importance of decommissioning retired assets. |
| [MIG:67](./release/retrospective.md) | **Conduct retrospectives.** Learning, growing, and even failure are at the heart of a growth mindset. Understand the importance of retrospectives to reinforce the principles of a growth mindset: experimentation, testing, learning, sharing, growing, and empowering. |

## Next steps

> [!div class="nextstepaction"]
> [Migration pre-requisites](./prerequisites/index.md)