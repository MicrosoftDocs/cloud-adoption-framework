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

To measure the impact of virtual desktop adoption efforts, the following a few key outcomes that can be tracked and evaluated:

- **Provisioning and scale time**: making virtual desktops available to users will be orders of magnitude quicker than building and shipping physical devices. This results in an ability to agile in service provision. Unforeseen circumstances that result in teams being unable to access an office location can be mitigated by providing virtual desktops.
- **Reduced desktop management effort**: by consolidating the end user desktop into a virtual experience, management can be centrally managed (and automated) more easily. By reducing the volume of physical devices in use, the amount of human interaction and asset tracking is also reduced. This results in teams being able to manage a large desktop estate primarily with tools and automation, instead of physical maintenance activities.
- **Simplified end user compute inventory**: In large scale enterprises, asset management for a end user compute invetory is often a full-time role or function. By moving a proportion of the desktop estate into a virtual environment, physical asset tracking and inventory activities can be reduced and simplified. The same asset tracking tools and automation used to catalog virtual servers can be used to track virtual desktops to help with this.
- **Improved remote access experience for latency-sensitive applications**: Certain line of business applications can be sensitive to the effects of latency, resulting in an increase in performance issues when being used remotely. This can be mitigated by moving the desktop into a virtual environment that is located close to (often with the same network) as the application being connected to. This approach can help provide a performant experience for teams working remotely and reduce the service incidents received by support teams related to application issues.

## Next step: Plan for a virtual desktop environment

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the adoption of virtual desktops as part of your cloud environment.

[Enterprise Scale Landing Zone for Windows Virtual Desktop](./wvd/enterprise-scale-landing-zone.md)
[Manage your virtual desktop environment](./wvd/WVD-manage.md)
[Govern your virtual desktop environment](./wvd/WVD-govern.md)
