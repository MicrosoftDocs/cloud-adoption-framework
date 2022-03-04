---
title: Overview of Azure Data Lake Storage for the data management and analytics scenario
description: Gain an overview of Azure Data Lake Storage for the data management and analytics scenario.
author: mboswell
ms.author: mboswell
ms.date: 02/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Overview of Azure Data Lake Storage for the data management and analytics scenario

We recommend you provision three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts within a single resource group, similar to the `storage-rg` resource group described in [Azure data management and analytics scenario architecture data landing zone overview](../architectures/data-landing-zone.md). Each of the three storage accounts within a data landing zone stores data in one of its three transformation stages: raw data, enriched and curated data, and workspace data. With an automated data agnostic ingestion service it's likely [Data application](../architectures/data-landing-zone-data-products.md) should only consume from the storage account that contains enriched and curated data. However, as previously stated, in the case where you've chosen not to implement a data agnostics engine, for ingesting once from operational sources, or complex connections aren't facilitated in the data agnostics engine, you would create a [data application that is source aligned](../architectures/data-application-source-aligned.md).

Data Lake Storage Gen2 supports:

- Fine-grained [access control lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs), which protect data at the file and folder level. ACLs help enterprises implement tight security measures around data products.
- Secure data storage through encryption at rest, which helps store the data securely.
- Access controls for Azure Active Directory (Azure AD) users and security groups, through integration with Azure AD for authentication and authorization.

## Data lake planning

Structure, governance, and security are key considerations that require planning commensurate with the size and complexity of each data lake. Consider what data will be stored in a lake, how it will get there, its transformations, who will be accessing it, and the typical access patterns. These considerations influence the structure of the lake and how it will be organized. Group consumers and producers of data based on who will need access to which data. Planning how to implement and govern access control across the lake is a worthwhile investment.

If your data lake will contain a few data assets and only has automated processes such as extract, transform, load (ETL) offloading, then the planning phase might be an easy task. If your lake will contain hundreds of data assets and have automated and manual interaction, planning will take longer. It will require more collaboration from the various data owners.

You might be familiar with the dreaded *data swamp* analogy. Governance and organization are key to avoiding this situation. When you create a solid foundation, it will increase the chance of sustained data lake success and business value.

A robust data catalog system is increasingly critical as the size, or number of data assets, and complexity, or number of users or departments, of a data lake grows. The catalog will ensure that users who process, consume, and govern the lake can find, tag, and classify data.

For more information, see [Data Governance Overview](../govern.md).

## The three storage accounts in a logical data lake

A common design consideration is whether to have a single or multiple storage accounts, and file systems building up the logical data lake. Whatever the number of storage solutions, the benefit of using a single storage technology is the ability to standardize across an organization and several ways to access data.

Data Lake Storage Gen2 is a platform as a service (PaaS) fully managed service. Because of this, multiple storage accounts or file systems won't incur a monetary cost until you start to store and access data. When you plan your provisioning, security, and governance, including your backups and disaster recovery, keep in mind that there's administrative and operational overhead associated with each Azure resource. To decide to create one or multiple accounts has no definitive answer. It requires thought and planning based on your unique scenario.

We recommend you add three storage accounts during your discovery and design phase. The following considerations factor into our recommendation:

- Isolation of data environments and predictability. For example, if you want to isolate activities that run in the laboratory zone to avoid potential effect on the curated zone. The curated zone holds data with greater business value that's used for critical decision making.
- Features and functionality at the storage account level. Consider whether lifecycle management options or firewall rules must be applied at the data landing zone or data lake level.
- There are good reasons to have multiple storage accounts, but be careful not to create unnecessary silos. Avoid creating duplicate data projects because of lack of visibility or knowledge-sharing across the organization. Ensure that a data catalog, good data governance, and project tracking tools are in place.
- Data processing tools and technologies, like Azure Data Factory and Azure Databricks for Apache Spark, can easily interact with data across multiple lakes if permissions are appropriately configured.
- Regional versus global lakes. Globally distributed consumers or processes on the lake might be sensitive to latency caused by geographic distances. Require data to be stored locally. Regulatory constraints or data sovereignty might require data to remain within a particular region. For more information, see [Multiregion deployments](#multiregion-deployments).

## Multiregion deployments

Data residency rules, or a requirement to have data close to a user base, can drive the requirement to create Azure Data Lake accounts in multiple Azure regions. We recommend you create a data landing zone in one region and then replicate global data using AzCopy, Azure Data Factory or third-party products. Local data remains in-region while global data is replicated across multiple regions.

## Next steps

[Data lake zones and containers](./data-lake-zones.md)
