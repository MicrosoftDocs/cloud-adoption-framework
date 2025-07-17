---
title: Execute workload migration cutover
description: Execute workload migration cutover to Azure with structured guidance for both offline and online migration approaches, including stakeholder communication, environment preparation, data migration execution, validation, and post-migration support.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Execute workload migration

This article provides guidance on executing the final workload cutover to Azure, ensuring minimal downtime and successful transition of your applications and data to the cloud environment.

## Notify stakeholders of the migration schedule and requirements

Stakeholder communication ensures that all affected parties understand the migration timeline and their responsibilities. This communication prevents confusion and ensures support teams are available during critical periods. You should communicate the schedule to IT staff, application owners, and end users as needed.

1. **Confirm that support teams are on standby during the cutover window.** Support team availability ensures rapid response to issues during the critical transition period. This availability reduces the time to resolve problems that could impact business operations. Schedule dedicated support resources for the cutover window and establish escalation procedures for critical issues.

2. **Implement a change freeze on the source system.** Change freeze prevents new modifications that could complicate the migration process or create data inconsistencies. This freeze ensures a stable baseline for the migration. Communicate the freeze period to all stakeholders and establish approval processes for emergency changes only.

## Deploy and configure the production environment

Production environment preparation ensures consistency, security, and operational readiness for the migrated workload. This preparation reduces configuration drift and provides a validated foundation for your workload. You should provision production resources using infrastructure-as-code templates and apply production-grade configurations.

1. **Provision production resources using infrastructure-as-code templates.** Infrastructure-as-code ensures consistent and repeatable deployments across environments. This approach reduces configuration errors and provides version control for infrastructure changes. Use Azure Resource Manager templates, Bicep, or Terraform to deploy resources with standardized configurations.

2. **Apply production-grade configurations.** Security configurations with production SKUs. Apply production security settings protect your workload from threats and ensure compliance with organizational policies. These configurations establish the foundation for secure operations in Azure. Configure network security groups, firewall rules, and identity access controls according to your security requirements.

## Validate Azure services operational status

Service validation confirms that the target environment is ready to receive the migrated workload. This validation prevents migration failures due to infrastructure issues. You should verify that all provisioned services are running correctly before proceeding with data migration.

1. **Verify that all provisioned services are running correctly.** Service verification ensures that the Azure infrastructure can support the migrated workload. This verification identifies potential issues before they impact the migration process. Check service health status, resource provisioning completion, and service-specific health checks.

2. **Confirm network connectivity is established.** Network connectivity validation ensures that all required communication paths are functional. This validation prevents connectivity issues that could disrupt the migration or application functionality. Test network connectivity between all required services and validate DNS resolution for critical endpoints.

3. **Validate environment readiness through pre-cutover validation scripts.** Validation scripts confirm that the target environment meets all requirements before migration begins. This validation prevents migration failures due to infrastructure issues. Run automated tests to validate things like, resource availability and security configurations.

## Execute data migration

Data migration execution transfers your workload data from the source environment to Azure. Offline migrations provide simplicity and decreased risk of data loss with planned downtime. Online migrations maintain provide near-zero downtime through continuous data synchronization. Both approaches require precise execution and validation to ensure successful outcomes.

### Execute offline migration

Offline migration stops the source system completely to prevent data changes during transfer. This approach provides the highest data integrity but requires extended downtime. Use offline migration when complete data consistency is required and planned downtime is acceptable.

1. **Stop the source datastore to prevent changes.** Source system shutdown eliminates data corruption risk by ensuring no new transactions occur during migration. This shutdown provides a clean cutoff point for data consistency. You should follow documented shutdown procedures to stop database services gracefully, verify transaction completion, and confirm no user access during migration.

2. **Transfer data to Azure using appropriate tools.** Data transfer tools move your database to Azure efficiently and securely. The transfer method depends on your data size and network capabilities. You should use native database replication tools when available. For more tools, see [](./execute-offline-migration-cutover.md#)

3. **Verify the Azure datastore functions correctly.** Data validation confirms that the migrated data loads correctly and all system components function as expected. This validation prevents user access to a non-functional system and ensures service reliability. Verify data integrity through row counts and consistency checks, and test critical database functions before proceeding.

4. **Redirect users to the new workload.** Traffic redirection completes the migration by directing users to the new Azure-based system. This step brings the application online and enables business operations to resume in the Azure environment. You should update DNS records or load balancer configurations to point to Azure endpoints, modify application connection strings to use the Azure datastore, and monitor the system for connectivity issues during the transition.

For detailed guidance on offline migration execution, see [Execute offline migration cutover](execute-offline-migration-cutover.md).

### Execute online migration

For an online migration you almost certainly want to use native replication of the DB system in question. Source DB and Target DB  ... Primary and replica.
Online migration:  Create a database in Azure, replicate data from on-prem to Azure. When you decide to cut over, stop writing to the on-prem-primary, kill replication, potentially brief downtime, point your apps/workloads to use the Azure DB

1. **Configure continuous data synchronization between source and target.** Real-time replication mechanisms ensure that the Azure environment remains current with the source system. This synchronization minimizes data loss and reduces the delta during cutover. Set up replication tools for continuous synchronization, perform initial full data synchronization, and maintain synchronization of ongoing changes throughout the migration process.

2. **Prepare for final cutover with controlled sequencing.** Controlled cutover ensures data consistency and minimizes downtime during the transition. This preparation prevents data divergence and ensures a smooth user experience. Block new write operations to the source system, perform a final synchronization to capture remaining changes, and start the workload in Azure.

3. **Validate the workload before redirecting user traffic.** Validation ensures that the migrated workload functions correctly and meets performance expectations. This testing prevents issues after users access the system. Conduct functional and performance testing to validate application behavior, then redirect user traffic to the Azure environment through DNS updates and load balancer configurations.

For detailed guidance on online migration execution, see [Execute online migration cutover](execute-online-migration-cutover.md).

## Validate migration success

Post-migration validation ensures that the workload operates correctly and meets all requirements. This validation confirms that data integrity is maintained and that the migration was successful. You should conduct comprehensive validation before declaring the migration complete.

1. **Validate workload functionality and data integrity.** Data validation confirms that the migration preserved all information and system functionality. This validation provides confidence that the workload operates correctly in Azure. You should have application owners or testers verify that all major functions work on the Azure-hosted system, check for errors, and validate data integrity through row count comparisons, critical reports, or parallel read-only validation using automated testing where possible.

2. **Confirm successful user access and system performance.** User access validation ensures that the transition to Azure is transparent and that performance meets expectations. This confirmation validates that users can access the system without disruption. Monitor user access patterns, system performance metrics, and error rates during the initial post-migration period.

3. **Announce migration success only after thorough validation.** Complete validation ensures that all stakeholders confirm the workload is stable and functional. This confirmation prevents premature declarations of success that could lead to issues later. Obtain confirmation from application owners, testers, and business stakeholders that the workload meets all requirements and operates correctly.

## Maintain fallback option

Retain the source environment as a fallback option. Source environment retention enables quick reversion if critical issues occur that cannot be resolved within acceptable timeframes. This fallback option provides business continuity insurance during the stabilization period. Keep the source environment available and maintain the ability to revert DNS records and restore previous configurations if needed.

## Support workload during stabilization

Enhanced support coverage ensures rapid response to post-migration issues during the critical stabilization period. This support provides faster resolution of issues that commonly occur after migration. You should establish dedicated support models and update operational documentation.

1. **Establish enhanced support coverage during the stabilization period.** Dedicated support models ensure rapid response to post-migration issues during the critical stabilization period. This support provides faster resolution of issues that commonly occur after migration. Assign experienced IT staff or migration partners to monitor the workload closely and provide shorter SLAs than normal operations.

2. **Update configuration management and inventory systems.** Configuration management updates ensure that operational tools and processes reflect the new Azure environment. This maintenance keeps operational documentation current and supports ongoing management activities. Update configuration management databases (CMDB) for the new hosting environment, assuming that existing inventory tools update IP addresses, CPU, memory, and other infrastructure details automatically.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Data Transfer | [AzCopy](https://docs.microsoft.com/azure/storage/common/storage-use-azcopy-v10) | Command-line utility for copying data to and from Azure Storage |
| Data Transfer | [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) | Graphical user interface for managing Azure Storage resources |
| Data Transfer | [Azure Data Box](https://azure.microsoft.com/services/databox/) | Physical device for transferring large amounts of data to Azure |
| Infrastructure | [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/) | Deployment and management service for Azure resources |
| Infrastructure | [Bicep](https://docs.microsoft.com/azure/azure-resource-manager/bicep/) | Domain-specific language for deploying Azure resources |
| Infrastructure | [Terraform](https://www.terraform.io/docs/providers/azurerm/) | Infrastructure-as-code tool for building Azure resources |

## Next steps

> [!div class="nextstepaction"]
> [Execute offline migration cutover](execute-offline-migration-cutover.md)