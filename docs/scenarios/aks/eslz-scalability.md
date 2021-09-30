---
title: Scalability considerations for AKS environments
description: Scalability considerations for AKS environments
author: xstabel
ms.author: brblanch
ms.date: 05/18/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-aks
---

<!-- docutune:casing "HPA" -->

# Scalability considerations for AKS environments

AKS can be scaled-in and out depending upon infrastructure needs (requiring more or less capacity), adding node pools with special capabilities like GPU, or application needs, in this case you have several factors like number and rate of concurrent connections, number of requests, back-end latencies on AKS applications.

The most common scalability options for AKS are the cluster autoscaler (automatically adding/removing nodes based on CPU and memory utilization) or the HPA (horizontal pod autoscaler) for your applications to scale in and out based on CPU and memory utilization as well as more advanced metrics.

## Design considerations

Here are some crucial factors to consider:

- Is rapid scalability a requirement for your application (no-time-to-wait)?
  - To have a quick provisioning of pods use virtual nodes, they are only supported with Linux nodes/pods.
- Is the workload non-time sensitive and can handle interruptions? Consider the use of [Spot VMs](/azure/aks/spot-node-pool)
- Is the underlying infrastructure (network plug-in, IP ranges, subscription limits, quotas, and so on) capable to scale out?
- Consider to automate scalability

  - You can enable cluster autoscaling to scale the number of nodes. Consider [cluster autoscaling](/azure/aks/cluster-autoscaler) and [scale-to-zero](/azure/aks/scale-cluster#scale-user-node-pools-to-0)
  - Horizontal pod autoscaler automatically scales the number of pods.
- Consider scalability with multizone and node pools
  - When creating node pools consider to set [Availability Zones with AKS](/azure/aks/availability-zones).
  - Consider to use multiple node pools to support applications with different requirements.
  - Scale node pools with cluster autoscaler.
  - You can scale to zero the user node pools. See the [limitations](/azure/aks/use-multiple-node-pools#limitations).

## Design recommendations

Follow these best practices for your design:

- Use virtual machine scale sets, which are required for scenarios including autoscaling, multiple node pools, and Windows node pool support.
  - Don't manually enable or edit settings for scalability in the Azure portal or using the Azure CLI.
- If you need fast burst autoscaling choose to burst from AKS cluster using Azure Container Instances and [virtual nodes](/azure/aks/virtual-nodes-portal) for rapid and infinite scalability and per-second billing.
- Use [cluster autoscaler](/azure/aks/cluster-autoscaler) and [scale-to-zero](/azure/aks/scale-cluster#scale-user-node-pools-to-0) for predictable scalability using VM-based worker nodes.
- Enable [cluster autoscaler](/azure/aks/cluster-autoscaler) to meet application demands.
  - You can enable autoscale for your [multiple node pools](/azure/aks/cluster-autoscaler#use-the-cluster-autoscaler-with-multiple-node-pools-enabled).
- Enable [horizontal pod autoscaler (HPA)](/azure/aks/concepts-scale#horizontal-pod-autoscaler) to mitigate the busy hours of your application.
  - All your containers and pods must have resource requests and limits defined.
  - HPA automatically scales the number of pods based on observed resource limits CPU/memory or custom metrics.
- Enable [Azure Monitor for containers](/azure/azure-monitor/containers/container-insights-overview) and live monitoring to monitor the cluster and workload utilization.
- Use multiple node pools when your applications have different resource requirements.
  - Remember you can [specify a VM size for a node pool](/azure/aks/use-multiple-node-pools#specify-a-vm-size-for-a-node-pool).
- Consider [Spot VM-based node pools](/azure/aks/spot-node-pool) for non-time-sensitive workloads that can handle interruptions and evictions.
