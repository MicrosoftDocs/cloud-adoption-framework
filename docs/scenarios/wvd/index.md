---
title: Migrate or deploy Windows Virtual Desktop instances to Azure
description: Use the Cloud Adoption Framework best practices to migrate or deploy Windows Virtual Desktop instances to Azure.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/17/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: internal
---

# Migrate or deploy Windows Virtual Desktop instances to Azure

Migrating an organization's end-user desktops to the cloud is a common scenario in cloud migrations. Doing so helps improve employee productivity and accelerate the migration of various workloads to support the organization's user experience.

## Strategy and motivations

Virtual desktop migrations are motivated by a few common target outcomes, as shown and listed here:

![List of motivations for virtual desktop migration.](../../_images/migrate/wvd/motivations.png)

- Organizations want to extend productivity to PCs, phones, tablets, or browsers that might not be under the direct control of the IT team.
- Employees need to access corporate data and applications from their devices.
- As workloads are migrated to the cloud, employees need more support for a low-latency, more optimized experience.
- The costs of current or proposed virtual desktop experiences need to be optimized to help organizations scale their remote work more effectively.
- The IT team wants to transform the workplace, which often starts with transforming employees' user experience.

Virtualization of your end users' desktops in the cloud can help your team realize each of these outcomes.

## Approach: Windows Virtual Desktop refactor and modernization

In the approach outlined in this article series, the existing Citrix, VMware, or Remote Desktop Services farms are modernized and replaced with a platform as a service (PaaS) solution called Windows Virtual Desktop.

In this scenario, desktop images are either migrated to Azure or new images are generated. Similarly, user profiles are either migrated to Azure or new profiles are created. For the most part, the client solution is enabled but largely unchanged by this migration effort.

![Diagram of the virtual desktop migration scenario.](../../_images/migrate/wvd/scenario-solution.png)

When the migration to the cloud is finished, the overhead and costs of managing a virtual desktop farm are replaced with a cloud-native solution that manages the virtual desktop experience for your team. The team needs to be concerned only with support of the desktop images, available applications, Azure Active Directory, and user profiles.

## Next steps

For guidance on specific elements of the cloud adoption journey, see:

- [Plan for Windows Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete a Windows Virtual Desktop proof-of-concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
