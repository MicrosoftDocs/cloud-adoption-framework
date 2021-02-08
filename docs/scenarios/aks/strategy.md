---
title: "Strategy for modern container adoption"
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of modern containers

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy.

This article will help expose a number of considerations regarding modern containers that may have an impact on your strategy.

## Modern container motivations

Organizations most commonly choose containers when innovation is a high priority. But management of cloud-native applications is also a very common driver. When migrating workloads, containerization may also be a sound option, if workload portability and environmental consistency are important to the success of the migration project.

Kubernetes then provides a layer of orchestration to make it easier for the organizations to capitalize on the benefits of containers and improve overall operations of containerized environments and workloads.

In Azure, the Azure Kubernetes Service (AKS) provides end to end container orchestration as a service.

## Modern container outcomes

To measure the impact of container and Kubernetes adoption efforts, the following a few key metrics that can be tracked & evaluated:

- Workload portability: Move your applications anywhere with a common containerized environment. Since there is a layer of abstraction between the Kubernetes cluster and the underlying infrastructure, you can move workloads between development and production environments or between cloud providers with ease.
- Provisioning and scale time: Elastic provisioning with event-driven autoscaling and triggers to reduce the time to provision and scale the resources supporting your workloads.
- Accelerated development times: Combining development tools, automated deployment, and integrated monitoring across consistent & standardized environments allows developers to focus more on building great products and less on the supporting infrastructure configuration across dev and prod environments.
- Improved cluster security: Integration between your existing identity and access management (IAM) provider and your clusters ensures a secure environment across all stages of deployment.

## Next step: Plan for modern containers

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for modern containers](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
