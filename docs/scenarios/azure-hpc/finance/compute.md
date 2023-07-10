---
title: 'Compute large-scale HPC application workloads in Azure VMs'
description: Learn about the Azure VM instances that are ideal for large-scale HPC application workloads in the oil and gas industry, plus HPC use cases, reference architecture, design considerations, and design recommendations.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
ms.date: 11/14/2022
---

# Compute large-scale HPC application workloads in Azure VMs

The term big compute (used in reference to HPC) describes large-scale workloads that require a large number of cores, often numbering in the hundreds or thousands. Scenarios include image rendering, fluid dynamics, financial risk modeling, oil exploration, drug design, and engineering stress analysis, among others.

The following are typical characteristics of big compute applications:

- The work can be split into discrete tasks, which can be run across many cores simultaneously.
- Each task is finite. It takes some input, does some processing, and produces output. The entire application runs for a finite amount of time (minutes to days). A common pattern is to set up many cores in a burst, and then spin down to zero once the application completes.
- The application doesn't need to stay up 24/7. But the system must handle node failures or application crashes.
- For some applications, tasks are independent and can run in parallel. In other cases, tasks are tightly coupled, meaning they must interact or exchange intermediate results. In that case, consider using high-speed networking technologies such as InfiniBand and remote direct memory access (RDMA).
- Depending on your workload, you might use compute-intensive VM sizes (H16r, H16mr, and A9).

:::image type="content" source="../media/tasks.png" alt-text="Diagram of Azure tasks." lightbox="../media/tasks.png":::

Azure offers a range of VM instances that are optimized for both CPU- and GPU-intensive workloads (both compute and visualization).

Azure is the only cloud platform that offers VM instances with InfiniBand-enabled hardware. This feature provides a significant performance advantage for running reservoir simulation and seismic workloads. The improved performance narrows the performance gap and results in near or better performance than current on-premises infrastructures.

Azure VMs have many different options, known as VM sizes. There are different series of VM sizes for HPC and GPU-optimized computing. Select the appropriate VM size for the workload you want to use. For more information on selecting VM sizes, see the [Sizes for VMs in Azure selector tool](/azure/virtual-machines/sizes).

Not all Azure products are available in all Azure regions. For more information, see the current [list of products available by region](https://azure.microsoft.com/explore/global-infrastructure/products-by-region/).

For best practices on your choices in Azure compute, see the [Azure compute blog](https://techcommunity.microsoft.com/t5/azure-compute-blog/bg-p/AzureCompute) or see the [Azure compute service](/azure/architecture/guide/technology-choices/compute-decision-tree) content to choose a service.

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

For more information on reference architecture or cookbooks for relevant HPC ISV applications that support HPC for manufacturing use cases, see:

- [Azure HPC certification.github.io](https://azurehpc-certification.github.io/)
- [Microsoft Azure HPC OnDemand Platform](https://techcommunity.microsoft.com/t5/azure-global/azure-hpc-ondemand-platform-cloud-hpc-made-easy/ba-p/2537338). Standalone reference architecture might not be compliant with the ALZ paradigm.

## Next steps

The following articles provide guidance that you might find helpful during various stages of the cloud adoption process. They can help you succeed in your cloud adoption scenario for HPC environments in the finance sector.

- [Azure billing offers and Active Directory tenants](./azure-billing-active-directory-tenant.md)
- [Identity and access management](./identity-access-management.md)
- [Management](./management.md)
- [Platform automation and DevOps](./platform-automation-devops.md)
- [Resource organization](./resource-organization.md)
- [Governance](./security-governance-compliance.md)
- [Security](./security.md)
- [Storage](./storage.md)
- [HPC landing zone accelerator](../azure-hpc-landing-zone-accelerator.md)