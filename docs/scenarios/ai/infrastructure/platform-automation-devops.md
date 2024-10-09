---
title: Platform automation and DevOps for AI workloads on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Platform automation and DevOps for AI workloads on Azure infrastructure

Implementing platform automation and DevOps practices is essential for efficient AI infrastructure management. Follow these guidelines to streamline deployment, monitoring, and resource management on Azure.

## Platform automation

- *Adopt “everything as code” principles.* Apply Infrastructure as Code (IaC) methods to your AI infrastructure. Automate deployment, configuration, monitoring, and teardown of resources to improve efficiency, consistency, and scalability.

## Configure virtual machines

Configure virtual machines (VMs) in your AI cluster for optimal workload execution:

- *Use pre-configured VM images.* Leverage Azure Marketplace images pre-configured for AI workloads to simplify setup and reduce configuration time.
  
- *Run AI workloads in containers.* Utilize container technologies like Singularity for running compute workloads. Refer to the [CycleCloud-Singularity repository](https://github.com/Azure/cyclecloud-singularity) as a starting point.
  
- *Execute post-deployment scripts.* Apply additional configurations using scripts executed after VM deployment. This ensures that all required tools and libraries are in place for AI workload execution.

## Repositories

Use the following repositories to deploy and manage high-performance computing (HPC) infrastructure for AI on Azure:

- *Azure CycleCloud.* Deploy Azure CycleCloud using a marketplace image for interactive UI-based deployment. To automate deployment of an auto-scaling SLURM cluster, use the [AzureHPC repository](https://github.com/Azure/azurehpc).
  
- *Azure HPC On-Demand Platform (Az-Hop).* Deploy a customizable, end-to-end base HPC infrastructure using [Az-Hop](https://github.com/Azure/az-hop).
  
- *Azure Batch.* Utilize the [Azure Batch Accelerator](https://github.com/Azure/bacc) repository to deploy Azure Batch according to best practices.
