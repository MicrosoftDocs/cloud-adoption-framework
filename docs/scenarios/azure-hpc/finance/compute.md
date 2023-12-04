---
title: Large-scale finance HPC workloads on Azure VMs
description: See the optimized virtual machine (VM) sizes that Azure offers for CPU-intensive and GPU-intensive finance workloads, including InfiniBand-enabled hardware.
author: bsantacruz
ms.author: bsantacruz
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 10/17/2023
---

# Run large-scale HPC application workloads for the finance industry on Azure virtual machines

High-performance computing (HPC) workloads, also known as big compute applications, require many cores. These workloads can include tasks such as financial risk modeling and engineering stress analysis.

Big compute applications typically have the following characteristics:

- The workload can be divided into discrete tasks that can be run simultaneously across many cores.
- Each task takes input, processes it, and produces output. The entire application runs for a finite amount of time.
- The application doesn't need to run constantly, but it must be able to handle node failures and crashes.
- Tasks can be independent or tightly coupled, requiring high-speed networking technologies like InfiniBand and remote direct memory access (RDMA) connectivity.
- Compute-intensive virtual machine (VM) sizes such as H16r, H16mr, and A9 can be used. The selection depends on the workload.

Azure offers a range of VM instances that are optimized for CPU-intensive and GPU-intensive workloads. These VMs can run in Azure Virtual Machine Scale Sets to provide resiliency and load balancing. Azure is also the only cloud platform that offers InfiniBand-enabled hardware. InfiniBand provides a significant performance advantage for tasks such as financial risk modeling and engineering stress analysis. This advantage results in performance that approaches or exceeds current on-premises infrastructure performance.

Azure VMs offer various options, known as VM sizes, for HPC and GPU-optimized computing. It's important to select a VM size that's appropriate for your workload. To find the size that's the best fit, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes). Also see the selector tool in [Virtual machines selector](https://azure.microsoft.com/pricing/vm-selector/).

Keep in mind that not all Azure products are available in all regions. To see what's available in your area, see [Products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

For best practices for choosing Azure compute options, see the [Azure compute blog](https://techcommunity.microsoft.com/t5/azure-compute-blog/bg-p/AzureCompute) or the [Azure compute service](/azure/architecture/guide/technology-choices/compute-decision-tree) content.

Azure offers both CPU-based and GPU-enabled VMs. The N-series VMs feature NVIDIA GPUs that are designed for compute-intensive or graphics-intensive applications such as AI, learning, and visualization.

HPC SKUs are designed for high-performance scenarios. But other SKUs, such as the E and F series, are also suitable for certain workloads.

## Design considerations

When you design your HPC infrastructure, several tools and services are available to help you manage and schedule your workloads.

[Azure CycleCloud](/azure/cyclecloud/) is a tool for creating, managing, operating, and optimizing HPC and big compute clusters in Azure. With Azure CycleCloud, users can dynamically configure HPC Azure clusters and orchestrate data and jobs for hybrid and cloud workflows. Azure CycleCloud provides the simplest way to manage HPC workloads in Azure that involves using a workload manager. Azure CycleCloud supports workload managers such as Grid Engine, Microsoft HPC Pack, HTCondor, LSF, PBS Pro, SLURM, and Symphony.

### Finance architecture design example

The following architecture provides an example of using VMs in HPC for finance workloads.

:::image type="content" alt-text="Architecture diagram that shows a finance HPC workload that uses HPC Pack HB-series VMs." source="./media/hpc-finance-architecture-example.svg" lightbox="./media/hpc-finance-architecture-example.svg":::

This workload uses HPC Pack HB-series compute nodes.

The [HB-series VMs](/azure/virtual-machines/hb-series) are optimized for HPC applications, such as financial analysis, weather simulation, and silicon register-transfer level (RTL) modeling. HB VMs feature up to 120 AMD EPYC™ 7003-series CPU cores, 448 GB of RAM, and no hyperthreading. HB-series VMs also provide 350 GB/sec of memory bandwidth, up to 32 MB of L3 cache per core, up to 7 GB/s of block device solid-state drive (SSD) performance, and clock frequencies of up to 3.675 GHz.

For the HPC head node, the workload uses a different sized VM. Specifically, it uses a D16s_v4 VM, a type of general purpose SKU.

For reference architectures and cookbooks for deploying HPC independent software vendor (ISV) applications that support use cases in the finance sector, see the following resources:

- [Virtual machine series](https://azure.microsoft.com/pricing/details/virtual-machines/series/).
- [Azure HPC certification.github.io](https://azurehpc-certification.github.io/).
- [Microsoft Azure HPC OnDemand Platform](https://techcommunity.microsoft.com/t5/azure-global/azure-hpc-ondemand-platform-cloud-hpc-made-easy/ba-p/2537338). This standalone reference architecture might not be compliant with the Azure landing zone paradigm.

## Next steps

The following articles provide guidance for various stages of the cloud adoption process. These resources can help you succeed in adopting finance sector HPC environments for the cloud.

- [Azure billing offers and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
- [Spot virtual machines](/azure/architecture/guide/spot/spot-eviction)
