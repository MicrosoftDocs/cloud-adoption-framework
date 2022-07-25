---
title: Approaches to cloud migration and modernization
description: Use the Cloud Adoption Framework for Azure to understand the various approaches to migrate and modernize in your cloud adoption journey.
author: BrianBlanchard
ms.author: brblanch
ms.date: 07/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Approaches to cloud migration and modernization

You can adopt the cloud in two ways. **??What horizon is building new apps??** (1) You can build new, cloud-native applications or (2) adapt existing applications to use cloud technologies. You have options if you want to adapt existing applications. You can migrate to IaaS, modernize with PaaS, replace with SaaS, or stay on-prem with a hybrid cloud.

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="Diagram showing approaches to cloud migration and modernization.":::

For most organizations, the best clouds adoption choices are to migrate and modernize existing applications. However, it is not necessary that you migrate before modernizing. Here we will discuss the benefits of migrating first and modernizing first.

## Migrate first, modernize later approach

This approach is often called rehosting or "lift-and-shift." Here, you move an existing application to the cloud as-is. This allows you to quickly benefit from the cloud. 

### 1. Migration Priorities

Migrate before modernizing if you want immediate:

- **Sustainability:** The lift-and-shift approach is the fastest way to reduce your data center footprint.
- **Savings:** Using IaaS solutions will let you trade capital expense with operational expense. Pay as you go and only pay for what you use.
- **IaaS Solutions:** IaaS VM provide immediate compatibility with existing on-prem applications. Migrate your workloads to Azure Virtual Machines and modernize while in the cloud.
- **Cloud-Readiness Test:** Test your migration to ensure your organization has the people and processes in place to adopt the cloud. Migrating a minimum viable product is a great approach to test the cloud-readiness of your organization.  

### 2. Migration Order

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach-v2.png" alt-text="Diagram showing portfolio migration modernization approach.":::



## Modernize during the move

This is approach is often called replatforming. Here, you will modernize aspects of an application during the migration process. Modernize during the move if you want:

- **Faster time-to-market:** Use existing PaaS technologies to speed up deployment.
- **Increased Innovation:** PaaS allows developers to focus on business logic and critical data plays.
- **Enhanced Productivity:** Adopting PaaS narrowing the skills required to push apps to market and increases the productivity of development, security, and operations.
- **Better Velocity:** Switching to managed services will limit the items developers need to focus on and will increase their sprint productivity.

***Examples:***

- Migrate your SQL database to a managed database solution such as Azure SQL Database.
- Move your on-prem directory services to Azure Active Directory Domain Services.

## Application portfolio migration and modernization approach




### Migration

#### First to move

Most things in an environment can be moved and perhaps modernized without a significant modernization effort. Your first items to move could include:

- Basic web apps
- Advanced portals
- New solutions
- Any modernized solutions

#### Next to move

Usually, what we see when we migrate next are things like high input and output transactional processing systems or regulatory and high business impact systems. Those items tend to be more difficult to do any kind of modernization on and migrations are a forced option many times.

#### Hard or costly to move

There's always the following group of items that's hard to move:

- HVA systems
- PKI systems
- Legacy source control
- Workloads that can't be modernized
- Workloads that require deep architectural change

> [!IMPORTANT]
> If you have *workloads that require deep architectural change*, you need to *rearchitect* rather than modernize. In this case, use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/). Also, shifting pieces of LoB apps to PowerApps, and so on, is part of [innovation](../innovate/index.md), rather than modernization.

You might have a small percentage of things that you take from a custom line of business app over to power apps. This task is outside of modernization and can be handled in the [innovation](../innovate/index.md) space.

### Modernization

Developers tend to build new apps cloud-natively using Serverless or PaaS technologies. Modernizing your existing apps employs using containers or Serverless to maximize cloud benefits, or [lift and shift](/virtualization/windowscontainers/quick-start/lift-shift-to-containers) into IaaS to take advantage of OPEX and cloud scale.

For apps that aren't custom built, many businesses choose to retire and replace them using SaaS or low code apps.

Some apps need to stay on premises due to regulatory or data sovereignty requirements or latency issues. It’s important to enable these apps to be cloud-connected.

No matter where your applications run, in multicloud, on-premises, or at the edge, it's important to enable consistent identity, security, management, and compliance across distributed environments.

Usually about 35% of any on premises environment gets retired, rightsized, or eliminated during the cloud motion, although this percentage is a rough estimate.

## Next steps

> [!div class="nextstepaction"]
> [Evaluate your modernization options](../modernize/business-alignment/evaluate-modernization-options.md)
