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

A workload that can tolerate downtime is a candidate for offline migration. Offline migration reduces complexity and risk by allowing data transfer while the source system is offline. A workload that requires near-zero downtime must use online migration. Online migration maintains availability during the transition and is essential for mission-critical systems.

1. **Identify workloads for offline migration.** Review the cloud adoption plan for documented maintenance windows or downtime tolerances. If this information is missing, work with stakeholders to define acceptable downtime periods. This step ensures that offline migration aligns with business expectations. Identify workloads with predictable usage cycles or scheduled maintenance windows. These workloads are ideal candidates for offline migration because downtime can be scheduled during low-impact periods.

2. **Identify workloads that require near-zero downtime.** Use SLAs, business continuity plans, and stakeholder input to identify workloads that must remain online during migration. These workloads typically support customer-facing services or core business operations. Evaluate the workload’s architecture, data volume, and interdependencies. Ensure that the workload supports continuous replication and that the network bandwidth is sufficient for real-time data transfer.

## Define rollback criteria and procedures

A rollback strategy is a documented plan that enables teams to revert infrastructure or application changes when deployment fails or introduces risk. A clear rollback strategy reduces downtime, limits business disruption, and supports operational resilience. You should define rollback criteria and procedures before any migration or deployment activity.

1. **Establish rollback criteria.** Rollback criteria are the specific conditions under which a rollback must be triggered. These include failed health checks, performance degradation, security violations, or unmet success metrics. Defining these criteria ensures teams act decisively when issues arise. You should collaborate with business stakeholders, workload owners, and operations teams to define thresholds for failure and document them in your deployment plan.

2. **Document rollback procedures.** Rollback procedures are the step-by-step instructions to revert a change. These vary depending on the workload, environment, and deployment method. Documenting rollback steps ensures consistency and reduces human error during high-pressure situations. You should include rollback scripts, configuration snapshots, and infrastructure-as-code templates in your documentation.

3. **Test rollback procedures in a pre-production environment.** Testing validates that rollback steps work as expected and do not introduce new issues. This step is critical for identifying gaps in automation, permissions, or dependencies. You should simulate failure scenarios in a staging environment and verify that rollback restores the system to a known-good state.

4. **Automate rollback where possible using deployment tools.** Automation reduces manual effort and speeds up recovery. Tools like Azure DevOps, GitHub Actions, or Bicep templates can automate rollback of infrastructure and application deployments. You should integrate rollback logic into your CI/CD pipelines and use deployment slots or blue-green deployments to simplify reversions.

5. **Include rollback plans in change management and release documentation.** Visibility into rollback plans ensures all stakeholders understand the recovery path. This is especially important for regulated environments or mission-critical systems. You should attach rollback documentation to change requests, release notes, and operational runbooks.

6. **Review and update rollback strategies after each deployment.** Continuous improvement ensures rollback strategies remain effective as systems evolve. You should conduct post-incident reviews and update rollback documentation based on lessons learned.

## Engage stakeholders on migration execution plan

Stakeholder approval validates your migration execution plan and ensures business alignment for the first wave of workloads. This approval process confirms that your proposed migration approaches, timelines, and rollback procedures meet business requirements and risk tolerance. You should present a comprehensive execution plan that demonstrates readiness and builds stakeholder confidence.

1. **Present the first wave workload migration plan with clear business justification.** Document each workload in the first wave with its business criticality, migration approach (offline or near-zero downtime), and rationale for the chosen method. Include the business impact of each workload's downtime and how your migration approach minimizes risk. Use a structured format that shows workload name, owner, migration type, scheduled downtime window, and business justification. This presentation helps stakeholders understand the careful planning behind each decision.

2. **Demonstrate rollback procedures for each workload in the first wave.** Present specific rollback plans for each workload that detail the steps, timeframes, and success criteria for reverting changes. Include automated rollback capabilities where available and manual procedures where required. Show how rollback procedures were tested in pre-production environments and document the results. This demonstration proves that you can restore services quickly if migration issues occur.

3. **Validate migration schedules against business calendar constraints.** Review your proposed migration timeline with business stakeholders to confirm it avoids critical business periods, maintenance freezes, and seasonal peaks. Present alternative scheduling options if conflicts exist and explain the trade-offs of each approach. Include specific dates, duration estimates, and dependencies between workloads. This validation ensures migration activities align with business operations and minimizes disruption.

4. **Secure formal approval for migration execution and rollback authority.** Obtain written approval from business stakeholders for the migration execution plan, including authorization to execute rollback procedures if needed. Define decision-making authority for rollback scenarios and ensure key stakeholders understand their roles during potential recovery situations. Document approval signatures and communication channels for emergency decisions. This formal approval provides clear authority to proceed and establishes accountability.

5. **Establish success criteria and checkpoints for the first wave.** Define measurable success metrics for each workload migration and establish go/no-go checkpoints throughout the process. Include performance benchmarks, functionality validation steps, and user acceptance criteria. Schedule formal review points where stakeholders can assess progress and make continuation decisions. These criteria provide objective measures for migration success and enable data-driven decisions about proceeding to subsequent waves.