---
title: Migrate end-user desktops to Azure Virtual Desktop
description: Use the Cloud Adoption Framework best practices to migrate end-user desktops to Azure Virtual Desktop.
author: stephen-sumner
ms.author: pnp
ms.date: 03/06/2026
ms.topic: concept-article
ms.custom: think-tank, e2e-avd
---

# Migrate end-user desktops to Azure Virtual Desktop

Migrating an organization's end-user desktops to the cloud is a common scenario in cloud migrations. Doing so helps improve employee productivity and accelerate the migration of various workloads to support the organization's user experience. This guidance follows the Cloud Adoption Framework's [Adopt methodology](/azure/cloud-adoption-framework/migrate/plan-migration), specifically the Migrate approach, to help organizations successfully transition to Azure Virtual Desktop.

## Components of the scenario

This scenario is designed to guide the end-to-end customer journey, throughout the cloud adoption lifecycle. Completing the journey requires a few key guidance sets:

- **Cloud Adoption Framework**: These articles map Azure Virtual Desktop guidance across the Cloud Adoption Framework methodologies (strategy, plan, ready, adopt, govern, and manage). Use these articles to prepare decision makers, central IT, and the cloud center of excellence for adoption of Azure Virtual Desktop as a central part of your technology strategy.
- **Application landing zone accelerator**: The [Azure Virtual Desktop application landing zone accelerator](https://github.com/Azure/avdaccelerator) provides infrastructure as code templates and proven deployment patterns that implement enterprise-scale best practices.
- **Reference architectures**: These reference solutions aid in accelerating deployment of Azure Virtual Desktop.

- **Featured Azure products**: Learn more about the products that support your virtual desktop strategy in Azure.
- **Training modules**: Gain the hands-on skills required to implement, maintain, and support an Azure Virtual Desktop environment.

## Common customer journeys

- **Azure Virtual Desktop reference architecture**: The [Azure Virtual Desktop reference architecture](./enterprise-scale-landing-zone.md) demonstrates how to deploy a proven architecture for Azure Virtual Desktop in your environment. This architecture is a suggested starting point for Azure Virtual Desktop.

- **Prepare for enterprise-scale deployment**: Before migrating existing virtual desktops, establish an enterprise-scale Azure landing zone to ensure consistent governance, security, and operations. The [application landing zone accelerator for Azure Virtual Desktop](https://github.com/Azure/avdaccelerator) provides Infrastructure as Code templates to implement best practices and accelerate deployment.

- **Migrate existing virtual desktops to Azure**: A common use case for Azure Virtual Desktop is to modernize an existing virtual desktop environment. Because Azure Virtual Desktop uses a platform-as-a-service (PaaS) control plane that differs architecturally from traditional VDI solutions, there is no direct migration path from other VDI platforms. Instead, your migration will involve:
  - **Session hosts and images**: Migrate your golden images into Azure or create new ones, then provision new Azure Virtual Desktop host pools with session hosts.
  - **User profiles**: Migrate existing user profiles into Azure (such as to Azure Files for FSLogix containers) or build new profiles.
  - **Applications**: Deploy applications using App Attach (formerly MSIX app attach) or install them directly on session host images.
  - **Infrastructure assessment**: Services like [Azure Migrate](/azure/migrate/migrate-services-overview) can help assess your existing infrastructure and dependencies as part of a standard migration process, though actual AVD deployment requires provisioning new host pools.

- **Implement specific Azure products**: Accelerate and improve virtual desktop capabilities using different Azure products outlined in Azure Virtual Desktop documentation.

## Next steps

The following list of articles will take you to guidance at specific points in the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Strategy for Azure Virtual Desktop](./strategy.md)
- [Plan for Azure Virtual Desktop](./plan.md)
- [Migrate to Azure Virtual Desktop](./migrate-assess.md)
- [Manage an Azure Virtual Desktop environment](./manage.md)
- [Govern an Azure Virtual Desktop environment](./govern.md)
