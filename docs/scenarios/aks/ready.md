---
title: Azure landing zone review for modern containers
description: Describe the scenario's impact on Azure landing zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

# Azure landing zone review for modern containers

The [Ready methodology in the Cloud Adoption Framework](../../ready/index.md) guides the creation of all Azure environments using [Azure landing zones](../../ready/landing-zone/index.md). Azure landing zones provide many [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options. You'll need to evaluate any landing zone that is to be used for modern container solutions no matter what implementation option you choose.

## Environmental considerations for orchestrated containers

If you haven't already selected an Azure landing zone implementation approach, review the [Azure landing zones](../../ready/landing-zone/index.md) article series. Then review how that landing zone option can best be aligned to a modern container scenario.

**Start-small options:** Container orchestration via Azure Kubernetes Service (AKS) requires some environmental configuration. The [baseline architecture for an Azure Kubernetes Service (AKS) cluster for Azure landing zones](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json) provides considerations about networking, compute, identity, security, BCDR, and operations.

**Enterprise-scale options:** The enterprise-scale construction set for AKS includes a reference implementation to deploy an enterprise-scale landing zone to support your AKS platform. Included in the construction set documentation is a series of best practices that can be used to evaluate production readiness of any AKS environment. These considerations apply even if you select a start-small landing zone implementation. See the following articles to evaluate your AKS environment:

- [Identity and access management](identity-and-access-management.md)
- [Network topology and connectivity](network-topology-and-connectivity.md)
- [Management and monitoring](management-and-monitoring.md)
- [Business continuity and disaster recovery](business-continuity-and-disaster-recovery.md)
- [Security governance and compliance](security-governance-and-compliance.md)
- [Platform automation and DevOps](platform-automation-and-devops.md)

The primary deference between the two options above resides in how separation of duties is expressed and implemented in terms of Azure resources, subscription topology, and usage of Azure Policy for governance. Understand your organization's plan around centralized versus decentralized operations and which work best for your organization's workloads. Both models can be flexed to provide the exact experience your organization and workloads require, but you'll want to start with the one most closely aligned with your defined strategy. Ensure all workload teams understand the operating model and duties required of all IT groups and members.

## Environmental considerations for non-orchestrated container solutions

The following container services run as platform as a service solutions, which require less environmental configuration. But the reduced configuration requirements result in reduced control over container orchestration and solutions specific configurations to integrate the workload into other assets, like VMs or other containers. These non-orchestrated solutions tend to lend themselves to a workload-biased operations strategy.

Review the concepts and how-to guides in each of the product documentation links below to evaluate different types of environmental configurations for non-orchestrated container types:

- [App Service](/azure/app-service/)
- [Azure Functions](/azure/azure-functions/functions-overview)
- [Container instances](/azure/container-instances/container-instances-overview)
- [Batch](/azure/batch/batch-technical-overview)

## Next step: Migrate workload to modern containers

The following list of articles will take you to guidance found at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](/azure/architecture/reference-architectures/containers/aks-start-here?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
