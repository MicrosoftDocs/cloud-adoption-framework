---
title: "Enterprise-Scale support for AKS Construction Set"
description: Describe how enterprise-scale can accelerate adoption of AKS
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# enterprise-scale support for AKS construction set
  
enterprise-scale construction sets provide a specific architectural approach and reference implementation to prepare your enterprise-scale landing zones for mission critical technology platforms and any supported workloads. This construction set enables the creation of a landing zone environment that can support the AKS platform at enterprise-scale, while adhering to the architecture and best practices of the Cloud Adoption Framework enterprise-scale landing zone.

## Prerequisite

The AKS Construction Set assume that enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review the enterprise-scale [overview](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) and [implementation guidance](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/implementation) before deploying the AKS construction set.

## Objective

Not all customers adopt AKS in the same way, so the AKS construction set architecture varies between customers. The technical considerations and design recommendations of the AKS Construction Set might lead to different trade-offs based on your organization's scenario. If you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale, in spite of minor variation.

## Process

The AKS Construction Set is modular by design so customers can customized environmental variables. The construction set approach to landing zones includes three sets of assets to support cloud teams:

- Design guidelines to aid in evaluating critical decisions
- Architecture to illustrate the end-state of the landing zone architecture
- Implementation to provide a deployable reference capable of creating the environment for your AKS deployment. 
  - This implementation also includes a Microsoft approved AKS reference implementation to test AKS deployment in the deployed environment.

## Design guidelines

Guide to the critical decisions that drive the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. There are 6 critical design areas that can be used to review and modify your enterprise-scale landing zone or any other Azure Landing Zone implementation:

- [Identity and Access Management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance and compliance](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps](./eslz-platform-automation-and-devops.md)

## Architecture

Conceptual reference architecture that demonstrates design areas and best practices. example below

![Responsibility Zones](media\aks_enterprise_scale_lz.png)

## Implementation

AKS construction set is an open-source collection of Terraform templates to automate the deployment of an environment capable of hosting a enterprise-scale Kubernetes cluster in Azure, using Azure Kubernetes Service (AKS).

The templates are split into:
Terraform modules which deploy the infrastructure components (such as VMs, network, storage) in Azure.
Ansible playbooks which run different roles to configure and VMs and install AKS HANA and required applications on the already deployed infrastructure.

Github repo: [AKS construction set](https://github.com/Azure/caf-terraform-landingzones-starter/tree/starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline)

## Next steps

Review the AKS construction Set critical design areas to make complete considerations and recommendations for your AKS Construction set architecture. [Identity and Access Management](./eslz-identity-and-access-management.md)
