---
title: Common Data Model & Industry Data Models
description: Learn about Common Data Model & Industry Data Models
author: SanemSSever
ms.author: sasever
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Common Data Model & Industry Data Models

Common Data Model(CDM) and Synapse Industry Data Models(IDM) are two enablers to provide the [Data Products](what-is-data-product.md) [interoperability](what-is-data-product.md#characteristics-of-data-served-as-a-product). Both of them serve the purpose of having organization and industry-wide standards in how the data is shaped and shared. Using a base data model, let it be CDM or IDM  as a standard in data interfaces where applicable helps also in keeping the data understandable.

## Common Data Model

The Common Data Model standard defines a common language for business entities covering, over time, the full range of business processes across sales, services, marketing, operations, finance, talent, and commerce and for the Customer, People, and Product entities at the core of a company's business processes. The goal of CDM is to enable data and application interoperability spanning multiple channels, service implementations, and vendors. CDM provides self-describing data (structurally and semantically), enabling applications to easily read and understand the data.
The graphic below shows some elements of the [standard entities](https://github.com/microsoft/CDM/tree/master/schemaDocuments/core/applicationCommon) available within Common Data Model. More information: [Common Data Model repository on GitHub](https://aka.ms/cdmrepo).

![Common Data Model poster.](https://docs.microsoft.com/en-us/common-data-model/media/cdm-entities-v1.png "Common Data Model poster")

[Download the Common Data Model poster](https://aka.ms/cdmposter)

## Synapse Industry Data Models (Lake Database Templates)

Synapse Industry Data Models are data models that can be used as predefined template models via the Lake Database feature of  Azure Synapse Analytics. environment and can be within the [Lake Database Templates](/azure/synapse-analytics/database-designer/concepts-database-templates) are a set of business and technical data definitions that are pre-designed to meet the needs of a particular industry. They act as blueprints that provide common elements derived from best practices, government regulations, and the complex data and analytic needs of an industry-specific organization and help with the transformation of data into insights.

With the Lake Database technology within Azure Synapse Analytics Lake Databases provides a query and processing interface to the Data Product files stored in the Azure Data Lake.

For further information on how to use  CDM refer to [Common Data Model](/common-data-model/) and for IDM refer to [Lake Database Templates](/azure/synapse-analytics/database-designer/overview-database-templates).
  