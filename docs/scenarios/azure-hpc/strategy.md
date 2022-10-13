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

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-plan-template.docx) to record your cloud adoption strategy. This article will help expose a number of technical considerations regarding HPC that may have an impact on your strategy.

## HPC motivations

When building your own HPC solution, there is significant investment required in specifying the right supercomputer specs and clusters. There are also financial concerns for investing in capital for continually upgrading computing hardware to meet high demanding workloads.

There are other concerns with time, as scheduling can take from days to months to run an on-premise HPC workload which will heavily affect optimization of internal operations.

## HPC outcomes

With HPC in Azure, there is less concern in building and owning your own expensive hardware and more focus on aligning your tools and processes to get the data you need for simulation and modeling results.

As geographical and market HPC demands require scaling out the compute resources, an Azure HPC system allows flexibility by adding dynamic resources as they are needed and remove them as demand falls to ensure a cost effective and high performing solution.

### Common Customer HPC Journeys

- **Automotive industry organizations** are able to simulate all aspects of vehicle engineering in cost effective, high performing, and highly secure infrastructure without concerns over traditional costs and maintenance responsibilities. HPC in Azure includes AI tools to find insights from 30 to 50 billion data points for complex data analyses such as racing strategies or autonomous driving.
- **Energy industry organizations** such as oil and gas benefit from an up-scaled, end-to-end AI ecosystem that provides nurturing new ideas into safety operations and taking vast data repositories into AI solutions that promote operational advances such as predictive maintenance, simulation workloads, and automating completion reports to reduce data extraction times from months to hours.
- **Health and life sciences** industries take advantage of HPC to create the next generation of healthcare breakthroughs in evaluating and treating diseases by using Azure data services. The HPC tools  assist in identifying health risk data, running benchmarks to optimize drug screening, and research underlying biology to better understand medical conditions.
- **For silicon industry** organizations, HPC boosts productivity, optimizes resources, and speed up time to produce and market finely tuned manufacturing and design solutions.
- **Finance organizations** use HPC to modernizing approaches to risk management, portfolio optimization, and implementing effective compliance and governance practices to protect consumer data. Computationally intensive workloads in Azure HPC have reduced costs and increased/instantaneous scalability for on-demand pricing model calculations.
- **Manufacturing organizations** utilize HPC to fuel real-time product simulations that reduce time to market and improve product quality. Thousands of on-demand simulation jobs are executed to deliver faster solutions and more improved insights for following health and safety regulations.  

## HPC business justification

When configuring your HPC environment to the cloud, you will want to consider forecasting what your on-premises HPC costs would be if no cloud migration is planned versus the costs of migrating to the cloud to determine how much spending is done to run your environment today, in an average year, and what the migration timeline will look like.

[Create a business case](../../strategy/cloud-migration-business-case.md) to help foster support from your finance team and other areas of the business to accelerate your cloud migration timeline and promote business agility. Also look into the different types of [cloud savings](../../strategy/cloud-migration-business-case.md#cloud-savings) to determine which billing model will be most cost effective for your HPC environment.

## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for HPC](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Govern HPC](./govern.md)
- [Secure HPC](./secure.md)
- [Organize team members for HPC in Azure](./organize.md)
- [Migrate HPC](./migrate.md)
- [Innovate with HPC](./innovate.md)
- [Manage HPC](./manage.md)
