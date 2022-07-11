---
title: Azure products supporting the modern application platforms scenario
description: A number of Azure products can support the modern application platform scenario depending on specific application and operations needs.
author: BrianBlanchard
ms.author: brblanch
ms.date: 05/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Modern application platform solutions in Azure

A number of Azure products and services can support your modern application platform needs. Selecting the right product requires intimate knowledge of the application and operations needs. To make that selection process simpler, this article will help prioritize which products to consider based on a few strategic questions:

- **Application platform:** Does the application require a *custom runtime*? Can the development team consider a *cloud runtime* definition set by the cloud provider?
- **Operations:** Will the operations of the application, application platform, or container host require *customized operations*? Or, is a *standardized operations* approach preferred to centralize operations across workloads? Alternatively, would *cloud operations* supported by the cloud provider by preferred?
- **Location:** Will this solution run in the *public cloud*? Or does it need to be deployed to *private cloud* or *edge* environments? Does the solution require *workload portability*?
- **Workload consolidation:** Will each application or workload require a *dedicated host*? Can the workload operate on a *shared host*? Or can this decision be deferred to the *cloud provider*?

## Compare Azure products

The following table maps the questions above to a few Azure products to consider.

| Azure products | Application platform | Operations | Location | Consolidation |
|--|--|--|--|--|
| Azure App Service | Cloud runtime | Cloud ops | Fixed (public cloud only) | Managed by Azure |
| Azure Stack HCI | Cloud runtime | Customizable | Fixed (private cloud only) | Shared host |
| Azure Stack HCI for AKS | Customizable | Customizable | Fixed (private cloud only) | Shared host |
| Azure Kubernetes Service (AKS) | Customizable | Customizable | Fixed (public cloud only) | Supports dedicated or shared hosts |
| Azure Arc for Kubernetes | Not applicable | Cloud operations | Supports public and private cloud | Not applicable |
| Azure App Service on Kubernetes with Azure Arc | Cloud runtime | Customizable and cloud operations | Supports public and private cloud | Supports dedicated or shared hosts |

## Azure products alignment to various roles

The following narratives share the perspectives of application and operations teams to better convey the value of each product offering.

### Azure App Service

Azure App Service enables you to build and host web apps, mobile back ends, and RESTful APIs in the programming language of your choice without managing infrastructure. It offers auto-scaling and high availability, supports both Windows and Linux, and enables automated deployments from GitHub, Azure DevOps, or any Git repo.

- **Developers** can best accelerate development using the Azure-native application platform and runtime defined by Microsoft Azure as their application platform.
- **Operations teams** want the ease and scale of operations that come from deferring many of the host operations tasks to the cloud provider.

### Azure Stack HCI

Azure Stack HCI provides an application platform, based on Azure's PaaS services, running on Azure Stack operated in private cloud or the edge, using tools which are very similar to cloud operations.

- **Developers** can best accelerate development using the Azure-native application platform and runtime defined by Microsoft Azure as their application platform.
- **Operations teams** have specific constraints:
  - Must run in a private cloud or edge.
  - It requires custom operations to fit parallel private cloud operations.
  - Most likely will consolidate workloads on shared hosts, separating host and workload operations into distinct sets of tasks for centralized host operations and workload operations which could be centralized or workload specific.

### Azure Stack HCI for AKS

Azure Stack HCI can also run an instance of Azure Kubernetes Service to support customizable application platforms running on Kubernetes.

- **Developers** require the ability to customize the application platform to meet the runtime requirements of the application.
- **Operations teams** have specific constraints:
  - Must run in private cloud or edge.
  - Requires custom operations to fit parallel private cloud operations.
  - Most likely will consolidate workloads on shared hosts, separating host and workload operations into distinct sets of tasks for centralized host operations and workload operations which could be centralized or workload specific.

### Azure Kubernetes Service (AKS)

Azure Kubernetes Service (AKS) provides a customizable runtime option based on Kubernetes, running on public cloud resources running in Azure.

- **Developers** require the ability to customize the application platform to meet the runtime requirements of the application.
- **Operations teams** have specific constraints:
  - Must run in public cloud only.
  - Requires custom operations defined by the container orchestrator and programmatic deployment of the hosts and containers, making this an idea solution for workload-specific DevOps teams with minimal dependency on centralized operations support.
    - Alternatively, container orchestrator can also be standardized across Kubernetes containers, allowing for centralized operations at scale.
  - AKS is designed to support dedicated containers per workload.
    - AKS can also be used to consolidate workloads, allowing central operations to extend support to container hosts.

### Azure Arc for Kubernetes

Azure Arc extends operations of Kubernetes clusters allowing for consistent cloud operations across public cloud, private cloud, and edge deployments of Kubernetes clusters.

- **Operations teams** have specific constraints:
  - Kubernetes containers have been deployed across multiple hybrid and multicloud environments.
  - Management of those diverse containers require centralization of operations, governance, security, and other unified operations principles regardless of environment.

### Azure App Service on Kubernetes with Azure Arc

Azure App Service on Kubernetes with Azure Arc creates consistency across development and operations.

- **Developers** can best accelerate development using the Azure-native application platform and runtime defined by Microsoft Azure as their application platform.
- **Operations teams** require flexibility:
  - Azure Arc components allow for consistent cloud operations across environments.
  - Kubernetes foundation allows for customizable or standardized container host operations at the host and workload levels.
  - The application platform overlay ensures a consistent runtime for applications that can run on Kubernetes hosts in a private cloud or edge and AKS in Azure.

## Take action

Your next step to integrate modern application platforms into your cloud adoption journey. The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for modern application platforms](./strategy.md)
- [Plan for modern application platforms](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate workloads to modern application platforms](./migrate.md)
- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
