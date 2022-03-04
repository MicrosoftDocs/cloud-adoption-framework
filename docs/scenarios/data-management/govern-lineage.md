---
title: Data Lineage requirements
description: Understand data lineage for data governance.
author: mboswell
ms.author: mboswell
ms.date: 02/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data lineage

Data lineage plays an important component in an data management and analytics scenario. Linage shows dependencies between raw data and the finished data products, it gives information about the transformations and manipulations that has happened to the raw that in order to create the data product. Lineage is a factor in understanding data quality and validating compliance. Lineage also adds context to datasets and products that allows for discoverable and self-serviceable data products.

One of the primary features of a data catalog is the ability to show the lineage between data products. Azure Purview supports capturing data lineage from three Azure Data Factory activities: copy data, data flow, and execute SSIS package. Along with the native integration, custom lineage reporting is also supported via Apache Atlas hooks or REST API.

:::image type="content" source="./images/data-lineage.png" alt-text="Diagram of data lineage." lightbox="./images/data-lineage.png":::

> [!IMPORTANT]
> It's recommended that Azure Data Factory or Azure Synapse pipelines be used for ingestion solutions as it will enable data lineage in Azure Purview. Other ingestion patterns should use Apache Atlas API to update data lineage as part of their data processing.

## Next steps

- [Master data management](govern-master-data.md)
