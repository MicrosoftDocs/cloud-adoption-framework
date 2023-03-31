---
title: Cloud-scale analytics data management landing zone overview
description: Gain an overview of cloud-scale analytics data management landing zone in Azure
author: mboswell
ms.author: mboswell
ms.date: 03/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Cloud-scale analytics data management landing zone overview

The data management landing zone is a management function and is central to cloud-scale analytics. It's responsible for the governance of your analytics platform.

:::image type="content" source="../images/data-management-overview.png" alt-text="Diagram of data management landing zone overview." lightbox="../images/data-management-overview.png":::

Your data management landing zone is a separate subscription that has the same standard Azure landing zone services. It allows data governance of your data via crawlers, which connect to your data lakes and polyglot storage in your data landing zones. Virtual network peering connects your data management landing zone to your data landing zones and connectivity subscription.

Use this architecture as a starting point. Download the [Visio file](https://www.microsoft.com/download/details.aspx?id=104215) and modify it to fit your specific business and technical requirements when planning your data management landing zone implementation.

> [!NOTE]
> Polyglot persistence is a storage term that describes your choice between different data storage/data stores technologies to support your various data types and their storage needs. Essentially, polyglot persistence is the concept that an application can use more than one core database or storage technology.

> [!IMPORTANT]
> Your data management landing zone must be deployed as a separate subscription under under a management group with the appropriate governance. You can then control governance across your organization. The [Azure landing zone accelerator](../../../ready/landing-zone/index.md) illustrates how you should approach Azure landing zones.

## Data catalog

*Resource group: governance-rg*

[!INCLUDE [data-catalog](../../cloud-scale-analytics/includes/data-catalog.md)]

For more information, see [Data catalog](../../cloud-scale-analytics/govern-data-catalog.md) and [Microsoft Purview deployment best practices for cloud-scale analytics](../best-practices/purview-deployment.md).

## Data quality management

*Resource group: governance-rg2*

Continue with your current solution.

You should manage data quality as close to your data source as possible so you avoid quality issues replicating across your analytics and AI estate. Moving quality metrics and validation to your data integration aligns the quality process with the teams that are closest to your data. These teams have the deepest understanding of your data asset.

Data lineage also provides data quality confidence, and you should provide it for all data products and products.

For more information on data quality management, see [Data quality](../../cloud-scale-analytics/govern-data-quality.md).

## Data modeling repository

*Resource group: governance-rg2*

You should capture and store entity relationship models in a central location within your data management landing zone. This provides data consumers a single place to find conceptual diagrams.

Many customers use [ER Studio](https://www.idera.com/products/er-studio/enterprise-data-modeling) and [iServer](https://www.orbussoftware.com/solutions/enterprise-architecture/data-architecture) to model their data products before ingestion.

## Master data management

*Resource group: governance-rg2*

Master data management control resides in the data management landing zone. [Master data management in data mesh](../../cloud-scale-analytics/architectures/data-mesh-master-data-management.md) contains specific considerations you should call out for data mesh.

Many master data management solutions fully integrate with Azure Active Directory. This integration allows you to secure your data and provide different views for different user groups.

For more information, see [Master data management system](../govern-master-data.md).

## API catalog

*Resource group: governance-rg2*

Your data application teams across will likely create various APIs for their data application. These APIs can be difficult to discover across your organization. Placing an API catalog in your data management landing zone can solve this problem.

An API catalog can help standardize your documentation and offers a place for internal collaboration on APIs. It also can drive consumption, publishing, and governance controls across your organization.

## Data sharing and contracts

*Resource group: governance-rg2*

Cloud-scale analytics uses
[Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview) or [Microsoft Purview policies](../secure-data-privacy.md) to control access to data sharing. Even so, you might still require a sharing and contract repository. This repository is an organizational function and should reside in your data management landing zone.

Your contracts should provide information on data validation, models, and security policies.

For more information, see [Data contracts](../../cloud-scale-analytics/architectures/data-contracts.md)

## Azure Container Registry

*Resource group: containers-rg*

Your data management landing zone hosts an Azure Container Registry. The Azure Container Registry allows your data platform operations to deploy standard containers for use in data science projects that your data application teams consume.

## Azure Synapse Private Link hubs

*Resource group: synapse-link-rg*

Azure Synapse Analytics Private Link hubs are Azure resources that connect your secured network and the Azure Synapse Studio web experience. Cloud-scale analytics securely connects your Azure Virtual Network to Azure Synapse Studio using private links from these hubs.

There are two steps to connect to Azure Synapse studio using private links.

1. Create a Private Link hub resource.
2. Create a private endpoint from your Azure Virtual Network to that Private Link hub.

You can then use private endpoints to securely communicate with Azure Synapse studio. Integrate these private endpoints with your DNS solution, either with your on-premises solution or with Azure Private DNS.

For more information, see [Connect to Azure Synapse studio using private links](/azure/synapse-analytics/security/synapse-private-link-hubs).

## Automation interfaces (optional)

Your organization might decide to create many automation services to augment cloud-scale analytics capabilities. These automation services drive conformity and onboarding solutions for your analytics state.

If you decide to build these automation services, you should have a user interface that acts as both a data marketplace and an operation console. This interface should rely on an underlying metadata store like we've previously discussed in [Metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md).

Your data marketplace or operations console calls a middle tier of microservices to facilitate onboarding, metadata registration, security provisioning, data lifecycle, and observability.

You can provision the **automationdb-rg** resource group to host your metadata store.

> [!IMPORTANT]
> None of these automation services are products, and they do not illustrate any roadmap item. They are listed to help you consider which items you might want to automate.

### Services

| Service                        | Service Scope                                                                                                                                                                                                                                                                                     |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Data landing zone provisioning | This service creates a new data landing zone. It's unlikely to have a high usage, but is included for end-to-end onboarding solution completeness. For more information, see [Provision the cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md)                                        |
| Data product onboarding        | This service creates and amends resource groups that pertain to an onboarded tenant. It also contains capabilities to upgrade and degrade SKUs and to activate and deactivate resource groups for any onboarded tenant or service. It creates a new data landing zone DevOps. For more information, see [Provision the cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md) |
| Access provisioning            | This service creates access packages, access policies, and asset access approval process (manual or automatic) using SPN/UPN. It can also expose an API to provide a list of subscription requests (assets) that users have submitted in the past 90 days. For more information, see [Data access management](../security-provisioning.md)         |
| Data agnostic ingestion        | This microservice creates new data sources for ingestion into your data landing zones. It does this by communicating with an Azure Data Factory SQL Database metastore in each data landing zone. For more information, see [How automated ingestion frameworks support cloud-scale analytics in Azure](../best-practices/automated-ingestion-pattern.md) |
| Metadata                       | This service exposed and creates metadata for the platform. For more information, see [Metadata standards](../../cloud-scale-analytics/govern-metadata-standards.md) |
| Data lifecycle                 | This service is responsible for maintaining your data lifecycle based on metadata. This maintenance can include moving data to cold storage and deleting records that no longer need to be retained. For more information, see [Data lifecycle management](../../cloud-scale-analytics/govern-lifecycle.md)                                                                                              |
| Data domain onboarding         | ONLY APPLICABLE TO DATA MESH. This service captures metadata pertaining to new domains and onboards the new domains as needed. It can also create, update, activate, and deactivate any domain or service line you might build into a microservice. For more information, see [Provision the cloud-scale analytics](../../cloud-scale-analytics/manage-provision-platform.md) |

### Data standardization

Although it isn't a specific feature or product of your data management landing zone, you should call out data standardization across all services. Data standardization defines the format in which your data should land and be stored.

> [!TIP]
> Use delta-lake format wherever possible as the defacto standard across all services and storage.

For more information, see [Data standardization](../../cloud-scale-analytics/architectures/data-standardization.md).

## Next steps

- [Overview of the data landing zone](./data-landing-zone.md)
