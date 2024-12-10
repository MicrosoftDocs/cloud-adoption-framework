---
title: Data management landing zone overview
description: Gain an overview of data management landing zone in Azure
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data management landing zone

The data management landing zone is a management function central to cloud-scale analytics. It's responsible for the governance of your analytics platform.

:::image type="content" source="../images/data-management-overview.png" alt-text="Diagram of data management landing zone overview." lightbox="../images/data-management-overview.png":::

Your data management landing zone is a separate subscription that has the same standard Azure landing zone services. It allows data governance of your data through crawlers, which connect to your data lakes and polyglot storage in your data landing zones. Virtual network peering connects your data management landing zone to your data landing zones and connectivity subscription.

This architecture is a starting point, and you can modify it to fit your specific business and technical requirements when planning your data management landing zone implementation.

> [!NOTE]
> Polyglot persistence is a storage term that describes your choice between different data storage/data store technologies to support your various data types and their storage needs. Essentially, polyglot persistence is the concept that an application can use more than one core database or storage technology.

> [!IMPORTANT]
> Your data management landing zone must be deployed as a separate subscription under a management group with the appropriate governance. You can then control governance across your organization. The [Azure landing zone accelerator](../../../ready/landing-zone/index.md) illustrates how you should approach Azure landing zones.

## Data governance

Cloud Scale Analytics suggests using Microsoft Purview. Alternatively, Microsoft Partner solutions can be deployed to manage specific data governance functions. Key functions to consider in your architecture include a global data catalog, master data management, data sharing and contracts, API catalog, data quality management, and a data modeling repository.

Microsoft partner data governance products that need deployment in a subscription should be deployed to the Data Governance resource group within the data management landing zone.

### Data catalog

[!INCLUDE [data-catalog](../../cloud-scale-analytics/includes/data-catalog.md)]

### Master data management

Master data management control resides in the data management landing zone. [Master data management in data mesh](../../cloud-scale-analytics/architectures/data-mesh-master-data-management.md) contains specific considerations you should call out for data mesh.

Many master data management solutions fully integrate with Microsoft Entra ID. This integration allows you to secure your data and provide different views for different user groups.

For more information, see [Master data management system](../govern-master-data.md).

### Data sharing and contracts

Cloud-scale analytics uses [Microsoft Entra entitlement management](/azure/active-directory/governance/entitlement-management-overview) or [Microsoft Purview policies](../secure-data-privacy.md) to control access to data sharing. Even so, you might still require a sharing and contract repository. This repository is an organizational function and should reside in your data management landing zone.

Your contracts should provide information on data validation, models, and security policies.

For more information, see [Data contracts](../../cloud-scale-analytics/architectures/data-contracts.md).

### API catalog

Your data application teams create various APIs for their data applications. These APIs can be difficult to discover across your organization. Placing an API catalog in your data management landing zone can solve this problem.

An API catalog can help standardize your documentation and offers a place for internal collaboration on APIs. It also can drive consumption, publishing, and governance controls across your organization.

### Data quality management

Continue with your current solution.

Manage data quality as close to the data source as possible to prevent quality issues from spreading across your analytics and AI systems. By integrating quality metrics and validation into your data processes, you align the quality management with the teams most familiar with the data, ensuring a deeper understanding and better handling of the data assets.

Data lineage also provides data quality confidence, and you should provide it for all data products.

For more information on data quality management, see [Data quality](../../cloud-scale-analytics/govern-data-quality.md).

### Data modeling repository

You should capture and store entity relationship models in a central location within your data management landing zone, providing data consumers a single place to find conceptual diagrams.

Many customers use [ER Studio](https://erstudio.com/) and [OrbusInfinity](https://www.orbussoftware.com/orbusinfinity) to model their data products before ingestion.

## Service layer

Your organization might decide to create many automation services to augment cloud-scale analytics capabilities. These automation services drive conformity and onboarding solutions for your analytics state.

If you decide to build these automation services, you should have a user interface that acts as both a data marketplace and an operation console. This interface should rely on an underlying metadata store such as [Metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md).

Your data marketplace or operations console calls a middle tier of microservices to facilitate onboarding, metadata registration, security provisioning, data lifecycle, and observability.

You can provision the **service layer** resource group to host your metadata store.

> [!IMPORTANT]
> None of these automation services are products, and they don't illustrate any roadmap item. They are listed to help you consider which items you might want to automate.

| Service                        | Service Scope                    |
|--------------------------------|-----------------------------------|
| Data landing zone provisioning | This service creates a new data landing zone. It's unlikely to have high usage, but is included for end-to-end onboarding solution completeness. For more information, see [Provision the cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md)                                        |
| Data product onboarding        | This service creates and amends resource groups that pertain to an onboarded tenant. It also contains capabilities to upgrade and downgrade SKUs and to activate and deactivate resource groups for any onboarded tenant or service. It creates a new data landing zone DevOps. For more information, see [Provision the cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md) |
| Data agnostic ingestion        | This microservice creates new data sources for ingestion into your data landing zones by communicating with an Azure Data Factory SQL Database metastore in each data landing zone. For more information, see [How automated ingestion frameworks support cloud-scale analytics in Azure](../best-practices/automated-ingestion-pattern.md) |
| Metadata                       | This service exposes and creates metadata for the platform. For more information, see [Metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md) |
| Access provisioning            | This service creates access packages, access policies, and asset access approval processes (manual or automatic) using SPN/UPN. It can also expose an API to provide a list of subscription requests (assets) that users submitted in the past 90 days. For more information, see [Data access management](../security-provisioning.md)         |
| Data lifecycle                 | This service is responsible for maintaining your data lifecycle based on metadata. This maintenance can include moving data to cold storage and deleting records that no longer need to be retained. For more information, see [Data lifecycle management](../../cloud-scale-analytics/govern-lifecycle.md)                                                                                              |
| Data domain onboarding         | ONLY APPLICABLE TO DATA MESH. This service captures metadata pertaining to new domains and onboards the new domains as needed. It can also create, update, activate, and deactivate any domain or service line you might build into a microservice. For more information, see [Provision the cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md) |

## Azure Container Registry

Your data management landing zone hosts an Azure Container Registry. The Azure Container Registry allows your data platform operations to deploy standard containers for use in data science projects that your data application teams consume.

## Next steps
> [!div class="nextstepaction"]
> [Overview of the data landing zone](./data-landing-zone.md)
