---
title: Enterprise-scale for AKS
description: Deploy Enterprise-scale for AKS.
author: BrianBlanchard
ms.author: brblanch
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: think-tank, e2e-aks
---

# Enterprise-scale for AKS

Enterprise-scale for AKS represents the strategic design path and target technical state for an Azure Kubernetes Service (AKS) deployment. This solution provides an architectural approach and reference implementation to prepare landing zone subscriptions for a scalable Azure Kubernetes Service (AKS) cluster. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure Landing Zones with a focus on the design principles of Enterprise-scale.

Customers adopt AKS in various ways. This solution can be adapted to produce an architecture that fits *your* way and puts your organization on a path to sustainable scale.

## To begin, implement an enterprise-scale landing zone

Enterprise-scale for AKS assumes that an enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## What Enterprise-scale for AKS provides

The Enterprise-scale for AKS approach provides these assets to support your project:

- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- The landing zone architecture
- An implementation that includes:
  - A deployable reference capable of creating the environment for your AKS deployment
  - A Microsoft-approved AKS reference implementation to test the deployed environment

## Design areas

These articles provide guidelines for creating your landing zone based on the design areas of Azure Landing Zones:

- [Enterprise enrollment](./eslz-enterprise-enrollment.md)
- [Identity and Access Management](./eslz-identity-and-access-management.md)
- [Network topology and connectivity](./eslz-network-topology-and-connectivity.md)
- [Resource Organization](./eslz-resource-organization.md)
- [Governance disciplines](./eslz-security-governance-and-compliance.md)
- [Operations management](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery](./eslz-business-continuity-and-disaster-recovery.md)
- [Deployment options](./eslz-platform-automation-and-devops.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices.

![Responsibility zones](./media/aks-enterprise-scale-landing-zone.png)

## Deploy Enterprise-scale for AKS

Enterprise-scale for AKS is an open-source collection of Terraform templates, available in [this GitHub repo](https://github.com/Azure/caf-terraform-landingzones-starter/tree/starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline).

There are two types of templates:

- Terraform modules that deploy infrastructure components like virtual machines, networks, or storage to Azure.
- Ansible playbooks that run different roles to configure virtual machines, and to install AKS HANA and required applications, on the already deployed infrastructure.

## Next steps

- Review Enterprise-scale for AKS design areas to make complete considerations and recommendations for your AKS architecture. See [Identity and Access Management](./eslz-identity-and-access-management.md).
