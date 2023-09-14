---
title: Prepare for cloud adoption
description: Learn how to create a landing zone to host the workloads that you plan to build in the cloud or migrate to the cloud.
author: martinekuan
ms.author: martinek
ms.date: 11/12/2021
ms.topic: conceptual
ms.custom: internal
---

# Prepare for cloud adoption

Before adoption can begin, you'll create a landing zone to host the workloads that you plan to build in or migrate to the cloud. This section of the framework guides you through environment preparation and landing zone creation.

## Landing zone concepts

[!INCLUDE [Landing zone concepts](~/../crr-aac-repo/docs/landing-zones/includes/concepts.md)]

## Landing zone journey

:::image type="content" source="./landing-zone/media/customer-landing-zone-journey.png" alt-text="Diagram showing the Azure landing zone customer journey." border="false" lightbox="./landing-zone/media/customer-landing-zone-journey.png" :::

As you work your way through the Ready guide, consider your progress as a continuous journey that will prepare you for landing zone creation. The journey consists of 4 major phases and related processes:

- Bootstrap your environment
  - [Create subscriptions manually](/azure/cost-management-billing/manage/create-subscription#create-a-subscription)
  - [Create subscriptions programatically](/azure/cost-management-billing/manage/programmatically-create-subscription)
  - [ALZ ](/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending)

- Deploy Azure landing zone platform components
  - [ALZ accelerator portal](/azure/cloud-adoption-framework/ready/landing-zone/implementation-options#azure-landing-zone-accelerator-approach)
  - [ALZ Bicep modules](https://github.com/Azure/ALZ-Bicep)
  - [ALZ Terraform module](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Connectivity-Resources-With-Custom-Settings)
- Subscription (LZ) vending process
  - [LZ vending module (Terraform)](https://github.com/Azure/terraform-azurerm-lz-vending)
  - [LZ vending module (Bicep)](https://github.com/Azure/bicep-lz-vending)
- Deploy workload landing zone components
  - [Cloud adoption scenarios and related accelerators](/azure/cloud-adoption-framework/scenarios/overview#scenarios-to-support-your-cloud-adoption-strategy)

The phases and processes are covered in more detail as you progress through the Ready guide.

## Next steps

Continue with cloud adoption and preparing your Azure environment for landing zones, by reviewing the [Azure setup guide](./azure-setup-guide/index.md).