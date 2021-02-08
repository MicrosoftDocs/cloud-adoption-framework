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
  
Enterprise-scale construction sets provide a specific architectural approach and reference implementation to prepare your enterprise-scale landing zones for mission critical technology platforms and any supported workloads. This construction set enables the creation of a landing zone environment that can support the AKS platform at enterprise-scale, while adhering to the architecture and best practices of the Cloud Adoption Framework enterprise-scale landing zone.

## Prerequisite

The AKS construction set assume that enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review the enterprise-scale [overview](../../ready/enterprise-scale/index.md) and [implementation guidance](../../ready/enterprise-scale/implementation.md) before deploying the AKS construction set.

## Objective

Not all customers adopt AKS in the same way or for the same reasons, so the AKS construction set architecture will vary between customers. The technical considerations and design recommendations of the AKS construction set might lead to different trade-offs based on your organization's scenario. If you follow the core recommendations, the resulting target architecture will set your organization on a path to sustainable scale, in spite of minor variation.

## Process

The AKS construction set is modular by design so customers can customize it. The construction set approach to landing zones includes three sets of assets to support cloud teams:

- Design guidelines to aid in evaluating critical decisions
- Architecture to illustrate the end-state of the landing zone architecture
- Implementation to provide a deployable reference capable of creating the environment for your AKS deployment
  - This implementation also includes a reference implementation built ontop of the [AKS Baseline Architecture](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks) to experience an AKS deployment in the deployed landing zone.

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

- Terraform modules which deploy the infrastructure components (such as network and cluster) in Azure.
- Bootstrapping the cluster with a GitOps operator.

All of this can be found at the [AKS construction set](https://github.com/Azure/caf-terraform-landingzones-starter/tree/starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline) in GitHub.

## Next steps

Review the AKS construction set critical design areas to make complete considerations and recommendations for your AKS construction set architecture. Start with [Identity and Access Management](./eslz-identity-and-access-management.md).

If you're not yet ready to dive into the AKS construction set for landing zones, review the [AKS Baseline Architecture](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks) to acquaint yourself with the fundamentals involved in a enterprise deployment of AKS.
