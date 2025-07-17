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

## 1. Deploy production environment before migration

1. **Provision production resources by using infrastructure-as-code.** Infrastructure-as-code templates ensure consistency across environments and reduce manual configuration errors. This approach provides version control and repeatable deployments that match your tested design. Use Azure Resource Manager (ARM) templates, Bicep, or Terraform to deploy the same resource definitions used in non-production environments.

2. **Apply production-grade configurations for networking, identity, and access.** Network and security configurations protect your workload and enable integration with dependent systems. These configurations must match your tested design to avoid connectivity issues during cutover. Configure virtual networks, subnets, private endpoints, role-based access control (RBAC), and managed identities with IP ranges, DNS zones, and firewall rules that match your tested design.

3. **Validate the readiness of the production environment.** Environment validation confirms that all services are deployed, accessible, and correctly configured before migration begins. This validation reduces the risk of delays or failures during the cutover. Run pre-cutover validation scripts or checklists to verify that all services are operational and meet your requirements.

## 2. Stop the source datastore to prevent changes

Source system shutdown eliminates data corruption risk by ensuring no new transactions occur during migration. This shutdown provides a clean cutoff point for data consistency. You should follow documented shutdown procedures to stop database services gracefully, verify transaction completion, and confirm no user access during migration.

## 3. Transfer the data to the cloud

1. **Select the appropriate data transfer tool based on your migration scenario.** Use the [data migration guides](/data-migration/) and review common data migration tools:

    | Source | Tool | Description |
    |--------|------|-------------|
    | Any | Native database replication | 
    | On-premises | [Azure Migrate](/azure/migrate/?view=migrate-classic) | Comprehensive migration service for discovering, assessing, and migrating workloads to Azure |
    | On-premises | [Azure Data Box](/azure/databox/data-box-overview) | Send terabytes of data into and out of Azure |
    | On-premises | [Azure Database Migration Service](/azure/dms/dms-overview) | Fully managed service for migrating databases to Azure with minimal downtime |
    | On-premises | [Azure Data Factory](/azure/data-factory/data-factory-tutorials) | Data integration service for creating data-driven workflows and pipelines |
    | On-premises | [AzCopy](https://docs.microsoft.com/azure/storage/common/storage-use-azcopy-v10) | Command-line utility for copying data to and from Azure Storage |
    | On-premises | [SQL Server Migration Assistant (SSMA)](https://docs.microsoft.com/sql/ssma/) | Automates migration from multiple database platforms to SQL Server and Azure SQL |
    | On-premises | [SSMA for Oracle](https://docs.microsoft.com/sql/ssma/oracle/) | Migrates Oracle databases to SQL Server and Azure SQL Database |
    | On-premises | [SSMA for SAP](https://docs.microsoft.com/sql/ssma/sybase/) | Migrates SAP ASE databases to SQL Server and Azure SQL Database |
    | Google Cloud | [Google Cloud Storage Transfer Service](https://cloud.google.com/storage-transfer-service) | Transfers data to and from various clouds or on-premises environments |
    | Google Cloud | gsutil | Google Cloud command-line tool for managing Cloud Storage |
    | AWS | [AWS Data Transfer Service](https://aws.amazon.com/datasync/) | Transfers data between on-premises and AWS storage services |
    | AWS | AWS CLI | Amazon Web Services command-line interface for managing AWS services |

1. **Execute the data transfer using your selected tool.** Data transfer tools include built-in security features such as encryption in transit and authentication mechanisms. Configure monitoring and logging to track transfer progress and identify any issues. Validate data integrity during the transfer process using checksums or other verification methods to ensure complete and accurate data migration.

## 4. Validate the workload in Azure

Perform functional and integration testing. Testing validates that the workload operates correctly in Azure and maintains data integrity. This validation confirms that all system interactions and dependencies function as expected. Test data integrity, application behavior, and system interactions to confirm proper operation.

## 5. Redirect user traffic to Azure

Traffic redirection transitions users to the Azure-hosted workload. Update DNS records, load balancer configurations, and application configurations to point to the Azure environment. Monitor user access patterns and system performance during the transition. This step completes the transition from the source environment to Azure. Update DNS records, connection strings, or endpoint configurations and confirm that users and systems can access the workload without issues.

## 6. Validate the workload after cutover

1. **Verify all major functions and data integrity.** Data validation confirms that the migration was successful and that no data was lost or corrupted. This verification provides confidence that the workload operates correctly in Azure. Use row count comparisons, checksums, critical reports, or parallel read-only modes to validate data and confirm that the system behaves as expected.

2. **Announce migration success only after thorough validation.** Complete validation ensures that all stakeholders agree the workload is stable and functional. This confirmation prevents premature declarations of success that could lead to issues later. Ensure that all stakeholders confirm the workload is stable and meets operational requirements.

## 7. Maintain a fallback option

Keep the source environment available as a fallback option. Source environment retention enables quick reversion if critical issues occur that cannot be resolved within acceptable timeframes. Retain DNS and access configurations to enable quick reversion if needed.

## 8. Support workload during stabilization

A dedicated support model ensures rapid response to post-migration issues during the critical stabilization period. Enhanced support provides faster resolution of issues that commonly occur after migration. You must establish a support model with shorter SLAs for the stabilization period.

Establish a support model with shorter SLAs during the stabilization period. Enhanced support coverage ensures that issues are resolved quickly during the critical post-migration period. Assign experienced IT staff or migration partners to monitor the workload and respond to issues promptly.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Infrastructure-as-code | [Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview) | Define and deploy Azure resources consistently across environments |
| Infrastructure-as-code | [Bicep](/azure/azure-resource-manager/bicep/overview) | A domain-specific language for deploying Azure resources declaratively |
| Infrastructure-as-code | [Terraform](/azure/developer/terraform/overview) | An open-source tool for building, changing, and versioning infrastructure |
| Data transfer | [AzCopy](/azure/storage/common/storage-use-azcopy-v10) | Command-line tool to transfer data to and from Azure Storage |
| Data transfer | [Azure Storage Explorer](/azure/storage/common/storage-explorer) | GUI tool to manage and transfer Azure Storage data |
| Data transfer | [Azure Data Box](/azure/databox/data-box-overview) | Physical device for secure offline data transfer to Azure |

## Next steps

> [!div class="nextstepaction"]
> [Azure migration guide](https://learn.microsoft.com/azure/cloud-adoption-framework/migrate/)
