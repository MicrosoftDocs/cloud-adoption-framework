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

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on what you are trying to do in the cloud.

The standard Plan methodology focuses on the [five Rs of rationalizing your digital estate](/../../digital-estate/5-rs-of-rationalization.md) and the most common paths to cloud adoption.) More specifically, these plans are tailored to the most common scenarios: Rehost, Rearchitect, or Rebuild.

## Initial containers considerations

If you need to orchestrate container deployment, manage provisioning, or control the configuration of containers at scale, you'll need to include a container orchestration solution like Kubernetes. In Azure, that is delivered as a service, Azure Kubernetes Service (AKS). When AKS is the default containerization approach, you'll need to include efforts to **package** workloads into containers and **rehost** these containers in Azure.

If container orchestration isn't required, Azure provides various solutions to rearchitect workloads within your portfolio. The following solutions would each follow this approach to planning:

- App Service
- Azure Functions
- Azure Container Instances
- Batch
- Azure Red Hat OpenShift
- Azure Service Fabric

For assistance comparing container modernization options, see the [container and compute decision tree](https://docs.microsoft.com/azure/architecture/guide/technology-choices/compute-decision-tree)

## Digital estate

When planning for your digital estate, you'll want to [gather inventory data](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/inventory) and [rationalization your estate](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/rationalize). In a container adoption plan, it's vital all assets, for example VMs, Data, and Applications, are grouped by the workload they support. Once the grouping and basic rationalization is complete, you can evaluate these workloads to determine the Package/Rehost or Rearchitect options.

In digital estate evaluation, you'll also need to evaluate your plan for data based on container persistence. Containers can run in a persistent or non-persistent state. Persistent state containers will retain data if there is a failure. Non-persistent containers won't maintain data. If you choose a non-persistent configuration, which is common for mature devops teams, you'll need to account for hosting the workloads data in a persistent environment, like Azure SQL.

These considerations will create clarity about the actions needed to complete adoption of containerized workloads in the cloud.

## Modern container adoption plan

The standard [Cloud Adoption Plan template](https://docs.microsoft.com/azure/cloud-adoption-framework/plan/template) accounts for the types of work required in a typical cloud adoption effort. However, you'll need to add tasks to your plan for packaging the workload into containers and orchestration of the container provisioning. 

## Modern container readiness plan

In addition to the cloud adoption skilling plan, the cloud adoption teams might need to develop skills related to container and Kubernetes before executing your plan:

- [Learn the basics of Kubernetes](https://aka.ms/LearnAKS)
- [Learn about containers](https://azure.microsoft.com/overview/containers/)
- [Get familiar with Kubernetes best practices](https://aka.ms/aks/bestpractices)

## Next step: Review your environment or Azure Landing Zone

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for modern containers](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
