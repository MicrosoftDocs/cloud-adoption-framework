---
title: "Strategy for unified operations adoption"
description: Describe the scenario's impact on strategy
author: mpvenables
ms.author: brblanch
ms.date: 11/19/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: strategy
---

# Strategic impact of hybrid and multi-cloud operations

## Executive summary

Few organizations jump straight into a cloud-native portfolio. Many customers continue to believe cloud myths that slow innovation efforts, such as "everything should go into the cloud." To minimize common mistakes, [dispel myths about moving to the cloud](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case>). To move forward, identify business outcomes supported by specific efforts that drive crucial business results. There may be sound business justifications to reserve part of your digital estate to an on-premises environment, but you still want the innovation that cloud services can bring to your datacenter.

At this point, you realize that a hybrid cloud is not simply two different environments, but a steady state that enables a consistent experience across end users, IT management & security, and app development, far beyond "lifting and shifting" virtual machines. Consistency in a hybrid cloud environment enables uniform development, unified dev-ops and management, common identity and security, and extension of existing applications and infrastructure to the cloud. Consistency across these key areas enables controlled transformation for your organization, backed with data-justified financial models for your business.  

Hybrid and multi-cloud is an evolution to distributed computing and unified operations, bringing consistent, cross-platform access to data and apps across private and public clouds—and edge computing environments. The most common environment across the enterprise is hybrid and multi-cloud. For most customers, moving to a hybrid and multi-cloud scenario is simply embracing market reality, and, as previously mentioned, remains a sound business decision.

The next decision for your organization is committing to a viable environment that supports a collection of resources hosted across public and private clouds, and having one control plane that uniformly protects and monitors resources, standardizes governance, and manages all operations. Consider a hybrid and multi-cloud environment to manage your overall digital estate if you are planning to be hybrid by design for the next 12 months or longer.

## Unified operations motivations

There are various [motivations](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/motivations>) that might steer customers to act on a hybrid and multi-cloud scenario? Adopting the right cloud strategy depends on documenting what classification the majority of these motivations are associated with: critical business events, migration, or innovation. 

Customers may have a digital estate bound by specific regulatory requirements and data localization laws that constrain in what geographical location it must reside. A particular industry might require low-latency and high connectivity for efficient operational capacity, such as financial services, also a common requirement for other industries like media, healthcare, education, and government, for example.

A large MNC (multi-national corporation), for example, might have globally distributed, legacy datacenters, with aging assets that are simply not compatible with an organization-wide migration effort. Or there may be corporations with even larger cloud estates that are sprawled across several cloud environments, and visibility and control of operations is challenging.

## Unified operations outcomes

When customers execute on their cloud strategy and choose a hybrid and multi-cloud scenario, they expect to see business outcomes supported by specific efforts that drive crucial business results, [outcomes grounded in cross-team consensus](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/business-outcomes/>).

Organizations might require **improved visibility and control over their IT estate**. They want the ability to see all their resources in a single location, and be able to query through them to gain insights.
  
Another outcome companies may target is **cloud-based management**—the ability (across platforms) to modernize operations with the same cloud management services on resources in locations that are outside of Azure.
  
**Governance** is an important outcome for companies wishing to ensure consistent configurations across all resources from one central location.
  
**DevOps and cloud native app deployment flexibility** would provide organizations the agility of deploying app infrastructure through templates and app configurations through GitOps.
  
Finally, companies might desire **increased flexibility when adopting PaaS**, the ability to run PaaS services on infrastructure of choice, as an outcome.

## What is the business justification for a multi-cloud control plane?

There are many [business justifications](<https://docs.microsoft.com/azure/cloud-adoption-framework/strategy/cloud-migration-business-case>) that may support choosing a hybrid and multi-cloud approach. Certainly, moving to a hybrid and multi-cloud control pane is multi-faceted. It may be driven by data residency restrictions, keeping legacy applications on premises, or avoiding replicating underutilized provisioned on-premises environments. Organizations seeking to enable higher visibility and control in such a hybrid/multi-cloud environment might benefit from one control plane over a consistent, cross-platform environment—with uniform development, unified dev-ops and management, common identity and security, and extension of existing applications and infrastructure across private cloud, public cloud, and edge computing resources.

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
