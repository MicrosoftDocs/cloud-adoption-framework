---
title: Compute Large-Scale HPC Application Workloads in Azure Virtual Machines
description: Learn about the ideal Azure VM instances for large-scale HPC application workloads, use cases, reference architecture, and design considerations and recommendations.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.custom: think-tank
ms.date: 11/14/2024
---

# Compute large-scale HPC application workloads in Azure Virtual Machines

High-performance computing (HPC) workloads, also known as big compute applications, are large-scale workloads that require many cores. HPC can help industries like energy, finance, and manufacturing at every stage of the product development process. 

Big compute applications typically have the following characteristics:

- You can divide the workload into discrete tasks that can be run simultaneously across many cores.
- Each task takes input, processes it, and produces output. The entire application runs for a finite amount of time.
- The application doesn't need to run constantly, but it must be able to handle node failures and crashes.
- Tasks can be independent or tightly coupled, which requires high-speed networking technologies like InfiniBand and remote direct memory access (RDMA) connectivity.
- You can use compute-intensive virtual machine (VM) sizes such as H16r, H16mr, and A9. Your selection depends on the workload.

:::image type="content" source="./media/tasks.png" alt-text="Diagram that shows how a job queue moves from the client to the scheduler and the parallel and tightly coupled Azure tasks." lightbox="./media/tasks.png" border="false":::

Azure provides a range of VM instances that are optimized for CPU-intensive and GPU-intensive workloads. These VMs can run in Azure Virtual Machine Scale Sets to provide resiliency and load balancing. Azure is also the only cloud platform that offers InfiniBand-enabled hardware. InfiniBand provides a significant performance advantage for tasks such as financial risk modeling, engineering stress analysis, and running reservoir simulation and seismic workloads. This advantage results in performance that approaches or exceeds current on-premises infrastructure performance.

Azure provides various VM sizes for HPC and GPU-optimized computing. It's important to select a VM size that's appropriate for your workload. To find the best fit, see [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes) and [Virtual machines selector tool](https://azure.microsoft.com/pricing/vm-selector/).

Keep in mind that not all Azure products are available in all regions. To see what's available in your area, see [Products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

For more information about Azure compute options, see the [Azure compute blog](https://techcommunity.microsoft.com/t5/azure-compute-blog/bg-p/AzureCompute) or [Choose an Azure compute service](/azure/architecture/guide/technology-choices/compute-decision-tree).

Azure provides both CPU-based and GPU-enabled VMs. The N-series VMs feature NVIDIA GPUs that are designed for compute-intensive or graphics-intensive applications such as AI, learning, and visualization. 

HPC products are designed for high-performance scenarios. But other products, such as the E and F series, are also suitable for specific workloads.

## Design considerations

When you design your HPC infrastructure, several tools and services are available to help you manage and schedule your workloads.

- [Azure Batch](/azure/batch/) is a managed service for running large-scale HPC applications. Use Batch to configure a VM pool and upload the applications and data files. Then the Batch service configures the VMs, assigns tasks to the VMs, runs the tasks, and monitors progress. Batch can automatically scale VMs up and down in response to changing workloads. Batch also provides a job-scheduling functionality.

- [Azure CycleCloud](/azure/cyclecloud/) is a tool for creating, managing, operating, and optimizing HPC and big compute clusters in Azure. Use Azure CycleCloud to dynamically configure HPC Azure clusters and orchestrate data and jobs for hybrid and cloud workflows. Azure CycleCloud provides the simplest way to manage HPC workloads by using a workload manager. Azure CycleCloud supports workload managers such as Grid Engine, Microsoft HPC Pack, HTCondor, LSF, PBS Pro, SLURM, and Symphony.

- [Azure Logic Apps](/azure/logic-apps/logic-apps-overview) is a specialized service for scheduling compute-intensive work to run on a managed pool of VMs. You can automatically scale compute resources to meet your jobs' needs.

The following sections describe reference architectures for the energy, finance, and manufacturing industries.

## Energy reference architecture

Consider the following recommendations and use cases when you design an architecture for energy workloads.

### Design recommendations

- Understand that reservoir and seismic workflows typically have similar requirements for compute and job scheduling.

- Consider your network needs. Azure HPC provides HBv2 and HBv3-series VM sizes for memory-intensive seismic imaging and reservoir simulations.

- Use HB-series VMs for memory bandwidth-bound applications and HC-series VMs for compute-bound reservoir simulations.

- Use NV-series VMs for 3D reservoir modeling and visualizing seismic data.

- Use NCv4-series VMs for GPU-accelerated seismic full-waveform inversion (FWI) analysis. 

   For data-intensive resin transfer molding (RTM) processing, the NDv4 VM size is the best option because it provides Non-Volatile Memory Express (NVMe) drives that have a cumulative capacity of 7 TB. 
   
   To get the best possible performance on HB-series VMs with Message Passing Interface (MPI) workloads, do optimal process pinning to the processors' cores. For more information, see [Optimal MPI process placement for Azure HB-series VMs](https://techcommunity.microsoft.com/t5/azure-high-performance-computing/optimal-mpi-process-placement-for-azure-hb-series-vms/ba-p/2450663). 
   
   NCv4-series VMs also provide dedicated tools to ensure the correct pinning of parallel application processes.

- Because of the complex architecture of NDv4-series VMs, pay attention when you configure the VMs to ensure that you launch the GPU-accelerated applications optimally. For more information, see [Azure scalable GPU VM](https://techcommunity.microsoft.com/t5/azure-high-performance-computing/azure-offers-the-most-scalable-gpu-vm-in-the-cloud-with-the-nd/ba-p/2524369).

### Use cases for the oil and gas seismic and reservoir simulation reference architecture

Reservoir and seismic workflows usually have similar requirements for compute and job scheduling. However, seismic workloads challenge the infrastructure's storage capabilities. They sometimes need multiple PBs of storage and throughput requirements that might be measured in hundreds of GBs. For example, a single seismic processing project might start with 500 TB of raw data, which requires potentially several PBs of long-term storage.

See the following reference architectures that can help you successfully meet your goals for running your application in Azure.

#### Reference architecture for seismic processing

Seismic processing and imaging are fundamental for the oil and gas industry because they create a model of the subsurface based on the exploration data. Geoscientists typically conduct the process of qualifying and quantifying what might be in the subsurface. Geoscientists usually use datacenter and cloud-bound software. Occasionally they access the software remotely or in the cloud by using virtual desktop technology.

The quality of the subsurface model and the quality and resolution of the data is crucial to make the right business decisions about bidding on leases or deciding where to drill. Seismic image interpretation images can improve the position of wells and reduce the risk of drilling a *dry hole*. For oil and gas companies, having a better understanding of subsurface structures translates directly to reducing exploration risk. Basically, the higher the accuracy of the company's view of the geological area, the better its chance of striking oil when it drills.

This job is data and compute-intensive. The company needs to process TBs of data. This data processing requires massive and fast computation power, which includes fast networking. Because of the data and computing-intensive nature of seismic imaging, companies use parallel computing to process data and reduce the time to compilation and completion. 

Companies relentlessly process large volumes of seismic acquisition data to locate and accurately quantify and qualify the hydrocarbon content in reservoirs that they discover in the subsurface before they begin recovery operations. Acquisition data is unstructured and can easily reach PBs of storage for one potential oil and gas field. Because of these factors, you can only complete seismic processing activity within a reasonable timeframe by using HPC and other appropriate data management strategies.

:::image type="content" source="./media/network-interconnect.png" alt-text="Diagram of the network interconnect compute and storage for seismic interpretation and modeling." lightbox="./media/network-interconnect.png" border="false":::

:::image type="content" source="./media/network-reference-architecture-seismic-processing.png" alt-text="Diagram of the network reference architecture for seismic processing." lightbox="./media/network-reference-architecture-seismic-processing.png" border="false":::

#### Reference architecture for reservoir simulation and modeling

Physical subsurface characteristics, such as water saturation, porosity, and permeability, are also valuable data in reservoir modeling. This data is important to determine what kind of recovery approach and equipment to deploy and, ultimately, where to position wells.

A reservoir modeling workload is also an area of reservoir engineering. The workload combines physics, mathematics, and computer programming in a reservoir model to analyze and predict fluid behavior in the reservoir over time. This analysis requires high computation power and big compute workload demands, including fast networking.

:::image type="content" source="./media/network-reference-architecture-reservoir-simulation.png" alt-text="Diagram of the network reference architecture for reservoir simulation." lightbox="./media/network-reference-architecture-reservoir-simulation.png" border="false":::

:::image type="content" source="./media/network-interconnect-compute-and-storage-seismic-analysis.png" alt-text="Diagram of the network interconnect compute and storage seismic analysis." lightbox="./media/network-interconnect-compute-and-storage-seismic-analysis.png" border="false":::

## Finance reference architecture

The following architecture is an example of how to use VMs in HPC for finance workloads.

:::image type="content" alt-text="Architecture diagram that shows a finance HPC workload that uses HPC Pack HB-series VMs." source="./media/hpc-finance-architecture-example.svg" lightbox="./media/hpc-finance-architecture-example.svg" border="false":::

This workload uses HPC Pack HB-series compute nodes.

The [HB-series VMs](/azure/virtual-machines/hb-series) are optimized for HPC applications, such as financial analysis, weather simulation, and silicon register-transfer level (RTL) modeling. HB VMs feature:

- Up to 120 AMD EPYC™ 7003-series CPU cores.
- 448 GB of RAM.
- No hyperthreading.

HB-series VMs also provide:

- 350 GB per second of memory bandwidth.
- Up to 32 MB of L3 cache per core.
- Up to 7 GB per second of block device solid-state drive (SSD) performance.
- Clock frequencies of up to 3.675 GHz.

For the HPC head node, the workload uses a different-sized VM. Specifically, it uses a D16s_v4 VM, a type of general-purpose product.

## Manufacturing reference architecture

The following architecture is an example of how to use VMs in HPC in manufacturing.

:::image type="content" alt-text="Architecture diagram that shows a manufacturing HPC workload that uses Azure CycleCloud and HC-series VMs." source="./media/hpc-manufacturing-architecture-example.svg" lightbox="./media/hpc-manufacturing-architecture-example.svg" border="false":::

This architecture uses Azure Files shares and Azure Storage accounts that are connected to an Azure Private Link subnet.

The architecture uses Azure CycleCloud in its own subnet. HC-series VMs are used in an arrangement of cluster nodes.

The HC-series VMs are optimized for HPC applications that use intensive computation. Examples include implicit and finite element analysis, reservoir simulation, and computational chemistry applications. HC VMs feature 44 Intel Xeon Platinum 8168 processor cores, 8 GB of RAM per CPU core, no hyperthreading, and up to four managed disks. The Intel Xeon Platinum platform supports Intel's rich ecosystem of software tools and features and an all-cores clock speed of 3.4 GHz for most workloads.

## Next steps

For more information about applications that support the use cases in this article, see the following resources:

- [Virtual machine series](https://azure.microsoft.com/pricing/details/virtual-machines/series/).
- [Azure HPC certification.github.io](https://github.com/AzureHPC-Certification/AzureHPC-Certification.github.io/).
- [Microsoft Azure HPC OnDemand Platform](https://techcommunity.microsoft.com/t5/azure-global/azure-hpc-ondemand-platform-cloud-hpc-made-easy/ba-p/2537338). This standalone reference architecture might not be compliant with the Azure landing zone paradigm.

The following articles provide guidance for various stages of the cloud adoption process. These resources can help you succeed in adopting manufacturing HPC environments for the cloud.

- [Identity and access management](./identity-access-management.md)
- [Network topology and connectivity](./network-topology-connectivity.md)
- [Resource organization](./resource-organization.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](./azure-hpc-landing-zone-accelerator.md)
- [Spot virtual machines](/azure/architecture/guide/spot/spot-eviction)