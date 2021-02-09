---
title: "Migrate workloads for modern containers"
description: Reduce cloud platform dependency and potentially reduce infrastructure footprint by migrating multiple web applications to a container solution
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# Migrate workloads to modern containers

Most modern container options require a rearchitecture or redeployment of the application. But the orchestration capabilities of Azure Kubernetes Service (AKS) allows for AKS solutions to be integrated into standard migration processes.

There is a clear and growing trend of migrating existing workloads from on-premise datacenters to a Kubernetes cluster in Azure. This approach has the potential of reducing the post-migration infrastructure footprint. More importantly, migrating to containers allows for greater portability in the portfolio, allowing workloads to be more easily moved between public and private cloud. This trend is most commonly experience when organizations have a large collection of web applications.

## One Migrate approach

As a part of the [Cloud Adoption Framework's One Migrate scenario](../index.md), containers can be migrated to Azure Kubernetes Service (AKS) to accelerate containers in the cloud. Typically migration to Azure uses Azure Migrate and the ecosystem of partner tools to assess workloads, migrate workloads, and release workloads to the cloud. This 3 step process can be applied to AKS migration, but you may need a few additional tools to help with the migration steps.

### Assess workloads

You'll need an inventory of workloads and their current containerization status. Workloads cannot be migrated until they have been validated as functional and performant while operating within a container. Work with application owners to allocate time to perform containerization, validate results, and build image building pipelines for the work. Take note of unique dependencies such as Windows-specific requirements (e.g. gMSA), local file system usage, cache implementation details, singleton implementations, and dependencies such as databases.

While a centralized team can lead the containerization efforts across an org, consider that more of a project management function and technical requirements gathering and oversight process, application owners will need to be highly involved in this process.

### Migrate containers and workloads

Migration to AKS involves new deployment pipelines and SRE access plans. Before any migration happens, ensure all teams involved understand their role, workload health assignments, and access patterns for deployments and SRE activities. Also insure migration has been validated end-to-end in pre-production and environments, including performing production-level load testing and SRE drills.

As with any migration, decide what maintenance window is agreeable and be clear to all interested stakeholders how the migration is proceeding. Track and dashboard the migration where appropriate. If a down-time migration cannot be negotiated, then allow for extra planning, cost, and complications around a no down-time migration. If it is found that a down-time migration is required when one was not expected, communicate that change to your stakeholders. Perform impact analysis on that change to ensure risks are documented and agreed upon.

All migrations (even downtime migrations), may need to modify the existing application with added flexibility to support the migration. Ensure app teams are fully involved in the planning of workload migrations as early as possible. For example additional DNS, connection string, and settings switching capabilities may need to be deployed in the current workload before the migration can be completed.

### Migrate from existing Kubernetes platforms

If you're coming from an existing kubernetes platform (AKS Engine, ACS, or another Kubernetes implementation), you might consider leveraging some open source tooling to help with the migration. In these cases you've already got a workload that functions in Kubernetes, and rehosting in AKS is usually much simpler. Validate all capabilities exist in AKS before performing any migration.

- [Velero](https://velero.io)
- [Azure Kube CLI extension](https://github.com/yaron2/azure-kube-cli)
- [ReShifter](https://github.com/mhausenblas/reshifter)
- Migrating from [AKS engine](https://docs.microsoft.com/azure-stack/user/azure-stack-kubernetes-aks-engine-overview) to AKS
- Migrating from [Azure Container Service (ACS)](https://azure.microsoft.com/updates/azure-container-service-will-retire-on-january-31-2020/) to AKS
- Moving existing resources to a different region

When migrating, ensure your target Kubernetes version is within the supported window for AKS. If using an older version, it may not be within the supported range and require upgrading versions to be supported by AKS. See [AKS supported Kubernetes versions](/azure/aks/supported-kubernetes-versions) for more information. Where possible, always try to migrate to the same version of Kubernetes. That means either do an inplace upgrade in the existing system or plan a post-migration upgrade -- based on your priorities.

## Next step: Innovate using modern container solutions

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Innovate using modern container solutions](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
