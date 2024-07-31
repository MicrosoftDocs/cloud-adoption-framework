---
title: What is a data product?
description: Learn about data products
author: sasever
ms.author: sasever
ms.date: 08/01/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# What is a data product?

Every application creates and stores data either temporarily or permanently. Many applications also create and save data for operational management purposes, such as error logging and health monitoring. To consume and process the data that these applications produce, centralized data teams use extract, transform, and load (ETL) processes. Application operation teams often have other data processing flows for data like application health data and KPI status monitoring data.

For data integration, a traditional waterfall approach in which teams follow a specific order of phases isn't ideal. It can lead to knowledge gaps, ownership problems, and communication conflicts that affect your data's quality, timeliness, and value for users. Application teams are responsible for application performance and success. When they use a waterfall approach, they make changes to downstream processes that other teams own. Sometimes these changes can affect other areas. For example, a minor upstream change might drastically alter a KPI's trend. These data problems can affect your ability to make critical decisions.

The [data mesh](./what-is-data-mesh.md) approach prevents these problems by adopting the concept of *data as a product*. Application owners and application teams treat data as a fully contained product that they're responsible for, rather than a byproduct of some process that other teams manage. Both applications and analytical data-serving tasks are within domain responsibility areas.

Data products are created specifically for analytical consumption. They have defined and agreed-upon shapes, consumption interfaces, and maintenance and refresh cycles, all of which are documented.

Data products are processed domain data assets or datasets that are shared with downstream processes through interfaces in a service-level objective (SLO). Unless otherwise required, you should process, shape, cleanse, aggregate, and normalize your raw data to meet agreed-upon quality standards before you make it available for consumption.

The following sections outline common characteristics of good data products.

## Data product characteristics

Ensure that your data products are:

- **Discoverable, understandable, and trustworthy.** To provide discoverability and clarity, domain teams share and update information about each data product, its data, its meaning, the format of shape of its data, and its refresh cycle. They communicate changes to the data or shape to downstream consumers in a timely manner. To ensure trustworthiness, interfaces provide time-bounded backwards compatibility for data product shapes.

- **Addressable, natively accessible, and secure.** To provide addressability, create defined processes to locate and gain access to each data product. Implement security measures for various access requirements. Your data domain ownership mentality shifts from gatekeeping data to serving data with well-defined security precautions. Access interfaces are well-documented and can vary in different technologies. Commonly used interfaces for natively accessible data products include APIs, database users, tables, or views, and files with necessary access rights.

- **Interoperable, truthful, and valuable.** To provide interoperability, ensure that your data follows defined common standards, such as the same values having the same name and data type. For example, you might name a column that contains customer identification data *CustomerID* in every data product, and its data might always be an integer. Data products provide value to customers, and you can use them as upstream sources for new data products in the same or different domains. But you can't just carry and copy the same data product in multiple places. Each data product that comes from a previous data product should provide new value and information to downstream consumers. Data products must also provide truthful, non-erroneous data.

Well-designed, well-maintained data products and their interfaces help organizations avoid duplicating data and can help create a native single source of truth.

## Data product design recommendations

To fulfill data product serving requirements, your domain teams must acquire a new set of skills and use new tools and platforms.

To build the data applications and produce or serve data products, fully equip your domain application teams. Your teams can use a familiar technology stack to build data products. They might also prefer to have their own Spark instance or pipeline engine if possible. For example, a large domain that serves many data products might process and serve data products from their own Azure Synapse Analytics instance. Smaller organizations and smaller domains of large enterprises might develop and run their data applications on a shared platform, such as centrally located Azure Data Factory, Azure Synapse Analytics, or Azure Databricks instances.

Ensure that your data products have the common characteristics described in this article, your lineage repository reflects your data application lineage, and that you govern your implementation and access.

:::image type="content" source="../media/logical-data-application-options-in-adlz.png" alt-text="Diagram that shows possible data application logical layouts in domains and landing zones." lightbox="../media/logical-data-application-options-in-adlz.png":::

## Data product and data application guidance for Azure
<!---Direct Guidance for MS Products -->
You can position all possible approaches for your data application environment within Azure data landing zones if your domain application teams use a shared platform and a shared set of services.

:::image type="content" source="../media/data-application-options-in-adlz.png" alt-text="Diagram that shows the data-application-rg resource group from Data Applications Context and the shared-application-rg resource group from Core Services Context." lightbox="../media/data-application-options-in-adlz.png":::

For data application pattern templates for Azure data landing zones, see [Sample data applications](../../data-management/architectures/data-landing-zone-data-products.md#sample-data-applications).

## Next step

- [Design considerations for self-serve data platforms](self-serve-data-platforms.md)
