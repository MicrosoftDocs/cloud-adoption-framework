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

A data management landing zone is esential for cloud-scale analytics. It oversees the governance of your entire analytics platform.

:::image type="content" source="../images/data-management-overview.png" alt-text="Diagram of data management landing zone overview." lightbox="../images/data-management-overview.png" border="false":::

Your data management landing zone is a separate subscription that has the same standard Azure landing zone services. It provides data governance through crawlers, which connect to your data lakes and polyglot storage in your data landing zones. Virtual network peering connects your data management landing zone to your data landing zones and connectivity subscription.

This architecture is a starting point. You can modify it to fit your specific business and technical requirements when you plan your data management landing zone implementation.

> [!NOTE]
> *Polyglot persistence* refers to the practice of using multiple data storage or data store technologies to support your data types and their storage needs. Polyglot persistence means that an application can use more than one core database or storage technology.

> [!IMPORTANT]
> You must deploy your data management landing zone as a separate subscription under a management group that has the appropriate governance. You can then control governance across your organization. The [Azure landing zone accelerator](../../../ready/landing-zone/index.md) illustrates how you should approach Azure landing zones.

## Data governance

The Azure cloud-scale analytics framework suggests that you use Microsoft Purview. Alternatively, you can deploy Microsoft partner solutions to manage specific data governance functions. Key functions to consider in your architecture include a global data catalog, primary data management, data sharing and contracts, an API catalog, data quality management, and a data modeling repository.

If you have Microsoft partner data governance products that require deployment in a subscription, deploy them to the Data Governance resource group within the data management landing zone.

### Data catalog

[!INCLUDE [data-catalog](../../cloud-scale-analytics/includes/data-catalog.md)]

### Primary data management

Primary data management control resides in the data management landing zone. For specific considerations for data mesh, see [Primary data management in data mesh](../../cloud-scale-analytics/architectures/data-mesh-master-data-management.md).

Many primary data management solutions fully integrate with Microsoft Entra ID. You can help secure your data and provide different views for different user groups.

For more information, see [Primary data management system](../govern-master-data.md).

### Data sharing and contracts

Cloud-scale analytics uses [Microsoft Entra entitlement management](/azure/active-directory/governance/entitlement-management-overview) or [Microsoft Purview policies](../secure-data-privacy.md) to control access to data sharing. In addition to those features, you might require a sharing and contract repository. This repository is an organizational function and should reside in your data management landing zone.

Your contracts should provide information about data validation, models, and security policies.

For more information, see [Data contracts](../../cloud-scale-analytics/architectures/data-contracts.md).

### API catalog

Your data application teams create various APIs for their data applications. These APIs can be difficult to discover across your organization. To solve this problem, place an API catalog in your data management landing zone.

An API catalog can help standardize your documentation and provide a place for internal collaboration on APIs. It can also drive consumption, publishing, and governance controls across your organization.

### Data quality management

Continue with your current solution.

Manage data quality at the data source to prevent problems from spreading across your analytics and AI systems. Integrate quality metrics and validation into your data processes so that teams that are most familiar with the data handle quality management. This approach helps ensure that your team has a deeper understanding and better handling of the data assets.

Provide data lineage for all data products to improve data quality confidence.

For more information about data quality management, see [Data quality](../../cloud-scale-analytics/govern-data-quality.md).

### Data modeling repository

Store entity relationship models centrally within your data management landing zone so that data consumers can easily find conceptual diagrams.

Use tools like [ER/Studio](https://erstudio.com/) and [OrbusInfinity](https://www.orbussoftware.com/orbusinfinity) to model your data products before ingestion.

## Service layer

Your organization might create several automation services to augment cloud-scale analytics capabilities. These automation services drive conformity and onboarding solutions for your analytics state.

If you build these automation services, you should have a user interface that serves as both a data marketplace and an operation console. This interface should rely on an underlying metadata store, such as [metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md).

Your data marketplace or operations console calls a middle tier of microservices to facilitate onboarding, metadata registration, security provisioning, data lifecycle, and observability.

You can provision the service layer resource group to host your metadata store.

> [!IMPORTANT]
> The following automation services aren't actual products that you can purchase. And they don't represent future releases or updates. Use the following list to help you consider which items to automate.

| Type of service                        | Service scope                    |
|--------------------------------|-----------------------------------|
| Data landing zone provisioning | This service creates a new data landing zone. This service is infrequently used, but it ensures end-to-end onboarding solution completeness. For more information, see [Provision cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md).                                        |
| Data product onboarding        | This service creates and amends resource groups that pertain to an onboarded tenant. It also contains capabilities to upgrade and downgrade SKUs and to activate and deactivate resource groups for onboarded tenants or services. This service also creates a new data landing zone for DevOps purposes. For more information, see [Provision cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md). |
| Data agnostic ingestion        | This microservice creates new data sources for ingestion into your data landing zones. To manage this process, it communicates with an Azure Data Factory and Azure SQL Database metastore that's located in each data landing zone. For more information, see [How automated ingestion frameworks support cloud-scale analytics in Azure](../best-practices/automated-ingestion-pattern.md). |
| Metadata                       | This service exposes and creates metadata for the platform. For more information, see [Metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md). |
| Access provisioning            | This service creates access packages, access policies, and manual or automatic asset access approval processes via a service principal name or user principal name. It can also expose an API to provide a list of subscription requests (or assets) that users submit in the past 90 days. For more information, see [Data access management](../security-provisioning.md).         |
| Data lifecycle                 | This service helps maintain your data lifecycle based on metadata. This maintenance can include moving data to cold storage and deleting outdated records. For more information, see [Data lifecycle management](../../cloud-scale-analytics/govern-lifecycle.md).                                                                                              |
| Data domain onboarding         | This service is only applicable to data mesh. This service captures new domain metadata and onboards the new domains as needed. It can also create, update, activate, and deactivate domain or service lines that you build into a microservice. For more information, see [Provision cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md). |

## Azure Container Registry

Your data management landing zone hosts an Azure Container Registry instance. Your data platform operations can use Container Registry to deploy standard containers for data science projects that your data application teams consume.

## Next step

> [!div class="nextstepaction"]
> [Overview of the data landing zone](./data-landing-zone.md)
