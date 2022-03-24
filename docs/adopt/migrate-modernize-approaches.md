---
title: Approaches to cloud migration and modernization
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 3/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
---
<!--Acrolinx:....., TODO: meta description, .............-->
# Cloud migration and modernization approaches

Where should you start in your three-horizon cloud adoption plan? Should you migrate or modernize first? 

Depending on your overall strategy and needs, you might migrate first and modernize later, or vice versa, or in parallel to migration, but it's important to keep those horizons separated. At least separate out your clusters of workloads. If you have one team working on migrating some workflows and another team working on modernizing others, keep them separate. For more information about workload clusters, see [Envision cloud modernization](../modernize/envision-cloud-modernization.md#step-3-define--track-clusters-of-workloads-based-on-the-motivation).

Deciding whether to modernize or migrate first comes down to *what benefits you want*.



 
 ## Migrate horizon benefits
 There are distinct motivations, reasons, and outcomes for migrating first.if you're trying to get out of a data center quickly, you should probably migrate first and change things up later 

 Migration provides you with the following benefits:
 
  ** Or** modernize with a separate team that's not involved in the migration horizon. 
 
- Reduce your data center footprint quickly
- Save immediately in costs
- Have immediate compatibility with IaaS VMs
- Test your migration to ensure cloud-readiness

## Modernize horizon benefits

If your main goal is to get a handful of apps faster time-to-market in the cloud, maybe you should modernize first.

- Containers, PaaS plays
- Faster time to market for applications


|Column1  |Column2  |Column3  |
|---------|---------|---------|
|Row1     |         |         |
|Row2     |         |         |

|Horizon  |Benefits  |
|---------|---------|
|Migrate   |If you want to get out of a datacenter quickly, you should probably migrate first and change things up afterward.         | 
|Modernize     |         | 
|Row3     |         | 





The following image sums up the decision making based on the benefits:

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="img":::

- The following image shows how a fictitious customer broke down their application portfolio into migration and modernization approaches, so they could think about it at a deeper level.
- In the image, The percentages are only representative of *some* customers, but the percentages are there only for relative discussion.
- callouts to sequencing, *First to move, Next to move* aren't intended to represent a prescribed sequence of operations, they indicate the **relative size of work**: everything under *first to move* is the simplest, and so on. 

If you're more focused on control, you might choose to lift-and-shift, go straight to Iaas, do some resizing, and migrate workloads.
More interested in productivity you'll conversion to SaaS/PaaS/serverless solutions. For most customers it's a mix between control and productivity, based on the set of workloads you're assessing.

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach.png" alt-text="img":::

In regards to the last bullet, *Workloads requiring deep architectural change*, if this applies to you, you need rearchitecture rather than modernization. In this case, use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/). Additionally, the top row of bullets (shifting pieces of LoB apps to PowerApps, and so on) is also not part of modernization, it's [innovation](../innovate/index.md).





<!--

And the first thing to note if we use this graphic is these percentages are representative of some customers, but the percentages are not the focus area, they're just there for relative discussion and what we see in this is if the customers. More focused on control, we're going to see more of that lift and shift go straight to, as do a little bit of resizing and migrate works if the customer is more interested in productivity, we're going to see more of this conversion too. SAS plays pass, plays pass, and service serverless solutions. Those sorts of things, but for most customers it's a big mix between control and productivity based on the set of workloads they're looking at, and what we tend to see is right here in the middle. Most things in an environment can be moved easily and may even be able to be modernized without a big modernization effort, and I know I've contradicted that thought of horizon separation before, but here we're looking more at the breakdown of. The size or value is more kind of the quantity of things, not necessarily the sequencing.
And then usually what we see in the next largest group to move are things like. High input and output transactional processing systems or regulatory and high business impact systems. Those tend to be a little harder to do any kind of modernization on and migrations. Really, they're. Their forced option a lot of times.
And then there's always a group of things that are hard to move, like your legacy source, control systems, or workloads that can't be modernized. They're going to require deep architectural change, and in this last bullet here on this article, we want to make sure there's some call out that says when we are doing deep architectural change that is not modernization. That's a re-architecture and we want the customer to use the well architected framework.
There are also some other things here where customers have a small percentage of things that they end up taking from a custom line of business app over to power apps. This is outside of modernization as well, and this is dealt with inside of the innovation space. We may see some things like that come up as we talk about Modernize, but
Innovate really is a better home for a lot of those. Those high-level power app conversations at this point, but again, this may be reevaluated. So don't be surprised if that last section of comments around the 15% needs to be edited later.
And then the other thing to be aware of is usually about 35% of any on premises environment gets retired, gets rightsized, gets eliminated during the cloud motion, so these are again rough estimates. But we're kind of breaking down the environment to talk about how different things might be broken up when we're thinking about migration and modernization. So that concludes the article about rationalizing the workloads or migrate modernize approaches.md. -->

## Next steps

> [!div class="nextstepaction"]
> [Evaluate your paths to modernization and innovation](../Evaluate/modernization-economics.md)
