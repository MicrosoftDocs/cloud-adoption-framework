---
title: Business Continuity and Disaster Recovery for Oracle Database@Azure Using Exadata Database Service
description: Learn about business continuity and disaster recovery (BCDR) for Oracle Database@Azure and how to build a resilient architecture for your workload environment.
author: gkayali
ms.author: guherk
ms.date: 01/25/2025
ms.topic: conceptual
ms.custom: e2e-oracle
--- 

# Business continuity and disaster recovery considerations for Oracle Database@Azure

This article expands on the business continuity and disaster recovery (BCDR) considerations and recommendations described in the [Azure landing zone design area](../../ready/landing-zone/design-area/management-business-continuity-disaster-recovery.md). It incorporates the [Oracle Maximum Availability Architecture (MAA)](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/db-azure1.html#GUID-E8360630-A2B8-4A46-9CBF-56EF0BF8A00F) principles for Oracle Database@Azure by using Oracle Exadata Database Service.

The first step to building a resilient architecture for your Oracle databases that run on Oracle Database@Azure is to identify the availability requirements for the solution. It's crucial to establish the recovery time objective (RTO) and recovery point objective (RPO) for different levels of failures, including planned and unplanned events. The RTO defines the maximum downtime that an application or business can tolerate after a disruption. The RPO specifies the maximum duration of data loss that an application or business can tolerate. You should address this prerequisite before you start your BCDR design. After you establish the requirements of your solution, you can design your Oracle Database@Azure environment to align with your RTO and RPO.

For more information, see the Microsoft Azure Well-Architected Framework's guidelines about how to [design a DR strategy](/azure/well-architected/reliability/disaster-recovery).

## Design considerations

- The Oracle Exadata Database@Azure service is available in two different availability zones within a region. This availability helps ensure service reliability and DR. To verify the deployment location of your Oracle Exadata Database@Azure, check your virtual machine (VM) cluster in the Azure portal.

- Oracle Exadata Database@Azure and its core components are limited to the availability zone in which you create the instance. The service doesn't cover multiple zones or span multiple regions. To achieve multiple-zone or multiregional resiliency, you can deploy new Oracle Exadata Database@Azure instances to target availability zones or regions.

- Oracle Exadata Database@Azure provides native Oracle technologies, such as Oracle Real Application Clusters for high availability (HA) and Oracle Data Guard for DR. Data Guard and Active Data Guard are supported for DR architecture.

- Oracle Exadata Database@Azure provides HA against database instance and hardware-level failures by default. This architecture aligns with the [MAA silver level](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/db-azure1.html#GUID-91572193-DF8E-4D7A-AF65-7A803B89E840). Planned maintenance operations can be conducted in a rolling manner. However, a default single-zone architecture has zero fault tolerance against site or regional failures.

- The solution provides automated Data Guard configuration for DR. This setup helps protect from site failures by requiring another Oracle Exadata Database@Azure deployment in a different availability zone or region.

- Network connectivity between primary and standby Oracle Exadata Database@Azure instances can be established via Azure networking and Oracle Cloud Infrastructure (OCI) networking. By default, the primary route for this connectivity is through Azure. 

- The three backup options available for Oracle Exadata Database@Azure are:

  - **OCI-managed backup:** This option includes two integrated solutions, which are Oracle Database Autonomous Recovery Service and Oracle Cloud Infrastructure Object Storage. These solutions are managed via the OCI console.

    Autonomous Recovery Service is designed for enterprise-level mission-critical workloads that have stringent RTO and RPO requirements. It provides availability through service-level agreements. For more information, see [Oracle platform as a service and infrastructure as a service public cloud services pillar document](https://www.oracle.com/us/corporate/contracts/paas-iaas-pub-cld-srvs-pillar-4021422.pdf).

    OCI Object Storage is a general-purpose backup solution that's suitable for workloads that have less stringent RTO or RPO requirements.

    These solutions enable automatic scheduling and management of database backups with a predefined retention period. For more information, see [Manage database backup and recovery on Exadata Database Service on Oracle dedicated infrastructure](https://docs.oracle.com/iaas/exadatacloud/doc/ecs-managing-db-backup-and-recovery.html).

  - **Self-managed backup:** You can configure Oracle Exadata Database@Azure to stream database backups to Azure Storage services, including Azure Blob Storage, Azure Files (via private endpoints), and Azure NetApp Files.

    This option requires manual configuration and ongoing maintenance.

  - **Non-Microsoft backup solutions:** You can use non-Microsoft backup solutions that are available in Azure Marketplace, such as [Commvault](https://documentation.commvault.com/2024e/essential/oracle_database_at_azure.html), to manage and store database backups.

## Design recommendations

To build a resilient architecture that's tailored to your specific requirements, consider the following BCDR recommendations for Oracle Exadata Database@Azure.

You should configure at least two Oracle Exadata Database@Azure instances with Data Guard to help protect against single-site failures. This setup aligns with the [MAA gold standard](https://docs.oracle.com/en/database/oracle/oracle-database/21/haovw/db-azure1.html#GUID-7A38AFBF-0184-46EA-ACB1-1188BBAA2B67).

### Multiple-zone BCDR

The multiple-zone BCDR architecture is recommended for customers who require a zero or near-zero RPO with multiple-zone redundancy while meeting single-region data residency requirements.

This solution includes a secondary Oracle Exadata Database@Azure deployment in a different availability zone within the same region. To ensure resilience against database, cluster, or availability zone failures, implement a standby database located in the secondary instance. This setup provides protection against site-level failures.  

:::image type="content" source="./media/cross-availability-zones.svg" alt-text="Diagram that shows a multiple-zone BCDR architecture for Oracle Exadata Database@Azure Azure landing zone accelerator." lightbox="./media/cross-availability-zones.svg" border="false":::

- **Data Guard redo transport mode:** Configure Data Guard redo transport mode according to your application services and RPO requirements:

  - **Data integrity and zero data loss:** When data integrity and zero data loss are the highest priorities, use Maximum Availability Mode (SYNC). This mode synchronously replicates data to the standby database, which ensures that no data is lost.
  
  - **System performance:** When system performance is critical and a small degree of data loss is acceptable, use Maximum Performance Mode (ASYNC). This mode uses asynchronous replication, which results in an RPO that's slightly greater than zero (or is near zero).

- **Maintain a symmetric standby instance:** You should maintain a symmetric standby instance with resources equivalent to the primary database to ensure consistent performance during switchover and failover operations. Alternatively, you can configure the standby database with minimal resources and scale up the VM cluster dynamically as needed after switchover or failover. However, this approach might add extra time for scaling operations and their reflection at the database level.

- **Automate failover operations:** Use [Oracle Data Guard Fast-Start Failover](https://www.oracle.com/technical-resources/articles/smiley-fsfo.html) to automate failover operation to minimize RTO and reduce errors.

  > [!NOTE]
  > Fast-Start Failover isn't a managed service and requires manual configuration.

    For this setup, extra VMs that run Oracle Data Guard Observers are required to enable Data Guard Fast-Start Failover. These observer VMs monitor the database and replication status, which automates the failover process.

  :::image type="content" source="./media/fast-start-failover.svg" alt-text="A diagram of the Fast-Start Failover architecture for Oracle Database@Azure Azure landing zone accelerator." lightbox="./media/fast-start-failover.svg" border="false":::

  If you require a symmetrical DR architecture if there's a failover, you should position an observer instance at the location where the secondary Oracle Exadata Database@Azure deployment is configured.

### Multiregional BCDR

- For a multiregional BCDR strategy, implement a secondary Oracle Exadata Database@Azure deployment with a standby database located in a different region where the service is available. This setup provides protection against full regional outages.

- Configure Data Guard to replicate asynchronously for regional DR that's based on your application requirements and network latency between your primary and secondary region. For more information, see [Azure network round-trip latency statistics](/azure/networking/azure-network-latency).

  > [!NOTE]
  > Automated Data Guard only allows the Maximum Performance Mode (ASYNC) configuration for cross-region deployments.

:::image type="content" source="./media/gold-cross-region.svg" alt-text="A diagram of multiregional BCDR architecture for Oracle Exadata Database@Azure Azure landing zone accelerator." lightbox="./media/gold-cross-region.svg" border="false":::

- Multiple-zone and multiregional BCDR recommendations focus on database service resiliency. To help ensure overall workload resiliency, consider using Azure services and features such as Azure Virtual Machine Scale Sets, Azure Site Recovery, and Azure Front Door to design robust architecture across availability zones or regions.

### Extended BCDR scenarios

#### Local and remote standby databases

To address requirements for robust service availability and resilience against regional outages, we recommend that you implement multiple standby databases for mission-critical workloads.

A local standby database on an Oracle Exadata Database@Azure deployment resides in a different availability zone within the same region. This setup provides a viable solution for latency-sensitive applications by addressing zero data loss failover requirements through SYNC Data Guard replication. This strategy helps ensure service availability without affecting application throughput or overall response time.

A remote standby database on an Oracle Exadata Database@Azure instance that's located in a different region addresses regional DR requirements.

:::image type="content" source="./media/local-standby.svg" alt-text="A diagram of local and remote standby BCDR architecture for Oracle Exadata Database@Azure Azure landing zone accelerator." lightbox="./media/local-standby.svg" border="false":::

This architecture is ideal for mission-critical workloads and requires a minimum of three Oracle Exadata Database@Azure deployments.

> [!NOTE]
> If a symmetrical configuration is required because of a failover scenario, place an extra standby database on Oracle Exadata Database@Azure in the secondary region, within a different availability zone. 
>

#### Data Guard Far Sync architecture

You can meet the requirement to implement zero data loss replication at any distance by using the Data Guard Far Sync configuration. This approach includes placing a [far sync instance](https://docs.oracle.com/en/database/oracle/oracle-database/19/sbydb/creating-oracle-data-guard-far-sync-instance.html) closer to the primary Oracle Exadata Database@Azure deployment, essentially in another availability zone within the same region, to synchronously send the redo logs. The far sync instance then transfers these logs asynchronously to the standby database that runs in the secondary Oracle Exadata Database@Azure deployment in another region. This setup effectively results in zero data loss replication between regions.

:::image type="content" source="./media/far-sync.svg" alt-text="A diagram of Far Sync BCDR architecture for Oracle Exadata Database@Azure Azure landing zone accelerator." lightbox="./media/far-sync.svg" border="false":::

If you look for a symmetrical DR architecture if there's a failover, place a far sync instance in a separate availability zone where the secondary Oracle Exadata Database@Azure deployment is configured.

> [!NOTE]
> The Far Sync architecture requires an Active Data Guard license and must be manually configured.

### Backup recommendations

If you plan to use backups as your only solution for BCDR requirements, keep in mind that RTO is higher compared to replication scenarios because it's based on database size and the backup methods that you use.

- **Back up data within Azure:** To meet organizational requirements that mandate data and backups remain in Azure, consider the following solutions:

  - **Use Autonomous Recovery Service (ARS) in Azure:** During backup policy configuration, choose to [store backup data in the same cloud provider as the database](https://docs.oracle.com/en/cloud/paas/recovery-service/dbrsu/azure-multicloud-recoveryservice.html) to use the ARS in Azure.
  
  - **Use Storage services:** Use Storage services like Blob Storage, Azure Files, and Azure NetApp Files to mount storage as network file system (NFS) points on the database server and stream Oracle Recovery Manager (RMAN) backups to Storage.

- **Long-term backup retention:** If your organization requires long-term backup retention, you can configure self-managed RMAN backups to Azure Storage.

- **Storage backup configurations:** When backups are configured to Storage services, consider the following recommendations:

  - **Schedule with cron jobs:** Use cron jobs at the database-node level to schedule backups at specific times based on your backup strategy.
  
  - **Replicate backups:** Use underlying storage replication features from Azure like zone-redundant storage and geo-redundant storage to replicate backups.

- **Back up and restore operations:** Manually back up Oracle Exadata Database@Azure VMs to restore critical files if there are accidental deletions or corruptions. For more information, see [Oracle Exadata Cloud Compute node backup and restore operations (document ID 2809393.1)](https://support.oracle.com/knowledge/Oracle%20Cloud/2809393_1.html).  

## Other recommendations

- **Keep data within Azure:** If it's necessary to keep data exclusively within Azure, route Data Guard traffic through the Azure network and configure backups to stay in Azure.

- **Test DR:** Test failover and switchover operations to help ensure that they work in a real disaster scenario.

  - Use [Oracle Fast-Start Failover](https://www.oracle.com/technical-resources/articles/smiley-fsfo.html) to automate failover operations when possible to minimize errors.
  
  - Use [Oracle Application Continuity](https://docs.oracle.com/en/database/oracle/oracle-database/19/racad/ensuring-application-continuity.html#GUID-C1EF6BDA-5F90-448F-A1E2-DC15AD5CFE75) to seamlessly mask the outage at the application layer.

- **Real-time data and replication:** For active-active environments, consider using [Oracle GoldenGate](https://www.oracle.com/integration/goldengate/) for real-time data integration and replication capabilities. It requires application-level awareness to handle conflict resolution effectively.

  > [!NOTE]
  > GoldenGate isn't included in this solution and might incur extra licensing costs.

- **Minimize interruptions:** To minimize interruptions for your workload, schedule planned maintenance during off-peak hours. When you can, use rolling manner updates to ensure a seamless process.

- **Use infrastructure as code (IaC):** For more reliable infrastructure automation, deploy the initial Oracle Exadata Database@Azure instance and VM clusters by using IaC. For more information about Oracle Database@Azure automation, see [QuickStart Oracle Database@Azure with Terraform or OpenTofu modules](https://docs.oracle.com/en/learn/dbazure-terraform/index.html).

  - Use Azure Verified Modules to deploy Oracle Exadata Database@Azure instances and VM clusters. For more information, see the following resources:
  
    - [Oracle Database@Azure - Azure Verified Modules for Oracle Exadata Infrastructure](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudexadatainfrastructure/azurerm/latest)

    - [Oracle Database@Azure - Azure Verified Modules for Oracle Exadata VM Cluster](https://registry.terraform.io/modules/Azure/avm-res-oracledatabase-cloudvmcluster/azurerm/latest)

  - Use IaC to deploy databases in the OCI console. You can use IaC to replicate the same deployment to a DR site and minimize the risk of human error.

## Related resources

- [Identity and access management for Oracle Database@Azure](./oracle-iam-odaa.md)
- [Security guidelines for Oracle Database@Azure](./oracle-security-overview-odaa.md)
- [Network topology and connectivity for Oracle Database@Azure](./oracle-network-topology-odaa.md)
