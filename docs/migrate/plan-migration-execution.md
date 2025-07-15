---
title: 
description: 
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan migration execution

A migration execution plan defines the specific order, timing, and approach for migrating workloads to Azure. This plan translates high-level migration strategies into actionable deployment sequences. It builds on the cloud adoption plan by addressing tactical decisions such as workload prioritization, migration sequencing, and data transfer methods.

## Assess migration readiness and skills

A readiness assessment ensures that your team has the skills and support needed to execute the migration plan. This step identifies capability gaps and accelerates progress through targeted training or external support.

1. **Evaluate internal skills and experience.** Review your team’s familiarity with Azure services, migration tools, and workload patterns. This evaluation identifies potential blockers and training needs. Use the [Migration skills](./migration-skills.md).

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

A planned migration sequence reduces migration risk, builds team confidence, and ensures a smooth transition. Start with simpler, non-critical workloads like dev/test environments before tackling more complex or critical systems. If you have many workloads, create a [migration wave plan](./migration-wave-plan.md).

1. **Create a migration wave plan for large portfolios.** If you manage many workloads, organize them into migration waves. Each wave should include a manageable set of workloads with similar risk profiles or dependencies. This approach enables iterative learning, reduces complexity, and allows for continuous improvement across waves. For more information, see [Migration wave planning](./migration-wave-plan.md).

2. **Verify workload criticality.** An accurate workload inventory and business criticality classification ensures that migration execution aligns with business priorities. Use the migration adoption plan to identify all workloads in scope for migration. This plan should include metadata such as workload owner, business unit, and technical dependencies. If the inventory is incomplete or outdated, update it before proceeding. Confirm that each workload’s criticality level reflects current business operations. Engage workload owners and business stakeholders to validate these classifications. This step ensures that migration execution aligns with service-level expectations. For more information, see [CAF Plan - Migration adoption plan](/azure/cloud-adoption-framework/plan/migration-adoption-plan#details-on-each-workload).

3. **Start with non-critical system.** Start with simpler, non-critical workloads such as internal systems or dev/test environments, before tackling more complex or critical systems such as customer facing applications. These workloads are less risky and provide a safe environment to test migration tools, validate assumptions, and refine processes. Use this phase to uncover issues early and build team confidence before migrating critical systems.

4. **Group and migrate dependent workloads together.** Migrating dependent systems together prevents broken integrations and service disruptions. Use dependency mapping tools to discover integration points and shared services. Group these systems into migration waves. See [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies).

5. **Limit hybrid or cross-cloud scenarios to short durations.** If you cannot migrate all dependencies together, document the gaps and plan for mitigation. Understand how to manage hybrid or multi-cloud. Hybrid environments increase complexity and risk. If unavoidable, define a clear timeline to complete the transition. Assign dedicated teams to manage both on-premises and cloud environments. This ensures continuity and reduces operational risk. Use Azure Monitor and other tools to maintain visibility and responsiveness across boundaries. Validate that systems can recover from failures during the transition. This reduces downtime and data loss. Apply caching, replication, or temporary APIs to bridge systems until full migration is complete.

6. **Define timelines.** Migration timelines provide structure and accountability for the cloud adoption process. Clear timelines ensure that teams understand delivery expectations and can plan resources accordingly. You should establish specific dates for each migration wave and align these timelines with business calendars to minimize disruption. Create timelines that include concrete milestones such as "CRM system live on Azure by June" or "Datacenter A shutdown by Q4." Avoid scheduling migrations during peak business periods such as holidays for retail applications or month-end processing for financial systems. Document task dependencies and monitor them throughout the migration process. When one timeline extends, update dependent tasks and communicate changes to stakeholders immediately. Use project management tools to track progress and identify potential delays before they impact business operations.

7. **Migrate non-production environments before production.** Always migrate staging, QA, and other non-production environments before production workloads. This step allows you to validate the end-to-end migration process, test application behavior in Azure, and confirm that performance and integrations meet expectations.

## Determine offline or near-zero downtime migration

A workload's downtime tolerance determines the appropriate migration strategy. Workloads with flexible downtime requirements can use offline migration, which the preferred method. Offline migration simplifies the process and reduces risk of data lost. Mission-critical workloads that require continuous availability need online migration strategies that maintain operations during the transition. However, online migrations often require temporary downtime depending on the tools used and technology stack of the workload.

1. **Assess workload downtime tolerance through business requirements.** Review service level agreements (SLAs), recovery time objectives (RTOs), and business continuity plans to determine acceptable downtime periods. Work with business stakeholders to define specific downtime windows based on operational impact and customer commitments. This assessment ensures that migration timing aligns with business needs and regulatory requirements. Consider factors such as customer-facing services, revenue-generating systems, and compliance obligations when evaluating downtime tolerance.

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