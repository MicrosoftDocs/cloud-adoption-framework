---
author: mboswell
ms.author: mboswell
ms.date: 04/11/2022
ms.topic: include
s.custom: e2e-data-management, think-tank
---

|Repository|Content|Required|Deployment model|
|-|-|-|-|
|[Data management template](https://github.com/Azure/data-management-zone)| Central data management services and shared data services like data catalog and self-hosted integration runtime | Yes | One per cloud-scale analytics |
|[Data landing zone template](https://github.com/Azure/data-landing-zone)| Data landing zone shared services, including ingestion, management, and data storage services | Yes | One per data landing zone |
|[Data integration template - batch processing](https://github.com/Azure/data-product-batch) | Additional services necessary for batch data processing | No | One or more per data landing zone |
|[Data integration template - stream processing](https://github.com/Azure/data-product-streaming) | Additional services necessary for data stream processing | No | One or more per data landing zone |
|[Data product template - analytics and data science](https://github.com/Azure/data-product-analytics)| Additional services necessary for data analytics and AI| No | One or more per data landing zone |

These templates contain Azure Resource Manager templates, the templates' parameter files, and CI/CD pipeline definitions for resource deployment.

Templates can change over time due to new Azure services and requirements. Secure each repository's main branch so it remains error-free and ready for consumption and deployment. Use a development subscription to test template configuration changes before you merge feature enhancements back into your main branch.
