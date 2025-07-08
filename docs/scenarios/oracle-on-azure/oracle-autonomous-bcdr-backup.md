---
title: Business continuity and disaster recovery considerations for Oracle Autonomous Database@Azure
description: Learn about key migration connectivity design considerations and detailed recommendations for Oracle Database@Azure, including best practices.
author: onursenturk
ms.author: onursenturk
ms.date: 03/07/2025
ms.topic: conceptual
ms.custom: e2e-oracle
---

# Business continuity and disaster recovery considerations for Oracle Autonomous Database@Azure

This article expands on the business continuity and disaster recovery (BCDR) considerations and recommendations described in the  [Azure landing zone design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery). It incorporates the  [Oracle Maximum Availability Architecture (MAA)](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/db-azure1.html#GUID-E8360630-A2B8-4A46-9CBF-56EF0BF8A00F) principles for Oracle Database@Azure by using Oracle Autonomous Database Service. 

The first step to building a resilient architecture for your Oracle databases that run on Oracle Database@Azure is to identify the availability requirements for the solution. It's crucial to establish the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failures, including planned and unplanned events. The RTO defines the maximum downtime that an application or business can tolerate after a disruption. The RPO specifies the maximum duration of data loss that an application or business can tolerate. You should address this prerequisite before you start your BCDR design. After you establish the requirements of your solution, you can design your Oracle Database@Azure environment to align with your RTO and RPO. 

For more information, see the Microsoft Azure Well-Architected Framework's guidelines about how to design a  [DR strategy](https://learn.microsoft.com/en-us/azure/well-architected/reliability/disaster-recovery). 

## Design considerations

- The Oracle Autonomous Database@Azure service is a shared, serverless service that runs on Oracle Exadata Infrastructure within a region. The Exadata Infrastructure is built in a highly available setup by design which runs on a VM cluster and mirrored storage servers. 

- Oracle Autonomous Database@Azure provides HA against database instance and hardware-level failures by default. This architecture aligns with the  [MAA silver level](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/oracle-maximum-availability-architecture-and-oracle-autonomous-database.html#GUID-80E31978-A2B5-4106-9CB8-C8DFD8AA9637). 

- There are two disaster recovery types supported by the platform for Oracle Autonomous Database@Azure: 

1. Backup-based disaster recovery (default option) 

    - Recovery Time Objective (RTO): 1 hour + 1 hour per 5TB of data 

    - Recovery Point Objective (RPO):  

        1 minute (remote backup) / 10 seconds (local backup) 

        More information can be found at  [About Backup-Based Disaster Recovery](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/backup-based-about.html#GUID-282CF7EC-4A3B-4D7F-A7E2-6C91515456E1) 

 2. Autonomous Data Guard 

    - Recovery Time Objective (RTO):  

        2 mins (local peer- in the same region) / 15 mins (remote peer- in the paired region) 

    - Recovery Point Objective (RPO):  

        10s (local peer) / 1 minute (remote peer) 

        More information can be found at  [Autonomous Data Guard Recovery Time Objective (RTO) and Recovery Point Objective (RPO)](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-about.html#GUID-AF736587-4F6D-45C3-9886-7211B0A33745)

- Oracle Autonomous Database@Azure and its core components are limited to the availability region in which you create the instance. To achieve multiregional resiliency, a cross-region DR instance can be created for a paired region for Oracle Autonomous Database@Azure over the Azure Portal. 

The details on the cross-region DR setup can be found here: 

[Create Cross-Region Disaster Recovery (Oracle)](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#ODADB-GUID-18CEC6A2-9026-4BA4-ADA1-C79C2F8B8884) 

- Oracle Autonomous Database@Azure provides Autonomous Data Guard for disaster recovery. Autonomous Data Guard consists of a combination of Data Guard and Fast Start Failover (FSFO) technologies where the failover is initiated automatically in certain scenarios. 

    - Automatic failover is not available for cross-region standby setup, it is only available for local (in the same region) standby peers. Please check  [Cross-Region Autonomous Data Guard Standby](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-about.html#GUID-AF736587-4F6D-45C3-9886-7211B0A33745)

    - Refer to  [Automatic Failover](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-data-guard-auto-failover.html#ADBSB-GUID-ADA480C6-A4E2-4E79-8490-BEEEF2E3383B)  with a Standby Database for the service description detail. 

- Autonomous Data Guard is available with the Data Warehouse and Transaction Processing workload types. Autonomous Data Guard is not available with the JSON and APEX workload types. 

- A local/remote standby database is not available for use as a read-only database. 

- For every Oracle Autonomous Database@Azure instance, you can create up to 1 local standby peer (in the same region of your primary instance) and 1 cross-region standby peer (in the paired region of your primary database instance). 

Refer to the documentation for the paired region mapping 

[Create Cross-Region Disaster Recovery](https://docs.oracle.com/en-us/iaas/Content/database-at-azure-autonomous/odadb-managing-autonomous-database-resources-azure.html#ODADB-GUID-18CEC6A2-9026-4BA4-ADA1-C79C2F8B8884) 

- If the customer's desired region is not within the paired regions, then the customer can raise a ticket to Oracle Support to have the desired region enabled for the standby database via Autonomous Data Guard. 

- While you add a new standby database, the primary database is available for read/write operations. There is no downtime on the primary database. 

- Oracle Autonomous Data Guard features asynchronous redo transport (in maximum performance mode) by default to ensure zero application performance impact for DR scenarios. 

- Before creating a cross-region disaster recovery with Autonomous Data Guard;  
a resource group, VNet and a delegated subnet should be available on the target region. 

- Network connectivity between primary and standby Oracle Autonomous Database@Azure instances is handled through OCI managed network when establishing Autonomous Data Guard. 

## Design Considerations – Backup/Restore 
- There are 2 backup options available for Oracle Autonomous Database@Azure: 

    1. Automatic Backup: 

        Autonomous Database automatic backups are stored in Oracle Cloud Infrastructure Object Storage and are replicated to another availability domain if available. 

        The backups are taken into a service managed bucket with no direct customer access. 

        The backups are Automatically done by the service (60-day full, daily 		incremental, 5 mins archivelog, some optional retention control) 

    2. Long-Term Backup: 
    
        Using the long-term backup feature you can create a long-term backup as a one-time backup or as scheduled long-term backup. You select the retention period for long-term backups in the range of a minimum of 3 months up to a maximum of 10 years.  

- All backups taken and managed by Oracle in Oracle Autonomous Database@Azure are immutable. Immutable backups cannot be deleted or modified. 

- Oracle Autonomous Database@Azure restores and recovers your database to the point-in-time you specify or using the backup you select from a list of backups. 

- If you select Enable cross-region backup replication to disaster recovery peer, it can take between several minutes and several hours to replicate the backups to the remote region, depending on the size of the backups. The backups from last 7 days are replicated. After backups are replicated, when you select Backups under Resources on the peer database, you will see the list of replicated backups. This way will allow you to initiate a restore operation on a peer database. 

- Oracle Autonomous Database@Azure takes scheduled long-term backups automatically according to the schedule you create; one-time, weekly, monthly, or yearly. 

- Autonomous Recovery Service for backups is currently not available for Oracle Autonomous Database@Azure. 

- The automatic backups will be stored within Oracle Object Storage by default, there is currently no option to store the backups within Azure. 

- Oracle Autonomous Database@Azure also provides the option to use Transparent Application Continuity. Transparent Application Continuity (TAC) transparently tracks and records session and transactional state so the database session can be recovered following recoverable outages. By enabling TAC, the application can restore the session state after the database instance completes the failover to the standby instance. 

Refer to  [Configure Application Continuity on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-continuity-configure.html)  for additional information. 


## Design recommendations

- To build a resilient architecture that's tailored to your specific requirements, consider the following BCDR recommendations for Oracle Autonomous Database@Azure. 

- It is highly recommended to create at least one local (within region) and one remote (cross-region) standby instance of for the Oracle Autonomous Database@Azure instances with Autonomous Data Guard to help protect against single-site failures. This setup aligns with the  [MAA gold standard](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/oracle-maximum-availability-architecture-and-oracle-autonomous-database.html#GUID-4617D519-FE8B-4476-9020-74D459688C52). 

- Enabling automatic backups and cross-region backup replication to disaster recovery peer is recommended. 

- When you enable Autonomous Data Guard with a cross-region standby database, the wallets for the primary and the standby specify different database hostnames and use different connection strings. Oracle recommends that applications use the connection string or wallet downloaded from the same region as the primary database. 
If you need to use a single connection string or wallet containing both the primary and the standby database hostnames, you may construct this manually. 

Refer to  [Cross-Region Autonomous Data Guard Notes](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-data-guard-notes.html#GUID-78A76415-4EB9-4412-869F-3130AF7F5C82)  for the additional information. 

## Backup recommendations 

- Apart from the automatic and scheduled long term backups, it is also helpful to take a consistent datapump export of the database to have management of your data. 

- Consider having an export of your data to Azure Blob Storage or Azure Files in a 	defined schedule via datapump. 

For other recommendations, refer to the Oracle documentation for the backup/restore recommendations: 

[Backup and Restore Notes](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/backup-restore-notes.html)

## Other recommendations 

- DR Drills:  Regular DR drills are recommended to test failover and switchover operations to help ensure that your RPO/RTO requirements will be covered in a real disaster scenario. This should be done on all the layers of the application, not just database. 

-  [Configure Application Continuity on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/application-continuity-configure.html)  to seamlessly handle the database outage at the application layer. 

- Real-time data and replication: For active-active environments, consider using  [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/)  for real-time data integration and replication capabilities. It requires application-level awareness to handle conflict resolution effectively. 

## Note 

GoldenGate isn't included in this solution and might incur extra licensing costs. 

## Related resources 

- [Identity and access management for Oracle Database@Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-iam-odaa) 

- [Security guidelines for Oracle Database@Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-security-overview-odaa)

- [Network topology and connectivity for Oracle Database@Azure](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-network-topology-odaa)