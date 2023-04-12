---
title: Create your initial Azure subscriptions
description: Begin your Azure adoption by creating your initial subscriptions.
author: martinekuan
ms.author: martinek
ms.date: 05/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
ms.custom: internal
---

# Create your initial Azure subscriptions

Begin your Azure adoption process by creating a set of subscriptions based on your organization's initial requirements.

> [!NOTE]
>
> Use the Azure landing zone guidance for [resource organization](../landing-zone/design-area/resource-org.md) as a first step towards planning subscriptions within your Azure environment to ensure you consider environment scaling.

## Create subscriptions

Create two Azure subscriptions:

- A subscription that contains your production workloads.
- A subscription that serves as your non-production environment, using an [Azure Dev/Test offer](https://azure.microsoft.com/pricing/dev-test/) for lower pricing.

![An initial subscription model showing keys next to boxes labeled **production** and **non-production.**](../../_images/ready/initial-subscription-model.png)

*Figure 1: An initial subscription model with keys next to boxes labeled "production" and "nonproduction".*

A two-subscription approach offers many benefits:

- The use of separate subscriptions for production and non-production environments creates a boundary that makes resource management simpler and safer.
- Azure Dev/Test subscription offerings are available for non-production workloads. These offerings provide discounted rates on Azure services and software licensing.
- Production and non-production environments often have different sets of Azure policies. Placing each environment in its own subscription makes it simple for you to apply different policies to them at the subscription level.
- You can place certain types of Azure resources in a non-production subscriptions for testing purposes. You can enable resource providers for these test resources in your non-production subscription without ever exposing them to your production environment.
- You can use Azure dev/test subscriptions as isolated sandbox environments. These sandboxes allow administrators and developers to rapidly create and tear down entire sets of Azure resources and help with data protection and security concerns.
- Acceptable cost thresholds often vary between production and non-production environments.

## Sandbox subscriptions

If you know your organization's cloud adoption strategy requires innovation, consider creating one or more sandbox subscriptions. In sandbox subscriptions, you can experiment with Azure capabilities and apply security policies to keep test subscriptions isolated from your production and non-production environments, Use an Azure Dev/Test offer to create these subscriptions.

![Subscription model showing keys next to boxes labeled production, nonproduction, and sandboxes.](../../_images/ready/initial-subscription-model-with-sandboxes.png)

- *Figure 2: A subscription model with sandbox subscriptions.*

## Shared services subscriptions

If your organization plans to host **more than 1,000 VMs or compute instances in the cloud within 24 months**, you should create another Azure subscription to host shared services. This strategy helps prepare you to support your end-state enterprise architecture.

![An initial subscription model showing keys next to boxes labeled production, non-production and shared services.](../../_images/ready/initial-subscription-model-with-shared-services.png)

*Figure 3: A subscription model with shared services.*

## Next steps

[Scale your Azure environment with additional subscriptions](./scale-subscriptions.md)
