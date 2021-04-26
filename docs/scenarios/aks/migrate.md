---
title: Migrate workloads for modern app platforms
description: Reduce cloud platform dependency and potentially reduce infrastructure footprint by migrating multiple web applications to a container solution
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, e2e-aks
---

# Migrate workloads to modern app platforms

Most modern app platform options require a rearchitecture or redeployment of the application. But the orchestration capabilities of Azure Kubernetes Service (AKS) allows for AKS solutions to be integrated into standard migration processes.

There's a clear and growing trend of migrating existing workloads from on-premises datacenters to a Kubernetes cluster in Azure. This approach has the potential of reducing the post-migration infrastructure footprint. More importantly, migrating to containers allows for greater portability in the portfolio, allowing workloads to be more easily moved between public and private cloud. This trend is most commonly experienced when organizations have a large collection of web applications.

## One Migrate approach

You can migrate to Azure Kubernetes Service (AKS) to accelerate containers in the cloud, as a part of the [Cloud Adoption Framework's One Migrate scenario](../index.md). Typically, migration to Azure uses Azure Migrate and partner tools to assess workloads, migrate workloads, and release workloads to the cloud. You can apply this three-step process to AKS migration, however, you might need a few other tools to help with the migration steps.

### Assess workloads

You'll need an inventory of workloads and their current containerization status. Workloads cannot be migrated until they have been validated as functional and performant while operating within a container. Work with application owners to allocate time to perform containerization, validate results, and build image building pipelines for the work. Take note of unique dependencies such as Windows-specific requirements (e.g. Gmsa), local file system usage, cache implementation details, singleton implementations, and dependencies such as databases.

While a centralized team can lead the containerization efforts across an org, consider that more of a project management function and technical requirements gathering and oversight process, application owners will need to be highly involved in this process.

### Migrate containers and workloads

When migrating, ensure your target Kubernetes version is within the supported window for AKS. If using an older version, it might not be within the supported range and require upgrading versions to be supported by AKS. For more information, see [AKS supported Kubernetes versions](/azure/aks/supported-kubernetes-versions).

As with any migration, decide what maintenance window is agreeable and be clear to all interested stakeholders how the migration is proceeding. Track and dashboard the migration where appropriate. If a down-time migration cannot be negotiated, then allow for extra planning, cost, and complications around a no down-time migration. If it is found that a down-time migration is required when one was not expected, communicate that change to your stakeholders. Perform impact analysis on that change to ensure risks are documented and agreed upon.

All migrations (even downtime migrations), may need to modify the existing application with added flexibility to support the migration. Ensure application teams are fully involved in the planning of workload migrations as early as possible. For example additional DNS, connection string, and settings switching capabilities may need to be deployed in the current workload before the migration can be completed.

Currently, you'll need to use one of several open-source tools to complete the replication of your container and workloads to Azure:

If you're coming from an existing Kubernetes platform (AKS Engine, ACS, or another Kubernetes implementation), you might consider using some open-source tooling to help with the migration. In these cases you've already got a workload that functions in Kubernetes, and rehosting in AKS is usually much simpler. Validate all capabilities exist in AKS before performing any migration.

- [Velero](https://velero.io)
- [Azure kube CLI extension](https://github.com/yaron2/azure-kube-cli)
- [Reshifter](https://github.com/mhausenblas/reshifter)
- Migrating from [AKS Engine](/azure-stack/user/azure-stack-kubernetes-aks-engine-overview) to AKS
- Migrating from [Azure container service (acs)](https://azure.microsoft.com/updates/azure-container-service-will-retire-on-january-31-2020/) to AKS
- Moving existing resources to a different region

When migrating, ensure your target Kubernetes version is within the supported window for AKS. If using an older version, it may not be within the supported range and require upgrading versions to be supported by AKS. For more information, see [AKS supported Kubernetes versions](/azure/aks/supported-kubernetes-versions). Where possible, always try to migrate to the same version of Kubernetes. That means either do an in-place upgrade in the existing system or plan a post-migration upgrade -- based on your priorities.

## Next step: Innovate using modern app platform solutions

The following articles will take you to guidance at specific points in the cloud adoption journey and help you be successful in the cloud adoption scenario.

- [Innovate using modern app platform solutions](/azure/architecture/reference-architectures/containers/aks-start-here?toc=/azure/cloud-adoption-framework/toc.json&bc=/azure/cloud-adoption-framework/_bread/toc.json)
- [Govern modern app platform solutions](./govern.md)
- [Manage modern app platform solutions](./manage.md)
