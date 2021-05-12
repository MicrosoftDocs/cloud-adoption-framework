---
title: Plan for modern containers
description: Describe the scenario's impact on planning
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: think-tank, e2e-aks
---

# Plan for modern containers

[Cloud Adoption Framework's Plan methodology](../../plan/index.md) helps create an overall cloud adoption plan to guide the programs and teams involved in your cloud-based digital transformation. This guidance provides templates for creating your backlog and plans for building necessary skills across your teams, all based on what you are trying to do in the cloud.

The standard Plan methodology focuses on the [five rs of rationalizing your digital estate](../../digital-estate/5-rs-of-rationalization.md). (Loosely translated: the most common paths to cloud adoption.) More specifically, those plans are tailored to the most common scenarios: rehost, rearchitect, or rebuild.

## Initial containers considerations

Packaging your workloads in containers is the first body of work that needs to be scheduled and worked on. The second is planning the hosting of those containers.

### Containers without orchestration

Some workloads are highly self-contained, and don't necessarily benefit from the advanced controls and infrastructure requirements that come with a large platform like Kubernetes. Just because your workload is containerized doesn't mean it must be deployed to Kubernetes. Azure provides a variety of solutions to run workloads within your portfolio that don't require the level of management and infrastructure that AKS requires. The following solutions would each follow this approach to planning:

- [App Service](/azure/app-service/)
- [Azure Functions](/azure/azure-functions/functions-overview)
- [Azure Container Instances](/azure/container-instances/container-instances-overview)
- [Batch](/azure/batch/batch-technical-overview)

Consider using a lighter weight solution for your containers for workloads that do not expect to grow in complexity and align with the purposes and limits of the above solutions.

### Containers with orchestration

For those workloads that cannot run in a fully managed PaaS platform and must relay on infrastructure-level controls, desire to use advanced deployment features such as those offered by container orchestrators, or expect to grow in modular complexity, turn to Azure Kubernetes Service (AKS). AKS solves for both container hosting, but also provides extensive architectural, SRE, security, deployment, monitoring, and infrastructure options.

The platform's feature set comes with a requirement to learn the platform both at the cluster operator level and at the workload level. Factor the education of your operations teams, architecture teams, and workload engineering teams into migration timelines. Also, because AKS is a platform, ensure workloads teams understand the separation of responsibilities within this platform versus their current hosting arrangement. It might be similar in some ways, but likely will be novel in others.

For very specialized workloads or specific organizational requirements, Azure offers two other major platforms in the container orchestration space.

- Azure Red Hat OpenShift
- Azure Service Fabric

If there is reason to explore alternatives, ensure time is allocated to understand the benefits and tradeoffs of all platform options. Azure's default solution is AKS, and this documentation assumes AKS is the chosen technology.

## Digital estate

When planning for your digital estate, you'll want to [gather inventory data](../../digital-estate/inventory.md) and [rationalization your estate](../../digital-estate/rationalize.md). In a container adoption plan, it's vital all assets, for example VMs, data, and applications, are grouped by the workload they support. Once the grouping and basic rationalization is complete, you can evaluate these workloads to determine the package/rehost or rearchitect options.

In digital estate evaluation, you'll also need to evaluate your plan for data based on container persistence. Containers can run in a persistent or non-persistent state. Persistent state containers will retain data if there is a failure. Non-persistent containers won't maintain data. If you choose a non-persistent configuration, which is common for mature DevOps teams, you'll need to account for hosting the workloads data in a persistent environment, like Azure SQL Database.

These considerations will create clarity about the actions needed to complete adoption of containerized workloads in the cloud.

## Modern container adoption plan

The standard [cloud adoption plan template](../../plan/template.md) accounts for the types of work required in a typical cloud adoption effort. But you will need to add tasks to your plan for packaging the workload into containers and orchestration of the container provisioning.

## Modern container readiness plan

In addition to the cloud adoption skilling plan, the cloud adoption teams might need to develop skills related to container and Kubernetes before executing your plan:

- [Learn the basics of Kubernetes](/azure/aks/concepts-clusters-workloads)
- [Learn about containers](https://azure.microsoft.com/product-categories/containers/)
- [Get familiar with Kubernetes best practices](/azure/aks/best-practices)

Ensure time is allocated for workload teams to document and dry-run migration plans. The existing application or external system (both dependencies and systems that depend on this workload) may need to be modified with added flexibility to support the migration effort. This is true for both pre-production and production environments.

## Next step: Review your environment or Azure landing zone

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Review your environment or Azure landing zone(s)](./ready.md)
- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](/azure/architecture/reference-architectures/containers/aks-start-here?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
- [See container and compute decision tree](/azure/architecture/guide/technology-choices/compute-decision-tree)
