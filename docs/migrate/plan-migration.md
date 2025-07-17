---
title: Plan your migration
description: Learn how to create migration plans that define workload sequencing, data transfer paths, and rollback strategies for successful Azure cloud migrations.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan your migration

A migration execution plan defines the specific order, timing, and approach for migrating workloads to Azure. This plan translates high-level migration strategies into actionable deployment sequences. Migration execution planning occurs in the CAF Migrate methodology rather than CAF Plan because several critical factors emerge only after you have built and operated your Azure landing zone:

| Factor | Description |
|--------|-------------|
| **Operational readiness validation** | Working with your deployed landing zone reveals actual team capabilities, operational processes, and support requirements that influence migration complexity and timing. |
| **Technical constraints discovery** | Network bandwidth, connectivity patterns, and Azure service performance become clear through operational experience, affecting data migration path selections and transfer timelines. |
| **Changing business priorities** | The time between initial planning and migration execution often brings new business requirements, regulatory changes, or shifting organizational priorities that require updated migration sequencing. |
| **Resource availability confirmation** | Actual Azure resource provisioning, cost patterns, and operational overhead become visible through landing zone operations, enabling more accurate migration resource planning and scheduling. |
| **Risk tolerance refinement** | Experience with Azure operations and incident management provides clearer understanding of acceptable downtime windows and rollback requirements for different workload types. |

It builds on the cloud adoption plan by addressing tactical decisions such as workload prioritization, migration sequencing, and data transfer methods.

## Assess migration readiness and skills

A readiness assessment ensures that your team has the skills and support needed to execute the migration plan. This step identifies capability gaps and accelerates progress through targeted training or external support.

1. **Evaluate internal skills and experience.** Review your team’s familiarity with Azure services, migration tools, and workload patterns. This evaluation identifies potential blockers and training needs. Use the [Migration skills](./migration-skills.md) to identify critical skills.

2. **Engage external expertise if needed.** If internal capabilities are limited, bring in [Microsoft or a Microsoft partner](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/#Nextsteps). External experts can validate your strategy, tools, and timelines. This support accelerates progress and reduces risk, especially for complex or large-scale migrations.

## Determine the data migration path

A data migration path defines how data moves from your current environment to Azure. Selecting the right path ensures secure, timely, and cost-effective data transfer. Identify whether ExpressRoute, VPN, or public internet is available and configured. This assessment determines which migration paths are technically feasible and secure.

1. **Use ExpressRoute for all workloads if available.** Use ExpressRoute if it is already provisioned or planned for your environment. ExpressRoute provides private, dedicated connectivity to Azure, which improves performance and security. This method is ideal for all workloads but requires setup and incurs additional cost for data transfer.

2. **Use VPN when ExpressRoute is unavailable.** Select VPN when you need encrypted data transfer over the internet but do not have ExpressRoute. VPN provides a secure tunnel to Azure but may have lower throughput and higher latency compared to ExpressRoute. Ensure VPN Gateway is configured in your Azure environment.

3. **Use public internet for non-sensitive data.** Choose this method when encryption is not required, ExpressRoute is unavailable, and the data is not suitable for offline transfer. This method is universally available but less secure and may impact bandwidth for other operations.

4. **Use Azure Data Box for large, non-critical offline transfers.** Select Azure Data Box when transferring large volumes of data that are not time-sensitive or business-critical. This method avoids network congestion but is the slowest due to shipping and manual handling. Order and configure the Data Box from the Azure portal.

| Data Migration Path | When to Use | Pros | Cons |
|----------------------|-------------|------|------|
| ExpressRoute | If ExpressRoute is available | Secure and fast | Requires setup and cost |
| VPN | If secure transfer is required and ExpressRoute is not available | More secure than public internet | Requires VPN setup |
| Public internet | If no secure path is needed and data is not viable for Data Box | Universally available | Least secure, uses internet bandwidth |
| Azure Data Box | For large, non-critical data | Offline bulk transfer | Slowest method |

## Determine the migration sequence

Migration sequencing reduces risk and builds team confidence by establishing a logical order for workload migration. The sequence determines which workloads move first and how dependent systems migrate together to prevent service disruptions.

### Validate workload criticality classifications before sequencing**

Workload criticality determines the business impact of downtime or failure. Accurate classification ensures that migration priorities align with business needs. You should validate criticality classifications with stakeholders before finalizing the migration sequence.

1. **Review workload metadata in the migration adoption plan.** Ensure metadata includes business unit, workload owner, technical dependencies, and current criticality classification. This information provides the foundation for prioritization and sequencing decisions.

2. **Engage business stakeholders to confirm classifications.** Collaborate with workload owners and business leaders to validate that criticality levels accurately reflect current operational priorities. This step prevents misalignment between technical execution and business expectations.

3. **Update classifications based on current business impact.** Revise workload classifications to reflect their true criticality if their role has changed. This ensures that critical systems are prioritized appropriately and not delayed due to outdated assumptions. For more information, see [Migration adoption plan](/azure/cloud-adoption-framework/plan/migration-adoption-plan#details-on-each-workload).

### Organize large portfolios into migration waves

A migration wave is a logical grouping of workloads that share similar complexity, risk, or dependency characteristics. This grouping enables teams to manage scope, reduce risk, and apply lessons learned across iterations. You should define migration waves to create manageable and repeatable units of work.

1. **Segment the migration portfolio into logical waves.** A migration wave should include workloads with similar technical profiles, business impact, or dependency structures. This segmentation allows teams to focus on a consistent set of challenges and apply targeted solutions. Use metadata such as workload type, owner, and environment to group workloads effectively.

2. **Limit the number of workloads per wave.** Each wave should be small enough to execute within a defined timeline but large enough to deliver meaningful progress. Smaller waves reduce risk and allow for faster feedback cycles. Larger waves may increase efficiency but require more coordination and resources.

3. **Sequence waves based on complexity and risk.** Start with low-complexity, low-risk workloads to build confidence and refine processes. Progressively increase complexity in later waves as the team gains experience and tooling matures.

For detailed guidance on wave planning, see [Migration wave planning](./migration-wave-plan.md).

### Group dependent workloads into the same migration wave

Dependencies between workloads can cause service disruptions if not migrated together. You should group interdependent systems into the same wave to maintain functionality and reduce complexity.

1. **Use dependency mapping tools to identify integrations.** Tools like Azure Migrate can reveal shared databases, APIs, and service calls. This visibility is essential for accurate grouping and ensures that interdependent workloads are migrated together.

2. **Create migration waves based on dependency clusters.** Group workloads that rely on each other into the same wave. This approach minimizes the need for temporary integration workarounds and reduces the risk of service disruptions during migration.

3. **Validate groupings with application owners.** Confirm that all critical dependencies are captured and that the proposed wave structure supports business continuity. Collaborate with application owners to ensure alignment with operational priorities and technical requirements.

For detailed guidance, see [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies).

### Minimize hybrid environment duration for dependent workloads

Hybrid environments introduce complexity and risk. When full migration of dependent systems is not possible, you should minimize the duration of hybrid states and implement mitigation strategies.

1. **Document integration gaps and risks.** Identify which systems remain on-premises and how they interact with cloud-based workloads. This documentation supports risk mitigation planning by providing visibility into potential challenges and dependencies.

2. **Implement temporary bridging solutions.** Use API gateways, database replication, or message queues to maintain functionality during the hybrid state. These solutions should be lightweight, easy to deploy, and simple to decommission once the migration is complete.

3. **Define clear timelines for full migration.** Assign owners and deadlines to complete the migration of remaining dependencies. This accountability ensures that hybrid states do not become permanent and supports progress toward full cloud adoption.

### Establish specific migration timelines with business alignment

Timelines provide structure and accountability. Aligning migration schedules with business calendars avoids disruption during peak periods. You should define and communicate migration timelines that reflect business priorities.

1. **Create a detailed migration schedule.** Define start and end dates for each migration wave and workload. Incorporate buffer time for testing and issue resolution to ensure smooth execution. This detailed scheduling reduces the risk of delays and supports effective resource planning.

2. **Align timelines with business events.** Avoid scheduling migrations during critical business periods such as financial close, product launches, or holiday seasons. This alignment minimizes the risk of business disruption and ensures stakeholder confidence.

3. **Use project management tools to track progress.** Leverage tools like Azure DevOps or Microsoft Project to manage dependencies, track milestones, and communicate changes effectively. These tools provide visibility into migration progress and support proactive issue resolution.

### Migrate non-production environments first for each workload

Non-production environments provide a safe space to test the full migration process. You should migrate development, staging, and QA environments before production to validate readiness.

1. **Sequence non-production environments ahead of production.** This order allows teams to test configurations, performance, and recovery procedures without impacting users.

2. **Use non-production migrations to train operations teams.** These migrations provide hands-on experience with Azure tools and management practices.

3. **Validate performance and functionality in Azure.** Confirm that applications behave as expected and meet performance targets before migrating production systems.

## Determine offline or near-zero downtime migration

A migration strategy must align with each workload’s tolerance for downtime. Offline migration is simpler and preferred when downtime is acceptable. Near-zero downtime migration is necessary for mission-critical workloads that must remain operational during the transition. You should evaluate each workload in your migration wave to determine the most suitable migration method.

1. **Assess workload downtime tolerance.** Downtime tolerance varies by workload and must be defined by business impact.
This assessment ensures migration timing aligns with operational and regulatory needs. Review SLAs, recovery time objectives (RTOs), and business continuity plans. Engage business stakeholders to define acceptable downtime windows. Consider customer-facing services, revenue-generating systems, and compliance obligations.

2. **Identify workloads suitable for offline migration.** Evaluate workloads that can accommodate planned downtime during migration. These typically include development environments, test systems, internal applications, and workloads with scheduled maintenance windows. Offline migration reduces complexity by eliminating the need for real-time data synchronization and provides a cleaner cutover process. Document the acceptable downtime duration for each workload and align migration schedules with business calendars to avoid peak periods such as month-end processing or seasonal demand.

3. **Classify workloads requiring near-zero downtime migration.** Identify workloads that must remain operational during migration to meet business continuity requirements. These include customer-facing applications, real-time transaction systems, and services covered by strict SLAs. Use business impact analysis to determine which systems fall into this category. Validate that the workload architecture supports continuous replication and that network bandwidth can handle real-time data transfer requirements. Consider implementing blue-green deployment strategies or using Azure Site Recovery for these critical systems.

4. **Validate technical requirements for online migration.** Ensure that workloads requiring near-zero downtime have the necessary technical capabilities for online migration. This includes support for database replication, application-level failover, and network connectivity that can sustain continuous data synchronization. Assess data volume, change rate, and interdependencies to confirm that online migration is technically feasible. Test connectivity between source and target environments to verify sufficient bandwidth and low latency for real-time replication.

5. **Plan migration windows for offline workloads.** Schedule offline migrations during approved maintenance windows or low-usage periods to minimize business impact. Coordinate with operations teams to ensure that migration activities do not conflict with other system maintenance or business-critical processes. Create detailed migration schedules that include preparation time, data transfer duration, testing phases, and contingency buffers. Communicate these schedules to all stakeholders and establish approval processes for any changes to migration timing.

## Define rollback plan

A rollback strategy is a documented plan that enables teams to revert infrastructure or application changes when deployment fails or introduces risk. A clear rollback strategy reduces downtime, limits business disruption, and supports operational resilience. You should define rollback criteria and procedures before any migration or deployment activity.

### Establish rollback criteria

1. **Define failure thresholds with stakeholders.** Work with business stakeholders, workload owners, and operations teams to establish what constitutes a failed deployment. Common thresholds include failed health checks, performance degradation, security violations, or unmet success metrics. This collaboration ensures rollback decisions match your organization's risk tolerance.

2. **Document rollback triggers in the deployment plan.** Record the rollback criteria in your deployment plan to provide visibility and accountability. Include measurable indicators such as CPU thresholds, response time limits, or error rates. This documentation supports consistent decision-making during incidents.

3. **Integrate rollback logic into CI/CD pipelines.** Use tools like [Azure Pipelines](/azure/devops/pipelines/process/stages) or [GitHub Actions](https://docs.github.com/actions/deployment/targeting-different-environments/using-environments-for-deployment) to automate rollback steps. For example, configure pipelines to redeploy a previous build if a deployment fails health checks.

### Document rollback procedures

1. **Create workload-specific rollback instructions.** Develop rollback steps that match your workload type, environment, and deployment method. For example, infrastructure-as-code deployments require reapplying previous templates, while application rollbacks involve redeploying a prior container image.

2. **Include rollback assets in documentation.** Attach rollback scripts, configuration snapshots, and infrastructure-as-code templates to your rollback plan. These assets enable rapid execution and reduce dependence on manual intervention.

### Test rollback procedures in a pre-production environment

1. **Simulate failure scenarios in staging.** Use a pre-production environment to simulate deployment failures and validate rollback effectiveness. This testing helps identify gaps in automation, permissions, or dependencies.

2. **Verify system recovery to a known-good state.** Confirm that rollback restores the system to a stable and functional configuration. This verification builds confidence in your rollback plan and supports operational readiness.

### Review and update rollback strategies after each deployment

1. **Conduct post-incident reviews.** After each deployment or rollback event, assess what worked and what didn't. Identify gaps in criteria, procedures, or automation.

2. **Update rollback documentation based on lessons learned.** Revise rollback plans to reflect new insights, changes in architecture, or updated tooling. This practice keeps rollback strategies current and effective.

## Engage stakeholders on migration execution plan

Stakeholder approval validates your migration execution plan and ensures business alignment for the first wave of workloads. This approval process confirms that your proposed migration approaches, timelines, and rollback procedures meet business requirements and risk tolerance. You should present a comprehensive execution plan that demonstrates readiness and builds stakeholder confidence.

1. **Present the first wave workload migration plan with clear business justification.** Document each workload in the first wave with its business criticality, migration approach (offline or near-zero downtime), and rationale for the chosen method. Include the business impact of each workload's downtime and how your migration approach minimizes risk. Use a structured format that shows workload name, owner, migration type, scheduled downtime window, and business justification. This presentation helps stakeholders understand the careful planning behind each decision.

2. **Demonstrate rollback procedures for each workload in the first wave.** Present specific rollback plans for each workload that detail the steps, timeframes, and success criteria for reverting changes. Include automated rollback capabilities where available and manual procedures where required. Show how rollback procedures were tested in pre-production environments and document the results. This demonstration proves that you can restore services quickly if migration issues occur.

3. **Validate migration schedules against business calendar constraints.** Review your proposed migration timeline with business stakeholders to confirm it avoids critical business periods, maintenance freezes, and seasonal peaks. Present alternative scheduling options if conflicts exist and explain the trade-offs of each approach. Include specific dates, duration estimates, and dependencies between workloads. This validation ensures migration activities align with business operations and minimizes disruption.

4. **Secure formal approval for migration execution and rollback authority.** Obtain written approval from business stakeholders for the migration execution plan, including authorization to execute rollback procedures if needed. Define decision-making authority for rollback scenarios and ensure key stakeholders understand their roles during potential recovery situations. Document approval signatures and communication channels for emergency decisions. This formal approval provides clear authority to proceed and establishes accountability.

5. **Establish success criteria and checkpoints for the first wave.** Define measurable success metrics for each workload migration and establish go/no-go checkpoints throughout the process. Include performance benchmarks, functionality validation steps, and user acceptance criteria. Schedule formal review points where stakeholders can assess progress and make continuation decisions. These criteria provide objective measures for migration success and enable data-driven decisions about proceeding to subsequent waves.