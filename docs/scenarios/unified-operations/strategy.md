---
title: "Strategy for unified operations adoption"
description: Describe the scenario's impact on strategy
author: mpvenables
ms.author: brblanch
ms.date: 11/18/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of hybrid and multi-cloud operations

## Executive summary

Few organizations jump straight into a cloud-native portfolio. Many customers continue to believe cloud myths that slow innovation efforts, such as "everything should go into the cloud." To minimize common mistakes, [dispel myths about moving to the cloud](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case>). To move forward, identify business outcomes that drive observable results or a change in business performance, supported by a specific measure. There may be sound business justifications to reserve part of your digital estate to an on-premises environment, but you still want the innovation that cloud services can bring to your datacenter. You may realize that a hybrid cloud is not simply two different environments, but a steady state that enables a consistent experience across end users, IT management & security, and app development, far beyond "lifting and shifting" virtual machines. Consistency in a hybrid cloud environment enables uniform development, unified dev-ops and management, common identity and security, and extension of existing applications and infrastructure to the cloud. Consistency across these key areas enables controlled transformation for your organization, backed with data-justified financial models for your business.  

Hybrid and multi-cloud is an evolution to distributed computing and unified operations, bringing consistent, cross-platform access to data and apps across private and public clouds—and edge computing environments. The most common environment across the enterprise is hybrid and multi-cloud. For most customers, moving to a hybrid and multi-cloud scenario is simply embracing market reality, and, as previously mentioned, remains a sound business decision.

The next decision for your organization is committing to a viable environment that supports a collection of resources hosted across public and private clouds, and having one control plane that monitors, governs, and manages your resources. Consider a hybrid and multi-cloud environment to manage you overall digital estate if you are planning to be hybrid by design for the next 12 months or longer.

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
