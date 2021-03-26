---
title: Outlining a strategy for a Windows Virtual Desktop environment
description: Explore strategic benefits of a Windows Virtual Desktop
author: DominicAllen
ms.author: doalle
ms.date: 4/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Strategic Impact of a Windows Virtual Desktop environment

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy.

This article will help expose a number of considerations regarding virtual desktops that will have an impact on your strategy.

## Virtual Desktop outcomes

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

## Next step: Plan for a virtual desktop environment

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the adoption of virtual desktops as part of your cloud environment.

- [Plan for Windows Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete a Windows Virtual Desktop proof-of-concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
- [Enterprise Scale Landing Zone for Windows Virtual Desktop](./wvd/enterprise-scale-landing-zone.md)
- [Manage your virtual desktop environment](./wvd/WVD-manage.md)
- [Govern your virtual desktop environment](./wvd/WVD-govern.md)