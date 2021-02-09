---
title: "Introduction to the SAP adoption scenario"
description: Describe the scenario
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# SAP on Azure

This article series outlines the process for integrating SAP into your cloud adoption efforts.

## SAP on Azure executive summary

This article series outlines how SAP workload impacts your overall strategy, cloud adoption plan, and environmental readiness efforts with detailed guidance on common drift for each effort. Once an environment is established, the series explains the processes for migrating an SAP platform and innovating on that platform using cloud technologies. To support your cloud adoption needs, the series also outlines the considerations for governance and operations management commonly necessitated by an SAP deployment.

To accelerate each of the above efforts, the article series also includes detailed technical references demonstrating how you can build an enterprise-scale landing zone to support all of your mission critical SAP needs.

## Alignment to SAP Migration framework

The SAP on Azure team has produced a comprehensive framework for migrating and innovating with SAP on Azure. That framework is the de facto guide for organizations who are hyper-focused on delivering the best possible migration of SAP to Azure. If your highest priority is the successful migration of SAP to the cloud, continue to use that guide.

![SAP Migration framework](./media/sap-migration-framework.png)

The Cloud Adoption Framework's SAP scenario (this article series) is a compliment to the existing SAP Migration framework. But the articles in this series are designed for a slightly different audience with slightly different goals. As organizations migrate to the cloud, they will commonly need to migrate, innovate, and manage a variety of workloads and technology platforms to accomplish business goals. Those efforts follow the methodologies in the Cloud Adoption Framework for consistent processes and approaches across various technology platforms and workloads. If you are integrating the migration of SAP into your overall cloud adoption plan, use this article series.

If your team(s) is following the guidance in both frameworks, you will see very similar guidance just in packaging that better aligns with the audience and their objectives. Below is a mapping of the terms so both audiences can have a similar conversation:

|||
|---------|---------|
|**Discover**|When cloud adoption spans multiple technology platforms, we've found that it's best to seperate the discovery process into two conversations: [Strategy](./strategy.md) to engage business executives during strategic alignment & [Plan](./plan.md) to prepare the plan based on current and future state data|
|**Prepare**|The [Ready](./ready.md) methodology prepares your team and the environment for the coming work. This scenario also integrates the Azure Landing Zones to provide pre-developed and opinionated approaches to rapidly deploy environments that can support a variety of technology platforms.|
|**Migrate**|The [Migrate](./migrate.md) methodology will demonstrate how SAP migration can be integrated into other repeatable migration processes.|
|**Run**|The [Manage](./manage.md) methodology will show how a common operations baseline can address many of the run-state concerns addressed in the SAP Migration guide, while also meeting the operational needs of other technology platforms.|
|**Innovate**|The [Innovate](methodology.md) outlines a variety of ways that you can take your SAP platform to the next level and integrate cloud-native solutions into your workloads.|

The guidance is designed to align & compliment between these two sources, to allow your SAP and central IT teams to work together during all phases of cloud adoption.

## SAP adoption scenario

Adoption of SAP workloads in the cloud will touch on most of the methodologies within the cloud adoption framework. In each of those phases, there are distinct constraints which will require SAP specific actions. This article series includes a mapping between the standard processes & SAP specific tasks.

![Get started with migration in Azure](../../_images/get-started/caf-baseline-journey.png)

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful adopting SAP in Azure.

- [Strategy for SAP](./strategy.md)
- [Plan for SAP](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate SAP](./migrate.md)
- [Innovate with SAP](./innovate.md)
- [Manage SAP](./manage.md)
