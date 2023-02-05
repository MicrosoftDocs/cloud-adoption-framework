---
title: Enterprise-scale support for Citrix on Azure
description: Learn how enterprise-scale support for the Citrix on Azure.
author: bebaur
ms.author: wasaleem
ms.date: 01/06/2023
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-avd
---

# Adopt the Citrix Cloud and Azure Landing Zone Accelerator

Citrix and Microsoft partnered together to accelerate the future of work. Employees need a consistent experience and seamless access to the applications and insights vital to doing their best work wherever work needs to get done – in the office, on the road, or at home.

This reference implementation adheres to the architecture and best practices of the Cloud Adoption Framework's Azure landing zones with a particular focus on the enterprise-scale design principles. Although this implementation can be deployed in any Azure environment that complies with the [prerequisites](https://github.com/Azure/avdaccelerator/wiki/Getting-Started#Getting-Started), It is recommended to use this solution after implementing an enterprise-scale landing zone, [enterprise-scale overview](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/) and [implementation guidance](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) before deploying the enterprise-scale for Desktop Virtualization solution.

**Customer Profile**

This scenario is ideal if:

- Critical applications or services are identified that will remain on-premises
- Migration from on-premises to Azure will occur in multiple phases but requires seamless access by end users throughout the project
- Advanced security capabilities such as granular peripheral controls (USB, clipboard, printing, etc.), session recording, or screen capture/keylogging protection to securely accommodate user workflows or maintain compliance when required
- Use cases utilize 3D graphics or require connectivity over challenging networks (low bandwidth, high latency)
- Require a unified platform for secure remote access to virtual desktops and physical workstations
- Built-in image lifecycle and provisioning tools to assist in streamlining management of large, complex portfolios of virtual app or virtual desktops use cases
- Software vendor recommendation to use Citrix for application delivery
- Support for Linux workloads is required
- Support for non-persistent workloads is required
- Non-Microsoft solutions for collaboration, authentication, or identity are required
- B2B or guest user access is required

The above list is not all inclusive of Citrix capabilities when deployed with Microsoft solutions for more information please refer to the following for additional customer scenarios: [Citrix Tech Zone – Enhancing Azure Virtual Desktop](https://docs.citrix.com/en-us/tech-zone/learn/tech-briefs/windows-virtual-desktop-value-add.html).

**Design guidelines**

Design guidance for Citrix DaaS on Microsoft Azure is available on Citrix TechZone and highlights the system, workload, user, and network considerations for Citrix technologies in alignment with Cloud Adoption Framework design principles.
Learn the guidelines that direct the design of the Cloud Adoption Framework for Azure enterprise-scale landing zone. The guidelines cover eight critical design areas:

- [Enterprise enrollment](../eslz-enterprise-enrollment.md)
- [Identity and access management](../landing-zone-for-citrix/ctx-identity-and-access-management.md)
- [Network topology and connectivity](../landing-zone-for-citrix/ctx-network-topology-and-connectivity.md)
- [Resource organization](../landing-zone-for-citrix/ctx-resource-organization.md)
- [Security, governance, and compliance](../landing-zone-for-citrix/ctx-security-governance-and-compliance.md)
- [Management and monitoring](../landing-zone-for-citrix/ctx-management-and-monitoring.md)
- [Business continuity and disaster recovery](../landing-zone-for-citrix/ctx-business-continuity-and-disaster-recovery.md)

## Architecture

The following diagram shows a conceptual reference architecture that demonstrates major design areas and design best practices in an Citrix Cloud and Azure environment.

**Single subscription deployment**
[![Diagram of the hub and spoke with hybrid connectivity scenario](../media/citrix-cloud-azure-virtual-desktop-architecture-1.png)](../media/citrix-cloud-azure-virtual-desktop-architecture-1.png#lightbox)

Download the [Visio file](../media/Citrix-accelerator-enterprise-scale-alz-architecture.vsdx) here.

## Next steps

Review the critical design considerations and recommendations for identity and access management specific to the deployment of Citrix on Azure.

- [Identity and access management](./ctx-identity-and-access-management.md)
