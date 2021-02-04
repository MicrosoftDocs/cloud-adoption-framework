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

## Assess containers and workloads

Currently, AKS migration can support the following scenarios:

- Migrating an AKS Cluster backed by [Availability Sets](https://docs.microsoft.com/azure/virtual-machines/windows/tutorial-availability-sets.md) to [Virtual Machine Scale Sets](https://docs.microsoft.com/azure/virtual-machine-scale-sets/overview.md)
- Migrating an AKS cluster to use a [Standard SKU load balancer](https://docs.microsoft.com/azure/aks/load-balancer-standard.md)
- Migrating from [Azure Container Service (ACS) - retiring January 31, 2020](https://azure.microsoft.com/updates/azure-container-service-will-retire-on-january-31-2020/) to AKS
- Migrating from [AKS engine](https://docs.microsoft.com/azure-stack/user/azure-stack-kubernetes-aks-engine-overview) to AKS
- Migrating from non-Azure based Kubernetes clusters to AKS
- Moving existing resources to a different region

When migrating, ensure your target Kubernetes version is within the supported window for AKS. If using an older version, it may not be within the supported range and require upgrading versions to be supported by AKS. See [AKS supported Kubernetes versions](https://docs.microsoft.com/azure/aks/supported-kubernetes-versions.md) for more information.

If you're migrating to a newer version of Kubernetes, review [Kubernetes version and version skew support policy](https://kubernetes.io/docs/setup/release/version-skew-policy/#supported-versions).

## Migrate containers and workloads

Currently, you will need to use one of several open-source tools to complete the replication of your container and workloads to Azure:

- [Velero](https://velero.io/) (Requires Kubernetes 1.7+)
- [Azure Kube CLI extension](https://github.com/yaron2/azure-kube-cli)
- [ReShifter](https://github.com/mhausenblas/reshifter)

See the following best practice to [migrate a container to AKS](https://docs.microsoft.com/azure/aks/aks-migration#aks-with-standard-load-balancer-and-virtual-machine-scale-sets).

## Next step: Innovate using modern container solutions

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Innovate using modern container solutions](https://docs.microsoft.com/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2fcloud-adoption-framework%2f_bread%2ftoc.json&toc=%2fazure%2fcloud-adoption-framework%2ftoc.json)
- [Govern modern container solutions](./govern.md)
- [Manage modern container solutions](./manage.md)
