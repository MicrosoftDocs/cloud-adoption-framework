---
title: How to adopt the cloud
description: Use the Cloud Adoption Framework for Azure to understand the typical journey to the cloud and how your existing portfolio will change.
author: stephen-sumner
ms.author: ssumner
ms.date: 08/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: 
ms.custom: internal, seo-caf-adopt
keywords: approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---

# How to adopt the cloud

The right cloud adoption option gives you the right balance of control and productivity. Control gives you the most configuration ability but has the most management overhead. Productivity restricts the number of configurations you can make but has little management overhead (*see figure*).

:::image type="content" source="../_images/adopt/adopt-existing-apps-v5.png" alt-text="Diagram showing portfolio migration modernization approach.":::

Building a hybrid cloud gives you the most control over your portfolio, but it limits your productivity. Replacing applications with SaaS and low-code solutions gives you the most productivity. Most organizations adopt a balance of both control and productivity.

The figure represents what a typical business does with their existing application portfolio:

- Retire 35% of existing applications
- Replace 15% of existing applications
- Replatform and Rehost 50% of existing applications

## Retire (35%)

Retire or get rid of any applications or environments you don't need. Take an inventory of your application portfolio and identify any that aren't worth the investment to keep. Shrinking your portfolio before cloud adoption lets you focus on your most business-critical workloads.

## Replace (15%)

Replacing critical workloads with SaaS and low-code solutions provides the most productivity for applications you need to keep. You can move "from" management-heavy technologies "to" cloud solutions that improve productivity (*see table for examples*).

| From<span title="Replace">&nbsp;</span> | To<span title="To">&nbsp;</span> |<span></span>|
|-|-|-|
|Custom line of <br>business (LOB)<br>apps|[Power Apps](/power-apps/powerapps-overview)| :::image type="icon" source="../_images/adopt/powerapps.svg":::
|DevOps tools|[GitHub](/learn/modules/introduction-to-github/)|:::image type="icon" source="../_images/adopt/github-icon.svg":::
|Relationship <br>Management|[Dynamics](/dynamics365/get-started/intro-crossapp-index)|:::image type="icon" source="../_images/adopt/dynamics.svg":::
|Industry <br>verticals|[3rd-party <br>SaaS](/marketplace/apps)|:::image type="icon" source="../_images/adopt/azure-2.svg":::
|

## Rehost and Replatform (50%)

**1. First to move (35%):**  Pick easy wins for the first workloads to move. Test your cloud adoption plan on manageable applications before tackling the most complex or business critical workloads. Document your successes, revise your migration strategy, and extract lessons-learned. You'll apply these insights to your more complicated migrations. [Use Azure Migrate to plan your migration](/azure/migrate/migrate-services-overview).

Some examples of workloads you could include in your first move are:

- *Basic web apps:* Rehost most your web applications. Allow more planning for applications that are highly regulated, business-critical, or transaction intensive (OLTP workloads).
- *Advanced portals:* Replatform your portals with [Power Apps portals](/power-apps/maker/portals/overview).
- *Modernized solutions:* Finish modernizing workloads. If you modernized the application, now it's time to modernize the database.

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
> [Migrate or modernize first?](../adopt/migrate-or-modernize.md)
