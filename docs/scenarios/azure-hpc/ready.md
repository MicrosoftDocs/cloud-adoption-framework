---
title: Azure landing zone for HPC
description: This article describes the HPC scenario's effect on Azure landing zone design.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 11/10/2022
ms.topic: conceptual
ms.custom: think-tank
---

# Azure landing zone for HPC

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure can guide you through the process of preparing your environment for cloud adoption. During the readiness phase, you can use an Azure landing zone. A landing zone is a technical accelerator that provides the basic building block for any cloud adoption environment. A landing zone can automate the configuration of your Azure environment, aligning with best practice guidance from the Cloud Adoption Framework. In the process of preparing for high-performance computing (HPC), you might encounter environment configurations that depend on your industry use case and requirements.

## Azure landing zone conceptual architecture

As you prepare your environment for sustained cloud adoption, you can use an Azure landing zone conceptual architecture, which represents a target end state. For HPC, there are multiple conceptual architecture references, based on the three industries that the Cloud Adoption Framework currently addresses:

- [Energy (oil and gas)](../azure-hpc/energy/compute.md#use-case-and-reference-architecture-for-seismic-processing)
- [Finance](./azure-hpc-landing-zone-accelerator.md#example-conceptual-reference-architecture-for-energy)
- [Manufacturing](./azure-hpc-landing-zone-accelerator.md#example-conceptual-reference-architecture-for-finance)

As you develop a long-term vision for your landing zone, consider these architecture references. These references provide a starting point. Based on your organization's business requirements and the needs of your end users, you might need to modify them.

## Evaluation for HPC

The decisions you make during strategic impact assessment and technical planning have the most influence on the landing zone configuration that you choose for your HPC deployments on Azure. We recommend that you consider the following questions:

- How mature is your environment on Azure? Depending on what stage it's in, ranging from proof of concept to a mature application that serves users, you can include or omit governance, security, or resource organization.
- Is the application you're building on Azure a short-lived one or a long-standing project? The answer to this question can help you choose your compute and storage options.
- Does your organization require that people access Azure resources at various levels?

As you can see from these questions, the deployment model will vary depending on your business, industry, and application usage.

## Azure landing zone acceleration for HPC
[Azure Batch](https://learn.microsoft.com/en-us/azure/batch/batch-technical-overview) and [Azure HPC OnDemand Platform](https://azure.github.io/az-hop) are both services provided by Microsoft Azure, but they serve different purposes and have different features.

### Azure Batch:
- It is designed to run large-scale parallel and high-performance computing (HPC) batch jobs efficiently in Azure.
- Azure Batch creates and manages a pool of compute nodes (virtual machines), installs the applications you want to run, and schedules jobs to run on the nodes.
- There’s no cluster or job scheduler software to install, manage, or scale.
- It works well with intrinsically parallel workloads. These workloads have applications which can run independently, with each instance completing part of the work.
- You can also use Batch to run tightly coupled workloads, where the applications you run need to communicate with each other, rather than running independently.
- Batch tasks can run directly on virtual machines (nodes) in a Batch pool, but you can also set up a Batch pool to run tasks in Docker-compatible containers on the nodes.

### Azure HPC OnDemand Platform (AzHop):
- AzHop provides an end-to-end deployment mechanism for a base HPC infrastructure on Azure.
- It delivers a complete HPC cluster solution ready for users to run applications, which is easy to deploy and manage for HPC administrators.
- AzHop leverages the various Azure building blocks and can be used as-is, or easily customized and extended to meet any uncovered requirements.
- It includes an OpenOn Demand Portal for a unified user access, remote shell access, remote visualization access, job submission, file access and more.
- It uses an Active Directory for user authentication and domain control.
- It uses Open PBS or SLURM as a Job Scheduler.
- Dynamic resources provisioning and autoscaling is done by Azure CycleCloud pre-configured job queues and integrated health-checks to quickly avoid non-optimal nodes.
- A common shared file system for home directory and applications is delivered by Azure Netapp Files.

### Comparison chart

|Feature              |Azure Batch             |Azure CycleCloud     |
|---------------|------------------------|------------------------|
|Scheduler |Batch APIs and tools and command-line scripts in the Azure portal (Cloud Native).  |Use standard HPC schedulers such as Slurm, PBS Pro, LSF, Grid Engine, and HTCondor, or extend CycleCloud autoscaling plugins to work with your own scheduler.|
|Compute Resources |Software as a Service Nodes – Platform as a Service |Platform as a Service Software – Platform as a Service |
|Monitor Tools |Azure Monitor |Azure Monitor, Grafana |
|Customization |Custom image pools, Third Party images, Batch API access. |Use the comprehensive RESTful API to customize and extend functionality, deploy your own scheduler, and support into existing workload managers |
|Integration | Synapse Pipelines, Azure Data Factory, Azure CLI |Built-In CLI for Windows and Linux |
|User type |Developers |Classic HPC administrators and users |
|Work Type |Batch, Workflows |Tightly coupled (Message Passing Interface/MPI).|
|Windows Support |Yes |Varies, depending on scheduler choice |

Azure CycleCloud and Azure Batch are both powerful tools for high-performance computing (HPC) tasks on Azure, but they are designed for different use cases.

Azure CycleCloud is an enterprise-friendly tool for orchestrating and managing HPC environments on Azure. It is targeted at HPC administrators and users who want to deploy an HPC environment with a specific scheduler in mind. CycleCloud provides powerful tooling to construct complete HPC environments on Azure, including NFS servers, parallel file systems, login hosts, license servers, and directory services. It is particularly useful for organizations that have operated HPC environments for a while and have accumulated years of expertise and in-house tooling around a specific scheduler.

On the other hand, Azure Batch is mostly aimed at developers and teams building a capability into their own product or service. It includes its own scheduler to run jobs and is designed to run large-scale parallel jobs efficiently without the need for cluster or job scheduler software. Azure Batch is particularly useful when management of a workload scheduler isn’t needed.

In summary, use Azure CycleCloud when you want to deploy an HPC environment with a specific scheduler in mind and have the need for a complete HPC environment. Use Azure Batch when you are developing a product or service that requires large-scale parallel processing and do not want to manage a workload scheduler.

## Next steps

- After you prepare your HPC landing zone, start looking into what your [migration](./migrate.md) will look like.
- See the overall [HPC landing zone accelerator](./azure-hpc-landing-zone-accelerator.md).
