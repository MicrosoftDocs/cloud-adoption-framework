---
title: Innovation on modern application platforms
description: Understand the Innovate methodology for a modern application platforms environment in the Cloud Adoption Framework for Azure.
author: brianblanchard
ms.author: brblanch
ms.date: 05/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-hybrid
---

# Innovation on modern application platforms

The Innovate methodology of the Cloud Adoption Framework for Azure drives adoption through the build-measure-learn cycle. The Innovate methodology focuses on digital innovation across data, applications, analytics, and AI and machine learning. Establish a vision for innovation that uses the abstraction layers provided by a modern application platform. For more information, see [Innovate methodology](../../innovate/index.md).

## Modern application platform innovation

When integrating modern application platforms into your cloud adoption strategy, innovation isn't limited to containers. Integration of modern application platforms offers the innovation that comes with other forms of hybrid and multicloud strategy.

![Diagram that shows the various innovation options enabled by the layers of abstraction in a modern app platform.](../../_images/innovate/hybrid-innovation-vision.png)

The following are examples of innovation from the layers of abstraction provided by a modern application platform innovation approach:

- **Data and innovation anywhere:** Using application portability lets data live where it makes the most sense for your users. Applications can follow the data. This approach encourages data democratization and application innovation. Azure Arc enabled data services and Azure Arc enabled Kubernetes offer management consistency when applications and data move to various environments. This approach allows developers to focus more on the application and the data, instead of the cloud or infrastructure.

- **Modernize your datacenter:** Modernizing your datacenter allows workloads to evolve and modernize to use Azure-native tools. This approach can accelerate development for even the most extensively governed workloads. Use Azure App Service for Kubernetes with Azure Arc or Azure Stack HCI to abstract out datacenter dependencies. This approach allows teams to build for cloud capabilities without leaving the datacenter.

- **Application platforms for the edge:** Extend your common runtime, shared containers, and orchestration to the edge by running Azure IoT or your application runtime on Kubernetes. For more information, see [How to install IoT Edge on Kubernetes](/azure/iot-edge/how-to-install-iot-edge-kubernetes).

- **Workload portability:** Standardize and centralize container orchestration around Kubernetes, Azure Kubernetes Service, or Azure App Service for Kubernetes with Azure Arc. This approach enables portability of workloads across instances of the common application platform running on public cloud, private cloud, and edge environments.

### Democratize data

Using modern application platforms can accelerate democratization of data. Breaking down data silos across clouds empowers business users and data scientists alike. Combining data that lives on-premises and in the cloud can form new analytics and insights. To learn more, see [Innovation tools to democratize data in Azure](../../innovate/best-practices/data.md).

### Engage on applications

Using new applications can further extend the capabilities of a common runtime.

- Developers create their own Power Apps and Power Automate solutions to extend professional applications. These applications can empower business teams from sales, payroll, finance, and others.
- Add intelligence to your applications with speech, text, vision, and chat bots. Include intelligent experiences in the public cloud, private cloud, or on the edge with web apps or serverless functions.
- Azure App Service provides an Azure-native runtime. Building on that application platform accelerates development. It also offers Azure-native features like intelligent experiences.
- Azure App Service offers workload portability and allows developers to build solutions in the cloud or edge environment that best meets their needs. You can delay governance, compliance, and security decisions until later in the development cycle.

To learn more about ways you can build applications on various modern application platforms using the consistent runtimes provided by Azure, see [Tools to engage via applications in Azure](../../innovate/best-practices/apps.md).

### Interact on devices

Bring the business integration of your modern application platform to your environment:

- **Mobile experiences:** Extend applications through the rapid development of mobile apps using the Azure App Service runtime.

- **Azure IoT:** Collect data in near-real time from devices in your business environments with Azure IoT on Kubernetes.

To learn more about using device interactions, see [Ambient experience tools to interact with devices in Azure](../../innovate/best-practices/devices.md).

## Next steps

The following articles provide guidance and help you succeed in the cloud adoption scenario:

- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
