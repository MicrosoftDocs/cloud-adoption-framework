---
title: Azure Landing Zone review for Azure high-performance computing (HPC)
description: HPC scenario's impact on the Azure Landing Zone design.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 11/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Azure Landing Zone review for Azure high-performance computing (HPC)

The [Ready methodology](../../ready/index.md) of the Microsoft Azure Cloud Adoption Framework guides customers through environment readiness to prepare for cloud adoption. The readiness section includes technical accelerators (Azure landing zones), which are the basic building block in any cloud adoption environment. Landing zones automate the configuration of your Azure environment, aligning with best practices guidance in the Cloud Adoption Framework. When preparing for HPC, there are many environment configurations that may be slightly different depending on the industry use case and therefore the requirements.

## Azure Landing Zone Conceptual Architecture

When preparing any environment for sustained cloud adoption, we use the Azure Landing Zones Conceptual Architecture to represent what a target end state should look like in Azure. For HPC, we have included multiple conceptual architecture references based on the three industries that the cloud adoption framework currently addresses:

- [Energy (Oil & Gas)](../azure-hpc/energy/compute.md#use-case-and-reference-architecture-for-seismic-processing).
- [Finance](../azure-hpc/azure-hpc-landing-zone-accelator.md#example-conceptual-energy-reference-architecture).
- [Manufacturing](./azure-hpc-landing-zone-accelator.md#example-conceptual-manufacturing-reference-architecture).

When developing a long-term vision for landing zones, consider the designs above. Note that the conceptual architecture references will act as a starting point, and based on your organization's business requirements and end-user needs, you may have to modify these as required.

## HPC evaluation

The decisions made during Strategic Impact Assessment and technical planning will have the most impact on the landing zone configuration that you choose for your HPC deployments in Azure. We recommend that the following are considered:

- What is the maturity of your environment in Azure? Depending on whether it is in the Proof of Concept (POC) stage, or a matured application serving end users - you can include or omit governance, security or resource organization.
- Is the application you're building on Azure a short lived one, or are you looking at a long standing project - depending on the application, you can choose your compute or storage options.
- Does your organization require multiple people at different levels of access to use the Azure resources?

The above are guiding questions and expected to help you understand that the deployment models chosen will vary across business, industries, and application usage.

## HPC Azure Landing Zone Acceleration

The [Azure HPC OnDemand Platform Accelerator](https://azure.github.io/az-hop/) delivers an end to end deployment mechanism for a complete HPC cluster solution in Azure. Industry standard tools like Terraform, Ansible and Packer are used to provision and configure this environment containing:

- An OpenOn Demand Portal for a unified user access, remote shell access, remote visualization access, job submission, file access and more.
- An Active Directory for user authentication and domain control.
- An OpenPBS or SLURM Job Scheduler.
- Azure CycleCloud to handle autoscaling of nodes through job scheduler integration.
- A Jumpbox to provide admin access.
- Azure Netapp Files for home directory and data storage.
- A Lustre cluster for the scratch storage with HSM capabilities to Azure Blobs through a RobinHood integration.
- Grafana dashboards to monitor your cluster.

## Next steps

- After preparing your HPC landing zones, start looking into what your [migration](./migrate.md) will look like.
- See the overall [HPC landing zone accelerator](../azure-hpc/azure-hpc-landing-zone-accelator.md).
