---
title: Design recommendations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to design AI workloads on Azure infrastructure (IaaS)
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/15/2024
ms.topic: conceptual
---


## Reliability

- *Distribute VMs across Availability Zones.* Minimize downtime from hardware failures or maintenance events by using Availability Zones, which distribute VMs across fault and update domains to ensure continued application operation.

- *Set up health monitoring with Azure Monitor.* Track CPU, memory, and network performance on your VMs using Azure Monitor and configure alerts to notify you of performance degradation or failures in the infrastructure supporting your models.

- *Automate patching and updates with rolling instances.* Use Azure Update Management to apply patches in a rolling manner, allowing one instance to be updated while others continue to serve traffic, preventing downtime during maintenance.

- *Design for graceful degradation during partial failures.* Ensure core functionality remains available by serving less complex AI models or limiting specific features when some VMs become unavailable, allowing users access to essential services even during outages.

- *Implement regular backups for key assets.* Regularly back up model data, training datasets, and configurations to enable quick restoration in case of failure, safeguarding valuable progress and data.

## Security

- *Schedule updates for Azure resources.* Use maintenance configurations to set specific update schedules for VMs and extensions, reducing vulnerability windows.

- *Patch virtual machines and container images regularly.* Enable automatic guest patching for VMs and scale sets to maintain security against new threats.

- *Monitor for model drift and ensure integrity.* Use digital signatures or hash verifications on model files to prevent unauthorized modifications. Track performance metrics, like accuracy and F1-score, with Azure Monitor to detect model drift, which may signal security vulnerabilities or data shifts.

- *Implement auditing and access logs.* Use Azure Monitor and Log Analytics to log access to models and VMs, helping to identify unauthorized access or unusual usage patterns.

- *Use version control for model files.* Store model files in Azure Storage with versioning to track changes, enabling rollback if needed. Manage access and enforce security best practices using Azure DevOps.

- *Set up anomaly detection for model outputs.* Track output metrics using Azure Monitor and set alerts for unusual behavior, such as significant changes in prediction accuracy, to detect potential issues early.

- *Enforce model access policies.* Use Azure RBAC and Azure AD Entra ID to secure access to VMs and model files, limiting access to authorized users only.

- *Regularly revalidate models against updated data.* Schedule automated revalidation tasks using Azure Automation or Logic Apps to maintain accuracy and mitigate risks from outdated predictions.

- *Track data lineage and model file changes.* Enable versioning in Azure Blob Storage and track data used in training and inference, ensuring no unauthorized data affects model outcomes.

- *Apply resource quotas and rate limits.* Use Azure API Management to enforce rate limits and quotas on model APIs, preventing system abuse and maintaining responsiveness.

- *Conduct regular vulnerability scans.* Use Microsoft Defender in Azure Security Center to assess VMs and resources for security issues or misconfigurations, safeguarding your environment from vulnerabilities.

## Operational excellence

- *Optimize resource allocation.* Regularly review Azure VM sizes and configurations based on actual resource usage to match workload needs. Use Azure Advisor for recommendations on optimal sizing and scaling.

- *Configure auto-scaling for efficiency.* Set up auto-scaling for VMs or containers to handle workload demands without over-provisioning. Use Azure Virtual Machine Scale Sets to adjust resources dynamically based on demand.

- *Conduct regular performance tuning.* Continuously profile the application to identify and resolve performance bottlenecks. Use Application Insights Profiler to analyze model code and resource usage.

- *Implement distributed training for efficiency.* Use distributed training techniques, if applicable, to reduce training time by leveraging multiple VMs. Frameworks like Horovod and PyTorch support distributed training on Azure.

- *Save checkpoints in Azure Blob Storage.* Store model states, weights, and configurations periodically in Azure Blob Storage using structured formats like TensorFlow SavedModel or PyTorch checkpoints. Set up interval-based checkpointing to capture model progress at key stages.

- *Design for state recovery.* Ensure the application can recover from saved checkpoints by loading the model state from Azure Blob Storage on startup. Check for existing checkpoints and load the latest available to resume without loss of progress.

## Performance efficiency

### Tune GPUs

Increasing the clock rate of a Graphics Processing Unit (GPU) can significantly improve performance, especially for tasks requiring high graphical processing or complex computations. Higher clock speeds allow the GPU to execute more operations in a given time period, enhancing overall efficiency. Use this [GPU-optimization script](https://github.com/Azure/azurehpc/tree/master/experimental/gpu_optimizations#gpu-optimization) to set the GPU clock frequencies to their maximum values.

- *Enable Accelerated Networking for supported VM SKUs.* This feature enhances front-end network performance, especially on VM SKUs that support it.

**I/O tuning**

- *Optimize scratch storage for high throughput and low latency.* Use local SSDs on VMs whenever possible for fast access to temporary data. If shared scratch storage is required, consider combining NVMe SSDs with a parallel file system (PFS) like BeeOND, IaaS Lustre PFS, Azure ClusterStor, or Azure NetApp Files.
- *Implement checkpoint storage for DL training jobs.* Large training jobs need reliable checkpointing. Determine checkpoint intervals, data transfer volume, and required storage performance. Use Blob Storage if it meets these needs.

**Benchmarking tests**

- *Run High-Performance Linpack (HPL) on each VM.* HPL in the Nvidia HPC-benchmarks container verifies floating-point GPU performance.
- *Use CUDA’s bandwidthTest for data transfer rates.* This test checks the speed of data transfer between host and GPU to ensure optimal bandwidth.
- *Conduct distributed deep learning benchmark tests.* Use tests like Megatron, NCCL, and RCCL to assess and optimize multi-GPU training efficiency, focusing on minimizing communication bottlenecks and ensuring model scalability.

### Megatron tests

**Overview of NVIDIA Megatron-LM**

- *Use Megatron-LM for training large NLP models.* This open-source framework enables training models with billions of parameters, optimized for NVIDIA hardware.
- *Leverage Azure HPC for scalable model training.* Azure’s HPC infrastructure, including NC- or ND-series SKUs, supports scalable, high-performance model training without on-premises hardware.
  
**Architecture requirements**

- *Set up Megatron-LM on CycleCloud Slurm Workspace.* This pre-configured solution deploys a Slurm cluster with required libraries, ideal for NC- or ND-series GPU SKUs. Note that NC-series SKUs lack RDMA support, so use ND-series for multi-node training.
  
**Software requirements**

- *Use a Linux OS and install NCCL, MPI, and NVIDIA drivers.* These components support multi-GPU and multi-node communication. Marketplace HPC images include the necessary libraries and drivers. If a custom image is needed, base it on HPC marketplace images or use the azhpc-images repository to ensure compatibility.
  
**Running Megatron-LM on Azure HPC infrastructure**

- *Launch Megatron-LM using the latest NGC PyTorch container.* For Slurm clusters, use enroot and pyxis to run containerized applications seamlessly. The CycleCloud Slurm workspace includes these components.
- *Verify cluster performance and configure data processing.* Conduct Node Health Checks and NCCL tests for distributed performance. Preprocess training data using the Megatron-LM’s preprocess_data.py script and refer to provided training examples.

**NCCL bandwidth test**

- *Run NCCL to check GPU communication efficiency.* NCCL’s all-reduce, all-gather, and other primitives support high-bandwidth GPU communication across nodes and networks, including PCIe, NVLink, NVswitch, and InfiniBand.