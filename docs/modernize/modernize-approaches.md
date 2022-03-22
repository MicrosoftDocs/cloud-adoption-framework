---
title: 'Approaches to modernization'
description: Understand and document initial decisions required to drive the cloud adoption journey.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: general
ms.custom: internal
---

# Approaches to modernizing

Depending on your overall business strategy and needs, you can choose to either migrate first and modernize later, or modernize in parallel to migration. Your decision gets based on your desired benefits.

There are distinct motivations, reasons, and outcomes when you Migrate first:

- if you modernize first, you're probably going to see more benefits
- if your real goal is you've got a handful of applications that you need to get a faster time to market in cloud, maybe a modernize first.

You want to keep those horizons separated and deciding whether you migrate first or modernize first, really comes down to what benefits you're after, but letting the customer know that there's  . Containers pass type of place. Maybe a modernization in a separate group, or a separate team that's not involved in the migration horizon. But just different ways to think about these benefits that we have listed down here, and we could almost just do a narrative behind this slide to set up that article.

This isn't an all or nothing play. The following image shows how a fictitious customer broke down their application portfolio into migration and modernization approaches, so they could think about it at a deeper level.

And the first thing to note if we use this graphic is these percentages are representative of some customers, but the percentages are not the focus area, they're just there for relative discussion and what we see in this is if the customers. More focused on control, we're going to see more of that lift and shift go straight to, as do a little bit of resizing and migrate works if the customer is more interested in productivity, we're going to see more of this conversion too. SAS plays pass, plays pass, and service serverless solutions. Those sorts of things, but for most customers it's a big mix between control and productivity based on the set of workloads they're looking at, and what we tend to see is right here in the middle. Most things in an environment can be moved easily and may even be able to be modernized without a big modernization effort, and I know I've contradicted that thought of horizon separation before, but here we're looking more at the breakdown of. The size or value is more kind of the quantity of things, not necessarily the sequencing.

And then usually what we see in the next largest group to move are things like. High input and output transactional processing systems or regulatory and high business impact systems. Those tend to be a little harder to do any kind of modernization on and migrations. Really, they're. Their forced option a lot of times.

And then there's always a group of things that are hard to move, like your legacy source, control systems, or workloads that can't be modernized. They're going to require deep architectural change, and in this last bullet here on this article, we want to make sure there's some call out that says when we are doing deep architectural change that is not modernization. That's a re-architecture and we want the customer to use the well architected framework.

There are also some other things here where customers have a small percentage of things that they end up taking from a custom line of business app over to power apps. This is outside of modernization as well, and this is dealt with inside of the innovation space. We may see some things like that come up as we talk about Modernize, but
Innovate really is a better home for a lot of those. Those high-level power app conversations at this point, but again, this may be reevaluated. So don't be surprised if that last section of comments around the 15% needs to be edited later.

And then the other thing to be aware of is usually about 35% of any on premises environment gets retired, gets rightsized, gets eliminated during the cloud motion, so these are again rough estimates. But we're kind of breaking down the environment to talk about how different things might be broken up when we're thinking about migration and modernization. So that concludes the article about rationalizing the workloads or migrate modernize approaches.md. 

:::image type="content" source="../../media/cloud-migration-modernization-approaches.png" alt-text="Chart showing various approaches to cloud migration and modernization.":::



breaking down the sequencing, not the size of effort involved.

> [!IMPORTANT]
> If your workload requires deep architectural change, you need rearchitecture rather than modernization. In this case, use the well-architected framework (link).

:::image type="content" source="../../media/application-portfolio-migration-modernization-approach.png" alt-text="Illustrative of application portfolio migration and modernization approach.":::


When you migrate first, you experience the following benefits:

- Reduce your data center footprint quickly
- Save immediately in costs
- Have immediate compatibility with IaaS VMs
- Test your migration to ensure cloud-readiness



## Next steps

[Evaluate your paths to modernization and innovation](../Evaluate/modernization-economics.md)