---
title: Overview of Azure Data Lake Storage for cloud-scale analytics
description: How to use Azure Data Lake Storage for cloud-scale analytics.
author: mboswell
ms.author: mboswell
ms.date: 04/12/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Overview of Azure data lake storage for cloud-scale analytics

The Azure Data Lake is a massively scalable and secure data storage for high-performance analytics workloads. You can create storage accounts with in a single resource group for cloud-scale analytics. It is recommended to provision three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts within a single resource group similar to the `storage-rg` resource group described in the article [cloud-scale analytics architecture data landing zone overview](../architectures/data-landing-zone.md).

Each storage account within a data landing zone stores data in one of the three transformation stages:

- raw data
- enriched and curated data
- development data lakes

With an automated data agnostic ingestion service, a [data application](../architectures/data-landing-zone-data-products.md) can consume enriched and curated data from a storage account. For ingesting data from operational sources, if you don't implement data agnostics engine or facilitate complex connections, you can create a [source aligned data application](../architectures/data-application-source-aligned.md). This data application follows the same flow as a data agnostics engine when ingesting data from external data sources.

Data Lake Storage Gen2 supports fine-grained [access control lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs) that protects data at the file and folder levels. The access control lists help enterprises implement tight security measures for authentication and authorization for data products to:

- store data securely through encryption at rest
- access controls for Azure Active Directory (AAD) users and security groups, through AAD integration

## Data lake planning

The key considerations that require planning for the size and complexity of each data lake are structure, governance, and security.
The structure and organization of a data lake is dependent on the:

- type of data
- data transformation
- data accessibility
- data access patterns

Consumers and producers are grouped based on the need for accessibility and data. It's good to plan implementation and access control governance across the data lake.

Planning of a data lake is easier if the data lake contains a few data assets and automated processes like extract, transform, load (ETL) offloading. Planning takes longer if the data lake:

- contains a large number of data assets with automated and manual interaction
- requires more collaboration with the data owners.

### Data swamp analogy

A data swamp is an un-managed data lake that is almost inaccessible to users. Data swamps occur when the data quality and data governance measures are not implemented. Sometimes a data swamp is seen from a data warehouse with existing hybrid models.

Governance and organization are key to avoid data swamps. When you create a solid foundation, it increases the chance of sustained data lake success and business value.

A robust data catalog system is increasingly critical if the size, number of data assets, complexity, or number of users or departments, of a data lake grows. The catalog will ensure that the users that process, consume, and govern the data lake can find, tag, and classify data.

For more information, see [data governance overview](../govern.md).

## Storage accounts in a logical data lake

A common design consideration is to have a single or multiple storage accounts, and file systems that build the logical data lake. Whatever the number of storage solutions, the benefit of using a single storage technology is the ability to standardize across an organization and several ways to access data.

Data Lake Storage Gen2 is a fully managed platform as a service (PaaS). Multiple storage accounts or file systems can't incur a monetary cost until the data is accessed or stored. It's important to note that there's administrative and operational overhead associated with each Azure resource during provisioning, security, and governance, including backups and disaster recovery. I

> [!NOTE]
>
> Three data lakes are illustrated in each data landing zone. However, depending on your requirements you can consolidate the raw, enriched and curated layers into one storage account. You can keep another storage account called 'development' where consumers of the data can bring other useful data products.

Consider the following factors into a consolidated or three storage account approach:

- Isolation of data environments and predictability
    - For example, you can isolate activities that run in a raw and development zone to avoid potential effect on the curated zone. The curated zone holds data with greater business value that's used for critical decision making.
- Features and functionality at the storage account level
    - You can choose if lifecycle management options or firewall rules must be applied at the data landing zone or data lake level.
    - It's good to create multiple storage accounts, but not create unwanted silos.
    - Avoid duplicate data projects with lack of visibility or knowledge-sharing across the organization.
    - Ensure that a data catalog, good data governance, and project tracking tools are in place.
- Data processing tools and technologies, like Azure Data Factory and Azure Databricks for Apache Spark, can interact with data across multiple lakes based on the configured permissions.
- Regional versus global lakes.
    - Globally distributed consumers or processes on the lake are sensitive to latency caused by geographic distances.
    - Its a good practice to store data locally.
    - Regulatory constraints or data sovereignty requires data to remain in a particular region.
    - For more information, see [multi-region deployments](#multiregion-deployments).

## Multiregion deployments

The Azure data lake account is created in multiple Azure regions when data residency rules and the requirement to have data close to a user base are met.
It's recommended to create a data landing zone in one region and then replicate global data using AzCopy, Azure Data Factory or third-party products. Local data lives in-region while global data is replicated across multiple regions.

## Next steps

[Data lake zones and containers](./data-lake-zones.md)
