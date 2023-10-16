---
title: Big compute in the manufacturing industry
description: See virtual machine (VM) sizes that are appropriate for big compute workloads in manufacturing, which require a large number of processing cores.
author: bsantacruz
ms.author: bsantacruz
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 10/17/2023
---

# Big compute in the manufacturing industry

High-performance computing (HPC) is used in the manufacturing industry to run large-scale workloads, also known as big compute applications. HPC can help manufacturers at every stage of product development processes and supply chains. Specifically, you can use HPC to run advanced design simulations and also to automate processes and predict maintenance issues.

Big compute workloads involve tasks that require many cores to process. These workloads can include financial risk modeling, engineering stress analysis, and other compute-intensive tasks. Big compute workloads have the following characteristics:

- The workload can be divided into discrete tasks that can be run simultaneously across many cores.
- Each task takes input, processes it, and produces output. The entire application runs for a finite amount of time.
- The application doesn't need to run constantly, but it must be able to handle node failures or crashes.
- Tasks can be independent or tightly coupled, requiring high-speed networking technologies like InfiniBand and remote direct memory access (RDMA) connectivity.

You can use compute-intensive virtual machine (VM) sizes such as H16r, H16mr, and A9. Your selection depends on your workload.

Azure offers a range of VM instances that are optimized for CPU-intensive and GPU-intensive workloads. It's also the only cloud platform that offers InfiniBand-enabled hardware. InfiniBand provides a significant performance advantage for reservoir simulation and seismic workload runs. This advantage results in performance that approaches or exceeds current on-premises infrastructure performance.

Azure VMs offer various options, known as VM sizes, for HPC and GPU-optimized computing. It's important to select a VM size that's appropriate for your workload. To find the size that's the best fit, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes). Also see the selector tool in [Virtual machines selector](https://azure.microsoft.com/pricing/vm-selector/).

Keep in mind that not all Azure products are available in all regions. To see what's available in your area, see [Products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

For best practices for choosing Azure compute options, see the [Azure compute blog](https://techcommunity.microsoft.com/t5/azure-compute-blog/bg-p/AzureCompute) or the [Azure compute service](/azure/architecture/guide/technology-choices/compute-decision-tree) content.

Azure offers both CPU-based and GPU-enabled VMs. The N-series VMs feature NVIDIA GPUs that are designed for compute-intensive or graphics-intensive applications such as AI, learning, and visualization.

HPC SKUs are designed for high-performance scenarios. But other SKUs, such as the E and F series, are also suitable for certain workloads. To help ensure optimal performance, carefully evaluate your workload requirements and choose an appropriate VM size.

## Design considerations

When you design your HPC infrastructure, several tools and services are available to help you manage and schedule your workloads.

[Azure CycleCloud](/azure/cyclecloud/) is a tool for creating, managing, operating, and optimizing HPC and big compute clusters in Azure. With Azure CycleCloud, users can dynamically configure HPC Azure clusters and orchestrate data and jobs for hybrid and cloud workflows. Azure CycleCloud provides the simplest way to manage HPC workloads in Azure that involves using a workload manager. Azure CycleCloud supports workload managers such as Grid Engine, Microsoft HPC Pack, HTCondor, LSF, PBS Pro, SLURM, and Symphony.

### Manufacturing architecture design example

The following architecture provides an example of using VMs in HPC in manufacturing.

:::image type="content" alt-text="Architecture diagram that shows a manufacturing HPC workload that uses Azure CycleCloud and HC-series VMs." source="./media/hpc-manufacturing-architecture-example.svg" lightbox="./media/hpc-manufacturing-architecture-example.svg":::

This architecture uses Azure Files shares and Azure Storage accounts that are connected to an Azure Private Link subnet.

The architecture uses Azure CycleCloud its own subnet. HC-series VMs are used in an arrangement of cluster nodes.

The HC-series VMs are optimized for HPC applications that are driven by intensive computation. Examples include implicit finite element analysis, reservoir simulation, and computational chemistry applications. HC VMs feature 44 Intel Xeon Platinum 8168 processor cores, 8 GB of RAM per CPU core, no hyperthreading, and up to four managed disks. The Intel Xeon Platinum platform supports Intel's rich ecosystem of software tools and features and an all-cores clock speed of 3.4 GHz for most workloads.

For reference architectures and cookbooks for deploying HPC independent software vendor (ISV) applications that support manufacturing use cases, see the following resources:

- [Virtual machine series](https://azure.microsoft.com/pricing/details/virtual-machines/series/).
- [Azure HPC certification.github.io](https://azurehpc-certification.github.io/).
- [Microsoft Azure HPC OnDemand Platform](https://techcommunity.microsoft.com/t5/azure-global/azure-hpc-ondemand-platform-cloud-hpc-made-easy/ba-p/2537338). This standalone reference architecture might not be compliant with the Azure landing zone paradigm.

## Next steps

The following articles provide guidance for various stages of the cloud adoption process. These resources can help you succeed in adopting manufacturing HPC environments for the cloud.

- [Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Management](./management.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
