---
title: Enterprise-scale for Microsoft Azure VMware Solution
description: Learn how enterprise-scale can accelerate the adoption of Microsoft Azure VMware Solution.
author: pgandham
ms.author: tozimmergren
ms.reviewer: tozimmergren
ms.date: 02/17/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-azure-vmware, think-tank, engagement-fy23
---

# Azure VMware Solution landing zone accelerator

Azure VMware Solution landing zone accelerator is an open-source collection of Azure Resource Manager and Bicep templates. It represents the strategic design path and target technical state for an Azure VMware Solution deployment. This open-source solution provides an architectural approach and reference implementation to prepare Azure landing zone subscriptions for a scalable Azure VMware Solution. The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones, focusing on enterprise-scale design principles.

The following guidance provides design considerations for implementing a scalable Azure VMware Solution in your landing zone. Based on this guidance, your organization's design decisions lays the groundwork for scalability.

Customers adopt Azure VMware Solution in various ways. You can adapt the enterprise scale for your Azure VMware Solution set to produce an architecture that fits your needs and puts your organization on a path to a sustainable scale.

Azure VMware Solution landing zone accelerator provides these assets to support your project:

- A modular approach to customize environment variables
- Design guidelines to aid in evaluating critical decisions
- Landing zone architecture
- An implementation that includes:
  - A deployable reference to create the environment for your Azure VMware Solution deployment
  - A Microsoft-approved Azure VMware Solution reference implementation to test the deployed environment

## Prerequisites

The Azure VMware Solution construction set assumes that you've successfully implemented an enterprise-scale landing zone. For more information about enterprise-scale landing zones, see:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## Design guidelines

The following articles provide guidelines for creating your landing zone:

- [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
- [Network topology and connectivity for Azure VMware Solution](./eslz-network-topology-connectivity.md)
- [Management and monitoring for an Azure VMware Solution enterprise-scale scenario](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery for Azure VMware Solution enterprise-scale scenario](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance for Azure VMware Solution](./eslz-security-governance-and-compliance.md)
- [Platform automation for Azure VMware Solution enterprise-scale scenario](./eslz-platform-automation-and-devops.md)

## Architecture

The following architecture diagram is an example that shows design areas and best practices.

[![Azure VMware Solution landing zone accelerator architecture](./media/azure-vmware-eslz-architecture.png)](./media/azure-vmware-eslz-architecture.png#lightbox)

For more information on the design areas labeled A-I in the visual, see [environment design areas](/azure/cloud-adoption-framework/ready/landing-zone/design-areas#environment-design-areas).

## Next steps

Review design considerations and recommendations related to identity and access management specific to the deployment of Azure VMware Solution.

> [!div class="nextstepaction"]
> [Enterprise-scale identity and access management for Azure VMware Solution](./eslz-identity-and-access-management.md)
