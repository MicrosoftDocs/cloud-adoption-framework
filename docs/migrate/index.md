---
title: Migrate overview
description: Prepare for a successful migration to Azure by using an iterative process to assess, deploy, and release workloads.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# CAF Migrate

This guidance provides a framework execute your migrations.

**Required:**

- Plan your migration ([discover inventory](/azure/cloud-adoption-framework/plan/discover-existing-workload-inventory), [select migration strategy per workload](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy), and assess workloads) and [document your cloud adoption plan](/azure/cloud-adoption-framework/plan/document-cloud-adoption-plan).
- Azure landing zone deployed with application subscriptions for this workload. A cloud adoption plan provides structure and clarity for migration efforts. It ensures that all stakeholders understand the scope, priorities, and expected outcomes. See [CAF Plan: Document your cloud adoption plan](/azure/cloud-adoption-framework/plan/document-cloud-adoption-plan).

## Assess migration readiness and skills

1. **Evaluate internal skills and experience.** Assess your team’s familiarity with Azure services, tools, and migration patterns. Identify gaps that could delay progress. See [Migration skills](./migration-skills.md).

2. **Consider hiring external expertise.** Migration complexity varies based on your environment and experience. Expert support can reduce risk and accelerate progress. Evaluate internal skills and experience with Azure and cloud migrations. If gaps exist, engage [Microsoft or a Microsoft partner](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/#Nextsteps) early. Use their expertise to validate your migration strategy, tools, and timelines.

## Determine online or offline migration per workload

A migration execution strategy defines how each workload transitions to Azure with minimal disruption. A workload’s tolerance for downtime determines the most appropriate migration execution. This classification ensures that each workload is migrated with the right balance of risk, complexity, and business continuity. You must assess each workload to determine whether it supports offline migration, requires online migration.This decision is critical to ensure business continuity and reduce risk during cloud adoption. You must evaluate each workload’s tolerance for downtime to select the appropriate migration approach.

1. **Verify workload inventory and business criticality from CAF Plan.** Ensure that the workload inventory and business criticality classification created during the CAF Plan phase are accurate and up-to-date. This verification ensures alignment with migration priorities and avoids disruptions to essential services. For more information, see [CAF Plan: Discover existing workload inventory](/azure/cloud-adoption-framework/plan/discover-existing-workload-inventory).

### Identify workloads that can tolerate downtime

A workload that can tolerate downtime is suitable for offline migration. It's the recommended approach if possible. It reduces complexity and risk by allowing you to stop the source system before transferring data, so there's no loss of data. You must use this approach for non-critical systems or those with scheduled maintenance windows.

2. **Confirm maintenance windows or acceptable downtime periods from your cloud adoption plan.** Reference the maintenance windows and downtime tolerance documented in your cloud adoption plan. This information ensures that offline migration aligns with established business expectations and service-level agreements (SLAs). If this information was not captured during planning, work with stakeholders to define acceptable downtime periods before proceeding with migration.

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

1. **Establish rollback criteria.** Rollback criteria are the specific conditions under which a rollback must be triggered. These include failed health checks, performance degradation, security violations, or unmet success metrics. Defining these criteria ensures teams act decisively when issues arise. You should collaborate with business stakeholders, worklaod owners, and operations teams to define thresholds for failure and document them in your deployment plan.

2. **Document rollback procedures.** Rollback procedures are the step-by-step instructions to revert a change. These vary depending on the workload, environment, and deployment method. Documenting rollback steps ensures consistency and reduces human error during high-pressure situations. You should include rollback scripts, configuration snapshots, and infrastructure-as-code templates in your documentation.

3. **Test rollback procedures in a pre-production environment.** Testing validates that rollback steps work as expected and do not introduce new issues. This step is critical for identifying gaps in automation, permissions, or dependencies. You should simulate failure scenarios in a staging environment and verify that rollback restores the system to a known-good state.

4. **Automate rollback where possible using deployment tools.** Automation reduces manual effort and speeds up recovery. Tools like Azure DevOps, GitHub Actions, or Bicep templates can automate rollback of infrastructure and application deployments. You should integrate rollback logic into your CI/CD pipelines and use deployment slots or blue-green deployments to simplify reversions.

5. **Include rollback plans in change management and release documentation.** Visibility into rollback plans ensures all stakeholders understand the recovery path. This is especially important for regulated environments or mission-critical systems. You should attach rollback documentation to change requests, release notes, and operational runbooks.

6. **Review and update rollback strategies after each deployment.** Continuous improvement ensures rollback strategies remain effective as systems evolve. You should conduct post-incident reviews and update rollback documentation based on lessons learned.

## Define stakeholder communication plans

A stakeholder communication plan ensures that all relevant parties stay informed and engaged throughout the cloud adoption process. This plan helps reduce risk, align expectations, and support collaborative decision-making. You should define how and when to communicate updates, risks, and decisions to stakeholders using structured and consistent channels.

1. **Identify and categorize all stakeholders.** Create a stakeholder map that includes business leaders, IT owners, application owners, support teams, and end users. Group them by their level of influence and interest. This step ensures that communication is tailored to each group’s needs and expectations. Use tools like Microsoft Teams, Azure DevOps, or Excel to document and maintain this list.

2. **Define communication objectives and responsibilities.** Clarify what each stakeholder group needs to know, when they need to know it, and who is responsible for delivering that information. This ensures accountability and consistency in messaging. Assign communication owners for each stakeholder group and document these roles in your communication plan.

3. **Establish structured communication channels.** Use formal channels such as Microsoft Teams for real-time collaboration, Outlook for formal updates, and Power BI dashboards for ongoing visibility. This structure ensures that stakeholders receive timely and relevant information in a format they can easily access and understand.

4. **Schedule regular communication touchpoints.** Set up recurring meetings, status reports, and milestone reviews aligned with the migration timeline. This cadence helps maintain transparency and builds trust. Include these touchpoints in your project plan and calendar invites to ensure participation.

5. **Include business stakeholders in migration decisions.** Engage business units early in planning to align migration schedules with operational needs. This collaboration ensures that cutover windows minimize disruption. You should gather input on blackout dates, change freezes, and business-critical periods for each application.

6. **Document and approve the migration schedule collaboratively.** Use a shared planning tool like Azure DevOps or Microsoft Project to draft the migration timeline. Review it with business and technical stakeholders to validate assumptions and constraints. This step ensures that the schedule reflects both technical feasibility and business readiness.

7. **Communicate risks and mitigation plans proactively.** Identify potential risks such as downtime, data loss, or user impact, and share mitigation strategies with stakeholders. This transparency builds confidence and enables faster decision-making. Use risk registers and incident response plans to support this communication.

8. **Track communication effectiveness and adjust as needed.** Collect feedback through surveys or direct input during meetings. Use this feedback to refine your communication approach. This continuous improvement loop ensures that communication remains relevant and effective throughout the project.

## Prepare workloads for the cloud

A workload must be cloud-ready before migration to Azure. Cloud readiness reduces cutover risk and ensures compatibility with Azure services. You should validate, secure, and automate workloads in Azure before production cutover.

### Create separate subscriptions for each environment

1. **Create a subscription for each environment.** Use distinct subscriptions for development, test, and production environments. This separation enables clearer cost management, policy enforcement, and access control. Use consistent naming conventions to improve visibility and simplify automation. For naming guidance, see [Naming convention](../ready/azure-best-practices/resource-naming.md)

1. **Apply environment-specific policies and budgets.** Use Azure Policy and Cost Management to enforce compliance and track spending. This helps prevent configuration drift and cost overruns.

1. **Assign access based on environment roles.** Use Azure role-based access control (RBAC) to restrict access to each subscription. Enable multifactor authentication (MFA) and configure conditional access policies through Microsoft Entra ID. Use Azure Bastion for secure administrative access to virtual machines. Over-permissioned roles increase the risk of misconfiguration or data exposure. This reduces the risk of accidental changes across environments.

### Deploy resources in a test environment

1. **Use the workload assessment and architecture plan from CAF Plan.** Reference the [workload assessment](../plan/assess-workloads-for-cloud-migration.md) and [planned Azure architecture](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) completed during the Plan phase. These artifacts provide the blueprint for creating the test environment. Validate that these documents are current and complete before deploying test resources.

1. **Deploy all workload components in the test environment.** Include compute resources (virtual machines, web apps, container hosting), databases, storage accounts, virtual networks, and DNS zones. Incomplete test environments delay validation and increase migration risk. Use your IaC templates or deployment scripts to ensure consistency between test and production environments.

1. **Configure security controls.** Apply (RBAC) to grant workload teams only the permissions required to the Azure resources for their responsibilities. Configure NSGs to limit traffic between subnets and resources. Use private endpoints for Azure services to avoid exposing them to the public internet. Enable managed identities for service-to-service authentication. For a comprehensive checklist, see [Security design](/azure/well-architected/security/checklist).

### Fix compatibility issues in Azure

You should resolve all compatibility issues in the test environment before production cutover. It's recommended to fix these issues in Azure to mirror your test environment as closely as possible with the Azure production environment.

    | Readiness issue                 | Fix                                                                 |
    |--------------------------------|----------------------------------------------------------------------|
    | Unsupported OS versions        | Upgrade to supported operating systems that allow replication.      |
    | Legacy NIC drivers and BIOS    | Update drivers and BIOS to ensure compatibility with Azure VMs.     |
    | Local file I/O                 | Replace with Azure Blob Storage or Azure Files.                     |
    | Hardcoded IP calls             | Use service discovery mechanisms such as Azure DNS or Private Link. |
    | Host-based antivirus dependency| Integrate with Microsoft Defender for Cloud.                        |
    | Hardcoded user accounts        | Replace with managed identities.                                    |

### Test workload in the Azure environment

1. **Validate network topology and identity integration.** Test that routing tables, firewall rules, and authentication mechanisms work correctly in Azure. Confirm that applications can communicate with dependencies and that users can authenticate as expected. This validation prevents connectivity issues during production cutover. Execute user acceptance testing, load testing, and integration testing to validate that the workload performs as expected. Document any issues or performance differences compared to the source environment. This testing phase confirms readiness for production migration.

## Create reusable infrastructure and automation assets

Reusable infrastructure and automation assets accelerate migration and improve consistency. These assets reduce manual effort, support repeatable deployments, and ensure that tested configurations are preserved. You should create infrastructure as code (IaC) assets only after the workload passes all tests in the test environment.

1. **Create IaC templates after validating workload behavior in the test environment.** Use the test environment to confirm that the workload functions correctly in Azure. This validation ensures that IaC templates reflect tested and production-ready configurations. Use Bicep or Terraform to define virtual machines, storage accounts, App Services, and other common resources. Bicep provides native integration with Azure Resource Manager, while Terraform supports multi-cloud scenarios and a broader ecosystem.

2. **Automate deployment of third-party tools and workload dependencies.** Include installation and configuration steps for databases, monitoring agents, backup solutions, or other required tools. Use scripts or deployment pipelines to automate these steps. Automation reduces deployment time, eliminates manual errors, and improves reliability across environments.

3. **Store all templates and scripts in version-controlled repositories.** Use GitHub or Azure DevOps to manage IaC assets. Version control enables peer reviews, supports collaboration, and encourages reuse across teams. It also provides traceability and rollback capabilities for infrastructure changes.

## Execute workload cutover

Migration execution requires a structured and validated approach to ensure workload continuity, data integrity, and minimal disruption. You must choose between offline and online migration strategies based on workload criticality and acceptable downtime.

### Provision production workload

Production resources must be ready to receive data before migration. You should provision, validate, and secure the production environment in advance.

1. **Deploy production infrastructure in Azure.** Use IaC templates to create production-ready resources. Include all dependencies and configurations validated in the test environment.

2. **Validate production readiness.** Confirm that all services, access controls, and network configurations match the test environment. This ensures a predictable cutover.

3. **Secure and monitor production resources.** Apply RBAC, NSGs, and Defender for Cloud policies. Enable monitoring and alerting to detect issues early.

## Optimize post-migration

After a successful cutover, immediate optimizations might be necessary. This phase overlaps with ongoing operations, but it’s essential to ensure your workloads are stable, performant, and cost-effective in Azure.

1. **Fine-tune configurations.** Azure offers flexibility to quickly adjust resources. Post-migration workloads might behave differently than they did on-premises or in other clouds. Use [Azure Advisor](/azure/advisor/advisor-overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/review-security-recommendations) to get tailored recommendations on cost optimization, performance, reliability, and security. Tweak configurations in accordance with [Azure services guides](/azure/well-architected/service-guides/?product=popular).

2. **Monitor costs.** Cost anomalies typically stem from either workload changes (enabling new features) or unexpected behavior in Azure. For example, autoscaling or inefficient SQL queries that were throttled on-premises might now consume more resources. Use [Azure Cost Management](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) to spot cost anomalies and Azure Advisor for relevant performance and reliability improvements. Compare current costs to your pre-migration baseline. Identify and address any configuration or feature changes that are driving up costs.

3. **Validate monitoring.** The first few days or weeks post-migration serve as a "bake-in" period. Ensure that performance, availability, and usage patterns align with expectations. Confirm that Azure Monitor is capturing the right metrics and alerts are configured appropriately. For more information, see [Monitor your Azure cloud estate.](/azure/cloud-adoption-framework/manage/monitor)

4. **Validate backups.** Ensure backup jobs are configured correctly and completing successfully. Test restore procedures to confirm data recoverability. For data reliability, see [Manage data reliability](/azure/cloud-adoption-framework/manage/protect#manage-data-reliability).

5. **Gather feedback from users.** Collect and document feedback from end users. Address any issues such as performance concerns or newly discovered bugs. Positive feedback (improved speed) can also validate migration success.

6. **Support team readiness.** Make sure the operations team knows how to handle issues in Azure. Provide quick cheat-sheets if needed ("To restart the app in Azure, go here; to check logs, go there…"). This preparation reduces downtime if any incident happens. Plan to have supporting services like backup, monitoring, and security in place. For more information, see [Ready your Azure cloud operations ](/azure/cloud-adoption-framework/manage/ready#document-your-cloud-operations).

7. **Monitor multi and hybrid workloads (if needed).** If parts of the workload remain in another cloud (e.g., app server in Azure, service in AWS) or on-premises, monitor these cross-cloud interactions. Watch for latency, reliability, and cost issues. Ensure secure and robust connectivity. Plan to eventually migrate or replace external dependencies with Azure-native services where feasible.

8. continuously reviewing architecture and modernisation opportunities even after initial migration.

## Decommission old workload

When you’re satisfied that the workload is stable in Azure and all users are on it, formally decommission the old version.

1. **Get stakeholder sign-off.** Get confirmation from the business owner that the new system is acceptable and the old one can be considered retired. This avoids miscommunication where IT thinks it's done but a business user was still using the old system for something.

2. **Reclaim licenses.** Reclaim any licenses from decommissioned servers if they can be repurposed. For example, if you moved Windows Server to Azure with Hybrid Benefit, you can reuse the old on-premises license if you freed it.

3. **Archive data.** If needed, keep backups of the last state of the on-prem system for a retention period in case something is missed. Many companies keep VM images or database backups for a few weeks after migration as a fallback. Migrate this data to [Azure Storage blob](/azure/storage/blobs/access-tiers-overview) cold tier or archive tier if you need it for 90 days or longer.

4. **Retire source infrastructure.** For on-premises, that could mean turning off VMs, deallocating hardware, updating CMDB that those servers are decommissioned. For other clouds, that means terminating instances or services there to avoid paying for parallel environments.

5. **Update documentation.** All runbooks, architecture diagrams, support contacts, monitoring dashboards update them to point to the Azure setup. Remove or mark old ones as deprecated.

## Next steps

Use CAF guidance to [govern](/azure/cloud-adoption-framework/govern/), [secure](/azure/cloud-adoption-framework/secure/overview), and [manage](/azure/cloud-adoption-framework/manage/) your Azure estate.|Data migration path|When to use|Pros|Cons||---|---|---|---||ExpressRoute|If available|Secure and fast|Requires setup and cost||Your Network|Default option|Universally available|Uses internet bandwidth||Azure Data Box|For large, non-critical data|Offline bulk transfer|Slowest method||Common readiness issues|Example remediation||---|---||Unsupported OS versions|Fix unsupported operating systems that block replication.||Legacy NIC drivers and BIOS|Update legacy network interface card (NIC) drivers and BIOS to ensure compatibility.||Local file I/O|Replace local file input/output operations with Azure Blob or Azure Files.||Hardcoded IP calls|Swap hardcoded IP calls with service discovery mechanisms.||Host-based antivirus dependency|Remove dependency on host-based antivirus software and integrate Microsoft Defender for Cloud.||Hardcoded user accounts|Use managed identities||Category|Azure||---|---||Unsupported OS versions|Upgrade to supported OS||Legacy NIC drivers/BIOS|Update drivers and firmware||Local file I/O|Use Azure Blob or Azure Files||Hardcoded IPs|Replace with service discovery||Host-based antivirus|Use Microsoft Defender for Cloud||Hardcoded user accounts|Use managed identities||Unsupported OS versions|Upgrade to supported OS|