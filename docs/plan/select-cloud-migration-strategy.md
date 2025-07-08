---
title: Select your cloud migration strategies
description: Learn how to select the right cloud migration strategy for each workload based on business goals, technical requirements, and organizational readiness to maximize Azure adoption success.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Select your cloud migration strategies

For each workload in your inventory, choose the most appropriate approach option: retire, retain, migrate as is (rehost), modernize (replatform, refactor, rearchitect), rebuild, and replace. Make this decision based on a knowledge of migration and modernization best practices. Selecting the appropriate migration strategy ensures that each workload aligns with business goals and maximizes cloud value. Follow these recommendations:

| Business goal | Cloud migration strategy | Drivers | Example Success Metrics |
|--------------|------------------------|---------|------------------------|
| Eliminate workloads of limited value | Retire | • Workload has limited current business value<br>• Migration cost outweighs business benefits | • Retire 100% of workloads identified as obsolete before migration |
| Adopt cloud with minimal disruption | Rehost | • Low risk migration<br>• Short-term cloud adoption goals<br>• Reduce capital expense<br>• Free up datacenter space<br>• Inexperience with Azure | • Migrate 100% of Tier 1 workloads from AWS to Azure with no SLA degradation<br>• Decommission 30% of on-premises infrastructure post-migration |
| Modernize workload with minimal investment | Replatform | • Simplified reliability<br>• Easier disaster recovery<br>• Offload operating system security<br>• Reduce licensing costs<br>• Moderate time-to-cloud with some benefits.  | • Reduce deployment lead times by 30% for migrated applications<br>• Reduce infrastructure and licensing costs by 25% within 12 months |
| Code changes deliver short- or long-term value | Refactor | • Decrease cost of maintenance<br>• Reduce technical debt <br>• Use Azure SDKs<br>• Improve code performance<br>• Optimize code costs<br>• Apply cloud design patterns<br>• Instrument code for monitoring | • Improve application response time by 40% using Azure-native services<br>• Achieve 95% observability coverage through code instrumentation |
| Meet business requirements better | Rearchitect | • Meet new business requirements<br>• Targeted scaling<br>• Service-oriented architecture<br>• Easier adoption of new technologies<br>• Mix technology stacks | • Support 2x user load with no performance degradation<br>• Integrate 3 new Azure-native services into existing architecture |
| Modernizing critical workload isn't worth it | Rebuild | • Legacy system is too outdated or inflexible<br>• Accelerate innovation<br>• Build applications faster<br>• Reduce operational cost<br>• Need modern frameworks and tools | • Launch new cloud-native application in 3 months vs. 6 months on-prem<br>• Cut operational costs by 40% using PaaS services |
| SaaS solution meets needs | Replace | • Simplify operations<br>• Focus development effort on strategic apps<br>• Little need for customization | • Transition CRM to SaaS with 99.9% uptime and no custom code<br>• Shift 30% of dev effort to competitive differentiators |
| Maintain stability and avoid unnecessary change | Retain | • Workload is stable, compliant, and meets current/future needs<br>• No near-term driver to move<br>•Low ROI from migration. | • Maintain current SLA and compliance posture<br>• Manage on-premises workloads from Azure using Azure Arc |

## Define business goals for each workload

Clear business goals ensure that each migration decision delivers measurable value and justifies the investment in cloud adoption. Each workload must align with specific business outcomes to support organizational objectives. You must define business goals before you select a migration strategy to ensure strategic alignment. Follow these recommendations:

1. **Identify specific business goals for each workload.** Business goals drive the urgency and type of migration strategy you apply. Common goals include operational efficiency, compliance requirements, innovation acceleration, and business agility improvements. Document these goals to create a clear foundation for decision-making.

2. **Define measurable success metrics for each goal.** Quantifiable metrics demonstrate the business value of migration decisions. Use metrics such as SLA improvements, cost savings percentages, deployment frequency increases, or user experience enhancements. Avoid metrics that only measure infrastructure relocation or technical completion, as these don't reflect business value.

3. **Map each workload to a migration strategy based on business context.** Use the documented business goals and drivers to guide your selection of the most appropriate migration strategy. This mapping ensures each decision supports broader organizational objectives and maximizes return on cloud investment.

## Understand migration and modernization best practices

Successful migrations to Azure follow consistent patterns. Understand these patterns before deciding how to handle each workload.

### Know when to rehost then modernize

A rehost is a like-for-like migration strategy. You move workloads to Azure with minimal changes, providing a fast and low-risk path to cloud adoption. This approach establishes a foundation for future modernization while minimizing business disruption. You must plan for both rehosting and modernization phases to achieve successful cloud adoption.

1. **Rehost workloads to minimize business disruption.** A like-for-like migration transfers workloads to Azure with the fewest possible changes, enabling rapid adoption and reducing migration complexity. This strategy allows your organization to realize immediate cloud benefits, such as improved scalability and availability, without requiring new application development skills. Use Azure Migrate or partner tools to assess dependencies and automate workload migrations from on-premises or other cloud platforms. Prioritize rehosting to establish baseline cloud operations and reduce the risk of deployment failures. Adopt new processes and practices more effectively by keeping workloads similar to their source environment. Plan to modernize workloads in Azure after rehosting, especially for large-scale datacenter transformations. Launch a cloud skills initiative in parallel to build team readiness for future modernization. See [Shared responsibility in the cloud](/azure/security/fundamentals/shared-responsibility).

2. **Rehost to build cloud operational capabilities.** Rehosting provides hands-on experience with Azure services, security models, and operational procedures. This experience prepares teams for more advanced modernization efforts. Train teams on Azure Resource Manager templates, monitoring tools, and backup procedures during rehosting projects to support long-term cloud operations.

3. **Rehost when modernization skills or time are limited.** Teams without established Azure modernization skills or with tight migration timelines benefit from initial rehosting. This approach delivers operational Azure experience while maintaining stable workload performance. Document current application architectures, establish cloud operational baselines, and build team expertise by managing rehosted workloads before pursuing complex modernization.

4. **Commit to modernization post-migration.** Post-migration modernization requires clear commitment and resource allocation to avoid indefinite delays. Executive sponsorship ensures continued investment after initial migration. Set modernization milestones within six months of migration completion, assign dedicated resources, and establish success metrics aligned with business objectives.

5. **Document technical debt and modernization opportunities during migration.** Migration assessments reveal architectural limitations and areas for improvement that support future modernization. Catalog performance bottlenecks, security vulnerabilities, and cost optimization opportunities identified during migration planning to build strong business cases for modernization.

6. **Use Azure operational data to prioritize modernization.** Running workloads in Azure generates performance metrics and cost data that inform modernization decisions. Analyze Azure Monitor metrics, Cost Management reports, and Azure Advisor recommendations after 30–60 days of operation to identify and prioritize workloads that offer the greatest modernization value.

### Know when to modernize workloads during migration

While modernizing as you migrate can yield long-term benefits, it also introduces additional complexity and risk. Only pursue modernization during migration when there is a compelling business reason to do so. For each potential modernization effort, be sure to perform a thorough cost-benefit and risk analysis before proceeding.

1. **Modernize when you have the skills and time.** An attempt to modernize without the necessary Azure skills or time can delay migration and increase risk. If your team lacks experience or time, defer the workload to a later migration wave.

1. **Modernize when current technology is incompatible with Azure.** Legacy technologies, unsupported SDKs, or the need to adopt SaaS solutions may require modernization. Justify each effort with a clear business case.

1. **Modernize problematic workloads.** Rehosting won’t fix performance or architectural issues. If a workload is business-critical and underperforming, consider modernize during migration.

1. **Modernize when a migration provides the best opportunity.** Migration projects often present the best opportunity to secure funding for modernization efforts. Take advantage of this moment to align modernization activities with business priorities. Delaying modernization may result in running inefficient workloads in Azure and missing the chance to get stakeholder support later. This can lead to higher costs from inefficient code, unnecessary calls, and increased maintenance requirements.

1. **Modernize only after you understand operational effects.** Many organizations assume that moving to PaaS always reduces costs compared to IaaS. This assumption can lead to premature modernization without proper vetting. Validate cost, skill, and process impacts before modernizing. Review current workload requirements and compare them to Azure IaaS and PaaS capabilities. Analyze total cost of ownership for each service model, including operational, licensing, and support costs. 

## Select the appropriate migration strategy for each workload

The selection of migration strategies determines the success of your cloud adoption effort. Each strategy offers distinct benefits and tradeoffs that must align with your documented business goals. You must evaluate each workload against available strategies to ensure optimal outcomes. Follow these recommendations:

1. **Retire workloads that no longer provide business value.** Workloads become obsolete when the cost to migrate and operate them exceeds their business value. Validate this decision by confirming that the workload is obsolete and has no critical dependencies that would impact other systems.

2. **Rehost workloads for fast, low-risk migration.** A rehost strategy moves workload components to the most similar Azure service with only necessary code changes. This approach provides low-risk, low-effort, and fast migration outcomes when timelines are short. Rehost represents the recommended approach for most workloads because it minimizes disruption while establishing cloud presence.

    | Source and Azure Target | Examples | Like-for-like Mapping Guidance |
    |--------------------------|----------|--------------------------------|
    | On-premises → Azure Virtual Machines | On-premises servers → Azure Virtual Machines | [Technology decision guides](/azure/architecture/guide/technology-choices/compute-decision-tree) |
    | Other cloud IaaS → Azure VMs | AWS EC2 → Azure Virtual Machines, GCP Compute Engine → Azure Virtual Machines | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics), [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) |
    | Other cloud PaaS → Azure PaaS | AWS Beanstalk → Azure App Service, GCP App Engine → Azure App Service | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics), [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) |

3. **Replatform workloads for operational efficiency.** A replatform strategy makes minimal changes to move a workload to a new hosting environment, typically adopting platform-as-a-service (PaaS). This approach reduces operational overhead of workload management but adds risk and potential delays to migration timelines. Replatform for reduced management overhead, faster updates, code portability, and improved resource efficiency. Implement replatform when the business value of the new environment justifies the investment. Some code refactoring or cloud design patterns might be necessary to take advantage of PaaS services.

4. **Refactor workloads to optimize code.** Refactor improves code without changing functionality or end-user experience, such as addressing technical debt or updating code frameworks. Refactor after the workload is stable in Azure to observe how the new environment changes code behavior. However, if migration presents a unique opportunity to resolve technical debt that might not occur later, align modernization activities with business priorities. Teams often introduce cloud design patterns, such as Retry and Circuit Breaker, during migration to take advantage of the cloud environment.

5. **Rearchitect workloads to modernize architecture.** Rearchitect redesigns how workload components interact, such as breaking out microservices from monolithic applications. This strategy requires code refactoring to support architectural changes. Only rearchitect before migration if you are unsure that moving the system to the cloud is the right choice. Otherwise, migrate as is and modernize in Azure for reduced risk. Rearchitect when you want service-oriented architecture, targeted scaling, easier tech adoption. Use the [Well-Architected Framework](/azure/well-architected/pillars) to guide successful rearchitecting. For examples, see [Modern Web App Pattern for .NET](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance).

6. **Replace workloads with SaaS solutions when customization needs are minimal.** A replace strategy substitutes custom applications with commercial software-as-a-service (SaaS) solutions that meet business requirements. This approach eliminates development and maintenance overhead while providing proven functionality. Replace workloads when SaaS solutions offer comparable features, integration capabilities meet requirements, and total cost of ownership justifies the transition. Consider data migration complexity, user training needs, and process changes when you evaluate replacement options. Common replacement scenarios include CRM systems, HR platforms, and collaboration tools where SaaS maturity provides reliable alternatives to custom solutions.

7. **Rebuild workloads using cloud-native technologies.** A rebuild strategy creates a new, cloud-native version of a workload using modern Azure services. This strategy is important when legacy systems no longer meet business or technical requirements and modernization is not cost-effective. You must rebuild when the workload is essential but the current system cannot support future needs or integrate effectively with Azure.

8. **Retain workloads that meet current and future business needs.** A retain strategy keeps workloads in their current environment when they are stable, compliant, and meet all current and future business needs with no near-term driver to move. You must retain workloads that cannot be migrated due to regulatory constraints, technical dependencies, or business continuity requirements. Use Azure Arc to manage retained on-premises workloads from Azure, providing unified management capabilities. Shift workloads that cannot be migrated to another migration wave or revisit them later when constraints change.

## Communicate and align decisions with stakeholders

Clear communication ensures all stakeholders understand and support migration decisions throughout the adoption process. Stakeholder alignment reduces execution risk and improves project outcomes by establishing shared understanding of priorities and constraints. You must establish a structured communication plan to maintain alignment throughout the migration process. Follow these recommendations:

1. **Document and share workload treatment decisions with all relevant stakeholders.** Migration decisions impact multiple organizational functions and require broad stakeholder input. Include business owners, legal teams, security teams, and technical leads in decision communication to ensure comprehensive understanding. Explain how each migration strategy decision supports documented business goals and addresses stakeholder concerns.

2. **Coordinate migration plans with the cloud strategy team.** The cloud strategy team provides organizational context and ensures migration decisions align with broader cloud adoption objectives. Regular coordination prevents conflicts between individual workload decisions and enterprise-wide cloud strategy. Review migration strategy selections against the cloud adoption plan established during the Strategy phase to maintain consistency.

3. **Establish regular communication between mandate owners and execution teams.** Ongoing communication between decision makers and implementers ensures plans remain viable as technical realities emerge. Schedule regular progress reviews to track migration progress, identify risks, and address technical issues. Use this feedback loop to adjust migration strategies when implementation challenges or new opportunities arise.

4. **Review and update migration strategies based on evolving requirements.** Business priorities and technical insights change throughout the migration process, requiring strategy adjustments. Establish a regular review cycle to reassess workload treatment decisions against current business goals and technical capabilities. Update strategy mappings to reflect new priorities, lessons learned, and changing organizational needs.

## Next steps

> [!div class="nextstepaction"]
> [Assess your workload](./assess-workloads-for-cloud-migration.md)
