---
title: Enterprise Scale Analytics and AI Overview
description: Enterprise Scale Analytics and AI Architecture Overview represents the strategic design path and target technical state for an Azure Analytics environment. Addressing the challenges of a centralized, monolithic data lake, this architecture is using a core service provider or harmonized data mesh pattern.
author: mboswell
ms.author: mboswell  # Microsoft employees only
ms.date: 03/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Enterprise Scale Analytics and AI Overview

Today, customers are investing in moving data to the cloud and have been following a modern data warehouse (MDW) pattern published by multiple cloud vendors. This MDW pattern pushes for singular enterprise data lakes which focuses the organization on centralized analytics. These patterns are aligned to on-premises deployments as opposed to the agility and self-service of the cloud.

The Enterprise Scale Analytics and AI solution pattern represents the strategic design path and targets the technical state for an Azure Analytics and AI environment. It addresses the challenges of a centralized monolithic data lake by using either a core service provider or harmonized data mesh pattern.

Distribution of the data and pipelines enables the Domains to have ownership of accessibility, usability, and development. The Enterprise Scale Analytics and AI solution pattern includes storage, data lineage, data classification, data ingestion, networking, security, access management, encryption, resiliency, and monitoring.

## Critical Design Areas

Enterprise Scale Analytics and AI considers six critical design areas that help translate organizational requirements to Azure constructs and capabilities. These design areas can help address the mismatch between on-premises and cloud-design infrastructure as well as data monoliths. These areas typically create dissonance and friction between the enterprise-scale definition and Azure adoption:

1. Data Management
1. Data Domains
1. Data Products
1. Data Platform Operational Excellence
1. Data Science Environment
1. Data Science Workflow and MLOps

## Data Management Landing Zone and Data Landing Zone(s)

The Enterprise Scale Analytics and AI solutions pattern consists of a Data Management Landing Zone with multiple connected Data Landing Zones:

* The Data Management Landing Zone consists of a data catalog, master data management, data quality, data contracts, and API management.
* The Data Landing Zone can host multiple analytics and AI solutions relevant to their respective business domain.

The platform can be extended to include other Azure services on demand. The proposed approach is to provision the analytics platform with the required services, with t-shirt sizing, and extend it further as new use cases are onboarded. This allows enterprises to regulate the platform cost effectively. The framework builds on our [Enterprise-Scale Architecture](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/) and should be considered a supplement to it.

![Enterprise Scale Data Management and Single Data Landing Zone](./images/hldsimple.png)

Figure 1: Enterprise Scale Data Management and Single Data Landing Zone

Figure 1 gives an overview of an Enterprise Scale Analytics and AI platform with a central Data Management Landing Zone and a **single** spoke (known as a Data Landing Zone). For a number of environments this will be the starting point. It allows you to conform to the principles of Enterprise Scale Analytics and AI whilst giving you the option to add additional Data Landing Zones. This is close to a Core Service Provider pattern which builds-out common core services with flexibility to bolt-on domain specific customizations.

![Enterprise Scale Data Management and Multiple Data Landing Zones](./images/hld.png)

Figure 2: Enterprise Scale Data Management and Multiple Data Landing Zones

Figure 2 gives an overview of an Enterprise Scale Analytics and AI platform with a central Data Management Landing Zone and a **multiple** spoke (known as a Data Landing Zones). This is similar to a Harmonized Mesh pattern, which leverages common policies that ensure baseline security and compatibility. Different groups within the enterprise can customize capabilities as they see fit.

The Enterprise Scale Analytics and AI framework advocates consistent governance using a common architecture that defines baseline capabilities and policies. Thus, all Data Landing Zones adhere to the same controls and auditing. Crucially, however, teams operating within the Data Landing Zone have the freedom to create data pipelines, ingest sources, create Data Products (such as reports and dashboards), and perform *ad hoc* Spark/SQL analysis. Furthermore, Data Landing Zone capabilities can be augmented by adding services on top of the baseline capability set out in the policy. Thus, a team could, for instance, add a third-party graph engine to address some niche business requirement.

If you have multiple Data Landing Zones, these can connect to data lakes hosted in other zones, allowing groups to collaborate across the enterprise (subject to SSO access controls).

The solution pattern places a strong emphasis on central cataloging and classification to protect data and allow various groups to discover datasets.

## Data Management Landing Zone

* The Data Management Landing Zone hosts centralized services such as data cataloging, monitoring, auditing, etc.
* The Data Landing Zone(s) are automatically peered to the Data Management Landing Zone to allow the data catalog to crawl across the Data Landing Zone(s) for data discovery and governance. The Data Management Landing Zone as deployed is peered to the Connectivity Management Subscription.
* This environment is highly controlled and subject to stringent audits.
* All data classification types will be stored in a central Data Catalog. Access patterns are enforced by metadata-dependent policies. The Data Catalog can serve as a back-end repository for data market front-ends.

The Data Management Landing Zone is discussed in detail in the [Data Management Landing Zone guide](./eslz-data-management-landing-zone.md).

## Data Landing Zone(s)

* Data Landing Zone(s) are subscriptions within the solution pattern representing primary business groups, integrators, and enablers as these groups own, operate, and often provide innate understanding for the source systems.
* Ingestion capabilities will exist in each Data Landing Zone to allow Domain subject matter experts to pull in data sources from third-party clouds or on-premises environments.
* Data Landing Zone are instantiated based on the Data Landing Zone core architecture, including all key capabilities to host an analytics platform.
* A Data Landing Zone can host one or many Domains.
* A Data Landing Zone can also host one or many Data Products.
* A data product is anything that drives business value (*e.g.* reports, workbooks, bespoke database or data API). It can leverage additional services/technologies not part of Data Landing Zone core architecture. For example:
  * Reporting with niche requirements, *e.g.* compliance, tax reporting, HR, etc.
  * Specialized capabilities that address gaps in the baseline policies.

The Data Landing Zone is discussed in detail in the [Data Landing Zone guide](./eslz-data-landing-zone.md)

>[!IMPORTANT]
>A **domain** is responsible for ingestion of data into a read data source. The data shouldn't have any data transformation applied apart from data quality checks and data types being applied. \
\
>A **data product** is data from a domain read data source which has had some data transformation applied. This could be a new curated dataset or BI report.
