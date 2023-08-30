---
title: Azure Data Lake Storage
description: How to use Azure Data Lake Storage for cloud-scale analytics.
author: mboswell
ms.author: mboswell
ms.date: 04/12/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Overview of Azure Data Lake Storage for cloud-scale analytics


The Azure Data Lake is a massively scalable and secure data storage for high-performance analytics workloads. You can create storage accounts within a single resource group for cloud-scale analytics. We recommend provisioning three [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) accounts within a single resource group similar to the `storage-rg` resource group described in the article [cloud-scale analytics architecture data landing zone overview](../architectures/data-landing-zone.md).

Each storage account within your data landing zone stores data in one of three stages:

- Raw data
- Enriched and curated data
- Development data lakes

A [data application](../architectures/data-landing-zone-data-products.md) can consume enriched and curated data from a storage account which has been ingested an automated data agnostic ingestion service. You can create a [source aligned data application](../../cloud-scale-analytics/architectures/data-application-source-aligned.md) if you don't implement data agnostics engine or facilitate complex connections for ingesting data from operational sources. This data application follows the same flow as a data agnostics engine when ingesting data from external data sources.

Data Lake Storage Gen2 supports fine-grained [access control lists](/azure/storage/blobs/data-lake-storage-access-control) (ACLs) that protect data at the file and folder levels. Access control lists can help your organization implement tight security measures for authentication and authorization for data products to:

- Store data securely through encryption at rest.
- Access controls for Azure Active Directory (Azure AD) users and security groups through Azure AD integration.

## Data lake planning

When you plan a data lake, always consider appropriate consideration to structure, governance, and security. Multiple factors influence each data lake's structure and organization:

- The type of data stored
- How its data is transformed
- Who accesses its data
- What its typical access patterns are

Group consumers and producers based on their data access needs. It's a good idea to plan implementation and access control governance across your data lake.

If your data lake contains a few data assets and automated processes like extract, transform, load (ETL) offloading, your planning is likely to be fairly easy. If your data lake contains hundreds of data assets and involves automated and manual interaction, expect to spend a longer time planning, as you'll need a lot more collaboration from data owners.

### Data swamp analogy

A data swamp is an un-managed data lake that is almost inaccessible to users. Data swamps occur when you don't implement data quality and data governance measures. You can sometimes see a data swamp in a data warehouse with existing hybrid models.

Proper governance and organization prevent data swamps. When you build a solid foundation for your data lake, it increases your chance of sustained data lake success and business value.

As the size, complexity, number of data assets, and number of users or departments of your data lake grows, it's increasingly critical for you to have a robust data catalog system. Your data catalog system ensures that your users can find, tag, and classify data while they process, consume, and govern your data lake.

For more information, see [data governance overview](../govern.md).

## Storage accounts in a logical data lake

Consider whether your organization needs one or many storage accounts, and consider what file systems you require to build your logical data lake. Single storage technology provides multiple data access methods and helps you standardize across your organization.

Data Lake Storage Gen2 is a fully managed platform as a service (PaaS). Multiple storage accounts or file systems can't incur a monetary cost until data is accessed or stored. Note that each Azure resource has associated administrative and operational overhead during provisioning, security, and governance, including backups and disaster recovery.

> [!NOTE]
>
> Three data lakes are illustrated in each data landing zone. However, depending on your requirements, you might be able to consolidate the raw, enriched and curated layers into one storage account. You can create another storage account called 'development' where data consumers can bring other useful data products.

Consider the following factors when deciding between a consolidated or three storage account approach:

- Isolation of data environments and predictability
    - You might isolate activities that run in the raw and development zones to avoid potential effect on the curated zone, which holds data with great business value that's needed for critical decision making
- Features and functionality at the storage account level
    - You can choose if lifecycle management options or firewall rules must be applied at the data landing zone or data lake level.
    - Create multiple storage accounts, but not unwanted silos.
    - Avoid duplicate data projects from lack of visibility or knowledge-sharing across your organization.
    - Ensure that you have good data governance, project tracking tools, and a data catalog in place.
- Interaction of data processing tools and technologies with data across multiple lakes based on the configured permissions
- Regional versus global lakes
    - Globally distributed consumers or processes on the lake are sensitive to latency caused by geographic distances.
    - Storing data locally is a good practice.
    - Regulatory constraints and data sovereignty can require data to remain in a particular region.
    - For more information, see [multi-region deployments](#multi-region-deployments).

## Multi-region deployments

When dictated by data residency rules or a requirement that you keep data close to a user base, you might need to create Azure Data Lake accounts in multiple Azure regions.
To do this, create a data landing zone in one region, then replicate global data using AzCopy, Azure Data Factory or third-party products. Local data lives in-region, while global data gets replicated across multiple regions.

## Next steps

[Data lake zones and containers](../../cloud-scale-analytics/best-practices/data-lake-zones.md)
