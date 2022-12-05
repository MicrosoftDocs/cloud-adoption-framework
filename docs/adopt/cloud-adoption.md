---
title: Cloud adoption journey
description: Understand the cloud adoption journey
author: stephen-sumner
ms.author: ssumner
ms.date: 09/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: cloud adoption, approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---

# Cloud adoption journey

Cloud adoption journeys tend to follow similar trajectories. Variations exist, but it can still be helpful to see how others adopt the cloud. Knowing what workloads to tackle first and what to do with them will streamline your cloud adoption journey (*see the following diagram*).

:::image type="content" source="../_images/adopt/cloud-adoption-journey.png" alt-text="Diagram showing portfolio migration modernization approach." border="false":::

An important consideration in adopting the right cloud solution is control versus productivity. Most organizations find a balance that meets their needs. A typical business will use the following strategies:

- Retire 35% of existing applications
- Replace 15% of existing applications
- Replatform and rehost 50% of existing applications

Read further for guidance on how you can approach each cloud adoption strategy.

## Retire (35%)

You should retire any applications and environments you don't need. Take an inventory of your application portfolio and find applications and environments that aren't worth the investment to keep. Shrink your portfolio before you adopt the cloud to focus on your most important workloads.

## Replace (15%)

Replace applications with software-as-a-service (SaaS) and low-code solutions. You can move "from" solutions that take more time to manage ("control") and move "to" cloud solutions that let you focus on growing your business ("productivity"). See the following table for examples.

| From<span title="Replace">&nbsp;</span> | To<span title="To">&nbsp;</span> |
|-|-|
|Custom line of <br>business (LOB)<br>apps|[Power Apps](/power-apps/powerapps-overview)|
|DevOps tools|[GitHub](/training/modules/introduction-to-github/)|
|Relationship <br>Management|[Dynamics 365](/dynamics365/get-started/intro-crossapp-index)|
|Industry <br>verticals|[3rd-party <br>SaaS](https://azuremarketplace.microsoft.com/marketplace/apps?filters=saas&page=1li)|

## Rehost or replatform (50%)

A typical business will rehost ("lift-and-shift") or replatform ("modernize") about half of its existing applications. The next article will help you decide which one to choose for each workload.

### First to move (35%)

Pick easy wins for the first workloads to move. This strategy lets you evaluate your adoption plan on easier applications before tackling more complex workloads. As you work, you should document your successes and revise your strategy if needed. Apply these insights to your more complicated moves.

Two examples of workloads you could include in your first move are:

- *Basic web apps:* Rehost your basic web applications. You should wait to move your more complicated workloads until you've moved your basic web apps.
- *Advanced portals:* Replatform your portals with [Power Apps portals](/power-apps/maker/portals/overview).

### Next to move (10%)

Use the lessons-learned from your first moves to tackle more challenging workloads such as those with:

- *High Business Impact:* Workloads that drive revenue.
- *High Input/Output (I/O) Online Transactional Processing (OLTP) Systems:* Workloads that record business transactions.
- *Regulated Information:* Workloads that must follow legal and industry standards such as HIPAA, PCI DSS, and others. You should use [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance) to ensure compliance with these standards.

### Hard or costly to move (5%)

Move the most difficult and costly workloads last. The following systems might need more thought to move efficiently:

- *High Value Asset (HVA):* Disruption or corruption of this workload would disrupt all business operations.
- *Public Key Infrastructure (PKI) systems:* Workloads that manage x509 digital certificates, network encryption, and authentication.
- *Legacy source control:* Source control systems that aren't easily replaced with GitHub.
- *Can't be modernized:* Legacy or proprietary technology that can't be modernized.
- *Deep architectural change:* Legacy architectures that require a complete redesign of the architecture. Use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) rather than the CAF modernize approach.

## More resources

- Use the tools available in [Azure Migrate](/azure/migrate/migrate-services-overview) to simplify your journey.
- Join the [migration and modernization program](https://azure.microsoft.com/migration/migration-modernization-program/#program-form) for self-guided digital support and expert-guided deployments.
- Use [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/?v=18.03#overview) to get customized guidance from Azure engineers.

## Next steps

> [!div class="nextstepaction"]
> [Migrate or modernize first?](../adopt/migrate-or-modernize.md)
