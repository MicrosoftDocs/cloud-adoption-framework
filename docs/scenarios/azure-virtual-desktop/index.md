---
title: Migrate end-user desktops to Azure Virtual Desktop
description: Use the Cloud Adoption Framework best practices to migrate end-user desktops to Azure Virtual Desktop.
author: Zimmergren
ms.author: pnp
ms.date: 07/19/2023
ms.topic: conceptual
ms.custom: think-tank, e2e-avd
---

# Migrate end-user desktops to Azure Virtual Desktop

Migrating an organization's end-user desktops to the cloud is a common scenario in cloud migrations. Doing so helps improve employee productivity and accelerate the migration of various workloads to support the organization's user experience.

## Components of the scenario

This scenario is designed to guide the end-to-end customer journey, throughout the cloud adoption lifecycle. Completing the journey requires a few key guidance sets:

- **Cloud Adoption Framework:** These articles walk through the considerations and recommendations of each CAF methodology. Use these articles to prepare decision makers, central IT, and the cloud center of excellence for adoption of Azure Virtual Desktop as a central part of your technology strategy.
- **Reference architectures:** These reference solutions aid in accelerating deployment of Azure Virtual Desktop.
- **Featured Azure products:** Learn more about the products that support your virtual desktop strategy in Azure.
- **Training modules:** Gain the hands-on skills required to implement, maintain, and support an Azure Virtual Desktop environment.

## Common customer journeys

- **Azure Virtual Desktop reference architecture:** The [Azure Virtual Desktop reference architecture](./enterprise-scale-landing-zone.md) demonstrates how to deploy a proven architecture for Azure Virtual Desktop in your environment. This architecture is a suggested starting point for Azure Virtual Desktop.

- **Migrate existing virtual desktops to Azure:** A common use case for Azure Virtual Desktop is to modernize an existing virtual desktop environment. While the process can vary, there are several components to a successful migration, like session hosts, user profiles, images, and applications. If you're migrating existing VMs, you can review articles on migration to learn how tools like [Azure Migrate](/azure/migrate/migrate-services-overview) can speed up your migration as part of a standard migration process. However, your migration might consist of bringing your golden image into Azure and provisioning a new Azure Virtual Desktop host pool with new session hosts. You can migrate your existing user profiles into Azure and build new host pools and session hosts as well. A final migration scenario might include migrating your applications into MSIX app attach format. For all of these migration scenarios, you need to provision a new host pool because there's currently no direct migration of other virtual desktop infrastructure (VDI) solutions into Azure Virtual Desktop.

- **Prepare for governance and operations at scale:** Enterprise-scale support for Azure Virtual Desktop demonstrates how you can use enterprise-scale landing zones to ensure consistent governance, security, and operations across multiple landing zones for centralized management of virtual desktop environments.

- **Implement specific Azure products:** Accelerate and improve virtual desktop capabilities using different Azure products outlined in the featured products section.

## Next steps

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for Azure Virtual Desktop](./strategy.md)
- [Plan for Azure Virtual Desktop](./plan.md)
- [Migrate to Azure Virtual Desktop](./migrate-assess.md)
- [Manage an Azure Virtual Desktop environment](./manage.md)
- [Govern an Azure Virtual Desktop environment](./govern.md)
