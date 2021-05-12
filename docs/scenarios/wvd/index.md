---
title: Migrate to or deploy Windows Virtual Desktop Session hosts to Azure
description: Use the Cloud Adoption Framework best practices to migrate or deploy Windows Virtual Desktop instances to Azure.
author: DominicAllen
ms.author: doalle
ms.date: 4/1/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
ms.custom: think-tank
---

# Migrate or deploy Windows Virtual Desktop instances to Azure

Migrating an organization's end-user desktops to the cloud is a common scenario in cloud migrations. Doing so helps improve employee productivity and accelerate the migration of various workloads to support the organization's user experience.

## Components of the scenario

This scenario is designed to guide the end-to-end customer journey, throughout the cloud adoption lifecycle. Completing the journey requires a few key guidance sets:

- **Cloud Adoption Framework:** These articles walk through the considerations and recommendations of each CAF methodology. Use these articles to prepare decision makers, central IT, and the cloud center of excellence for adoption of Windows Virtual Desktop as a central part of your technology strategy.
- **Reference architectures:** These reference solutions aid in accelerating deployment of Windows Virtual Desktop.
- **Featured Azure products:** Learn more about the products that support your virtual desktop strategy in Azure.
- **Microsoft Learn modules:** Gain the hands-on skills required to implement, maintain, and support a virtual desktop environment.

## Common customer journeys

**Windows Virtual Desktop reference architecture**: The reference architecture listed in the left pane demonstrates how to deploy a proven architecture for WVD in your environment. This architecture is a suggested starting point for Windows Virtual Desktop in Azure.

**Migrate existing Virtual Desktops to Azure**: A common use case for WVD is to modernize and existing virtual desktop environment. While the process can vary there are several components to a successful migration. Session Hosts, User Profiles, Images and Applications. If you are performing a lift and shift of existing VMs, articles on migration outline how tools such as Movere and Azure Migrate can accelerate the migration as part of a standard migration process. However your migration may consist of bringing your golden image into Azure and provisioning a new WVD Hostpool with new Session Hosts. Additionally you may migrate your existing user profiles into Azure and build new WVD Hostpools and Session Hosts as well. A final migration scenario may also include migrating your applications into MSIX format for AppAttach. In all these migration scenarios customers will need to provision a new WVD HostPool as there is no direct migration of other VDI solutions into Windows Virtual Desktop at this time.

**Prepare for governance and operations at scale**: The enterprise-scale for Windows Virtual Desktop guidance demonstrates how you can use enterprise-scale landing zones to ensure consistent governance, security, and operations across multiple landing zones for centralized management of virtual desktop environments.

**Implement specific Azure products**: Accelerate and improve virtual desktop capabilities using different kinds of Azure products outlined in the featured products section.

## Next steps

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for Windows Virtual Desktop](./WVD-strategy.md)
- [Plan for Windows Virtual Desktop](./plan.md)
- [Migrate to Windows Virtual Desktop](./migrate-assess.md)
- [Manage a Windows Virtual Desktop environment](./WVD-manage.md)
- [Govern a Windows Virtual Desktop environment](./WVD-govern.md)
