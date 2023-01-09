---
title: Strategy for Azure high-performance computing (HPC) adoption
description: As an IT Professional, I want to find guidance in the Cloud Adoption Framework covering the strategy scenario for using Azure High-performance computing (HPC) as part of my IT strategy.
author: Rajani-Janaki-Ram
ms.author: erd
ms.date: 09/15/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Strategic impact of Azure high-performance computing (HPC)

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy. This article will help expose many technical considerations regarding HPC that have an impact on your strategy.

## HPC motivations

When building your own on-premises HPC solution, there's significant investment required in specifying the right supercomputer specs and clusters, which will incentivize cost savings and optimization of computational needs.

As you migrate your HPC environment, there will be a push for cost savings. Investing in HPC capital has financial concerns rising due to continually upgrading IT infrastructure to meet high demanding workloads. The goal will be reducing computing operational costs while still optimizing and scaling up the performance of your HPC workloads for on-demand usage.

There will also be a drive to reduce how long on-premises HPC workloads typically take to run HPC workloads for faster decision making when computing large amounts of data. These time consuming on-premises workloads could take months and will heavily affect internal operations in terms of cost and scaling.

## HPC outcomes

With HPC in Azure, there's less concern in building and owning your own expensive hardware and more focus on aligning your tools and processes to get the data you need for simulation and modeling results.

As geographical and market HPC demands require scaling out the compute resources, an Azure HPC system allows flexibility by adding dynamic resources as they're needed, and remove them as demand falls to ensure a cost effective and high performing solution.

## HPC business justification

When configuring your HPC environment to the cloud, you'll want to consider forecasting what your on-premises HPC costs would be if no cloud migration is planned versus the costs of migrating to the cloud to determine how much spending is done to run your environment today, in an average year, and what the migration timeline will look like.

[Create a business case](../../strategy/cloud-migration-business-case.md) to help foster support from your finance team and other areas of the business to accelerate your cloud migration timeline and promote business agility. Also look into the different types of [cloud savings](../../strategy/cloud-migration-business-case.md#cloud-savings) to determine which billing model will be most cost effective for your HPC environment.

## Next steps

- Start [planning](./plan.md) your cloud adoption journey for your HPC environment.
- [Classify](../../strategy/motivations.md#classify-your-motivations) your motivations for your cloud adoption strategy
- Check out what accelerating [HPC in the cloud](https://azure.microsoft.com/resources/accelerating-ai-and-hpc-in-the-cloud/) looks like.
