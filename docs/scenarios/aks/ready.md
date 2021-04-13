---
title: Azure landing zones for container operations
description: Describe the scenario's impact on Azure landing zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

# Azure landing zones for container operations

The [Ready methodology in the Cloud Adoption Framework](../../ready/index.md) guides the creation of all Azure environments using [Azure landing zones](../../ready/landing-zone/index.md). Azure landing zones provide many [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

With Azure landing zones, you can start with a small implementation and expand over time. For more sophisticated environments, you can start with enterprise-scale implementation options. You'll need to evaluate any landing zone that is to be used for modern container solutions no matter what implementation option you choose.

## Environmental considerations for orchestrated containers

If you haven't already selected an Azure landing zone implementation approach, review the [Azure landing zones](../../ready/landing-zone/index.md) article series. Then review how that landing zone option can best be aligned to a modern container scenario.

**Start-small and expand with the AKS baseline:** Container orchestration via Azure Kubernetes Service (AKS) requires some environmental configuration. The [baseline architecture for an Azure Kubernetes Service (AKS) cluster](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks?bc=/azure/cloud-adoption-framework/_bread/toc.json&toc=/azure/cloud-adoption-framework/scenarios/aks/toc.json) provides a proven approach to deploying your first AKS environment.

**Enterprise-scale landing zones:** The enterprise-scale for AKS includes a reference implementation to deploy an enterprise-scale landing zone to support your AKS platform. 


The primary deference between the two options above resides in how separation of duties is expressed and implemented in terms of Azure resources, subscription topology, and usage of Azure Policy for governance. Understand your organization's plan around centralized versus decentralized operations and which work best for your organization's workloads. Both models can be flexed to provide the exact experience your organization and workloads require, but you'll want to start with the one most closely aligned with your defined strategy. Ensure all workload teams understand the operating model and duties required of all IT groups and members.

## Azure Landing Zone design areas

Regardless of your initial implementation option, all Azure Landing Zones for AKS should adhere to a set of common design considerations and recommendations outlined in the following articles series. These checklists of considerations and recommendations can help the container operations team evaluate any landing zone to ensure it is ready to host AKS containers:

- [Identity and access management](eslz-identity-and-access-management.md)
- [Network topology and connectivity](eslz-network-topology-and-connectivity.md)
- [Resource Organization](eslz-resource-organization.md)
- [Governance disciplines](eslz-security-governance-and-compliance.md)
- [Operations baseline](eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](eslz-business-continuity-and-disaster-recovery.md)
- [Deployment options](eslz-platform-automation-and-devops.md)

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
