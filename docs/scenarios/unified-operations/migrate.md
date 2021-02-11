---
title: Hybrid and multicloud migration
description: Understand migration to a hybrid and multicloud environment
author: brianblanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: e2e-hybrid
---

# Hybrid and multicloud migration

In the [Migrate methodology](../../migrate/index.md), migration to the cloud is already considered to be a hybrid or multicloud process. Most of the guidance in that methodology will remain relevant when migrating to a hybrid and multicloud environment. The biggest shift from that methodology is related to the long-term objective of migrations.

![Shift from unidirectional cloud migration to bidirectional hybrid and multicloud migration described in next paragraph.](../../_images/unified-operations/primary-cloud-provider.png)

Typically, migration efforts have been seen as a one-way street; assets move up to cloud (or to a new cloud) and stay there. In a hybrid and multicloud environment, migration efforts are more like a multilane highway; assets move between multiple public and private clouds based on shifting business or technical requirements. This shift in migration strategy has little impact on the migration process, but can directly impact all of the work that comes before and after migration.

## Impact on migration-specific processes

While their direct impact on migration processes is minor, becoming aware of divergences can increase your organization's likelihood of success. The act of migrating workloads consists of three high-level processes, repeated in waves (or sprints) until the migration is complete. Here is a brief look at how these processes change:

- **Assess workloads:** There are a few considerations that will shape how you assess workloads prior to migration.
- **Deploy workloads:** Deployment of the waves of workloads is largely unchanged. But, you may want to use more of the [Azure Migrate](/azure/migrate/) ecosystem to accelerate specific types of migrations.
- **Release workloads:** Once workloads have been deployed, the biggest shift will be seen in testing cycles prior to release to production traffic.

Additional guidance on assessing, deploying, or releasing workloads within your migration processes will be discussed later on this guide. But first review the next section on the bigger changes to upstream and downstream processes that will impact your migration.

## Impact on upstream and downstream processes

When migrating workloads in a hybrid and multicloud environment, the real impact is on the efforts that come before and after the migration. Before migrating workloads in a hybrid and multicloud approach, see [Introduction to hybrid and multicloud](./index.md) and [introduction to unified operations](./unified-operations.md) to understand what else changes outside of your migration effort.

> [!WARNING]
> The links above provide high level insights that will set you up for success. Within those articles are links to vital technical changes and impacts. Do not proceed with a migration under a hybrid and multicloud strategy without a basic understanding of the impact on your [plan](./plan.md), [environmental readiness](./ready.md), and [operations management](./manage.md). Failure to prepare for those activities will result in greater operational costs and may create unintended vendor lock-in.

## Assess workloads for hybrid and multicloud migration

Azure products used in a standard migration are still applicable to a hybrid and multicloud migration. Specifically, Azure Migrate and Service Map can be used to understand your digital estate and outline your dependencies. For more information on both tools, see the [getting started guide for assessing workloads](../../migrate/azure-migration-guide/assess.md). When building out your plan or assessing waves of hybrid and multicloud workloads, the [best practice for digital estate assessment in Azure](../../plan/contoso-migration-assessment.md) still applies.

Where hybrid and multicloud migrations encounter assessment challenges, it signals lack of maturity within their migration team's assessment processes. The following considerations should be factoring into your assessment plans:

- When evaluating your workloads, it is always important to consider compatibility with Azure and Azure landing zones. During workload evaluation, you will also need to consider compatibility with any hybrid networking, hybrid identity, hybrid security, or hybrid management/governance constraints established in other hybrid or multicloud environments.
- A more thorough emphasis must also be placed on dependencies, since a larger percentage of assets may be hosted in other clouds.
- It is important to understand the reason behind the hybrid and multicloud decision to evaluate compatibility of the various workloads with tools supporting:

  - **Azure Stack HCI compatibility** is important if you are modernizing your datacenter to allow for cloud native solutions on-premises.
  - **Kubernetes compatibility** is important if you are maintaining portability through container-based infrastructure.
  - **Azure Edge compatibility** may be important to extend workloads, and reduce latency at the point of interaction.
  - **Regulatory, compliance, or business requirements** may dictate that some assets or data remain on-premises. To monitor assets that are migrated, you may need to add additional monitoring tools.

These articles will help you to mature the most impactful processes required for this type of migration:

- **[Responsibilities](../..//migrate/migration-considerations/assess/index.md#accountability-during-assessment)**
- **[Workload classification](../../migrate/migration-considerations/assess/classify.md)**
- **[Cloud compatibility](../../migrate/migration-considerations/assess/evaluate.md)**
- **[Agile change management](../../migrate/migration-considerations/assess/release-iteration-backlog.md)**
- **[Building a well-defined migration backlog](../../plan/plan-intro.md)**

## Deploy migrated workloads for hybrid and multicloud

When migrating to the cloud, it is always important to have a clear inventory of all dependent assets and network paths to ensure that those assets are deployed in the correct cloud. A clear inventory (or digital estate assessment) is even more important in hybrid environments before migrating workloads. See the *Assess workloads* section above before trying to migrate workloads to a hybrid and multicloud environment.

[Azure Migrate](/azure/migrate/migrate-services-overview) is the principal solution for migrating workloads from your private cloud to Azure. Best practices for migrating to Azure from other public clouds will vary. And, you may need to add a few additional tools when migrating to Azure Stack HCI. See the following tutorials:

- **[Migrate from AWS to Azure](/azure/migrate/tutorial-migrate-aws-virtual-machines)**
- **[Migrate from GCP to Azure](/azure/migrate/tutorial-migrate-gcp-virtual-machines)**
- **[Migrate to Azure Stack HCI](../../scenarios/azure-stack/migrate-deploy.md#deploy-workloads)**

## Release migrated workloads for hybrid and multicloud

The importance of testing, benchmarking/sizing, and promotion plans can't be overstated when migrating to the cloud. Hybrid and multicloud workloads have greater dependencies on decentralized assets and the networks connecting them. They are more prone to latency, connectivity, and routing issues which could appear to be cloud platform performance issues. Testing and debugging of hybrid and multicloud workloads will need a greater time allocation than workloads deployed to a single cloud provider for the added layers in identity and networking.

Here are a few considerations to include in your testing plan when migrating to a hybrid and multicloud environment:

- **[Align business and IT testing](../../migrate/migration-considerations/optimize/business-test.md)**
- **[Benchmark and resize assets](../../migrate/migration-considerations/optimize/optimize.md)**
- **[Cost and resizing best practices](../../migrate/azure-best-practices/migrate-best-practices-costs.md)**
- **[Promote to production](../../migrate/migration-considerations/optimize/promote.md)**
- **[Prepare for unified operations](./unified-operations.md)**

## Next step: Govern hybrid and multicloud environments

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
