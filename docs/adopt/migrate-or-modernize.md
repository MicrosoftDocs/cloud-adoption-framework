---

title: Migrate or modernize first?
description: Learn if you should migrate existing applications first or modernize them before migrating to the cloud.
author: stephen-sumner
ms.author: ssumner
ms.date: 12/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Migrate or modernize first?

Figuring out if you should migrate an on-premises application first ("rehost") or modernize first ("replatform") is a common question. The answer depends on your migration goals, but aligning your goals to an approach can be difficult. To help, we created a short assessment to help you find the right path.

We define each approach and outline their benefits. If the benefits described match your goals, then you've likely found the answer to your question.

:::image type="content" source="../_images/adopt/migrate-or-modernize-first.png" alt-text="Diagram that shows approaches to cloud migration and modernization.":::

## Migrate ("Rehost")

Migrate or rehost your applications first. This is the "lift-and-shift" approach. With this approach, you move an existing application to the cloud as it is and modernize it later. Rehosting has four major benefits.

***Immediate sustainability:*** The lift-and-shift approach is the fastest way to reduce your data center footprint.

***Immediate cost savings:*** Using comparable cloud solutions will let you trade capital expense with operational expense. Pay-as-you-go and only pay for what you use.

***IaaS solutions:*** IaaS virtual machines (VMs) provide immediate compatibility with existing on-premises applications. Migrate your workloads to Azure Virtual Machines and modernize while in the cloud. Some on-premises applications can move to an application platform with minimal effort. We recommend Azure App Service as a first option with IaaS solutions able to host all applications.

***Immediate cloud-readiness test:*** Test your migration to ensure your organization has the people and processes in place to adopt the cloud. Migrating a minimum viable product is a great approach to test the cloud-readiness of your organization.  

## Modernize ("Replatform")

Modernize or replatform your applications first. In this approach, you change parts of an application during the migration process. It takes a little more work to get to the cloud, but your applications have better cost and performance efficiency in the cloud. There are four benefits of modernizing before migration.

***Faster time-to-market:*** Use PaaS technologies to speed up deployment.

***Increased application innovation:*** PaaS allows developers to focus on business logic and critical data plays.

***Enhanced productivity:*** Adopting PaaS narrows the skills required to push apps to market and increases the productivity of development, security, and operations.

***Better development velocity:*** Switching to managed services will limit the items developers need to focus on and will increase their sprint velocity.

## Next steps

Now you have a sense of what to do first. Start migrating or modernizing.

> [!div class="nextstepaction"]
> [Learn how to migrate](../migrate/index.md)
> [!div class="nextstepaction"]
> [Learn how to modernize](../modernize/index.md)
