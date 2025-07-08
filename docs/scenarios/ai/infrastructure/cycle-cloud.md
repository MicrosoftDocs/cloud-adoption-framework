---
title: Implementation option for AI on Azure infrastructure
description: Discover how to build AI workloads on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 04/09/2025
ms.topic: conceptual
---

# Implementation option for AI on Azure infrastructure

This article provides implementation recommendations for organizations running AI workloads on Azure infrastructure (IaaS). After deploying an [Azure landing zone](../ready.md#use-an-azure-landing-zone), you can set up the application landing zone using the [CycleCloud Workspace for Slurm](/azure/cyclecloud/qs-deploy-ccws). Azure CycleCloud Workspace for Slurm offers several benefits for users who want to run AI workloads with the Slurm scheduler.

- *Easy and fast cluster creation.* Users can quickly create Slurm clusters on Azure through a simple GUI. They can choose from various Azure virtual machine (VM) sizes and types and customize cluster settings such as node count, network configuration, storage options (like Azure NetApp Files and Azure Managed Lustre Filesystem), and Slurm parameters.

- *Flexible and dynamic cluster management.* Azure CycleCloud scales Slurm clusters up or down automatically. Users can monitor cluster status, performance, and utilization, and view logs and metrics through the GUI. They can delete clusters when not needed and only pay for the resources they use.

- *Full control of the infrastructure.* Users have full control over the deployed infrastructure, allowing them to bring their own code, libraries, and packages, and to use resources on demand.

## Design guidelines

The following articles provide guidelines for AI workloads on Azure infrastructure (IaaS):

- [Compute](./compute.md)
- [Storage](./storage.md)
- [Networking](./networking.md)
- [Governance](./governance.md)
- [Management](./management.md)
- [Security](./security.md)

## Architecture

:::image type="content" source="../images/ai-infrastructure-landing-zone.svg" alt-text="Diagram showing AI application on Azure infrastructure in Azure landing zone." lightbox="../images/ai-infrastructure-landing-zone.svg" border="false":::
*Figure 1. AI application on Azure infrastructure in Azure landing zone.*

## Deploy CycleCloud Workspace for Slurm

The [CycleCloud Workspace for Slurm](/azure/cyclecloud/qs-deploy-ccws) can be used as the initial deployment in the enterprise environment. You can develop and customize the code to expand its functionality and/or adapt it to your Azure landing zone environment. Then, follow the guidance to [fine-tune a diffusion model from Hugging Face using Azure CycleCloud Workspace for Slurm](https://techcommunity.microsoft.com/t5/azure-compute-blog/fine-tuning-a-hugging-face-diffusion-model-on-cyclecloud/ba-p/4262431).

## Next step

> [!div class="nextstepaction"]
> [Compute IaaS AI](./compute.md)