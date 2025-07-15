---
title: Migrate overview
description: Prepare for a successful migration to Azure by using an iterative process to assess, deploy, and release workloads.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Optimize workloads post-migration

After a successful cutover, immediate optimizations might be necessary. This phase overlaps with ongoing operations, but it’s essential to ensure your workloads are stable, performant, and cost-effective in Azure.

1. **Fine-tune configurations.** Azure offers flexibility to quickly adjust resources. Post-migration workloads might behave differently than they did on-premises or in other clouds. Use [Azure Advisor](/azure/advisor/advisor-overview) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/review-security-recommendations) to get tailored recommendations on cost optimization, performance, reliability, and security. Tweak configurations in accordance with [Azure services guides](/azure/well-architected/service-guides/?product=popular).

2. **Monitor costs and resource utilization.** Cost anomalies often result from workload changes or unexpected Azure behavior patterns. Azure's elastic scaling capabilities can amplify inefficiencies that were previously constrained in on-premises environments. You should establish cost monitoring and alerting to detect unusual spending patterns early. Use [Azure Cost Management](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) to track spending trends and identify optimization opportunities. Configure budget alerts to notify stakeholders when costs exceed thresholds. Review resource utilization metrics to identify over-provisioned resources that can be rightsized. Consider third-party cost optimization tools for advanced analytics and automated recommendations across complex environments.

3. **Validate monitoring.** The first few days or weeks post-migration serve as a "bake-in" period. Ensure that performance, availability, and usage patterns align with expectations. Confirm that Azure Monitor is capturing the right metrics and alerts are configured appropriately. For more information, see [Monitor your Azure cloud estate.](/azure/cloud-adoption-framework/manage/monitor)

4. **Validate backups.** Ensure backup jobs are configured correctly and completing successfully. Test restore procedures to confirm data recoverability. For data reliability, see [Manage data reliability](/azure/cloud-adoption-framework/manage/protect#manage-data-reliability).

5. **Gather feedback from users.** Collect and document feedback from end users. Address any issues such as performance concerns or newly discovered bugs. Positive feedback (improved speed) can also validate migration success.

6. **Support team readiness.** Make sure the operations team knows how to handle issues in Azure. Provide quick cheat-sheets if needed ("To restart the app in Azure, go here; to check logs, go there…"). This preparation reduces downtime if any incident happens. Plan to have supporting services like backup, monitoring, and security in place. For more information, see [Ready your Azure cloud operations ](/azure/cloud-adoption-framework/manage/ready#document-your-cloud-operations).

7. **Monitor multi and hybrid workloads (if needed).** If parts of the workload remain in another cloud or on-premises, monitor these cross-cloud interactions. Watch for latency, reliability, and cost issues. Ensure secure and robust connectivity. Plan to eventually migrate or replace external dependencies with Azure-native services where feasible.

8. **Schedule regular architecture reviews to identify modernization opportunities.** Migration teams often move to new projects immediately after cutover. Schedule quarterly architecture reviews to assess over provisioning to optimize costs. Use [Azure Well-Architected Framework reviews](/azure/well-architected/) to systematically evaluate cost optimization, operational excellence, performance efficiency, reliability, and security. Create a backlog of modernization opportunities and prioritize them based on business value and technical debt reduction. Assign ownership for these reviews to ensure they happen consistently rather than being deferred indefinitely.

## Decommission old workloads

When you’re satisfied that the workload is stable in Azure and all users are on it, formally decommission the the source workload.

1. **Obtain stakeholder sign-off.** Get confirmation from the business owner that the new system is acceptable and the old one can be considered retired. This avoids miscommunication where IT thinks it's done but a business user was still using the old system for something.

2. **Reclaim licenses.** Reclaim any licenses from decommissioned servers if they can be repurposed. For example, Do you mean the on-prem license is used by AHB, thus reducing the VM cost  on Azure? The sentence needs clarity s it could be read that you have a spare on-prem license, which isn't correct, the license would be used by the Azure VM via AHB.

3. **Archive data.** Retention requirements vary by organization and regulatory environment. Many companies maintain VM images or database backups for several weeks after migration as a safety measure. Financial institutions face regulatory obligations to retain data for seven years or longer. You should migrate archived data to [Azure Storage blob](/azure/storage/blobs/access-tiers-overview) cold tier for 90-day retention or archive tier for longer periods. Document retention policies and ensure archived data remains accessible for compliance audits. Test restoration procedures to confirm data can be recovered when needed. This archival strategy provides both regulatory compliance and operational safety during the transition period.

4. **Update documentation and operational assets.** Documentation updates ensure teams can effectively operate and troubleshoot workloads in Azure. Outdated documentation creates operational risk and increases incident response time. You should update all operational documentation, architecture diagrams, runbooks, and monitoring dashboards to reflect the new Azure environment. Remove or mark legacy documentation as deprecated to prevent confusion during incidents. Include time and budget for documentation updates in your migration planning process. Organizations often overlook this requirement, which results in incomplete operational handoffs and increased support burden.

## Next steps

