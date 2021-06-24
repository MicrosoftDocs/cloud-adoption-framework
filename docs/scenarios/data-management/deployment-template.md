---
title: Azure Enterprise-Scale Analytics and AI Deployment Models
description: Enterprise-Scale Analytics and AI Deployment Models
author: mboswell
ms.author: mboswell
ms.date: 03/05/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Deployment Templates

The Enterprise Scale Analytic and AI solution has create the following core **starter** templates:

|Repo|Content|Required Y/N|Deployment model|
|-|-|-|-|
|[Data Management Landing Zone Template](https://github.com/Azure/data-management-zone)| Central data management services as well as shared data services such as data catalog, SHIR etc. | Mandatory | One per Enterprise Scale Analytics and AI |
|[Data Landing Zone Template](https://github.com/Azure/data-landing-zone)| Shared services for a Data Landing Zone like data storage and ingestion services as well as management services | Mandatory | One per Data Landing Zone |
|[Data Integration Batch Template](https://github.com/Azure/data-integration-batch) | Additional services required for a Data Integration Batch | Optional | One or many per Data Landing Zone |
|[Data Integration Streaming Template](https://github.com/Azure/data-integration-streaming) | Additional services required for a Data Integration Streaming | Optional | One or many per Data Landing Zone |
|[Data Product Template - Analytics and Data Science](https://github.com/Azure/data-product-analytics)| Additional services required for a data product analytics and AI| Optional | One or many per Data Landing Zone |
| [Data Product Template - Reporting](https://github.com/Azure/data-product-reporting) | Additional services required for a data product reporting | Optional | One or many per Data Landing Zone|

These templates should not only contain ARM templates and the respective parameter files, but also CI/CD pipeline definitions for deploying the resources.
Because of new requirements and new services on Azure, these templates will evolve over time. Therefore the `main` branch of these repositories should be secured to ensure that it is always error free and ready for consumption and deployment. A development subscription should be used to test changes to the configuration of the templates, before merging feature enhancements back into the `main` branch. 
