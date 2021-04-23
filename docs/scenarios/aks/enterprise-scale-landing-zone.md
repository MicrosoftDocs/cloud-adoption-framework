---
title: Construction set for AKS enterprise-scale scenario
description: Use the Azure Kubernetes Service (AKS) construction set to help you create enterprise-scale landing zones that support AKS.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

# Construction set for AKS enterprise-scale scenario

The enterprise scale AKS construction set represents the strategic design path and target technical state for an Azure Kubernetes Service (AKS) landing zone. The AKS construction set provides an architectural approach and reference implementation to deploy a scalable Azure Kubernetes Service (AKS) cluster into a prepared Enterprise-scale landing zone. The implementation of construction set landing zones adhere to the architecture and best practices of the Cloud Adoption Framework.

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
- A Microsoft-approved AKS reference implementation based on the [AKS secure baseline](https://github.com/mspnp/aks-secure-baseline)

## Design guidelines

These articles provide guidelines for creating your landing zone:

- [Identity and access management for AKS enterprise-scale scenario](./eslz-identity-and-access-management.md)
- [Network topology and connectivity for AKS enterprise-scale scenario](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring for AKS enterprise-scale scenario](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery for AKS enterprise-scale scenario](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance for AKS enterprise-scale scenario](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps for AKS enterprise-scale scenario](./eslz-platform-automation-and-devops.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows a golden state for an enterprise scale landing zone with a corporate landing zone subscription and shows design areas and best practices.

![Enterprise architecture](./media/Golden-state-for-enterprise-architecture-with-AKS-cluster.png)





## AKS Construction Set RI for Online Landing Zone

The AKS construction set reference implementation (RI) is an open-source collection of Terraform templates, available in [this GitHub repo](https://github.com/Azure/caf-terraform-landingzones-starter/tree/starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline). This RI is based on the [AKS secure baseline](https://github.com/mspnp/aks-secure-baseline) and currently deploys a simplistic version of an AKS implementation that can sit in its own subscription within the online management group of an ESLZ. An application deployed in the subscription for an online landing zone will be internet-facing, and does not require hybrid connectivity.



![Responsibility zones](./media/aks-enterprise-scale-landing-zone.png)

## Next steps

- Review the AKS construction set critical design areas to make complete considerations and recommendations for your AKS construction set architecture. See [Azure Kubernetes Service (AKS) enterprise-scale scenario](./eslz-identity-and-access-management.md).
