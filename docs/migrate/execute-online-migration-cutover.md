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

A production-ready Azure environment ensures consistency, security, and operational readiness for the migrated workload. Production environments require validated infrastructure and configurations before you initiate the migration. You should provision and validate all necessary components to ensure a smooth transition.

1. **Provision production resources using infrastructure-as-code.** Infrastructure-as-code templates ensure consistency across environments and reduce configuration drift. Use Azure Resource Manager (ARM) templates, Bicep, or Terraform to deploy the same resource definitions used in non-production environments. This approach creates predictable deployments and simplifies troubleshooting.

2. **Apply production-grade configurations for networking, identity, and access.** Production configurations secure the environment and enable seamless integration with dependent systems. Configure virtual networks, subnets, private endpoints, role-based access control (RBAC), and managed identities. Ensure that IP ranges, DNS zones, and firewall rules match the tested design from your non-production environments.

3. **Validate the readiness of the production environment.** Environment validation reduces the risk of delays or failures during the cutover window. Confirm that all services are deployed, accessible, and correctly configured. Run pre-cutover validation scripts or checklists to verify readiness and identify potential issues before migration begins.

## 2. Configure continuous data synchronization

Real-time replication mechanisms ensure that the Azure environment remains current with the source system. Continuous synchronization minimizes data loss and reduces the delta during cutover. You should establish and maintain synchronization throughout the migration process.

1. **Set up replication tools for continuous synchronization.** Replication tools mirror data changes in near real-time and maintain consistency between source and target systems. Use tools compatible with your workload type such as Azure Database Migration Service, Azure Migrate, or third-party solutions. Select tools that support your specific database type and replication requirements.

2. **Perform an initial full data synchronization.** Initial synchronization establishes a consistent baseline for ongoing replication. Transfer the complete dataset to Azure to create a foundation for continuous updates. Monitor the synchronization process to ensure completion and verify data integrity.

3. **Maintain synchronization of ongoing changes.** Change synchronization captures all new data changes while the source system remains operational. Keep replication active to ensure the Azure environment reflects the most current state. Monitor replication lag and resolve any synchronization issues promptly.

## 3. Prepare for final cutover

A controlled cutover ensures data consistency and minimizes downtime during the transition. Precise sequencing prevents data divergence and ensures a smooth user experience. You should follow a specific order to transition users to the Azure-hosted workload.

1. **Block new write operations to the source system.** Write blocking prevents data divergence during the final synchronization phase. Temporarily disable write access to ensure no new changes occur while completing the migration. Communicate the maintenance window to users and stakeholders in advance.

2. **Perform a final synchronization.** Final synchronization captures any remaining changes and ensures the Azure environment reflects the most recent state. Verify that all pending transactions are complete and all data is synchronized. This step is critical for maintaining data integrity during the cutover.

3. **Start the workload in Azure.** Azure workload startup marks the beginning of production operations in the cloud environment. Bring the application or service online and monitor system health to confirm readiness. Validate that all services start correctly and perform initial health checks.

## 4. Validate the workload in Azure

Validation ensures that the migrated workload functions correctly and meets performance expectations. Thorough testing prevents issues after users access the system. You should conduct comprehensive validation before redirecting user traffic.

1. **Conduct functional and performance testing.** Testing validates that all application features, integrations, and performance benchmarks operate as expected. Confirm that dependencies and configurations work correctly in the Azure environment. Run automated tests and manual verification procedures to ensure system readiness.

2. **Redirect user traffic to Azure.** Traffic redirection transitions users to the Azure-hosted workload. Update DNS records, load balancer configurations, and application URLs to point to the Azure environment. Monitor user access patterns and system performance during the transition.

## 5. Confirm migration success

Post-migration validation ensures data integrity and operational readiness. Application owners and testers provide critical validation of system functionality. You should verify that the migrated workload meets all requirements and performs correctly.

1. **Validate workload functionality and data integrity.** Data validation confirms that the migration preserved all information and system functionality. Compare critical reports, perform row count checks, and use validation tools to ensure data consistency. Run the old and new systems in parallel (read-only) if needed to verify accuracy.

2. **Retain the fallback environment.** The fallback environment provides a safety net during the stabilization period. Keep the source system available until you confirm the Azure environment is stable and performs correctly. If issues arise, revert DNS and resume operations on the original system while addressing problems.

## 6. Implement hypercare support

A dedicated support model during the stabilization period ensures rapid issue resolution. Experienced staff monitor and support the workload during the critical post-migration phase. You should assign resources to provide enhanced support during the transition period. Hypercare support provides enhanced monitoring and rapid response during the stabilization period. Assign IT teams or migration partners to monitor the workload closely and provide shorter SLAs. Respond quickly to any issues during the initial post-migration period to maintain system stability.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Infrastructure as Code | [Azure Resource Manager templates](https://learn.microsoft.com/azure/azure-resource-manager/templates/overview) | Define and deploy Azure infrastructure consistently |
| Infrastructure as Code | [Azure Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview) | A domain-specific language for deploying Azure resources declaratively |
| Infrastructure as Code | [Terraform on Azure](https://learn.microsoft.com/azure/developer/terraform/) | Open-source tool for provisioning and managing Azure infrastructure |
| Migration | [Azure Migrate](https://learn.microsoft.com/azure/migrate/migrate-overview) | Central hub for discovering, assessing, and migrating workloads to Azure |
| Migration | [Azure Database Migration Service](https://learn.microsoft.com/azure/dms/dms-overview) | Migrate databases to Azure with minimal downtime |
| Monitoring | [Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/overview) | Collect, analyze, and act on telemetry data from Azure resources |
| Identity | [Microsoft Entra ID](https://learn.microsoft.com/entra/fundamentals/whatis) | Manage user identities and access to Azure resources |

## Next steps

> [!div class="nextstepaction"]
> [Post-migration optimization](post-migration-optimization.md)
