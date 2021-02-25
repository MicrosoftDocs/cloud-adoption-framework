---
title: AKS Enterprise-scale storage
description: AKS guidelines for Enterprise-scale storage
author: gbowerman
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# AKS enterprise-scale storage

Your organization or enterprise needs to design suitable, AKS platform-level capabilities to meet their specific requirements. Specifically, these application workloads have storage requirements which probably will different among them. There are multiple considerations when choosing the storage needs for these applications such as performance, persistence, accessibility and cost. Kubernetes provides different storage concepts to suit those needs and specifically in AKS you have to choose the right service for each application.

## Design considerations

Consider the following factors:

- Your application requires stateful workloads.
- Your application needs to manage secrets.
- Your application requires a guaranteed storage throughput and how this characteristic relate to storage tiers (standard, premium, ultra), storage services (Azure disk, Azure Files, Azure NetApp Files, third-party) and the worker sizes.
- Multiple write-read applications running in the cluster.
- Multitenancy and node pool isolation.
- Creation of the storage classes which meet your organization requirements.

## Design recommendations

The following are proven practices for your design:

- If stateful workloads are considered, prepare the dynamic storage Azure disks or Azure Files.
- If multipod needs to write-read in same storage, support Azure Files or third-party as Azure NetApp Files.
- In most cases, premium SSD storage is recommended.
- Use node pools for different workloads requiring different storage and performance characteristics.
- Create storage classes.
