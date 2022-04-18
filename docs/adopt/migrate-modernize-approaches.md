---
title: Approaches to cloud migration and modernization
description: Use the Cloud Adoption Framework for Azure to understand the various approaches to migrate and modernize in your cloud adoption journey.
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Approaches to cloud migration and modernization

Where should you start in your three-horizon cloud adoption plan? Should you migrate or modernize first?

Depending on your overall strategy and needs, you might migrate first and modernize later, or vice versa. You might even modernize in parallel to migration. If you decide to modernize in parallel to migration, you'd want to modernize with a separate team that's not involved in migration. It's important to keep those horizons separated. You'll also want to separate your clusters of workloads. For more information about workload clusters, see [Envision cloud modernization](../modernize/envision-cloud-modernization.md#step-3-define--track-clusters-of-workloads-based-on-the-motivation).

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="Diagram showing approaches to cloud migration and modernization.":::

Deciding whether to modernize or migrate first comes down to *what benefits you want*.

## Migrate first, Modernize later approach

There are distinct motivations, reasons, and outcomes for migrating first. For instance, if you're trying to get out of a data center now, you might want to migrate first and change things later. If you're more focused on control, you might choose to lift-and-shift, go straight to Iaas, do some resizing, and migrate workloads.

Migrate first if you immediately want the following benefits for your organization:

- Reduce your data center footprint fast
- Save immediately in costs
- Have immediate compatibility with IaaS VMs
- Test your migration to ensure cloud-readiness

## Modernize first, Migrate later approach

If your main goal is to get a handful of apps faster time-to-market in the cloud, you might want to modernize first.

Modernize first if you immediately want the following benefits for your organization:

- Faster time to market for applications
- Increased app innovation
- Enhanced productivity
- Great app dev velocity

## Application portfolio migration and modernization approach

Most companies want a combination of control and productivity, based on the set of workloads they're assessing. So, we tend to see a mixed approach to the horizons. In this section we focus less on the horizon separation and sequence, and more on the breakdown of quantity and value of your workloads.

The following image shows an example of how a customer could break down their application portfolio into migrate and modernization approaches, so they can approach it at a deeper level. The percentages are examples only.

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach.png" alt-text="Diagram showing portfolio migration modernization approach.":::

### Migration

#### First to move

Most things in an environment can be moved and perhaps modernized without a significant modernization effort. Your first items to move could include:

- Basic web apps
- Advanced portals
- New solutions
- Any modernized solutions

#### Next to move

Usually, what we see when we migrate next are things like high input and output transactional processing systems or regulatory and high business impact systems. Those items tend to be more difficult to do any kind of modernization on and migrations are a forced option many times.

#### Hard or costly to move

There's always the following group of items that's hard to move:

- HVA systems
- PKI systems
- Legacy source control
- Workloads that can't be modernized
- Workloads that require deep architectural change

> [!IMPORTANT]
> If you have *workloads that require deep architectural change*, you need to *rearchitect* rather than modernize. In this case, use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/). Also, shifting pieces of LoB apps to PowerApps, and so on, is part of [innovation](../innovate/index.md), rather than modernization.

You might have a small percentage of things that you take from a custom line of business app over to power apps. This task is outside of modernization and can be handled in the [innovation](../innovate/index.md) space.

### Modernization

Developers tend to build new apps cloud-natively using Serverless or PaaS technologies. Modernizing your existing apps employs using containers or Serverless to maximize cloud benefits, or [lift and shift](/virtualization/windowscontainers/quick-start/lift-shift-to-containers) into IaaS to take advantage of OPEX and cloud scale.

For apps that aren't custom built, many businesses choose to retire and replace them using SaaS or low code apps.

Some apps need to stay on premises due to regulatory or data sovereignty requirements or latency issues. It’s important to enable these apps to be cloud-connected.

No matter where your applications run, in multicloud, on-premises, or at the edge, it's important to enable consistent identity, security, management, and compliance across distributed environments.

Usually about 35% of any on premises environment gets retired, rightsized, or eliminated during the cloud motion, although this percentage is a rough estimate.

## Next steps

> [!div class="nextstepaction"]
> [Evaluate your modernization options](../modernize/evaluate-modernization-options.md)
