---
title: Plan for Azure high-performance computing (HPC)
description: #Describe the scenario's impact on planning.
author: ericd-mst-github
ms.author: erd
ms.date: 09/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Plan for Azure high-performance computing (HPC)

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on what you are trying to do in the cloud. This article outlines how to include HPC into the overall cloud adoption plan.

Application of the Plan methodology focuses on the [five Rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md). The most common path to the cloud focuses on speed, efficiency, and repeatability of the migration and modernization processes. From the five Rs, planning usually prioritizes rehost options with limited parallel support for rearchitect and rebuild options.

## HPC estate

While it is important to gather inventory data for a digital estate for cloud adoption, HPC in Azure does has a [migration](https://azure.microsoft.com/en-us/resources/hpc-migration-guide/) path in the demand of newer hardware for better performance, but keep in mind that certain VM series of hardware are specifically scoped, particularly the A8 to A11 series. 

It is recommended to assess your current environment's HPC usage to decide which HPC cluster is needed. Your organization may benefit from the performance and cost advantages of a more traditional VM SKU as well.

## HPC adoption plan

Do you have a specific devops backlog the customer should use? Or is the standard adoption plan template still sufficient?
https://docs.microsoft.com/azure/cloud-adoption-framework/plan/template

## HPC readiness plan

Are there specific skills or extra training this team should take before getting started?


## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Govern HPC](./govern.md)
- [Strategic impact of HPC](./secure.md)
- [Organize team members for HPC in Azure](./organize.md)
- [Migrate HPC](./migrate.md)
- [Innovate with HPC](./innovate.md)
- [Manage HPC](./manage.md)