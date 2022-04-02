---
title: 'Modernization disciplines'
description: TODO
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: modernize
ms.custom: internal
---
<!--Slide 45-->
# Modernization disciplines

To keep building and launching new code bases, you'll want to increase the capabilities for you application platform to minimize the efforts required by your developers for faster time to market.

[DevOps maturity model](/azure/cloud-adoption-framework/innovate/considerations/ci-cd)
## Application platforms discipline

:::image type="content" source="../_images/modernize/migration-journey-tools-and-services.png" alt-text="Diagram showing the tools and services for your migration journey.":::

### Developer alignment

If your desired cost savings is bigger than the cost of modernization, let's align your developers and see what they can do to optimize. This is an example where your business might have different rules if you're already doing a lot of application platform motions. Maybe you get your cost savings through application platform improvements, but customers lean more towards developer alignment as a way to get there.

### Data platform alignment

<!--They group up loosely with the different disciplines = linking. It says in general, this is a discipline that would apply for your workloads in this bucket.-->

:::image type="content" source="../_images/modernize/automate-database-modernization.png" alt-text="Diagram showing aspects of database modernization.":::

There are many of the workloads left in the cost optimizing applications motivation.

- Does the cost of modernizing exceed the desired cost savings?
- Do you understand your break even point?

On the other hand, if they do well, it's going to take a lot of change to modernize and the cost savings aren't all that great. Then let's go ahead and just migrate this over and get it out of the out of the pool of things we want to move around or modernize.

Should they modernize? Should they just migrate it up and just know that they'll have that ongoing high cost of operations?

:::image type="content" source="../_images/modernize/database-migration-process-overview.png" alt-text="Diagram showing database migration process overview.":::

Is this an example of what may end up going into one of the more complex evaluation states? When we talk about hybrid work, it means different things to different people. 

Is it your workload that's hybrid and you need some degree of portability so that you can move it to Azure, but later move it to on-premises? Move it to GCP or a WS and you want that fluidity of where your workload lives? It's very commonplace for customers that are trying to modernize right now.

Is it really your workers or hybrid and you just need new network routing paths to get those workers to that workload? Whether it's a hybrid or portable workload, this is clearly a case of application platform.

If you've consumed considerations for data portability, you might need to modernize your data platform.
If it's more the workers who are hybrid and not the workload, then it would only need migration.

[Data migration type](../innovate/best-practices/data-dms.md#data-migration-type)

## Testing & architecture

If you determine that your application needs some hybrid portability capabilities, we might want to run a [Well-Architected Review](https://azure.microsoft.com/blog/introducing-the-microsoft-azure-wellarchitected-framework/) because we need to better understand on a workload-by-workload basis.

You want your workload buckets aligned with the disciplines. This action helps to create a pattern where you prioritize the buckets and set up repeatable processes to get faster time to market. You can modernize all of these workloads using a chaos or deploy all of these application innovation workloads through some developer alignment techniques that are repeatable. Centralize your data by using the Azure migration capabilities of moving from SQL Server to individual SQL instances.

Align your workloads to your business values and disciplines to drive your desired outcomes.
