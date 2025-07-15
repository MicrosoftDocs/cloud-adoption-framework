---
title: 
description: 
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Plan migration execution

This article provides guidance on creating a detailed migration execution plan that defines the specific order, timing, and approach for migrating workloads to Azure. A migration execution plan builds upon the foundational cloud adoption plan by translating high-level migration strategies into actionable deployment sequences. While the cloud adoption plan focuses on selecting migration strategies (the 5 Rs of migration), assessing workload readiness, and estimating migration costs, the execution plan addresses the tactical decisions of which workloads to migrate first, how to sequence migrations, and what methods to use for data transfer.

A structured migration execution plan reduces risk, minimizes business disruption, and accelerates cloud adoption success. Organizations use this plan to coordinate technical teams, manage dependencies, and ensure business continuity throughout the migration process. The execution plan serves as the operational blueprint that transforms migration strategy into reality.

## Assess migration readiness and skills

1. **Evaluate internal skills and experience.** Assess your team’s familiarity with Azure services, tools, and migration patterns. Identify gaps that could delay progress. See [Migration skills](./migration-skills.md).

2. **Consider hiring external expertise.** Migration complexity varies based on your environment and experience. Expert support can reduce risk and accelerate progress. Evaluate internal skills and experience with Azure and cloud migrations. If gaps exist, engage [Microsoft or a Microsoft partner](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/#Nextsteps) early. Use their expertise to validate your migration strategy, tools, and timelines.

## Determine online or offline migration per workload

A migration execution strategy defines how each workload transitions to Azure with minimal disruption. A workload’s tolerance for downtime determines the most appropriate migration execution. This classification ensures that each workload is migrated with the right balance of risk, complexity, and business continuity. You must assess each workload to determine whether it supports offline migration, requires online migration.This decision is critical to ensure business continuity and reduce risk during cloud adoption. You must evaluate each workload’s tolerance for downtime to select the appropriate migration approach.

1. **Verify workload inventory and business criticality from CAF Plan.** Ensure that the workload inventory and business criticality classification created during the CAF Plan phase are accurate and up-to-date. This verification ensures alignment with migration priorities and avoids disruptions to essential services. For more information, see [CAF Plan: Discover existing workload inventory](/azure/cloud-adoption-framework/plan/discover-existing-workload-inventory).

### Identify workloads that can tolerate downtime

A workload that can tolerate downtime is suitable for offline migration. It's the recommended approach if possible. It reduces complexity and risk by allowing you to stop the source system before transferring data, so there's no loss of data. You must use this approach for non-critical systems or those with scheduled maintenance windows. 2. **Confirm maintenance windows or acceptable downtime periods from your cloud adoption plan.** Reference the maintenance windows and downtime tolerance documented in your cloud adoption plan. This information ensures that offline migration aligns with established business expectations and service-level agreements (SLAs). If this information was not captured during planning, work with stakeholders to define acceptable downtime periods before proceeding with migration.

### Identify workloads that require near-zero downtime

A workload that requires near-zero downtime must use online migration. This classification maintains availability during the transition and is essential for mission-critical systems. You must use continuous replication to minimize downtime during cutover.

1. **Identify mission-critical workloads with strict availability requirements.** Review SLAs, business continuity plans, and stakeholder input to determine which workloads must remain online during migration.

2. **Assess the feasibility of online migration.** Evaluate the workload’s architecture, data volume, and dependencies to confirm that online migration is technically viable. This assessment helps avoid unexpected failures during replication or cutover.

## Determine the data migration path for each workload

A data migration path defines how data moves from your current environment to Azure. Selecting the right path ensures secure, timely, and cost-effective data transfer. Identify whether ExpressRoute, VPN, or public internet is available and configured. This assessment determines which migration paths are technically feasible and secure.

| Data Migration Path | When to Use | Pros | Cons |
|----------------------|-------------|------|------|
| ExpressRoute | If ExpressRoute is available | Secure and fast | Requires setup and cost |
| VPN | If secure transfer is required and ExpressRoute is not available | More secure than public internet | Requires VPN setup |
| Public internet | If no secure path is needed and data is not viable for Data Box | Universally available | Least secure, uses internet bandwidth |
| Azure Data Box | For large, non-critical data | Offline bulk transfer | Slowest method |

1. **Use ExpressRoute if available.** Use ExpressRoute if it is already provisioned or planned for your environment. ExpressRoute provides private, dedicated connectivity to Azure, which improves performance and security. This method is ideal for all workloads but requires setup and incurs additional cost for data transfer.

2. **Use VPN when ExpressRoute is unavailable.** Select VPN when you need encrypted data transfer over the internet but do not have ExpressRoute. VPN provides a secure tunnel to Azure but may have lower throughput and higher latency compared to ExpressRoute. Ensure VPN Gateway is configured in your Azure environment.

3. **Use public internet for non-sensitive data.** Choose this method when encryption is not required, ExpressRoute is unavailable, and the data is not suitable for offline transfer. This method is universally available but less secure and may impact bandwidth for other operations.

4. **Use Azure Data Box for large, non-critical offline transfers.** Select Azure Data Box when transferring large volumes of data that are not time-sensitive or business-critical. This method avoids network congestion but is the slowest due to shipping and manual handling. Order and configure the Data Box from the Azure portal.

## Determine the migration sequence

A planned migration sequence reduces migration risk, builds team confidence, and ensures a smooth transition. Start with simpler, non-critical workloads like dev/test environments before tackling more complex or critical systems. If you have many workloads, create a [migration wave plan](./migration-wave-plan.md).

1. **Create a migration wave plan for large portfolios.** If you manage many workloads, organize them into migration waves. Each wave should include a manageable set of workloads with similar risk profiles or dependencies. This approach enables iterative learning, reduces complexity, and allows for continuous improvement across waves. For more information, see [Migration wave planning](./migration-wave-plan.md).

2. **Start with non-critical system.** Start with simpler, non-critical workloads such as internal systems or dev/test environments, before tackling more complex or critical systems such as customer facing applications. These workloads are less risky and provide a safe environment to test migration tools, validate assumptions, and refine processes. Use this phase to uncover issues early and build team confidence before migrating critical systems.

3. **Group and migrate dependent workloads together.** Migrating dependent systems together prevents broken integrations and service disruptions. Use dependency mapping tools to discover integration points and shared services. Group these systems into migration waves. See [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies).

    - **Limit hybrid or cross-cloud scenarios to short durations.** If you cannot migrate all dependencies together, document the gaps and plan for mitigation. Understand how to manage hybrid or multi-cloud. Hybrid environments increase complexity and risk. If unavoidable, define a clear timeline to complete the transition. Assign dedicated teams to manage both on-premises and cloud environments. This ensures continuity and reduces operational risk. Use Azure Monitor and other tools to maintain visibility and responsiveness across boundaries. Validate that systems can recover from failures during the transition. This reduces downtime and data loss. Apply caching, replication, or temporary APIs to bridge systems until full migration is complete.

4. **Define timelines.** Migration timelines provide structure and accountability for the cloud adoption process. Clear timelines ensure that teams understand delivery expectations and can plan resources accordingly. You should establish specific dates for each migration wave and align these timelines with business calendars to minimize disruption. Create timelines that include concrete milestones such as "CRM system live on Azure by June" or "Datacenter A shutdown by Q4." Avoid scheduling migrations during peak business periods such as holidays for retail applications or month-end processing for financial systems. Document task dependencies and monitor them throughout the migration process. When one timeline extends, update dependent tasks and communicate changes to stakeholders immediately. Use project management tools to track progress and identify potential delays before they impact business operations.

5. **Migrate non-production environments before production.** Always migrate staging, QA, and other non-production environments before production workloads. This step allows you to validate the end-to-end migration process, test application behavior in Azure, and confirm that performance and integrations meet expectations.

## Define rollback criteria and procedures

A rollback strategy is a documented plan that enables teams to revert infrastructure or application changes when deployment fails or introduces risk. A clear rollback strategy reduces downtime, limits business disruption, and supports operational resilience. You should define rollback criteria and procedures before any migration or deployment activity.

1. **Establish rollback criteria.** Rollback criteria are the specific conditions under which a rollback must be triggered. These include failed health checks, performance degradation, security violations, or unmet success metrics. Defining these criteria ensures teams act decisively when issues arise. You should collaborate with business stakeholders, workload owners, and operations teams to define thresholds for failure and document them in your deployment plan.

2. **Document rollback procedures.** Rollback procedures are the step-by-step instructions to revert a change. These vary depending on the workload, environment, and deployment method. Documenting rollback steps ensures consistency and reduces human error during high-pressure situations. You should include rollback scripts, configuration snapshots, and infrastructure-as-code templates in your documentation.

3. **Test rollback procedures in a pre-production environment.** Testing validates that rollback steps work as expected and do not introduce new issues. This step is critical for identifying gaps in automation, permissions, or dependencies. You should simulate failure scenarios in a staging environment and verify that rollback restores the system to a known-good state.

4. **Automate rollback where possible using deployment tools.** Automation reduces manual effort and speeds up recovery. Tools like Azure DevOps, GitHub Actions, or Bicep templates can automate rollback of infrastructure and application deployments. You should integrate rollback logic into your CI/CD pipelines and use deployment slots or blue-green deployments to simplify reversions.

5. **Include rollback plans in change management and release documentation.** Visibility into rollback plans ensures all stakeholders understand the recovery path. This is especially important for regulated environments or mission-critical systems. You should attach rollback documentation to change requests, release notes, and operational runbooks.

6. **Review and update rollback strategies after each deployment.** Continuous improvement ensures rollback strategies remain effective as systems evolve. You should conduct post-incident reviews and update rollback documentation based on lessons learned.

## Define stakeholder communication plans

Stakeholder communication plans establish clear channels, responsibilities, and timelines for information sharing throughout the cloud migration process. These plans reduce project risk by ensuring all stakeholders remain informed about progress, changes, and decisions. You should create structured communication protocols that align with your migration timeline and stakeholder needs.

1. **Map stakeholders by role and communication needs.** Create a comprehensive stakeholder inventory that categorizes participants by their responsibilities and information requirements. Include business leaders, workload owners, application teams, infrastructure teams, security teams, and end users. This mapping ensures tailored communication that addresses specific concerns and decision-making authority. Use Microsoft Teams channels or Azure DevOps work items to document stakeholder roles and contact information.

2. **Assign communication ownership and accountability.** Designate specific team members as communication leads for each stakeholder group. This assignment ensures consistent messaging and prevents communication gaps. Document these responsibilities in your project plan and include backup contacts for continuity. Communication leads should understand both technical details and business implications to effectively translate information for their assigned stakeholders.

3. **Establish formal communication channels and tools.** Use structured platforms that support your organizational communication preferences. Microsoft Teams provides real-time collaboration for technical discussions, Outlook enables formal status updates and approvals, and Power BI dashboards offer ongoing visibility into migration progress. Azure DevOps can track work items and decisions that require stakeholder input. This multi-channel approach ensures information reaches stakeholders through their preferred methods.

4. **Create recurring communication touchpoints with clear agendas.** Schedule regular meetings, status reports, and milestone reviews that align with your migration timeline. Include weekly status updates for project teams, bi-weekly executive briefings, and monthly stakeholder reviews. Document these touchpoints in project calendars and include specific agendas to maintain focus and efficiency. Regular communication builds trust and enables proactive issue resolution.

5. **Engage business stakeholders in migration planning and scheduling.** Include business units in migration timeline discussions to identify operational constraints and preferences. Gather input on maintenance windows, business-critical periods, change freezes, and seasonal considerations. This collaboration ensures migration activities align with business operations and minimize disruption. Document these constraints in your migration schedule and validate changes with business stakeholders.

6. **Document and validate migration schedules collaboratively.** Use shared project management tools like Azure DevOps or Microsoft Project to create transparent migration timelines. Review schedules with both technical and business stakeholders to confirm feasibility and business readiness. Include dependencies, resource requirements, and contingency plans in your documentation. This collaborative approach ensures realistic timelines and shared accountability.

7. **Share risk assessments and mitigation strategies proactively.** Identify potential migration risks including service disruptions, data integrity concerns, and user impact scenarios. Communicate these risks along with specific mitigation plans to relevant stakeholders. Use risk registers and incident response procedures to support these discussions. Proactive risk communication enables faster decision-making and builds stakeholder confidence in the migration approach.

8. **Monitor communication effectiveness and adjust based on feedback.** Regularly assess whether stakeholders receive the information they need in an accessible format. Use surveys, meeting feedback, or direct conversations to identify communication gaps or preferences. Adjust your communication frequency, format, or channels based on stakeholder input. This continuous improvement approach ensures communication remains effective throughout the migration process.