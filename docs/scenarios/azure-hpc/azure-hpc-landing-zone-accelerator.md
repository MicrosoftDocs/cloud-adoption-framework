---
title: Azure high-performance computing (HPC) landing zone accelerator
description: The HPC landing zone accelerator is a set of open-source scripts and templates that help you create a deployment solution for customized HPC landing zones that adhere to best practices.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 11/23/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Azure high-performance computing (HPC) landing zone accelerator

The high-performance computing (HPC) landing zone accelerator automates the deployment of an environment. This environment provides a base framework that you can customize to create an end-to-end deployment mechanism for a complete HPC cluster solution in Azure. The accelerator is a collection of open-source scripts & templates that can prepare your enterprise-scale landing zones. It can provide a specific architectural approach and a reference implementation that adhere to the architecture and best practices of the Cloud Adoption Framework. 

Customers adopt HPC in various ways to suit their business needs, and you can adapt the HPC landing zone accelerator to produce an architecture that fits *your* way. Using the accelerator helps to put your organization on a path to a sustainable scale.

## Implement an enterprise-scale landing zone

The HPC landing zone accelerator assumes that you're starting with an enterprise-scale landing zone that's been successfully implemented. For more information on this prerequisite, see the following articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## What the HPC landing zone accelerator provides

The approach to landing zones of the HPC landing zone accelerator provides the following assets to your project:

- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- The landing zone architecture
- An implementation that includes:
  - A deployable reference capable of creating the environment for your HPC deployment
  - A Microsoft-approved HPC reference implementation to test the deployed environment

## Design guidelines for energy, manufacturing, and finance

The architectures of landing zones vary by business sector, in addition to varying by organization. This section lists articles by sector that provide guidelines for creating your landing zone:

- Energy (Oil and Gas)

  - [Azure Billing and Azure Active Directory Tenants](./energy/azure-billing-active-directory-tenant.md)
  - [Azure Identity and Access Management](./energy/identity-access-management.md)
  - [Management for Energy HPC](./energy/management.md)
  - [Network Topology and Connectivity for Energy HPC](./energy/network-topology-connectivity.md)
  - [Platform automation and DevOps for energy HPC](./energy/platform-automation-devops.md)
  - [Resource Organization](./energy/resource-organization.md)
  - [Governance for energy HPC](./energy/security-governance-compliance.md)
  - [Security for energy HPC](./energy/security.md)
  - [Storage for HPC energy environments](./energy/storage.md)
  
- Manufacturing 
  - [Azure Billing and Active Directory Tenants for manufacturing HPC](./manufacturing/azure-billing-active-directory-tenant.md)
  - [Azure Identity and Access Management for manufacturing HPC](./manufacturing/identity-access-management.md)
  - [Management for manufacturing HPC](./manufacturing/management.md)
  - [Network topology and connectivity for manufacturing HPC](./manufacturing/network-topology-connectivity.md)
  - [Platform automation and DevOps for manufacturing HPC](./manufacturing/platform-automation-devops.md)
  - [Resource organization for manufacturing HPC](./manufacturing/resource-organization.md)
  - [Azure governance for manufacturing HPC](./manufacturing/security-governance-compliance.md)
  - [Security for manufacturing HPC](./manufacturing/security.md)
  - [Storage for manufacturing HPC](./manufacturing/storage.md)

- Finance
  - [Azure billing offers and Active Directory tenants for finance HPC](./finance/azure-billing-active-directory-tenant.md)
  - [Azure identity and access management for finance HPC](./finance/identity-access-management.md)
  - [Management for finance HPC](./finance/management.md)
  - [Network topology and connectivity for finance HPC](./finance/network-topology-connectivity.md)
  - [Platform automation and DevOps for finance HPC](./finance/platform-automation-devops.md)
  - [Resource organization for finance HPC](./finance/resource-organization.md)
  - [Governance for finance HPC](./finance/security-governance-compliance.md)
  - [Security for finance HPC](./finance/security.md)
  - [Storage for finance HPC](./finance/storage.md)

## Example: conceptual reference architecture for energy

The following conceptual reference architecture is an example that shows design areas and best practices for *energy* environments.

:::image type="content" alt-text="Diagram that shows an example architecture for an energy environment, including compute, storage, subnets, a database, and a front end for on-premises users." source="./media/network-interconnect.png" lightbox="./media/network-interconnect.png":::

## Example: conceptual reference architecture for finance

The following conceptual reference architecture is an example that shows design areas and best practices for *finance* environments.

:::image type="content" alt-text="Diagram that shows an example architecture for a finance environment, including on-premises resources, virtual network, subnets, and network security groups." source="./media/hpc-finance-architecture-example.png" lightbox="./media/hpc-finance-architecture-example.png":::


## Example: conceptual reference architecture for manufacturing

The following conceptual reference architecture is an example that shows design areas and best practices for *manufacturing* environments.

:::image type="content" alt-text="Diagram that shows an example architecture for a manufacturing environment, including on-premises and cloud resources and an HPC landing zone." source="./media/hpc-manufacturing-architecture-example-temp.png" lightbox="./media/hpc-manufacturing-architecture-example-temp.png":::


## Obtain the HPC landing zone accelerator

The HPC landing zone accelerator is available on GitHub: [Azure HPC OnDemand Platform Accelerator](https://azure.github.io/az-hop/)

## Next steps

For considerations and recommendations for your HPC landing zone accelerator architecture, review the critical design areas of the HPC landing zone accelerator in [Azure Identity and Access Management](./energy/identity-access-management.md).
