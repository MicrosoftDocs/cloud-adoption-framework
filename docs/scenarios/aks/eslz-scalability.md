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
    
- Consider to automate scalability  
    - You can enable Cluster Autoscaling to scale the number of nodes.
    - Horizontal Pod Autoscaler automatically scales the number of Pods.

- Consider scalability with Multi-Zone and Node Pools
    - When creating node pools consider to set availability zones.
    - Consider to use multiple node pools to support applications with different requirements. 
    - Scale node pools with cluster autoscaler.
    - You can scale to zero the user node pools. See the [limitations](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools#limitations). 


## Design recommendations

Follow these best practices for your design:

- Use VMSS (VM scale sets), they are required for scenarios including autoscaling, multiple node pools, and Windows support.
    - Don't manually enable or edit settings for scalability in the Azure portal or using the Azure CLI.

- If you need fast burst autoscaling Choose to burst from AKS cluster using ACI and [Virtual Nodes](https://docs.microsoft.com/azure/aks/virtual-nodes-portal).

- Enable [Cluster Autoscaler](https://docs.microsoft.com/azure/aks/cluster-autoscaler) to meet application demands.
    - You can enable autoscale for your [multiple node pools](https://docs.microsoft.com/en-us/azure/aks/cluster-autoscaler#use-the-cluster-autoscaler-with-multiple-node-pools-enabled). 

- Enable [Horizontal Pod Autoscaler (HPA)](https://docs.microsoft.com/azure/aks/concepts-scale#horizontal-pod-autoscaler) to mitigate the busy hours of your application.
    - All your containers and pods must have resource requests and limits defined. 
    - HPA automatically scales the number of PODs based on observed resource limits or custom metrics.

- Use multiple node pools when your applications have different resource requirements. 
    - Remember you can [specify a VM size for a node pool](https://docs.microsoft.com/en-us/azure/aks/use-multiple-node-pools#specify-a-vm-size-for-a-node-pool).
