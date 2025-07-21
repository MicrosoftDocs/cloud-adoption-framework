---
title: Execute migration to loud
description: Execute migration to cloud with structured guidance for both offline and online migration approaches, including stakeholder communication, environment preparation, data migration execution, validation, and post-migration support.
author: stephen-sumner
ms.author: pnp
ms.date: 08/01/2025
ms.topic: conceptual
---

# Execute migration to cloud

This article provides structured guidance for executing successful migration to Azure. The guidance covers both near-zero downtime and planned downtime approaches to accommodate different business requirements.

## Prepare stakeholders for migration

Stakeholder preparation ensures coordinated execution and rapid issue resolution during migration. Clear communication and resource allocation reduce business disruption and improve migration success rates. You should establish communication protocols and confirm support availability before beginning migration activities.

1. **Distribute a detailed migration schedule to all stakeholders.** A comprehensive schedule creates clarity and alignment across the organization. Create and distribute a document that specifies migration timing, expected service impacts, user responsibilities, and contingency plans. Include contact information for the migration team and support resources. This preparation prevents misunderstandings and reduces business disruption during the migration window.

2. **Confirm technical support availability throughout the entire migration window.** Dedicated technical resources enable immediate response to issues that emerge during migration. Schedule specific technical staff with relevant expertise to be on-call during the entire migration period. Establish clear escalation paths with response time expectations for critical issues. This support structure reduces resolution time for problems that could affect migration success or business operations.

3. **Conduct a pre-migration readiness review with all support teams.** A readiness review confirms that all teams understand their roles and have necessary access. Hold a meeting with representatives from each support team to review the migration plan, verification procedures, and rollback criteria. Verify that support teams have appropriate system access and monitoring tools configured. This preparation ensures coordinated response to any issues that arise during migration.

## Implement a change freeze

A change freeze prevents modifications that could disrupt migration success. System stability reduces migration risks and ensures data consistency. You should implement controls to prevent changes to source systems during the migration window.

1. **Implement automated change controls in deployment pipelines.** Automated controls prevent unauthorized changes to production systems. Configure deployment pipelines to block releases to the source environment during the freeze window. Add approval gates in your CI/CD tools to enforce the freeze period. These controls prevent accidental deployments that could affect migration.

2. **Document emergency change procedures.** Emergency procedures enable critical fixes while maintaining migration stability. Create specific criteria for emergency changes and define an expedited approval process. Include contact information for approvers and document required testing. These procedures balance system stability with business continuity requirements.

3. **Monitor for unauthorized changes.** Change detection ensures freeze compliance throughout the migration window. Configure alerts for file system modifications, database schema changes, and application deployments. Use configuration management tools to track system state. This monitoring prevents undocumented changes from affecting migration success.

## Finalize the production environment

Production environment preparation ensures consistency, security, and operational readiness for the migrated workload. This preparation reduces configuration drift and provides a validated foundation for your workload. You should create production resources using infrastructure-as-code templates and apply production-grade configurations.

1. **Create production resources using infrastructure-as-code templates.** Infrastructure-as-code ensures consistent and repeatable deployments across environments. This approach reduces configuration errors and provides version control for infrastructure changes. Use Azure Resource Manager templates, Bicep, or Terraform to deploy resources with standardized configurations.

2. **Apply production-grade configurations to Azure resources.** Production configurations establish security, performance, and compliance baselines that protect your workload and meet organizational requirements. Configure network security groups with restrictive rules that allow only necessary traffic between services. Apply firewall rules that block unauthorized access while enabling required communication paths. Set up identity and access management controls that follow the principle of least privilege. Provision your database in Azure with the correct version and configure user accounts, roles, and permissions required for replication. Configure network access controls and firewall rules to secure database connections. These configurations create a secure foundation for your migrated workload.

3. **Verify that all services are running correctly.** Service verification ensures that the Azure infrastructure can support the migrated workload. This verification identifies potential issues before they affect the migration process. Check service health status, resource creation completion, and service-specific health checks.

4. **Confirm network connectivity is established.** Network connectivity validation ensures that all required communication paths are functional. This validation prevents connectivity issues that could disrupt the migration or application functionality. Test network connectivity between all required services and validate DNS resolution for critical endpoints.

## Execute cutover

Migration execution transfers workload data and operations from the source environment to Azure. The following steps provide a standardized approach that prioritizes near-zero downtime while accommodating scenarios that can tolerate planned downtime. You should adapt these steps based on your specific downtime requirements and workload characteristics. See the [data migration tools](#azure-tools-and-resources).

### Execute near-zero downtime migration

1. **Establish database replication.** Configure your database platform's native replication feature to establish continuous data replication between your source and Azure target system. Verify that initial data synchronization completes successfully and that replication is healthy.

2. **Monitor replication lag.** Monitor the lag in replication using your database platform's monitoring tools. Higher latency increases cutover risk and duration. Don't proceed to the next step until replication lag is zero.

3. **Migrate unstructured data and files during stable replication.** Copy unstructured data and files to Azure before the final cutover. Use [Tools for object and file migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) with features to transfer files to the appropriate Azure storage services. This preparation reduces the amount of data that needs to be copied during the final cutover.

4. **Pause write operations during final synchronization window.** Coordinate with application teams to stop write operations or enable read-only mode during predetermined maintenance windows. This step prevents data inconsistencies during the final cutover. Schedule this pause during a low-traffic period and communicate the timeline to all stakeholders. If you don't pause write operations, you increase the risk of data loss.

5. **Complete final data synchronization.** Complete final synchronization of any data modified after pausing writes using AzCopy or similar tool. Verify no pending transactions remain on the source systems and database replication is completely caught up.

6. **Validate data integrity and workload functionality.** Database row counts can be compared for a quick check but for deeper validation, checksums and hash functions are preferred. For file systems, use MD5 hash functions and validate file counts, sizes, and timestamps. Verify critical workload functionality including authentication and core transactions.

7. **Direct traffic to the new Azure workload.** Update DNS records and load balancer configurations to direct user traffic to the Azure environment. Monitor workload health and performance.

8. **Conduct comprehensive post-cutover validation and monitoring.** Perform end-to-end functional testing of all critical business processes using automated test suites. Validate data accuracy using checksum verification and hash function comparisons between source and target systems. Have application owners confirm that all major functions operate correctly. Monitor system performance, error rates, and user access patterns for the first 24-48 hours after cutover to identify any performance degradation or functionality issues.

### Execute migration with downtime

1. **Stop all write operations to the source system.** This step ensures no new transactions occur during migration. Confirm that all transactions are complete and that users are locked out before proceeding.

2. **Migrate all data to Azure.** Copy databases, files, and object storage to Azure. Use tools such as Azure Migrate, AzCopy, or Azure Database Migration Service (DMS) depending on the data type and volume. See the [data migration tools](#azure-tools-and-resources).

3. **Validate data integrity after migration.** Perform checksums, row counts, and metadata comparisons to confirm data accuracy. Use automated tools where available to reduce manual effort and increase reliability.

4. **Test the application in the Azure environment.** Run end-to-end tests to confirm that the application functions correctly with the migrated data. Include reporting, integrations, and backup validation.

5. **Direct traffic to the new Azure workload.** Update DNS, load balancers, and application configurations to point to Azure. Monitor for connectivity issues and confirm successful redirection.

6. **Validate workload functionality after cutover.** Perform final checks to ensure the application is stable and data is accurate. Engage application owners to verify business-critical functions.

## Maintain fallback option

Retain the source environment as a fallback option. Source environment retention enables quick reversion if critical issues occur that can't be resolved within acceptable timeframes. This fallback option provides business continuity insurance during the stabilization period. Keep the source environment available and maintain the ability to revert DNS records and restore previous configurations if needed.

## Validate migration success

Post-migration validation ensures that the workload operates correctly and meets all requirements. This validation confirms that data integrity is maintained and that the migration was successful. You should conduct comprehensive validation before declaring the migration complete.

1. **Confirm successful user access and system performance.** User access validation ensures that the transition to Azure is transparent and that performance meets expectations. This confirmation validates that users can access the system without disruption. Monitor user access patterns, system performance metrics, and error rates during the initial post-migration period.

1. **Announce migration success only after thorough validation.** Complete validation ensures that all stakeholders confirm the workload is stable and functional. This confirmation prevents premature declarations of success that could lead to issues later. Obtain confirmation from application owners, testers, and business stakeholders that the workload meets all requirements and operates correctly.

## Support workload during stabilization

Enhanced support coverage ensures rapid response to post-migration issues during the critical stabilization period. This support provides faster resolution of issues that commonly occur after migration. You should establish dedicated support models and update operational documentation.

1. **Establish enhanced support coverage during the stabilization period.** Dedicated support models ensure rapid response to post-migration issues during the critical stabilization period. This support provides faster resolution of issues that commonly occur after migration. Assign experienced IT staff or migration partners to monitor the workload closely and provide shorter SLAs than normal operations.

2. **Update configuration management and inventory systems.** Configuration management updates ensure that operational tools and processes reflect the new Azure environment. This maintenance keeps operational documentation current and supports ongoing management activities. Update configuration management databases (CMDB) for the new hosting environment, assuming that existing inventory tools update IP addresses, CPU, memory, and other infrastructure details automatically.

## Azure tools and resources

| Source | Tool | Description |
|--------|------|-------------|
| Multiple | [Database migration guides](/data-migration/) | Guides for different database platforms, sources, and targets |
| Multiple | [Tools for object and file migration](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) | A comparison of different tools |
| Other clouds | [AWS and Google Cloud to Azure](/azure/migration/migrate-to-azure) | Guides for migrating from AWS and Google Cloud to Azure |
| On-premises | [Azure Database Migration Service](/azure/dms/dms-overview) | Fully managed service for migrating databases to Azure with minimal downtime |
| On-premises | [Azure Migrate](/azure/migrate) | Comprehensive migration service for discovering, assessing, and migrating workloads to Azure |
| On-premises | [Azure Data Box](/azure/databox/data-box-overview) | Send terabytes of data into and out of Azure |
| Google Cloud | [Google Cloud Storage Transfer Service](https://cloud.google.com/storage-transfer-service) | Transfers data to and from various clouds or on-premises environments |
| Google Cloud | gsutil | Google Cloud command-line tool for managing Cloud Storage |
| AWS | [AWS Data Transfer Service](https://aws.amazon.com/datasync/) | Transfers data between on-premises and AWS storage services |
| AWS | AWS CLI | Amazon Web Services command-line interface for managing AWS services |
| Multiple | [Java migration guides](/azure/developer/java/migration/migration-overview) | Guides for migrating Java apps to Azure |
| On-premises | [VMWare](/azure/migrate/tutorial-discover-vmware) | Guides for migrating VMWare to Azure |
| On-premises | [Hyper-V](/azure/migrate/tutorial-discover-hyper-v) | Guides for migrating Hyper-V to Azure |

## Next steps

> [!div class="nextstepaction"]
> [Optimize workloads after migration](./optimize-workloads-after-migration.md)
