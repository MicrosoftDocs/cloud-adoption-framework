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

- Decide to burst from AKS cluster using ACI and Virtal Nodes. Is rapid scalability a requirement (no-time-to-wait)?
- Is scalability infrastructure/VM’s required? Consider Cluster Autoscaling and HPA
- Has scalability with Multi-Zone and Node Pools been considered?

## Design recommendations

Follow these best practices for your design:

- Use VMSS.  VM scale sets are required for scenarios including autoscaling, multiple node pools, and Windows support.
- If you need fast burst autoscaling enable [Virtual Nodes](https://docs.microsoft.com/azure/aks/virtual-nodes-portal).
- Enable [Cluster Autoscaler for Node Pools](https://docs.microsoft.com/azure/aks/cluster-autoscaler) to meet application demands.
- Enable [Horizontal Pod Autoscaler (HPA)](https://docs.microsoft.com/azure/aks/concepts-scale#horizontal-pod-autoscaler) to mitigate the busy hours of your application.
