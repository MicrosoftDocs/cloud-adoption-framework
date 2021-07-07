---
title: Azure Enterprise Scale Analytics and AI Teams Data Lake Overview
description: Enterprise Scale Analytics and AI Architecture Data Lake Overview
author:  mboswell
ms.author:  mboswell # Microsoft employees only
ms.date: 06/25/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Lake Services Overview

Three [Azure Data Lake Storage Gen2 (ADLS)](/azure/storage/blobs/data-lake-storage-introduction) accounts should be provisioned per [Data Landing Zone](../architecture/../architectures/data-landing-zone.md) in the "data lake services" resource group. As data passes through the different stages of transformation, it should be saved in one of the Data Landing Zone's three data lakes and available for the [data products](../architectures/data-landing-zone-data-products.md) in the lake which serves as the enriched and curated data layer. Data products would consume from the enriched and curated data layer only. These data lake accounts should be deployed into a single resource group.

Azure Data Lake Storage provides:

* Support for fine-grained [Access Control Lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs), protecting data at the file and folder level, which helps enterprises to implement tight security measures around the datasets being stored in this service.
* The data is encrypted at rest and integrates with Azure Active Directory integration for the authentication and authorization. It helps to store the data securely and to implement access controls for the AD users and security groups.

## Data Lake Planning

Structure, governance and security are key aspects which require an appropriate amount of planning relative to the potential size and complexity of your data lake. Consider what data is going to be stored in the lake, how it will get there, it's transformations, who will be accessing it, and the typical access patterns. This will influence the structure of the lake and how it will be organised. Then consider who will need access to which data, and how to group these consumers and producers of data. Planning how to implement and govern access control across the lake will be well worth the investment in the long run.

If your data lake is likely to start out with a few data assets and only automated processes (such as ETL offloading) then this planning phase may a relatively simple task. Should your lake contain hundreds of data assets and have both automated and manual interaction then certainly planning is going to take longer and require more collaboration from the various data owners.

Most people by now are probably all too familiar with the dreaded "data swamp" analogy. Governance and organization is the key to avoiding this situation. Of course, it may be impossible to plan for every eventuality in the beginning, but laying down solid foundations will increase the chance of continued data lake success and business value in the long run.

A robust data catalog system also becomes ever-more critical as the size (number of data assets) and complexity (number of users or departments) of the data lake increases. The catalog will ensure that data can be found, tagged and classified for those processing, consuming and governing the lake.

## The Three Data Lakes

A common design consideration is whether to have single or multiple data lakes, storage accounts and filesystems. The data lake itself may be considered a single logical entity yet it might comprise of multiple storage accounts in different subscriptions in different regions, with either centralized or decentralized management and governance. Whatever the physical implementation (# of data lakes), the benefit of using a single storage technology is the ability to standardize across the organization with numerous ways in which to access the data.

Azure Data Lake Store is a PaaS fully managed service, and having multiple storage accounts or filesystems does not incur any monetary cost until you start to store and access data. There is an administrative and operational overhead associated with each resource in Azure to ensure that provisioning, security and governance (including backups and DR) are maintained appropriately. The question of whether to create one or multiple accounts has no definitive answer, it requires thought and planning based on your unique scenario.

When designing the construction set we came back to our key principle of scale and felt that with a single data lake we were limiting some of this scale from the outset. We have focused on starting off with three data lake accounts which can be added to during your discovery and design phase. Some of the considerations we had were:

* Planning large-scale enterprise workloads may require significant throughput and resources. We considered the various subscription and service quotas. From this we made the decision to split the lake physically across multiple storage accounts.
  * Whilst quotas and limits will be an important consideration, some of these are not fixed and the Azure Storage Product Team will always try to accommodate your requirements for scale and throughput where possible. As of July 2021, here are the published quotas and items to consider:
    * 5 PiB for all regions. These are default limits which normally can be raised through a support ticket.
    * Max request rate 20,000 per second per storage account.
    * Ingress rate 25 Gbps.
    * Storage accounts per subscription 250.
    * Max access & default ACLs per file or folder 32. This is a hard limit hence ACLs should be assigned to groups instead of individual users.
    * See other limits [here](/azure/storage/common/storage-scalability-targets).
* Environment isolation and predictability.Even though ADLS gen2 offers excellent throughput, there are still limits to consider. For example, one may wish to isolate the activities running in the laboratory zone from potential impact on the curated zone, which normally holds data with greater business value used in critical decision making.
* Features and functionality at the storage account level. If you want to make use of options such as lifecycle management or firewall rules, consider whether these need to be applied at the zone or data lake level.
* Whilst there were many good reasons to have multiple storage accounts, one should be careful not to create additional silos. Take care to avoid duplicate data projects due to lack of visibility or knowledge-sharing across the organization. This is even more reason to ensure that a data catalogue, good data governance and project tracking tools are in place.
* Data processing tools and technologies, like ADF and Databricks (Spark) can easily interact with data across multiple lakes so long as permissions have been granted appropriately.

Other areas which you should consider and which are outside the initial design of the constructions set were:

* Regional vs global lakes. Globally distributed consumers or processes on the lake may be sensitive to latency caused by geographic distances and therefore require the data to reside locally. Regulatory constraints or data sovereignty may often prevent data from leaving a particular region. See [Multi-Region Deployments](#multi-region-deployments).

## Multi-Region Deployments

Data Residency rules or the requirement to have data close to a user base will sometimes drive the requirement to create Azure Data Lake accounts in other Azure regions. It is recommended that you create a Data Landing Zone in the region and replicate global data using third-party products, azcopy or Azure Data Factory to copy the deltas between the regions. Thus this would allow local data to remain in region whilst global data could be replicated around for us by Data Product teams.

## Data Lake Access Control Lists Guideline

* Create AD Groups to represent data products, datasets, data integrations or job functions and assign access to AD groups instead of individual users. This method simplifies operations and maintenance tasks because most of the time, as will only add and remove users to and from AD groups. Modifying ACL on files and folders in the data lake should not happen very frequently - typically at the moment of dataset creation.
* The lowest granularity for ACL is the dataset (table name) level which is represented by a folder in the data lake storage.
* It is likely that existing groups in Azure AD are based on organizational structure. However, not all members in the same organizational unit need access to data in the data lake. It's best to define new AD groups based on their data roles and dataset grouping.
* Default ACL on each dataset folder must include Read and Execute permissions. Execute permission is required for users to be able to traverse folder partitions and files under it. Access ACL assigned to an AD group on each dataset folder will include Read and Execute permissions.
* Write permission should be given to a system through managed identity or service principal only because any changes should only be made by an ingestion, transformation, or maintenance process.

See [Understanding access control and data lake configurations in ADLS Gen2](data-lake-access.md#understanding-access-control-and-data-lake-configurations-in-adls-gen2) for further insight on how to best configure this.
