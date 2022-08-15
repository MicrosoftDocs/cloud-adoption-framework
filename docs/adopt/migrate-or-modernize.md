---
title: Migrate or modernize first?
description: Use the Cloud Adoption Framework for Azure to understand the various approaches to migrate and modernize in your cloud adoption journey.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Migrate or modernize first?

Customers often ask if they should migrate first and modernize later or modernize during the migration. The timing depends on the benefits you want to gain. We recommended two approaches: rehost and replatform (*see figure*).

:::image type="content" source="../_images/adopt/migrate-or-modernize-v3.png" alt-text="Diagram showing approaches to cloud migration and modernization.":::

## Rehost ("migrate first, modernize later")

Rehosting is often called "lift-and-shift." Here, you move an existing application to the cloud as-is. This approach allows you to quickly benefit from the cloud.

**Rehosting Priorities:** Migrate before modernizing if you want the following benefits:

- *Immediate sustainability:* The lift-and-shift approach is the fastest way to reduce your data center footprint.
- *Immediate cost savings:* Using IaaS solutions will let you trade capital expense with operational expense. Pay as you go and only pay for what you use.
- *IaaS Solutions:* IaaS virtual machines (VMs) provide immediate compatibility with existing on-premises applications. Migrate your workloads to Azure Virtual Machines and modernize while in the cloud.
- *Immediate cloud-readiness test:* Test your migration to ensure your organization has the people and processes in place to adopt the cloud. Migrating a minimum viable product is a great approach to test the cloud-readiness of your organization.  

## Replatform ("modernize during the move")

Replaforming lets you modernize aspects of an application during the migration process.

**Replatforming Priorities:** Modernize during the move if you want:

- *Faster time-to-market:* Use existing PaaS technologies to speed up deployment.
- *Increased application innovation:* PaaS allows developers to focus on business logic and critical data plays.
- *Enhanced productivity:* Adopting PaaS narrows the skills required to push apps to market and increases the productivity of development, security, and operations.
- *Better development velocity:* Switching to managed services will limit the items developers need to focus on and will increase their sprint velocity.

## Next steps

> [!div class="nextstepaction"]
> [Learn how to migrate](../migrate/index.md)
