---
title: Select your cloud migration strategies
description: Select cloud migration strategies for your workloads. Choose between retire, rehost, replatform, refactor, rearchitect, rebuild, or replace based on business goals and technical requirements.
author: stephen-sumner
ms.author: pnp
ms.date: 07/15/2025
ms.topic: conceptual
---

# Select your cloud migration strategies

This article helps you select the most appropriate cloud migration strategy for each workload in your portfolio. Each strategy (retire, retain, rehost, replatform, refactor, rearchitect, rebuild, or replace) offers distinct benefits and tradeoffs that must align with your business goals and technical requirements.

## Migration strategy overview

The following table provides a comprehensive overview of all available cloud migration strategies. Use this reference to understand each strategy's primary business drivers and key indicators that signal when to apply each approach to your workloads.

| Cloud migration strategy | Business driver | Key indicators for this strategy |
|--------------------------|------------------|------------------------------|
| [Retire](#1-retire-decommission) | Eliminate workloads of limited value. | • Workload has limited current or future business value. • Migration or modernization cost outweighs business benefits. |
| [Rehost](#2-rehost-like-for-like-migration) | Adopt cloud with minimal business disruption. | • Workload is stable. • Workload is compatible with Azure. • Low-risk migration. • Short-term cloud adoption goals. • No immediate need for modernization. • Reduce capital expense. • Free up datacenter space. • Inexperience with Azure. |
| [Replatform](#3-replatform-modernize-hosting-environment) | Take advantage of managed services with minimal investment. | • Simplify reliability and disaster recovery. • Reduce OS and licensing overhead. • Improve time-to-cloud with moderate investment. • Containerize app. |
| [Refactor](#4-refactor-modernize-code) | Code changes deliver short- or long-term value. | • Decrease cost of maintenance. • Reduce technical debt. • Use Azure SDKs. • Improve code performance. • Optimize code costs. • Apply cloud design patterns. • Instrument code for monitoring. |
| [Rearchitect](#5-rearchitect-modernize-architecture-and-code) | Meet business requirements better with modernized architecture. | • Application requires modularization or service decomposition. • Scaling needs vary by component. • Architecture must support future innovation. • Mix technology stacks. |
| [Replace](#6-replace-use-saas-alternative) | SaaS/AI solution meets needs. | • Simplify operations. • Internal development resources are better used elsewhere. • Little need for customization. |
| [Rebuild](#7-rebuild-build-cloud-native) | Critical legacy systems are obsolete and modernization isn't viable. | • Legacy system is too outdated or inflexible. • Build applications faster. • Reduce operational cost. • Need modern frameworks and tools. |
| [Retain](#8-retain-keep-as-is) | Maintain stability and avoid unnecessary change. | • Workload is stable, compliant, and meets business needs. • No near-term driver to move. • Low ROI from migration. |

## Define business drivers for each workload

A business driver is a specific, measurable reason for making decisions about a workload during cloud adoption. Clearly defining these drivers ensures that migration strategies align with business goals and deliver tangible value.

1. **Identify the current business value of the workload.** Evaluate how the workload supports current operations. This helps determine whether it warrants further investment or should be retired.

    - Analyze usage metrics, cost reports, and stakeholder feedback.
    - Identify dependencies and system integrations.
    - Document how the workload contributes to business outcomes (revenue, compliance, customer experience).

2. **Assess the workload’s future relevance.** Determine whether the workload remains relevant to future business strategies. This assessment ensures that cloud investments support long-term goals.

    - Align the workload with strategic initiatives, such as market expansion or product innovation.
    - Evaluate whether the workload can scale or adapt to future needs.
    - Consider whether emerging technologies or business models will replace or enhance the workload.

3. **Map the workload to business goals.** Link the workload to specific business goals to clarify its strategic importance. This mapping ensures that migration decisions support measurable outcomes.

    - Use business goal categories such as agility, innovation, cost optimization, resilience, or sustainability.
    - Engage business stakeholders to validate alignment.
    - Prioritize workloads that directly support high-impact goals.

4. **Define the primary business driver.** Select the main driver that best reflects the workload’s current role and future potential. This guides the choice of migration strategy.

    | Business driver | Migration strategy |
    |------------------|--------------------|
    | Need to decommission redundant or low-value workloads | Retire |
    | Need minimal business disruption and no modernization in near future | Rehost |
    | Need PaaS solutions and minimal code changes to meet business goals | Replatform |
    | Need code changes to meet business goals | Refactor |
    | Need architecture changes to meet goals | Rearchitect |
    | Need SaaS/AI solution to simplify operations | Replace |
    | Need new cloud-native solution to meet requirements | Rebuild |
    | Need stability and avoid change | Retain |

## Engage workload teams to validate business drivers and migration strategies

Workload team engagement ensures that migration strategies align with technical realities and business priorities. This engagement is essential to validate assumptions, uncover constraints, and build shared ownership of migration outcomes.

You must engage workload teams early to confirm that business drivers are accurate and that selected migration strategies are feasible and aligned with delivery timelines.

1. **Communicate the business rationale and migration scope.** Share the defined business drivers, expected outcomes, and proposed migration strategy with each workload team. Clear communication ensures that teams understand the strategic context and can provide informed feedback. This step builds trust and encourages collaboration.

2. **Request documentation of current and target architectures.** Ask workload teams to provide architecture diagrams, service dependencies, and integration points. This documentation helps validate the feasibility of the proposed migration strategy and identifies technical risks or gaps that might require adjustments.

3. **Validate alignment between business drivers and technical realities.** Review the selected migration strategy with each workload team to confirm that it supports the workload’s business goals and technical constraints. This validation ensures that the strategy is both achievable and aligned with long-term objectives.

4. **Provide support for constrained teams.** Assign migration specialists or temporary resources to assist teams with limited capacity. This support helps maintain project momentum and ensures that all workloads receive the attention needed to meet migration timelines.

5. **Secure executive sponsorship to reinforce priorities.** Ensure that executive sponsors communicate the importance of migration activities and set clear expectations. Executive alignment helps workload teams prioritize migration tasks alongside operational responsibilities.

## Select the right migration strategy

A migration strategy defines how each workload transitions to Azure. This decision must align with business drivers to ensure that cloud adoption delivers measurable value. You must use the defined business driver to eliminate unsuitable options and select the most effective strategy for each workload.

### 1. Retire (decommission)

Retire decommissions workloads that no longer provide business value. This strategy is important when workloads are obsolete, underused, or redundant. Validate this decision by confirming that the workload is obsolete and has no critical dependencies that would affect other systems. Update your inventory as you decommission workloads.

| Business driver | Key indicators for this strategy |
|----------|----------|
| Need to decommission redundant or low-value workloads | • Workload has limited current or future business value<br>• Migration or modernization cost outweighs business benefits |

### 2. Rehost (like-for-like migration)

A rehost strategy enables fast and low-risk migration by moving workloads to Azure with minimal changes. A rehost is a like-for-like migration, which moves virtual machines to IaaS, IaaS to IaaS, and PaaS to PaaS.

| Business driver | Key indicators for this strategy |
|----------------------|------------------------|
| Need minimal business disruption and no modernization in near future | • Workload is stable<br>• Workload is compatible with Azure<br>• Low-risk migration<br>• Short-term cloud adoption goals<br>• No immediate need for modernization<br>• Reduce capital expense<br>• Free up datacenter space<br>• Inexperience with Azure |

1. **Don't rehost problematic workloads.** Rehosting doesn't resolve existing performance, reliability, or architectural issues. Migrating such workloads without modernization can carry forward technical debt and require rework later. Instead, modernize these workloads during migration to address root causes.

2. **Confirm that the workload will not require modernization within two years.** Rehosting is suitable only when you're confident that the workload remains in its current state for at least two years. If modernization is likely, consider refactoring or rearchitecting instead to avoid duplicate effort.

3. **Use rehost to build foundational cloud operations.** Rehosting helps teams gain experience with Azure operations, governance, and cost management. This early exposure supports broader cloud adoption goals and prepares teams for more complex modernization efforts.

| Source environment | Azure target | Rehosting examples | Guidance |
|--------------| --- | ----------|--------------------------------|
| On-premises | Azure IaaS | On-premises servers → Azure Virtual Machines | [Technology decision guides](/azure/architecture/guide/technology-choices/compute-decision-tree) |
|Other cloud IaaS | Azure IaaS | AWS EC2 → Azure Virtual Machines<br><br>GCP Compute Engine → Azure Virtual Machines | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) <br> [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) |
| Other cloud PaaS | Azure PaaS | AWS Beanstalk → Azure App Service<br><br>GCP App Engine → Azure App Service | [AWS to Azure service mapping](/azure/architecture/aws-professional/#primary-topics) <br> [GCP to Azure service mapping](/azure/architecture/gcp-professional/services) |

### 3. Replatform (modernize hosting environment)

Replatforming moves workloads to a modern hosting environment with minimal code changes. This strategy is important when you want to reduce infrastructure management, improve scalability, and simplify operations without a full application rewrite.

| Business driver | Key indicators for this strategy |
|------------------|---------------------------|
| Need PaaS solutions and minimal code changes to meet business goals | • Workload benefits from simplified reliability and disaster recovery<br>• Workload reduces OS and licensing overhead<br>• Team can containerize or repackage the app with moderate effort<br>• Migration improves time-to-cloud without major refactoring |

Choose workloads where PaaS options reduce operational overhead, improve reliability, or simplify disaster recovery. Minimal code refactoring might be necessary to take advantage of PaaS services.

| Source environment | Azure target | Replatforming examples | Guidance |
|---------------|--------------|--------------------------| ---------|
| On-premises | Azure PaaS | VMs → Azure App Service<br><br>SQL Server on a VM → Azure SQL Database | [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) <br> [Database migration guides](/data-migration/) |
| Other cloud IaaS | Azure PaaS | AWS EC2 → Azure App Service<br><br>MySQL on AWS EC2 → Azure SQL Database | [Other cloud to Azure migration](/azure/migration/migrate-to-azure) <br> [Database migration guides](/data-migration/) |
| Azure IaaS | Azure PaaS | Azure Virtual Machines → Azure App Service<br><br>SQL Server on Azure Virtual Machines → Azure SQL Database | [Reliable web app pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/reliable-web-app/dotnet/guidance) <br> [Database migration guides](/data-migration/) |

### 4. Refactor (modernize code)

Refactoring improves the internal structure of code without adding new features. This practice is important during cloud adoption because it helps teams modernize legacy code, reduce technical debt, and prepare workloads for long-term maintainability in Azure. You should refactor code when the migration process creates a unique opportunity to address technical debt or when post-migration behavior reveals areas for improvement.

| Business driver | Key indicators for this strategy |
|----------------------|--------------------------------------------|
| Need code changes to meet business goals | • The workload has high maintenance costs<br>• The codebase contains significant technical debt<br>• Azure SDKs or services can improve performance or observability<br>• The team can optimize code costs or apply cloud design patterns |

### 5. Rearchitect (modernize architecture and code)

A rearchitect strategy redesigns the workload’s architecture to improve scalability, agility, and service orientation. This strategy is important when you need to break down monolithic applications, adopt microservices, or enable targeted scaling. You should rearchitect when your current architecture limits your ability to meet business goals or scale effectively. For an example, see [Modern Web App Pattern](/azure/architecture/web-apps/guides/enterprise-app-patterns/modern-web-app/dotnet/guidance).

| Business driver | Key indicators for this strategy |
|----------------------|------------------------------|
| Need architecture changes to meet goals | • The application requires modularization or service decomposition<br>• Scaling needs vary by component<br>• The architecture must support future innovation<br>• The solution uses mixed technology stacks|

### 6. Replace (use SaaS alternative)

A replace strategy uses commercial SaaS solutions to eliminate the need for custom development and ongoing maintenance. This strategy is ideal when SaaS offerings meet business needs with minimal customization. Replace workloads when SaaS solutions offer comparable features, integration capabilities meet requirements, and total cost of ownership justifies the transition. Consider data migration complexity, user training needs, and process changes when you evaluate replacement options. Common replacement scenarios include CRM systems, HR platforms, and collaboration tools where SaaS maturity provides reliable alternatives to custom solutions.

| Business driver | Key indicators for this strategy |
|----------------------|------------------------------|
| Need SaaS/AI solution to simplify operations | • The legacy system is too outdated or inflexible<br>• The team needs to accelerate innovation<br>• The solution requires modern frameworks and tools<br>• Operational costs are too high in the current environment |

### 7. Rebuild (build cloud-native)

A rebuild strategy is a full redevelopment of a workload using cloud-native solutions. This approach is appropriate when legacy systems are obsolete or when modernization isn't feasible. Rather than modernizing legacy functionality, you can reimagine the solution to use Azure capabilities like PaaS, automation, and AI. Some workloads required a rebuild, like DHCP server. For other workloads, it's better to deploy new instances of services in Azure rather than migrating them, such as Active Directory Domain Controllers.

| Business driver | Key indicators for this strategy |
|----------------------|------------------------------|
| Need new cloud-native solution to meet requirements | • The workload has a mature SaaS alternative<br>• Internal development resources are better used elsewhere<br>• The solution requires little customization |

### 8. Retain (keep as is)

A retain strategy keeps workloads in their current environment when they're stable, compliant, and meet all current and future business needs with no near-term driver to move. You must retain workloads that can't be migrated due to regulatory constraints, technical dependencies, or business continuity requirements. Use [Azure Arc](/azure/azure-arc/overview) to manage retained on-premises workloads from Azure, providing unified management capabilities. Consider a more modern on-premises solution like [Azure Local](/azure/azure-local/overview) for your workloads and connect to Azure. Shift workloads that can't be migrated to another migration wave or revisit them later when constraints change.

| Business driver | Key indicators for this strategy |
|----------------------|------------------------------|
| Need stability and avoid change | • The workload is stable, compliant, and meets business needs<br>• There is no near-term driver to migrate<br>• Migration offers low return on investment |

## Understand when to modernize during migration

Modernization during migration refers to replatforming, rearchitecting, or refactoring workloads to maximize cloud value. Modernization can deliver long-term benefits but introduces complexity and risk to migration timelines. You must evaluate whether to modernize during migration or defer modernization to post-migration phases based on clear business justification. Follow these recommendations:

1. **Modernize when your team has the required skills and time.** Attempting modernization without adequate expertise or time increases risk and delays. If your team lacks readiness, defer modernization to a later phase.

2. **Modernize workloads that require compatibility updates.** Legacy technologies, unsupported SDKs, or the need to adopt SaaS solutions might require modernization. Justify each effort with a clear business case.

3. **Modernize when migration enables funding and alignment.** Migration projects often unlock funding and stakeholder support. Use this opportunity to align modernization with business priorities. Delaying might result in inefficient workloads and missed opportunities.

## Communicate decisions to stakeholders

Clear communication ensures all stakeholders understand and support migration decisions throughout the adoption process. Stakeholder alignment reduces execution risk and improves project outcomes by establishing shared understanding of priorities and constraints. You must establish a structured communication plan to maintain alignment throughout the migration process. Follow these recommendations:

1. **Define success metrics that validate the business outcome.** Success metrics quantify the value of the chosen action and confirm whether the business driver is achieved. This step ensures that decisions are based on business impact rather than technical completion. Use metrics such as:

    | Cloud migration strategy | Example success metrics |
    |--------------------------|------------------------------|
    | [Retire](#1-retire-decommission) | • Retire 100% of workloads identified as obsolete before migration |
    | [Rehost](#2-rehost-like-for-like-migration) | • Migrate 100% of Tier 1 workloads from other cloud to Azure with no service-level agreement (SLA) degradation<br>• Decommission 30% of on-premises infrastructure post-migration. |
    | [Replatform](#3-replatform-modernize-hosting-environment) | • Reduce deployment lead times by 30% for migrated applications<br>• Reduce infrastructure and licensing costs by 25% within 12 months |
    | [Refactor](#4-refactor-modernize-code) | • Improve application response time by 40% using Azure-native services<br>• Achieve 95% observability coverage through code instrumentation |
    | [Rearchitect](#5-rearchitect-modernize-architecture-and-code) | • Support 2x user load with no performance degradation<br>• Integrate three new Azure-native services into existing architecture |
    | [Replace](#6-replace-use-saas-alternative) | • Transition CRM to SaaS with 99.9% uptime and no custom code<br>• Shift 30% of dev effort to competitive differentiators.   |
    | [Rebuild](#7-rebuild-build-cloud-native) | • Launch new cloud-native application in three months vs. six months on-premises<br>• Cut operational costs by 40% using PaaS services |
    | [Retain](#8-retain-keep-as-is) | • Maintain current SLA and compliance posture<br>• Manage on-premises workloads from Azure using Azure Arc |

2. **Document and share workload treatment decisions with all relevant stakeholders.** Migration decisions can affect multiple organizational functions and require broad stakeholder input. Include business owners, legal teams, security teams, and technical leads in decision communication. Explain how each migration strategy decision supports documented business goals and addresses stakeholder concerns.

3. **Coordinate migration plans with the cloud strategy team.** The cloud strategy team provides organizational context and ensures migration decisions align with broader cloud adoption objectives. Regular coordination prevents conflicts between individual workload decisions and enterprise-wide cloud strategy. Review migration strategy selections against the cloud adoption plan established during the Strategy phase to maintain consistency.

4. **Establish regular communication between mandate owners and execution teams.** Ongoing communication between decision makers and implementers ensures plans remain viable as technical realities emerge. Schedule regular progress reviews to track migration progress, identify risks, and address technical issues. Use this feedback loop to adjust migration strategies when implementation challenges or new opportunities arise.

5. **Review and update migration strategies based on evolving requirements.** Business priorities and technical insights change throughout the migration process, requiring strategy adjustments. Establish a regular review cycle to reassess workload treatment decisions against current business goals and technical capabilities. Update strategy mappings to reflect new priorities, lessons learned, and changing organizational needs.

## Next steps

> [!div class="nextstepaction"]
> [Assess your workload](./assess-workloads-for-cloud-migration.md)
