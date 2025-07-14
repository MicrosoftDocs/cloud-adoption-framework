---
title: Migrate overview
description: Prepare for a successful migration to Azure by using an iterative process to assess, deploy, and release workloads.
author: stephen-sumner
ms.author: pnp
ms.date: 04/09/2024
ms.topic: conceptual
---

# CAF Migrate

This guidance provides a framework execute your migrations.

**Required:**

- Plan your migration ([discover inventory](/azure/cloud-adoption-framework/plan/discover-existing-workload-inventory), [select migration strategy per workload](/azure/cloud-adoption-framework/plan/select-cloud-migration-strategy), and assess workloads) and [document your cloud adoption plan](/azure/cloud-adoption-framework/plan/document-cloud-adoption-plan).
- Azure landing zone deployed with application subscriptions for this workload. A cloud adoption plan provides structure and clarity for migration efforts. It ensures that all stakeholders understand the scope, priorities, and expected outcomes. See [CAF Plan: Document your cloud adoption plan](/azure/cloud-adoption-framework/plan/document-cloud-adoption-plan).

## Understand migration skills

1. Evaluate internal skills and experience. Assess your team’s familiarity with Azure services, tools, and migration patterns. Identify gaps that could delay progress.

2. Consider hiring external expertise. Migration complexity varies based on your environment and experience. Expert support can reduce risk and accelerate progress. Evaluate internal skills and experience with Azure and cloud migrations. If gaps exist, engage [Microsoft or a Microsoft partner](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate/#Nextsteps) early. Use their expertise to validate your migration strategy, tools, and timelines.

## Determine migration execution strategy per workload

A migration execution strategy defines how each workload transitions to Azure with minimal disruption. This decision is critical to ensure business continuity and reduce risk during cloud adoption. You must evaluate each workload’s tolerance for downtime to select the appropriate migration approach.

## Classify each workload by downtime tolerance

A workload’s tolerance for downtime determines the most appropriate migration strategy. This classification ensures that each workload is migrated with the right balance of risk, complexity, and business continuity. You must assess each workload to determine whether it supports offline migration, requires online migration, or is better suited for redeployment.

### Identify workloads that can tolerate downtime

A workload that can tolerate downtime is suitable for offline migration. This classification reduces complexity and risk by allowing you to stop the source system before transferring data. You must use this approach for non-critical systems or those with scheduled maintenance windows.

1. **Inventory all workloads and document their business criticality.** Create a list of workloads and classify them based on their impact on business operations. This classification helps determine which systems can be taken offline without disrupting essential services.

2. **Confirm maintenance windows or acceptable downtime periods.** Review operational policies and service-level agreements (SLAs) to identify when downtime is permissible. This step ensures that offline migration aligns with business expectations.

3. **Select offline migration tools and methods.** Use tools that support offline migration, such as Azure Migrate: Server Migration or Azure Data Box, to transfer data while the source system is offline. This approach simplifies cutover and reduces the risk of data inconsistency.

### Identify workloads that require near-zero downtime

A workload that requires near-zero downtime must use online migration. This classification maintains availability during the transition and is essential for mission-critical systems. You must use continuous replication to minimize downtime during cutover.

1. **Identify mission-critical workloads with strict availability requirements.** Review SLAs, business continuity plans, and stakeholder input to determine which workloads must remain online during migration.

2. **Assess the feasibility of online migration.** Evaluate the workload’s architecture, data volume, and dependencies to confirm that online migration is technically viable. This assessment helps avoid unexpected failures during replication or cutover.

3. **Implement continuous replication and plan for cutover.** Use tools such as Azure Migrate: Server Migration with continuous replication or Azure Site Recovery to replicate data in real time. Schedule a cutover window that minimizes user impact and validate the system post-migration.

## Identify workloads suitable for redeployment

A workload that can be rebuilt in Azure is suitable for redeployment. This classification avoids the complexity of data synchronization and enables modernization. You must use infrastructure-as-code or deployment pipelines to provision these workloads in Azure.

1. **Evaluate workloads for rebuild potential.** Identify workloads that are stateless, containerized, or already defined in code. These workloads are ideal candidates for redeployment.

2. **Define infrastructure and configuration as code.** Use tools such as Azure Resource Manager (ARM) templates, Bicep, or Terraform to codify infrastructure. This approach ensures consistency, repeatability, and version control.

3. **Deploy workloads using automated pipelines.** Use Azure DevOps or GitHub Actions to automate deployment. Validate the environment post-deployment to ensure it meets functional and performance requirements.

## Determine the data migration path for each workload

A data migration path defines how data moves from your current environment to Azure. Selecting the right path ensures secure, timely, and cost-effective data transfer. You must evaluate each workload’s data characteristics and business requirements to choose the most appropriate migration method.

1. **Assess the network connectivity available for each workload.** Identify whether ExpressRoute, VPN, or public internet is available and configured. This assessment determines which migration paths are technically feasible and secure. Use Azure Network Watcher or Azure Migrate to evaluate connectivity options.

2. **Use ExpressRoute for high-throughput, secure migrations.** Choose ExpressRoute if it is already provisioned or planned for your environment. ExpressRoute provides private, dedicated connectivity to Azure, which improves performance and security. This method is ideal for all workloads but requires setup and incurs additional cost.

3. **Use VPN for secure transfers when ExpressRoute is unavailable.** Select VPN when you need encrypted data transfer over the internet but do not have ExpressRoute. VPN provides a secure tunnel to Azure but may have lower throughput and higher latency compared to ExpressRoute. Ensure VPN Gateway is configured in your Azure environment.

4. **Use public internet only for non-sensitive, low-volume data.** Choose this method when encryption is not required, ExpressRoute is unavailable, and the data is not suitable for offline transfer. This method is universally available but less secure and may impact bandwidth for other operations.

5. **Use Azure Data Box for large, non-critical offline transfers.** Select Azure Data Box when transferring large volumes of data that are not time-sensitive or business-critical. This method avoids network congestion but is the slowest due to shipping and manual handling. Order and configure the Data Box from the Azure portal.

### Data migration path comparison

| Data Migration Path | When to Use | Pros | Cons |
|----------------------|-------------|------|------|
| ExpressRoute | If ExpressRoute is available | Secure and fast | Requires setup and cost |
| VPN | If secure transfer is required and ExpressRoute is not available | More secure than public internet | Requires VPN setup |
| Public internet | If no secure path is needed and data is not viable for Data Box | Universally available | Least secure, uses internet bandwidth |
| Azure Data Box | For large, non-critical data | Offline bulk transfer | Slowest method |

### Define rollback strategies and stakeholder communication plans

Rollback and communication plans reduce risk and improve stakeholder confidence. You must include both in your migration plan.

1. **Define rollback criteria and procedures.** Establish clear conditions for rollback and document the steps to revert changes. Test rollback procedures before migration.

2. **Create a stakeholder communication plan.** Identify key stakeholders and define how and when to communicate updates, risks, and decisions. Use structured channels such as Teams, email, or dashboards.

## Create reusable assets and automation to accelerate migration

Reusable infrastructure and automation reduce manual effort and increase consistency. You must create infrastructure-as-code (IaC) templates and automation scripts for both Azure and non-Azure services.

1. **Develop IaC templates for Azure services.** Create templates for common services such as virtual machines, App Services, storage accounts, and file shares. Use Bicep or Terraform for consistency and version control.

2. **Automate deployment of non-Azure dependencies.** Build scripts or pipelines to deploy third-party tools such as Oracle databases or monitoring agents. This ensures repeatability and reduces errors.

3. **Store and share reusable assets in a central repository.** Use GitHub or Azure DevOps to manage and version templates. Encourage teams to contribute and reuse assets.

### Redeploy workloads when rebuilding is more efficient

Redeployment is a valid alternative when workloads can be rebuilt in Azure. This approach is ideal for modern applications or those managed through DevOps pipelines.

1. **Deploy and configure required Azure services.** Provision infrastructure using ARM templates, Bicep, or Terraform. Configure networking, identity, and monitoring to support the application.

2. **Deploy the application.** Install and configure the application in the new Azure environment. Use CI/CD pipelines to automate deployment where possible.

3. **Test the application.** Validate functionality, integration, and performance in Azure. Ensure the application meets operational and business requirements.

4. **Stop the original workload and migrate the database.** Shut down the on-premises system. Transfer any required data to Azure using secure and supported tools.

5. **Decommission on-premises resources.** Retire legacy infrastructure to complete the transition and reduce operational overhead.

## Determine the migration sequence

A planned migration sequence reduces migration risk, builds team confidence, and ensures a smooth transition. Start with simpler, non-critical workloads like dev/test environments before tackling more complex or critical systems. If you have many workloads, create a [migration wave plan](./migration-wave-plan.md).

1. **Start with non-critical workloads to validate tools and processes.** Begin with simpler, internal, or non-production workloads such as development and test environments. These workloads are less risky and provide a safe environment to test migration tools, validate assumptions, and refine processes. Use this phase to uncover issues early and build team confidence before migrating critical systems.

2. **Group and migrate dependent workloads together.** Identify and group workloads that have interdependencies. Migrating dependent systems together prevents broken integrations and service disruptions. Use tools like Azure Migrate or dependency visualizers to map workload dependencies. If you cannot migrate all dependencies together, document the gaps and plan for mitigation, including performance testing and integration validation. Understand how to manage hybrid or multi-cloud.

    1. **Identify and group interdependent systems.** Use dependency mapping tools to discover integration points and shared services. Group these systems into migration waves. See [Map internal and external dependencies](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration#map-internal-and-external-dependencies).

    2. **Limit hybrid or cross-cloud scenarios to short durations.** Hybrid environments increase complexity and risk. If unavoidable, define a clear timeline to complete the transition. Assign dedicated teams to manage both on-premises and cloud environments. This ensures continuity and reduces operational risk. Use Azure Monitor and other tools to maintain visibility and responsiveness across boundaries. Validate that systems can recover from failures during the transition. This reduces downtime and data loss. Apply caching, replication, or temporary APIs to bridge systems until full migration is complete.

3. **Define and align migration timelines with business priorities.** Establish clear timelines for each migration wave, such as “CRM system live on Azure by June” or “Datacenter A shutdown by Q4.” Align these timelines with business calendars and avoid peak periods, such as holidays for retail applications. This alignment ensures minimal business disruption and stakeholder readiness.

4. **Migrate non-production environments before production.** Always migrate staging, QA, and other non-production environments before production workloads. This step allows you to validate the end-to-end migration process, test application behavior in Azure, and confirm that performance and integrations meet expectations.

5. **Create a migration wave plan for large portfolios.** If you manage many workloads, organize them into migration waves. Each wave should include a manageable set of workloads with similar risk profiles or dependencies. This approach enables iterative learning, reduces complexity, and allows for continuous improvement across waves. For more information, see [Migration wave planning](./m)

## Prepare workloads for the cloud

Before migrating, ensure workloads are ready for Azure. Addressing compatibility and configuration issues early reduces cutover risk.

1.**Conduct a workload assessment.** Conduct a [workload assessment](/azure/cloud-adoption-framework/plan/assess-workloads-for-cloud-migration) of each workload. A workload assessment determines the specifications and readiness for Azure.

2.**Plan workload architecture.** You shouldesign the target architecture in Azure. For information, see [Plan the target architecture](#_Plan_the_target).

3.**Fix issues in Azure.** Remediate compatibility issues in Azure
A test deployment in Azure validates workload behavior and uncovers compatibility issues before production cutover. This step reduces migration risk by ensuring workloads operate as expected in the target environment.
You must test workloads in Azure and resolve all identified issues in the cloud environment to ensure a smooth and predictable migration.
Deploy the workload in a test environment in Azure. Use a staging subscription or Azure DevTest Labs to replicate the production environment. This test environment must reflect production configurations, including network topology, identity controls, and storage dependencies. Testing in Azure exposes issues that may not appear in on-premises environments.
Identify and resolve compatibility issues in Azure. Run validation tests and monitor workload behavior. Address all issues directly in the Azure environment to ensure fixes are effective in the target platform. Avoid remediating in the source environment, as this may not reflect Azure-specific behavior.
Apply targeted remediations for common readiness issues. Use the table below to address known blockers that frequently impact workload migration.

| Readiness Issue               | Remediation                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| Unsupported OS versions       | Fix unsupported operating systems that block replication.                  |
| Legacy NIC drivers and BIOS   | Update legacy network interface card (NIC) drivers and BIOS to ensure compatibility. |
| Local file I/O                | Replace local file input/output operations with Azure Blob or Azure Files. |
| Hardcoded IP calls            | Swap hardcoded IP calls with service discovery mechanisms.                 |
| Host-based antivirus dependency | Remove dependency on host-based antivirus software and integrate Microsoft Defender for Cloud. |
| Hardcoded user accounts       | Use managed identities.                                                    |

## Provision target environment

At this point, you need to create Azure resources that will hold the workload after cutover. You need to stage the Azure resources to receive the incoming workload data.

1.** Create and configure Azure resources.** Get all prerequisites ready so that the actual cutover can proceed smoothly.

1.** Test workload.** After provisioning the target environment, migrate and test non-production workloads to validate the end-to-end migration process. This rehearsal phase is essential for identifying and resolving issues before production cutover. Use the test to confirm the workload runs in Azure as expected. Validate dependencies (DNS, data) and configurations. Document any issues and refine your migration runbook for production.

## Execute your migration to Azure

Migration execution is the step where you migrate data to Azure and direct users to the new workload in Azure. Plan and execute the switch to Azure per your migration plan. For each workload:

1.** Notify stakeholders of cutover time.** Communicate the schedule to everyone affected (IT staff, app owners, end users if needed). Make sure support teams are on standby during the cutover window. Freeze changes on the source system.
2.** Migrate data.** For offline migrations, turn off the source system at the scheduled time and perform the final migration steps. Do final the backup and then copy the data to Azure before redirecting users to the Azure workload.

## Execute the migration

### Execute offline migrations for non-critical workloads

An offline migration is the preferred approach for workloads that can tolerate downtime. This method reduces complexity and risk by avoiding real-time synchronization. You must follow a structured sequence to ensure data consistency, minimize downtime, and validate functionality in Azure.

1. **Stop the source workload to ensure data consistency.** Shut down the application or service that hosts the workload. This step prevents data changes during migration and avoids corruption or loss. Use application-specific shutdown procedures to ensure a clean stop.

2. **Create a complete backup of the workload’s data.** Generate a full backup of all relevant data, configurations, and dependencies. This backup serves as both the migration source and a recovery point. Store the backup in a secure, accessible location.

3. **Deploy and configure required Azure services.** Provision the necessary infrastructure in Azure, such as virtual machines, databases, or storage accounts. Use Azure Resource Manager (ARM) templates, Bicep, or Terraform to ensure consistency and repeatability. Configure networking, identity, and access controls to match the source environment.

4. **Transfer the backup to Azure using secure and supported tools.** Use tools such as AzCopy, Azure Storage Explorer, or Azure Data Box to move the backup to Azure. Select the tool based on data volume, network bandwidth, and security requirements.

5. **Restore the data in Azure and validate workload functionality.** Deploy the backup to the target Azure service or virtual machine. Perform functional and integration testing to confirm that the workload operates correctly. Validate data integrity and application behavior.

6. **Start the workload in Azure to resume operations.** Bring the application or service online. Monitor startup logs and system health to ensure successful initialization.

7. **Redirect users to the Azure-hosted workload.** Update DNS records, connection strings, or endpoint configurations. Confirm that users and dependent systems can access the workload without issues.

### Execute online migrations for mission-critical workloads

An online migration is essential for workloads that require high availability. This approach uses continuous data synchronization to minimize downtime. You must follow a structured sequence to maintain data integrity and ensure readiness in Azure.

1. **Deploy and configure required Azure services.** Provision the target environment in Azure, including compute, storage, and networking components. Use infrastructure-as-code tools to ensure consistency. Configure services to match the source environment’s architecture and security posture.

2. **Configure continuous data synchronization between the source and Azure.** Set up replication tools to mirror data changes in near real time. Use tools compatible with your workload type to ensure the Azure environment stays current.

3. **Perform an initial full data synchronization to establish a baseline.** Transfer the complete dataset to Azure. This step ensures a consistent starting point for ongoing replication.

4. **Maintain synchronization of ongoing changes while the source remains active.** Keep replication running to capture all new data changes. This reduces the delta during final cutover.

5. **Block new write operations to the source system before final cutover.** Temporarily stop all write activity to prevent data divergence. This step ensures consistency during the final sync.

6. **Perform a final synchronization to capture any remaining changes.** Run a last sync operation to ensure the Azure environment reflects the most recent state.

7. **Start the workload in Azure to resume operations.** Bring the application or service online. Monitor logs and system health to confirm readiness.

8. **Validate the workload functionality and performance in Azure.** Conduct functional, integration, and performance testing. Confirm that all dependencies and configurations work as expected.

9. **Redirect user traffic to the Azure-hosted workload.** Update DNS records, connection strings, or load balancer configurations. Confirm that users can access the workload without issues.


For online migrations, ensure the data sync is up to date. Stop the source system from accepting new data. Let the last changes sync before redirecting users to the Azure resources.

1.** Redirect users (cut over).** Ensure all Azure services are running and healthy. Perform the cutover. Cutover requires you update DNS entries, load balancer configs, and application URLs to point to the new Azure endpoints. For example, change DNS CNAME to the Azure Web App’s address or point applications to the new database endpoint.
2.** Validate the workload.** Have application owners or testers verify all major functions are working on the Azure-hosted system. Check the system for any errors. Only after thorough testing announce the migration is successful.

After migrating data, run checks to ensure all records are present and integrity holds. For databases, use techniques like row counts comparison, or run critical reports on old vs new to see if they match. Use tools to validate data or even run the old and new in parallel read-only mode to compare results. For critical data, it’s worth the effort.

1.** Keep the fallback option.** Keep the old environment available as a fallback until you are confident in the Azure system. If something unexpectedly goes wrong, you can revert DNS and go back.

## Decommission old workload

When you’re satisfied that the workload is stable in Azure and all users are on it, formally decommission the old version.

1.** Get stakeholder sign-off.** Get confirmation from the business owner that the new system is acceptable and the old one can be considered retired. This avoids miscommunication where IT thinks it’s done but a business user was still using the old system for something.
2.** Reclaim licenses.** Reclaim any licenses from decommissioned servers if they can be repurposed. For example, if you moved Windows Server to Azure with Hybrid Benefit, you can reuse the old on-premises license if you freed it.
3.** Archive data.** If needed, keep backups of the last state of the on-prem system for a retention period in case something is missed. Many companies keep VM images or database backups for a few weeks after migration as a fallback. Migrate this data to [Azure Storage blob](/azure/storage/blobs/access-tiers-overview) cold tier or archive tier if you need it for 90 days or longer.
4.** Retire source infrastructure.** For on-premises, that could mean turning off VMs, deallocating hardware, updating CMDB that those servers are decommissioned. For other clouds, that means terminating instances or services there to avoid paying for parallel environments.
5.** Update documentation:** All runbooks, architecture diagrams, support contacts, monitoring dashboards update them to point to the Azure setup. Remove or mark old ones as deprecated.

## Optimize post-migration

After a successful cutover, immediate optimizations may be necessary. This phase overlaps with ongoing operations, but it’s essential to ensure your workloads are stable, performant, and cost-effective in Azure. Here’s how:

1.** Fine-tune configurations.** Azure offers flexibility to quickly adjust resources. Post-migration workloads might behave differently than they did on-premises or in other clouds. Use [Azure Advisor](/azure/advisor/advisor-overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/review-security-recommendations) to get tailored recommendations on cost optimization, performance, reliability, and security. Tweak configurations in accordance with [Azure services guides](/azure/well-architected/service-guides/?product=popular).
2.** Monitor costs**. Cost anomalies typically stem from either workload changes (enabling new features) or unexpected behavior in Azure. For example, autoscaling or inefficient SQL queries that were throttled on-premises might now consume more resources. Use [Azure Cost Management](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) to spot cost anomalies and Azure Advisor for relevant performance and reliability improvements. Compare current costs to your pre-migration baseline. Identify and address any configuration or feature changes that are driving up costs.
3.** Validate monitoring**. The first few days or weeks post-migration serve as a “bake-in” period. Ensure that performance, availability, and usage patterns align with expectations. Confirm that Azure Monitor is capturing the right metrics and alerts are configured appropriately. For more information, see [Monitor your Azure cloud estate.](/azure/cloud-adoption-framework/manage/monitor)
4.** Validate backups**. Ensure backup jobs are configured correctly and completing successfully. Test restore procedures to confirm data recoverability. For data reliability, see [Manage data reliability](/azure/cloud-adoption-framework/manage/protect#manage-data-reliability).
5.** Gather feedback from users.** Collect and document feedback from end users. Address any issues such as performance concerns or newly discovered bugs. Positive feedback (improved speed) can also validate migration success.
6.** Support team readiness.** Make sure the operations team knows how to handle issues in Azure. Provide quick cheat-sheets if needed (“To restart the app in Azure, go here; to check logs, go there…”). This preparation reduces downtime if any incident happens. Plan to have supporting services like backup, monitoring, and security in place. For more information, see [Ready your Azure cloud operations ](/azure/cloud-adoption-framework/manage/ready#document-your-cloud-operations).
7.** Monitor multi and hybrid workloads (if needed).** If parts of the workload remain in another cloud (e.g., app server in Azure, service in AWS) or on-premises, monitor these cross-cloud interactions. Watch for latency, reliability, and cost issues. Ensure secure and robust connectivity. Plan to eventually migrate or replace external dependencies with Azure-native services where feasible.

## Next steps

Use CAF guidance to [govern](/azure/cloud-adoption-framework/govern/), [secure](/azure/cloud-adoption-framework/secure/overview), and [manage](/azure/cloud-adoption-framework/manage/) your Azure estate.|Data migration path|When to use|Pros|Cons||---|---|---|---||ExpressRoute|If available|Secure and fast|Requires setup and cost||Your Network|Default option|Universally available|Uses internet bandwidth||Azure Data Box|For large, non-critical data|Offline bulk transfer|Slowest method||Common readiness issues|Example remediation||---|---||Unsupported OS versions|Fix unsupported operating systems that block replication.||Legacy NIC drivers and BIOS|Update legacy network interface card (NIC) drivers and BIOS to ensure compatibility.||Local file I/O|Replace local file input/output operations with Azure Blob or Azure Files.||Hardcoded IP calls|Swap hardcoded IP calls with service discovery mechanisms.||Host-based antivirus dependency|Remove dependency on host-based antivirus software and integrate Microsoft Defender for Cloud.||Hardcoded user accounts|Use managed identities||Category|Azure||---|---||Unsupported OS versions|Upgrade to supported OS||Legacy NIC drivers/BIOS|Update drivers and firmware||Local file I/O|Use Azure Blob or Azure Files||Hardcoded IPs|Replace with service discovery||Host-based antivirus|Use Microsoft Defender for Cloud||Hardcoded user accounts|Use managed identities||Unsupported OS versions|Upgrade to supported OS|