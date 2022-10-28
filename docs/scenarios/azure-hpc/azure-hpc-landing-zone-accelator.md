---
title: Enterprise-scale support for Azure high-performance computing (HPC)
description: Describe how enterprise-scale can accelerate adoption of HPC.
author: Rajani-Janaki-Ram
ms.author: rajanaki
ms.date: 09/28/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank
---

# Azure high-performance computing (HPC) landing zone accelerator

The HPC  landing zone accelerator is an open-source collection of scripts & templates that you can use to automate the deployment of an environment that can provide you a base framework on which you can make further customizations to suit your business needs. It can provide a specific architectural approach and reference implementation to prepare your enterprise-scale landing zones. The landing zones adhere to the architecture and best practices of the Cloud Adoption Framework.

Customers adopt HPC in various ways. The  landing zone accelerator can be adapted to produce an architecture that fits **your** way and puts your organization on a path to sustainable scale.

## To begin, implement an enterprise-scale landing zone

The HPC  landing zone accelerator assumes that an enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## What the HPC landing zone accelerator provides

The  landing zone accelerator approach to landing zones provides these assets to support your project:

- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- The landing zone architecture
- An implementation that includes:
  - A deployable reference capable of creating the environment for your HPC deployment
  - A Microsoft-approved HPC reference implementation to test the deployed environment

## Design guidelines

These articles provide guidelines for creating your landing zone:

- Energy (Oil and Gas)

    - [Azure billing and HPC - Energy landing zone accelerator](./energy/azure-billing-active-directory-tenant.md)
    - [Identity and access management for HPC - Energy landing zone accelerator](./energy/identity-access-management.md)
    - [Management for HPC - Energy landing zone accelerator](./energy/management.md)
    - [Network topology and connectivity for HPC - Energy landing zone accelerator](./energy/network-topology-connectivity.md)
    - [Platform automation and devops for HPC - Energy landing zone accelerator](./energy/platform-automation-devops.md)
    - [Management group and subscription organization for HPC - Energy landing zone accelerator](./energy/resource-organization.md)
    - [Governance disciplines for HPC - Energy](./energy/security-governance-compliance.md)
    - [Security disciplines for HPC - Energy](./energy/security.md)
    - [Storage](./energy/storage.md)
  
- Manufacturing 
    - [Azure billing and HPC - Energy landing zone accelerator](./manufacturing/azure-billing-active-directory-tenant.md)
    - [Identity and access management for HPC - Energy landing zone accelerator](./manufacturing/identity-access-management.md)
    - [Management for HPC - Energy landing zone accelerator](./manufacturing/management.md)
    - [Network topology and connectivity for HPC - Energy landing zone accelerator](./manufacturing/network-topology-connectivity.md)
    - [Platform automation and devops for HPC - Energy landing zone accelerator](./manufacturing/platform-automation-devops.md)
    - [Management group and subscription organization for HPC - Energy landing zone accelerator](./manufacturing/resource-organization.md)
    - [Governance disciplines for HPC - Energy](./manufacturing/security-governance-compliance.md)
    - [Security disciplines for HPC - Energy](./manufacturing/security.md)
    - [Storage](./manufacturing/storage.md)

- Finance
    - [Azure billing and HPC - Energy landing zone accelerator](./finance/azure-billing-active-directory-tenant.md)
    - [Identity and access management for HPC - Energy landing zone accelerator](./manufacturing/identity-access-management.md)
    - [Management for HPC - Energy landing zone accelerator](./finance/identity-access-management.md)
    - [Network topology and connectivity for HPC - Energy landing zone accelerator](./finance/network-topology-connectivity.md)
    - [Platform automation and devops for HPC - Energy landing zone accelerator](./finance/platform-automation-devops.md)
    - [Management group and subscription organization for HPC - Energy landing zone accelerator](./finance/management.md)
    - [Governance disciplines for HPC - Energy](./finance/security-governance-compliance.md)
    - [Security disciplines for HPC - Energy](./finance/security.md)
    - [Storage](./finance/storage.md)

## Example conceptual energy reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices for energy environments.

:::image type="content" alt-text="Network interconnect Compute and Storage - Seismic Interpretation and Modeling" source="./media/network-interconnect.png" lightbox="./media/network-interconnect.png":::

## Example conceptual finance reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices for finance environments.

:::image type="content" alt-text="hpc finance architecture example" source="./media/hpc-finance-architecture-example.png" lightbox="./media/hpc-finance-architecture-example.png":::


## Example conceptual manufacturing reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices for manufacturing environments.

:::image type="content" alt-text="hpc manufacturing architecture example" source="./media/hpc-manufacturing-architecture-example.png" lightbox="./media/HPC-manufacturing-architecture-example.png":::

## Obtain the HPC landing zone accelerator

The [Azure HPC OnDemand Platform Accelerator](https://azure.github.io/az-hop/) helps to create an end to end deployment mechanism for a complete HPC cluster solution in Azure. Based on the business specific requirements, you can build on top of this and make updates as required.

## Next steps

- Review the HPC  landing zone accelerator critical design areas to make complete considerations and recommendations for your HPC  landing zone accelerator architecture. See [HPC {{Insert-accelerator-name}} landing zone accelerator](./energy/identity-access-management.md).
