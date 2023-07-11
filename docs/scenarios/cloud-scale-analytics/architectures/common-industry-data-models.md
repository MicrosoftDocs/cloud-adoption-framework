---
title: Common Data Model & industry data models
description: Learn about Common Data Model & industry data models.
author: sasever
ms.author: sasever
ms.date: 04/11/2022
ms.topic: conceptual
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Common Data Model & industry data models

The Common Data Model (CDM) and industry data models (IDMs) enable [data product interoperability](what-is-data-product.md#data-product-characteristics). Both model types help you organize the way your data is shaped and shared and ensure that it meets industry-wide standards. Since standardizing data interfaces helps keep your data understandable, you should use the CDM or an IDM as your base data model.

## Common Data Model

The Common Data Model defines a common language for business entities. Over time, this language covers the full range of your business processes across sales, services, marketing, operations, finance, talent, and commerce. The CDM enables data and application interoperability spanning multiple channels, service implementations, and vendors. It also provides data that self-describes (structurally and semantically), which allows applications to easily read and understand the data.

The following poster shows some elements of the [standard entities](https://github.com/microsoft/CDM/tree/master/schemaDocuments/core/applicationCommon) available in the Common Data Model. You can also [download your own copy](https://aka.ms/cdmposter) of the following CDM poster. 

For more information, see [Common Data Model repository on GitHub](https://aka.ms/cdmrepo).

:::image type="content" source="../media/cdm-entities-v1.png" alt-text="Common Data Model poster" lightbox="../media/cdm-entities-v1.png":::

For more information, see [Common Data Model](/common-data-model/)

## Synapse industry data models

You can use Synapse industry database templates as predefined templates for your Azure Synapse Analytics environment's lake database. Each model is a set of business and technical data definitions, pre-designed to meet the needs of a particular industry.

Databases templates provide a query and processing interface for the data product files stored in your Azure Data Lake. For more information, see [What is Azure Database Templates](/azure/synapse-analytics/database-designer/overview-database-templates).

## Next steps

- [What is a data mesh?](what-is-data-mesh.md)
