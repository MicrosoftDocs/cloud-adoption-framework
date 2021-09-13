---
title: Strategy for modern application platform adoption
description: Describe the scenario's impact on strategy
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

# Strategic impact of modern application platform

Best practice encourages customers to create a single centralized cloud adoption strategy, using the [Cloud Adoption Framework's Strategy methodology](../../strategy/index.md). If you haven't already, use the [strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx) to record your cloud adoption strategy.

This article will help expose a number of considerations regarding containers that will have an impact on your strategy.

## Motivations

Application services and containers can accelerate cloud adoption strategies, if the motivations of that strategy focus on the following:

- Pace of innovation: delivering technology-driven products and services to market faster than the competition
- Streamlined operations: operations of a diverse set of workloads need to be optimized to reduce operational overhead

Reducing the direct dependencies between workload operations and the operations of the underlying infrastructure through abstraction options like applications services (PaaS solutions) and orchestrated containers, can contribute to the success of each of these common motivations.

## Modern container outcomes

To measure the impact of modern application platform adoption efforts, the following are a few key outcomes that can be tracked and evaluated:

- **Accelerated development times:** Combining development tools, automated deployment, and integrated monitoring across consistent and standardized environments allows developers to focus more on building great products and less on the supporting infrastructure configuration across development and production environments.
- **Streamlined operations:** Standardized container orchestration ensures consistent runtimes across all hosts, which can reduce technical complexity across the portfolio. Through standardization, centralized operations teams can extend traditional support and operations practices to container hosts resulting in a smaller number of assets to be managed.
- **Workload portability:** Move your applications anywhere with a common containerized environment. Since there is a layer of abstraction between the Kubernetes cluster and the underlying infrastructure, you can move workloads between development and production environments or between cloud providers with less effort than cloud provider native solutions.
- **Provisioning and scale time:** Infrastructure elasticity to reduce the time to provision and scale the resources supporting your workloads.
- **Safe deployment practices:** Kubernetes workloads and constructs support many deployment methods, allowing workloads to be rolled out with confidence.
- **Integrated access management:** Integration between your existing identity and access management (IAM) provider and your clusters ensures a secure environment across all stages of deployment.
- **Infrastructure isolation:** Kubernetes clusters can range from a public cloud offering through a completely private offering, allowing you to control exposure of your workload and its runtime environment specifically to the desired level.
- **Network observability:** Traffic entering and exiting Kubernetes clusters can be subjected to internal traffic monitoring and control to achieve desired security outcomes.
- **Talent retention:** Modern infrastructure improves hiring and retaining of talent due to using modern, industry-standard, cloud agnostic tooling that is seen as highly desirable to work with.

> [!NOTE]
> Many of the outcomes above can create conflicts with one another. It's important to **prioritize** the desired outcomes. In later phases of the cloud adoption journey, these prioritization decisions will be used to make critical design and architecture decisions.

## Next step: Plan for modern application platform

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for modern application platform](./plan.md)
- [Review your environment or Azure landing zones](./ready.md)
- [Migrate workloads to modern application platform](./migrate.md)
- [Innovate using modern application platform solutions](./innovate.md)
- [Govern modern application platform solutions](./govern.md)
- [Manage modern application platform solutions](./manage.md)
