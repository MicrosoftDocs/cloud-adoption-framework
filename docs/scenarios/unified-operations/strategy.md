---
title: "Strategy for unified operations adoption"
description: Describe the scenario's impact on strategy
author: mpvenables
ms.author: brblanch
ms.date: 11/17/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of hybrid/unified operations

## Executive summary

Few organizations jump straight into a cloud-native portfolio. Many customers persisting in the belief in cloud myths that stir up fear, slowing innovation efforts, and remain unwilling to commit to a completely cloud-based solution. To move forward, cloud adoption efforts should identify business outcomes that drive observable results or a change in business performance, supported by a specific measure. To minimize common mistakes, it's important to first [dispel myths about moving to the cloud](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case>), and note that hybrid cloud is the connection of on-prem and multi cloud, and that hybrid is not just a transitory state.

**Add connection to Myth no. 2 and link back to the reality and eventuality of the hybrid environment today, highlighting the impending importance of hybrid across the enterprise.**

Cloud computing is about distributed data that extends across platforms. Hybrid makes that possible INSERT POINT FROM JULIA WHITE ARTICLE

The most common environment across the enterprise is a hybrid one. For most customers, a hybrid environments across multiple clouds is the undeniable reality in the existing global IT landscape.

Your will likely be operating across on-premises, one (or more) physical datacenter(s) with some combination of private or multi-cloud environments.
The big decision:

- Are you hybrid because of a one-way trip to the cloud?
- Are you hybrid by choice, supporting a mixture of assets living in public & private cloud

If you plan to be hybrid by design for the next 12 months or longer, you should consider unified operations to manage you overall digital estate.

## Unified operations motivations

- Regulatory requirements
- Latency & connectivity
- Aging assets with no migration compatibility
- Sprawl across clouds

What would motivate the customer to act on this scenario?
<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/motivations>

## Unified operations outcomes

When customers act on this scenario, what do they expect to see as an outcome?
<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/>

- IT Estate visibility and control - ability to see all resources in a single location and be able to query through them to gain insights.
  
- Cloud-based management - ability to modernize operations by being able to use the same cloud management services on resources outside of Azure.
  
- Governance - ability to ensure consistent configurations in all  resources from a central location.
  
- DevOps and cloud native app deployment flexibility - ability to deploy apps’ infra through templates and apps’ configurations through GitOps.
  
- Increased flexibility when adopting PaaS - ability to run PaaS services on infrastructure of choice.

## What is the business justification for a multi-cloud control plane?

Is there something special that customers have to do to justify doing this thing?
<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case>

## Next step: Plan for unified operations

The following list of articles will take you to guidance found at specific points throughout the cloud adoption journey to help you be successful in the cloud adoption scenario.

- [Plan for unified operations](./plan.md)
- [Review your environment or Azure Landing Zone(s)](./ready.md)
- [Assess for unified operations migration](./migrate-assess.md)
- [Migrate unified operations](./migrate-deploy.md)
- [Release unified operations to production](./migrate-release.md)
- [Innovate with unified operations](./innovate.md)
- [Govern unified operations](./govern.md)
- [Manage unified operations](./manage.md)
