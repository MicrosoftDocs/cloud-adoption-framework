---
title: AKS landing zone accelerator
description: Overview of the AKS landing zone accelerator.
author: Zimmergren
ms.author: pnp
ms.date: 02/25/2022
ms.topic: conceptual
ms.custom: think-tank, e2e-aks
---

# AKS landing zone accelerator

The AKS landing zone accelerator represents the strategic design path and target technical state for an Azure Kubernetes Service (AKS) deployment. This solution provides an architectural approach and reference implementation to prepare landing zone subscriptions for a scalable Azure Kubernetes Service (AKS) cluster. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones with a focus on the design principles of enterprise-scale.

This solution is open source. You can adapt the templates to create an architecture that meets your needs. The following guidance provides design considerations for implementing a scalable AKS cluster in your landing zone. The design decisions your organization makes, based on this guidance, can lay the groundwork for scalability.

## Implement a platform foundation

The AKS landing zone accelerator assumes that a platform foundation that takes care of the shared services (network, security, identity, and governance) required to effectively construct and operationalize a landing zone has been successfully implemented. This isn't mandatory when implementing the AKS landing zone accelerator, but it does handle much of the security and management required to safely manage your cloud environment. If you already have one, you can skip this step. For more information on this, review these articles:

- [Implement Cloud Adoption Framework Azure landing zone](../../../ready/landing-zone/index.md)

## What the AKS landing zone accelerator provides

The landing zone accelerator approach provides these assets to support your project:

- A modular approach that allows you to customize your environment variables.
- Design guidelines for evaluating critical decisions.
- The landing zone architecture.
- A Microsoft-recommended AKS reference implementation based on the [AKS baseline](/azure/architecture/reference-architectures/containers/aks/secure-baseline-aks).

## Design areas

These articles provide guidelines for creating your landing zone based on the design areas of Azure landing zones:

- [Identity and access management](./identity-and-access-management.md)
- [Network topology and connectivity](./network-topology-and-connectivity.md)
- [Resource organization](./resource-organization.md)
- [Security](./security.md)
- [Management and BCDR](./management.md)
- [Platform automation and DevOps](./platform-automation-and-devops.md)
- [Storage](./storage.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows a golden state for an Azure landing zone with a corporate landing zone subscription and shows design areas and best practices.

[![Diagram that shows the A K S landing zone accelerator architecture.](./media/aks-eslz-architecture.png)](./media/aks-eslz-architecture.png#lightbox)

## Deploy AKS landing zone accelerator

AKS landing zone accelerator is an open-source collection of ARM, Bicep and Terraform templates, available in the [`AKS landing zone accelerator`](https://aka.ms/aks-reference-implementation) repo.

These templates are used to deploy infrastructure components such as virtual machines, networks, or storage to Azure. To get the templates, see the [`AKS landing zone accelerator`](https://aka.ms/aks-reference-implementation) repo. There, you will find various scenarios to help get you started on setting up your AKS environment quickly. Conceptually, this workload should sit in the landing zones management group of an Azure landing zone platform foundation as indicated in the image above.

## Next steps

Learn about design considerations for identity and access management in your Azure landing zones.

- [Identity and access management for Azure Kubernetes Service (AKS) landing Zone accelerator scenario](./identity-and-access-management.md)
