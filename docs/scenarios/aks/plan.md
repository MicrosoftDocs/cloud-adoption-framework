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

The standard Plan methodology focuses on the [five Rs of rationalizing your digital estate](/../../digital-estate/5-rs-of-rationalization.md). (Loosely translated: The most common paths to cloud adoption.) More specifically, those plans are tailored to the most common scenarios: rehost, rearchitect, or rebuild.

## Initial containers considerations

Packaging your workloads in containers is the first body of work that needs to be scheduled and worked on. The second is planning the hosting of those containers.

### Containers without orchestration

Some workloads are highly self-contained, and don't necessarily benefit from the advanced controls and infrastructure requirements that that come with a large platform like Kubernetes. Just because your workload is containerized doesn't mean it must be deployed to Kubernetes. Azure provides a variety of solutions to run workloads within your portfolio that don't require the level of management and infrastructure that AKS requires. The following solutions would each follow this approach to planning:

- [App Service](/azure/app-service/)
- [Azure Functions](/azure/azure-functions/functions-overview)
- [Azure Container Instances](/azure/container-instances/container-instances-overview)
- [Batch](/azure/batch/batch-technical-overview)

Consider using a lighter weight solution for your containers for workloads that do not expect to grow in complexity and align with the purposes and limits of the above solutions.

### Containers with orchestration

For those workloads that cannot run in a fully managed PaaS platform and must relay on infrastructure-level controls, desire to use advanced deployment features such as those offered by container orchestrators, or expect to grow in modular complexity, turn to Azure Kubernetes Service (AKS). AKS solves for both container hosting, but also provides extensive architectural, SRE, security, deployment, monitoring, and infrastructure options.

The platform's feature set comes with a requirement to learn the platform both at the cluster operator level and at the workload level. Factor the education of your operations teams, architecture teams, and workload engineering teams into migration timelines. Also, because AKS is a platform, ensure workloads teams understand the separation of responsibilities within this platform vs their current hosting arrangement. It might be similar in some ways, but likely will be novel in others.

For very specialized workloads or specific organizational requirements, Azure offers two other major platforms in the container orchestration space.

- Azure Red Hat OpenShift
- Azure Service Fabric

If there is reason to explore alternatives, ensure time is allocated to understand the benefits and tradeoffs of all platform options. Azure's default solution is AKS, and this documentation assumes AKS is the chosen technology.

## Digital estate

When planning for your digital estate, you will still want to [gather inventory data](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/inventory) & [rationalization your estate](https://docs.microsoft.com/azure/cloud-adoption-framework/digital-estate/rationalize). But in a container adoption plan, it is vital that all assets (VMs, Data, and Applications) are grouped by the workload they support. Once the grouping and basic rationalization is complete, you can then evaluate those workloads to determine select from Package/Rehost or Rearchitect options.

In digital estate evaluation, you'll also need to evaluate your plan for data based on container persistence. Containers can run in a persistent or non-persistent state. Persistent state containers will retain data in the event of a failure. Non-persistent containers will not maintain data. If you choose a non-persistent configuration (which is the preferred solution) you will need to account for hosting of the workloads data in a persistent environment, like Azure SQL Database. Ensure application teams have accounted for work to validate network latency concerns, SRE operations drills, and deployment pipeline restructuring.

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

- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
- [See container and compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree)
