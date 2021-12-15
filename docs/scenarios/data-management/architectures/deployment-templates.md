---
title: Deployment templates for data management and analytics scenario deployments
description: Learn about the core starter templates for data management and analytics scenario deployments.
author: mboswell
ms.author: mboswell
ms.date: 12/14/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: think-tank, e2e-data-management
---

# Deployment templates for data management and analytics scenario

The data management and analytics scenario has the following core starter templates:

|Repository|Content|Required|Deployment model|
|-|-|-|-|
|[Data management template](https://github.com/Azure/data-management-zone)| Central data management services and shared data services, such as data catalog and self-hosted integration runtime | Yes | One per data management and analytics scenario |
|[Data landing zone template](https://github.com/Azure/data-landing-zone)| Data landing zone shared services, such as data storage, ingestion services, and management services | Yes | One per data landing zone |
|[Data integration template - batch processing](https://github.com/Azure/data-product-batch) | Additional services required for batch data processing | No | One or more per data landing zone |
|[Data integration template - stream processing](https://github.com/Azure/data-product-streaming) | Additional services required for processing data streams | No | One or more per data landing zone |
|[Data product template - analytics and data science](https://github.com/Azure/data-product-analytics)| Additional services required for data analytics and AI| No | One or more per data landing zone |
| | |

These templates contain not only Azure Resource Manager templates and their parameter files, but also CI/CD pipeline definitions for resource deployment.

The templates can change over time because of new Azure services and requirements. Secure the `main` branch of these repositories to ensure that it remains error-free and ready for consumption and deployment. Use a development subscription to test template configuration changes before you merge feature enhancements back into the `main` branch.

## Cost estimates

We have provided links to the official cost calculator, where users can make changes depending on the expected amount of data and data throughput. All cost calculations specify a *base cost* of data management and analytics for Cloud Adoption Framework for Azure. Base cost can be defined as the cost that occurs if no data workloads run inside the respective subscriptions.

### Data management zone costs

In a production scenario, we recommend that you rely on the Azure Firewall and private DNS zones that are hosted in the connectivity hub of [azure landing zones](https://github.com/Azure/Enterprise-Scale). In minimal viable products, you can rely on the Azure Firewall and private DNS zones that are bundled with Cloud Adoption Framework data management and analytics. Therefore, we provide the following two different cost calculations:

- [Calculation 1: Pricing calculator - data management zone without Azure Firewall and private DNS zones](https://azure.com/e/ebb7508a6d78487b9a1583878d0948cc)
- [Calculation 2: Pricing calculator - data management zone with Azure Firewall and private DNS zones](https://azure.com/e/658478643d4b46fdbf8b1972c4b0704b)

Keep in mind that the following services are not listed in the overview, because they are either not available in the official pricing calculator or the pricing calculator does not allow you to set the compute hours to 0:

- Azure Purview
- Synapse Private Link hub
- Route table
- Network security group

### Data landing zone costs

For data landing zones, refer to the following cost calculation:

- [Pricing calculator - data landing zone](https://azure.com/e/55cb6feafcc24cec8cfeb10486d54ab5)

You can further reduce the cost by hosting the self-hosted integration runtime (SHIR) on-premises instead of hosting it on a virtual machine scale set.

Keep in mind that the following services are not listed in the overview, because they're either unavailable in the official pricing calculator or the pricing calculator doesn't allow you to set the compute hours to 0:

- Azure Databricks
- Route table
- Network security group

## Next steps

Learn about [Azure policies](policies.md) for data management and analytics scenario.
