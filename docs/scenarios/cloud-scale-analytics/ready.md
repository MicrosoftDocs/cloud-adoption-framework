---
title: Review your environment for Azure landing zones for cloud-scale analytics
description: Learn about how cloud-scale analytics affects your Azure landing zone design.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Azure landing zones for cloud-scale analytics

In response to the need for frictionless governance and a platform for actionable insights to the business, cloud-scale analytics represents a strategic design path and targets the technical state for an Azure analytics and AI environment.

The pattern relies upon the distribution of the data and its pipelines across domains. This pattern enables ownership of accessibility, usability, and development. Largely based on these patterns, cloud-scale analytics includes the following capabilities:

- Storage
- Data governance
- Data ingestion
- Data quality
- Access provisioning
- Networking
- Encryption
- Resiliency
- Observability

> [!NOTE]
> Cloud-scale analytics builds on the [Start with Cloud Adoption Framework enterprise-scale landing zones](../../ready/enterprise-scale/index.md) and should be considered a supplement to it.

Cloud-scale analytics builds on top of the Microsoft Cloud Adoption Framework while applying our Well-Architected framework lens. The Microsoft Cloud Adoption Framework provides prescriptive guidance and best practices on cloud operating models, reference architecture, and platform templates. It's based on real-world learnings from some of our most challenging, sophisticated, and complex environments.

Cloud-scale analytics paves the way for customers to build and operationalize landing zones to host and run analytics workloads. You build the landing zones on the foundations of security, governance, and compliance. They're scalable and modular while supporting autonomy and innovation.

Cloud-scale analytics considers five critical design areas that help translate organizational requirements to Azure constructs and capabilities. Lack of attention to these design areas typically creates dissonance and friction between the enterprise-scale definition and Azure adoption. Cloud-scale analytics uses these design areas to help address the mismatch between on-premises and cloud-design infrastructure.

To learn more, see:

- [Data management landing zone](#data-management-landing-zone)
- [Data landing zone](#data-landing-zone)
- [Data products](#data-products)
- [Data platform operational excellence](#operational-excellence)

## Data management landing zone

At the heart of cloud-scale analytics is its management capability. This capability is enabled through the data management landing zone.

For more information, see [Data management landing zone](architectures/data-management-landing-zone.md).

## Data landing zone

**Data landing zones** are subscriptions that host multiple analytics and AI solutions relevant to their respective domain or domains. These subscriptions within cloud-scale analytics represent primary business groups, integrators, and enablers. These groups own, operate, and often provide an innate understanding of the source systems.

A few important points to keep in mind about data landing zones:

- Automated ingestion capabilities can exist in each data landing zone. These capabilities allow subject matter experts to pull in external data sources into the data landing zone.
- A data landing zone is instantiated based on its core architecture. It includes key capabilities to host an analytics platform.
- A data landing zone can contain multiple [data products](#data-products).

For more information, see [Data landing zone](architectures/data-landing-zone.md).

## Data products

A data product is anything that drives business value and is pushed to a polyglot store such as the data landing zone data lake.

Data products manage, organize, and make sense of the data within and across domains. A data product is a result of data from one or many transactional system integrations or other data products.

For more information, see [cloud-scale analytics data products in Azure](architectures/data-landing-zone-data-products.md).

> [!IMPORTANT]
> When ingesting data from operational systems into a read data source, apart from data quality checks and other applied data, the data should avoid having other data transformations applied to it. This drives reusability of the data product and allows other domains to consume, subject to access, for their use cases as opposed to having multiple extractions from the same operational system.

## Operational excellence

Cloud-scale analytics is designed with operational excellence at its core through self-service enablement, governance, and streamlined deployments. The working model for data operations enables these core principles by using infrastructure-as-code and deployment templates. It also uses deployment processes that include a forking and branching strategy and a central repository.

For more information, see [Organize Operations](organize.md).

## Other design considerations

To get started with the data management and data management landing zones, you need to make sure that you have the underpinning architectural components to enable a successful deployment.

- [Enterprise enrollment and Microsoft Entra tenants for cloud-scale analytics](eslz-enterprise-enrollment-and-azure-ad-tenants.md)

- [Identity and access management for cloud-scale analytics](eslz-identity-and-access-management.md)

- [Network topology and connectivity for cloud-scale analytics landing zones](eslz-network-topology-and-connectivity.md)

- [Resource organization for cloud-scale analytics](eslz-resource-organization.md)

- [Security, governance, and compliance for cloud-scale analytics](eslz-security-governance-and-compliance.md)

- [Management and monitoring for cloud-scale analytics](eslz-management-and-monitoring.md)

- [Business continuity and disaster recovery considerations for AKS](../app-platform/aks/management.md)

## Next steps

- [Enterprise enrollment](eslz-enterprise-enrollment-and-azure-ad-tenants.md)
