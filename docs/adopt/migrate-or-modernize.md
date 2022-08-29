---
title: Migrate or modernize first?
description: Use the Cloud Adoption Framework for Azure to understand the various approaches to migrate and modernize in your cloud adoption journey.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/19/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Migrate or modernize?

For on-premises applications, prioritizing whether to migrate ("rehost") or modernize ("replatform") first is a common dilemma. Depending on your business goals (*see figure*) and the following benefits of each approach, you'll be better equipped to move forward with an approach.

:::image type="content" source="../_images/adopt/migrate-or-modernize-v5.png" alt-text="Diagram showing approaches to cloud migration and modernization.":::

## Migrate ("Rehost")

Migrate or rehost your applications first. This approach is often called "lift-and-shift." You move an existing application to the cloud as it is and modernize later.

**Benefits of migrating first:**

- *Immediate sustainability:* The lift-and-shift approach is the fastest way to reduce your data center footprint.
- *Immediate cost savings:* Using IaaS solutions will let you trade capital expense with operational expense. Pay-as-you-go and only pay for what you use.
- *IaaS solutions:* IaaS virtual machines (VMs) provide immediate compatibility with existing on-premises applications. Migrate your workloads to Azure Virtual Machines and modernize while in the cloud.
- *Immediate cloud-readiness test:* Test your migration to ensure your organization has the people and processes in place to adopt the cloud. Migrating a minimum viable product is a great approach to test the cloud-readiness of your organization.  

## Modernize ("Replatform")

Modernize or replatform your applications first. In this approach, you change parts of an application during the migration process. It takes a little more work to get to the cloud, but your applications have better cost and performance efficiency in the cloud.

**Benefits of modernizing first:**

- *Faster time-to-market:* Use existing PaaS technologies to speed up deployment.
- *Increased application innovation:* PaaS allows developers to focus on business logic and critical data plays.
- *Enhanced productivity:* Adopting PaaS narrows the skills required to push apps to market and increases the productivity of development, security, and operations.
- *Better development velocity:* Switching to managed services will limit the items developers need to focus on and will increase their sprint velocity.

## Next steps

Now you have a sense of what to do first. Start migrating or modernizing.

> [!div class="nextstepaction"]
> [Learn how to migrate](../migrate/index.md)
> [!div class="nextstepaction"]
> [Learn how to modernize](../modernize/index.md)
