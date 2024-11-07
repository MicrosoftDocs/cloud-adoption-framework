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

- *Implement distributed training for efficiency.* Use distributed training techniques, if applicable, to reduce training time by using multiple VMs. Frameworks like Horovod and PyTorch support distributed training on Azure.

- *Save checkpoints in Azure Blob Storage.* Store model states, weights, and configurations periodically in Azure Blob Storage using structured formats like TensorFlow SavedModel or PyTorch checkpoints. Set up interval-based checkpointing to capture model progress at key stages.

- *Design for state recovery.* Ensure the application can recover from saved checkpoints by loading the model state from Azure Blob Storage on startup. Check for existing checkpoints and load the latest available to resume without loss of progress.

## Cost optimization

Using models on Azure IaaS might become costly if not carefully managed, especially as compute and storage demands grow. When planning is not intentional, over-provisioned resources or idle instances can drive up expenses. Resource usage must align with workload needs to avoid unnecessary costs and ensure sustainable model development. Consider these strategies:

- *Commit to Reserved Instances.* Save on virtual machine (VM) costs by committing to a one- or three-year term, which offers discounted rates.

- *Use VM Scale Sets (VMSS) for automatic scaling.* Automatically adjust VM instances based on metrics like CPU usage, paying only for what you need and preventing over-provisioning.

- *Set automatic shutdowns for idle instances.* Avoid costs from unused resources by enabling automatic shutdown, especially for development and test environments.

- *Use Azure Savings Plans for predictable usage.* Reduce costs compared to pay-as-you-go pricing by committing to consistent usage across VM sizes and regions.

- *Use Azure Spot instances for fault-tolerant workloads.* Get substantial discounts on spare capacity for workloads that can tolerate interruptions.

- *Select the right storage solution.* Balance cost and performance based on workload needs. Choose Azure Managed Lustre (AMLFS) for high-throughput, large-scale applications, and Azure NetApp Files (ANF) for advanced data management and reliability.

## Performance efficiency

### GPU tuning

Increase the clock rate of a graphics processing unit (GPU) to improve performance, especially for tasks requiring high graphical processing or complex computations. Higher clock speeds allow the GPU to execute more operations in a given time period, enhancing overall efficiency. Use this [GPU-optimization script](https://github.com/Azure/azurehpc/tree/master/experimental/gpu_optimizations#gpu-optimization) to set the GPU clock frequencies to their maximum values.

- *Enable Accelerated Networking.* Accelerated Networking is a hardware acceleration technology that allows virtual machines to use single root I/O virtualization (SR-IOV) on supported virtual machines types. It provides lower latency, reduced jitter, and decreased CPU utilization. Enable accelerated Networking offers substantial enhancements in front-end network performance.

### I/O tuning

- *Optimize scratch storage.* Scratch needs to have high throughput and low latency. The training job requires reading data, processing it, and using this storage location as scratch space while the job runs. Ideally, you would use the local SSD directly on each VM. If you need a shared filesystem for scratch, combining all NVMe SSDs to create a Parallel File System (PFS) might be a great option in terms of cost and performance, assuming it has sufficient capacity. One method to achieve this is with BeeOND. If this is not suitable, other storage options like IaaS Lustre PFS, Azure ClusterStor, and Azure NetApp files can be explored.

- *Implement checkpoint storage.* Large deep learning training jobs can run for weeks, depending on the number of VMs used. Just like any HPC cluster, you can encounter failures, such as InfiniBand issues, dual in-line memory module (DIMM) failures, error-correcting ode (ECC) errors in GPU memory. It is critical to have a checkpointing strategy. Know the checkpoint interval (when data is saved). Understand how much data is transferred each time. Have a storage solution that meets capacity and performance requirements. Use Blob Storage, if it meets the performance needs.

### Benchmarking tests

Benchmarking tests help evaluate and improve distributed deep learning training performance on GPUs, especially for large-scale models. These tests measure the efficiency of GPU communication across nodes, aiming to reduce data transfer bottlenecks during distributed training. The three tests discussed include:

- **Megatron Framework**: Supports large-scale language models by improving distributed training efficiency.
- **NCCL and RCCL Tests**: Evaluate performance and accuracy in multi-GPU communication using NCCL or RCCL libraries, testing patterns like all-reduce and scatter.

These tests ensure scalability and optimal performance for LLMs, with Megatron focusing on model training and NCCL/RCCL on GPU communication.

### Using NVIDIA Megatron-LM

NVIDIA Megatron-LM is an open-source framework for training large language models. It allows developers to create massive neural networks for NLP tasks, with features including:

- **Parallelism**: Supports model, data, and pipeline parallelism for billion-parameter models.
- **Scalability**: Scales across multiple GPUs and nodes for efficient large model training.
- **Flexibility**: Allows configuration of model architecture, data loading, and training strategies.
- **Optimizations**: Uses NVIDIA’s GPU optimizations for performance gains.

Megatron-LM deploys on Azure HPC infrastructure, and it uses Azure’s scalability for large language models without requiring on-premises hardware.

#### Setting Up Megatron-LM on Azure HPC

Deploying Megatron-LM requires specific software and hardware.

- *Pick .* Use the CycleCloud Slurm Workspace to simplify deployment. Choose NC-series or ND-series SKUs for the GPU partition. For multi-node training, ND-series SKUs are recommended for RDMA support. Azure’s HPC marketplace images generally include these drivers and libraries. If customization is needed, the azhpc-images repository can ensure compatibility.
- *Use the right image.* The software requirements for the project include a Linux-based operating system, typically Ubuntu. For multi-GPU and multi-node communication, it is essential to have communication libraries such as NCCL and MPI. Additionally, appropriate NVIDIA drivers must be installed to ensure GPU acceleration. [Azure's HPC marketplace images](/azure/virtual-machines/azure-hpc-vm-images) generally come with these drivers and libraries pre-installed. However, if customization is necessary, the azhpc-images repository can be used to ensure compatibility.

#### Running Megatron-LM on Azure HPC

Using Megatron-LM with Azure’s infrastructure involves a few additional components:

- **enroot**: Runs containerized applications on HPC clusters without root privileges.
- **pyxis**: Integrates enroot with Slurm, enabling containerized jobs on HPC nodes.

These are included in the CycleCloud Slurm workspace but may need to be added to other Slurm clusters via CycleCloud projects.

Steps to train with Megatron-LM:

1. **Verify Cluster Performance**: Run Node Health Checks to identify hardware issues. Use NCCL tests to confirm distributed all-reduce performance.
2. **Prepare Training Data**: Use a model like CodeParrot to validate the workflow.
3. **Data Preprocessing**: Use the `preprocess_data.py` script in Megatron-LM to format data for training.
4. **Training Configuration**: Refer to Megatron-LM examples to set up training parameters. 

This setup ensures efficient deployment and training of large language models on Azure’s HPC resources.

**NCCL bandwidth test**

- *Run NCCL to check GPU communication efficiency.* NCCL’s all-reduce, all-gather, and other primitives support high-bandwidth GPU communication across nodes and networks, including PCIe, NVLink, NVswitch, and InfiniBand.