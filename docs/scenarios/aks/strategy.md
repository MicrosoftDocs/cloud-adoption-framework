---
title: Strategy for modern container adoption
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: think-tank, e2e-aks
---

# Strategic impact of modern containers

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy.

This article will help expose a number of considerations regarding containers that will have an impact on your strategy.

## Modern container motivations

***** NEW CONTENT

Application services and containers can accelerate cloud adoption strategies, if the motivations of that strategy focus on the following: 

- Pace of innovation: Delivering technology-driven products and services to market faster than the competition
- Streamlined operations: Operations of a diverse set of workloads needs to be optimized to reduce operational overhead

Reducing the direct dependencies between workload operations and the operations of the underlying infrastructure through modern abstraction options like Applications services (PaaS solutions) and orchestrated containers, can contribute to the success of each of these common motivations.

**** Original content to be removed

Organizations most commonly choose containers when innovation is a high priority. But management of highly componentized, cloud-native applications is also a very common driver. When migrating non-containerized workloads, first containerizing the workload may also be a sound option if workload portability and environmental consistency can obtained with minimal functionality changes within the workload.

Kubernetes then provides a layer of orchestration to make it easier for the organizations to capitalize on the benefits of containers and improve overall operations of containerized environments and workloads. In Azure, the Azure Kubernetes Service (AKS) provides end to end container orchestration as a service.

*******

## Modern container outcomes

****** Added streamlined operations below. Also moved provisioning and scale time lower in the list.

To measure the impact of *container and Kubernetes* adoption efforts, the following are a few key outcomes that can be tracked and evaluated:

- **Accelerated development times:** Combining development tools, automated deployment, and integrated monitoring across consistent and standardized environments allows developers to focus more on building great products and less on the supporting infrastructure configuration across dev and prod environments.
- **Streamlined operations:** Standardized container orchestration ensures consistent runtimes across all hosts, which can reduce technical complexity across the portfolio. Through standardization, centralized operations teams can extend traditional support and operations practices to container hosts resulting in a smaller number of assets to be managed.
- **Workload portability:** Move your applications anywhere with a common containerized environment. Since there is a layer of abstraction between the Kubernetes cluster and the underlying infrastructure, you can move workloads between development and production environments or between cloud providers with less effort than cloud provider native solutions.
- **Provisioning and scale time:** Infrastructure elasticity to reduce the time to provision and scale the resources supporting your workloads.
- **Safe deployment practices:** Kubernetes workloads and constructs supports many deployment methods, allowing workloads to rolled out with confidence.
- **Integrated access management:** Integration between your existing identity and access management (IAM) provider and your clusters ensures a secure environment across all stages of deployment.
- **Infrastructure isolation:** Kubernetes clusters can range from a public cloud offering through a completely private offering, allowing you to control exposure of your workload and its runtime environment specifically to the desired level.
- **Network observability:** Traffic entering and exiting Kubernetes clusters can be subjected to internal traffic monitoring and control to achieve desired security outcomes.
- **Talent retention:** Modern infrastructure improves hiring and retaining of talent due to using modern, industry-standard, cloud agnostic tooling that is seen as highly desirable to work with.

## Next step: Plan for modern containers

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for modern containers](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](/azure/architecture/reference-architectures/containers/aks-start-here?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
