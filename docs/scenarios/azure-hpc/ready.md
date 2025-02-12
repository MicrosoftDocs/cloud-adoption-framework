---
title: Azure landing zone for HPC
description: See the effect of an HPC scenario on Azure landing zone design. Understand the differences between Azure Batch and Azure HPC OnDemand Platform (AzHop).
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 11/10/2022
ms.topic: conceptual
ms.custom: think-tank
---

# Landing zone for HPC

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure can guide you through preparing your environment for cloud adoption. During the readiness phase, you can use an Azure landing zone. A landing zone is a technical accelerator that provides the basic building block for any cloud adoption environment. A landing zone can automate the configuration of your Azure environment, aligning with best practice guidance from the Cloud Adoption Framework. While preparing for high-performance computing (HPC), you might encounter environment configurations that depend on your industry use case and requirements.

## Azure landing zone conceptual architecture

As you prepare your environment for sustained cloud adoption, you can use an Azure landing zone conceptual architecture that represents a target end state. For HPC, there are multiple conceptual architecture references that are based on the three industries that the Cloud Adoption Framework currently addresses:

- [Energy (oil and gas)](../azure-hpc/compute.md#reference-architecture-for-seismic-processing)
- [Finance](./azure-hpc-landing-zone-accelerator.md#example-conceptual-reference-architecture-for-energy)
- [Manufacturing](./azure-hpc-landing-zone-accelerator.md#example-conceptual-reference-architecture-for-finance)

Consider these architecture references as you develop a long-term vision for your landing zone. These references provide a starting point. Based on your organization's business requirements and the needs of your end users, you might need to modify them.

## Evaluation for HPC

The decisions that you make during strategic impact assessment and technical planning influence the landing zone configuration that you choose for your HPC deployments on Azure. We recommend that you consider the following questions:

- How mature is your environment on Azure? Is it in the proof of concept stage? Or is it already a mature application that serves users? Depending on its stage, you can include or omit governance, security, or resource organization.
- Is the application that you're building on Azure short-lived or a long-standing project? The answer to this question can help you choose your compute and storage options.
- Does your organization require that people access Azure resources at various levels?

As you can see from these questions, the deployment model varies depending on your business, industry, and application usage.

## Azure landing zone acceleration for HPC

[Azure Batch](/azure/batch/batch-technical-overview) and [Azure CycleCloud](/azure/cyclecloud/overview) are both Azure provided 1st party service while **Azure HPC OnDemand Platform** ([AzHOP](https://azure.github.io/az-hop/)) is an automation built on top of Azure Cycle Cloud which delivers an end-to-end deployment mechanism for a complete HPC cluster solution in Azure.

### Azure Batch

- Batch is designed to run large-scale parallel and HPC batch jobs efficiently in Azure.
- Batch creates and manages a pool of compute nodes, or virtual machines (VMs). You can also use Batch to install the applications that you want to run and to schedule jobs to run on the nodes.
- There's no cluster or job scheduler software to install, manage, or scale.
- Batch works well with intrinsically parallel workloads. These workloads have applications that can run independently, with each instance completing part of the work.
- You can also use Batch to run tightly coupled workloads, where the applications that you run need to communicate with each other rather than running independently.
- Batch tasks can run directly on VMs, or nodes, in a Batch pool. But you can also set up a Batch pool to run tasks in Docker-compatible containers on the nodes.

### Azure CycleCloud

- It supports various HPC schedulers, such as SLURM, OpenPBS, PBSPro, LSF, Grid Engine, and HTCondor12.
- It allows you to provision infrastructure for HPC systems, such as virtual machines, scale sets, network interfaces, and disks.
- It automatically scales the infrastructure to run jobs efficiently at any scale based on job load, availability, and time requirements.
- It provides a rich, declarative, templating format to construct complete HPC environments on Azure.
- It integrates with Azure services such as Azure Monitor and Microsoft Cost Management tools.

### AzHop

- AzHop provides an end-to-end deployment mechanism for a base HPC infrastructure on Azure utilizing CycleCloud to orchestrate jobs.
- It delivers a complete HPC cluster solution that's ready for users to run applications on and that's easy for HPC administrators to deploy and manage.
- AzHop uses various applications built-in that you can use "as is," or you can easily customize and extend to meet any unmet requirements.
- It includes an **Open OnDemand** portal for unified user access, remote shell access, remote visualization access, job submission, file access, and more.
- It uses **Active Directory** for user authentication and domain control.
- It uses **OpenPBS** or Simple Linux Utility for Resource Management (**SLURM**) as a job scheduler.
- Dynamic resource provisioning and autoscaling are done by **CycleCloud** preconfigured job queues and integrated health checks to quickly avoid nonoptimal nodes.
- **Azure NetApp Files** delivers a shared file system for the home directory and applications.

### Comparison chart

|Feature | Azure Batch | Azure CycleCloud |
|---------------|------------------------|------------------------|
| Scheduler | Batch APIs and tools are available. You can also use cloud-native command-line scripts in the Azure portal. | You can use standard HPC schedulers such as **SLURM**, **OpenPBS**, **PBSPro**, **LSF**, **Grid Engine**, and **HTCondor**. Or you can extend Azure CycleCloud autoscaling plugins to work with your own scheduler.|
| Compute resources | Software as a service (SaaS) nodes – platform as a service (PaaS). |PaaS software – PaaS. |
| Monitoring tools | Azure Monitor. | Azure Monitor and Grafana. |
| Customization | You can use custom image pools, third-party images, or Batch API access. | You can use the comprehensive RESTful API to customize and extend functionality, deploy your own scheduler, and support existing workload managers. |
| Integration | Azure Synapse Analytics pipelines, Azure Data Factory, and the Azure CLI. | A built-in CLI for Windows and Linux. |
| User type | Developers. | Classic HPC administrators and users. |
| Work type | Batches and workflows. | Tightly coupled workflows that use Message Passing Interface (MPI).|
| Windows support | Provided. | Depends on the scheduler choice. |

Azure CycleCloud and Azure Batch are powerful tools for HPC tasks on Azure, but they're designed for different use cases.

Azure CycleCloud is an enterprise-friendly tool for orchestrating and managing HPC environments on Azure. It's targeted at HPC administrators and users who want to deploy an HPC environment with a specific scheduler in mind. Azure CycleCloud provides powerful tooling to construct complete HPC environments on Azure, including Network File Sharing (NFS) servers, parallel file systems, sign-in hosts, license servers, and directory services. It's useful for organizations that have operated HPC environments for a while and have accumulated years of expertise and in-house tooling around a specific scheduler.

In contrast, Batch is mostly aimed at developers and teams who build a capability into their own product or service. Batch includes its own scheduler and is designed to run large-scale parallel jobs efficiently without cluster or job scheduler software. Batch is useful when you don't need to manage a workload scheduler.

In summary, use Azure CycleCloud when you want to deploy an HPC environment with a specific scheduler in mind and need a complete HPC environment. Use Batch when you develop a product or service that requires large-scale parallel processing and you don't want to manage a workload scheduler.

## Next steps

- Review available [High performance computing VM sizes](/azure/virtual-machines/sizes-hpc).
- After you prepare your HPC landing zone, start looking at your [migration](./migrate.md).
- See the overall [HPC landing zone accelerator](./azure-hpc-landing-zone-accelerator.md).
