---
title: Oracle on Azure IaaS landing zone accelerator
description: Learn how to use the Oracle on Azure landing zone accelerator to automate the deployment of environments that can host Oracle on Azure virtual machines.
author: jfaurskov
ms.author: janfaurs
ms.date: 08/02/2024
ms.topic: concept-article
ms.custom: e2e-oracle
---

# Oracle on Azure IaaS landing zone accelerator

The Oracle on Azure infrastructure as a service (IaaS) landing zone accelerator is an open-source collection of Terraform, Bicep, and Ansible templates. You can use these templates to automate the deployment of an environment that can host Oracle on Azure virtual machines. The landing zone accelerator provides a specific architectural approach and reference implementation that you can use to prepare your landing zones. These landing zones adhere to the architecture and best practices of the Cloud Adoption Framework for Azure.

You can adopt Oracle on Azure IaaS in various ways. You can adapt the landing zone accelerator to produce an architecture that fits your scenario and enables sustainable scaling.

## Prerequisites

The Oracle on Azure IaaS landing zone accelerator assumes you already implemented an Azure landing zone. You can still use the accelerator if your infrastructure doesn't conform to Azure landing zones. For more information, see these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## Oracle on Azure IaaS landing zone accelerator assets

The landing zone accelerator provides these assets to support your project:

- A modular approach so that you can customize environment variables.
- Design guidelines that help you make critical decisions.
- The landing zone architecture.
- An implementation that includes:
  - A deployable reference that creates the environment for your Oracle on Azure IaaS deployment.
  - A Microsoft-recommended Oracle on Azure IaaS reference implementation to test the deployed environment.

## Design guidelines

For guidelines to create your landing zone, see these articles:

- [Network topology and connectivity for Oracle on Azure Virtual Machines landing zone accelerator](./oracle-network-topology-iaas.md)
- [Security guidelines for Oracle on Azure Virtual Machines landing zone accelerator](./oracle-security-overview-iaas.md)
- [Business continuity and disaster recovery (BCDR) for Oracle on Azure Virtual Machines landing zone accelerator](./oracle-disaster-recovery-iaas.md)
- [Manage and monitor Oracle workloads on Azure Virtual Machines landing zone accelerator](./oracle-manage-monitor-iaas.md)

## Example conceptual reference architecture

This diagram shows a reference architecture that illustrates design areas and best practices.

:::image type="content" source="media/index/reference-architecture-oracle-infrastructure-landing-zone.svg" alt-text="A diagram that shows a reference architecture of the Oracle on Azure landing zone accelerator." border="false" lightbox="media/index/reference-architecture-oracle-infrastructure-landing-zone.svg":::

*Download a [Visio file](https://arch-center.azureedge.net/reference-architecture-oracle-iaas-landing-zone.vsdx) of this architecture.*

## Get the Oracle on Azure IaaS landing zone accelerator

The Oracle on Azure IaaS landing zone accelerator is available [on GitHub](https://aka.ms/lza/oracle-accelerator).

## Next step

To see more recommendations for your architecture, review the Oracle on Azure IaaS landing zone accelerator [design areas](./oracle-network-topology-iaas.md).
