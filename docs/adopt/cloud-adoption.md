---
title: Cloud adoption journey
description: Understand the cloud adoption journey
author: stephen-sumner
ms.author: ssumner
ms.date: 12/13/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: adopt
ms.custom: internal, seo-caf-adopt
keywords: cloud adoption, approaches, strategy, cloud migration, cloud modernization, cloud adoption framework
---

# Cloud adoption journey

Cloud adoption journeys tend to follow similar trajectories. Variations exist, but it can still be helpful to see how others adopt the cloud. Knowing what workloads to tackle first and what to do with them will streamline your cloud adoption journey.

:::image type="content" source="../_images/adopt/cloud-adoption-journey.png" alt-text="Diagram showing portfolio migration modernization approach." border="false":::

An important consideration in adopting the right cloud solution is the balance of control versus productivity. Infrastructure-as-a-service (IaaS) solutions give you the most control but require more time to maintain. Platform-as-a-service (PaaS) and software-as-a-service (SaaS) solutions transfer management responsibility to Azure and allow your teams to focus on being productive. The balance needed between control and productivity is different for every organization, and it will change over time as your priorities change.

For the initial cloud adoption, a typical organization retires 35% of its applications, replaces 15% of its portfolio, and migrates 50% with only necessary modifications (replatform or rehost).

## Retire (35%)

We recommend retiring any workloads your organization doesn't need. You'll need to do some discovery and inventory to find applications and environments that aren't worth the investment to keep. The goal of retiring is to be cost and time efficient. Shrinking your portfolio before you move to the cloud allows your team to focus on the most important assets.

## Replace (15%)

Most organizations replace about 15% of their applications with software-as-a-service (SaaS) and low-code solutions. They see the value in moving "from" technologies with management overhead ("control") and moving "to" solutions that let them focus on achieving their objectives ("productivity").

*Table 1 - Examples of replacing workloads with SaaS and low-code solutions*

| From | To |
| --- | --- |
|Custom line of <br>business (LOB)<br>apps|[Power Apps](/power-apps/powerapps-overview)|
|DevOps tools|[GitHub](/training/modules/introduction-to-github/)|
|Relationship <br>Management|[Dynamics 365](/dynamics365/get-started/intro-crossapp-index)|
|Industry <br>verticals|[3rd-party <br>SaaS](https://azuremarketplace.microsoft.com/marketplace/apps?filters=saas&page=1li)|

## Migrate (rehost or replatform) (50%)

A typical business will migrate about half of its existing workloads. Within these workloads, there are normally three tiers of difficulty. About 35% are easy to move. The next 10% are more difficult because they're more complex or more important, and only the last 5% require extra planning to execute.

There are many migration approaches. Rehosting ("lift-and-shift") and replatforming ("modernize") are the most common, and our recommended approaches for cloud adoption. But it can be difficult to decide which one meets your needs, so we have guidance on deciding which approach is right for you. For more information, see [migrate or modernize?](migrate-or-modernize.md).

### First to move (35%)

We recommend picking easy wins for the first workloads to move. This strategy lets you evaluate your adoption plan on easier applications before tackling more complex workloads. As you work, you should document your successes and revise your strategy if needed. Apply these insights to your more complicated moves. Two examples of workloads you could include in your first move are basic web apps and advanced portals.

***Basic web apps:*** We recommend rehosting your basic web applications and waiting to move your more complicated workloads until you've moved your basic web apps. Azure App Service is a flexible application platform that can host most applications. We recommend this solution for basic web applications. For more information, see [Azure App Service](/azure/app-service/overview).

***Advanced portals:*** You should migrate your portals to [Power Apps portals](/power-apps/maker/portals/overview) to increase productivity.

### Next to move (10%)

You should apply lessons-learned from your first moves to tackle more challenging or more important workloads. We have some examples to give you a sense of the workload types.

- ***High Business Impact:*** Workloads that drive revenue or are mission-critical.

- ***High Input/Output (I/O) Online Transactional Processing (OLTP) Systems:*** These workloads record business transactions and have elevated processing requirements.

- ***Regulated Information:*** These workloads must follow legal and industry standards such as HIPAA, PCI DSS, and others. We recommend using Azure Policy to ensure compliance with these standards. For more information, see [Azure Policy](/azure/governance/policy/concepts/regulatory-compliance).

### Hard or costly to move (5%)

Move the most difficult and costly workloads last. The following systems might need more thought to move efficiently.

***High Value Asset (HVA):*** Disruption or corruption of this workload would disrupt all business operations.

***Public Key Infrastructure (PKI) systems:*** Workloads that manage x509 digital certificates, network encryption, and authentication.

***Legacy source control:*** Source control systems that aren't easily replaced with GitHub.

***Can't be modernized:*** Legacy or proprietary technology that can't be modernized.

***Deep architectural change:*** Legacy architectures that require a complete redesign of the architecture. Use the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) rather than the CAF modernize approach.

### More resources

- Use the tools available in [Azure Migrate](/azure/migrate/migrate-services-overview) to simplify your journey.
- Join the [migration and modernization program](https://azure.microsoft.com/migration/migration-modernization-program/#program-form) for self-guided digital support and expert-guided deployments.
- Use [FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack/?v=18.03#overview) to get customized guidance from Azure engineers.

## Next steps

> [!div class="nextstepaction"]
> [Migrate or modernize first?](../adopt/migrate-or-modernize.md)
