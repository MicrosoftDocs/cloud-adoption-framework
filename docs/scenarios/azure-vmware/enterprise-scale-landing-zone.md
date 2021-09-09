---
title: Enterprise-scale support for Azure VMware Solution
description: <<Describe how enterprise-scale can accelerate adoption of Azure VMware Solution.>>
author: pgandham
ms.author: janet
ms.date: 06/28/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise Scale for Azure VMware Solution

Enterprise-scale for AVS represents the strategic design path and target technical state for an Azure VMware Solution (AVS) deployment. This solution provides an architectural approach and reference implementation to prepare landing zone subscriptions for a scalable Azure VMware Solution (AVS). The implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones with a focus on the design principles of enterprise-scale. Review the enterprise-scale overview and implementation guidance before deploying enterprise-scale for SAP on Azure.

This solution is open source. The following guidance provides design considerations for implementing a scalable AVS  in your landing zone. The design decisions your organization makes, based on this guidance, can lay the groundwork for scalability.

Customers adopt Azure VMware Solution in various ways. The Enterprise-Scale for AVS set can be adapted to produce an architecture that fits **your** way and puts your organization on a path to sustainable scale.

## To begin, implement an enterprise-scale landing zone

The Azure VMware Solution construction set assumes that an enterprise-scale landing zone has been successfully implemented. For more information on this prerequisite, review these articles:

- [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md)
- [Implement Cloud Adoption Framework enterprise-scale landing zones in Azure](../../ready/enterprise-scale/implementation.md)

## What enterprise-scale for AVS provides

The enterprise-scale approach for AVS provides these assets to support your project:
- A modular approach, so that you can customize environment variables
- Design guidelines to aid in evaluating critical decisions
- The landing zone architecture
- An implementation that includes:
  - A deployable reference capable of creating the environment for your Azure VMware Solution deployment
  - A Microsoft-approved Azure VMware Solution reference implementation to test the deployed environment

## Design guidelines

These articles provide guidelines for creating your landing zone:

- [Azure VMware Solution enterprise-scale scenario](./eslz-identity-and-access-management.md)
- [Network topology and connectivity for Azure VMware Solution enterprise-scale scenario](./eslz-network-topology-and-connectivity.md)
- [Management and monitoring for Azure VMware Solution enterprise-scale scenario](./eslz-management-and-monitoring.md)
- [Business continuity and disaster recovery for Azure VMware Solution enterprise-scale scenario](./eslz-business-continuity-and-disaster-recovery.md)
- [Security, governance, and compliance for Azure VMware Solution enterprise-scale scenario](./eslz-security-governance-and-compliance.md)
- [Platform automation and DevOps for Azure VMware Solution enterprise-scale scenario](./eslz-platform-automation-and-devops.md)

## Example conceptual reference architecture

The following conceptual reference architecture is an example that shows design areas and best practices.

[![Enterprise-scale for AVS architecture](./media/avs-eslz-architecture.png)](./media/avs-eslz-architecture.png#lightbox)

Enterprise-scale for AVS is an open-source collection of ARM, BiCep templates, available in the [enterprise-scale for AVS
 repo](https://github.com/Azure/Enterprise-Scale-for-AVS)

BiCep  templates are used to deploy infrastructure components such as AVS,virtual machines, networks, or storage to Azure. To get the templates, see the [enterprise-scale for Azure VMware Solution using BiCep](https://github.com/Azure/Enterprise-Scale-for-AVS) using BiCep. This reference implementation currently deploys a simplistic version of an AVS implementation that resides in its own subscription within the online management group of an enterprise-scale landing zone. 

## Implementation with Bicep/Azure Resource Manager (ARM) templates for Remote Desktop Services
ARM Azure VMware Solution templates provide a collection of infrastructure-as-code Bicep/ARM templates to deploy an Azure VMware Solution environment on Azure.

The automate Azure VMware Solution deployments in Azure GitHub repository contains code that lets you automatically deploy Azure Virtual Desktop environments in the Azure cloud.


## Next steps

- Review the Azure VMware Solution construction set critical design areas to make complete considerations and recommendations for your Azure VMware Solution construction set architecture. See [Azure VMware Solution enterprise-scale scenario](./eslz-identity-and-access-management.md).

