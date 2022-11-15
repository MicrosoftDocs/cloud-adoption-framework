---
title: Azure landing zone for HPC
description: This article describes the HPC scenario's effect on Azure landing zone design.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 11/10/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Azure landing zone for HPC

The [Ready methodology](../../ready/index.md) of the Cloud Adoption Framework for Azure can guide you through the process of preparing your environment for cloud adoption. During the readiness phase, you can use an Azure landing zone. A landing zone is a technical accelerator that provides the basic building block for any cloud adoption environment. A landing zone can automate the configuration of your Azure environment, aligning with best practice guidance from the Cloud Adoption Framework. In the process of preparing for high-performance computing (HPC), you might encounter environment configurations that depend on your industry use case and requirements.

## Azure landing zone conceptual architecture

As you prepare your environment for sustained cloud adoption, you can use an Azure landing zone conceptual architecture, which represents a target end state. For HPC, there are multiple conceptual architecture references, based on the three industries that the Cloud Adoption Framework currently addresses:

- [Energy (oil and gas)](../azure-hpc/energy/compute.md#use-case-and-reference-architecture-for-seismic-processing)
- [Finance](./azure-hpc-landing-zone-accelerator.md#example-conceptual-reference-architecture-for-energy)
- [Manufacturing](./azure-hpc-landing-zone-accelerator.md#example-conceptual-manufacturing-reference-architecture)

As you develop a long-term vision for your landing zone, consider these architecture references. These references provide a starting point. Based on your organization's business requirements and the needs of your end users, you might need to modify them.

## Evaluation for HPC

The decisions you make during strategic impact assessment and technical planning have the most influence on the landing zone configuration that you choose for your HPC deployments on Azure. We recommend that you consider the following questions:

- How mature is your environment on Azure? Depending on what stage it's in, ranging from proof of concept to a mature application that serves users, you can include or omit governance, security, or resource organization.
- Is the application you're building on Azure a short-lived one or a long-standing project? The answer to this question can help you choose your compute and storage options.
- Does your organization require that people access Azure resources at various levels?

As you can see from these questions, the deployment model will vary depending on your business, industry, and application usage.

## Azure landing zone acceleration for HPC

[Azure HPC OnDemand Platform](https://azure.github.io/az-hop) provides an end-to-end deployment mechanism for a complete HPC cluster solution on Azure. Industry-standard tools like Terraform, Ansible, and Packer provision and configure the environment. 

The environment contains:

- An OpenOn Demand portal for unified user access, remote shell access, remote visualization access, job submission, file access, and more.
- Active Directory, for user authentication and domain control.
- An OpenPBS or Slurm job scheduler.
- Azure CycleCloud, to handle autoscaling of nodes through job scheduler integration.
- A jump box to provide admin access.
- Azure Netapp Files for home directory and data storage.
- A Lustre cluster for scratch storage, with HSM capabilities to Azure blobs through a Robinhood integration.
- Grafana dashboards to monitor your cluster.

## Next steps

- After you prepare your HPC landing zone, start looking into what your [migration](./migrate.md) will look like.
- See the overall [HPC landing zone accelerator](./azure-hpc-landing-zone-accelerator.md).
