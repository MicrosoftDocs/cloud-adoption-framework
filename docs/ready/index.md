---
title: Ready your Azure environment for workloads
description: Understand Azure landing zone and the process to use one. 
author: stephen-sumner
ms.author: pnp
ms.date: 10/02/2025
ms.topic: conceptual
ms.custom: internal
ms.update-cycle: 1095-days
---

# Ready your Azure environment for workloads

Before you can deploy workloads in Azure, it's important to prepare the underlying environment that will support them. This foundational setup is known as an [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) is the recommended starting point to build your Azure environment. An Azure landing zone is a structured approach that helps you build a scalable, secure, and governed cloud environment from the start.

:::image type="content" source="../_images/ready/azure-landing-zone-conceptural-diagram.png" alt-text="Diagram showing the conceptual components of your cloud environment as it aligns with Azure landing zones." lightbox="../_images/ready/azure-landing-zone-conceptural-diagram.png" border="false":::

An Azure landing zone helps you address key considerations such as identity and access management, customer agreements, and the configuration of core platform services. It provides a consistent framework for organizing both shared infrastructure and application-specific resources. At the heart of this model are two types of landing zones:

## Platform landing zone

The platform landing zone serves as the backbone of your Azure environment. It establishes governance and central services that apply across your organization. These include:

- A management group hierarchy with Azure Policy enforcement across all resources.
- Dedicated subscriptions for connectivity, identity, management, and security shared services.

Depending on your organization's size and cloud maturity, you might choose to implement all, some, or none of these centralized services. For smaller or cloud-native teams, a lightweight approach might be sufficient.

## Application landing zone

The application landing zone is where your workloads live. Each application environment (development, testing, or production) has its own application landing zone. These zones:

- Consist of one or more subscriptions to accommodate scaling and service limits.
- Are nested under appropriate management groups, such as "Online" or "Corp", to inherit governance from the platform landing zone.

This structure ensures that workloads are deployed in a controlled and consistent manner, while still allowing flexibility for individual application needs.

## Services that apply across all subscriptions

Whether a subscription belongs to the platform or an application landing zone, certain services should be enabled universally. These include:

- Azure Role-Based Access Control (RBAC)
- Cost Management
- Network Watcher
- Microsoft Defender for Cloud

These services help maintain visibility, security, and operational control across your entire Azure environment. For more details, see [Azure landing zones](../../ready/landing-zone/index.md).

## Azure landing zone journey

As you work through the Ready guide, think of your progress as a journey toward creating a fully operational Azure landing zone. This journey unfolds in four major phases, each with supporting processes and tools:

:::image type="content" source="./landing-zone/media/customer-landing-zone-journey.png" alt-text="Diagram showing the Azure landing zone customer journey." border="false" lightbox="./landing-zone/media/customer-landing-zone-journey.png" :::

### 1. Bootstrap your environment

Start by creating the subscriptions that will host your resources. You can do this manually or programmatically:

  - [Create subscriptions manually](/azure/cost-management-billing/manage/create-subscription#create-a-subscription)
  - [Create subscriptions programatically](/azure/cost-management-billing/manage/programmatically-create-subscription)
  - [Subscription vending modules](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending)

### 2. Deploy platform landing zone components

Next, deploy the core components of your platform landing zone using one of several implementation options:

- [Accelerator portal](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options#azure-landing-zone-accelerator-approach)
- [Bicep modules](https://github.com/Azure/ALZ-Bicep)
- [Bicep Accelerator](https://github.com/Azure/ALZ-Bicep/wiki/Accelerator)
- [Terraform module](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Connectivity-Resources-With-Custom-Settings)

### 3. Subscription vending process

Once your platform is in place, you can provision application landing zones using vending modules:

- [Vending module (Terraform)](https://github.com/Azure/terraform-azurerm-lz-vending)
- [Vending module (Bicep)](https://github.com/Azure/bicep-registry-modules/tree/main/avm/ptn/lz/sub-vending)

### 4. Deploy workload landing zone components

Finally, deploy the components that support your specific workloads. These are often aligned with cloud adoption scenarios and supported by accelerators:

[Cloud adoption scenarios](../overview.md#what-specific-scenarios-does-the-cloud-adoption-framework-address)

Each phase builds on the previous one, guiding you toward a well-architected Azure environment. The Ready guide walks you through these steps in more detail.

## Next steps

> [!div class="nextstepaction"]
> [What is an Azure landing zone?](./landing-zone/index.md)
