---
title: Construction set for AKS enterprise-scale scenario
description: Use the Azure Kubernetes Service (AKS) construction set to help you create enterprise-scale landing zones that support AKS.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Construction set for AKS enterprise-scale scenario

The AKS construction set is an open-source collection of Terraform templates that you can use to automate the deployment of an environment capable of hosting Azure Kubernetes Service (AKS). It can provide a specific architectural approach and reference implementation to prepare your enterprise-scale landing zones. The landing zones adhere to the architecture and best practices of the Cloud Adoption Framework.

Customers adopt AKS in various ways. The construction set can be adapted to produce an architecture that fits *your* way and puts your organization on a path to sustainable scale.

## To begin, implement an enterprise-scale landing zone

The AKS construction set assumes that an enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## What the AKS construction set provides

The construction set approach to landing zones provides these assets to support your project:

- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- The landing zone architecture
- An implementation that includes:
  - A deployable reference capable of creating the environment for your AKS deployment
  - A Microsoft-approved AKS reference implementation to test the deployed environment

## Design guidelines

These articles provide guidelines for creating your landing zone:

- [Azure Kubernetes Service (AKS) enterprise-scale scenario](./eslz-identity-and-access-management.md)
- [Network topology and connectivity for AKS Enterprise-Scale scenario](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring for AKS Enterprise-Scale scenario](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery for AKS Enterprise-Scale scenario](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance for AKS Enterprise-Scale scenario](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps for AKS enterprise-scale scenario](./eslz-platform-automation-and-devops.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices.

![Responsibility zones](media/aks_enterprise_scale_lz.png)

## Obtain the AKS construction set

The AKS construction set is an open-source collection of Terraform templates. You find it in GitHub: [Azure / caf-terraform-landingzones-starter](https://github.com/Azure/caf-terraform-landingzones-starter/tree/starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline).

The templates are of two types:

- Terraform modules that deploy infrastructure components like virtual machines, networks, or storage to Azure.
- Ansible playbooks that run different roles to configure virtual machines, and to install AKS HANA and required applications, on the already deployed infrastructure.

## Next steps

- Review the AKS construction set critical design areas to make complete considerations and recommendations for your AKS construction set architecture. See [Azure Kubernetes Service (AKS) enterprise-scale scenario](./eslz-identity-and-access-management.md).
