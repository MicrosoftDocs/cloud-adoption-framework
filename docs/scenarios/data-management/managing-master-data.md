---
title: "Managing master data"
description: Managing master data
author: mboswell
ms.author: mboswell
ms.date: 06/24/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Managing master data

Central to any data governance program is master data management. Creating trusted master data is therefore critical. This can be done by defining master data entities in the business glossary within Azure Data Catalog and then using the data catalog to register data sources and discover where disparate master data is located across multiple data stores in the distributed data landscape.

By mapping the physical data names of discovered disparate master data to the common business vocabulary in Azure Purview, it then becomes possible to know how to clean, match and integrate the data discovered to create golden master data records stored in a central MDM system. This can be done using Azure Data Lake Storage and Azure Data Factory as shown in [Combining Microsoft Technologies to Help Govern Data](technology-needed-for-end-to-end-governance.md#combining-microsoft-technologies-to-help-govern-data).

:::image type="content" source="images/central-master-data-management.png" alt-text="central master data management":::

Figure 1: Central Master Data Management

Once created and stored centrally, master data can then be synchronized with all other systems that need it to make sure they are consistent.

In addition, master data maintenance needs to be governed. The challenge is therefore to identify in which tasks of which business processes that maintenance occurs. This can be done using business process identification and CRUD analysis. However, it is often a manual task to work this out but is now helped by the emergence of process mining and analyzing database log files. Once the tasks within a process that maintain master data have been identified, it can be governed.

## Governing GDPR Consent Management Using Master Data

Finally, master data management (MDM) provides the ideal place for GDPR customer consent management. This can be done by collecting consents from all applications that request it, matching these with customer master data and storing all consents in additional tables along with the master data record in the MDM system.
