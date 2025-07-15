---
title: The Azure Well-Architected Framework for HPC
description: Learn how to use the Azure Well-Architected Framework architecture principles to design and optimize workloads running in your high-performance computing (HPC) scenario.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 04/02/2024
ms.topic: conceptual
ms.custom: think-tank
---

# The Azure Well-Architected Framework for HPC

The [plan for Azure high-performance computing (HPC)](./plan.md) outlines a process to rationalize your scenario, prioritize technical efforts, and identify workloads. For many of the workloads, it's important to adhere to a set of architectural principles. These principles help guide development and optimization of the workloads. The five architectural constructs are described in the [Azure Well-Architected Framework](/azure/well-architected/). This guidance provides a summary of how you can apply these principles to the management of your data workloads.

## Reliability

Everything has the potential to break. Data pipelines are no exception. Great architectures are designed with availability and resiliency in mind. The key considerations are how quickly you can detect change and how quickly you can resume operations.

Your data environment should consider resilient architectures, cross region redundancies, service level, service-level agreements (SLAs), and critical support. The existing environment should also include auditing, monitoring, and alerting by using integrated monitoring and a notification framework.

On top of these environmental controls, the workload team should consider:

- Doing more architecture modification to improve service level SLAs.
- Setting up redundant workload-specific architecture.
- Establishing processes for monitoring and notification beyond what the cloud operations teams provide.

### Hybrid ExpressRoute connectivity

In order to support mission critical HPC workloads, use an Azure ExpressRoute high availability configuration. Even in a single site, high availability setup where you might have a redundant ExpressRoute connection, it doesn't protect you against single edge site downtime. When you enable two connections at two facilities, the redundancy lets your business continue if there's a disaster at the primary location. By using ExpressRoute high availability, you can help ensure connectivity to Azure if an ExpressRoute outage occurs in a single region.

#### Recommendations

- Enable two ExpressRoute circuits in two different ExpressRoute edge site locations for maximum redundancy.
  - This setup requires you to establish two ExpressRoute circuits in the Azure portal for the two different ExpressRoute edge site locations. Then, you connect both ExpressRoute circuits to the same virtual hub network in Azure.
  - Place the two edge site locations in the same Azure region. It's what provides the redundancy in case one of the peering locations fails. Both ExpressRoute connections terminate into the same virtual hub network in Azure. View the list of [ExpressRoute locations and connectivity partners](/azure/expressroute/expressroute-locations-providers#global-commercial-azure) to plan your ExpressRoute peering locations.
  - Work with the provider to configure the second ExpressRoute site.
  - Ensure that the second connection is working by failing traffic over to the second location, which is critical. Perform regular drills to ensure connectivity.

For more information on a maximum resiliency ExpressRoute configuration, see [Design for disaster recovery with ExpressRoute](/azure/expressroute/designing-for-disaster-recovery-with-expressroute-privatepeering#redundancy-with-expressroute-circuits-in-different-metros).

## Security

Apply security principles to your HPC environment to provide safeguards against deliberate attacks and abuse of your valuable data and systems. Look into securing your user operating system images and user access, and follow Azure Batch and Azure CycleCloud security guidelines. For more information, see [Principles of the security pillar](/azure/architecture/framework/security/security-principles).

### Operating system images

Azure Marketplace provides Linux-based HPC images to use in the cluster. These images contain many popular libraries, software packages, and diagnostic tools such as:

- InfiniBand-based, message passing interface (MPI) libraries.
- Mellanox OFED.
- Preconfigured IP over InfiniBand.
- Communication runtimes.
- Intel/AMD-optimized libraries.
- Azure HPC diagnostic tools.

You can start with the images and then apply your organization's security policies to strengthen software images against vulnerabilities and cyber threats. After validation, you can save the new image in Azure Compute Gallery. You can then use the image to create virtual machines in Azure CycleCloud, Azure HPC, and Batch.

### User access

- Define clear lines of responsibility and separation of duties for each function.
- Restrict access based on a need-to-know basis and least privilege security principles.
- Assign permissions to users, groups, and applications at a certain scope through Azure role-based access control. Use built-in roles when possible.
- Prevent deletion or modification of a resource, resource group, or subscription through management locks.
- Use managed identities to access resources in Azure.
- Support a single enterprise directory. Keep the cloud and on-premises directories synchronized, except for critical-impact accounts.
- Set up Microsoft Entra Conditional Access. Enforce and measure key security attributes when authenticating all users, especially for critical-impact accounts.
- Use passwordless methods or opt for modern password methods.
- Block legacy protocols and authentication methods.

### Azure Batch security

Follow the best practices to enable security for [Batch](/azure/batch/security-best-practices).

### Azure CycleCloud security

Follow the best practices to enable security for [Azure CycleCloud](/azure/cyclecloud/concepts/security-best-practices).

## Cost optimization

To make the most out of running your environment in Azure, prioritize cost management and upfront planning exercises. Cost management and planning are typically the most important considerations for an organization's successful cloud migration journey. [Microsoft Cost Management](/azure/cost-management-billing) gives you tools to plan for, analyze, and reduce spending to maximize your cloud investment. For more information on the ways you can plan and optimize your cloud costs, see [Cost management billing best practices](/azure/cost-management-billing/costs/cost-mgt-best-practices). The following considerations are some of the most important in cost optimization.

### Choice of operating system

Linux is the dominant operating system for HPC workloads. Linux is open-source and tuned for performance to use the HPC infrastructure. So the MPI libraries and Infiniband drivers work well on Linux versus Windows. By using Linux virtual machines (VMs) versus Windows for setting up an HPC cluster, it can definitely save costs. But some users might have a strong preference for a Windows environment especially while doing the pre-processing and post-processing tasks in workloads such as computational fluid dynamics. In this case, we recommend having a Windows front end submit jobs to a Linux host, a head node, which uses the compute nodes for simulations.

### Autoscaling

Autoscaling lets you set up and use VMs only when you submit a job or when a job is active. When the job finishes, the nodes turn off automatically. By using autoscaling, you adjust compute resources used by your application, potentially saving you time and money. Azure CycleCloud has autoscaling turned on in its schedulers by default. The default time limit to switch off the nodes is 15 minutes. You can customize the time limit. The time limit helps ensure that users pay only for what they use. Batch provides a mechanism to integrate an autoscaling formula with a choice of parameters. For more information, see [Get started with autoscale in Azure](/azure/azure-monitor/autoscale/autoscale-get-started).

### Pay-as-you-go versus reserved instances and spot instances

Azure provides various pricing options, pay-as-you-go, reserved instance with one- or three-year options, and spot instances that are subject to the capacity available in the Data center. Pay-as-you-go instances are cost effective because they cater to sporadic demand for capacity. Reserved instances can prove to be cost effective if there's a continuous demand for HPC or there are many applications that run on Azure HPC. Both are a good fit for production-ready workloads. Spot instances are good for brief testing and experimentation or if your application needs checkpointing, for example, genomics. Spot instances are subject to the capacity available in the data center. The pricing depends on these factors. You can evict spot instances with minimum notice.

### Data classification

HPC workloads benefit from high throughput storage. For example, use Azure Managed Lustre, Azure Net App Files, or BeeGFS Parallel File System. These storage services deliver performance but might come at a cost. It's important to classify your data beforehand so that only application-specific data resides in these systems. All other data can reside in low-cost storage solutions such as Azure Data Lake Storage or Azure Blob Storage.

Further, it might be useful to set up HPC storage systems on demand to help ensure the data synchronizes to a low-cost storage service like Blob Storage. On-demand storage helps ensure data retains in Blob Storage when the high-performance storage system is turned off. Managed Lustre and Net App Files offer a synchronization service.

### Set budgets

Azure CycleCloud lets you set budgets per cluster and can send notifications to recipients if they're close to exhausting the budgets. For Batch, you can create budgets and spending alerts for your Batch pools or Batch accounts from the Azure portal. Budgets and alerts are useful for notifying stakeholders of any risks of overspending, although it's possible for there to be a delay in spending alerts and to slightly exceed a budget.

## Operational excellence

When you keep your HPC applications running in production, deployments must be reliable and predictable. Reliable and predictable deployments consist of automating HPC workloads with infrastructure as code (IaC) solutions. You must also perform node health checks to analyze and monitor your HPC workloads.

 For more information on deployment suggestions, see [Recommendations for using infrastructure as code](/azure/architecture/framework/devops/automation-infrastructure). For more information on monitoring suggestions, see [Recommendations for designing and creating a monitoring system](/azure/architecture/framework/devops/checklist).

### Infrastructure as code

HPC on Azure deploys several resources like Azure CycleCloud, HPC Cluster, Storage, Visualization Nodes, License Servers, and so on. To automate the deployment, we recommend that you use industry-standard tools like Terraform, Ansible, and Packer to simplify the process.

### Node health check

[Azure Managed Grafana](https://azure.microsoft.com/services/managed-grafana/#overview) is a fully managed service for analytics and monitoring solutions. Grafana Labs supports Grafana and provides extensible data visualizations.

## Performance efficiency

Ensure that your HPC environment is able to scale efficiently so it can meet the demands placed on it by users. Choose the right platform for your HPC applications based on application vendor recommendations. Invest in capacity planning if you need extra infrastructure to meet demand. Monitor the HPC infrastructure performance as users use your system.

For more information, see the [performance efficiency articles](/azure/architecture/framework/scalability/overview#topics).

### Choose the right platform for the HPC application

Azure offers a range of platforms for VMs based on Intel, AMD CPU and NVIDIA, and AMD GPU. Although most of the applications are compatible with what's available, some benefit from only a particular type of CPU or GPU. Before you deploy your infrastructure to the cloud, it's important to have a recommendation from the application vendor (ISV) to understand the following needs.

- If the application is memory bound, CPU bound, or GPU bound
- If they have any recommendation on any type of CPU or GPU architecture for performance
- If there's a type of MPI and its version that their application can benefit from
- If there's a recommendation on the scheduler type
- If there's a recommendation on the IOPS/throughput from the Parallel File Systems

### Invest in capacity planning

Based on the type of the application and its license conditions, review whether the license is set to use a specific number of cores. Assess your investment to enable the license to cater for HPC and then plan your capacity accordingly.

### Monitor the performance of infrastructure

- It's important to be able to track the way in which users use your system, trace resource use, and generally monitor the health and performance of your system. You can use this information as a diagnostic aid to detect and correct issues, and to help spot potential problems and prevent them from occurring. For an overview of the Azure components and services available to monitor your resources, see [Azure Monitor overview](/azure/monitoring-and-diagnostics/monitoring-overview).
- Monitor is a great tool to identify if there are any bottlenecks in the VM instances and storage.
- Storage throttling can cause applications to slow down substantially and affect performance. Throttling happens when input and output operations within storage exceed the throughput limits you set. Azure Storage services offer read and write operations graphs to monitor if there are any issues from throttling.
- Azure CycleCloud integrates with Azure services such as Monitor and Microsoft Cost Management tools. It also supports monitoring external services through its pluggable architecture. For more information, see [Monitoring](/azure/cyclecloud/concepts/monitoring).
- Further, if you're using Batch, [Batch Explorer](https://github.com/Azure/BatchExplorer) is a free, rich-featured, stand-alone client tool to help create, debug, and monitor Batch applications.

## Next steps

- [Introduction to architectures for HPC](./index.md)
