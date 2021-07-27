---
title: Azure enterprise-scale analytics and AI data lake services overview
description: Learn how to configure enterprise-scale analytics and AI architecture data lakes within your data landing zone.
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 07/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data lake services overview

We recommend provisioning three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts within a single resource group, similar to the Data Lake Services resource group described in [Enterprise Scale Analytics and AI Architecture data landing zone](../architectures/data-landing-zone.md). Each of the three data lakes within a data landing zone stores data in one of its three transformation stages: raw data, enriched and curated data, and workspace data. [Data products](../architectures/data-landing-zone-data-products.md) should only consume from the data lake that contains enriched and curated data.

Data Lake Storage Gen2 supports:

* Fine-grained [Access Control Lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs), which protect data at the file and folder level. ACLs help enterprises implement tight security measures around datasets.
* Secure data storage through encryption at rest, which helps store the data securely.
* Access controls for Azure AD users and security groups, through integration with Azure Active Directory (Azure AD) for authentication and authorization.

## Data lake planning

Structure, governance and security are key considerations that require planning commensurate with the size and complexity of each data lake. Consider what data will be stored in a lake, how it will get there, it's transformations, who will be accessing it, and the typical access patterns. This will influence the structure of the lake and how it will be organized. Group consumers and producers of data based on who will need access to which data. Planning how to implement and govern access control across the lake is a worthwhile investment.

If your data lake will contain just a few data assets and only have automated processes (such as ETL offloading), then the planning phase could be a relatively simple task. If your lake will contain hundreds of data assets and have both automated and manual interaction, then planning is going to take longer and require more collaboration from the various data owners.

Most people by now are probably familiar with the dreaded *data swamp* analogy. Governance and organization are key to avoiding this situation. Although it isn't possible to plan for every eventuality at the outset, laying down solid foundations will increase the chance of sustained data lake success and business value.

A robust data catalog system is increasingly critical as the size (number of data assets) and complexity (number of users or departments) of a data lake grows. The catalog will ensure that data can be found, tagged, and classified by those who process, consume, and govern the lake.

## The three data lakes

A common design consideration is whether to have one or more data lakes, storage accounts, and filesystems. Although a data lake is considered a single logical entity, it can contain multiple storage accounts in different subscriptions and regions, with either centralized or decentralized management and governance. Regardless of the number of data lakes, the benefit of using a single storage technology is the ability to standardize across an organization and several ways to access data.

Data Lake Storage Gen2 is a PaaS fully managed service, so multiple storage accounts or filesystems will not incur a monetary cost until you start to store and access data. When planning provisioning, security and governance (including backups and disaster recovery), keep in mind that there is an administrative and operational overhead associated with each resource in Azure. The question of whether to create one or multiple accounts has no definitive answer, and requires thought and planning based on your unique scenario.

Since scalability is a key concept and a single data lake may limit scalability from the outset, we recommend adding three data lake accounts during your discovery and design phase. The following considerations factor into our recommendation:

* Large-scale enterprise workloads generally require significant throughput and resources. Splitting the lake physically across multiple storage accounts helps to stay within the various subscription and service quotas. Following are published quotas as of July 2021 (contact [Azure Support](https://azure.microsoft.com/en-us/support/faq/) to request higher capacity and ingress limits):
  * Maximum storage account capacity for all regions: 5 PiB
  * Maximum requests per second per storage account: 20,000
  * Maximum ingress rate per storage account: 25 Gbps
  * Maximum storage accounts per subscription: 250
  * Maximum *access* and *default* ACLs per file or folder (this is a hard limit so assign ACLs to groups not individual users): 32
  * See [Scalability and performance targets](/azure/storage/common/storage-scalability-targets) for more information on limits.
* Isolation of data environments and predictability. For example, you wish to isolate activities running in the laboratory zone to avoid potential impact on the curated zone, which holds data with greater business value that is used for critical decision making.
* Features and functionality at the storage account level. Consider whether lifecycle management options or firewall rules need to be applied at the data landing zone level or data lake level.
* Whilst there are good reasons to have multiple storage accounts, be careful not to create unnecessary silos. Avoid creating duplicate data projects due to lack of visibility or knowledge-sharing across the organization. Ensure that a data catalog, good data governance and project tracking tools are in place.
* Data processing tools and technologies, such as Azure Data Factory and Azure Databricks (Apache Spark), can easily interact with data across multiple lakes if permissions are appropriately configured.
* Regional vs global lakes. Globally distributed consumers or processes on the lake may be sensitive to latency caused by geographic distances and so require data to reside locally. Regulatory constraints or data sovereignty may require data to remain within a particular region. See [Multiregion deployments](#multiregion-deployments) for more information.

## Multiregion deployments

Data residency rules, or a requirement to have data close to a user base, will sometimes drive the requirement to create Azure data lake accounts in multiple Azure regions. We recommend creating a data landing zone in one region and then replicating global data using third-party products, AzCopy, or Data Factory. In this way, local data can remain in-region whilst global data is replicated across multiple regions.

## Data lake access control list guidelines

* Create Azure AD groups to represent data products, datasets, data integrations, or job functions. Assign access to Azure AD groups instead of individual users. This will simplify operation and maintenance tasks as you'll only add and remove users from Azure AD groups. Modifying ACLs on files and folders in a data lake should happen infrequently, typically only at dataset creation.
* Set the lowest granularity for an ACL at the dataset (table name) level, which is represented by a folder in data lake storage.
* Define new Azure AD groups based on data roles and dataset groupings. Existing Azure AD groups may follow organizational structure, even though not all members in the same organizational unit need access to a data lake.
* Default ACL on every dataset folder must include *read* and *execute* permissions. Execute permission is required for users to be able to traverse a restricted folder and access files under it. Access ACL assigned to an Azure AD group will include read and execute permissions on each dataset folder.
* Only a managed identity or a service principal should grant *write* permission to a system, as changes should only be made by an ingestion, transformation, or maintenance process.

See [Understanding access control and data lake configurations in Azure Data Lake Storage Gen2](data-lake-access.md#understanding-access-control-and-data-lake-configurations-in-adls-gen2) for more information on access control mechanisms.
