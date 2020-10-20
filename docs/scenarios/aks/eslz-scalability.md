---
title: "AKS Enterprise-scale scalability"
description: AKS Guidelines for Enterprise-scale scalability
author: xstabel
ms.author: ctalaver
ms.date: 09/11/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# AKS Enterprise-scale Scalability

## Design considerations

Here are some crucial factors to consider:

- Is rapid scalability a requirement (no-time-to-wait)? Consider using [Azure Container Instances (ACI)](https://docs.microsoft.com/azure/container-instances/) as [virtual nodes](https://docs.microsoft.com/azure/aks/virtual-nodes-portal).
- Is auto scalability for worker/infrastructure nodes required? Consider [Cluster Autoscaling](https://docs.microsoft.com/azure/aks/cluster-autoscaler) and [scale-to-zero](https://docs.microsoft.com/azure/aks/scale-cluster#scale-user-node-pools-to-0)
- Is the underlaying infrastructure (Network plugin, IP ranges, subscription limits, quotas, etc) capable to scale out?
- Is the workload capable to scale out? Consider the use of the Kubernetes Horizontal Pod Autoscaler (HPA)
- Is the workload non-time sensitive and can handle interruptions? Consider the use of [Spot VMs](https://docs.microsoft.com/azure/aks/spot-node-pool)
- Was zone redundancy considered? Use [Availability Zones with AKS](https://docs.microsoft.com/azure/aks/availability-zones)

## Design recommendations

Follow these best practices for your design:

- Use VMSS (default) for new clusters to support scenarios including autoscaling, multiple node pools, and windows node pool support.
- Use [Virtual Nodes](https://docs.microsoft.com/azure/aks/virtual-nodes-portal) for rapid and infinite scalability and per-second billing.
- Use [Cluster Autoscaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler) and [scale-to-zero](https://docs.microsoft.com/azure/aks/scale-cluster#scale-user-node-pools-to-0) for predictable scalability using VM-based worker nodes.
- Enable [Horizontal Pod Autoscaler (HPA)](https://docs.microsoft.com/azure/aks/concepts-scale#horizontal-pod-autoscaler) to scale the workload based on cpu/memory or custom metrics.
- Enable [Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview) and Live Monitoring to monitor the cluster and workload utilization.
- Consider [Spot VM based node pools](https://docs.microsoft.com/azure/aks/spot-node-pool) for non-timesensitive workloads that can handle interruptions and evictions.
