---
title: Compute for AI workloads on Azure infrastructure
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Compute for AI workloads on Azure infrastructure

This article provides recommendations for bringing your own AI models to run on Azure infrastructure. The preferred approach is to start with Azure AI platform solutions (PaaS). For organizations looking to bring their own models to Azure for training, this is the guidance to get you AI workload running on Azure infrastructure.

AI workloads need specialized virtual machines (VMs) to handle high computational demands and large-scale data processing. Using the right VMs optimizes resource use and speeds up the development and deployment of AI models, making this step essential for organizations adopting AI.

| AI phase             | Virtual Machine Image  | Generative AI (LLMs, SLMs) | Nongenerative AI (complex models)  | Nongenerative AI (small models)  |
|----------------------|------------------------|----------------------------|------------------------------------|----------------------------------|
| Training AI models   | [Data Science Virtual Machines](https://azure.microsoft.com/services/virtual-machines/data-science/)     | GPU (prefer ND-family. Alternatively use NC family with ethernet-interconnected VMs) | GPU (prefer ND-family. Alternatively use NC family with ethernet-interconnected VMs) | [Memory-optimized](https://azure.microsoft.com/services/virtual-machines/memory-optimized/) (CPU) |
| Inferencing AI models| [Data Science Virtual Machines](https://azure.microsoft.com/services/virtual-machines/data-science/)     | GPU (NC or ND family)  | GPU (NC or ND family) | [Compute-optimized](https://azure.microsoft.com/services/virtual-machines/compute-optimized/) (CPU) |

## Pick the right virtual machine image

Choosing a suitable virtual machine image, such as the Data Science Virtual Machines, allows quick access to pre-configured tools for building AI workloads. This choice saves time and resources while ensuring you have the necessary software for efficient AI processing.

- *Start with the Data Science Virtual Machines images.* The [Data Science Virtual Machine](/azure/machine-learning/data-science-virtual-machine/overview) image offers preconfigured access to data science tools. These tools include PyTorch, TensorFlow, scikit-learn, Jupyter, Visual Studio Code, Azure CLI, pyspark, and others. When you use it with GPUs, the image installs Nvidia drivers, CUDA Toolkit, and cuDNN.

- *Find alternative images as needed.* If the Data Science Virtual Machine image doesn’t meet your needs, use the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps) or other searching [methods](/azure/virtual-machines/overview#distributions) to find an alternate image. For example, with GPUs, you should use [Linux images](/azure/virtual-machines/configure) that include InfiniBand drivers, NVIDIA drivers, communication libraries, MPI libraries, and health check and monitoring tools.

## Pick a virtual machine size

Selecting an appropriate virtual machine size is essential to align with the complexity of your AI model, data size, and cost constraints. Using hardware that matches your training or inferencing needs maximizes efficiency and ensures that resources are neither underused nor overwhelmed.

- *Narrow your virtual machine options.* Opt for the latest virtual machine SKUs for the fastest training and inference times. When training, use SKUs that support RDMA and GPU interconnects for high-speed data transfer between the GPUs. Inferencing models often do not require SKUs with InfiniBand. For example, see [ND MI300X v5 series](/azure/virtual-machines/sizes/gpu-accelerated/nd-mi300x-v5-series), [ND H100 v5 series](/azure/virtual-machines/nd-h100-v5-series), [NDm A100 v4-series](/azure/virtual-machines/ndm-a100-v4-series), and [ND A100 v4-series](/azure/virtual-machines/nda100-v4-series).

- *Check virtual machine pricing.* Use the virtual machine pricing pages for [Linux](https://azure.microsoft.com//pricing/details/virtual-machines/linux/) and [Windows](https://azure.microsoft.com/pricing/details/virtual-machines/windows/) VMs for a general understanding of the cost of your VM choice. Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to get a more detailed pricing estimate of your architecture.

- *Consider spot instances.* Spot Instances are optimal for inferencing scenarios where the risk of losing data is minimal. Spot instances offer significant cost savings on certain SKUs for AI infrastructure as they utilize unused capacity in datacenters at a discounted rate. However, this capacity can be reclaimed at any time, so spot instances are best for AI workloads that can handle interruptions. Ensure regular checkpointing to minimize data loss if your VM is evicted.

## Choose a compute orchestration solution

Compute orchestration solutions enable the efficient management of complex AI tasks across virtual machine clusters. Selecting an orchestration tool based on your scheduling, containerization, and scaling requirements helps streamline operations and improves scalability for organizations adopting AI.

- *Use Azure CycleCloud to access open-source schedulers.* Azure CycleCloud is ideal for using open-source schedulers like Slurm, Grid Engine, or Torque/PBS. It offers flexibility in cluster management, customizable configurations, advanced scheduling capabilities, and support for running containerized applications in an HPC environment. For more information, see [Azure HPC deployment](https://github.com/Azure/azurehpc#azurehpc).
Virtual machines within the cluster require configuration for AI workload execution. [Azure CycleCloud Workspace for Slurm (CCWS)](/azure/cyclecloud/overview-ccws) offers a managed Marketplace deployment option for Slurm clusters. Because setting up and managing Slurm clusters can be complex, CCWS simplifies the process by enabling users to deploy pre-configured Slurm clusters within minutes—no prior knowledge of Slurm or Azure required.

- *Use Azure Batch for its built-in scheduling features.* Azure Batch provides built-in scheduling features without the need for other software installation or management. It has a consumption pricing model and no licensing fees. It's suitable if you want to avoid upfront costs. Azure Batch provides native support for containerized tasks. For a repository that contains an accelerator to deploy Azure batch with best practices, see [Azure Batch Accelerator](https://github.com/Azure/bacc).

- *Use Azure Kubernetes Service (AKS) to run containers at scale.* AKS is a managed service for deploying, scaling, and managing Docker containers and container-based applications across a cluster of container hosts. It’s a great choice if you’re planning to run AI workloads in containers at scale.

- *Manually orchestrate jobs for simple orchestration.* If you don’t have complex orchestration tasks or multiple jobs to execute, deploy and manage AI resources manually. For small scale workloads, keep these items in mind:

    - *Define your workflow.* You should understand your workflow end-to-end and map out each step that is needed for the job or jobs. Understanding the architecture of your workload is imperative, including all dependencies and constraints. You need to consider the order in which jobs run and what happens If the workload fails at a particular job.
    - *Log and monitor jobs.* You need to implement clear logging and monitoring while running your jobs/scripts. There are frameworks that can help implement logging and monitoring at the script level
    - *Validate prerequisites.* Ensure that your environment has all the prerequisites necessary to support the workflow. Include any frameworks or libraries in the environment that the workflow runs in.
    - *Use version control.* Use a version control system to track/revert changes
    - *Automate*. Use scripts to automate each step of the process, including data preprocessing, training, and evaluation.

## Consider containers

Using containers for AI workloads provides a consistent, reproducible environment that efficiently manages computational resources and scales based on demand. Containers allow seamless transitions between different environments, essential for organizations looking to adopt scalable and flexible AI solutions.

- *Install drivers.* Ensure that you have the necessary drivers installed to enable containers to run in various scenarios. For cluster configurations, container runtime tools such as Pyxis and Enroot are typically required.

- *Use toolkits.* The NVIDIA Container Toolkit is commonly used to enable GPU resources within containers. Ensure you install all necessary drivers, such as drivers for CUDA and the GPU. You can then use your preferred container runtime and engine to execute your AI workloads.

## Next step

> [!div class="nextstepaction"]
> [IaaS AI storage](./storage.md)
