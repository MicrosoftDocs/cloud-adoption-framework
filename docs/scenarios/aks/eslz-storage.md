---
title: "AKS Enterprise-scale storage"
description: AKS Guidelines for Enterprise-scale storage
author: gbowerman
ms.author: brblanch
ms.date: 08/31/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: migrate
---

# AKS Enterprise-scale Storage

Your organization or enterprise needs to design suitable, AKS platform-level capabilities to meet their specific requirements. Specifically, these application workloads have storage requirements which probably will different among them. There are multiple considerations when choosing the storage needs for these applications such as performance, persistance, accessibility and cost. Kubernetes provides different storage concepts to suit those needs and specifically in AKS you have to choose the right service for each application. 


## Design considerations

Consider the following factors:

- Your application requires stateful workloads.

- Your application needs to manage secrets.
  
- Your application requires a guaranteed storage throughput and how this characteristic relate to storage tiers (standerd, premium, ultra), storage services (Azure Disk, Azure Files, Azure Netapp Files, third party)  and the worker sizes.

- Multiple write-read applications running in the cluster.

- Multi-tenancy and Node Pool isolation.

- Creation of the storage classes which meet your organization requirements.

## Design recommendations

The following are proven practices for your design:

- Azure Keyvault CSI integration is recommended

- If Stateful workloads are considered, prepare the dynamic storage Azure Disks or Azure Files

- If multi-pod need to write-read in same storage. Support Azure Files or third party as ANF - Azure NetApp Files 

- In most cases, it is recommended to use Premium storage - SSD-based Storage

- Node pools

- Create Storage classes
