---
title: Innovation and Windows Virtual Desktop environment
description: Explore how organizations can innovate with Windows Virtual Desktop
author: DominicAllen
ms.author: doalle
ms.date: 4/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Innovation and Windows Virtual Desktop environment

This article outlines how Windows Virtual Desktop (WVD) technology can help organizations drive innovative new ways of working for teams.

Technologies such as virtual desktops offer new ways to deliver a productivity environment to teams.

Given that virtual desktops are a central, scalable, secure desktop experience users are able to work in ways that may not be possible with traditional ways, or that may not have offered a performant experience.

## Innovation scenarios

- **Provide desktop environments for temporary workers**: WVD instances can be deployed and configured quickly and at scale. Similarly, they can be shut down equally quickly. This makes it a useful solution for providing a standardized access method to corporate applications and information for temporary workers.

    By using WVD, virtual desktops can be used to securely give productivity environments without the need to build, ship and manage physical devices. A WVD approach also means enterprise-level security and access management.

- **Deliver latency sensitive applications to remote workers**: remote working works best for asynchronous or latency-tolerant applications - those where performance is not degraded significantly by varying network quality or round-trip latency. For those applications that do require short ping times from client to server, a WVD environment can help provide a performant experience.

    By hosting the desktop session in Azure, alongside the application being used, organizations can use the Azure network to connect application client and server resulting in a lower-latency connection than a traditional VPN connection over a public network.

- **Provide highly-secure working environments**: in certain scenarios, the need to remove the risk of corporate data being stored on physical devices (such as laptops) is a key requirement.

    By providing specific users access to a desktop - and the associated applications and data - using WVD, organizations are able to retain the entire desktop within the corporate environment. This means if the local device were lost, or accessed by someone without authorization, the data and applications were not held locally and therefore not at risk.

## Next steps

To get started with Windows Virtual Desktop, the following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the adoption of virtual desktops as part of your cloud environment.

- [Plan for Windows Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete a Windows Virtual Desktop proof-of-concept](./proof-of-concept.md)
- [Assess for Windows Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Windows Virtual Desktop instances](./migrate-deploy.md)
- [Release your Windows Virtual Desktop deployment to production](./migrate-release.md)
- [Enterprise Scale Landing Zone for Windows Virtual Desktop](./wvd/enterprise-scale-landing-zone.md)
- [Manage your virtual desktop environment](./wvd/WVD-manage.md)
- [Govern your virtual desktop environment](./wvd/WVD-govern.md)