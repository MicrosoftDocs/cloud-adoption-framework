---
title: Adopt AI on Azure infrastructure (IaaS)
description: Discover how to build AI applications on Azure IaaS with detailed recommendations, architecture guides, and best practices.
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/01/2024
ms.topic: conceptual
---

# Adopt AI on Azure infrastructure (IaaS) - Recommendations to build AI applications with Azure infrastructure services (IaaS)

This article provides recommendations for bringing your own AI models to run on Azure infrastructure. The preferred approach is to start with Azure AI platform solutions (PaaS). The focus is on building AI applications in Azure.

## Understand AI networking

This guidance provides recommendations for selecting the right networking features for AI workloads on Azure infrastructure.

- *Use high-performance networking.* A minimum bandwidth of 10-20 Gbps is often required for distributed AI workloads involving multiple nodes and large datasets. Use virtual machines and virtual machines images that support high performance technologies, such as interconnects, Infiniband, and GPUDirect RDMA.

- *Deploy dedicated virtual networks for each application environment.* Size the networks appropriately and deploy them within the relevant subscription to optimize performance and resource allocation.

- *Deploy VMs to their appropriate subscriptions.* Use different SKUs and availability configurations as needed to meet environment-specific requirements.

## Understand AI compute

Compute refers to the hardware, images used to train and inference AI models. Compute resources directly affect the efficiency, speed, and cost-effectiveness of your AI operations.

*Table 1. Summary of compute recommendations by use case.*

| AI phase             | Virtual Machine Image  | Generative AI (LLMs, SLMs) | Non-generative AI (complex models)  | Non-generative AI (small models)  |
|---------|------------|---------              |-----------------------------|-----------------------------        | ---                               |
| Training AI models   | [Data Science Virtual Machines](https://azure.microsoft.com/services/virtual-machines/data-science/)     | GPU (prefer ND-family. Alternatively use NC family with ethernet-interconnected VMs) | GPU (prefer ND-family. Alternatively use NC family with ethernet-interconnected VMs) | [Memory-optimized](https://azure.microsoft.com/services/virtual-machines/memory-optimized/) (CPU) |
| Inferencing AI models| [Data Science Virtual Machines](https://azure.microsoft.com/services/virtual-machines/data-science/)     | GPU (NC or ND family)  | GPU (NC or ND family) | [Compute-optimized](https://azure.microsoft.com/services/virtual-machines/compute-optimized/) (CPU) |

### Pick the right virtual machine image

Choose a virtual machine image (Linux and Windows distributions) that expedites your ability to build AI workloads. Use images that have preinstalled tools for AI workloads.

- *Start with the Data Science Virtual Machines images.* [Data Science Virtual Machine](/azure/machine-learning/data-science-virtual-machine/overview) image offers pre-configured access to PyTorch, TensorFlow, scikit-learn, Jupyter, Visual Studio Code, Azure CLI, pyspark, and other tools for quick setup on Azure. When you use it with GPUs, the image installs Nvidia drivers, CUDA Toolkit, and cuDNN.

- *Find alternative images as needed.* If the Data Science Virtual Machine image doesn’t meet your needs, use the [Azure marketplace](https://azuremarketplace.microsoft.com/marketplace/apps) or other searching [methods](/azure/virtual-machines/overview#distributions) to find an alternate image. For example, with GPUs, you should use [Linux images](/azure/virtual-machines/configure) that include InfiniBand drivers, NVIDIA drivers, communication libraries, MPI libraries, and health check and monitoring tools.

### Pick a virtual machine size

Pick the virtual machine that aligns with your AI model complexity, dataset size, cost considerations, and whether you’re training or inferencing AI models.

- *Narrow your virtual machine options.* AI training is faster on memory-optimized hardware. AI inferencing is faster on compute-optimized hardware. Use GPUs to train and inference large datasets, such as those required for LLM, SLM, and image recognition. Select GPU virtual machines that support Infiniband, GPUDirect RDMA, and GPU interconnects for high-speed data transfer between the GPUs. The following table provides a recommended series based on data size.

| VM series | Infiniband | GPUDirect RDMA | GPU interconnects | Compute capacity |
| ----      | ---        | ---            | ---               | ---              |
| [ND MI300X v5 series](/azure/virtual-machines/sizes/gpu-accelerated/nd-mi300x-v5-series) | X | X | X | Extra high |
| [ND H100 v5 series](/azure/virtual-machines/nd-h100-v5-series) | X | X | X | High |
| [NDm A100 v4-series](/azure/virtual-machines/ndm-a100-v4-series) | X | X | X | Medium-high |
| [ND A100 v4-series](/azure/virtual-machines/nda100-v4-series) | X | X | X | Medium |

- *Check virtual machine pricing.* Use the virtual machine pricing pages for [Linux](https://azure.microsoft.com//pricing/details/virtual-machines/linux/) and [Windows](https://azure.microsoft.com/pricing/details/virtual-machines/windows/) VMs for a general understanding of the cost of your VM choice and confirm what aligns with your budget. Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) to get a most detailed pricing estimate.

- *Consider spot instances.* Spot Instances are optimal for inferencing scenarios where the risk of losing data is minimal. Spot instances offer significant cost savings on certain SKUs for AI infrastructure as they utilize unused capacity in datacenters at a discounted rate. However, this capacity can be reclaimed at any time, so spot instances are best for AI workloads that can handle interruptions. Ensure regular checkpointing to minimize data loss if your VM is evicted.

### Choose a compute orchestration solution

Use an orchestrator if you have complex orchestration requirements and virtual machine clusters. You need to choose a compute orchestrator now because you can’t always add a compute orchestrator to deployed virtual machines. The orchestrator you should use depends on your scheduler preference, cluster management needs, container usage, and scalability requirements. To choose an orchestrator, follow this guidance:

- *Use Azure CycleCloud to access open-source schedulers.* Azure CycleCloud is ideal for using open-source schedulers like Slurm, Grid Engine, or Torque/PBS. It offers flexibility in cluster management, customizable configurations, advanced scheduling capabilities, and support for running containerized applications in an HPC environment. For more information, see [Azure HPC deployment](https://github.com/Azure/azurehpc#azurehpc). Virtual machines deployed as part of the cluster must be configured for AI workload execution.

- *Use Azure Batch for its built-in scheduling features.* Azure Batch provides built-in scheduling features without the need for additional software installation or management. It’s based on compute resources and usage, without additional licensing fees, making it suitable for those wanting to avoid upfront costs. It provides native support for containerized tasks. For a repository that contains an accelerator to deploy Azure batch with best practices, see [Azure Batch Accelerator](https://github.com/Azure/bacc).

- *Use Azure Kubernetes Service (AKS) to run containers at scale.* AKS is a managed service for deploying, scaling, and managing Docker containers and container-based applications across a cluster of container hosts. It’s a great choice if you’re planning to run AI workloads in containers at scale.

- *Manually orchestrate jobs for simple orchestration.* If you don’t have complex orchestration tasks or multiple jobs to execute, deploy and manage AI resources manually. For small scale workloads, keep these items in mind:

    - *Define your workflow.* You should understand your workflow end-to-end and map out each step that is needed for the job or jobs. Understanding the architecture of your workload is imperative, including all dependencies and constraints. You will also have to carefully consider the order in which jobs run and what happens If the workload fails at a particular job.
    - *Log and monitor jobs.* You need to implement clear logging and monitoring while running your jobs/scripts. There are frameworks that can help implement logging and monitoring at the script level
    - *Validate prerequisites.* Ensure that your environment has all the pre-requisites necessary to support the workflow. Include any frameworks or libraries in the environment that the workflow will be running in.
    - *Use version control.* Use a version control system to track/revert changes
    - *Automate*. Use scripts to automate each step of the process, including data preprocessing, training, and evaluation.

### Consider containers

Consider using containers for your AI workloads. Containers provide a consistent, reproducible, and isolated environment that can efficiently utilize computational resources, scale based on demand, and transition seamlessly between different environments.

- *Install drivers.* Ensure that you have the necessary drivers installed to enable containers to run in various scenarios. For cluster configurations, container runtime tools such as Pyxis and Enroot are typically required.

- *Use toolkits.* The NVIDIA Container Toolkit is commonly used to enable GPU resources within containers. It’s crucial to ensure that all necessary drivers, including those for CUDA and the GPU, are installed. You can then use your preferred container runtime and engine to execute your AI workloads.

## Understand AI data storage

Implement a storage solution that combines a high-performance file system for active workloads and scalable blob storage for long-term data management. This ensures data integrity, efficiency, and reproducibility in AI workflows.

- *Use a file system for active data*. Implement a file system to store "job-specific/hot" data—data actively used or generated by AI jobs. This solution is ideal for real-time data processing due to its low-latency and high-throughput capabilities, which are critical for optimizing the performance of AI workflows. Azure has three principal file system solutions to support training and inferencing AI models on Azure infrastructure. To choose the right file system, follow these recommendations:

    - *Use Azure Managed Lustre for lowest data transfer times and minimized latency.* Azure Managed Lustre provides high performance with parallel file system capabilities and simplifies management with Azure integration. It's cost-effective, with usage-based storage costs, and allows selective data import from Blob Storage, optimizing data handling.
    
    - *Use Azure NetApp Files when you need enterprise-grade features and performance for AI workloads.* Azure NetApp Files offer high reliability and performance, ideal for mission-critical applications. Azure NetApp Files is beneficial if you have existing investments in NetApp infrastructure, require hybrid cloud capabilities, or need to customize and fine-tune storage configurations to meet specific workload requirements.
    
    - *Use local NVMe/SSD file systems when performance is the top priority.* It aggregates the local NVMe of compute (worker nodes) to create a job-dedicated parallel file system, using a job-dedicated parallel file system like BeeGFS On Demand (BeeOND). They operate directly on the compute nodes to create a temporary, high-performance file system for the duration of the job. These systems offer ultra-low latency and high throughput, making them ideal for I/O-intensive applications like deep learning training or real-time inference.

- *Transfer inactive data to Azure Blob Storage.* After a job is completed, transfer inactive job data from Azure Managed Lustre to Azure Blob Storage for long-term, cost-effective storage. Blob storage provides scalable options with different access tiers, ensuring efficient storage of inactive or infrequently accessed data, while keeping it readily available when needed.

- *Implement checkpointing for model training.* Set up a checkpointing mechanism that saves the model’s state, including training weights and parameters, at regular intervals (e.g., every 500 iterations). Store this checkpoint data in Azure Managed Lustre to allow restarting the model training from a previously saved state, improving the flexibility and resilience of your AI workflows.

- *Automate data migration to lower-cost storage tiers.* Configure Azure Blob Storage lifecycle management policies to automatically migrate older, infrequently accessed data to lower-cost storage tiers, such as the Cool or Archive tiers. This approach optimizes storage costs while ensuring that important data remains accessible when needed.

- *Ensure data consistency across distributed environments.* Ensure data consistency across distributed AI workloads by setting up synchronization between Azure Managed Lustre and Azure Blob Storage. This synchronization ensures that all nodes accessing the data are working with the same, consistent version, preventing errors and discrepancies in distributed environments.

- *Enable data versioning for reproducibility.* Activate versioning in Azure Blob Storage to track changes to datasets and models over time. This feature facilitates rollback, enhances reproducibility, and supports collaboration by maintaining a detailed history of modifications to data and models, enabling you to compare and restore previous versions as needed.

## Secure AI infrastructure

The following is a starting point for Azure infrastructure and any PaaS services in the AI application. For more comprehensive information on securing AI, see the [Secure AI](./secure.md).

- *Apply secure configurations to Azure services.* Follow the [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for each service in your architecture. Common Azure services in AI workloads on Azure infrastructure include:

    - [Windows](/security/benchmark/azure/baselines/virtual-machines-windows-virtual-machines-security-baseline) and [Linux](/security/benchmark/azure/baselines/virtual-machines-linux-virtual-machines-security-baseline) Azure Virtual Machines
    - [Azure CycleCloud](/azure/cyclecloud/concepts/security-best-practices)
    - Virtual Machine Scale Sets
    - Azure Managed Lustre File System
    - Azure NetApp Files
    - Azure Kubernetes Service
    - Azure Database for MySQL
    - [Key Vault](/security/benchmark/azure/baselines/key-vault-security-baseline)

- *Use private endpoints.* Use private endpoints available in [Azure Private Link](/azure/networking/fundamentals/networking-overview#privatelink) for any PaaS solution in your architecture, such as your storage or filesystem.

- *Implement network security groups (NSGs).* NSGs can be complex. Ensure you understand the NSG rules and their implications when setting up your Azure infrastructure for AI workloads. [NSG](/azure/virtual-network/network-security-groups-overview) rules have a priority order. Understand this order to avoid conflicts and ensure the smooth running of your AI workloads.

- *Use application security groups*. If you need to label traffic at a greater granularity than what virtual networks provide, consider using [Application Security Groups](/azure/virtual-network/application-security-groups). This can be useful when managing traffic for specific AI workloads.

- *Close unused ports.* Limit internet exposure by exposing only services intended for external-facing use cases and using private connectivity for other services.

- *Use antimalware.* Use [Microsoft Antimalware for Azure](/azure/security/fundamentals/antimalware) on your virtual machines to protect them from malicious files, adware, and other threats.

## Manage AI infrastructure

This guidance focuses on ensuring observability and managing business continuity for AI workloads on Azure infrastructure.

### Monitor AI infrastructure

The following guidance provides recommendations for monitoring AI workloads running on Azure infrastructure.

- *Ensure monitoring by default.* Deploy the required Azure Monitor agents for virtual machines and Azure Virtual Machine Scale Sets, including Azure Arc connected servers. Connect them to the central Log Analytics workspace in the management subscription. Configure alerts using [Azure Monitor Baseline Alerts](http://aka.ms/amba) (AMBA).

- *Use Azure Update Manager.* You can monitor Windows and Linux update compliance across your machines in Azure and on-premises/on other cloud platforms (connected by [Azure Arc](/azure/azure-arc/)) from a single pane of management. You can also use Update Manager to make real-time updates or schedule them within a defined maintenance window.

- *Monitor virtual machines.* [Monitor](/azure/virtual-machines/monitor-vm) VM host data (physical host) and VM guest data (operating system and application). Consider using [VM Insights](/azure/azure-monitor/vm/vminsights-enable-overview) to simplify the onboarding, access predefined performance charts, and utilize dependency mapping. Track Spot VM evictions and maintenance events to manage interruptions effectively. [Learn more about scheduled events](/azure/virtual-machines/linux/scheduled-events).

- *Monitor networks.* [Monitor and diagnose](/azure/network-watcher/network-watcher-overview) networking issues without logging into your VMs. Get real-time performance information at the packet level. Troubleshoot performance issues with the [Performance Diagnostics tool](/azure/troubleshoot/azure/virtual-machines/windows/performance-diagnostics). [Track](/azure/network-watcher/network-insights-overview) topology, health, and metrics for all deployed network resources.

- *Monitor storage.* Monitor the performance of storage, such as local SSDs, [attached disks](/azure/virtual-machines/disks-metrics), file shares, and [Azure storage accounts](/azure/azure-monitor/insights/storage-insights-overview).

- *Use orchestrator monitoring capabilities (if applicable).* Consider using the built-in monitoring capabilities of orchestrators like Azure CycleCloud, Azure Batch, and Azure Kubernetes Service (AKS). Follow the guidance for the orchestrator you chose:

    - *Azure CycleCloud:* Track CPU, disk, and network metrics. store data from Azure Cycle Cloud clusters to Log Analytics and create custom metrics dashboards. For more information, see [Monitoring Azure CycleCloud](/azure/cyclecloud/concepts/monitoring). [Node Health Checks](https://github.com/Azure/azurehpc-health-checks#Configuration) are a set of automated tests to ensure that your HPC/AI hardware is healthy. You can run this check in Azure CycleCloud as part of cluster deployment or separately using the GitHub repo instructions. Ensure that you pay attention to the compatibility matrix in the documentation and run where appropriate to ensure that you identify any unhealthy nodes prior to running your AI workloads.

    - *Azure Batch:* Collect job and task metrics (active tasks, task duration, job start time, duration, task start time) and pool metrics (idle nodes, running nodes, CPU usage, Disk I/O). For more information, see [Azure Batch monitoring](/azure/batch/monitor-batch).

    - [*Azure Kubernetes Service*](/azure/architecture/reference-architectures/containers/aks-gpu/gpu-aks). Use Azure Monitor for containers. Monitor pod performance, node health, and resource utilization. Set up alerts and custom dashboards.

## Manage business continuity and disaster recovery

The following guidance provides recommendations for implementing and managing business continuity and disaster recovery for your AI applications.

- *Use Azure Site Recovery.* Site Recovery uses real-time replication and recovery automation to replicate workloads across regions. Built-in platform capabilities for VM workloads meet low RPO and RTO requirements. You can use Site Recovery to run recovery drills without affecting production workloads. You can also use Azure Policy to enable replication and to audit VM protection.

- *Use orchestrator capabilities (if applicable)*. Use your orchestrator to recover failed compute nodes. For example, configure Azure Batch can automatically [retry tasks](/azure/batch/best-practices#pool-allocation-failures) in case of failure.

- *Schedule backups.* Determine if you need to backup incremental changes to datasets and models daily or weekly. This could also include databases, entire datasets.

- *Ensure data compliance.* Make sure your backup strategy complies with data protection regulations like GDPR, HIPAA. Comply with data residency requirements and store backups in appropriate geographic locations.

- *Create snapshots.* You can use the capabilities of your scheduler to take snapshots. For example, CycleCloud can take point-in-time snapshots of the underlying application datastore as recovery points.

## AI on infrastructure implementation options

- *AI on infrastructure landing zone accelerator:* If you use Azure landing zones, deploy the [Cycle Cloud Workspace for SLURM](/azure/cyclecloud/qs-deploy-ccws) to your application landing zone.

:::image type="content" source="./images/generative-ai-app.svg" alt-text="Diagram showing the basic components of a generative AI application." lightbox="./images/generative-ai-app.svg" border="false":::
*Figure 1. Basic components of a generative AI application with RAG.*

- *Custom AI application.* If you have an existing Azure environment or don’t want to start with Azure landing zone, use the guidance discussed in this article to create an AI application.

## Next step

> [!div class="nextstepaction"]
> [Secure AI](secure.md)