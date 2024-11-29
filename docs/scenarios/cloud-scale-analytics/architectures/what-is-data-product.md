---
title: What is a data product?
description: Learn about the data mesh approach, which adopts the concept of data as a product. Learn how to create effective data products and use them in your design.
author: sasever
ms.author: sasever
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# What is a data product?

Every application creates and stores data either temporarily or permanently. Many applications also create and save data for operational management purposes, such as error logging and health monitoring. To consume and process the data that these applications produce, centralized data teams use extract, transform, and load (ETL) processes. Application operation teams often have other data processing flows for data like application health data and KPI status monitoring data.

For data integration, a traditional waterfall approach, in which teams follow a specific order of phases, isn't ideal. It can lead to knowledge gaps, ownership problems, and communication conflicts that affect your data's quality, timeliness, and value for users. Application teams are responsible for application performance and success. When they use a waterfall approach, they make changes to downstream processes that other teams own. Sometimes these changes can affect other areas. For example, a minor upstream change might drastically alter a KPI's trend. These conflicts can affect your ability to make critical decisions.

## Data as a product

To prevent these problems, the [data mesh](./what-is-data-mesh.md) approach adopts the concept of *data as a product*. Application owners and application teams treat data as a fully contained product that they're responsible for, rather than a byproduct of another team's process. Both applications and analytical data-serving tasks are within domain responsibility areas.

Data products are created specifically for analytical consumption. They have defined and agreed-upon shapes, consumption interfaces, and maintenance and refresh cycles, all of which are documented.

Data products are processed domain data assets or datasets that you can share with downstream processes through interfaces in a service-level objective. Unless otherwise required, you should process, shape, cleanse, aggregate, and normalize your raw data to meet agreed-upon quality standards before you make it available for use.

The following sections outline common characteristics of good data products.

## Data product characteristics

Ensure that your data products are:

- **Discoverable, understandable, and trustworthy.** To provide discoverability and clarity, share and update information about each data product, its data, its meaning, the shape format of its data, and its refresh cycle. Communicate data changes or shape changes to downstream consumers in a timely manner. To ensure trustworthiness, interfaces provide time-bounded backwards compatibility for data product shapes.

- **Addressable, natively accessible, and secure.** To provide addressability, create defined processes to locate and gain access to each data product. Implement security measures for various access requirements. Shift your data domain ownership mentality from gatekeeping data to serving data with well-defined security precautions. Well-documented access interfaces can vary across different technologies. Commonly used interfaces for natively accessible data products include APIs, database users, tables, or views, and files with necessary access rights.

- **Interoperable, truthful, and valuable.** To provide interoperability, ensure that your data follows defined common standards, such as values that have the same name and data type. For example, you might name a column that contains customer identification data *CustomerID* in every data product, and its data might always be an integer. Data products provide value to customers, and you can use them as upstream sources for new data products in the same domain or different domains. But you can't just carry and copy the same data product in multiple places. Each data product that comes from a previous data product should provide new value and information to downstream consumers. Data products must also provide truthful, accurate data.

Use well-designed, well-maintained data products and their interfaces to help avoid duplicating data and create a native single source of truth.

## Data product design recommendations

To fulfill data product serving requirements, your domain teams must acquire a new set of skills and use new tools and platforms.

To build the data applications and produce or serve data products, fully equip your domain application teams. Your teams can use a familiar technology stack to build data products. They might also prefer to have their own Spark instance or pipeline engine. For example, a large domain that serves many data products might process and serve data products from their own Azure Synapse Analytics instance. Smaller organizations and smaller domains of large organizations might develop and run their data applications on a shared platform, such as a centrally located Azure Data Factory, Azure Synapse Analytics, or Azure Databricks instance.

Ensure that your data products have the common characteristics that are described in this article, that your lineage repository reflects your data application lineage, and that you govern your implementation and access.

The following diagram shows an example data application logical layout in a domain and landing zone.

:::image type="content" source="../media/logical-data-application-options-in-adlz.png" alt-text="Diagram that shows a possible data application logical layout in a domain and landing zone." lightbox="../media/logical-data-application-options-in-adlz.png":::

## Next step

- [Design considerations for self-serve data platforms](self-serve-data-platforms.md)