---
title: The Azure Well-Architected Framework for HPC
description: #Use the Azure Well-Architected Framework architecture principles to design and optimize workloads running in your scenario.
author: {{Token-ContributorGithubId}}
ms.author: {{Token-Alias}}
ms.date: {{Token-Date}}
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# The Azure Well-Architected Framework for HPC

The [Plan methodology of this scenario](./plan.md) outlines a process for you to rationalize your scenario, prioritize technical efforts, and identify workloads. For many of the named workloads, it's important to adhere to a set of architectural principles. These principles help guide development and optimization of the workloads. The five architectural constructs are detailed in the [Azure Well-Architected Framework](/azure/architecture/framework/). This guidance provides a summary of how you can apply these principles to the management of your data workloads.

## Reliability

Describe the ability of a system to recover from failures and continue to function.

Everything has the potential to break and data pipelines are no exception. Because of this, great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change, and how quickly you can resume operations.

Your data environment should consider resilient architectures, cross region redundancies, service level, service-level agreements (SLAs), and critical support. The existing environment should also include auditing, monitoring, and alerting by using integrated monitoring and a notification framework.

On top of these environmental controls, the workload team should consider:

- More architecture modification to improve service level SLAs
- Redundancy of workload-specific architecture
- Processes for monitoring and notification beyond what is provided by the cloud operations teams

## Security

Describe how you will protect applications and data from threats.

## Cost optimization

The following measures would be helpful in cost optimisation of the HPC workloads

### Choice of Operating System: 
Linux has been the dominant operating system when it comes to HPC workloads. Linux is open-source, tuned for performance to leverage the HPC infrastructure, thus the MPI libraries and Infiniband drivers work very well on Linux vs. Windows. Thereby leveraging Linux VMs over Windows for setting up a HPC cluster would definitely save costs. However, it is understandable that some users may have a strong preference for a Windows environment especially while doing the pre/post processing tasks in workload such as Computational Fluid Dynamics. In such a case the recommendation is to have a Windows Front End submitting jobs to a Linux host (Head Node) which can leverage the compute nodes for simulations. 

### Auto Scaling: 
Autoscaling is a capability to provision and utilise the VMs only when the job is submitted/active. Once the job is complete the nodes turn off automatically. Azure CycleCloud has built in autoscaling turned on in its schedulers by default. The default time limit to switch the nodes off is 15 minutes and can be customised. This ensures that the users pay only for what they use. Azure batch, on the other hand, provides the user a mechanism to integrate an autoscaling formula with the choice of parameters.     

### PAYG vs Reserved vs Spot Instance: 
Azure provides various pricing options namely, Pay As You Go (PAYG), Reserved Instance with 1 or 3 year options, Spot Instances subject to the capacity available in the Data center. PAYG instances are cost effective to cater sporadic demand for capacity and Reserved Instances could prove cost effective if either there is a continuous demand for HPC or there are many applications to run on Azure HPC. Both are good fit for production ready workloads. Spot instances, on the other hand are good for brief testing and experimentation or if your application suits checkpointing, e.g, Genomics. Spot instances are subject to the capacity available in the data centre and the pricing changes and based on these factors the spot instances can be evicted with minimum notice. 

### Data Classification: 
HPC workloads benefit from high throughput storage, e.g., Azure Managed Lustre, Azure Net App Files, BeeGFS Parallel File System, etc. These storage services do deliver the performance and may come at a cost. It is important to have data classified before hand such that only application-specific data reside in these systems. All other data can reside in low cost storages such as Azure Data Lake or Blob. Further, it might be useful to provision HPC storage systems on demand making sure the data is synced to low cost storage service like Azure Blob Storage. This will ensure data is retained in Azure Blob when the high performance storage system is turned off. Azure Managed Lustre and Azure Net App Files do offer a sync service. 

### Set Budgets
Azure CycleCloud allows you to set budgets per cluster and can send notifications to the recipients if they are close to exhaust the budgets. For Azure batch, you can create budgets and spending alerts for your Batch pools or Batch accounts from the Azure portal. Budgets and alerts are useful for notifying stakeholders of any risks of overspending, although it's possible for there to be a delay in spending alerts and to slightly exceed a budget.


## Operational excellence

Outline the operations processes that keep a system running in production.

## Performance Efficiency

### Choosing the right platform for the HPC application
Azure offers a range of platforms for Virtual Machines based on Intel, AMD CPU and/or NVIDIA, AMD GPU. While most of the applications are compatible with what is available, there are some which only benefit from a particular type of CPU and/or GPU. Before deploying the infrastructure on cloud it is important to have a recommendation from the application vendor (ISV) to understand 
(a) Whether the application is memory bound, CPU bound or GPU bound. 
(b) Whether they have any recommendation on any type of CPU/GPU architecture for performance
(c) The type of MPI and its version their application can benefit from
(d) The recommendation on the scheduler type.
(e) Their recommendation on the IOPS/throughput from the Parallel File Systems, if any. 

### Invest in capacity planning: 
Based on the type of the application and its license conditions, investigate whether the license is locked to use a specific number of cores and thereby assess your investment to enable the license to cater for HPC and plan the capacity accordingly. 

### Monitor the performance of infrastructure: 
Azure monitor is a great tool to identify if there are any bottlenecks in the VM instances and storage. Azure Storage services offer the read/write operations graphs to monitor if there are any issues pertaining to throttling. This happens when Input Output Operations within Storage exceed the throughput limits set. Storage throttling can cause application to slow down substantially therby affecting performance. 

## Next steps

[Introduction to architectures for HPC](./index.md)
