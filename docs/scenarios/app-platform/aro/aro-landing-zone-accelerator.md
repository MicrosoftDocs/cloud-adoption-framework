---
title: ARO landing zone accelerator
description: Learn to deploy ARO Landing Zone Accelerator.
author: UmarMohamedUsman
ms.author: umarm
ms.date: 06/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-ARO
---

# ARO landing zone accelerator

ARO landing zone accelerator represents the strategic design path and target technical state for an Azure Red Hat OpenShift (ARO) deployment. This solution provides an architectural approach and reference implementation to prepare landing zone subscriptions for a scalable Azure Red Hat OpenShift (ARO) cluster. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones.

This solution is open source. You can adapt the templates to create an architecture that meets your needs. The following guidance provides design considerations for implementing a scalable ARO cluster in your landing zone. The design decisions your organization makes, based on this guidance, can lay the groundwork for scalability.

## Implement a platform foundation

ARO landing zone accelerator assumes that a platform foundation that takes care of the shared services (network, security, identity, and governance) required to effectively construct and operationalize a landing zone has been successfully implemented. This isn't mandatory when implementing ARO landing zone accelerator, but it does handle much of the security and management required to safely manage your cloud environment. If you already have one, you can skip this step. For more information on this, review these articles:

- [Implement Cloud Adoption Framework Azure landing zone](../../ready/landing-zone)

## What the ARO landing zone accelerator provides

The landing zone accelerator approach for ARO provides these assets to support your project:

- A modular approach that allows you to customize your environment variables.
- Design guidelines for evaluating critical decisions.
- The landing zone architecture.
- A Microsoft-recommended ARO reference implementation using Azure CLI.

## Design areas

These articles provide guidelines for creating your landing zone based on the design areas of Azure landing zones:

- [Identity and access management](./aro-identity-and-access-management.md)
- [Network topology and connectivity](./aro-network-topology-and-connectivity.md)
- [Resource organization](./aro-resource-organization.md)
- [Security](./aro-security.md)
- [Operations management and BCDR](./aro-operations-Management-and-BCDR.md)
- [Deployment options](./aro-platform-automatoin-devops.md)

## Reference architecture

The following diagram shows ARO Landing Zone Accelerator architecture.

[![ARO landing zone accelerator architecture](./media/aro_landing_zone_Architecture.png)](./media/aro_landing_zone_Architecture.png)

## Deploy ARO landing zone accelerator

ARO landing zone accelerator is an open-source repo consist of Azure CLI reference implementation along with Critical Design Area recommendations, available in the [`ARO landing zone accelerator`](https://aka.ms/aro-landing-zone-accelerator) repo.

## Next steps

Learn about design considerations for identity and access management in your Azure landing zones.

[Identity and access management for Azure Red Hat Openshift (ARO) landing Zone accelerator scenario](./aro-identity-and-access-management.md).
