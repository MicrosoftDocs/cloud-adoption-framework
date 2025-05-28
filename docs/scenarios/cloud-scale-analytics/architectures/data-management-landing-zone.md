---
title: Data Management Landing Zone Overview
description: Learn how to use a data management landing zone to govern your analytics platform, including data governance, lifecycle management, and metadata registration.
author: mboswell
ms.author: mboswell
ms.date: 02/20/2025
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data management landing zone

A data management landing zone is essential for cloud-scale analytics. It oversees the governance of your entire analytics platform.

:::image type="content" source="../images/data-management-overview.svg" alt-text="Diagram of data management landing zone overview." lightbox="../images/data-management-overview.svg" border="false":::

A data management landing zone is a separate subscription that has the same standard Azure landing zone services. It provides data governance through crawlers, which connect to data lakes and polyglot storage in data landing zones. Virtual network peering connects the data management landing zone to the data landing zones and connectivity subscription.

This architecture is a starting point. You can modify it to fit your specific business and technical requirements when you plan your data management landing zone implementation.

> [!NOTE]
> *Polyglot persistence* refers to the practice of using multiple data storage or data store technologies to support your data types and their storage needs. Polyglot persistence means that an application can use more than one core database or storage technology.

> [!IMPORTANT]
> You must deploy your data management landing zone as a separate subscription under a management group that has the appropriate governance. Then you can control governance across your organization. The [Azure landing zone accelerator](../../../ready/landing-zone/index.md#azure-verified-modules-for-platform-landing-zones) describes how you should approach Azure landing zones.

## Data governance

The Azure cloud-scale analytics framework suggests that you use Microsoft Purview. Alternatively, you can deploy non-Microsoft solutions to manage specific data governance functions.

Consider the following key functions in your architecture:

- A global data catalog
- Primary data management
- Data sharing and contracts
- An API catalog
- Data quality management
- A data modeling repository

If you have partner data governance products that require deployment in a subscription, deploy them to the data governance resource group within the data management landing zone.

### Data catalog

[!INCLUDE [data-catalog](../../cloud-scale-analytics/includes/data-catalog.md)]

### Primary data management

Primary data management control resides in the data management landing zone. For specific data mesh considerations, see [Primary data management in data mesh](../../cloud-scale-analytics/architectures/data-mesh-master-data-management.md).

Many primary data management solutions fully integrate with Microsoft Entra ID, which helps secure your data and provide different views for different user groups. For more information, see [Primary data management system](../govern-master-data.md).

### Data sharing and contracts

Cloud-scale analytics uses [Microsoft Entra entitlement management](/entra/id-governance/entitlement-management-overview) or [Microsoft Purview policies](../secure-data-privacy.md) to control access to data sharing. In addition to those features, you might require a sharing and contract repository. This repository is an organizational function and should reside in your data management landing zone. Your contracts should provide information about data validation, models, and security policies.

### API catalog

Your data application teams create various APIs for their data applications, which can be hard to find across your organization. To address this problem, place an API catalog in your data management landing zone.

An API catalog standardizes your documentation, facilitates internal collaboration, and enhances consumption, publishing, and governance controls across your organization.

### Data quality management

Use your existing data quality management practices. To prevent problems from spreading across your analytics and AI systems, manage data quality at the data source.

Integrate quality metrics and validation into your data processes so that the teams most familiar with the data handle quality management. This approach helps ensure that your team has a deeper understanding and better handling of the data assets. Provide data lineage for all data products to improve data quality confidence.

For more information, see [Data quality](../../cloud-scale-analytics/govern-data-quality.md).

### Data modeling repository

Store entity relationship models centrally within your data management landing zone so that data consumers can easily find conceptual diagrams. To model your data products before ingestion, use tools like [ER/Studio](https://erstudio.com/) and [OrbusInfinity](https://www.orbussoftware.com/orbusinfinity).

## Service layer

Your organization might create several automation services to augment cloud-scale analytics capabilities. These automation services drive conformity and onboarding solutions for your analytics state.

If you build these automation services, a user interface should serve as both a data marketplace and an operation console. This interface should rely on an underlying metadata store, such as [metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md).

Your data marketplace or operations console calls a middle tier of microservices to facilitate onboarding, metadata registration, security provisioning, data lifecycle, and observability. You can provision the service layer resource group to host your metadata store.

> [!IMPORTANT]
> The following automation services aren't actual products that you can purchase. And they don't represent future releases or updates. Use the following list to help you consider which items to automate.

| Type of service                        | Service scope                    |
|--------------------------------|-----------------------------------|
| Data landing zone provisioning | This service creates a new data landing zone. This service is infrequently used, but it ensures end-to-end onboarding solution completeness. For more information, see [Provision cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md).                                        |
| Data product onboarding        | This service creates and amends resource groups that pertain to an onboarded tenant. It also contains capabilities to upgrade and downgrade SKUs and to activate and deactivate resource groups for onboarded tenants or services. This service also creates a new data landing zone for DevOps purposes. For more information, see [Provision cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md). |
| Data agnostic ingestion        | This microservice creates new data sources for ingestion into your data landing zones. To manage this process, it communicates with an Azure Data Factory and Azure SQL Database metastore that's located in each data landing zone. For more information, see [How automated ingestion frameworks support cloud-scale analytics in Azure](../best-practices/automated-ingestion-pattern.md). |
| Metadata                       | This service exposes and creates metadata for the platform. For more information, see [Metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md). |
| Access provisioning            | This service uses a service principal name or user principal name to create access packages, access policies, and manual or automatic asset access approval processes. It can also expose an API to provide a list of subscription requests (or assets) that users submit in the last 90 days. For more information, see [Data access management](../../cloud-scale-analytics/secure.md).         |
| Data lifecycle                 | This service helps maintain your data lifecycle based on metadata. This maintenance can include moving data to cold storage and deleting outdated records. For more information, see [Data lifecycle management](../../cloud-scale-analytics/govern-lifecycle.md).                                                                                              |
| Data domain onboarding         | This service is only applicable to data mesh. This service captures new domain metadata and onboards the new domains as needed. It can also create, update, activate, and deactivate domain or service lines that you build into a microservice. For more information, see [Provision cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md). |

## Azure Container Registry

Your data management landing zone hosts an Azure Container Registry instance. Data platform operations can use Container Registry to deploy standard containers for data science projects that your data application teams consume.

## Next step

> [!div class="nextstepaction"]
> [Overview of data landing zones](./data-landing-zone.md)
