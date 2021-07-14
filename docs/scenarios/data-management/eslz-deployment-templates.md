---
title: Deployment templates
description: Learn about the core starter templates for enterprise-scale analytics and AI deployment. 
author: mboswell
ms.author: mboswell
ms.date: 07/13/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Deployment templates

The Enterprise Scale Analytic and AI solution has the following core starter templates:

|Repository|Content|Required|Deployment model|
|-|-|-|-|
|[Data Management Template](https://github.com/Azure/data-management-zone)| Central data management services and shared data services, such as data catalog and self-hosted integration runtime | Yes | One per Enterprise Scale Analytics and AI |
|[Data Landing Zone Template](https://github.com/Azure/data-landing-zone)| Data Landing Zone shared services, such as data storage, ingestion services, and management services | Yes | One per Data Landing Zone |
|[Data Integration Template - Batch Processing](https://github.com/Azure/data-integration-batch) | Additional services required for batch data processing | No | One or more per Data Landing Zone |
|[Data Integration Template - Stream Processing](https://github.com/Azure/data-integration-streaming) | Additional services required for processing data streams | No | One or more per Data Landing Zone |
|[Data Product Template - Analytics and Data Science](https://github.com/Azure/data-product-analytics)| Additional services required for data analytics and AI| No | One or more per Data Landing Zone |
| [Data Product Template - Reporting](https://github.com/Azure/data-product-reporting) | Additional services required for data product reporting | No | One or more per Data Landing Zone|

These templates not only contain Azure Resource Manager templates and their parameter files, but also CI/CD pipeline definitions for resource deployment.

The templates can change over time because of new Azure services and requirements. Secure the `main` branch of these repositories to ensure that it remains error-free and ready for consumption and deployment. Use a development subscription to test template configuration changes before you merge feature enhancements back into the `main` branch.
