---
title: Oracle on Azure IaaS landing zone accelerator
description: Learn how to use the Oracle on Azure IaaS landing zone accelerator to automate the deployment of environments that can host Oracle on Azure virtual machines.
author: jfaurskov
ms.author: janfaurs
ms.date: 08/02/2024
ms.topic: conceptual
ms.service: azure-cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Oracle on Azure IaaS landing zone accelerator

The Oracle on Azure infrastructure as a service (IaaS) landing zone accelerator is an open-source collection of Terraform, Bicep, and Ansible templates. You can use these templates to automate the deployment of an environment that can host Oracle on Azure virtual machines. The landing zone accelerator provides a specific architectural approach and reference implementation that you can use to prepare your landing zones. These landing zones adhere to the architecture and best practices of the Cloud Adoption Framework for Azure.

You can adopt Oracle on Azure IaaS in various ways. You can adapt the landing zone accelerator to produce an architecture that fits your scenario and puts your organization on a path to scale sustainably.

## Prerequisites

The Oracle on Azure IaaS landing zone accelerator assumes that you already successfully implemented an Azure landing zone. However, you can use the Oracle on Azure IaaS landing zone accelerator if your infrastructure doesn't conform to Azure landing zones. For more information, see these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## Oracle on Azure IaaS landing zone accelerator assets

The landing zone accelerator provides these assets to support your project:

- A modular approach so that you can customize environment variables.
- Design guidelines that help you make critical decisions.
- The landing zone architecture.
- An implementation that includes:
  - A deployable reference that can create the environment for your Oracle on Azure IaaS deployment.
  - A Microsoft-recommended Oracle on Azure IaaS reference implementation to test the deployed environment.

## Design guidelines

For guidelines to create your landing zone, see these articles:

- [Network topology and connectivity for Oracle on Azure Virtual Machines landing zone accelerator](./oracle-network-topology.md)
- [Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator](./oracle-security-guideline-landing-zone.md)
- [Business continuity and disaster recovery (BCDR) for Oracle on Azure Virtual Machines landing zone accelerator](./oracle-disaster-recovery-oracle-landing-zone.md)
- [Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator](./oracle-manage-monitor-workload.md)
- [Governance and compliance for Oracle on Azure Virtual Machines landing zone accelerator](./governance-compliance-oracle-landing-zone.md)

## Example conceptual reference architecture

This diagram shows an example conceptual reference architecture that illustrates design areas and best practices.

:::image type="content" source="media/index/reference-architecture-oracle-iaas-landing-zone.svg" alt-text="A diagram that shows a reference architecture of the Oracle on Azure landing zone accelerator." lightbox="media/index/reference-architecture-oracle-iaas-landing-zone.svg":::

## Get the Oracle on Azure IaaS landing zone accelerator

The Oracle on Azure IaaS landing zone accelerator is available [on GitHub](https://aka.ms/lza/oracle-accelerator).

## Next step

- To see more recommendations for your architecture, review the Oracle on Azure IaaS landing zone accelerator [design areas](./oracle-iaas/oracle-network-topology-iaas.md).
