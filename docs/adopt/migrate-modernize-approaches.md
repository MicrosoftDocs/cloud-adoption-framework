---
title: Approaches to cloud migration and modernization
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 04/01/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
---
<!--Acrolinx:96, TODO: meta description, more content -->
# Cloud migration and modernization approaches

Where should you start in your three-horizon cloud adoption plan? Should you migrate or modernize first?

Depending on your overall strategy and needs, you might migrate first and modernize later, or vice versa. You might even modernize in parallel to migration, but it's important to keep those horizons separated. In that instance, you'd want to modernize with a separate team that's no involved in migration. At least separate your clusters of workloads. For more information about workload clusters, see [Envision cloud modernization](../modernize/envision-cloud-modernization.md#step-3-define--track-clusters-of-workloads-based-on-the-motivation).

Deciding whether to modernize or migrate first comes down to *what benefits you want*.

## Migrate horizon benefits

There are distinct motivations, reasons, and outcomes for migrating first. If you're trying to get out of a data center quickly, you should probably migrate first and change things later. 

Migration provides you with the following benefits:

- Reduce your data center footprint quickly
- Save immediately in costs
- Have immediate compatibility with IaaS VMs
- Test your migration to ensure cloud-readiness

## Modernize horizon benefits

If your main goal is to get a handful of apps faster time-to-market in the cloud, maybe you should modernize first.

- Containers, PaaS
- Faster time to market for applications

The following image sums up the decision making process, based on the benefits each horizon provides.

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="img":::

- The next image shows how a fictitious customer broke down their application portfolio into migration and modernization approaches. This way, they can approach it at a deeper level.
- In the image, the percentages are and example and only there for relative discussion.
- Callouts to sequencing, *First to move, Next to move* aren't intended to represent a prescribed sequence of operations, they indicate the **relative size of work**: everything under *first to move* is the simplest, and so on.

If you're more focused on control, you might choose to lift-and-shift, go straight to Iaas, do some resizing, and migrate workloads. If you're more interested in productivity, you might conversion to SaaS,PaaS, and serverless solutions. 

For most customers it's a mix between control and productivity, based on the set of workloads you're assessing.

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach.png" alt-text="img":::

With regard to the last bullet in the previous image, *Workloads requiring deep architectural change*, if this scenario applies to you, you need rearchitecture rather than modernization. In this case, use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/). Additionally, the top row of bullets (shifting pieces of LoB apps to PowerApps, and so on) is also not part of modernization, it's [innovation](../innovate/index.md).

Most things in an environment can be moved easily and might even be able to be modernized without a significant modernization effort. We're looking more at the breakdown of the kinds of the quantities, not necessarily the sequencing. breaking down the environment to talk about how different things might be broken up when we're thinking about migration and modernization.

## Migration horizon benefits



Usually what we see in the next largest group to move are things like high input and output transactional processing systems or regulatory and high business impact systems. Those items tend to be more difficult to do any kind of modernization on and migrations are a forced option many times. There's always a group of things that are hard to move, like your legacy source, control systems, or workloads that can't be modernized. They're going to require deep architectural change

You might have a small percentage of things that you take from a custom line of business app over to power apps. This task is outside of modernization and can be dealt with in the innovation space. We may see some things like that come up as we talk about Modernize, but Innovate really is a better home for many these.
<!-->
Those high-level power app conversations at this point, but again, this might be reevaluated. So don't be surprised if that last section of comments around the 15% needs to be edited later.
-->
Usually about 35% of any on premises environment gets retired, rightsized, or eliminated during the cloud motion, so these numbers are again rough estimates.

## Next steps

> [!div class="nextstepaction"]
> [Evaluate your paths to modernization and innovation](../Evaluate/modernization-economics.md)
