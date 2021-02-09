---
title: "Azure Landing Zone review for modern containers"
description: Describe the scenario's impact on Azure Landing Zone design
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Azure Landing Zone review for modern containers

The [Ready methodology in the Cloud Adoption Framework](../../ready/index.md) guides the creation of all Azure environments using [Azure Landing Zones](../../ready/landing-zone/index.md). Azure Landing Zones provide a number of [implementation options](../../ready/landing-zone/implementation-options.md) built around a set of [common design areas](../../ready/landing-zone/design-areas.md).

With Azure Landing Zones, you could start with a small implementation and expand over time. Alternatively, for more sophisticated environments, you could start with enterprise-scale implementation options. In either scenario, you will need to evaluate any landing zone that is to be used for modern container solutions.

## Environmental considerations for orchestrated containers

If you haven't already chosen an Azure Landing Zone implementation approach, review the [Azure Landing Zones](../../ready/landing-zone/index.md) article series. Then review how that landing zone option can best be aligned to a modern container scenario.

**Start-small options:** Container orchestration via Azure Kubernetes Service (AKS) does require critical environmental configuration, as AKS is not a "self-contained" service, and relies heavily on bring-your-own virtual networks, ingress resources, and other Azure services. The [baseline architecture and reference implementation for an Azure Kubernetes Service (AKS) cluster for Azure Landing Zones](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json) lists considerations regarding networking, compute, identity, security, BCDR, and operations. This is a foundational architecture that build out a single cluster, in a single region, adhering to best practices and provides networking observability both into and out of the cluster.

**Enterprise-scale options:** The enterprise-scale construction set for AKS includes a reference implementation to deploy an enterprise-scale landing zone to support your AKS platform. It's based on the baseline architecture but is tailored specifically to deploy into your enterprise-scale landing zone for AKS. Included in the construction set documentation is a series of implementation considerations and recommendations. If you use the start small options, you'll find the perspectives shared in this series valuable as you compare your current state to the enterprise-scale variation if you decide to move to the enterprise-scale landing zone approach.

- [Identity and Access Management](scenarios/aks/eslz-identity-and-access-management.md)
- [Network topology and connectivity](scenarios/aks/eslz-network-topology-and-connectivity.md)
- [Management and Monitoring](scenarios/aks/eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](scenarios/aks/eslz-business-continuity-and-disaster-recovery.md)
- [Security governance and compliance](scenarios/aks/eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](scenarios/aks/eslz-platform-automation-and-devops.md)

The primary deference between the two options above resides in how separation of duties is expressed and implemented in terms of Azure resources, subscription topology, and usage of Azure Policy for governance. Understand your organization's plan around centralized vs decentralized operations and which work best for your organization's workloads. Both models can be flexed to provide the exact experience your organization and workloads require. Ensure all workload teams understand the operating model and duties required of all IT groups and members.

## Environmental considerations for non-orchestrated container solutions

The following container services run as Platform as a service solutions, which require less environmental configuration. But the reduced configuration requirements result in reduced control over container orchestration and solutions specific configurations to integrate the workload into other assets, like VMs or other containers. These non-orchestrated solutions tend to lend themselves to a workload-biased operations strategy.

Review the concepts and how-to guides in each of the product documentation links below to evaluate different types of environmental configurations for non-orchestrated container type:

- [App Service](/azure/app-service/)
- [Azure Functions](/azure/azure-functions/functions-overview)
- [Container Instances](/azure/container-instances/container-instances-overview)
- [Batch](/azure/batch/batch-technical-overview)

## Next step: Migrate workload to modern containers

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Migrate workloads to modern containers](./migrate.md)
- [Innovate using modern container solutions](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
