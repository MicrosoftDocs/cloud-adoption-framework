---
title: Well-architected considerations for AI workloads on Azure infrastructure (IaaS)
description: Learn how to design AI workloads on Azure infrastructure (IaaS).
author: stephen-sumner
ms.author: rajanaki
ms.date: 11/15/2024
ms.topic: conceptual
---
# Well-architected considerations for AI workloads on Azure infrastructure (IaaS)

Well-architected considerations for AI on Azure infrastructure involve best practices that optimize the reliability, security, operational efficiency, cost management, and performance of AI solutions. These principles ensure robust deployment, secure data handling, efficient model operation, and scalable infrastructure on Azure’s IaaS platform. Applying these principles allows organizations to build resilient, secure, and cost-effective AI models that meet business needs.

## Reliability

Reliability involves minimizing downtime and ensuring consistent performance for AI applications on Azure infrastructure. Ensuring reliable operations across distributed virtual machines (VMs) and maintaining performance during infrastructure changes prevents service interruptions. These practices are important because they guarantee continuous model availability and improve user experience.

- *Distribute VMs across Availability Zones.* Minimize downtime from hardware failures or maintenance events by using [Availability Zones](/azure/reliability/availability-zones-overview). They distribute VMs across fault and update domains to ensure continued application operation.

- *Set up health monitoring with Azure Monitor.* Track CPU, memory, and network performance on your VMs using Azure Monitor and configure alerts to notify you of performance degradation or failures in the infrastructure supporting your models. For more information, see [Azure Monitor VM Insights](/azure/azure-monitor/vm/vminsights-health-overview).

- *Automate patching and updates with rolling instances.* Use Azure Update Management to apply patches in a rolling manner, allowing one instance to be updated while others continue to serve traffic, preventing downtime during maintenance.

- *Design for graceful degradation during partial failures.* Ensure core functionality remains available by serving less complex AI models or limiting specific features when some VMs become unavailable, allowing users access to essential services even during outages.

- *Implement regular backups for key assets.* Regularly back up model data, training datasets, and configurations to enable quick restoration if there was a failure, safeguarding valuable progress and data.

## Security

Security covers protective measures to safeguard AI models, data, and infrastructure against unauthorized access and threats. Implement updates, monitor model integrity, and control access to prevent vulnerabilities that could compromise sensitive information. These steps are essential to maintain data privacy and trustworthiness of AI solutions in production environments.

- *Schedule updates for Azure resources.* Use maintenance configurations to set specific update schedules for VMs and extensions, reducing vulnerability windows.

- *Patch virtual machines and container images regularly.* Enable [automatic guest patching](/azure/virtual-machines/automatic-vm-guest-patching) for VMs and scale sets to maintain security against new threats. For more information, see [Guest updates and host maintenance overview](/azure/virtual-machines/updates-maintenance-overview).

- *Monitor for model drift and ensure integrity.* Ensure model integrity by implementing security mechanisms such as digital signatures or hash verifications for model files to prevent unauthorized modifications. Use Azure Monitor to track key performance metrics and identify model drift, which could indicate potential security vulnerabilities or data shifts. You can define custom metrics (accuracy, F1-score, and data distribution on your models) in your code by using the [Azure Monitor Metrics SDK](/azure/azure-monitor/essentials/metrics-custom-overview). Azure Monitor Metrics SDK allows you to send your model’s performance statistics and data drift measurements to Azure Monitor. Monitoring for performance changes over time can help detect when a model's behavior deviates, potentially signaling an attack or a need for retraining. This proactive approach helps safeguard model integrity and maintain security compliance.

- *Implement auditing and access logs.* Use Azure Monitor and Log Analytics to log access to models and VMs, helping to identify unauthorized access or unusual usage patterns. For more information, see [Activity logs in Azure Monitor](/azure/azure-monitor/essentials/activity-log).

- *Use version control for model files.* Store model files in Azure Storage (Blob, File, or Disk) with versioning to track changes, ensuring a clear audit trail for identifying and rolling back harmful modifications. Using Azure DevOps for version control enhances security by managing access to code changes and enforcing best practices in code reviews. This layered approach mitigates risks of unauthorized changes and provides accountability. For more information, see [Blob Versioning in Azure Storage](/azure/storage/blobs/versioning-overview).

- *Set up anomaly detection for model outputs.* Use Azure Monitor to track the output metrics of your models and set up alerts for unusual behavior. For example, monitoring API responses from your model can help detect abnormal output. You can set anomaly detection on a metric like prediction accuracy to automatically detect when it drops outside of an expected range. For more information, see [Create and Manage Metric Alerts with Dynamic Thresholds](/azure/azure-monitor/alerts/alerts-dynamic-thresholds).

- *Enforce model access policies.* Use [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) and Microsoft Entra ID to secure access to VMs and model files, limiting access to authorized users only.

- *Regularly revalidate models against updated data.* Implementing periodic revalidation of your model using automated scripts or workflows on your VMs ensures that the model remains accurate and effective against current datasets, mitigating risks from outdated or inaccurate predictions. By scheduling these tasks with Azure Automation or Azure Logic Apps, you can maintain compliance with data standards and enhance overall model security. This proactive approach helps identify vulnerabilities early, ensuring continuous improvement and safeguarding against potential threats. You can schedule your automation workflows to periodically trigger revalidation tasks. Start with an [Azure Automation runbook](/azure/automation/automation-runbook-execution), [run in the virtual machine](/azure/automation/automation-hybrid-runbook-worker), create an appropriate [schedule](/azure/automation/shared-resources/schedules) to get validation results.

- *Track data lineage and model file changes.* Enable versioning in Azure Blob Storage and track data used in training and inference, ensuring no unauthorized data affects model outcomes.

- *Apply resource quotas and rate limits.* Implement rate limits and quotas for your model APIs through Azure API Management to prevent overuse or abuse, which can lead to system vulnerabilities or service outages. This strategy ensures the system remains responsive during high traffic and mitigates risks associated with denial-of-service attacks. By controlling access, you can maintain performance and protect sensitive data from potential exploitation [API Management Quotas and Limits](/azure/api-management/api-management-policies#rate-limiting-and-quotas).

- *Conduct regular vulnerability scans.* Use Microsoft Defender Vulnerability Scanning to conduct vulnerability assessments of your VMs and related resources. Regularly check for any security issues or misconfigurations in your VM setup that could expose your models. [Microsoft Defender Vulnerability Scanning](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management).

## Cost optimization

Cost optimization involves aligning resource usage with workload requirements to avoid unnecessary expenses. Right-sizing VMs, committing to reserved instances, and setting up autoscaling help manage costs without compromising performance. Controlling costs on Azure infrastructure is vital for long-term sustainability and scalability of AI deployments.

- *Commit to [Reserved Instances](https://azure.microsoft.com/pricing/reserved-vm-instances).* Save on virtual machine (VM) costs by committing to a one- or three-year term, which offers discounted rates.

- *Use Azure Virtual Machine Scale Sets for automatic scaling.* [Automatically scale](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-autoscale-overview)  VM instances based on metrics like CPU usage, paying only for what you need and preventing over-provisioning.

- *Set automatic shutdowns for idle instances.* Avoid costs from unused resources by enabling automatic shutdown, especially for development and test environments.

- *Use [Azure Savings Plans](/azure/cost-management-billing/savings-plan/savings-plan-compute-overview) for predictable usage.* Reduce costs compared to pay-as-you-go pricing by committing to consistent usage across VM sizes and regions.

- *Use [Azure Spot instances](/azure/virtual-machines/spot-vms) for fault-tolerant workloads.* Get substantial discounts on spare capacity for workloads that can tolerate interruptions.

- *Select the right storage solution.* Balance cost and performance based on workload needs. Choose Azure Managed Lustre (AMLFS) for high-throughput, large-scale applications, and Azure NetApp Files (ANF) for advanced data management and reliability.

## Operational excellence

Operational excellence involves optimizing the configuration and management of Azure resources to improve the functionality of AI applications. Efficient resource allocation, performance tuning, and distributed training support smooth operation and adaptability to varying demands. This focus on operational efficiency ensures AI models perform as intended, without excessive resource use.

- *Optimize resource allocation.* Regularly review Azure VM sizes and configurations based on actual resource usage to match workload needs. Use Azure Advisor for recommendations on optimal sizing and scaling.

- *Configure autoscaling for efficiency.* Set up autoscaling for VMs or containers to handle workload demands without over-provisioning. Use Azure Virtual Machine Scale Sets to adjust resources dynamically based on demand. For more information, see [Azure Virtual Machine Scale Sets](/azure/virtual-machine-scale-sets/overview).

- *Conduct regular performance tuning.* Continuously profile the application to identify and resolve performance bottlenecks. Use [Application Insights Profiler](/azure/azure-monitor/profiler/profiler-overview) to analyze model code and resource usage.

- *Implement distributed training for efficiency.* Use distributed training techniques, if applicable, to reduce training time by using multiple VMs. Frameworks like Horovod and PyTorch support distributed training on Azure.

- *Save checkpoints in Azure Blob Storage.* Save model states, weights, and configurations periodically to Azure Blob Storage. You can use Azure SDKs or libraries available in the programming language you're using for the LLM. Store the checkpoints in a structured format, like TensorFlow SavedModel or PyTorch checkpoint files. Modify your training or inference code to include checkpoint logic. Start with setting intervals (after every epoch or some iterations) to save the model's state. Use a consistent naming convention for checkpoint files to track the most recent state easily.

- *Design for state recovery.* Ensure your application can recover from a saved checkpoint. Implement logic to load the model's state from Azure Blob Storage when the application starts. It includes, checking for existing checkpoints, and loading the most recent checkpoint if available, allowing the application to resume without losing progress.

## Performance efficiency

Performance efficiency refers to maximizing the processing power of Azure infrastructure to meet AI model demands. You should tune GPU settings, optimize input/output (I/O) processes, and run benchmarking tests to improve computational speed and responsiveness. Ensuring high performance supports the execution of complex AI models at scale, which enhances user satisfaction and reduces latency.

### GPU tuning

Increase the clock rate of a graphics processing unit (GPU) to improve performance, especially for tasks requiring high graphical processing or complex computations. Higher clock speeds allow the GPU to execute more operations in a given time period, enhancing overall efficiency. Use this [GPU-optimization script](https://github.com/Azure/azurehpc/tree/master/experimental/gpu_optimizations#gpu-optimization) to set the GPU clock frequencies to their maximum values.

- *Enable Accelerated Networking.* Accelerated Networking is a hardware acceleration technology that allows virtual machines to use single root I/O virtualization (SR-IOV) on supported virtual machines types. It provides lower latency, reduced jitter, and decreased CPU utilization. Enable accelerated Networking offers substantial enhancements in front-end network performance.

### I/O tuning

- *Optimize scratch storage.* Scratch needs to have high throughput and low latency. The training job requires reading data, processing it, and using this storage location as scratch space while the job runs. Ideally, you would use the local SSD directly on each VM. If you need a shared filesystem for scratch, combining all NVMe SSDs to create a Parallel File System (PFS) might be a great option in terms of cost and performance, assuming it has sufficient capacity. One method is to use [Azure Managed Lustre](/azure/azure-managed-lustre/amlfs-overview). If Azure Managed Lustre isn't suitable, you can explore storage options like [Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-introduction) or [Azure Native Qumulo](/azure/partner-solutions/qumulo/qumulo-overview).

- *Implement checkpoint storage.* Large deep learning training jobs can run for weeks, depending on the number of VMs used. Just like any HPC cluster, you can encounter failures, such as InfiniBand issues, dual in-line memory module (DIMM) failures, error-correcting ode (ECC) errors in GPU memory. It's critical to have a checkpointing strategy. Know the checkpoint interval (when data is saved). Understand how much data is transferred each time. Have a storage solution that meets capacity and performance requirements. Use Blob Storage, if it meets the performance needs.

### Benchmarking tests

Benchmarking tests help evaluate and improve distributed deep learning training performance on GPUs, especially for large-scale models. These tests measure the efficiency of GPU communication across nodes, aiming to reduce data transfer bottlenecks during distributed training. The three tests discussed include:

- *Megatron framework*: Supports large-scale language models by improving distributed training efficiency.
- *The NVIDIA Collective Communications Library (NCCL) and ROCm Communication Collectives Library (RCCL) tests*: Evaluate performance and accuracy in multi-GPU communication using NCCL or RCCL libraries, testing patterns like all-reduce and scatter.

These tests ensure scalability and optimal performance for LLMs, with Megatron focusing on model training and NCCL/RCCL on GPU communication.

### NVIDIA Megatron-LM test

NVIDIA Megatron-LM is an open-source framework for training large language models. It allows developers to create massive neural networks for NLP tasks, with features including:

- *Parallelism*: Supports model, data, and pipeline parallelism for billion-parameter models.
- *Scalability*: Scales across multiple GPUs and nodes for efficient large model training.
- *Flexibility*: Allows configuration of model architecture, data loading, and training strategies.
- *Optimizations*: Uses NVIDIA GPU optimizations for performance gains.

Megatron-LM deploys on Azure HPC infrastructure, and it uses Azure’s scalability for large language models without requiring on-premises hardware.

#### Megatron-LM test set up

Deploying Megatron-LM requires specific software and hardware.

- *Pick the right deployment options.* Use the [CycleCloud Workspace for Slurm](./cycle-cloud.md) to simplify deployment. Choose NC-series or ND-series SKUs for the GPU partition. For multi-node training, ND-series SKUs are recommended for RDMA support. Azure’s HPC marketplace images generally include these drivers and libraries. If customization is needed, the azhpc-images repository can ensure compatibility.

- *Use the right image.* The software requirements for the project include a Linux-based operating system, typically Ubuntu. For multi-GPU and multi-node communication, it's essential to have communication libraries such as NCCL and MPI. Additionally, appropriate NVIDIA drivers must be installed to ensure GPU acceleration. [Azure's HPC marketplace images](/azure/virtual-machines/azure-hpc-vm-images) come with these drivers and libraries preinstalled. However, if customization is necessary, the [azhpc-images](https://github.com/Azure/azhpc-images?tab=readme-ov-file#azure-hpcai-vm-images) repository can be used to ensure compatibility.

#### Megatron-LM test use

You should run Megatron-LM using the latest release of [NGC's PyTorch container](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch). To run the container against a traditional Slurm-based HPC cluster, you need to install and configure these other components in your cluster:

- [enroot](https://github.com/NVIDIA/enroot): a tool that allows users to run containerized applications on HPC clusters without requiring root privileges or modifying the host system.
- [pyxis](https://github.com/NVIDIA/pyxis): a plugin for Slurm that enables seamless integration of enroot with Slurm, allowing users to submit containerized jobs to Slurm queues and run them on HPC nodes.

Both of these components are included in [CycleCloud Workspace for Slurm](./cycle-cloud.md) but are currently not included in Slurm clusters that are built via CycleCloud. You can introduce these extra components via [cluster-init with CycleCloud projects](/azure/cyclecloud/how-to/projects). With these requirements met, you can use Megatron-LM for LLM training by:

- *Verifying the performance of your cluster*: Identify any potential hardware issues before running your workload with [Node Health Checks](https://github.com/Azure/azurehpc-health-checks). Use NCCL tests to verify the distributed all-reduce performance of the cluster.
- *Selecting your training data*: Use the [codeParrot](https://huggingface.co/codeparrot/codeparrot-small) model as a starting point to validate your workflow.
- *Preprocessing your data*: Use the [preprocess\_data.py](https://github.com/NVIDIA/Megatron-LM/tree/main) script within the Megatron-LM repository to convert your data to a format that is compatible with Megatron-LM.
- *Training with Megatron-LM*: Use the [examples](https://github.com/NVIDIA/Megatron-LM/tree/main/examples) within Megatron-LM as a reference to configure Megatron for training.

This setup ensures efficient deployment and training of large language models on Azure’s infrastructure.

### NCCL bandwidth test

To verify and optimize GPU communication across nodes, run the NCCL bandwidth test. The NCCL bandwidth test is specialized tool within NCCL, a library that facilitates high-speed communication between GPUs. NCCL supports collective operations, including all-reduce, all-gather, reduce, broadcast, and reduce-scatter, across single or multi-GPU nodes, and achieves optimal performance on platforms with PCIe, NVLink, NVswitch, or networking setups like InfiniBand or TCP/IP. For more information, see [NVIDIA/NCCL tests](https://github.com/nvidia/nccl).

#### NCCL performance metrics

Use the NCCL bandwidth test to assess key metrics, including time and bandwidth. "Time" (in milliseconds) measures the overhead or latency in operations, making it useful for evaluating operations with small data sizes. "Bandwidth" (in GB/s) evaluates point-to-point operation efficiency, such as Send/Receive. "Bus bandwidth" reflects hardware usage efficiency by accounting for inter-GPU communication speed and bottlenecks in components like NVLink or PCI. Calculations for various collective operations are provided, such as AllReduce, ReduceScatter, AllGather, Broadcast, and Reduce.

#### NCCL test initiation

To initiate these tests within a CycleCloud deployment, connect to the scheduler node via SSH and access a GPU-equipped compute node. Clone the Git repository for NCCL tests, navigate to the `nccl-tests` directory, and create a host file listing the nodes for testing. Obtain the scheduler node’s IP address from CycleCloud’s web app.

### NCCL test arguments

Before running tests, specify different [arguments](https://github.com/nvidia/nccl-tests?tab=readme-ov-file#arguments) like the number of GPUs per thread (`-g`), data size range (`-b` for minimum bytes and `-e` for maximum bytes), step increment (`-i` or `-f`), reduction operation type (`-o`), datatype (`-d`), root device (`-r`), iteration count (`-n`), warmup count (`-w`), and CUDA graph settings (`-G`). Refer to the NCCL test documentation for a full list of adjustable parameters.

### RCCL tests

ROCm Communication Collectives Library (RCCL) is a specialized library designed for efficient communication between AMD GPUs. It provides collective operations such as all-reduce, all-gather, broadcast, and reduce, supporting both intra- and inter-node GPU communication. Optimized for platforms using PCIe and networking technologies like InfiniBand, RCCL ensures scalable data transfer in multi-GPU environments. It supports integration into both single- and multi-process workflows, such as those using MPI. For more information, see [ROCm Communication Collectives Library](https://github.com/rocm/rccl#rccl)

- *Set Up Environment.* Install ROCm and ensure RCCL is properly installed on all nodes.
- *Build RCCL Tests.* Clone the repository, navigate to the rccl-tests directory, and compile the tests.
- *Run Bandwidth Tests.* Use the provided test executables (rccl-tests), specifying communication operations like all-reduce.
- *Analyze Performance.* Compare bandwidth and latency results across nodes and GPUs.

## Next step

> [!div class="nextstepaction"]
> [Govern AI](../govern.md)
