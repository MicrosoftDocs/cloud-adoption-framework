---
title: 'Compute | Microsoft Docs'
description: 'The term big compute (used in reference to HPC) describes large-scale workloads that require a large number of cores, often numbering in the hundreds or thousands.'
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 09/23/2022
---

# Compute

The term big compute (used in reference to HPC) describes large-scale workloads that require a large number of cores, often numbering in the hundreds or thousands. Scenarios include image rendering, fluid dynamics, financial risk modeling, oil exploration, drug design, and engineering stress analysis, among others.

Here are some typical characteristics of big compute applications:

 - The work can be split into discrete tasks, which can be run across many cores simultaneously.
 - Each task is finite. It takes some input, does some processing, and produces output. The entire application runs for a finite amount of time (minutes to days). A common pattern is to provision many cores in a burst, and then spin down to zero once the application completes.
 - The application does not need to stay up 24/7. However, the system must handle node failures or application crashes.
 - For some applications, tasks are independent and can run in parallel. In other cases, tasks are tightly coupled, meaning they must interact or exchange intermediate results. In that case, consider using high-speed networking technologies such as InfiniBand and remote direct memory access (RDMA).
 - Depending on your workload, you might use compute-intensive VM sizes (H16r, H16mr, and A9).

:::image type="content" alt-text="Azure tasks" source="../media/tasks.png" lightbox="../media/tasks.png":::

Azure offers a range of VM instances that are optimized for both CPU and GPU intensive workloads (both compute and visualization) that are greatly suitable for running Oil and Gas workloads.

Azure is the only cloud platform that offers VM instances with InfiniBand-enabled hardware. This provides a significant performance advantage for running some reservoir simulation and seismic workloads. This improved performance narrows the performance gap and gets to near or better performance than current on-premises infrastructures.

Azure VMs have many different options, called VM sizes. There are different series of VM sizes for HPC and VM sizes GPU-optimized computing. Select the appropriate VM size for the workload you want to use. For help with selecting sizes, see the VM selector tool.

Not all Azure products are available in all Azure regions. For more information, see the current list of products available by region.

For best practices on choices in Azure Compute, see Azure Compute Blog - Microsoft Tech Community and Choose an Azure compute service - Azure Architecture Center | Microsoft Docs

Azure offers a range of sizes that are optimized for both CPU and GPU intensive workloads.

**CPU-based virtual machines**

 - [Linux VMs](/azure/virtual-machines/linux/sizes-hpc)
 - [Windows VMs](/azure/virtual-machines/windows/sizes-hpc)

**GPU-enabled virtual machines**

N-series VMs feature NVIDIA GPUs designed for compute-intensive or graphics-intensive applications including artificial intelligence (AI) learning and visualization.

 - [Linux VMs](/azure/virtual-machines/linux/sizes-gpu)
 - [Windows VMs](/azure/virtual-machines/windows/sizes-gpu)

HPC SKUs have been built specially for high-performance scenarios. However, Azure also offers other SKUs that may be suitable for certain workloads you are running on your HPC infrastructure, which could be run effectively on less expensive hardware. Some compute SKUs commonly used are the E and F series.

## HPC Design Considerations:

Job Scheduler
Azure offers some specialized services that one can use to schedule compute-intensive work to run on a managed pool of virtual machines, and you can automatically scale compute resources to meet the needs of your jobs.

[Azure Batch](/azure/batch/) is a managed service for running large-scale HPC applications. Using Azure Batch, you configure a VM pool, and then you upload the applications and data files. Then the Batch service provisions the VMs, assigns tasks to the VMs, runs the tasks, and monitors the progress. Batch can automatically scale up/down the VMs in response to the changing workload. Batch also provides a job-scheduling functionality.

[Azure CycleCloud](/azure/cyclecloud/) is a tool for creating, managing, operating, and optimizing HPC and Big Compute clusters in Azure. With Azure CycleCloud, users can dynamically provision HPC Azure clusters and orchestrate data and jobs for hybrid and cloud workflows. Azure CycleCloud provides the simplest way to manage HPC workloads, by using various Work Load Managers (like Grid Engine, HPC Pack, HTCondor, LSF, PBS Pro, Slurm, or Symphony) on Azure.

## HPC Design Recommendations
 - Both Reservoir and Seismic workflows typically have similar requirements for compute and job scheduling. 
 - While considering network needs, for the memory-intensive seismic imaging and reservoir simulations Azure HPC offers HBv2 and HBv3 VM sizes. 
 - Use HB VMs for memory bandwidth-bound applications and HC VMs for compute-bound reservoir simulations. 
 - Use NV VMs for 3D reservoir modeling and visualizing seismic data.
 - For GPU accelerated seismic FWI analysis NCv4 is the recommended solution. For more data intensive RTM processing the NDv4 SKU is the best option thanks to the availability of NVMe drives with a cumulative capacity of 7TB.To obtain the best possible performance on HB series VMs with MPI workloads optimal process pinning to the processors cores must be ensured. Refer to the Optimal MPI Process Placement for Azure HB Series VMs blog post for guidance. Dedicated tools are also provided to ensure the correct pinning of parallel application processes as described here.
 - Due to the complex architecture of NDv4 series VMs, particular attention must be observed to ensure the VMs are correctly configured to ensure the optimal execution of GPU accelerated applications. Please refer to this blog post for additional details.

## HPC Reference Architecture

### Oil and Gas Seismic and Reservoir Simulation Reference Architecture Use Cases:

From our experience, both Reservoir and Seismic workflows typically have similar requirements for compute and job scheduling. However, Seismic workloads challenge the infrastructure on storage with possibly multi-PB storage requirements (a single seismic processing project may start with 500 TB of raw data, which requires a total of several PBs of long-term storage) and throughput requirements that may be measured in 100's of GB/s. We will share below a few reference architectures we have today so you can successfully meet the goals for running your application in Azure.

### Use Case and Reference Architecture for Seismic Processing:

Use case description:

Seismic processing/imaging is fundamental for the oil and gas business as it creates a model of the subsurface out of the exploration data. The process of qualify and quantifying what may be in the subsurface is typically conducted by geoscientists using software that is often data center / cloud bound and occasionally accessible remotely using virtual desktop technology remotely or alternatively in the cloud. 

The quality of the subsurface model and the quality & resolution of the data is crucial to make the right business decision regarding bidding on leases or deciding where to drill. Seismic image interpretation images can improve the position of wells and reduce the risk of drilling a “dry hole”. For oil and gas companies, having a better understanding of subsurface structures translates directly to reducing exploration risk. Basically, the higher the accuracy of the company’s view of the geological area, the better its chance of striking oil when it drills. This job is very data- and compute-intensive which needs to process terabytes of data and requires massive and fast computation power including fast networking.  Due to the data/computing intensive nature of seismic imaging, parallel computing is used to process data to reduce the time compilation and completion. Large volumes of seismic acquisition data are processed relentlessly in an attempt to locate, accurately quantify and qualify the hydrocarbon content in reservoirs discovered in the subsurface before recovery operations commence. As acquisition data is mainly unstructured and can easily reach petabyte levels for one potential oil and gas field, seismic processing activity can only be completed within a meaningful timescale by using HPC and appropriate data management strategies.

:::image type="content" alt-text="Network interconnect Compute and Storage - Seismic Interpretation and Modeling" source="../media/network-interconnect.png" lightbox="../media/network-interconnect.png":::

:::image type="content" alt-text="Network Reference Architecture - Seismic Processing" source="../media/network-reference-architecture-seismic-processing.png" lightbox="../media/network-reference-architecture-seismic-processing.png":::

### Use Case and Reference Architecture for Reservoir Simulation/Modeling:

Use case description:

Reservoir Modeling also places values on physical subsurface characteristics such as water saturation, porosity and permeability, which are important in determining what kind of recovery approach and equipment to deploy, and ultimately where to optimally position wells.

Reservoir Modeling workload is also an area of Reservoir Engineering, that, combining Physics, Mathematics, and Computer Programming to a reservoir model – which allows the analysis and the prediction of the fluid behavior in the reservoir over time. This requires high computation power and typical big compute workload needs including fast networking.

:::image type="content" alt-text="Network Reference Architecture: Reservoir Simulation" source="../media/network-reference-architecture-reservoir-simulation.png" lightbox="../media/network-reference-architecture-reservoir-simulation.png":::

:::image type="content" alt-text="Network Interconnect Compute and Storage Seismic Analysis" source="../media/network-interconnect-compute-and-storage-seismic-analysis.png" lightbox="../media/network-interconnect-compute-and-storage-seismic-analysis.png":::

For more information on ref architecture or cookbooks for relevant HPC ISV applications supporting HPC for Energy use cases, see

 - [Azure HPC | HOME (azurehpc-certification.github.io)](https://azurehpc-certification.github.io/)
 - [Microsoft Azure HPC OnDemand Platform | Cloud HPC made easy](https://techcommunity.microsoft.com/t5/azure-global/azure-hpc-ondemand-platform-cloud-hpc-made-easy/ba-p/2537338) (standalone ref arch may not be compliant with ALZ paradigm)

## Next steps
The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario for energy HPC environments.
- [Azure billing active directory tenant](./azure-billing-active-directory-tenant.md)
- [Identity Access Management](./identity-access-management.md)
- [Management](./management.md)
- [Network Topology Connectivity](./network-topology-connectivity.md)
- [Platform Automation DevOps](./platform-automation-devops.md)
- [Resource Organization](./resource-organization.md)
- [Governance for HPC in energy industries](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- Back to [landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)


