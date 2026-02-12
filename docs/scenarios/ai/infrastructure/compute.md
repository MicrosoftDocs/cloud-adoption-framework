---
title: Compute recommendations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to select compute for AI workloads on Azure infrastructure (IaaS).
author: stephen-sumner
ms.author: rajanaki
ms.date: 04/09/2025
ms.topic: concept-article
---

# Compute recommendations for AI workloads on Azure infrastructure (IaaS)

This article provides compute recommendations for organizations running AI workloads on Azure infrastructure (IaaS). The preferred approach is to start your AI adoption with [Azure AI platform-as-a-service (PaaS) solutions](../platform/architectures.md). However, if you have access to Azure GPUs, follow this guidance to run AI workloads on Azure IaaS.

AI workloads require specialized virtual machines (VMs) to handle high computational demands and large-scale data processing. Choosing the right VMs optimizes resource use and accelerates AI model development and deployment. The following table provides an overview of recommended compute options.

| AI phase             | Virtual Machine Image  | Generative AI | Nongenerative AI (complex models)  | Nongenerative AI (small models)  |
|----------------------|------------------------|----------------------------|------------------------------------|----------------------------------|
| Training AI models   | [Data Science Virtual Machines](/azure/machine-learning/data-science-virtual-machine/overview/)     | GPU (prefer ND-family. Alternatively use NC family with ethernet-interconnected VMs) | GPU (prefer ND-family. Alternatively use NC family with ethernet-interconnected VMs) | [Memory-optimized](/azure/virtual-machines/sizes/memory-optimized/m-family) (CPU) |
| Inferencing AI models| [Data Science Virtual Machines](/azure/machine-learning/data-science-virtual-machine/overview/)     | GPU (NC or ND family)  | GPU (NC or ND family) | [Compute-optimized](/azure/virtual-machines/sizes/compute-optimized/f-family) (CPU) |

## Pick the right virtual machine image

Choose a suitable virtual machine image, such as the Data Science Virtual Machines, to access preconfigured tools for AI workloads quickly. This choice saves time and resources while providing the software necessary for efficient AI processing

- *Start with the Data Science Virtual Machines images.* The [Data Science Virtual Machine](/azure/machine-learning/data-science-virtual-machine/overview) image offers preconfigured access to data science tools. These tools include PyTorch, TensorFlow, scikit-learn, Jupyter, Visual Studio Code, Azure CLI, and PySpark. When used with GPUs, the image also includes Nvidia drivers, CUDA Toolkit, and cuDNN. These images serve as your baseline image. If you need more software, add it via a script at boot time or embed it into a custom image. They maintain compatibility with your orchestration solutions.

- *Find alternative images as needed.* If the Data Science Virtual Machine image doesn't meet your needs, use [Microsoft Marketplace](https://marketplace.microsoft.com/marketplace/apps) or other search [methods](/azure/virtual-machines/overview#distributions) to find alternate images. For example, with GPUs, you might need [Linux images](/azure/virtual-machines/configure) that include InfiniBand drivers, NVIDIA drivers, communication libraries, MPI libraries, and monitoring tools.

## Pick a virtual machine size

Selecting an appropriate virtual machine size aligns with your AI model complexity, data size, and cost constraints. Matching hardware to training or inferencing needs maximizes efficiency and prevents underutilization or overload.

- *Narrow your virtual machine options.* Choose the latest virtual machine SKUs for optimal training and inference times. For training, select SKUs that support RDMA and GPU interconnects for high-speed data transfer between GPUs. For inference, avoid SKUs with InfiniBand, which is unnecessary. Examples include the [ND H200 v5](/azure/virtual-machines/sizes/gpu-accelerated/nd-h200-v5-series), [ND MI300X v5 series](/azure/virtual-machines/sizes/gpu-accelerated/nd-mi300x-v5-series), [ND H100 v5 series](/azure/virtual-machines/nd-h100-v5-series), [NDm A100 v4-series](/azure/virtual-machines/ndm-a100-v4-series), and [ND A100 v4-series](/azure/virtual-machines/nda100-v4-series).

- *Check virtual machine pricing.* Use the [Linux](https://azure.microsoft.com/pricing/details/virtual-machines/linux/) and [Windows](https://azure.microsoft.com/pricing/details/virtual-machines/windows/) VM pricing pages for a general cost overview. For a detailed estimate, use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/).

- *Consider spot instances.* [Spot instances](/azure/virtual-machines/spot-vms) are cost-effective for inference scenarios with minimal data loss risk. Spot instances offer significant savings by utilizing unused datacenter capacity at a discount. However, this capacity can be reclaimed at any time, so spot instances are best for workloads that can handle interruptions. Regularly checkpoint data to minimize loss when evicted. For information, see [Using Spot VMs in Azure CycleCloud](/azure/cyclecloud/how-to/use-spot-instances).

## Choose a compute orchestration solution

Compute orchestration solutions facilitate the management of AI tasks across virtual machine clusters. Even for simple deployments, an orchestrator can help reduce costs and ensure an environment is reproducible. Orchestrators help ensure you only use the compute that you need for a specific amount of time. Select an orchestration tool based on your scheduling, containerization, and scaling needs to improve operations and scalability.

- *Use Azure CycleCloud for open-source schedulers.* Azure CycleCloud is ideal for open-source schedulers like Slurm, Grid Engine, or Torque/PBS. It provides flexible cluster management, customizable configurations, and advanced scheduling capabilities. Virtual machines within the cluster need configuration for AI workload execution. Virtual machines for CycleCloud and Batch are non-persistent. The orchestrator creates and removes VMs when needed to help with cost savings. For more information, see [Azure CycleCloud Workspace for Slurm](./cycle-cloud.md).

- *Use Azure Batch for built-in scheduling.* Azure Batch offers built-in scheduling features with no need for extra software installation or management. It has a consumption pricing model and no licensing fees. It also supports containerized tasks natively. For deployment best practices, see [Azure Batch Accelerator](https://github.com/Azure/bacc).

- *Use Azure Kubernetes Service (AKS) for container scaling.* AKS is a managed service for deploying, scaling, and managing containers across a cluster. It's suitable for running AI workloads in containers at scale. For more information, see [Use Azure Kubernetes Service to host GPU-based workloads](/azure/architecture/reference-architectures/containers/aks-gpu/gpu-aks).

- *Manually orchestrate jobs for simpler tasks.* If orchestration needs are minimal, manage AI resources manually. Consider the following steps for small-scale workloads:
    - *Define your workflow.* Understand your workflow end-to-end, including dependencies and job sequence. Consider how to handle failures at any step.
    - *Log and monitor jobs.* Implement clear logging and monitoring frameworks for your jobs.
    - *Validate prerequisites.* Ensure your environment meets all workflow requirements, including necessary libraries and frameworks.
    - *Use version control.* Track and manage changes using version control.
    - *Automate tasks.* Use scripts to automate data preprocessing, training, and evaluation.

## Consider containers

Containers provide a consistent, reproducible environment that scales efficiently. Containers streamline transitions between environments, making them essential for scalable AI solutions.

- *Install drivers.* Ensure the necessary drivers are installed to enable container functionality in various scenarios. For cluster configurations, tools like Pyxis and Enroot are often required.

- *Use NVIDIA Container Toolkit.* This toolkit enables GPU resources within containers. Install all required drivers, such as CUDA and GPU drivers, and use your preferred container runtime and engine for AI workload execution.

## Next step

> [!div class="nextstepaction"]
> [Storage IaaS AI](./storage.md)
