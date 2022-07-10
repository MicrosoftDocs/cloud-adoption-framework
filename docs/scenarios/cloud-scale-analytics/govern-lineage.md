---
title: Data lineage
description: Understand data lineage for data governance.
author: mboswell
ms.author: mboswell
ms.date: 03/15/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data lineage

Data lineage plays an important role in cloud-scale analytics. Lineage shows dependencies between raw data and finished products, describing the transformations and manipulations that turn that raw data into the final data products. It helps organizations understand data quality and validate compliance. It also adds context to datasets and products that enables data products to be discoverable and self-serviceable.

A primary of any data catalog is its ability to show the lineage between data products. Azure Purview supports data lineage capture from three Azure Data Factory activities:

* copy data
* data flow
* execute SSIS package

In addition to this native lineage reporting, Azure Purview also allows custom lineage reporting via Apache Atlas hooks or REST API.

:::image type="content" source="./images/data-lineage.png" alt-text="Diagram of data lineage." lightbox="./images/data-lineage.png":::

> [!IMPORTANT]
> Azure Data Factory and Azure Synapse pipelines are recommended for ingestion solutions because they enable data lineage in Azure Purview. Alternate ingestion patterns should use Apache Atlas API to update data lineage as part of their data processing.

## Azure Purview data lineage

One of Azure Purview's platform features is its ability to show the lineage between datasets created by data processes. Systems like Data Factory, Data Share, and Power BI capture the lineage of data as it moves. You can also get custom lineage reporting via Atlas hooks and REST API.

> [!TIP]
> For more information on supported systems and best practices, see the [Microsoft Purview Data Catalog lineage user guide](/azure/purview/catalog-lineage-user-guide).

## Next steps

Learn how to manage master data in Azure.

> [!div class="nextstepaction"]
> [Master data management](govern-master-data.md)
