---
title: Prepare for cloud adoption
description: Learn how to create a landing zone to host the workloads that you plan to build in the cloud or migrate to the cloud.
author: Zimmergren
ms.author: tozimmergren
ms.date: 09/15/2023
ms.topic: conceptual
ms.custom: internal
---

# Prepare for cloud adoption

Before adoption can begin, you create a landing zone to host the workloads that you plan to build in or migrate to the cloud. This section of the framework guides you through environment preparation and landing zone creation.

## Landing zone concepts

A landing zone helps you plan for and design an Azure deployment. It conceptualizes a designated area for placement and integration of resources. There are [two types of landing zones](/azure/cloud-adoption-framework/ready/landing-zone/#platform-landing-zones-vs-application-landing-zones):

- Platform landing zone: Provides centralized, foundational services for workloads and applications. These  services support your workloads and include networking, identity access management, policies, and monitoring. This foundation enables migration, modernization, and innovation in Azure.

- Application landing zone: provides services specific to an application or workload. A workload deployed to an application landing zone integrates with and is dependent upon services provided by the platform landing zone.

There are two steps to designing and deploying a landing zone:

- Reference architecture: A specific design that illustrates resource deployment to one or more Azure subscriptions, which meet the requirements of the landing zone.

- Reference implementation: Artifacts that deploy Azure resources into the landing zone subscription(s), according to the reference architecture. There are many [platform and application landing zone deployment options](/azure/architecture/landing-zones/landing-zone-deploy). These deployment options automate and accelerate the deployment of a reference implementation, using IaC technology such as ARM, Bicep, Terraform, and others.

## Landing zone journey

:::image type="content" source="./landing-zone/media/customer-landing-zone-journey.png" alt-text="Diagram showing the Azure landing zone customer journey." border="false" lightbox="./landing-zone/media/customer-landing-zone-journey.png" :::

As you work your way through the Ready guide, consider your progress as a continuous journey that prepares you for landing zone creation. The journey consists of four major phases and related processes:

- Bootstrap your environment
  - [Create subscriptions manually](/azure/cost-management-billing/manage/create-subscription#create-a-subscription)
  - [Create subscriptions programatically](/azure/cost-management-billing/manage/programmatically-create-subscription)
  - [Subscription vending modules](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending)

- Deploy Azure platform landing zone components
  - [Accelerator portal](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options#azure-landing-zone-accelerator-approach)
  - [Bicep modules](https://github.com/Azure/ALZ-Bicep)
  - [Bicep Accelerator](https://github.com/Azure/ALZ-Bicep/wiki/Accelerator)
  - [Terraform module](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Connectivity-Resources-With-Custom-Settings)
- Subscription landing zone vending process
  - [Vending module (Terraform)](https://github.com/Azure/terraform-azurerm-lz-vending)
  - [Vending module (Bicep)](https://github.com/Azure/bicep-registry-modules/tree/main/avm/ptn/lz/sub-vending)
- Deploy workload landing zone components
  - [Cloud adoption scenarios and related accelerators](/azure/cloud-adoption-framework/scenarios/overview#scenarios-to-support-your-cloud-adoption-strategy)

The phases and processes are covered in more detail as you progress through the Ready guide.

## Next steps

Continue with cloud adoption and preparing your Azure environment for landing zones, by reviewing the [Azure setup guide](./azure-setup-guide/index.md).
