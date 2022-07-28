---
title: Cloud migration and modernization
description: Use the Cloud Adoption Framework for Azure to understand the various approaches to migrate and modernize in your cloud adoption journey.
author: StephenSumner
ms.author: ssumner
ms.date: 07/27/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---
# Cloud migration and modernization

You can adopt the cloud in two ways. (1) You can build new, cloud-native applications or (2) adapt existing applications to use cloud technologies.

:::image type="content" source="../_images/adopt/migration-modernization-approaches.png" alt-text="Diagram showing approaches to cloud migration and modernization.":::

**New Apps:** Developers often adopt event-driven ("serverless") technologies when building cloud-native applications. These decisions help reduce cost and sustainment efforts. **Is this right?**

**Existing Apps:** You have options if you want to adapt existing applications. You can migrate to IaaS, modernize with PaaS and containers, replace with SaaS, or stay on-premises with a hybrid cloud. **Should we change the graphic?**

For most organizations, the cloud adoption plan involves migrating and modernizing existing applications. However, the question is when to modernize these applications. The timing depends on your business goals. We recommended two approaches: rehost and replatform.

## Rehost - migrate first, modernize later

This approach is often called rehosting or "lift-and-shift." Here, you move an existing application to the cloud as-is. This approach allows you to quickly benefit from the cloud.

**Rehosting Priorities:** Migrate before modernizing if you want immediate:

- *Sustainability:* The lift-and-shift approach is the fastest way to reduce your data center footprint.
- *Savings:* Using IaaS solutions will let you trade capital expense with operational expense. Pay as you go and only pay for what you use.
- *IaaS Solutions:* IaaS virtual machines (VMs) provide immediate compatibility with existing on-premises applications. Migrate your workloads to Azure Virtual Machines and modernize while in the cloud.
- *Cloud-Readiness Test:* Test your migration to ensure your organization has the people and processes in place to adopt the cloud. Migrating a minimum viable product is a great approach to test the cloud-readiness of your organization.  

## Replatform - modernize during the move

This approach is often called replatforming. Here, you'll modernize aspects of an application during the migration process.

**Replatforming Priorities:** Modernize during the move if you want:

- *Faster time-to-market:* Use existing PaaS technologies to speed up deployment.
- *Increased Innovation:* PaaS allows developers to focus on business logic and critical data plays.
- *Enhanced Productivity:* Adopting PaaS narrows the skills required to push apps to market and increases the productivity of development, security, and operations.
- *Better Velocity:* Switching to managed services will limit the items developers need to focus on and will increase their sprint velocity.

## How to move existing applications

The decision to rehost or replatform existing applications must factor in whether control or productivity is more important (*see figure*). Remaining on-premises and building a hybrid environment offers the most control while converting to SaaS and low-code solutions or replacing applications altogether offers the most productivity. Most organizations adopt a balance of both control and productivity.

:::image type="content" source="../_images/adopt/portfolio-migration-modernization-approach-v2.png" alt-text="Diagram showing portfolio migration modernization approach.":::

The figure represents what a typical business does with their existing application portfolio:

- Retire 35% of existing applications
- Replace 15% of existing applications
- Replatform and Rehost 50% of existing applications

### Retire (35%)

Your business has applications and environments it doesn't need. As part of your cloud adoption plan, you'll take an inventory of your application portfolio. You'll find IT assets that you don't need or aren't worth keeping. Shrinking your application portfolio allows your business to focus on business-critical workloads.

### Replace (15%)

Replacing critical workloads with SaaS and low-code solutions provides the most productivity for applications you need to keep. You can move "from" management-heavy technologies "to" cloud solutions that improve productivity (*see table for examples*).

| From<span title="Replace">&nbsp;</span> | To<span title="To">&nbsp;</span> |<span></span>|
|-|-|-|
|Custom line of <br>business (LOB)<br>apps|[Power Apps](/power-apps/powerapps-overview)| :::image type="icon" source="../_images/adopt/powerapps.svg":::
|DevOps tools|[GitHub](/learn/modules/introduction-to-github/)|:::image type="icon" source="../_images/adopt/github-icon.svg":::
|Relationship <br>Management|[Dynamics](/dynamics365/get-started/intro-crossapp-index)|:::image type="icon" source="../_images/adopt/dynamics.svg":::
|Industry <br>verticals|[3rd-party <br>SaaS](/marketplace/apps)|:::image type="icon" source="../_images/adopt/azure-2.svg":::
|

#### Rehost and Replatform (50%)

**1. First to move (35%):**  Pick easy wins for the first workloads to move. Test your cloud adoption plan on manageable applications before tackling the most complex or business critical workloads. Document your successes, revise your migration strategy, and extract lessons-learned. You'll apply these insights to your more complicated migrations. [Use Azure Migrate to plan your migration](/azure/migrate/migrate-services-overview).

Some examples of workloads you could include in your first move are:

- *Basic web apps:* Rehost most your web applications. Allow more planning for applications that are highly regulated, business-critical, or transaction intensive (OLTP workloads).
- *Advanced portals:* Replatform your portals with [Power Apps portals](/power-apps/maker/portals/overview).
- *New solutions:* Build new applications in the cloud with IaaS and PaaS solutions rather than rehost or replatform. This differs from the "Replace" strategy above. "Replace" uses SaaS and low-code tools instead of IaaS and PaaS. **Is this right?**
- *Modernized solutions:* Replatform your workloads with PaaS technologies during the move. For example, you can move from a SQL database to the fully managed Azure SQL Database service.

**2. Next to move (10%):** Use the lessons-learned from your first move to tackle more challenging workloads. The challenge can be technical or simply the importance of the workload. Joining the [migration and modernization program](https://azure.microsoft.com/migration/) offers self-guided support and expert-guided deployments. Some of the more challenging workloads to move are:

- *High Business Impact:* Workloads that drive revenue.
- *High Input/Output (I/O) Online Transactional Processing (OLTP) Systems:* Workloads that record business transactions.
- *Regulated Information:* Workloads that require compliance with legal and industry standards such as [HIPAA, PCI DSS, and General Data Protection Regulation (GDPR)](/../cloud-adoption-framework-pr/docs/govern/policy-compliance/regulatory-compliance.md). Use [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance.md) to ensure compliance with these standards.

**3. Hard or costly to move (5%):** Move the most difficult and costly workloads last. These systems need more thought to move efficiently. Consider using [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/?v=18.03#overview) to get customized guidance from Azure engineers.

- *High Value Asset (HVA):* Disruption or corruption of this workload would disrupt all business operations.
- *Public Key Infrastructure (PKI) systems:* Workloads that manage x509 digital certificates and provide network encryption and authentication.
- *Legacy source control:* Source control systems that aren't easily replaced with GitHub.
- *Can't be modernized:* Legacy or proprietary technology that can't be modernized.
- *Deep architectural change:* Legacy architectures that require a complete redesign of the architecture. Use the [Microsoft Azure Well-Architected Framework](/well-architected-pr/well-architected/index.md) rather than the CAF modernize horizon.

## Next steps

> [!div class="nextstepaction"]
> [Migrate](../migrate/index.md)
