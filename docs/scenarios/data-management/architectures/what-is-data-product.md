---
title: What is a data product?
description: Learn about data products
author: sasever
ms.author: sasever
ms.date: 02/08/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# What is a data product?
<!---Intro -->
Every application creates and stores data either temporarily or permanently during the process of fulfilling the primary function of the application. Many well designed applications also creates and saves data for operational management purposes like error logging and health monitoring. Data produced by these applications traditionally consumed and further processed by centralized data integration teams upon need of business via ETL processes. It is also common for application operation teams to have additional data processing flows for various purposes like monitoring the application health or application KPI status.

<!---Problem -->

The traditional approach having a waterfall of teams and responsibilities in data integration creates knowledge gaps, ownership problems and communication conflicts which in the long run effects the quality, timeliness and even value of the data for its end-users. Because the application team's mean responsibility is the performance and success of the application itself, reflection of the changes performed for this purpose to the downstream processes which are owned by other teams, frequently does not work as it should. In such a scenario it is inevitable to find yourself noticing the big effect of a so-called minor upstream change, after a C-level asks the question of why her KPI's trend changed so unusually in last two weeks. Sometimes you are even lucky that you heard it at that stage, before the data is used, lets say for very critical decisions.

<!---Solution Suggestion -->

**[Data Mesh](./what-is-data-mesh.md)** approach focuses on solving these problems by giving the data a product notion, namely **data as a product**. Not a bi-product of a process that is taken care by others if they need it, but a fully contained product whose responsibility is owned by the application owners and team itself. With this approach, now, not only the application is in the responsibility area of the domain but also any kind of analytical data serving task.

<!---design considerations -->

Is every data created by the domain applications a **'Data Product'**? Not necessarily.
**Data Product** is the **data** that is created specifically **as a product** for **analytical** consumption purposes. It has a defined and agreed **shape**, defined and agreed **consumption interfaces** and again defined and agreed **maintenance & refresh cycle** and it is **documented**.

Data product is the processed version of domain data assets/datasets that are agreed to share with downstream processes through agreed interfaces within an SLO. Unless it is really required so, it should not be the raw version of the data exposed to consumption as it is, but should be processed, shaped, cleansed, fitting into an agreed quality standard even into some level, it can be aggregated or normalized. Data served as a data product should comply with some common characteristics.

## Characteristics of Data served as a Product

A well designed data product should follow below characteristics:

**Discoverable, Understandable, Trustworthy :** The information about what the data product is, which data it contained, what it means, the format and shape of the data and the refresh cycle should be shared and kept up to date by the domain teams to provide **discoverability** and **understandability**. The changes in the data content and shape should be communicated to the downstream consumers timely and the interfaces should provide a time bounded backwards compatibility for the data product shape to provide **trustworthiness**.

**Addressable, Natively Accessible and Secure :** There should be defined process for locating and gaining access to the data product itself(the information about the data being accessible in the organization does not necessarily mean that the data itself can be accessible by everyone.) to provide **addressability**. The necessary **security** measures for different access requirements should be in place. The mentality of the data domain ownership should shift from protecting by gate keeping to serving data with well defined security precautions. The offered access interfaces should be well documented. Access interfaces can vary in different technologies. Providing an API, a database user and table/view, a file in a certain location with necessary access rights can be listed as some example possible commonly used interfaces to have a **natively accessible** data product.

**Interoperable, Truthful Valuable on its own:** The data product should also follow some defined common standards to provide **interoperability** like same value having always the same name, same data type across the board. For example the field/column containing the identification of the customer being CustomerID in every data product and its type always being integer, or using snake_case or camelCase for naming across the board. It also should provide a **value** for its consumer as it is, but if required it also can be an upstream source to create new data products in the same or different domains. This should not be understood that we can carry and copy the same data product all over. the new data products sourcing others should provide a new value, information to its downstream consumers. Finally a data product should comply to some base quality standards and provide non-erroneous **truthful** data.

Well designed, maintained and owned data products and data product interfaces also help organizations preventing from unnecessary data and process duplications and can lead to a native single source of truth usage across the board.

## Data Product Design Recommendations
<!---design recommendations -->

Fulfilling the requirements of serving data about their domain and application as a product, requires domain teams to acquire new set of skills, use new tools and platforms.

First of all the domain application teams need to be fully equipped to be able to build their **data applications** which produces and serves one or many **data products**. The teams can either use a familiar to them technology stack to build the data applications, for example a domain operations team running mainframes for certain applications, can perfectly build a Cobol based data application. They can also prefer having their own spark instance or pipeline engine if it is feasible, to build and run their data applications, for example a very large domain serving many data products can decide having their own Azure Synapse Analytics,and process and serve their data products from there. In a relatively smaller company or smaller domains of a big enterprise can also decide to use a provided shared platform to develop and run their data applications, like having a centrally located Azure Data Factory, Azure Synapse Analytics or Azure Databricks. What ever the approach is, the common characteristics of a data product should be there, the data application lineage should be reflected to a lineage repository, implementation and access should be governed and policy driven the outcome data product of data application should follow the principles of data products and be Discoverable, Understandable, Trustworthy, Addressable, Natively Accessible, Secure, Interoperable, Truthful and Valuable on its own.

:::image type="content" source="../images/logical-data-application-options-in-adlz.png" alt-text="Diagram that shows possible data application logical lay outs in domains and landing zones." lightbox="../images/logical-data-application-options-in-adlz.png":::

## Data Product and Data Application Guidance for Azure
<!---Direct Guidance for MS Products -->

Within an Azure Data Landing Zone, we can position all possible approaches for a data application environment. If the domain application teams choice of data application architecture is using a shared platform, set of Services.

:::image type="content" source="../images/data-application-options-in-adlz.png" alt-text="Diagram that shows data-application-rg resource group from Data Applications Context and  shared-application-rg resource group from Core Services Context for data management and analytics scenario." lightbox="../images/data-application-options-in-adlz.png":::

In Data Management & Analytics guidance, within Azure Data Landing Zones implementations we provide three different frequently used data application patterns as a template. For detailed information on those please refer to [Data management and analytics scenario data products in Azure - Sample data applications](../architectures/data-landing-zone-data-products.md#sample-data-applications)

## Next steps

[Design considerations for self-serve data platforms](self-serve-data-platforms.md)