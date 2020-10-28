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
AKS could be scaled out depending upon infrastructure needs (you need more nodes) or application needs, in this case you have a number of factors like  number and rate of concurrent connections, number of requests, back-end latencies on AKS Applications. 
So, scaling out options are available for infrastructure using Cluster Autoscaler or HPA (Horizontal Pod Autoscaler) for your applications.

## Design considerations

Here are some crucial factors to consider:

- Is rapid scalability a requirement for your application (no-time-to-wait)? 
    - To have a quick provisioning of pods use virtual nodes, they are only supported with Linux nodes/pods. 

- Is the workload non-time sensitive and can handle interruptions? Consider the use of [Spot VMs](https://docs.microsoft.com/azure/aks/spot-node-pool)

- Is the underlaying infrastructure (Network plugin, IP ranges, subscription limits, quotas, etc) capable to scale out?

- Consider to automate scalability  
    - You can enable Cluster Autoscaling to scale the number of nodes. Consider [Cluster Autoscaling](https://docs.microsoft.com/azure/aks/cluster-autoscaler) and [scale-to-zero](https://docs.microsoft.com/azure/aks/scale-cluster#scale-user-node-pools-to-0)
    - Horizontal Pod Autoscaler automatically scales the number of Pods.

- Consider scalability with Multi-Zone and Node Pools
    - When creating node pools consider to set [Availability Zones with AKS](https://docs.microsoft.com/azure/aks/availability-zones).
    - Consider to use multiple node pools to support applications with different requirements. 
    - Scale node pools with cluster autoscaler.
    - You can scale to zero the user node pools. See the [limitations](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#limitations). 

## Design recommendations

Follow these best practices for your design:

- Use VMSS (VM scale sets), they are required for scenarios including autoscaling, multiple node pools, and Windows  node pool support.
    - Don't manually enable or edit settings for scalability in the Azure portal or using the Azure CLI.

- If you need fast burst autoscaling Choose to burst from AKS cluster using ACI and [Virtual Nodes](https://docs.microsoft.com/azure/aks/virtual-nodes-portal) for rapid and infinite scalability and per-second billing.

- Use [Cluster Autoscaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler) and [scale-to-zero](https://docs.microsoft.com/azure/aks/scale-cluster#scale-user-node-pools-to-0) for predictable scalability using VM-based worker nodes.

- Enable [Cluster Autoscaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler) to meet application demands.
    - You can enable autoscale for your [multiple node pools](https://docs.microsoft.com/azure/aks/cluster-autoscaler#use-the-cluster-autoscaler-with-multiple-node-pools-enabled). 

- Enable [Horizontal Pod Autoscaler (HPA)](https://docs.microsoft.com/azure/aks/concepts-scale#horizontal-pod-autoscaler) to mitigate the busy hours of your application.
    - All your containers and pods must have resource requests and limits defined. 
    - HPA automatically scales the number of PODs based on observed resource limits cpu/memory or custom metrics.

- Enable [Azure Monitor for containers](https://docs.microsoft.com/azure/azure-monitor/insights/container-insights-overview) and Live Monitoring to monitor the cluster and workload utilization.

- Use multiple node pools when your applications have different resource requirements. 
    - Remember you can [specify a VM size for a node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#specify-a-vm-size-for-a-node-pool).

- Consider [Spot VM based node pools](https://docs.microsoft.com/azure/aks/spot-node-pool) for non-timesensitive workloads that can handle interruptions and evictions.
