---
title: Migrate workloads for Azure high-performance computing (HPC)
description: As an IT professional, I want to find guidance in the Cloud Adoption Framework covering migration for using Azure High-performance computing (HPC) as part of my IT strategy.
author: Rajani-Janaki-Ram
ms.author: erd
ms.date: 09/19/2022
ms.topic: conceptual
s.custom: think-tank
---

# Migrate Azure high-performance computing (HPC)

Azure HPC offers sustainability, efficiency, and flexibility with various digital solutions to not only supplement on-premises infrastructure but also reduces reliance on persistent cycles concerning hardware refreshes for higher demanding computation. 

See how your HPC environment will [migrate](../../migrate/index.md) to the cloud and determine which approach best fits your environment.

## HPC process details

You should continually reassess your infrastructure requirements to improve performance and reduce costs by using the relevant type of VMs. It is also possible to move to a more cost-effective, non HPC cluster.

Review the [migration resources](../../migrate/azure-migration-guide/index.md#azure-migration-guide-overview) to define your HPC migration process and in addition:
- **Review the current VM size**: Review your CPU, memory, disk, and networking specifications for existing VMs to determine appropriate VM sizes.
- **Verify Azure subscription quota limits**: Ensure that the quota limits in your Azure subscription accommodate the target VM sizes you choose.
- **Identify the deployment model**: Automate deployment as much as possible by choosing between Azure Resource Manager or Azure Service Manager, previously known as classic deployment.

Consider also [getting assistance](../../migrate/azure-migration-guide/assistance.md) to accelerate your HPC migration efforts.

## HPC process flow

In regards to dedicated data migration assistance, find an Azure [HPC industry partner](https://appsource.microsoft.com/marketplace/partner-dir) near you to help with potential latency problems and large sets of important data to be moved.

You can also use [Azure HPC Cache](/azure/hpc-cache/hpc-cache-overview) services to create a copy of your data needed for temporary processing in the cloud. Typically Azure HPC Cache is used for read-heavy file access workflows, NFS-accessible storage and Azure Blobs, and compute farms of up to 75,000 cores.

A wide variety of workflows across many industries that have a large number of machines needed to access a set of files at scale and low latency will benefit from Azure HPC Cache.

## HPC workload specific activities

As there are various industries using HPC for specific and different computing needs, there are many ways to migrate workloads.

To get started on migrating HPC workload activities, refer to the [migration resources](../../migrate/azure-migration-guide/assess.md#assess-workloads-and-refine-plans) to use the data and assessment tool to access/define your HPC workloads, make informed decisions on migration readiness, align your organization with the relevant stakeholders, and evaluating the timeline of migration.


## Next steps

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for HPC](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Govern HPC](./govern.md)
- [Secure HPC](./secure.md)
- [Organize team members for HPC in Azure](./organize.md)
- [Innovate with HPC](./innovate.md)
- [Manage HPC](./manage.md)
