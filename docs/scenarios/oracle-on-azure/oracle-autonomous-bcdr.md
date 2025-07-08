---
title: Business continuity and disaster recovery considerations for Oracle Autonomous Database@Azure
description: Learn about key migration connectivity design considerations and detailed recommendations for Oracle Database@Azure, including best practices.
author: onursenturk
ms.author: onursenturk
ms.date: 07/08/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Business continuity and disaster recovery considerations for Oracle Autonomous Database@Azure

This article expands on the business continuity and disaster recovery (BCDR) considerations and recommendations described in the  [Azure landing zone design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery). It incorporates the  [Oracle Maximum Availability Architecture (MAA)](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/db-azure1.html#GUID-E8360630-A2B8-4A46-9CBF-56EF0BF8A00F) principles for Oracle Database@Azure by using Oracle Autonomous Database Service. 

You must identify the availability requirements for your solution to build a resilient architecture for your Oracle databases that run on Oracle Database@Azure. Establish the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failures, including planned and unplanned events. RTO defines the maximum downtime that an application or business can tolerate after a disruption. RPO specifies the maximum duration of data loss that an application or business can tolerate. Address these prerequisites before you start your BCDR design. After you establish your solution requirements, you can design your Oracle Database@Azure environment to align with your RTO and RPO targets. 

For more information, see the Microsoft Azure Well-Architected Framework's guidelines about how to design a  [DR strategy](https://learn.microsoft.com/en-us/azure/well-architected/reliability/disaster-recovery). 

## Design considerations

- The Oracle Autonomous Database@Azure service is a shared, serverless service that runs on Oracle Exadata Infrastructure within a region. The Exadata Infrastructure is built in a highly available setup by design which runs on a VM cluster and mirrored storage servers. 

- Oracle Autonomous Database@Azure provides HA against database instance and hardware-level failures by default. This architecture aligns with the  [MAA silver level](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/oracle-maximum-availability-architecture-and-oracle-autonomous-database.html#GUID-80E31978-A2B5-4106-9CB8-C8DFD8AA9637). 

- There are two disaster recovery types supported by the platform for Oracle Autonomous Database@Azure: 

1. Backup-based disaster recovery (default option) 

    - Recovery Time Objective (RTO): 1 hour + 1 hour per 5TB of data 

    - Recovery Point Objective (RPO):  

        1 minute (remote backup) / 10 seconds (local backup) 

        More information is available at [About Backup-Based Disaster Recovery](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/backup-based-about.html#GUID-282CF7EC-4A3B-4D7F-A7E2-6C91515456E1) 

 2. Autonomous Data Guard 

    - Recovery Time Objective (RTO):  

        2 mins (local peer- in the same region) / 15 mins (remote peer- in the paired region) 

    - Recovery Point Objective (RPO):  

        10s (local peer) / 1 minute (remote peer) 

        More information is available at [Autonomous Data Guard Recovery Time Objective (RTO) and Recovery Point Objective (RPO)](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-about.html#GUID-AF736587-4F6D-45C3-9886-7211B0A33745)

- Oracle Autonomous Database@Azure and its core components are limited to the availability region where you create the instance. To achieve multiregional resiliency, you can create a cross-region disaster recovery instance for a paired region through the Azure Portal.

For details on cross-region disaster recovery setup, see:

[Create Cross-Region Disaster Recovery (Oracle)](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#ODADB-GUID-18CEC6A2-9026-4BA4-ADA1-C79C2F8B8884) 

- Oracle Autonomous Database@Azure provides Autonomous Data Guard for disaster recovery. Autonomous Data Guard combines Data Guard and Fast Start Failover (FSFO) technologies to initiate failover automatically in certain scenarios.

    - Automatic failover is only available for local (same region) standby peers, not for cross-region standby setups. See [Cross-Region Autonomous Data Guard Standby](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-about.html#GUID-AF736587-4F6D-45C3-9886-7211B0A33745)

    - For service description details, see [Automatic Failover](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-data-guard-auto-failover.html#ADBSB-GUID-ADA480C6-A4E2-4E79-8490-BEEEF2E3383B) with a Standby Database.

- Autonomous Data Guard supports Data Warehouse and Transaction Processing workload types. Autonomous Data Guard does not support JSON and APEX workload types.

- Local and remote standby databases do not support read-only access.

- For every Oracle Autonomous Database@Azure instance, you can create up to one local standby peer (in the same region as your primary instance) and one cross-region standby peer (in the paired region of your primary database instance).

For paired region mapping documentation, see:

[Create Cross-Region Disaster Recovery](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#ODADB-GUID-18CEC6A2-9026-4BA4-ADA1-C79C2F8B8884) 

- When your desired region is not within the paired regions, you can create a ticket to Oracle Support to enable the desired region for the standby database via Autonomous Data Guard.

- When you add a new standby database, the primary database remains available for read/write operations. The primary database experiences no downtime.

- Oracle Autonomous Data Guard uses asynchronous redo transport in maximum performance mode by default to ensure zero application performance impact for disaster recovery scenarios. 

- Before creating cross-region disaster recovery with Autonomous Data Guard, ensure that a resource group, virtual network, and delegated subnet are available in the target region.

- Network connectivity between primary and standby Oracle Autonomous Database@Azure instances is handled through OCI managed network when establishing Autonomous Data Guard. 

## Design Considerations - Backup/Restore
- Oracle Autonomous Database@Azure offers two backup options:

    1. Automatic Backup: 

        Autonomous Database automatic backups are stored in Oracle Cloud Infrastructure Object Storage and are replicated to another availability domain if available. 

        The backups are taken into a service managed bucket with no direct customer access. 

        The backups are Automatically done by the service (60-day full, daily 		incremental, 5 mins archivelog, some optional retention control) 

    2. Long-Term Backup: 
    
        Using the long-term backup feature you can create a long-term backup as a one-time backup or as scheduled long-term backup. You select the retention period for long-term backups in the range of a minimum of 3 months up to a maximum of 10 years.  

- All backups taken and managed by Oracle in Oracle Autonomous Database@Azure are immutable. Immutable backups cannot be deleted or modified. 

- Oracle Autonomous Database@Azure restores and recovers your database to a specified point-in-time or using a backup you select from a list of available backups.

- When you enable cross-region backup replication to disaster recovery peer, backup replication to the remote region takes several minutes to several hours, depending on backup size. The service replicates backups from the last 7 days. After backup replication completes, you can view the replicated backups in the Backups section under Resources on the peer database. This capability allows you to initiate restore operations on a peer database.

- Oracle Autonomous Database@Azure creates scheduled long-term backups automatically according to the schedule you define: one-time, weekly, monthly, or yearly.

- Autonomous Recovery Service for backups is currently not available for Oracle Autonomous Database@Azure.

- The automatic backups will be stored within Oracle Object Storage by default, there is currently no option to store the backups within Azure. 

- Oracle Autonomous Database@Azure also provides the option to use Transparent Application Continuity. Transparent Application Continuity (TAC) transparently tracks and records session and transactional state so the database session can be recovered following recoverable outages. By enabling TAC, the application can restore the session state after the database instance completes the failover to the standby instance. 

For additional information, see [Configure Application Continuity on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-continuity-configure.html). 


## Design recommendations

- To build a resilient architecture tailored to your specific requirements, consider the following BCDR recommendations for Oracle Autonomous Database@Azure. 

- It is highly recommended to create at least one local (within region) and one remote (cross-region) standby instance of for the Oracle Autonomous Database@Azure instances with Autonomous Data Guard to help protect against single-site failures. This setup aligns with the  [MAA gold standard](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/oracle-maximum-availability-architecture-and-oracle-autonomous-database.html#GUID-4617D519-FE8B-4476-9020-74D459688C52). 

- Enabling automatic backups and cross-region backup replication to disaster recovery peer is recommended. 

- When you enable Autonomous Data Guard with a cross-region standby database, the wallets for the primary and the standby specify different database hostnames and use different connection strings. Oracle recommends that applications use the connection string or wallet downloaded from the same region as the primary database. 
If you need to use a single connection string or wallet containing both the primary and the standby database hostnames, you may construct this manually. 

For additional information, see [Cross-Region Autonomous Data Guard Notes](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-notes.html#GUID-78A76415-4EB9-4412-869F-3130AF7F5C82). 

## Backup recommendations

- In addition to automatic and scheduled long-term backups, take a consistent Data Pump export of the database to manage your data independently.

- Consider exporting your data to Azure Blob Storage or Azure Files on a defined schedule using Data Pump.

For other recommendations, see the Oracle documentation for backup/restore recommendations:

[Backup and Restore Notes](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/backup-restore-notes.html)

## Other recommendations 

- DR Drills:  Regular DR drills are recommended to test failover and switchover operations to help ensure that your RPO/RTO requirements will be covered in a real disaster scenario. This should be done on all the layers of the application, not just database. 

-  [Configure Application Continuity on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-continuity-configure.html)  to seamlessly handle the database outage at the application layer. 

- Real-time data and replication: For active-active environments, consider using  [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/)  for real-time data integration and replication capabilities. It requires application-level awareness to handle conflict resolution effectively. 

## Note

Oracle GoldenGate is not included in this solution and might incur additional licensing costs. 

## Related resources

- [Identity and access management for Oracle Database@Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-iam-odaa)

- [Security guidelines for Oracle Database@Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-security-overview-odaa)

- [Network topology and connectivity for Oracle Database@Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-network-topology-odaa)