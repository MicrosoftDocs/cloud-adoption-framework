---
title: "Plan for modern containers"
description: Describe the scenario's impact on planning
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Plan for modern containers

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) provides a direct methodology to create an overall cloud adoption plan to guide the various programs and teams involved in your cloud-based digital transformation. That guidance provides templates for creating your backlog & plans for building necessary skills across your teams; all based on what you are trying to do in the cloud.

The standard Plan methodology focuses on the [five Rs of rationalizing your digital estate](/../../digital-estate/5-rs-of-rationalization.md). (Loosely translated: The most common paths to cloud adoption.) More specifically, those plans are tailored to the most common scenarios: Rehost, Rearchitect, or rebuild.

## Initial containers considerations

If you need to orchestrate container deployment, manage provisioning, or control the configuration of containers at scale, you will need to include a container orchestration solution like Kubernetes. In Azure, that is delivered as a service, Azure Kubernetes Service (AKS). When AKS is the default containerization approach, you will need to include efforts to **package** workloads into containers AND **rehost** those containers in Azure.

If container orchestration isn't required, Azure provides a variety of solutions to rearchitect workloads within your portfolio. The following solutions would each follow this approach to planning:

- App Service
- Azure Functions
- Azure Container Instances
- Batch
- Azure Red Hat OpenShift
- Azure Service Fabric

For assistance comparing container modernization options, see the [container and compute decision tree](https://docs.microsoft.com/azure/architecture/guide/technology-choices/compute-decision-tree)

## Digital estate

When planning for your digital estate, you will still want to [gather inventory data](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/inventory) & [rationalization your estate](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/rationalize). But in a container adoption plan, it is vital that all assets (VMs, Data, and Applications) are grouped by the workload they support. Once the grouping and basic rationalization is complete, you can then evaluate those workloads to determine select from Package/Rehost or Rearchitect options.

In digital estate evaluation, you'll also need to evaluate your plan for data based on container persistence. Containers can run in a persistent or non-persistent state. Persistent state containers will retain data in the event of a failure. Non-persistent containers will not maintain data. If you choose a non-persistent configuration (which is common for mature devops teams) you will need to account for hosting of the workloads data in a persistent environment, like Azure SQL.

These considerations will create clarity regarding the actions needed to complete adoption of containerized workloads in the cloud.

## Modern container adoption plan

The standard [Cloud Adoption Plan template](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/template) accounts for the types of work required in a typical cloud adoption effort. But you will need to add tasks to your plan for packaging the workload into containers and orchestration of the container provisioning. 

## Modern container readiness plan

In addition to the typical cloud adoption skilling plan, the cloud adoption teams may need to develop skills related to container and Kubernetes before executing your plan:

[Learn the basics of Kubernetes](https://aka.ms/LearnAKS)
[Learn about containers](https://azure.microsoft.com/overview/containers/)
[Get familiar with Kubernetes best practices](https://aka.ms/aks/bestpractices)

## Next step: Review your environment or Azure Landing Zone

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for modern containers](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](./innovate.md)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
