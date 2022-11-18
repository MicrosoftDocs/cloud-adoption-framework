---
title: Compute 
description: Learn about the Azure VM instances that are ideal for large-scale HPC application workloads in the oil and gas industry, plus HPC use cases, reference architecture, design considerations, and design recommendations.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/14/2022
---

# Compute

The term big compute (used in reference to HPC) describes large-scale workloads that require a large number of cores, often numbering in the hundreds or thousands. Scenarios include image rendering, fluid dynamics, financial risk modeling, oil exploration, drug design, and engineering stress analysis, among others.

The following are typical characteristics of big compute applications:

- The work can be split into discrete tasks, which can be run across many cores simultaneously.
- Each task is finite. It takes some input, does some processing, and produces output. The entire application runs for a finite amount of time (minutes to days). A common pattern is to set up many cores in a burst, and then spin down to zero once the application completes.
- The application doesn't need to stay up 24/7. But the system must handle node failures or application crashes.
- For some applications, tasks are independent and can run in parallel. In other cases, tasks are tightly coupled, meaning they must interact or exchange intermediate results. In that case, consider using high-speed networking technologies such as InfiniBand and remote direct memory access (RDMA).
- Depending on your workload, you might use compute-intensive VM sizes (H16r, H16mr, and A9).

:::image type="content" source="../media/tasks.png" alt-text="Diagram of Azure tasks." lightbox="../media/tasks.png":::

Azure offers a range of VM instances that are optimized for both CPU- and GPU-intensive workloads (both compute and visualization). The VMs are ideal for running oil and gas workloads.

Azure is the only cloud platform that offers VM instances with InfiniBand-enabled hardware. This feature provides a significant performance advantage for running reservoir simulation and seismic workloads. The improved performance narrows the performance gap and results in near or better performance than current on-premises infrastructures.

Azure VMs have many different options, known as VM sizes. There are different series of VM sizes for HPC and GPU-optimized computing. Select the appropriate VM size for the workload you want to use. For more information on selecting VM sizes, see the [Sizes for VMs in Azure selector tool](/azure/virtual-machines/sizes).

Not all Azure products are available in all Azure regions. For more information, see the current [list of products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

For best practices on your choices in Azure compute, see the [Azure compute blog](https://techcommunity.microsoft.com/t5/azure-compute-blog/bg-p/AzureCompute) or see the[Azure compute service](/azure/architecture/guide/technology-choices/compute-decision-tree) content to choose a service.

**CPU-based virtual machines**

- [Linux VMs](/azure/virtual-machines/linux/sizes-hpc)
- [Windows VMs](/azure/virtual-machines/windows/sizes-hpc)

**GPU-enabled virtual machines**

N-series VMs feature NVIDIA GPUs designed for compute-intensive or graphics-intensive applications including artificial intelligence (AI), learning, and visualization.

- [Linux VMs](/azure/virtual-machines/linux/sizes-gpu)
- [Windows VMs](/azure/virtual-machines/windows/sizes-gpu)

HPC SKUs are built specially for high-performance scenarios. But Azure also offers other SKUs that might be suitable for certain workloads you run on your HPC infrastructure. You can run these SKUs effectively on less expensive hardware. Some commonly used compute SKUs are the E and F series.

## HPC design considerations

[Job Scheduler](/azure/logic-apps/logic-apps-overview) is a specialized service for scheduling compute-intensive work to run on a managed pool of virtual machines. You can automatically scale compute resources to meet the needs of your jobs.

[Azure Batch](/azure/batch/) is a managed service for running large-scale HPC applications. Using Azure Batch, you configure a VM pool, and then you upload the applications and data files. Then the Batch service configures the VMs, assigns tasks to the VMs, runs the tasks, and monitors the progress. Batch can automatically scale VMs up and down in response to changing workloads. Batch also provides a job-scheduling functionality.

[Azure CycleCloud](/azure/cyclecloud/) is a tool for creating, managing, operating, and optimizing HPC and Big Compute clusters in Azure. With Azure CycleCloud, users can dynamically configure HPC Azure clusters and orchestrate data and jobs for hybrid and cloud workflows. Azure CycleCloud provides the simplest way to manage HPC workloads, by using various work load managers (such as Grid Engine, HPC Pack, HTCondor, LSF, PBS Pro, Slurm, or Symphony) on Azure.

## HPC design recommendations

- Both reservoir and seismic workflows typically have similar requirements for compute and job scheduling.
- While you consider your network needs, for the memory-intensive seismic imaging and reservoir simulations, Azure HPC offers HBv2 and HBv3 VM sizes.
- Use HB VMs for memory bandwidth-bound applications and HC VMs for compute-bound reservoir simulations.
- Use NV VMs for 3D reservoir modeling and visualizing seismic data.
- For GPU accelerated seismic FWI analysis, NCv4 is the recommended solution. For more data intensive RTM processing, the NDv4 SKU is the best option thanks to the availability of NVMe drives with a cumulative capacity of 7 TB. To get the best possible performance on HB series VMs with MPI workloads, do optimal process pinning to the processors' cores. For more information, see the [Optimal MPI process placement for Azure HB series VMs](https://techcommunity.microsoft.com/t5/azure-high-performance-computing/optimal-mpi-process-placement-for-azure-hb-series-vms/ba-p/2450663) blog post. Dedicated tools are also provided to ensure the correct pinning of parallel application processes as described here.
- Due to the complex architecture of NDv4 series VMs, be sure to pay particular attention when configuring the VMs to ensure you launch the GPU-accelerated applications optimally. For more information about Azure high-performance computing, see the [Azure scalable GPU VM](https://techcommunity.microsoft.com/t5/azure-high-performance-computing/azure-offers-the-most-scalable-gpu-vm-in-the-cloud-with-the-nd/ba-p/2524369) blog post.

## HPC reference architecture

The following are the use case and reference architectures for energy HPC environments.

### Oil and gas seismic and reservoir simulation reference architecture use cases

Commonly, both reservoir and seismic workflows have similar requirements for compute and job scheduling. However, seismic workloads challenge the infrastructure on storage with potentially multi-PB storage and throughput requirements that might be measured in the hundreds of GB. For example, a single seismic processing project might start with 500 TB of raw data, which requires potentially several PB of long-term storage. Following are a few reference architectures available today that can help you successfully meet your goals for running your application in Azure.

### Use case and reference architecture for seismic processing

Seismic processing and imaging are fundamental for the oil and gas business because they create a model of the subsurface out of the exploration data. The process of qualifying and quantifying what might be in the subsurface is typically conducted by geoscientists. Geoscientists use software that's often data center and cloud bound. Occasionally they access the software using virtual desktop technology remotely or in the cloud.

The quality of the subsurface model and the quality and resolution of the data is crucial to make the right business decisions regarding bidding on leases or deciding where to drill. Seismic image interpretation images can improve the position of wells and reduce the risk of drilling a “dry hole”. For oil and gas companies, having a better understanding of subsurface structures translates directly to reducing exploration risk. Basically, the higher the accuracy of the company’s view of the geological area, the better its chance of striking oil when it drills.

This job is data- and compute-intensive. The company needs to process terabytes of data, requiring massive and fast computation power, which includes fast networking. Due to the data- and computing-intensive nature of seismic imaging, companies use parallel computing to process data and reduce the time compilation and completion. Companies relentlessly process large volumes of seismic acquisition data to locate, accurately quantify, and qualify the hydrocarbon content in reservoirs discovered in the subsurface before recovery operations commence. As acquisition data is unstructured and can easily reach petabyte levels for one potential oil and gas field, seismic processing activity can only be completed within a meaningful timescale by using HPC and appropriate data management strategies.

:::image type="content" source="../media/network-interconnect.png" alt-text="Diagram of network interconnect compute and storage - seismic interpretation and modeling." lightbox="../media/network-interconnect.png":::

:::image type="content" source="../media/network-reference-architecture-seismic-processing.png" alt-text="Diagram of network reference architecture - seismic processing." lightbox="../media/network-reference-architecture-seismic-processing.png":::

### Use case and reference architecture for reservoir simulation and modeling

Reservoir modeling also places values on physical subsurface characteristics such as water saturation, porosity, and permeability. This data is important in determining what kind of recovery approach and equipment to deploy, and ultimately where best to position wells.

A reservoir modeling workload is also an area of reservoir engineering. The workload combines physics, mathematics, and computer programming in a reservoir model to analyze and predict fluid behavior in the reservoir over time. This analysis requires high computation power and typically big compute workload demands including fast networking.

:::image type="content" source="../media/network-reference-architecture-reservoir-simulation.png" alt-text="Diagram of network reference architecture - reservoir simulation." lightbox="../media/network-reference-architecture-reservoir-simulation.png":::

:::image type="content" source="../media/network-interconnect-compute-and-storage-seismic-analysis.png" alt-text="Diagram of network interconnect compute and storage seismic analysis." lightbox="../media/network-interconnect-compute-and-storage-seismic-analysis.png":::

For more information on reference architecture or cookbooks for relevant HPC ISV applications that support HPC for energy use cases, see:

- [Azure HPC certification.github.io](https://azurehpc-certification.github.io/)
- [Microsoft Azure HPC OnDemand Platform](https://techcommunity.microsoft.com/t5/azure-global/azure-hpc-ondemand-platform-cloud-hpc-made-easy/ba-p/2537338). Standalone reference architecture might not be compliant with the ALZ paradigm.


## Next steps

The following articles provide guidance on each step in the cloud adoption journey for energy HPC environments.

- [Azure billing and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Azure identity and access management for HPC in energy industries](./identity-access-management.md)
- [Management for HPC in energy industries](./management.md)
- [Network topology and connectivity for energy industries](./network-topology-connectivity.md)
- [Platform automation and DevOps for in energy industries](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance for HPC in energy industries](./security-governance-compliance.md)
- [Security for HPC in energy industries](./security.md)
- [Storage for HPC in energy industries](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)
