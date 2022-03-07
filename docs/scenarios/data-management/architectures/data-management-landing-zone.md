---
title: Overview of cloud-scale analytics data management landing zone in Azure
description: Gain an overview of cloud-scale analytics data management landing zone in Azure
author: mboswell
ms.author: mboswell
ms.date: 02/24/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Overview of the data management landing zone

The data management landing zone is classified as a management function and is central to cloud-scale analytics. It's responsible for the governance of the analytics platform.

 :::image type="content" source="../images/data-management-overview.png" alt-text="Diagram of data management landing zone overview." lightbox="../images/data-management-overview.png":::

The data management landing zone is a separate subscription that has the standard services of an Azure landing zone. They're connected to the data landing zones and connectivity subscription via virtual network peering. It allows the data governance of the data, via crawlers, which connect to the data lakes and polyglot storage in the data landing zones.

> [!NOTE]
> Polyglot persistence is an storage term used to describe choosing different data storage/data stores technologies to support the various data types and their storage needs. Polyglot persistence is essentially the idea that an application can use more than one core database or storage technology.

> [!WARNING]
> The data management landing zone must be deployed as a separate subscription under the platform branch of an azure landing zone architecture. You can then control the governance across the business. The [Azure landing zone accelerator](../../../ready/landing-zone/index.md) illustrates the way to approach Azure landing zones.

## Data catalog

*Resource group: governance-rg*

[!INCLUDE [data-catalog](../includes/data-catalog.md)]

For more information, see [Data Catalog](../govern-data-catalog.md) and [Azure Purview deployment best practices for cloud-scale analytics](../best-practices/purview-deployment.md).

## Data quality management

*Resource group: governance-rg2*

You are advised to continue with their current solution.

Data quality should happen as close to the source as possible to avoid quality issues replicating across the analytics and AI estate. Moving quality metrics and validation to the data integration aligns the quality process with the teams that are closest to the data. These teams have the deepest understanding of the data asset. Data lineage also provides data quality confidence and should be provided for all data products and products.

For more information, see [Data quality](../govern-data-quality.md).

## Data modeling repository

*Resource group: governance-rg2*

Entity relationship models should be captured and stored in a central location, that is in the data management landing zone. It gives consumers of the data a single place to go for conceptual diagrams.

[ER Studio](https://www.idera.com/products/er-studio/enterprise-data-modeling) and [iServer](https://www.orbussoftware.com/solutions/enterprise-architecture/data-architecture) are used by many customers to model their data products before ingesting.

## Master data management

*Resource group: governance-rg2*

Master data management control resides in the data management landing zone. For data mesh there are specific considerations to call out in [Master Data Management in Data Mesh](data-mesh-master-data-management.md)

Many master data management solutions fully integrate with Azure Active Directory. The integration allows you to secure the data and provide different views for different user groups.

For more information, see [master data management system](../govern-master-data.md).

## API catalog

*Resource group: governance-rg2*

It's likely that data application teams across will create various APIs for their data application. These APIs can be difficult to discover across the organization. Placing an API catalog in the data management landing zone can help solve this problem.

The API catalog can help standardize documentation and offers a place for internal collaboration on APIs. It can also help drive consumption, publishing, and governance controls across the organization.

## Data sharing and contracts

*Resource group: governance-rg2*

Cloud-scale analytics uses
[Azure AD entitlement management](/azure/active-directory/governance/entitlement-management-overview) or [Azure Purview policies](../secure-data-privacy.md) to control access to sharing of data. You still might require a sharing and contract repository. The repository is an organizational function. It should be in the data management landing zone.

These contracts should give information on data validation, model, and security policies.

For more information, see [Data sharing agreements](../govern-data-sharing-agreements.md).

## Container registry

*Resource group: containers-rg*

The data management landing zone hosts an Azure Container Registry. It allows the data platform operations to deploy standard containers for use in data science projects for the data application teams to consume.

## Azure Synapse Private Link hub

*Resource group: synapse-link-rg*

Azure Synapse Analytics Private Link hubs are Azure resources, which act as connectors between your secured network and the synapse studio web experience. Cloud-scale analytics uses the hubs to securely connect to Azure Synapse studio from your Azure Virtual Network using private links.

There are two steps to connect to Azure Synapse studio using private links. First, you must create a Private Link hubs resource. Second, you must create a private endpoint from your Azure Virtual Network to this Private Link hub. You can then use private endpoints to securely communicate with Azure Synapse studio. Integrate the private endpoints with your DNS solution, either in your on-premises solution or with Azure Private DNS.

For more information, see [Connect to Azure Synapse studio using private links](/azure/synapse-analytics/security/synapse-private-link-hubs).

## Automation interfaces (optional)

To augment cloud-scale analytics capabilities, some organization could decide to create many automation services to drive conformity and onboarding solutions for your analytics estate.

> [!IMPORTANT]
> None of these automation interfaces are products and neither do they illustrate a roadmap item. They are listed to help you consider items which you might want to automate.

If you decide to build these products, it's recommended that you have a user interface that acts as both a data marketplace and operation console. The interface would rely on an underlying metadata store that we've previously discussed in [Metadata Standards](../govern-metadata-standards.md).

The data marketplace, or operations console, would call a middle tier of microservices to facilitate onboarding, metadata registration, security provisioning, data lifecycle and observability.

The automationdb-rg resource group can be provisioned to host the metadata store.

### Services

| Service                        | Service Scope                                                                                                                                                                                                                                                                                     |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Data landing zone provisioning | This service is responsible for creating a new data landing zone - it's unlikely to have a high usage but is included for completeness of an end-to-end onboarding solution  For more information, see [Provision the Azure cloud-scale analytics](../manage-provision-platform.md)                                        |
| Data product onboarding        | This service exposes ability to create / amend resource groups pertaining to an onboarded tenant. Also capabilities to upgrade / degrade SKUs, activate / deactivate resource group for any onboarded tenant / service. It would create a new data landing zone DevOps. For more information, see [Provision the Azure cloud-scale analytics](../manage-provision-platform.md) |
| Access provisioning            | This service exposes the ability to create Access Packages, Access Policies, Asset access approval process(Manual/Auto) using SPN/UPN. This should also be able to expose an API to give the list of subscription requests (assets) that a user have been submitted in the last 90 days. For more information, see [Data Access Management](../security-provisioning.md)         |
| Data agnostic ingestion        | The microservice communicates with an Azure Data Factory SQL Database metastore in each data landing zone to create new data sources for ingestion for landing into the data landing zones. For more information, see [How automated ingestion frameworks support cloud-scale analytics in Azure](../best-practices/automated-ingestion-pattern.md) |
| Metadata                       | This service exposed and creates metadata for the platform. For more information, see [Metadata Standards](../govern-metadata-standards.md)                                                                                                                                                                                                            |
| Data lifecycle                 | Responsible for maintaining the data lifecycle based upon the metadata. This could include moving data to cold storage or deleted records that should no longer be held. For more information, see [What is Data Lifecycle Management?](../govern-lifecycle.md)                                                                                              |
| Data domain onboarding         | ONLY APPLICABLE TO DATA MESH. This service exposes ability to capture metadata pertaining to new domain & onboard them to as needed. Also capabilities to create, update, activate / deactivate any domain / service line would be built into microservice. For more information, see [Provision the Azure cloud-scale analytics](../manage-provision-platform.md) |

### Data Standardization

Although this isn't a feature or a product of the data management landing zone, it's important to call out data standardization across all services. This defines the format in which data should land and be stored.

>[!TIP]
>Where possible, we would recommend using delta-lake format as the defacto standard across all services and storage.

For more information, see [Data Standardization](data-standardization.md).

## Next steps

[Overview of the data landing zone](./data-landing-zone.md)
