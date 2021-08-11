---
title: Azure enterprise-scale for analytics and AI data lake overview
description: Learn about enterprise-scale for analytics and AI architecture data lake overview
author: mboswell
ms.author: mboswell
ms.date: 07/27/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data management and analytics scenario Azure Data Lake services overview

We recommend you provision three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts within a single resource group, similar to the `data lake services` resource group described in [Azure data management and analytics scenario architecture data landing zone overview](../architectures/data-landing-zone.md). Each of the three data lakes within a data landing zone stores data in one of its three transformation stages: raw data, enriched and curated data, and workspace data. [Data products](../architectures/data-landing-zone-data-products.md) should only consume from the data lake that contains enriched and curated data.

Data Lake Storage Gen2 supports:

- Fine-grained [access control lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs), which protect data at the file and folder level. ACLs help enterprises implement tight security measures around datasets.
- Secure data storage through encryption at rest, which helps store the data securely.
- Access controls for Azure Active Directory (Azure AD) users and security groups, through integration with Azure AD for authentication and authorization.

## Data lake planning

Structure, governance, and security are key considerations that require planning commensurate with the size and complexity of each data lake. Consider what data will be stored in a lake, how it will get there, its transformations, who will be accessing it, and the typical access patterns. These considerations influence the structure of the lake and how it will be organized. Group consumers and producers of data based on who will need access to which data. Planning how to implement and govern access control across the lake is a worthwhile investment.

If your data lake will contain a few data assets and only has automated processes such as extract, transform, load (ETL) offloading, then the planning phase might be an easy task. If your lake will contain hundreds of data assets and have automated and manual interaction, planning will take longer. It will require more collaboration from the various data owners.

You might be familiar with the dreaded *data swamp* analogy. Governance and organization are key to avoid this situation. When you create a solid foundation, it will increase the chance of sustained data lake success and business value.

A robust data catalog system is increasingly critical as the size, or number of data assets, and complexity, or number of users or departments, of a data lake grows. The catalog will ensure that users who process, consume, and govern the lake can find, tag, and classify data.

## The three data lakes

A common design consideration is whether to have a single or multiple data lakes, storage accounts, and file systems. Whatever the number of data lakes, the benefit of using a single storage technology is the ability to standardize across an organization and several ways to access data.

Data Lake Storage Gen2 is a platform as a service (PaaS) fully managed service. Because of this, multiple storage accounts or file systems won't incur a monetary cost until you start to store and access data. When you plan your provisioning, security, and governance, including your backups and disaster recovery, keep in mind that there's administrative and operational overhead associated with each Azure resource. To decide to create one or multiple accounts has no definitive answer. It requires thought and planning based on your unique scenario.

Scalability is a key concept and a single data lake might limit scalability from the outset. We recommend you add three data lake accounts during your discovery and design phase. The following considerations factor into our recommendation:

- Large-scale enterprise workloads generally require significant throughput and resources. Splitting the lake physically across multiple storage accounts helps you stay within the various subscription and service quotas.

  - For more information about limits, see [Scalability and performance targets](/azure/storage/common/scalability-targets-standard-account).

    > [!TIP]
    > Contact [Azure Support](https://azure.microsoft.com/support/faq/) to request higher capacity and ingress limits.

- Isolation of data environments and predictability. For example, if you want to isolate activities that run in the laboratory zone to avoid potential effect on the curated zone. The curated zone holds data with greater business value that's used for critical decision making.
- Features and functionality at the storage account level. Consider whether lifecycle management options or firewall rules must be applied at the data landing zone or data lake level.
- There are good reasons to have multiple storage accounts, but be careful not to create unnecessary silos. Avoid creating duplicate data projects because of lack of visibility or knowledge-sharing across the organization. Ensure that a data catalog, good data governance, and project tracking tools are in place.
- Data processing tools and technologies, like Azure Data Factory and Azure Databricks for Apache Spark, can easily interact with data across multiple lakes if permissions are appropriately configured.
- Regional versus global lakes. Globally distributed consumers or processes on the lake might be sensitive to latency caused by geographic distances. Require data to be stored locally. Regulatory constraints or data sovereignty might require data to remain within a particular region. For more information, see [Multiregion deployments](#multiregion-deployments).

## Multiregion deployments

Data residency rules, or a requirement to have data close to a user base, can drive the requirement to create Azure Data Lake accounts in multiple Azure regions. We recommend you create a data landing zone in one region and then replicate global data using third-party products like AzCopy or Azure Data Factory. Local data remains in-region while global data is replicated across multiple regions.

## Data lake access control list guidelines

- Create Azure AD groups to represent data products, datasets, data integrations, or job functions. Assign access to Azure AD groups instead of individual users. This configuration will simplify operation and maintenance tasks as you'll only add and remove users from Azure AD groups. Modifying ACLs on files and folders in a data lake should happen infrequently, typically only at dataset creation.
- Set the lowest granularity for an access control list (ACL) at the dataset or table name level. A folder can represent this configuration in Data Lake Storage.
- Define new Azure AD groups based on data roles and dataset groupings. Existing Azure AD groups might follow organizational structure, even though not all members in the same organizational unit need access to a data lake.
- Default access control list (ACL) on every dataset folder must include *read* and *execute* permissions. Execute permission is required for users to traverse a restricted folder and access files under it. Access ACL assigned to an Azure AD group will include read and execute permissions on each dataset folder.
- Only a managed identity or a service principal should grant *write* permission to a system. Changes can be made by an ingestion, transformation, or maintenance process.

For more information about access control mechanisms, see [Managing data lake access](./data-lake-access.md).

## Next steps

The next step is to review guidance about data lake zones.

> [!div class="nextstepaction"]
> [Data lake zones](./data-lake-services.md)
