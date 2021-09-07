---
title: Innovation and Azure Virtual Desktop
description: Explore how organizations can innovate with Azure Virtual Desktop
author: DominicAllen
ms.author: doalle
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Innovation and Azure Virtual Desktop environment

Technologies such as virtual desktops offer new ways to deliver a productivity environment to organizations. Virtual desktops provide a central, scalable, and secure desktop experience. The result is users can work in ways that traditionally weren't possible, and with a more performant experience.

The following guidance provides information on how Azure Virtual Desktop can help organizations drive innovative new ways for their teams to work.

## Innovation scenarios

- **Provide desktop environments for temporary workers:** Azure Virtual Desktop instances can be deployed and configured quickly and at scale. Similarly, they can be shut down quickly. This technology provides a standardized access method to corporate applications and information for temporary workers.

    By using Azure Virtual Desktop, virtual desktops can be used to securely provide productivity environments without the need to build, ship, and manage physical devices. An Azure Virtual Desktop approach also provides enterprise-level security and access management.

- **Deliver latency sensitive applications to remote workers:** Remote working is most effective for asynchronous or latency-tolerant applications, where performance isn't degraded significantly by inconsistent network quality or round-trip latency. For those applications that do require short ping times from client to server, an Azure Virtual Desktop environment can help provide a performant experience.

    By hosting the desktop session in Azure alongside the application, organizations can use the Azure network to connect the application client and server. This configuration results in a lower-latency connection than a traditional VPN connection over a public network.

- **Provide highly secure working environments:** In certain scenarios, the need to remove the risk of corporate data being stored on physical devices, for example laptops, is a key requirement.

    By providing specific users access to a desktop, and the associated applications and data using Azure Virtual Desktop, organizations can retain the entire desktop within the corporate environment. The result is if the local device is lost, or accessed by someone without authorization, the data and applications are not stored locally and not at risk.

- **Modernize applications with MSIX app attach:** MSI installer packages have become the application packaging standard for Windows-based applications. MSIX is a new packaging format that offers many features aimed to improve the packaging experience for all Windows applications. The Azure Virtual Desktop related innovation to application management is a new feature called [MSIX app attach](/azure/virtual-desktop/what-is-app-attach). MSIX app attach is a way to deliver MSIX applications to both physical and virtual machines. However, MSIX app attach is different from regular MSIX because it's made specifically for Azure Virtual Desktop. This creates separation between user data, the operating system, and applications by using MSIX containers. You can remove the need for repackaging when you deliver applications dynamically. You can reduce the time it takes for a user to sign in to Azure Virtual Desktop. At the same time, you can reduce infrastructure requirements and cost.

## Next steps

The following resources provide guidance for specific points throughout the cloud adoption journey to help you be successful in the adoption of Azure Virtual Desktop, as part of your cloud environment.

- [Plan for Azure Virtual Desktop migration or deployment](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Complete an Azure Virtual Desktop proof-of-concept](./proof-of-concept.md)
- [Assess for Azure Virtual Desktop migration or deployment](./migrate-assess.md)
- [Deploy or migrate Azure Virtual Desktop instances](./migrate-deploy.md)
- [Release your Azure Virtual Desktop deployment to production](./migrate-release.md)
- [Enterprise-scale landing zone for Azure Virtual Desktop](./enterprise-scale-landing-zone.md)
- [Manage your virtual desktop environment](./manage.md)
- [Govern your virtual desktop environment](./govern.md)
