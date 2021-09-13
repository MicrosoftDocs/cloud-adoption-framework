---
title: Introduction to the modern application platform scenario
description: Describe the scenario
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Introduction to the modern application platform scenario

As customers address larger, more sophisticated forms of cloud adoption, their journey to the cloud becomes more complex. Commonly, customers use orchestrated containers to manage pools of workloads in one or more centralized clusters. This article series combines technical and non-technical considerations required to prepare for Kubernetes and container integration into centralized operations and your broader cloud strategy.

Organizations include managed services, application services, and containers in their overall strategy to accelerate developer productivity, reduce operating overhead, make workloads more portable, and modernize legacy workloads.

- **Application platform:** A collection of application dependencies designed to support the execution of the application. Application platforms accelerate development by providing well-defined structures to address many common needs. Application platforms can also create constraints that affect how the application can be built.
- **Application services (PaaS services):** Application services, or platform as a service (PaaS) options for developers, provide an application platform that maximizes the value each application can draw from a cloud environment. These services create a layer of abstraction between the application platform and the underlying cloud infrastructure. This layer of abstraction forces a specific and consistently defined set of application platform constraints, which can only run in specific environments.
- **Containers:** Containers create a similar layer of abstraction between applications runtime requirements and underlying operating system & infrastructure. Unlike PaaS options, containers allow the application runtime to be configured for the needs of the application, regardless of the container host.
- **Container orchestration:** A container orchestrator provides a consistent application runtime for an instance of a container host. This orchestration allows workload-focused operations teams to mature deployment and DevOps practices to facilitate multiple deployment and operations practices, reducing dependencies on centralized or human operations.

This article series will outline how application services and containers can be integrated into your cloud adoption strategy to delivery the following outcomes:

- **Developer acceleration through abstraction:** Both containers and application services, accelerate developer productivity by allowing developers to focus more on code and less on host environment concerns.
- **Reduce operations costs through abstraction:** Standardized container orchestration ensures consistent runtimes across all hosts, which streamlines operations regardless of the workloads developers may deploy. Through standardization, centralized operations teams can extend traditional support and operations practices to container hosts.
- **Workload portability through abstraction:** Moving workloads between container orchestrators allows for workload portability. Some container orchestration platforms work in the public cloud. Other container orchestration platforms are designed for edge or private cloud deployment. Allowing for diverse container orchestration options allows for portability of workloads between container hosts across hybrid, multicloud, edge, and public cloud platforms.
- **Modernize legacy workloads through abstraction:** Legacy workloads may require a layer of abstraction prior to migration or modernization. Customizing the runtime on a container host allows the legacy requirements to be met in a modern cloud environment.

This article series outlines how you can integrate container and container management into your strategy, plan, adoption, and operation phases of your cloud journey.

## Components of the scenario

This scenario is designed to guide the end-to-end customer journey, throughout the cloud adoption lifecycle. Completing the journey requires a few key guidance sets:

- **Cloud Adoption Framework:** These articles walk through the smallest set of considerations and implementations of each CAF methodology. Use these articles to prepare decision makers, central IT, and the cloud center of excellence for adoption of containers and container management as a central part of your technology strategy.
- **Azure Well-Architected Framework:** These articles outline the considerations that each workload owner should make when their workloads need to be deployed using containers or container management solutions like Kubernetes.
- **Reference architectures:** These reference solutions aid in accelerating deployment of container solutions using Azure Kubernetes Service (AKS).
- **Featured Azure products:** Learn more about the products that support your container and container management strategy in Azure.
- **Microsoft Learn modules:** Gain the hands-on skills required to implement, maintain, and support container and AKS solutions.

## Common customer journeys

**AKS reference architectures:** The reference architectures listed in the left pane demonstrate how to deploy various proven architectures to manage your container and Kubernetes platforms with the help of Azure Kubernetes Service (AKS). These architectures are the suggested starting point for Kubernetes in Azure.

**Migrate existing workloads to AKS:** A common use case for AKS in Azure is to modernize existing web-based workloads directly to a container-based or cloud-native solution, instead of traditional migration efforts. The article on [migrating to containers](./migrate.md) will demonstrate how Azure Migrate can accelerate container migration within your standard migration processes.

**Centralize deployment and management of containers:** The first set of articles in the left pane provides rich guidance on centralization of your container strategy. This article series intends to help central IT or cloud center of excellence teams understand how containers affect your cloud strategy and how to provide consistent centralized support.

**Prepare for governance and operation of containers at scale:** [Enterprise-scale for AKS](./enterprise-scale-landing-zone.md) demonstrates how you can use enterprise-scale landing zones to ensure consistent governance, security, and operations across multiple landing zones for centralized management of containers at scale.

**Implement specific Azure products:** Accelerate and improve container and Kubernetes capabilities using different kinds of Azure products outlined in the featured products section.

## Next step: Integrate modern application platforms into your cloud adoption journey

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for modern application platforms](./strategy.md)
- [Plan for modern application platforms](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate workloads to modern application platforms](./migrate.md)
- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
