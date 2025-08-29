---
title: Business continuity and disaster recovery for Oracle Autonomous Database@Azure
description: Learn business continuity and disaster recovery considerations and recommendations for Oracle Autonomous Database@Azure, including backup strategies and high availability architecture.
author: onursenturk
ms.author: onursenturk
ms.date: 08/29/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Business continuity and disaster recovery for Oracle Autonomous Database@Azure

This article provides business continuity and disaster recovery (BCDR) guidance for Oracle Autonomous Database@Azure. Organizations use Oracle Autonomous Database@Azure to achieve high availability while simplifying database administration through automated management capabilities.

## Establish your availability requirements

Organizations must define clear recovery objectives before implementing BCDR solutions. Recovery Time Objective (RTO) represents the maximum acceptable downtime after a failure, while Recovery Point Objective (RPO) defines the maximum acceptable data loss. These objectives determine the appropriate BCDR architecture and technologies for your Oracle Autonomous Database@Azure environment.

1. **Define your recovery objectives based on business requirements.** Autonomous Database@Azure supports different availability levels that align with [Oracle Maximum Availability Architecture (MAA)](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/oracle-maximum-availability-architecture-and-oracle-autonomous-database.html#GUID-80E31978-A2B5-4106-9CB8-C8DFD8AA9637) principles. The default configuration provides MAA Silver level protection against instance and hardware failures. Plan your architecture to meet specific RTO and RPO requirements for different failure scenarios.

2. **Plan for regional limitations and cross-region requirements.** Oracle Autonomous Database@Azure operates within a single availability region where you create the instance. Multi-regional resiliency requires additional cross-region disaster recovery instances. Consider geographic distribution requirements for compliance and data residency needs when planning your deployment topology.

## Use Autonomous Data Guard for high availability

Autonomous Data Guard provides automated disaster recovery capabilities for Oracle Autonomous Database@Azure. The solution combines Oracle Data Guard technology with Fast Start Failover to deliver continuous database protection with minimal administrative overhead.

1. **Configure local standby databases for fast recovery.** Create a local standby database within the same region as your primary instance to achieve rapid failover with minimal data loss. Local standby configurations provide automatic failover capabilities with RTO of 2 minutes and RPO of 10 seconds. This configuration protects against instance-level failures while maintaining optimal performance.

2. **Implement cross-region standby databases for site protection.** Deploy cross-region standby databases in paired Azure regions to protect against regional failures. Cross-region configurations provide RTO of 15 minutes and RPO of 1 minute. Manual failover is required for cross-region scenarios, but the solution ensures business continuity during major outages. For non-paired regions, create a ticket to Oracle Support to enable the desired region for standby database deployment. For details on cross-region disaster recovery setup, see [Create Cross-Region Disaster Recovery (Oracle)](https://docs.oracle.com/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#ODADB-GUID-18CEC6A2-9026-4BA4-ADA1-C79C2F8B8884).

3. **Use supported workload types for Autonomous Data Guard.** Autonomous Data Guard supports Data Warehouse and Transaction Processing workload types. JSON and APEX workload types are not supported with this disaster recovery solution. Evaluate your workload compatibility before implementing Autonomous Data Guard.

4. **Prepare network infrastructure for cross-region deployment.** Ensure resource groups, virtual networks, and delegated subnets exist in target regions before configuring cross-region disaster recovery. Network connectivity between primary and standby instances uses OCI managed networking, which simplifies configuration and management.

## Implement comprehensive backup strategies

Oracle Autonomous Database@Azure provides multiple backup options to meet different recovery requirements. Backup strategies complement high availability solutions and provide protection against data corruption, accidental deletion, and long-term retention needs.

1. **Use automatic backups for operational recovery.** Autonomous Database@Azure performs automatic backups continuously, storing data in Oracle Cloud Infrastructure Object Storage with cross-availability domain replication. Automatic backups include 60-day full backups, daily incremental backups, and 5-minute archive log backups. The backup data is immutable and cannot be deleted or modified by users.

2. **Configure long-term backup retention for compliance.** Create long-term backups using the built-in long-term backup feature for retention periods from three months to 10 years. Schedule long-term backups as one-time operations or recurring schedules (weekly, monthly, yearly) based on compliance and business requirements. Long-term backups provide data protection beyond standard retention periods.

3. **Enable cross-region backup replication for disaster recovery.** Configure cross-region backup replication to disaster recovery regions to enable restore operations during regional outages. Backup replication transfers data from the last seven days and takes several minutes to hours depending on backup size. This capability ensures data availability even when primary regions are unavailable.

4. **Supplement backups with Data Pump exports.** Create consistent Data Pump exports of your database to manage data independently from automatic backups. Export data to Azure Blob Storage or Azure Files on defined schedules to provide additional data protection and migration capabilities. Data Pump exports offer flexibility for data movement and recovery scenarios.

## Configure application continuity

Application continuity ensures minimal disruption to applications during database failover scenarios. Oracle provides transparent application continuity features that automatically handle session recovery and transaction replay during outages.

1. **Enable Transparent Application Continuity for seamless recovery.** Configure [Transparent Application Continuity](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-continuity-configure.html) to track session and transactional state automatically. This feature enables applications to restore session state after database failover to standby instances, minimizing application-level changes required for high availability.

2. **Use appropriate connection strings for multi-region deployments.** Applications should use connection strings or wallets downloaded from the same region as the primary database. When cross-region standby databases are configured, different wallets specify different hostnames. Construct manual connection strings containing both primary and standby hostnames when single connection string requirements exist. For additional information, see [Cross-Region Autonomous Data Guard Notes](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-notes.html#GUID-78A76415-4EB9-4412-869F-3130AF7F5C82).

3. **Test application behavior during failover scenarios.** Verify that applications handle database failover correctly through regular testing. Application continuity reduces but does not eliminate the need for application-level error handling and retry logic.

## Test and validate disaster recovery procedures

Regular testing ensures that BCDR solutions meet defined objectives and identify potential issues before actual disasters occur. Comprehensive testing validates both technical capabilities and operational procedures.

1. **Conduct regular disaster recovery drills across all application layers.** Perform scheduled failover and switchover operations to verify that RTO and RPO requirements are achievable in real scenarios. Test all components of the application stack, not just the database layer, to ensure complete system recovery. Document test results and update procedures based on findings.

2. **Validate backup and restore operations.** Test restore procedures using both automatic backups and long-term backups to verify data integrity and recovery times. Practice point-in-time recovery scenarios to ensure the ability to recover from specific points in time. Regular testing identifies potential issues with backup data before they impact production recovery.

3. **Verify cross-region failover procedures.** Test manual failover procedures for cross-region disaster recovery scenarios to ensure operations teams understand the process and can execute it efficiently. Document step-by-step procedures and maintain current contact information for Oracle Support when assistance is needed.

## Consider additional replication technologies

For specific use cases that require active-active configurations or enhanced replication capabilities, additional Oracle technologies provide advanced data replication and integration features.

1. **Evaluate Oracle GoldenGate for active-active environments.** Consider using [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/) for real-time data integration and replication capabilities when active-active database configurations are required. This solution requires application-level awareness to handle conflict resolution effectively. Oracle GoldenGate is not included in the base Autonomous Database@Azure solution and requires separate licensing.

2. **Plan for conflict resolution in multi-master scenarios.** Design application logic to handle data conflicts that can occur in active-active replication scenarios. Implement business rules and technical controls to ensure data consistency across multiple database instances.

## Azure tools and resources

| Category | Tool | Description |
|----------|------|-------------|
| Documentation | [About Backup-Based Disaster Recovery](https://docs.oracle.com/iaas/autonomous-database-serverless/doc/backup-based-about.html#GUID-282CF7EC-4A3B-4D7F-A7E2-6C91515456E1) | Oracle documentation for backup-based disaster recovery capabilities |
| Documentation | [Autonomous Data Guard RTO and RPO](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-about.html#GUID-AF736587-4F6D-45C3-9886-7211B0A33745) | Detailed RTO and RPO information for Autonomous Data Guard |
| Documentation | [Create Cross-Region Disaster Recovery](https://docs.oracle.com/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#ODADB-GUID-18CEC6A2-9026-4BA4-ADA1-C79C2F8B8884) | Oracle documentation for configuring cross-region disaster recovery |
| Documentation | [Automatic Failover with Standby Database](https://docs.oracle.com/iaas/autonomous-database-serverless/doc/autonomous-data-guard-auto-failover.html#ADBSB-GUID-ADA480C6-A4E2-4E79-8490-BEEEF2E3383B) | Oracle documentation for automatic failover capabilities |
| Documentation | [Configure Application Continuity](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-continuity-configure.html) | Steps to configure application continuity for seamless failover |
| Documentation | [Cross-Region Autonomous Data Guard Notes](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-notes.html#GUID-78A76415-4EB9-4412-869F-3130AF7F5C82) | Additional notes for cross-region Autonomous Data Guard implementation |
| Documentation | [Backup and Restore Notes](https://docs.oracle.com/iaas/autonomous-database-serverless/doc/backup-restore-notes.html) | Comprehensive backup and restore guidance from Oracle |
| Integration | [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/) | Real-time data integration and replication for active-active environments (requires separate licensing) |

## Next steps

> [!div class="nextstepaction"]
> [Network topology and connectivity for Oracle Database@Azure](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-network-topology-odaa)