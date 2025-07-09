---
title: Select your cloud migration strategies
description: Learn how to select the right cloud migration strategy for each workload based on business goals, technical requirements, and organizational readiness to maximize Azure adoption success.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Select your cloud migration strategies

For each workload in your inventory, choose the most appropriate approach option: retire, retain, migrate as is (rehost), modernize (replatform, refactor, rearchitect), rebuild, and replace. Make this decision based on a knowledge of migration and modernization best practices. Selecting the appropriate migration strategy ensures that each workload aligns with business goals and maximizes cloud value.

| **Cloud migration strategy** | Business drivers | Ways to validate your migration strategy selection | Example success metrics |
|------------------------|------------------|------------|------------------------|
| **Retire** | Eliminate workloads of limited value | • Workload has limited current or future business value<br>• Migration or modernization cost outweighs business benefits | • Retire 100% of workloads identified as obsolete before migration |
| **Rehost** | Adopt cloud with minimal disruption | • Workload is stable<br>• Workload is compatible with Azure<br>• Low risk migration<br>• Short-term cloud adoption goals<br>• No immediate need for modernization<br>• Reduce capital expense<br>• Free up datacenter space<br>• Inexperience with Azure | • Migrate 100% of Tier 1 workloads from AWS to Azure with no SLA degradation<br>• Decommission 30% of on-premises infrastructure post-migration |
| **Replatform** | Modernize workload with minimal investment | • Simplify reliability and disaster recovery<br>• Reduce OS and licensing overhead<br>• Improve time-to-cloud with moderate investment | • Reduce deployment lead times by 30% for migrated applications<br>• Reduce infrastructure and licensing costs by 25% within 12 months |
| **Refactor** | Code changes deliver short- or long-term value | • Decrease cost of maintenance<br>• Reduce technical debt<br>• Use Azure SDKs<br>• Improve code performance<br>• Optimize code costs<br>• Apply cloud design patterns<br>• Instrument code for monitoring | • Improve application response time by 40% using Azure-native services<br>• Achieve 95% observability coverage through code instrumentation |
| **Rearchitect** | Meet business requirements better | • Application requires modularization or service decomposition<br>• Scaling needs vary by component<br>• Architecture must support future innovation<br>• Mix technology stacks | • Support 2x user load with no performance degradation<br>• Integrate 3 new Azure-native services into existing architecture |
| **Rebuild** | Modernizing a critical workload is not worth it | • Legacy system is too outdated or inflexible<br>• Accelerate innovation<br>• Build applications faster<br>• Reduce operational cost<br>• Need modern frameworks and tools | • Launch new cloud-native application in 3 months vs. 6 months on-prem<br>• Cut operational costs by 40% using PaaS services |
| **Replace** | SaaS solution meets needs | • Simplify operations<br>• Internal development resources are better used elsewhere<br>• Little need for customization | • Transition CRM to SaaS with 99.9% uptime and no custom code<br>• Shift 30% of dev effort to competitive differentiators |
| **Retain** | Maintain stability and avoid unnecessary change | • Workload is stable, compliant, and meets business needs<br>• No near-term driver to move<br>• Low ROI from migration | • Maintain current SLA and compliance posture<br>• Manage on-premises workloads from Azure using Azure Arc |

## Define business goals for each workload

A clear set of business goals ensures that each cloud migration decision delivers measurable value and aligns with organizational priorities. Business goals provide the foundation for selecting the right migration strategy and maximizing return on investment.
You must define business goals before selecting a migration strategy to ensure each workload supports broader organizational outcomes.

1. **Identify specific business drivers for each workload.** Business drivers are the underlying motivations for cloud adoption. These include cost optimization, operational efficiency, compliance, innovation, scalability, and business continuity. Identifying these drivers clarifies the urgency and direction of migration decisions. Document each driver to ensure alignment across stakeholders.

2. **Define measurable success metrics for each goal.** Success metrics quantify the value of migration and validate whether business goals are achieved. Use metrics such as SLA improvements, cost reduction percentages, deployment frequency, or user satisfaction scores. Avoid metrics that only reflect technical completion, such as VM counts or storage migration, as they do not demonstrate business value.

3. **Map each workload to a migration strategy based on business context.** Migration strategies, such as rehost, refactor, rearchitect, rebuild, or replace, must align with the workload’s business drivers. For example, select rehost for cost-driven migrations or refactor for innovation-focused goals. This mapping ensures each workload contributes to strategic outcomes and supports long-term cloud maturity.

## Select the appropriate migration strategy for each workload

The selection of migration strategies determines the success of your cloud adoption effort. Each strategy offers distinct benefits and tradeoffs that must align with your documented business goals. You must evaluate each workload against available strategies to ensure optimal outcomes. Follow these recommendations:

### 1. Retire (decommission)

Retire workloads that no longer provide business value. Workloads become obsolete when the cost to migrate and operate them exceeds their business value. Validate this decision by confirming that the workload is obsolete and has no critical dependencies that would impact other systems. Update your inventory as you decommission workloads.

### 2. Rehost (like-for-like migration)

A rehost strategy enables fast and low-risk migration by moving workloads to Azure with minimal changes. A rehost is a like-for-like migration, which moves virtual machines to IaaS, IaaS to IaaS, and PaaS to PaaS.

    - **Don't rehost problematic workloads.** Rehosting does not resolve existing performance, reliability, or architectural issues. Migrating such workloads without modernization can carry forward technical debt and require rework later. Instead, modernize these workloads during migration to address root causes.

    - **Confirm that the workload will not require modernization within two years.** Rehosting is suitable only when you are confident that the workload will remain in its current state for at least two years. If modernization is likely, consider refactoring or rearchitecting instead to avoid duplicate effort.

    - **Use rehost to build foundational cloud operations.** Rehosting helps teams gain experience with Azure operations, governance, and cost management. This early exposure supports broader cloud adoption goals and prepares teams for more complex modernization efforts.

    | Workload type | Azure target | Examples | Like-for-like Mapping Guidance |
    |--------------| --- | ----------|--------------------------------|
    | On-premises | → Azure IaaS | On-premises servers → Azure Virtual Machines | [Technology decision guides](/azure/architecture/guide/technology-choices/compute-decision-tree) |
    | Other cloud IaaS | → Azure IaaS | AWS EC2 → Azure Virtual Machines<br>GCP Compute Engine → Azure Virtual Machines | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics), [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) |
    | Other cloud PaaS | → Azure PaaS | AWS Beanstalk → Azure App Service<br>GCP App Engine → Azure App Service | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics), [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) |

### Modernize

#### **Replatform (modernize hosting environment).**

A replatform strategy makes minimal changes to move a workload to a new hosting environment, typically adopting platform-as-a-service (PaaS). This approach reduces operational overhead of workload management but adds risk and potential delays to migration timelines. Replatform for reduced management overhead, faster updates, code portability, and improved resource efficiency. Implement replatform when the business value of the new environment justifies the investment. Some code refactoring or cloud design patterns might be necessary to take advantage of PaaS services. Validate operational impacts before selecting PaaS services. Moving to PaaS does not always reduce costs. Assess the total cost of ownership, including operational, licensing, and support costs. Compare IaaS and PaaS options against workload requirements to make informed decisions.

#### 4. **Refactor (modernize code).** 

Refactor improves code without changing functionality or end-user experience, such as addressing technical debt or updating code frameworks. Refactor after the workload is stable in Azure to observe how the new environment changes code behavior. However, if migration presents a unique opportunity to resolve technical debt that might not occur later, align modernization activities with business priorities. Teams often introduce cloud design patterns, such as Retry and Circuit Breaker, during migration to take advantage of the cloud environment.

#### 5. **Rearchitect (modernize architecture and code).** 

Rearchitect workloads to modernize architecture. Rearchitect redesigns how workload components interact, such as breaking out microservices from monolithic applications. This strategy requires code refactoring to support architectural changes. Rearchitect when you want service-oriented architecture, targeted scaling, easier tech adoption. Use the [Well-Architected Framework](/azure/well-architected/pillars) to guide your design. For an example, see [Modern Web App Pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance).

### 6. **Replace (use SaaS alternative).** 

Replace workloads with SaaS solutions when customization needs are minimal. A replace strategy substitutes custom applications with commercial software-as-a-service (SaaS) solutions that meet business requirements. This approach eliminates development and maintenance overhead while providing proven functionality. Replace workloads when SaaS solutions offer comparable features, integration capabilities meet requirements, and total cost of ownership justifies the transition. Consider data migration complexity, user training needs, and process changes when you evaluate replacement options. Common replacement scenarios include CRM systems, HR platforms, and collaboration tools where SaaS maturity provides reliable alternatives to custom solutions.

### 7. **Rebuild (build cloud-native).** 

Rebuild is the right strategy when legacy systems no longer meet business or technical needs and modernization isn’t viable. It involves creating a new solution from scratch using Azure-native services—maximizing scalability, reliability, and security. This approach allows you to reimagine the workload. Rather than replicating legacy functionality, you can redesign the solution to use Azure capabilities like PaaS, automation, and AI. Replace infrastructure services like DHCP with Azure-native alternatives, and deploy new instances of services like Active Directory Domain Controllers in Azure rather than migrating them.

### 8. **Retain (keep as is).** 

A retain strategy keeps workloads in their current environment when they are stable, compliant, and meet all current and future business needs with no near-term driver to move. You must retain workloads that cannot be migrated due to regulatory constraints, technical dependencies, or business continuity requirements. Use Azure Arc to manage retained on-premises workloads from Azure, providing unified management capabilities. Shift workloads that cannot be migrated to another migration wave or revisit them later when constraints change.

## Understand when to modernize during migration

Modernization during migration refers to replatforming, rearchitecting, or refactoring workloads to maximize cloud value. Modernization can deliver long-term benefits but introduces complexity and risk to migration timelines. You must evaluate whether to modernize during migration or defer modernization to post-migration phases based on clear business justification. Follow these recommendations:

1. **Modernize when your team has the required skills and time.** Attempting modernization without adequate expertise or time increases risk and delays. If your team lacks readiness, defer modernization to a later phase.

2. **Modernize workloads that require compatibility updates.** Legacy technologies, unsupported SDKs, or the need to adopt SaaS solutions may require modernization. Justify each effort with a clear business case.

3. **Modernize when migration enables funding and alignment.** Migration projects often unlock funding and stakeholder support. Use this opportunity to align modernization with business priorities. Delaying may result in inefficient workloads and missed opportunities.

## Communicate and align decisions with stakeholders

Clear communication ensures all stakeholders understand and support migration decisions throughout the adoption process. Stakeholder alignment reduces execution risk and improves project outcomes by establishing shared understanding of priorities and constraints. You must establish a structured communication plan to maintain alignment throughout the migration process. Follow these recommendations:

1. **Document and share workload treatment decisions with all relevant stakeholders.** Migration decisions impact multiple organizational functions and require broad stakeholder input. Include business owners, legal teams, security teams, and technical leads in decision communication to ensure comprehensive understanding. Explain how each migration strategy decision supports documented business goals and addresses stakeholder concerns.

2. **Coordinate migration plans with the cloud strategy team.** The cloud strategy team provides organizational context and ensures migration decisions align with broader cloud adoption objectives. Regular coordination prevents conflicts between individual workload decisions and enterprise-wide cloud strategy. Review migration strategy selections against the cloud adoption plan established during the Strategy phase to maintain consistency.

3. **Establish regular communication between mandate owners and execution teams.** Ongoing communication between decision makers and implementers ensures plans remain viable as technical realities emerge. Schedule regular progress reviews to track migration progress, identify risks, and address technical issues. Use this feedback loop to adjust migration strategies when implementation challenges or new opportunities arise.

4. **Review and update migration strategies based on evolving requirements.** Business priorities and technical insights change throughout the migration process, requiring strategy adjustments. Establish a regular review cycle to reassess workload treatment decisions against current business goals and technical capabilities. Update strategy mappings to reflect new priorities, lessons learned, and changing organizational needs.

## Next steps

> [!div class="nextstepaction"]
> [Assess your workload](./assess-workloads-for-cloud-migration.md)
