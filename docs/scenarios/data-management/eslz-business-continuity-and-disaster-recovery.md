---
title: Business continuity and disaster recovery for data management and analytics in Azure
description: Learn how this enterprise-scale scenario can improve business continuity and disaster recovery of data management and analytics in Azure.
author: christophermschmidt
ms.author: chrschm
ms.date: 07/19/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business continuity and disaster recovery for data management and analytics

When you design architecture for a cloud service, consider your availability requirements and how to respond to potential interruptions in the service. An issue could be localized to the specific instance or region-wide. Having plans for both is important. Depending on your recovery time objective and the recovery point objective, you might choose an aggressive strategy for high availability and disaster recovery.

High availability and disaster recovery can sometimes be combined. The two areas have slightly different strategies, especially when it comes to data. To learn more, see the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) and its [reliability principles](/azure/architecture/framework/reliability/principles).

Instead of trying to prevent failures, accept up front that failures can and do happen. Minimize the effects of any single failing component in the lifecycle. Your tolerance for cost, recovery point objective, and recovery time objective determine the type of solution to implement.

## Backup strategies

Many alternative strategies are available for implementing distributed compute across regions. Strategies must be tailored to business requirements and circumstances of your application. At a high level, the approaches fall into the following categories:

- **Backup and restore:** Restore the database application from the last backup copy before the disaster. This approach is commonly used following data corruption or accidental deletion.
- **Redeploy on disaster:** Redeploy the application from scratch at the time of disaster. This approach is appropriate for non-critical applications that don't require a guaranteed recovery time.
- **Warm spare (active/passive):** Create a secondary hosted service in an alternate region. Deploy roles to guarantee minimal capacity. The roles don't receive production traffic. This approach is useful for applications that haven't been designed to distribute traffic across regions.
- **Hot spare (active/active):** Design the application to receive production load in multiple regions. You might configure the cloud services in each region for higher capacity than required for disaster recovery purposes. Instead, you could scale out the cloud services as necessary at the time of a disaster and failover.

  This approach requires investment in application design, but has benefits. It offers low and guaranteed recovery time. There's continuous testing of all recovery locations and efficient usage of capacity. For database applications, this approach includes a load balancer for two databases that synchronize with a single connection point.

## Disaster recovery and high availability for Azure services

The following sections discuss different Azure services.

### Azure Cosmos DB

For an overview of high availability with Azure Cosmos DB, see [How does Azure Cosmos DB provide high availability](/azure/cosmos-db/high-availability).

### Azure Data Factory

Data integrations and data product are likely to have Azure DevOps repositories linked to Azure Data Factory. You can deploy pipelines to another Data Factory with minimal downtime. To use code version control software apart from GitHub and Azure DevOps repo, use the Azure Data Factory SDK to author pipelines and other Azure Data Factory objects.

### Azure Data Lake

Azure Data Lake Storage Gen2 already supports 3x replication to guard against localized hardware failures. Other replication options, such as zone-redundant storage (ZRS) or geo-zone-redundant storage (GZRS), improve high availability. Geo-redundant storage (GRS) and read-access geo-redundant storage (RA-GRS) improve disaster recovery. For high availability, if there's a service interruption, the workload needs access to the latest data as quickly as possible. The workload can switch over to a replicated instance locally or to a new region.

If one of the data landing zones requires geo-redundancy, with Data Lake Storage Gen2, we recommend you geo-replicate your data by using GRS or RA-GRS. Consider ways for the application using Data Lake Storage Gen2 to automatically fail over to the secondary region. You could use monitoring triggers or length of failed attempts. Otherwise, at least send a notification to administrators for manual intervention. Keep in mind that there's trade-off of failing over versus waiting for a service to come back online.

> [!NOTE]
> A storage account which is configured as RA-GRS or any other GRS technology does not qualifies as a response to disaster recovery. Conduct appropriate due diligence in terms of what works best, including a dual load scenario, which copies data into two Azure regions.

Each data landing zone must have a recovery point objective for its data integrations and data products. Each data landing zone must have a defined replication strategy for its use cases.

### Azure Databricks

For an overview of a disaster recovery architecture for Azure Databricks clusters, see [Regional disaster recovery for Azure Databricks clusters](/azure/databricks/scenarios/howto-regional-disaster-recovery).

### Azure Machine Learning

For an overview of high availability with Azure Machine Learning, see [Failover for business continuity and disaster recovery](/azure/machine-learning/how-to-high-availability-machine-learning).

### Azure Key Vault

Azure Key Vault provides features to help you maintain availability and prevent data loss. Back up secrets only if you have a critical business justification. Backing up secrets in your key vault may introduce operational challenges such as maintaining multiple sets of logs, permissions, and backups when secrets expire or rotate. For more information, see [Azure Key Vault backup](/azure/key-vault/general/backup).

Key Vault maintains availability in disaster scenarios. It fails over requests to a paired region without any intervention from a user. For more information, see [Azure Key Vault availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance). As an alternative, you may consider storing secrets and other Key Vault artifacts in a secondary vault with appropriate permissions. This pattern may be suited for applications that require the vault to be in the same region as the application.

### Azure SQL Database

For an overview of business continuity with Azure SQL Database, see [Overview of business continuity with Azure SQL Database](/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview).

### Azure Synapse Analytics

For an overview of business continuity with Azure Synapse Analytics, see [High availability for Azure Synapse Analytics](/azure/cloud-adoption-framework/migrate/azure-best-practices/analytics/azure-synapse).

## Next steps

[Platform automation and Azure DevOps data management and analytics](./eslz-platform-automation-and-devops.md)
