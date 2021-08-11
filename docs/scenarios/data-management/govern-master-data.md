---
title: Manage master data in Azure
description: Learn about managing master data, including creation, storage, synchronization between systems, and governance in Azure.
author: mboswell
ms.author: mboswell
ms.date: 07/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Manage master data

Master data management (MDM) is central to any data governance program, making the creation of trusted master data critical. Create this data by defining master data entities in the business glossary in Azure Data Catalog. Then use the data catalog to register data sources. And finally, discover where various master data is located across multiple data stores in the distributed data landscape.

You can map the physical data names of discovered master data to the common business vocabulary in Azure Purview. Then you'll be able to learn how to clean, match, and integrate the data discovered to create golden master data records stored in a central MDM system. You can use Azure Data Lake Storage and Azure Data Factory to create these records, as shown in [Combining Microsoft technologies to help govern data](./govern-technology.md#combine-microsoft-technologies-to-help-govern-data).

:::image type="content" source="./images/central-master-data-management.png" alt-text="Diagram that shows central master data management.":::

Once created and stored centrally, master data can be synchronized with all other systems that need it to make sure they're consistent.

It's important to govern your master data maintenance. The challenge is identifying in which tasks of which business processes that maintenance happens. This identification can be done using business process identification and create, read, update, or delete (CRUD) analysis. It's often a manual task to work out this governance. But now it's helped by the emergence of process mining and analyzing database log files. Once you identify the tasks within a process that maintains master data, it can be governed.

## Govern consent management using master data

MDM provides the ideal place for customer consent management. Collect consents from all applications that request it. Then match them with customer master data, and store all consents in extra tables along with the master data record in the MDM system.

## Next steps

- [Data sharing agreements](./govern-data-sharing-agreements.md)
