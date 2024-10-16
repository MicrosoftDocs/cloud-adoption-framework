---
title: Implementation options for AI on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Implementation options for AI on Azure infrastructure

After deploying an [Azure landing zone](../ready.md#deploy-a-foundation-with-azure-landing-zone), you can set up the application landing zone using the [Cycle Cloud Workspace for SLURM](/azure/cyclecloud/qs-deploy-ccws).

:::image type="content" source="../images/ai-infra-alz.svg" alt-text="Diagram showing AI application on Azure infrastructure in Azure landing zone." lightbox="../images/ai-infra-alz.svg" border="false":::
*Figure 1. AI application on Azure infrastructure in Azure landing zone.*

Azure CycleCloud Workspace for Slurm offers several benefits for users who want to run AI workloads with Slurm scheduler.

- *Easy and fast cluster creation.* Users can quickly create Slurm clusters on Azure through a simple GUI. They can choose from various Azure virtual machine (VM) sizes and types, and customize cluster settings such as node count, network configuration, storage options (like Azure NetApp Files and Azure Managed Lustre Filesystem), and Slurm parameters.

- *Flexible and dynamic cluster management.* Azure CycleCloud scales Slurm clusters up or down automatically. Users can monitor cluster status, performance, and utilization, and view logs and metrics through the GUI. They can delete clusters when not needed and only pay for the resources they use.

- *Full control of the infrastructure.* Users have full control over the deployed infrastructure, allowing them to bring their own code, libraries, and packages, and to use resources on demand.

## Next step

> [!div class="nextstepaction"]
> [Govern AI](govern.md)