---
title: AKS enterprise-scale storage
description: AKS guidelines for enterprise-scale storage
author: gbowerman
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
ms.custom: think-tank, e2e-aks
---

# AKS enterprise-scale storage

Your organization or enterprise needs to design suitable, AKS platform-level capabilities to meet their specific requirements. Specifically, these application workloads have storage requirements that probably differ. There are multiple considerations when choosing the storage needs for these applications such as performance, persistence, accessibility, and cost. Kubernetes provides different storage concepts to suit those needs and specifically in AKS you have to choose the right service for each application.

## Design considerations

Consider the following factors:

- Whether your application requires stateful workloads.
- Whether our application needs to manage secrets.
- Whether your application requires a guaranteed storage throughput and how this characteristic relates to storage tiers (standard, premium, ultra), storage services (Azure disk, Azure Files, Azure NetApp Files, or third-party services) and the worker sizes.
- Multiple write-read applications running in the cluster.
- Multitenancy and node pool isolation.
- Creation of the storage classes that meet your organization requirements.

## Design recommendations

The following are proven practices for your design:

- If stateful workloads are considered, prepare the dynamic storage Azure disks or Azure Files.
- If multipod needs to write/read in same storage, support Azure Files or third-party services like Azure NetApp Files.
- In most cases, premium SSD storage is recommended.
- Use node pools for different workloads requiring different storage and performance characteristics.
- Create storage classes.
