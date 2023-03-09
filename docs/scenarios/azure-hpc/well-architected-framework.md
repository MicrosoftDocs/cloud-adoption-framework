---
title: The Azure Well-Architected Framework for HPC
description: Use the Azure Well-Architected Framework architecture principles to design and optimize workloads running in your HPC scenario.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 10/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# The Azure Well-Architected Framework for HPC

The [Plan methodology of this scenario](./plan.md) outlines a process for you to rationalize your scenario, prioritize technical efforts, and identify workloads. For many of the named workloads, it's important to adhere to a set of architectural principles. These principles help guide development and optimization of the workloads. The five architectural constructs are detailed in the [Azure Well-Architected Framework](/azure/architecture/framework/). This guidance provides a summary of how you can apply these principles to the management of your data workloads.

## Reliability

Everything has the potential to break and data pipelines are no exception. Because of this, great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change, and how quickly you can resume operations.

Your data environment should consider resilient architectures, cross region redundancies, service level, service-level agreements (SLAs), and critical support. The existing environment should also include auditing, monitoring, and alerting by using integrated monitoring and a notification framework.

On top of these environmental controls, the workload team should consider:

- More architecture modification to improve service level SLAs
- Redundancy of workload-specific architecture
- Processes for monitoring and notification beyond what is provided by the cloud operations teams

## Security

Apply security principles to your HPC environment to provide assurances against deliberate attacks and abuse of your valuable data and systems. Look into securing your user operating system images, user access, and follow Batch and CycleCloud security guidelines. For more suggestions, see [Principles of the security pillar](/azure/architecture/framework/security/security-principles).

### Operating system images

Azure Marketplace provides Linux based HPC images to use in the cluster. These images come packed with popular InfiniBand-based MPI libraries, Mellanox OFED, Preconfigured IP over InfiniBand, Communication Runtimes, Intel/AMD Optimized libraries, Azure HPC diagnostic tools, etc. Users can start with these images and then apply their organization's security hardening policies to strengthen software images against vulnerabilities and cyber threats. Upon hardening, the new image can be saved in Azure's Image Gallery to be utilized to create the Virtual Machines within Azure's HPC Cluster orchestrator service, Azure CycleCloud and Azure HPC Service, Azure Batch.

### User access

- Define clear lines of responsibility and separation of duties for each function.
- Restrict access based on a need-to-know basis and least privilege security principles.
- Assign permissions to users, groups, and applications at a certain scope through Azure RBAC. Use built-in roles when possible.
- Prevent deletion or modification of a resource, resource group, or subscription through management locks.
- Use Managed Identities to access resources in Azure.
- Support a single enterprise directory. Keep the cloud and on-premises directories synchronized, except for critical-impact accounts.
- Set up Azure AD Conditional Access. Enforce and measure key security attributes when authenticating all users, especially for critical-impact accounts.
- Preferably use passwordless methods or opt for modern password methods.
- Block legacy protocols and authentication methods.

### Azure batch security

Follow the best practices to enable security for [Azure batch](/azure/batch/security-best-practices)

### Azure CycleCloud security

Follow the best practices to enable security for [Azure CycleCloud](/azure/cyclecloud/concepts/security-best-practices)

## Cost optimization

To make the most out of running your environment in Azure, you must first prioritize cost management and upfront planning exercises. These are the most pivotal for a successful cloud migration and journey for almost any organization. [Azure Cost Management](/azure/cost-management-billing) gives you the tools to plan for, analyze and reduce your spending to maximize your cloud investment. An extensive list of ways you can optimize and plan your cloud spent can be found [here](/azure/cost-management-billing/costs/cost-mgt-best-practices) But, for the purposes of discussion, let’s call out a few important ones
here:

The following measures would be helpful in cost optimization of the HPC workloads

### Choice of operating system

Linux has been the dominant operating system for HPC workloads. Linux is open-source, tuned for performance to leverage the HPC infrastructure, thus the MPI libraries and Infiniband drivers work well on Linux vs. Windows. Thereby using Linux VMs over Windows for setting up an HPC cluster would definitely save costs. However, it's understandable that some users may have a strong preference for a Windows environment especially while doing the pre/post processing tasks in workload such as Computational Fluid Dynamics. In such a case, the recommendation is to have a Windows Front End submitting jobs to a Linux host (Head Node) which can use the compute nodes for simulations.

### Autoscaling

Autoscaling is a capability to provision and utilize the VMs only when the job is submitted/active. Once the job is complete the nodes turn off automatically. Using Autoscaling allows you to adjust compute resources used by your application, potentially saving you time and money. Azure CycleCloud has built in autoscaling turned on in its schedulers by default. The default time limit to switch off the nodes is 15 minutes and can be customized. This ensures that the users pay only for what they use. Azure batch, on the other hand, provides the user a mechanism to integrate an autoscaling formula with the choice of parameters.   For more details, see [here](/azure/azure-monitor/autoscale/autoscale-get-started).

### PAYG vs Reserved vs Spot Instance

Azure provides various pricing options namely, Pay As You Go (PAYG), Reserved Instance with 1 or 3 year options, Spot Instances subject to the capacity available in the Data center. PAYG instances are cost effective to cater sporadic demand for capacity and Reserved Instances could prove cost effective if either there's a continuous demand for HPC or there are many applications to run on Azure HPC. Both are good fit for production ready workloads. Spot instances, on the other hand are good for brief testing and experimentation or if your application suits checkpointing, e.g, Genomics. Spot instances are subject to the capacity available in the data center and the pricing changes and based on these factors the spot instances can be evicted with minimum notice.

### Data classification

HPC workloads benefit from high throughput storage, for example, Azure Managed Lustre, Azure Net App Files, BeeGFS Parallel File System, etc. These storage services do deliver the performance and may come at a cost. It's important to have data classified before hand such that only application-specific data reside in these systems. All other data can reside in low cost storages such as Azure Data Lake or Blob. Further, it might be useful to provision HPC storage systems on demand making sure the data is synced to low cost storage service like Azure Blob Storage. This will ensure data is retained in Azure Blob when the high performance storage system is turned off. Azure Managed Lustre and Azure Net App Files do offer a sync service.

### Set budgets

Azure CycleCloud allows you to set budgets per cluster and can send notifications to the recipients if they're close to exhaust the budgets. For Azure batch, you can create budgets and spending alerts for your Batch pools or Batch accounts from the Azure portal. Budgets and alerts are useful for notifying stakeholders of any risks of overspending, although it's possible for there to be a delay in spending alerts and to slightly exceed a budget.

## Operational excellence

When keeping your HPC applications running in production, deployments must be reliable and predictable. Reliable and predictable deployments consist of automating HPC workloads with Infrastructure as a Code (IaC) solutions. You must also perform node health checks for analyzing and monitoring your HPC workloads.

 For more deployment suggestions, see [repeatable infrastructure](/azure/architecture/framework/devops/automation-infrastructure). For more monitoring suggestions, see the recommended [checklist](/azure/architecture/framework/devops/checklist).

### Infrastructure as Code

HPC on Azure deploys several resources like Azure CycleCloud, HPC Cluster, Storage, Visualization Nodes, License Servers, etc. To automate the deployment, it's recommended to use industry standard tools like Terraform, Ansible and Packer to simplify the process.

### Node health check

[Azure Managed Grafana](https://azure.microsoft.com/services/managed-grafana/#overview) is a fully managed service for analytics and monitoring solutions. It's supported by Grafana Enterprise, which provides extensible data visualizations. This can be integrated in the HPC workloads and an example is shown in Azure HPC OnDemand Platform like [AzHop](https://azure.github.io/az-hop/).

## Performance efficiency

Ensure that your HPC environment is able to scale in order to meet the demands placed on it by users in an efficient manner. Choose the right platform for your HPC applications based on application vendor recommendations, invest in capacity planning if extra infrastructure is needed to meet demand, and monitor the HPC infrastructure performance as users use your system.

For more information, see [performance efficiency topics](/azure/architecture/framework/scalability/overview#topics).

### Choosing the right platform for the HPC application

Azure offers a range of platforms for Virtual Machines based on Intel, AMD CPU and/or NVIDIA, AMD GPU. While most of the applications are compatible with what is available, there are some which only benefit from a particular type of CPU and/or GPU. Before deploying the infrastructure on cloud it's important to have a recommendation from the application vendor (ISV) to understand
- Whether the application is memory bound, CPU bound or GPU bound.
- Whether they have any recommendation on any type of CPU/GPU architecture for performance
- The type of MPI and its version their application can benefit from
- The recommendation on the scheduler type.
- Their recommendation on the IOPS/throughput from the Parallel File Systems, if any.

### Invest in capacity planning

Based on the type of the application and its license conditions, investigate whether the license is locked to use a specific number of cores and thereby assess your investment to enable the license to cater for HPC and plan the capacity accordingly.

### Monitor the performance of infrastructure

- It's important to be able to track the way in which users use your system, trace resource utilization, and generally monitor the health and performance of your system. You can use this information as a diagnostic aid to detect and correct issues, and to help spot potential problems and prevent them from occurring. For an overview of the Azure components and services available to monitor Azure resources, see [here](/azure/monitoring-and-diagnostics/monitoring-overview).
- Azure monitor is a great tool to identify if there are any bottlenecks in the VM instances and storage.
- Storage throttling can cause application to slow down substantially thereby affecting performance. This happens when Input Output Operations within Storage exceed the throughput limits set. Azure Storage services offer the read/write operations graphs to monitor if there are any issues pertaining to throttling.
- Azure CycleCloud integrates with Azure services such as Azure Monitor and Azure Cost Management tools. It also supports monitoring of external services through its pluggable architecture. See more details [here](/azure/cyclecloud/concepts/monitoring).
- Further, if you are using Azure Batch, [Batch Explorer](https://github.com/Azure/BatchExplorer) is a free, rich-featured, stand-alone client tool to help create, debug, and monitor Azure Batch applications

## Next steps

- See [Introduction to architectures for HPC](./index.md)
