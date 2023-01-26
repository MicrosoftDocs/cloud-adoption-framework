---
title: How to relocate cloud workloads
description: Discover the process for relocating cloud workloads and applications to another region.
author: SomilGanguly
ms.author: ssumner
ms.date: 2/3/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-relocate
keywords: cloud adoption, cloud framework, cloud adoption framework
---
# Relocate cloud workloads

CAF Relocate details the process of relocating workloads in Azure and helps you to pick the best relocation strategies. Here we define relocation, identify reasons to relocate, and outline the relocation lifecycle.

:::image type="content" source="../_images/relocate/caf-relocate.png" alt-text="Image showing the relocation process. There are two phases and five steps. The first phase is the initiate phase, and it has one step called initiate. The second phase is the Move phase. It has four steps that you repeat for each workload. The steps are Evaluate, Select, Migrate, and Cutover." lightbox="../_images/relocate/caf-relocate.png" border="false":::
*Figure 1. The relocation lifecycle.*

## What is relocation?

Relocation is a process of moving a workload in Azure to a different Azure region.  While it’s a migration effort, it isn't a migration to the cloud.  Instead, it’s a migration with the Azure public cloud. As a result, it has some similarities with the process defined in CAF Migrate but also has its own solutions and considerations to take advantage of different Azure regions.

## Why relocate?

Relocation adds flexibility that can help you optimize cost and performance throughout the lifecycle of your workloads. When workloads are first deployed or migrated to Azure, a decision is made about their region.  However, as time passes, you should review that decision to see if a different region might be a better fit. For example, another region could have services or capabilities unavailable in the current region, or you might want to move your workload closer to a new customer base. Data residency laws might change, or budgets could shift. Rather than work around these changes and encounter cost or performance issues, a relocation might be the best way to proceed for your workload.

*Table 1. Example scenarios that drive relocations.*

| Relocation drivers | Examples |
| --- | --- |
| Business developments | Respond to business changes and expand your global footprint. |
| Compliance | Meet data sovereignty and residency requirements. |
| Proximity | Provide lower latency to end users. |

## How to relocate

We divide the relocation lifecycle into two phases. The first phase is Initiate. The Initiate phase is where you establish the relocation project. The second phase is Move. The Move phase is where you plan and execute the relocation. These are project-level steps that define the lifecycle of relocation. They show how to find the right relocation tool and when to use it. But they don't tell you how to use the tool. Let’s look at the two phases of relocation.

**Initiate phase:** The initiate phase has a single-step also called Initiate. The goal of the Initiate phase is to set up the relocation project, get stakeholder approval, and identify workloads for relocation.

**Move phase:** The Move phase is a four-step process to plan and move a workload to a different region. The steps in the Move Phase are (1) evaluate, (2) select, (3) migrate, and (4) cutover. After you cut over the final workload, you need to officially close to the relocation project.

*Table 2. The steps of the Move phase and their main goal.*

| Step | Main goal |
| --- | --- |
|1. Evaluate| Conduct workload discovery|
|2. Select| Pick the right relocation method|
|3. Migrate| Relocate the workload|
|4. Cutover| Direct traffic to new location|

## Next step

We invite you to read relocation best practices and use it as guidance for each workload relocation. The following articles detail how you should approach each step. The content highlights critical areas to focus on but also refers you to other documentation for deeper technical insight. We assume a basic understanding of Azure regions and service availability. For more information, see:

- [Azure regions decision guide](/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions)
- [Special conditions to consider when moving a resource](/azure/azure-resource-manager/management/move-support-resources)
- [Azure Products by Region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/)
- [Azure regions and availability zones](/azure/reliability/availability-zones-overview)
- [List of region pairs](/azure/reliability/cross-region-replication-azure#azure-cross-region-replication-pairings-for-all-geographies)
- [Azure Services](/azure/reliability/availability-service-by-category)
- [How to move resources](/azure/resource-mover/move-region-within-resource-group)

There are a few prerequisites that you need to address before relocating a workload. The Initiate phase provides guidance for these prerequisites.

> [!div class="nextstepaction"]
> [Initiate](initiate.md)
