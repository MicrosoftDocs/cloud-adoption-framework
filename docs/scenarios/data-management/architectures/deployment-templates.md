---
title: Deployment templates for enterprise-scale for analytics and AI deployments
description: Learn about the core starter templates for enterprise-scale for analytics and AI deployments.
author: mboswell
ms.author: mboswell
ms.date: 10/01/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.custom: think-tank, e2e-data
---

# Deployment templates for enterprise-scale for analytics and AI deployments

The enterprise-scale for analytics and AI solution has the following core starter templates:

|Repository|Content|Required|Deployment model|
|-|-|-|-|
|[Data management template](https://github.com/Azure/data-management-zone)| Central data management services and shared data services, such as data catalog and self-hosted integration runtime | Yes | One per enterprise-scale for analytics and AI |
|[Data landing zone template](https://github.com/Azure/data-landing-zone)| Data landing zone shared services, such as data storage, ingestion services, and management services | Yes | One per data landing zone |
|[Data integration template - batch processing](https://github.com/Azure/data-product-batch) | Additional services required for batch data processing | No | One or more per data landing zone |
|[Data integration template - stream processing](https://github.com/Azure/data-product-streaming) | Additional services required for processing data streams | No | One or more per data landing zone |
|[Data product template - analytics and data science](https://github.com/Azure/data-product-analytics)| Additional services required for data analytics and AI| No | One or more per data landing zone |

These templates not only contain Azure Resource Manager templates and their parameter files, but also CI/CD pipeline definitions for resource deployment.

The templates can change over time because of new Azure services and requirements. Secure the `main` branch of these repositories to ensure that it remains error-free and ready for consumption and deployment. Use a development subscription to test template configuration changes before you merge feature enhancements back into the `main` branch.

## Cost Estimates

Links to the official Cost Calculator have been provided where users can make changes depending on the expected amount of data and data throughput. All cost calculations will specify base cost of CAF data management and analytics. Base cost means the cost that occur if no data workloads run inside the respective subscriptions.

### Data Management Zone

In a production scenario, it is recommended to rely on the Azure Firewall and Private DNS Zones hosted in the connectivity Hub of [Enterprise-Scale Landing Zones](https://github.com/Azure/Enterprise-Scale). In Minimal Viable Products, users may rely on the Azure Firewall and Private DNS Zones bundled with CAF data management and analytics. Hence, two different cost calculations are provided which can be found below:

- [Pricing Calculator - Data Management Zone w/o Azure Firewall and Private DNS Zones](https://azure.com/e/ebb7508a6d78487b9a1583878d0948cc)
- [Pricing Calculator - Data Management Zone w/ Azure Firewall and Private DNS Zones](https://azure.com/e/658478643d4b46fdbf8b1972c4b0704b)

Please keep in mind that the following services are not listed in the overview, because they are either not available in the official Pricing Calculator or the Pricing Calculator does not allow to set the compute hours to 0:

- Azure Purview
- Synapse Private Link Hub
- Route Table
- Network Security Group

### Data Landing Zone

For the Data Landing Zone, please refer to the following cost calculation:

- [Pricing Calculator - Data Landing Zone](https://azure.com/e/55cb6feafcc24cec8cfeb10486d54ab5)

Cost can be further reduced by hosting the Self-hosted Integration Runtime (SHIR) on-premises instead of hosting it on a Virtual Machine Scale Set (VMSS).

Please keep in mind that the following services are not listed in the overview, because they are either not available in the official Pricing Calculator or the Pricing Calculator does not allow to set the compute hours to 0:

- Azure Databricks
- Route Table
- Network Security Group

## Next steps

[Frequently asked questions about enterprise-scale for analytics and AI in Azure](./frequently-asked-questions.md)

