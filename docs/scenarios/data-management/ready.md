---
title: Review your environment for Azure landing zones
description: Learn about how data management and analytics affects your Azure landing zone design.
author: BrianBlanchard
ms.author: brblanch
ms.date: 12/15/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Review your environment for Azure landing zones

Data management and analytics scenario builds upon Azure landing zones for ease of deployment and governance. The principal purpose of an Azure landing zone is to ensure that when an application or workload lands on Azure, the required "plumbing" is already in place. There are sample templates, which get you started which can be used for data lakehouse and [data mesh](what-is-data-mesh.md) deployments. They provide agility and compliance with security and governance requirements. Azure landing zones must be in place before you deploy your first data management and analytics landing zones.

## Data management and analytics evaluation

Often businesses seek clarity or prescriptive guidance before they start to carve out the technical details for a specific use case, project, or an end-to-end data management and analytics. It can be challenging to ensure that all strategic and required principles in the scope of the current use are considered for how the overall data strategy is formulated.

To speed up the delivery of this end-to-end insights journey while still keeping these challenges in mind, Microsoft has developed a prescriptive scenario for data management and analytics. It aligns to the key themes discussed in [Develop a plan for data management and analytics](../plan.md).

The data management and analytics scenario builds on top of the Microsoft Cloud Adoption Framework whilst applying our Well-Architected framework lens. Microsoft Cloud Adoption Framework provides prescriptive guidance and best practices on cloud operating models, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments.

The data management and analytics scenario paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular while supporting autonomy and innovation.

## Observations of existing architectures

In the late 1980s, there was the introduction of the data warehouse generation 1, which combined disparate data sources from across the enterprise. In the late 2000s came Gen2, with the introduction of the big data ecosystem like Hadoop and the data lake. In the mid 2010s, we had the cloud data platform. It was similar to previous generations, but with the introduction of the ingestion of streaming data, like kappa or lambda architectures. The early 2020s introduced the concepts of the data lakehouse, data mesh, data fabric, and data-centric operational patterns.

Understanding the evolution and looking forward, many organizations still have the centralized monolithic platform, generation 1. This system works well, up to a point. Bottlenecks because of interdependent processes, tightly coupled components, hyperspecialized teams, and thousands of extract, transform, load (ETL) jobs become prominent and can slow down delivery timelines.

The data warehouse and data lake is still valuable, and will play an important role in your overall architecture. We're highlighting some of the challenges that inevitably come forth when using these traditional practices. These challenges are especially relevant in a complex organization, where data sources, requirements, teams, and outputs change.

## Data Management and Analytics Scenario

In response to the challenges of centralized data warehouses, data management and analytics scenario represents a strategic design path and targets the technical state for an Azure analytics and AI environment.

The pattern relies upon distribution of the data and its pipelines across domains. This pattern enables ownership of accessibility, usability, and development. Largely based on these patterns, data management and analytics scenario includes the following capabilities:

- Storage
- Data lineage
- Data classification
- Data ingestion
- Networking
- Security
- Access management
- Encryption
- Resiliency
- Monitoring

> [!NOTE]
> The data management and analytics scenario builds on the Cloud Adoption Framework [enterprise-scale architecture](../../../ready/enterprise-scale/index.md) and should be considered a supplement to it.

## Critical design areas

Data management and analytics scenario considers five critical design areas that help translate organizational requirements to Azure constructs and capabilities. Lack of attention to these design areas typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. Data management and analytics scenario uses these design areas to help address the mismatch between on-premises and cloud-design infrastructure.

To learn more, see:

- [Data management landing zone](#data-management-landing-zone)
- [Data landing zone](#data-landing-zone)
- [Data products](#data-products)
- [Data platform operational excellence](#operational-excellence)

## Data management landing zone

At the heart of data management and analytics scenario, is its management capability. This capability is enabled through the data management landing zone.

:::image type="content" source="../images/data-management-overview-1.png" alt-text="Diagram of a Data management overview." lightbox="../images/data-management-overview-1.png":::

The **Data management landing zone** is a subscription that governs the platform and supports the following capabilities:

- [Data catalog](data-management-landing-zone.md#data-catalog)
- [Data classification](data-management-landing-zone.md#data-classification)
- [Data lineage](data-management-landing-zone.md#data-lineage)
- [Data quality](data-management-landing-zone.md#data-quality-management)
- [Data modeling repository](data-management-landing-zone.md#data-modeling-repository)
- [Master data management](data-management-landing-zone.md#master-data-management)
- [API catalog](data-management-landing-zone.md#api-catalog)
- [Data sharing and contracts](../govern-data-sharing-agreements.md)

For more information, see [Overview of the Azure data management and analytics scenario data management landing zone](data-management-landing-zone.md).

## Data landing zone

**Data landing zones** are subscriptions that host multiple analytics and AI solutions relevant to their respective domain or domain(s). These subscriptions within data management and analytics scenario represent primary business groups, integrators, and enablers. These groups own, operate, and often provide innate understanding for the source systems.

:::image type="content" source="../images/data-landing-zone-overview.png" alt-text="Diagram of a data landing zone" lightbox="../images/data-landing-zone-overview.png":::

A few important points to keep in mind about data landing zones:

- Automated Ingestion capabilities can exist in each data landing zone. These capabilities allow subject matter experts to pull in external data sources into the data landing zone.
- A data landing zone is instantiated based on its core architecture. It includes key capabilities to host an analytics platform.
- A data landing zone can contain multiple [data product](#data-products).

For more information, see [Data landing zone](data-landing-zone.md).

## Data products

A data product is anything that drives business value and is pushed to a polyglot store such as the data landing zone data lake.

Data products manage, organize, and make sense of the data within and across domains. A data product is a result of data from one or many transactional system integrations or other data products.

For more information, see [data management and analytics scenario data products in Azure](data-landing-zone-data-products.md).

> [!IMPORTANT]
> When ingesting data from operational systems into a read data source. Apart from data quality checks and other applied data, the data should avoid having other data transformations applied to it. This drives reusability of the data product and allow other domains to consume, subject to access, for there use cases as opposed to having multiple extractions from the same operational system.

## Operational excellence

The data management and analytics scenario is designed with operational excellence at its core through self-service enablement, governance, and streamlined deployments. The working model for data operations enables these core principles by using infrastructure-as-code and deployment templates. It also uses deployment processes that include a forking and branching strategy and a central repository.

For more information, see [Organize Operations](../organize.md).

## Next steps

[Overview of the data management landing zone](data-management-landing-zone.md)
