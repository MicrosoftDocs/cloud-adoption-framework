---
title: Execute offline migration cutover
description: Use offline migration to move workloads to Azure with a structured approach that ensures data consistency and minimizes risk during planned downtime.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Execute offline migration cutover

This article helps you execute offline migrations for workloads that can tolerate planned downtime. Offline migration simplifies the migration process by avoiding real-time synchronization and reduces the risk of data inconsistency.

## 1. Deploy and configure the production environment before migration

A production-ready Azure environment ensures consistency, security, and operational readiness for the migrated workload. This deployment approach reduces configuration drift and provides a validated foundation for your workload. You must provision and validate all necessary infrastructure and configurations before you initiate the migration.

1. **Provision production resources by using infrastructure-as-code.** Infrastructure-as-code templates ensure consistency across environments and reduce manual configuration errors. This approach provides version control and repeatable deployments that match your tested design. Use Azure Resource Manager (ARM) templates, Bicep, or Terraform to deploy the same resource definitions used in non-production environments.

2. **Apply production-grade configurations for networking, identity, and access.** Network and security configurations protect your workload and enable integration with dependent systems. These configurations must match your tested design to avoid connectivity issues during cutover. Configure virtual networks, subnets, private endpoints, role-based access control (RBAC), and managed identities with IP ranges, DNS zones, and firewall rules that match your tested design.

3. **Validate the readiness of the production environment.** Environment validation confirms that all services are deployed, accessible, and correctly configured before migration begins. This validation reduces the risk of delays or failures during the cutover. Run pre-cutover validation scripts or checklists to verify that all services are operational and meet your requirements.

## 2. Stop the source workload to ensure data consistency

A clean shutdown of the source workload prevents data changes during migration and avoids corruption or loss. Application-specific shutdown procedures ensure that all processes complete cleanly and no data is left in an inconsistent state. You must follow documented shutdown procedures to ensure a clean shutdown of the source application or service.

## 3. Create and transfer a complete backup of the workload

A complete backup provides a reliable migration source and a recovery point in case of issues. Secure transfer methods protect your data during transit and ensure that all components arrive intact in Azure. You must use secure and supported tools to transfer the backup to Azure.

1. **Create a full backup of all relevant data and configurations.** Complete backups ensure that no critical components are missed during migration. This backup serves as both the migration source and a recovery point if issues occur. Include application data, configuration files, and dependencies in a secure and accessible location.

2. **Transfer the backup to Azure by using secure tools.** Secure transfer tools protect your data during transit and provide reliable delivery to Azure. Choose the appropriate tool based on your data volume, network bandwidth, and security requirements. Use AzCopy, Azure Storage Explorer, or Azure Data Box to transfer the backup securely to Azure.

## 4. Restore and validate the workload in Azure

Backup restoration and validation ensure that the application functions correctly in the new environment. Thorough testing confirms that data integrity is maintained and that all system interactions work as expected. You must perform comprehensive testing before you resume operations.

1. **Restore the backup to the target Azure service or virtual machine.** Proper restoration procedures ensure that all data and configurations are correctly applied in Azure. This step recreates your workload in the target environment with all necessary components. Use the appropriate restore tools and procedures for your specific workload type.

2. **Perform functional and integration testing.** Testing validates that the workload operates correctly in Azure and maintains data integrity. This validation confirms that all system interactions and dependencies function as expected. Test data integrity, application behavior, and system interactions to confirm proper operation.

## 5. Start the workload and redirect users

Bringing the workload online and updating access configurations ensures a smooth transition for users and dependent systems. Close monitoring during this phase helps identify and resolve any issues quickly. You must monitor the system closely during this critical transition period. Proper startup procedures ensure that all components initialize correctly and the system is ready for user access. Monitor startup logs and system health to confirm successful initialization and identify any issues early.

## 4. Validate the workload in Azure

Validation ensures that the migrated workload functions correctly and meets performance expectations. Thorough testing prevents issues after users access the system. You should conduct comprehensive validation before redirecting user traffic.

Testing validates that all application features, integrations, and performance benchmarks operate as expected. Confirm that dependencies and configurations work correctly in the Azure environment. Run automated tests and manual verification procedures to ensure system readiness.

## 5. Redirect user traffic to Azure

Traffic redirection transitions users to the Azure-hosted workload. Update DNS records, load balancer configurations, and application configurations to point to the Azure environment. Monitor user access patterns and system performance during the transition. This step completes the transition from the source environment to Azure. Update DNS records, connection strings, or endpoint configurations and confirm that users and systems can access the workload without issues.

## 6. Validate the workload after cutover

Post-migration validation ensures that the workload is fully functional and that data integrity is maintained. Comprehensive validation by application owners and testers confirms that the migration was successful. You must involve application owners and testers in this validation process.

1. **Verify all major functions and data integrity.** Data validation confirms that the migration was successful and that no data was lost or corrupted. This verification provides confidence that the workload operates correctly in Azure. Use row count comparisons, checksums, critical reports, or parallel read-only modes to validate data and confirm that the system behaves as expected.

2. **Announce migration success only after thorough validation.** Complete validation ensures that all stakeholders agree the workload is stable and functional. This confirmation prevents premature declarations of success that could lead to issues later. Ensure that all stakeholders confirm the workload is stable and meets operational requirements.

## 7. Maintain a fallback option

A fallback environment provides a safety net in case of unexpected issues after migration. Retaining the source environment allows quick reversion if problems occur that cannot be resolved quickly. You must retain the source environment until the Azure system is fully validated and stable.

Keep the source environment available as a fallback option. Source environment retention enables quick reversion if critical issues occur that cannot be resolved within acceptable timeframes. Retain DNS and access configurations to enable quick reversion if needed.

## 8. Support workload during stabilization

A dedicated support model ensures rapid response to post-migration issues during the critical stabilization period. Enhanced support provides faster resolution of issues that commonly occur after migration. You must establish a support model with shorter SLAs for the stabilization period.

Establish a support model with shorter SLAs during the stabilization period. Enhanced support coverage ensures that issues are resolved quickly during the critical post-migration period. Assign experienced IT staff or migration partners to monitor the workload and respond to issues promptly.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Infrastructure-as-code | [Azure Resource Manager templates](https://learn.microsoft.com/azure/azure-resource-manager/templates/overview) | Define and deploy Azure resources consistently across environments |
| Infrastructure-as-code | [Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/overview) | A domain-specific language for deploying Azure resources declaratively |
| Infrastructure-as-code | [Terraform](https://learn.microsoft.com/azure/developer/terraform/overview) | An open-source tool for building, changing, and versioning infrastructure |
| Data transfer | [AzCopy](https://learn.microsoft.com/azure/storage/common/storage-use-azcopy-v10) | Command-line tool to transfer data to and from Azure Storage |
| Data transfer | [Azure Storage Explorer](https://learn.microsoft.com/azure/storage/common/storage-explorer) | GUI tool to manage and transfer Azure Storage data |
| Data transfer | [Azure Data Box](https://learn.microsoft.com/azure/databox/data-box-overview) | Physical device for secure offline data transfer to Azure |

## Next steps

> [!div class="nextstepaction"]
> [Azure migration guide](https://learn.microsoft.com/azure/cloud-adoption-framework/migrate/)
