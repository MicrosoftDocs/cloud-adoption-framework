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

### Identify workloads that can tolerate downtime

A workload that can tolerate downtime is suitable for offline migration. It's the recommended approach if possible. It reduces complexity and risk by allowing you to stop the source system before transferring data. You must use this approach for non-critical systems or those with scheduled maintenance windows.

1. **Verify workload inventory and business criticality from CAF Plan.** Ensure that the workload inventory and business criticality classification created during the CAF Plan phase are accurate and up-to-date. This verification ensures alignment with migration priorities and avoids disruptions to essential services. For more information, see [CAF Plan: Discover existing workload inventory](/azure/cloud-adoption-framework/plan/discover-existing-workload-inventory).

2. **Confirm maintenance windows or acceptable downtime periods from your cloud adoption plan.** Reference the maintenance windows and downtime tolerance documented in your cloud adoption plan. This information ensures that offline migration aligns with established business expectations and service-level agreements (SLAs). If this information was not captured during planning, work with stakeholders to define acceptable downtime periods before proceeding with migration.

### Identify workloads that require near-zero downtime

A workload that requires near-zero downtime must use online migration. This classification maintains availability during the transition and is essential for mission-critical systems. You must use continuous replication to minimize downtime during cutover.

1. **Identify mission-critical workloads with strict availability requirements.** Review SLAs, business continuity plans, and stakeholder input to determine which workloads must remain online during migration.

2. **Assess the feasibility of online migration.** Evaluate the workload’s architecture, data volume, and dependencies to confirm that online migration is technically viable. This assessment helps avoid unexpected failures during replication or cutover.

3. **Implement continuous replication and plan for cutover.** Use tools such as Azure Migrate: Server Migration with continuous replication or Azure Site Recovery to replicate data in real time. Schedule a cutover window that minimizes user impact and validate the system post-migration.

## Determine the data migration path for each workload

A data migration path defines how data moves from your current environment to Azure. Selecting the right path ensures secure, timely, and cost-effective data transfer. You must evaluate each workload’s data characteristics and business requirements to choose the most appropriate migration method.

| Data Migration Path | When to Use | Pros | Cons |
|----------------------|-------------|------|------|
| ExpressRoute | If ExpressRoute is available | Secure and fast | Requires setup and cost |
| VPN | If secure transfer is required and ExpressRoute is not available | More secure than public internet | Requires VPN setup |
| Public internet | If no secure path is needed and data is not viable for Data Box | Universally available | Least secure, uses internet bandwidth |
| Azure Data Box | For large, non-critical data | Offline bulk transfer | Slowest method |

1. **Assess the network connectivity available for each workload.** Identify whether ExpressRoute, VPN, or public internet is available and configured. This assessment determines which migration paths are technically feasible and secure. Use Azure Network Watcher or Azure Migrate to evaluate connectivity options.

2. **Use ExpressRoute for high-throughput, secure migrations.** Choose ExpressRoute if it is already provisioned or planned for your environment. ExpressRoute provides private, dedicated connectivity to Azure, which improves performance and security. This method is ideal for all workloads but requires setup and incurs additional cost.

3. **Use VPN for secure transfers when ExpressRoute is unavailable.** Select VPN when you need encrypted data transfer over the internet but do not have ExpressRoute. VPN provides a secure tunnel to Azure but may have lower throughput and higher latency compared to ExpressRoute. Ensure VPN Gateway is configured in your Azure environment.

4. **Use public internet only for non-sensitive, low-volume data.** Choose this method when encryption is not required, ExpressRoute is unavailable, and the data is not suitable for offline transfer. This method is universally available but less secure and may impact bandwidth for other operations.

5. **Use Azure Data Box for large, non-critical offline transfers.** Select Azure Data Box when transferring large volumes of data that are not time-sensitive or business-critical. This method avoids network congestion but is the slowest due to shipping and manual handling. Order and configure the Data Box from the Azure portal.

## Determine the migration sequence

A planned migration sequence reduces migration risk, builds team confidence, and ensures a smooth transition. Start with simpler, non-critical workloads like dev/test environments before tackling more complex or critical systems. If you have many workloads, create a [migration wave plan](./migration-wave-plan.md).

1. **Start with non-critical workloads to validate tools and processes.** Begin with simpler, internal, or non-production workloads such as development and test environments. These workloads are less risky and provide a safe environment to test migration tools, validate assumptions, and refine processes. Use this phase to uncover issues early and build team confidence before migrating critical systems.

2. **Group and migrate dependent workloads together.** Identify and group workloads that have interdependencies. Migrating dependent systems together prevents broken integrations and service disruptions. Use tools like Azure Migrate or dependency visualizers to map workload dependencies. If you cannot migrate all dependencies together, document the gaps and plan for mitigation, including performance testing and integration validation. Understand how to manage hybrid or multi-cloud.

    1. **Identify and group interdependent systems.** Use dependency mapping tools to discover integration points and shared services. Group these systems into migration waves. See [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies).

    2. **Limit hybrid or cross-cloud scenarios to short durations.** Hybrid environments increase complexity and risk. If unavoidable, define a clear timeline to complete the transition. Assign dedicated teams to manage both on-premises and cloud environments. This ensures continuity and reduces operational risk. Use Azure Monitor and other tools to maintain visibility and responsiveness across boundaries. Validate that systems can recover from failures during the transition. This reduces downtime and data loss. Apply caching, replication, or temporary APIs to bridge systems until full migration is complete.

3. **Define and align migration timelines with business priorities.** Establish clear timelines for each migration wave, such as “CRM system live on Azure by June” or “Datacenter A shutdown by Q4.” Align these timelines with business calendars and avoid peak periods, such as holidays for retail applications. This alignment ensures minimal business disruption and stakeholder readiness.

4. **Migrate non-production environments before production.** Always migrate staging, QA, and other non-production environments before production workloads. This step allows you to validate the end-to-end migration process, test application behavior in Azure, and confirm that performance and integrations meet expectations.

5. **Create a migration wave plan for large portfolios.** If you manage many workloads, organize them into migration waves. Each wave should include a manageable set of workloads with similar risk profiles or dependencies. This approach enables iterative learning, reduces complexity, and allows for continuous improvement across waves. For more information, see [Migration wave planning](./migration-wave-plan.md).

## Define rollback criteria and procedures

A rollback strategy is a documented plan that enables teams to revert infrastructure or application changes when deployment fails or introduces risk. A clear rollback strategy reduces downtime, limits business disruption, and supports operational resilience. You should define rollback criteria and procedures before any migration or deployment activity.

1. **Establish rollback criteria based on business and technical risk.** Rollback criteria are the specific conditions under which a rollback must be triggered. These include failed health checks, performance degradation, security violations, or unmet success metrics. Defining these criteria ensures teams act decisively when issues arise. You should collaborate with business stakeholders, application owners, and operations teams to define thresholds for failure and document them in your deployment plan.

2. **Document rollback procedures for each workload or change type.** Rollback procedures are the step-by-step instructions to revert a change. These vary depending on the workload, environment, and deployment method. Documenting rollback steps ensures consistency and reduces human error during high-pressure situations. You should include rollback scripts, configuration snapshots, and infrastructure-as-code templates in your documentation.

3. **Test rollback procedures in a pre-production environment.** Testing validates that rollback steps work as expected and do not introduce new issues. This step is critical for identifying gaps in automation, permissions, or dependencies. You should simulate failure scenarios in a staging environment and verify that rollback restores the system to a known-good state.

4. **Automate rollback where possible using deployment tools.** Automation reduces manual effort and speeds up recovery. Tools like Azure DevOps, GitHub Actions, or Bicep templates can automate rollback of infrastructure and application deployments. You should integrate rollback logic into your CI/CD pipelines and use deployment slots or blue-green deployments to simplify reversions.

5. **Include rollback plans in change management and release documentation.** Visibility into rollback plans ensures all stakeholders understand the recovery path. This is especially important for regulated environments or mission-critical systems. You should attach rollback documentation to change requests, release notes, and operational runbooks.

6. **Review and update rollback strategies after each deployment.** Continuous improvement ensures rollback strategies remain effective as systems evolve. You should conduct post-incident reviews and update rollback documentation based on lessons learned.

| Category | Tool | Description |
|----------|------|-------------|
| Deployment automation | https://learn.microsoft.com/azure/devops/?view=azure-devops | Supports CI/CD pipelines with rollback logic and deployment gates. |
| Infrastructure as Code | https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview | Enables declarative infrastructure definitions with rollback via version control. |
| Application deployment | https://learn.microsoft.com/azure/app-service/deploy-staging-slots | Allows blue-green deployments and quick rollback by swapping slots. |
| Monitoring and alerts | https://learn.microsoft.com/azure/azure-monitor/overview | Detects failure conditions that can trigger rollback actions. |
| Change tracking | https://learn.microsoft.com/azure/automation/change-tracking/overview | Tracks configuration changes to support rollback decisions. |

## Define stakeholder communication plans

1. **Create a stakeholder communication plan.** Identify key stakeholders and define how and when to communicate updates, risks, and decisions. Use structured channels such as Teams, email, or dashboards.

1. communication management and including business in decisions - the migration schedule needs to be a collaborative decision. The timeframe for cutover should have the least impact on the business and end users as possible, so blackout dates and change freezes should be considered on an app by app basis assuming there will be downtime.

## Prepare workloads for the cloud

Before migrating, ensure workloads are ready for Azure. Addressing compatibility and configuration issues early reduces cutover risk.

1. **Conduct a workload assessment.** Conduct a [workload assessment](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration) of each workload. A workload assessment determines the specifications and readiness for Azure.

2. **Plan workload architecture.** You shouldesign the target architecture in Azure. For information, see [Plan the target architecture](#_Plan_the_target).

3. **Fix issues in Azure.** Remediate compatibility issues in Azure. A test deployment in Azure validates workload behavior and uncovers compatibility issues before production cutover. This step reduces migration risk by ensuring workloads operate as expected in the target environment. You must test workloads in Azure and resolve all identified issues in the cloud environment to ensure a smooth and predictable migration.

1. **Deploy the workload in a test environment in Azure.** Use a staging subscription or Azure DevTest Labs to replicate the production environment. This test environment must reflect production configurations, including network topology, identity controls, and storage dependencies. Testing in Azure exposes issues that may not appear in on-premises environments.

2. **Identify and resolve compatibility issues in Azure.** Run validation tests and monitor workload behavior. Address all issues directly in the Azure environment to ensure fixes are effective in the target platform. Avoid remediating in the source environment, as this may not reflect Azure-specific behavior.

3. **Apply targeted remediations for common readiness issues.** Use the table below to address known blockers that frequently impact workload migration.

    | Readiness Issue               | Remediation                                                                 |
    |-------------------------------|-----------------------------------------------------------------------------|
    | Unsupported OS versions       | Fix unsupported operating systems that block replication.                  |
    | Legacy NIC drivers and BIOS   | Update legacy network interface card (NIC) drivers and BIOS to ensure compatibility. |
    | Local file I/O                | Replace local file input/output operations with Azure Blob or Azure Files. |
    | Hardcoded IP calls            | Swap hardcoded IP calls with service discovery mechanisms.                 |
    | Host-based antivirus dependency | Remove dependency on host-based antivirus software and integrate Microsoft Defender for Cloud. |
    | Hardcoded user accounts       | Use managed identities.                                                    |

## Create your Azure workload resources

At this point, you need to create Azure resources that will hold the workload after cutover. You need to stage the Azure resources to receive the incoming workload data. Creating Azure workload resources before production cutover is essential to ensure a smooth and predictable migration. This phase focuses on provisioning, validating, securing, and automating the target environment to support a successful transition.

### Provision and configure Azure workload resources

A fully provisioned and configured Azure environment ensures readiness for workload migration. This step reduces downtime and minimizes risk during the cutover.

1. Provision all required Azure resources to host the workload. Create infrastructure components such as virtual machines, storage accounts, networking, and platform services. Include all dependencies such as DNS, identity, and data services. This ensures the environment is complete and avoids delays during cutover.

2. Configure resources to meet workload requirements. Apply workload-specific settings such as performance tiers, availability zones, and backup policies. Ensure the configuration aligns with business continuity and compliance requirements.

### Validate the workload in a non-production environment

A validated non-production environment ensures the production cutover proceeds without disruption. This step helps identify and resolve issues early.

1. Migrate and test non-production workloads. Use representative test data and simulate real-world scenarios to validate the end-to-end migration process. Confirm that the workload performs as expected in Azure.

2. Validate all workload dependencies. Ensure DNS resolution, data access, and application configurations function correctly. Identify and document any issues for remediation.

3. Test rollback procedures. Simulate rollback scenarios to verify that recovery steps are executable and well-documented. This reduces risk during production cutover.

4. Refine the migration runbook. Update the migration plan based on test results. Include detailed steps, validation checks, and rollback procedures to guide the production cutover.

### Apply security controls for workload and user access

Security controls protect sensitive data and ensure compliance with organizational policies. These controls must be applied to both workload teams and end users.

1. Apply role-based access control (RBAC) for workload teams. Assign appropriate roles using Azure RBAC. Limit permissions to the minimum required for operational responsibilities. This enforces least privilege and reduces the risk of misconfiguration.

2. Enforce user authentication and authorization. Use Microsoft Entra ID to manage user identities. Require multifactor authentication (MFA) and apply conditional access policies to protect access to critical resources.

3. Restrict access using virtual networks. Use network security groups (NSGs), private endpoints, and service endpoints to limit access to only necessary public interfaces. This reduces the attack surface and enforces network segmentation.

### Create reusable assets and automation

Reusable infrastructure and automation accelerate migration efforts and improve consistency across environments.

1. Develop infrastructure-as-code (IaC) templates. Use Bicep or Terraform to define and deploy Azure resources. Create templates for common services such as virtual machines, App Services, storage accounts, and file shares. This ensures repeatability and version control.

2. Automate deployment of third-party tools. Build scripts or pipelines to install and configure tools such as Oracle databases, monitoring agents, or backup solutions. Automating these steps reduces manual effort and deployment errors.

3. Use source control to manage templates. Store IaC templates and scripts in GitHub or Azure DevOps. Enable versioning, peer reviews, and collaboration across teams. Encourage teams to contribute to and reuse shared assets.

## Execute workload cutover

Migration execution requires a structured and validated approach to ensure workload continuity, data integrity, and minimal disruption. You must choose between offline and online migration strategies based on workload criticality and acceptable downtime.

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