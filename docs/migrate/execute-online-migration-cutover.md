---
title: Execute online migrations
description: Use online migration to move workloads to Azure with continuous data synchronization that minimizes downtime and maintains high availability.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Execute online migration cutover

This article helps you execute online migrations for workloads that require high availability. Online migration uses continuous data synchronization to minimize downtime and maintain service availability during the transition to Azure.

## 1. Deploy and configure the production environment before migration

1. **Provision production resources using infrastructure-as-code.** Infrastructure-as-code templates ensure consistency across environments and reduce configuration drift. Use Azure Resource Manager (ARM) templates, Bicep, or Terraform to deploy the same resource definitions used in non-production environments. This approach creates predictable deployments and simplifies troubleshooting.

2. **Apply production-grade configurations for networking, identity, and access.** Production configurations secure the environment and enable seamless integration with dependent systems. Configure virtual networks, subnets, private endpoints, role-based access control (RBAC), and managed identities. Ensure that IP ranges, DNS zones, and firewall rules match the tested design from your non-production environments.

3. **Validate the readiness of the production environment.** Environment validation reduces the risk of delays or failures during the cutover window. Confirm that all services are deployed, accessible, and correctly configured. Run pre-cutover validation scripts or checklists to verify readiness and identify potential issues before migration begins.

## 2. Configure continuous data synchronization

1. **Set up replication tools for continuous synchronization.** Replication tools mirror data changes in near real-time and maintain consistency between source and target systems. Use tools compatible with your workload type such as Azure Database Migration Service, Azure Migrate, or third-party solutions. Select tools that support your specific database type and replication requirements.

2. **Perform an initial full data synchronization.** Initial synchronization establishes a consistent baseline for ongoing replication. Transfer the complete dataset to Azure to create a foundation for continuous updates. Monitor the synchronization process to ensure completion and verify data integrity.

3. **Maintain synchronization of ongoing changes.** Change synchronization captures all new data changes while the source system remains operational. Keep replication active to ensure the Azure environment reflects the most current state. Monitor replication lag and resolve any synchronization issues promptly.

## 3. Prepare for final cutover

1. **Block new write operations to the source system.** Write blocking prevents data divergence during the final synchronization phase. Temporarily disable write access to ensure no new changes occur while completing the migration. Communicate the maintenance window to users and stakeholders in advance.

2. **Perform a final synchronization.** Final synchronization captures any remaining changes and ensures the Azure environment reflects the most recent state. Verify that all pending transactions are complete and all data is synchronized. This step is critical for maintaining data integrity during the cutover.

3. **Start the workload in Azure.** Azure workload startup marks the beginning of production operations in the cloud environment. Bring the application or service online and monitor system health to confirm readiness. Validate that all services start correctly and perform initial health checks.

## 4. Validate the migrated workload before redirecting user traffic

Conduct rapid functional validation of the migrated application in the Azure environment before making it available to users. This validation confirms the workload functions correctly and meets performance expectations, preventing issues after users begin accessing the system. After successful validation, redirect user traffic to the Azure environment by updating DNS records and load balancer configurations to complete the cutover process.

## 5. Redirect user traffic to Azure

1. **Redirect users to the new workload.** After successful validation, redirect user traffic to the Azure environment by updating DNS records and load balancer configurations to complete the cutover process.

1. **Consider gradual cutover.** A gradual cutover reduces risk by gradually shifting a percentage of users to the Azure environment while maintaining fallback capabilities. For detailed guidance, see [Gradual cutover to Azure](./onpremises-azure-gradual-cutover.md).

1. **Validate continuous service availability during traffic transition.** Service availability monitoring ensures that online migration maintains the near-zero downtime objective throughout the cutover process. Use Azure tools to monitor user access patterns, response times, and error rates during the transition period. Implement automated health checks and readiness probes to confirm that the Azure environment handles production traffic without degradation. Azure Monitor provides real-time insights into application performance and infrastructure health. Configure metrics such as response times, error rates, and throughput to detect anomalies during the cutover. Set up alerts to notify stakeholders of any deviations from expected performance.

## 6. Validate the workload after online migration cutover

1. **Perform real-time data consistency verification during active operation.** Data consistency validation confirms that online migration preserved data integrity throughout the continuous synchronization process. This verification provides confidence that the workload operates correctly in Azure without data loss or corruption. Use automated consistency checks, transaction log analysis, and parallel validation queries to confirm data accuracy while the system remains operational.

2. **Confirm migration success only after continuous operation validation.** Complete validation ensures that the online migration met near-zero downtime requirements and that all stakeholders agree the workload is stable. This confirmation prevents premature success declarations that could overlook critical issues in production. Validate that replication lag remained within acceptable thresholds, that no data was lost during cutover, and that all business processes continue without interruption.

## 7. Maintain synchronized fallback environment for immediate rollback

Immediate rollback capabilities are essential for online migrations that require near-zero downtime guarantees. Keep the source environment fully operational and synchronized to enable instant failback within minutes if issues arise. You must maintain real-time replication, application readiness, and network connectivity to support seamless traffic redirection without service interruption.

## 8. Support workload during stabilization

1. **Implement hypercare support with escalation procedures.** Around-the-clock support ensures continuous availability for mission-critical workloads during stabilization. Establish clearly defined escalation paths and response time commitments to address issues promptly. Deploy experienced engineers who understand the workload architecture and can make critical decisions quickly. Define specific SLAs for different severity levels, such as 15-minute response times for critical issues that affect system availability.

1. **Deploy real-time health monitoring with automated alerting.** Proactive monitoring detects issues before they impact users and enables preventive action for mission-critical systems. Implement comprehensive health models that monitor application performance, infrastructure metrics, and business-critical transactions. Configure automated alerts for deviations from baseline performance or availability thresholds. Use Azure Monitor, Application Insights, and custom health endpoints to provide continuous visibility into system health and trigger immediate notifications for anomalies. For monitoring guidance, see [Monitor Azure](/azure/cloud-adoption-framework/manage/monitor).

1. **Execute continuous performance validation and capacity monitoring.** Continuous monitoring ensures that mission-critical workloads maintain performance standards under varying load conditions during stabilization. Monitor key performance indicators, response times, and throughput metrics continuously. Implement load testing and stress testing to validate system behavior under peak conditions. Use Azure Monitor metrics and custom dashboards to track performance trends and identify capacity constraints before they impact users.

1. **Document all incidents and establish root cause analysis procedures.** Detailed incident tracking and analysis prevent recurrence and improve system reliability for mission-critical workloads. Create comprehensive incident reports that capture timeline, impact, resolution steps, and root cause analysis. Establish post-incident review processes to identify improvements and update operational procedures. Maintain a knowledge base of known issues and solutions to accelerate future problem resolution.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Infrastructure as Code | [Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview) | Define and deploy Azure infrastructure consistently |
| Infrastructure as Code | [Azure Bicep](/azure/azure-resource-manager/bicep/overview) | A domain-specific language for deploying Azure resources declaratively |
| Infrastructure as Code | [Terraform on Azure](/azure/developer/terraform/) | Open-source tool for provisioning and managing Azure infrastructure |
| Migration | [Azure Migrate](/azure/migrate/migrate-overview) | Central hub for discovering, assessing, and migrating workloads to Azure |
| Migration | [Azure Database Migration Service](/azure/dms/dms-overview) | Migrate databases to Azure with minimal downtime |
| Monitoring | [Azure Monitor](/azure/azure-monitor/overview) | Collect, analyze, and act on telemetry data from Azure resources |
| Identity | [Microsoft Entra ID](/entra/fundamentals/whatis) | Manage user identities and access to Azure resources |

## Next steps

> [!div class="nextstepaction"]
> [Optimize workload after migration](./optimize-workloads-after-migration.md)
