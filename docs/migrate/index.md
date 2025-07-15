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

## Prepare workloads for the cloud

A workload must be cloud-ready before migration to Azure. Cloud readiness reduces cutover risk and ensures compatibility with Azure services. You should validate, secure, and automate workloads in Azure before production cutover. Use need to use your [Azure architecture plan](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) and your [workload assessment](../plan/assess-workloads-for-cloud-migration.md).

### Create separate subscriptions for each environment

1. **Create a subscription for each environment.** Use distinct subscriptions for development, test, and production environments. This separation enables clearer cost management, policy enforcement, and access control. Use consistent naming conventions to improve visibility and simplify automation. For naming guidance, see [Naming convention](../ready/azure-best-practices/resource-naming.md)

1. **Apply environment-specific policies and budgets.** Use Azure Policy and Cost Management to enforce compliance and track spending. This helps prevent configuration drift and cost overruns.

1. **Assign access based on environment roles.** Use Azure role-based access control (RBAC) to restrict access to each subscription. Enable multifactor authentication (MFA) and configure conditional access policies through Microsoft Entra ID. Use Azure Bastion for secure administrative access to virtual machines. Over-permissioned roles increase the risk of misconfiguration or data exposure. This reduces the risk of accidental changes across environments.

### Deploy resources in a test environment

1. **Use the workload assessment and architecture plan from CAF Plan.** Use the [planned Azure architecture](../plan/estimate-total-cost-of-ownership.md#plan-your-azure-architecture) completed during the Plan phase. This artifact provides the blueprint for creating the test environment. Validate that this document is current and complete before deploying test resources.

1. **Deploy all workload components in the test environment.** Include compute resources (virtual machines, web apps, container hosting), databases, storage accounts, virtual networks, and DNS zones. Incomplete test environments delay validation and increase migration risk. Use your IaC templates or deployment scripts to ensure consistency between test and production environments.

1. **Configure security controls.** Apply (RBAC) to grant workload teams only the permissions required to the Azure resources for their responsibilities. Configure NSGs to limit traffic between subnets and resources. Use private endpoints for Azure services to avoid exposing them to the public internet. Enable managed identities for service-to-service authentication. For a comprehensive checklist, see [Security design](/azure/well-architected/security/checklist).

### Fix compatibility issues in Azure

1. **Identify compatibility issues.** Reference the [workload assessment](../plan/assess-workloads-for-cloud-migration.md) that you completed during the CAF Plan phase.  Azure environments require specific configurations and supported technologies to function correctly. You should identify and fix these issues in the test environment to ensure a smooth production migration.

2. **Resolve compatibility issues in the test environment.** Compatibility issues prevent successful migration and must be resolved before production cutover. fix all identified issues in Azure rather than in the source environment. This approach ensures that your test environment mirrors the production Azure environment as closely as possible. Use the following table to guide your remediation efforts:

| Compatibility Issue | Azure Solution | Why This Matters |
|---------------------|----------------|------------------|
| Unsupported OS versions | Upgrade to supported operating systems | Azure requires supported OS versions for security updates and platform compatibility |
| Legacy NIC drivers and BIOS | Update drivers and BIOS firmware | Modern drivers ensure network performance and security in Azure VMs |
| Local file I/O dependencies | Replace with Azure Blob Storage or Azure Files | Cloud-native storage provides better scalability and integration |
| Hardcoded IP addresses | Use Azure DNS or Private Link for service discovery | Dynamic addressing supports Azure networking and resilience |
| Host-based antivirus software | Integrate with Microsoft Defender for Cloud | Cloud-native security provides better threat detection and management |
| Hardcoded user accounts | Replace with managed identities | Managed identities eliminate credential management and improve security |

### Test workload in the Azure environment

1. **Validate network connectivity and identity integration.** Network connectivity and identity integration form the foundation of successful workload operation in Azure. You must verify that applications connect to dependencies and users authenticate correctly to prevent service disruption during production cutover. Use Azure Network Watcher to test all network routes and firewall rules in your Azure test environment. Test authentication mechanisms through user login scenarios and service-to-service authentication. Validate traffic flows between application tiers and external services using network monitoring tools.

2. **Conduct comprehensive functional and performance testing.** Functional and performance testing validates that your workload operates correctly and meets performance requirements in Azure. You should complete user acceptance testing, load testing, and integration testing to confirm workload behavior matches expectations. Use Azure Load Testing to simulate user traffic and measure response times, throughput, and resource utilization. Document performance metrics and compare results to baseline measurements from your source environment. Involve business stakeholders in acceptance testing to confirm applications meet business requirements and user expectations.

3. **Verify all compatibility fixes in the test environment.** Compatibility fixes ensure that your workload functions correctly in Azure without unexpected behavior. You must test each compatibility fix through functional, performance, and integration testing in the Azure environment. Execute test scenarios that exercise all modified components and validate that fixes resolve identified issues without introducing new problems. Document test results and any additional fixes required based on testing outcomes. Use Azure Monitor and Application Insights to track application behavior and identify potential issues during testing.

4. **Create detailed deployment documentation.** Deployment documentation provides the blueprint for consistent production implementation and reduces deployment risk. You should document all configuration changes, compatibility fixes, and deployment steps validated during testing. Include environment-specific settings, connection strings, service endpoints, and security configurations in your documentation. Add configurations to your infrastructure as code templates and deployment scripts to automate production deployment. Store documentation in version-controlled repositories to ensure team access and maintain change history.

5. **Establish performance baseline comparisons with the source environment.** Performance baseline comparisons validate that your workload maintains or improves performance after migration to Azure. You should have captured comprehensive performance metrics during your workload assessment. Use these baseline measurements to identify performance improvements or degradation during testing and to validate that Azure configurations meet your performance requirements.

## Create reusable infrastructure and automation assets

Reusable infrastructure and automation assets accelerate migration and improve consistency. These assets reduce manual effort, support repeatable deployments, and ensure that tested configurations are preserved. You should create infrastructure as code (IaC) assets only after the workload passes all tests in the test environment.

1. **Create IaC templates after validating workload behavior in the test environment.** Use the test environment to confirm that the workload functions correctly in Azure. This validation ensures that IaC templates reflect tested and production-ready configurations. Use Bicep or Terraform. Bicep provides native integration with Azure Resource Manager, while Terraform supports multi-cloud scenarios and a broader ecosystem.

2. **Automate deployment of third-party tools and workload dependencies.** Include installation and configuration steps for databases, monitoring agents, backup solutions, or other required tools. Use scripts or deployment pipelines to automate these steps. Automation reduces deployment time, eliminates manual errors, and improves reliability across environments.

3. **Store all templates and scripts in version-controlled repositories.** Use GitHub or Azure DevOps to manage IaC assets. Version control enables peer reviews, supports collaboration, and encourages reuse across teams. It also provides traceability and rollback capabilities for infrastructure changes.

4. **Test the infrastructure provisioning process.** Validate that your IaC templates, pipelines, and scripts can create the entire infrastructure stack from scratch. Test different deployment scenarios including initial deployment, updates, and rollbacks to ensure the automation works correctly. Use separate Azure subscriptions or resource groups for testing to avoid conflicts with production resources. This testing validates that your templates work consistently and can be used confidently for production deployments.
