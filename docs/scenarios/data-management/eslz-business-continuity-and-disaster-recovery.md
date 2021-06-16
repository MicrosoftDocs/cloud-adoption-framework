---
title: Azure Enterprise-Scale business continuity and disaster recovery for 'data management and analytics'
description: Describe how this enterprise-scale scenario can improve business continuity and disaster recovery of 'data management and analytics'
author: christophermschmidt
ms.author: chrschm
ms.date: 06/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Business continuity and disaster recovery for 'data management and analytics' Enterprise-Scale scenario

When architecting any cloud service, you must consider your availability requirements and how to respond to potential interruptions in the service. An issue could be localized to the specific instance or even region-wide, so having a plan for both is important. Depending on the recovery time objective (RTO) and the recovery point objective (RPO) SLAs for your workload, you might choose an aggressive strategy for high availability and disaster recovery. 

High availability (HA) and disaster recovery (DR) can sometimes be combined, although each has a slightly different strategy, especially when it comes to data. Microsoft have published guidance using under the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework/) and [Reliability Overview](/azure/architecture/framework/resiliency/overview).

In a cloud world, instead of trying to prevent failures from happening acknowledge up front that failures can and do happen. The goal is to minimize the effects of any single failing component in the lifecycle. Your tolerance for cost, RPO, and RTO will have an impact on the type of solution implemented.

## Backup Strategies
Microsoft has pre-published guidance on building Reliability and Resiliency into applications in the [Reliability Overview](/azure/architecture/framework/resiliency/overview). Some additional considerations are below:

Many alternative strategies are available for implementing distributed compute across regions. These must be tailored to the specific business requirements and circumstances of the application. At a high level, the approaches can be divided into the following categories:

* **Backup and Restore**: In this approach, the database application is restored from the last backup copy before the disaster. This approach is commonly used following data corruption or accidental deletion. 

* **Redeploy on disaster**: In this approach, the application is redeployed from scratch at the time of disaster. This is appropriate for non-critical applications that don't require a guaranteed recovery time.

* **Warm Spare (Active/Passive)**: A secondary hosted service is created in an alternate region, and roles are deployed to guarantee minimal capacity; however, the roles don't receive production traffic. This approach is useful for applications that have not been designed to distribute traffic across regions.

* **Hot Spare (Active/Active)**: The application is designed to receive production load in multiple regions. The cloud services in each region might be configured for higher capacity than required for disaster recovery purposes. Alternatively, the cloud services might scale-out as necessary at the time of a disaster and failover. This approach requires substantial investment in application design, but it has significant benefits. These include low and guaranteed recovery time, continuous testing of all recovery locations, and efficient usage of capacity. For database applications, this includes a load balancer that sits over top of two databases that are kept in sync with a single connection point. This can be implemented in as many levels as required. 


## Data Lake

Data Lake Storage Gen2 already handles 3x replication under the hood to guard against localized hardware failures. Additionally, other replication options, such as ZRS or GZRS, improve HA, while GRS & RA-GRS improve DR. When building a plan for HA, in the event of a service interruption the workload needs access to the latest data as quickly as possible by switching over to a separately replicated instance locally or in a new region.

If one of the Data Landing Zones requires geo-redundancy, with Data Lake Storage Gen2, it is recommended to geo-replicate your data via GRS or RA-GRS that satisfies your HA/DR requirements. Additionally, you should consider ways for the application using Data Lake Storage Gen2 to automatically fail over to the secondary region through monitoring triggers or length of failed attempts, or at least send a notification to admins for manual intervention. Keep in mind that there is trade-off of failing over versus waiting for a service to come back online.

>[!Note]
>A storage account which is configured as RA-GRS or any other GRS technology does not qualifies as a response to DR and customers are encouraged to conduct appropriate due diligence in terms of what works best for them including a "dual load" scenario i.e. copy data into 2 Azure regions respectively.

Each Data Landing Zone must decide on the Recovery Point Objective for their Data Integration(s) and Data Products and defined a replication strategy for their use cases.

## Azure Machine Learning

For an overview of High Availability with Azure Machine Learning, see [Failover for business continuity and disaster recovery](/azure/machine-learning/how-to-high-availability-machine-learning).

### Azure Synapse Analytics

For an overview of business continuity with Azure Synapse Analytics see [High availability for Azure Synapse Analytics](/azure/cloud-adoption-framework/migrate/azure-best-practices/analytics/azure-synapse).

### Azure Databricks

For an overview of a disaster recovery architecture useful for Azure Databricks clusters, and the steps to accomplish that design see [Regional disaster recovery for Azure Databricks clusters](/azure/databricks/scenarios/howto-regional-disaster-recovery).

### Azure SQL Database

For an overview of business continuity with Azure SQL Database, see [Overview of business continuity with Azure SQL Database](/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview).

### Azure Cosmos DB

For an overview of High Availability with Azure Cosmos DB, see [How does Azure Cosmos DB provide high availability](/azure/cosmos-db/high-availability).

### Azure Data Factory

As Data Integrations and Data Product are likely to have Azure DevOps (GitHub or any other code version control software) repositories linked to Azure Data Factory, it is possible to deploy pipelines to another Data Factory with minimal downtime. To use code version control softwares apart from GitHub and Azure DevOps Repo will require developers to use ADF SDK to author pipelines and other Azure data factory objects.

## Azure Key Vault

Azure Key Vault automatically provides features to help you maintain availability and prevent data loss. Back up secrets ([Azure Key Vault Backup](/azure/key-vault/general/backup)) only if you have a critical business justification. Backing up secrets in your key vault may introduce operational challenges such as maintaining multiple sets of logs, permissions, and backups when secrets expire or rotate.

Key Vault maintains availability in disaster scenarios and will automatically fail over requests to a paired region without any intervention from a user. For more information, see [Azure Key Vault availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance). As an alternative, you may consider storing secrets and other AKV artifacts in a secondary key vault with appropriate permissions. Note that this pattern may be suited for applications which require the vault to be co-located in the same region in which the app exists.
