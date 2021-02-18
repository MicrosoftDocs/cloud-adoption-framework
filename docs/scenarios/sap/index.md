---
title: Introduction to an SAP adoption scenario
description: Understand the process for integrating an SAP platform into your cloud adoption efforts.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
ms.custom: think-tank
---

# Introduction to an SAP adoption scenario

This article series outlines the process for integrating an SAP platform into your cloud adoption efforts.

## Executive summary of SAP on Azure

These articles describe how SAP workloads impact your overall strategy, cloud adoption plan, and environmental readiness efforts, with detailed guidance on common drift for each effort. Once an environment is established, the series explains the processes for migrating an SAP platform and how to use cloud technologies to innovate on that platform. To support your cloud adoption needs, the series also outlines considerations and best practices for managing governance and operations throughout an SAP deployment.

To accelerate these efforts, the articles also include detailed technical resources that describe how to build an enterprise-scale landing zone that can support your mission-critical SAP needs.

## How to align to the SAP migration framework

The SAP on Azure team has produced a comprehensive framework for migrating and innovating with SAP on Azure. That framework is the de facto guide for organizations who are hyper-focused on delivering the best possible migration of SAP to Azure. If your highest priority is the successful migration of SAP to the cloud, continue to use that guide.

![Diagram of the SAP migration framework](./media/sap-migration-framework.png)

This article series outlines an SAP scenario for the Cloud Adoption Framework, and it complements the current SAP migration framework. These articles are also designed for a slightly different audience with slightly different goals, and they can help your organization if you're integrating the migration of SAP into your overall cloud adoption plan. As organizations migrate to the cloud, they typically need to migrate, innovate, and manage a variety of workloads and technology platforms to accomplish their business goals. Those efforts align with the methodologies in the Cloud Adoption Framework for consistent processes and approaches across various technology platforms and workloads. 

If your team(s) is following the guidance in both frameworks, you will see very similar guidance just in packaging that better aligns with the audience and their objectives. Below is a list of the terms to help both audiences can have a similar conversation:

|||
|---------|---------|
|**Discover**|When cloud adoption spans multiple technology platforms, we've found that it's best to separate the discovery process into two conversations: [Strategy](./strategy.md), to engage business executives during strategic alignment, and [Plan](./plan.md), to prepare the plan based on current and future-state data.|
|**Prepare**|The [Ready](./ready.md) methodology prepares your team and the environment for the coming work. This scenario also integrates Azure landing zones to provide pre-developed and opinionated approaches to help your team to rapidly deploy environments that can support various technology platforms.|
|**Migrate**|The [Migrate](./migrate.md) methodology demonstrates how an SAP migration can integrate with other repeatable migration processes.|
|**Run**|The [Manage](./manage.md) methodology shows how a common operations baseline can address many of the run-state concerns addressed in [Migrate](./migrate.md) and also meet the operational needs of other technology platforms.|
|**Innovate**|The [Innovate](methodology.md) outlines how you can take your SAP platform to the next level and integrate cloud-native solutions into your workloads.|

The guidance aligns these two sources to allow your SAP and central IT teams to work together during all phases of cloud adoption.

## The SAP adoption process

Adopting SAP workloads in the cloud will touch on most of the methodologies and phases within the Cloud Adoption Framework. Distinct constraints within each phase will require actions specific to SAP, and this article series maps standard processes to SAP-specific tasks.

![Diagram of the methodologies within the Cloud Adoption Framework and how to get started with migration in Azure.](../../_images/get-started/caf-baseline-journey.png)

## Next steps

The following articles provide guidance for specific points throughout the cloud adoption journey to help you succeed in adopting SAP in Azure.

- [The strategic impact of SAP in the cloud](./strategy.md)
- [Plan for SAP cloud adoption in Azure](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate an SAP platform to Azure](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
