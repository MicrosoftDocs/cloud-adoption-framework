---
title: "Hybrid and multicloud migration"
description: Understand migration to a hybrid and multicloud environment
author: BrianBlanchard
ms.author: brblanch
ms.date: 02/01/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Hybrid and multicloud migration

In the [Migrate methodology](../../migrate/index.md), migration to the cloud is already consider to be a hybrid or multicloud process. Most of the guidance in that methodology will remain relevant when migrating to a hybrid and multicloud environment. The biggest shift from that methodology is related to the long-term objective of migrations.

![Shift from uni-direction cloud migration, to bi-directional hybrid and multicloud migration described in next paragraph.](../../_images/unified-operations/primary-cloud-provider.png)

Typically, migration efforts have been seen as a one-way street; assets move up to cloud (or to a new cloud) & stay there. In a hybrid and multicloud environment, migration efforts are more like a multi-lane highway; assets move between multiple public and private clouds based on shifting business or technical requirements. This shift in migration strategy has little impact on the migration process, but can directly impact all of the work that comes before and after migration.

## Impact on migration-specific processes

While the direct impact on migration processes is minor, awareness of those deviations can increase your organization's likelihood of success. The act of migrating workloads consists of three high level processes, which are repeated in waves or sprints until the migration is complete. The following introduces how each of those processes change:

- **Assess workloads:** There are a few considerations that will shape how you assess workloads prior to migration. 
- **Deploy workloads:** Deployment of the waves of workloads is largely unchanged. But, you may want to leverage more of the [Azure Migrate](https://docs.microsoft.com/azure/migrate) ecosystem to accelerate specific types of migrations.
- **Release workloads:** Once workloads have been deployed, the biggest shift will be seen in testing cycles prior to release to production traffic.

See below for additional guidance on assessing, deploying, or releasing workloads within your migration processes. But first review the next section on the bigger changes to upstream and downstream processes that will impact your migration.

## Impact on upstream & downstream processes

When migrating workloads in a hybrid and multicloud environment, the real impact is on the efforts that come before and after the migration. Before migrating workloads as part of a hybrid and multicloud approach, see [Introduction to hybrid and multicloud](./index.md) and [Introduction to unified operations](./unified-operations.md) to understand what else changes outside of the migration.

> [!WARNING]
> The links above provide high level insights that will set you up for success. Within those articles are links to vital technical changes & impacts. Do not proceed with a migration under a hybrid and multicloud strategy without a basic understanding of the impact on your [Plan](./plan.md), [Environmental readiness](./ready.md), and [operations management](./manage.md). Failure to prepare for those activities will result in greater operational costs & may create unintended vendor lock-in.

## Assess workloads for hybrid and multicloud migration

The Azure products used for a standard migration are still applicable in a hybrid and multicloud migration. Specifically Azure Migrate and Service Map can be used to understand your digital estate and outline dependencies. For more information on both tools, see the [getting started guide for assessing workloads](../../migrate/azure-migration-guide/assess.md). When building out your plan or assessing waves of hybrid and multicloud workloads, the [best practice for digital estate assessment in Azure](../../plan/contoso-migration-assessment.md) is still applicable.

Where hybrid and multicloud migrations encounter assessment challenges are in the lack of maturity within their migration team's assessment processes. The following considerations should be factoring into your assessment plans:

- When evaluating workload it is always important to consider compatibility with Azure and your Azure Landing Zones. During workload evaluation, you will also need to consider compatibility with any hybrid networking, hybrid identity, hybrid security, or hybrid management/governance constraints established in other hybrid or multicloud environments.
- A more thorough emphasis must also be placed on dependencies, since a larger percentage of assets may be hosted in other clouds.
- It is important to understand the reason behind the hybrid and multicloud decision to evaluate compatibility of the various workloads with any supporting tools:
    - Azure Stack HCI compatibility is important if you are modernizing your data center to allow for cloud native solutions on-prem.
    - Kubernetes compatibility is important if you are maintaining portability through container-based infrastructure.
    - Azure Edge compatibility may be important to extend workloads & reduce latency at the point of interaction.
    - Regulatory, compliance, or business requirements may dictate that some assets or data remain on-prem. To monitor those parts that are migrated, you may need to add additional monitoring tools.

The following articles will help mature the most impactful processes required for this type of migration:

- **[Responsibilities](../..//migrate/migration-considerations/assess/index.md)**
- **[Workload classification](../../migrate/migration-considerations/assess/classify.md)**
- **[Cloud compatibility](../../migrate/migration-considerations/assess/evaluate.md)**
- **[Agile change management](../../migrate/migration-considerations/assess/release-iteration-backlog.md)**
- **[Building a well-defined migration backlog](../../plan/plan-intro.md)**

## Deploy migrated workloads for hybrid and multicloud

When migrating to the cloud, it is always important to have a clear inventory of all dependent assets and network paths to ensure that those assets are deployed in the correct cloud. A clear inventory or digital estate assessment is even more important in hybrid environments before migrating workloads. See the prior section of assessing workloads before trying to migrate workloads to a hybrid and multicloud environment.

Azure Migrate is the de facto solution for migrating your workloads from your private cloud to Azure. The best practices for migrating to Azure from other public clouds does change a bit. Likewise, you may need to add a few additional tools when migrating to Azure Stack HCI. See below for tutorials:

- **[Migrate from AWS to Azure](https://docs.microsoft.com/azure/migrate/tutorial-migrate-aws-virtual-machines)**
- **[Migrate from GCP to Azure](https://docs.microsoft.com/azure/migrate/tutorial-migrate-gcp-virtual-machines)**
- **[Migrate to Azure Stack HCI](../../scenarios/azure-stack/migrate-deploy.md#deploy-workloads)**

## Release migrated workloads for hybrid and multicloud

The importance of testing, benchmarking/sizing, and promotion plans can't be overstated during a migration to the cloud. Hybrid and multicloud workloads have greater dependencies on decentralized assets and the networks connecting them. They are more prone to latency, connectivity, and routing issues which could appear to be cloud platform performance issues. Testing and debugging of hybrid and multicloud workloads will need a greater time allocation than workloads deployed to a single cloud provider.

The following are a few considerations that should be included in your testing plan when migrating to a hybrid and multicloud environment:

- **[Align business and IT testing](../../migrate/migration-considerations/optimize/business-test.md)**
- **[Benchmark & resize assets](../../migrate/migration-considerations/optimize/optimize.md)**
- **[Cost and resizing best practices](../../migrate/azure-best-practices/migrate-best-practices-costs.md)**
- **[Promote to production](../../migrate/migration-considerations/optimize/promote.md)**
- **[Prepare for unified operations](./unified-operations.md)**

## Next step: Govern hybrid and multicloud environments

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Govern hybrid and multicloud environments](./govern.md)
- [Manage hybrid and multicloud environments](./manage.md)
