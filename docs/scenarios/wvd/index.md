---
title: "Migrate or deploy Windows Virtual Desktop instances to Azure"
description: Migrate or deploy Windows Virtual Desktop instances to Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/01/2010
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Migrate or deploy Windows Virtual Desktop instances to Azure

Migrating end-user desktops to the cloud is a common scenario in cloud migrations. This scenario enables productivity boosts and accelerates the migration of various workloads to support the end-user experience.

## Strategy and motivations

Virtual desktop migrations are motivated by a few common target outcomes, pictured and listed below:

![Motivations for virtual desktop migration](../../_images/migrate/wvd/motivations.png)

- There is a clear desire to extend productivity to PC, phones, tablets, or browsers that might not be under the direct control of IT.
- End users have a need to access corporate data and applications from their devices.
- As workloads are migrated to the cloud, end users need more support to have a low-latency, performant experience.
- Cost of current or proposed virtual desktop experiences needs to be optimized so you can scale remote work cost effectively.
- The IT team wants to transform the workplace, which often starts with transforming the end-user experience.

Virtualization of the end-user desktops in the cloud can help realize each of these motivations.

## Approach: WVD refactor and modernization

In the approach outlined in this article, the existing citrix, VMware, or remote desktop service (RDS) farms will be modernized to use a platform as a service (PaaS) solution, called Windows Virtual Desktop (WVD).

In this approach, the management of virtual desktops is modernized and replaced with the platform as a service offering in Azure, called Windows Virtual Desktop. The desktop image is either migrated to Azure or new images are generated. The user profile is also migrated to Azure or a new profile is created. For the most part, the client solution is enabled but largely unchanged by this migration effort.

![Solution diagram for virtual desktop migration scenario](../../_images/migrate/wvd/scenario-solution.png)

When finished the overhead and costs of managing a virtual desktop farm is replaced with cloud-native solution, which manages the virtual desktop experience for customers. Your team only has to be concerned with support of the desktop images, available applications, Azure Active Directory, and user profiles.

## Next step: Integrate this strategy into your cloud adoption journey

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey.

- [Plan for Windows Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zone(s)](./ready.md)
- [Complete a Windows Virtual Desktop proof-of-concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
