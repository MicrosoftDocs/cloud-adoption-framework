---
title: Approaches to cloud migration and modernization
description: Use the Cloud Adoption Framework for Azure to understand the various approaches to migrate and modernize in your cloud adoption journey.
author: BrianBlanchard
ms.author: chcomley
ms.date: 07/21/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Approaches to cloud migration and modernization

As part of your cloud adoption journey, you can choose your approach to migration and modernization. Is there an advantage to doing one before the other? What's best for your business?

You can take one of the following three approaches to cloud migration and modernization:

- [Approaches to cloud migration and modernization](#approaches-to-cloud-migration-and-modernization)
  - [Migrate first, modernize later](#migrate-first-modernize-later)
  - [Modernize first, migrate later](#modernize-first-migrate-later)
  - [Migrate and modernize in parallel](#migrate-and-modernize-in-parallel)
    - [Migrate](#migrate)
      - [First to move](#first-to-move)
      - [Next to move](#next-to-move)
      - [Hard or costly to move](#hard-or-costly-to-move)
    - [Modernize](#modernize)
  - [Next steps](#next-steps)

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="Diagram showing approaches to cloud migration and modernization.":::

## Migrate first, modernize later

There are distinct motivations and outcomes for migrating first. For instance, if you're trying to get out of a data center now, you might want to migrate first and change things later. If you're more focused on control, you might choose to lift-and-shift, go straight to Iaas, do some resizing, and migrate workloads. Migrate first if you immediately want the following benefits for your organization:

- Reduce your data center footprint fast
- Save immediately in costs
- Have immediate compatibility with IaaS VMs
- Test your migration to ensure cloud-readiness

## Modernize first, migrate later

If your main goal is to get a handful of apps faster time-to-market in the cloud, you might want to modernize first. Modernize first if you immediately want the following benefits for your organization:

- Have faster time to market for applications
- Increase app innovation
- Enhance productivity
- Increase developer velocity

## Migrate and modernize in parallel

Most companies want a combination of control and productivity, based on the set of workloads they're assessing. So, we tend to see a mixed approach. In this section we focus less on the horizon separation and sequence, and more on the breakdown of quantity and value of your workloads.

The following image shows an example of how a customer could break down their approach to the migrate and modernize their application portfolio in tandem.

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach.png" alt-text="Diagram showing portfolio migration modernization approach.":::

### Migrate

#### First to move

Most things in an environment can be moved and perhaps modernized without a significant modernization effort. Your first-to-move could include the following items:

- Basic web apps
- Advanced portals
- New solutions
- Any modernized solutions

#### Next to move

Often times, we then migrate things like high input and output transactional processing systems or regulatory and high business impact systems. Those items tend to be more difficult to do any kind of modernization on and migrations are a forced option many times.

#### Hard or costly to move

The following groups of items are often hard to move:

- HVA systems
- PKI systems
- Legacy source control
- Workloads that can't be modernized
- Workloads that require deep architectural change

> [!IMPORTANT]
> If you have *workloads that require deep architectural change*, you need to *rearchitect* rather than modernize. In this case, use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/). Also, shifting pieces of LoB apps to PowerApps, and so on, is part of [Innovation](../innovate/index.md), rather than [Modernization](../modernize/index.md).

You might have a small percentage of things that you take from a custom line of business app over to power apps. This task is outside of modernization and can be handled in the [Innovation](../innovate/index.md) aspect of cloud adoption.

### Modernize

Developers tend to build new apps cloud-natively using Serverless or PaaS technologies. Modernizing your existing apps employs using containers or Serverless to maximize cloud benefits, or [lift and shift](/virtualization/windowscontainers/quick-start/lift-shift-to-containers) into IaaS to take advantage of OPEX and cloud scale.

Move away from using the following assets:

- Custom LoB apps
- DevOps tools
- Relationship management tools
- Industry standard verticals

Modernize using:

- Power Apps
- GitHub
- Dynamics 365
- 3rd party SaaS

Some apps need to stay on premises due to regulatory or data sovereignty requirements or latency issues. It’s important to enable these apps to be cloud-connected. Usually about 35% of any on premises environment gets retired, rightsized, or eliminated during the cloud motion.

For apps that aren't custom built, many businesses choose to retire and replace them using SaaS or low code apps.

No matter where your applications run, in multicloud, on-premises, or at the edge, it's important to enable consistent identity, security, management, and compliance across distributed environments.

## Next steps

> [!div class="nextstepaction"]
> [Evaluate your modernization options](../modernize/business-alignment/evaluate-modernization-options.md)
