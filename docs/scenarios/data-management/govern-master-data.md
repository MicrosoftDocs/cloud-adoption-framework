---
title: Manage master data
description: Learn about managing master data in Azure, including how to create, store, and synchronize between systems, and governance.
author: mboswell
ms.author: mboswell
ms.date: 02/14/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Master data management

Master data management (MDM) is central to any data governance program, making the creation of trusted master data critical. Create this data by defining master data entities in the business glossary in a data catalog. Then use the data catalog to register data sources. And finally, discover where various master data is located across multiple data stores in the distributed data landscape.

You can map the physical data names of discovered master data to the common business vocabulary in Azure Purview. Then you'll be able to learn how to clean, match, and integrate the data discovered to create golden master data records stored in a central MDM system.

:::image type="content" source="./images/central-master-data-management.png" alt-text="Diagram that shows central master data management.":::

Once created and stored centrally, master data can be synchronized with all other systems that need it to make sure they're consistent.

It's important to govern your master data maintenance. The challenge is identifying in which tasks of which business processes that maintenance happens. This identification can be done using business process identification and create, read, update, or delete (CRUD) analysis. It's often a manual task to work out this governance. But now it's helped by the emergence of process mining and analyzing database log files. Once you identify the tasks within a process that maintains master data, it can be governed.

## Master data partner solutions

Microsoft has partner with Profisee and CluedIn to provide native integrations into Azure Purview. It is recommended to assess these products for your master data requirements.

- [Data governance with Profisee and Azure Purview](/azure/architecture/reference-architectures/data/profisee-master-data-management-purview)
- [Migrate master data services to Azure with CluedIn and Azure Purview](/azure/architecture/reference-architectures/data/migrate-master-data-services-with-cluedin)

Some of the vendors other in this space are:

- [SAP master data governance](https://www.sap.com/products/master-data-governance.html)
- [Semarchy](https://www.semarchy.com/)

## Alternatives solutions

Absent a purpose-built MDMapplication, some of the technical capabilities needed to build an MDM solution may be found within the Azure ecosystem.

- Data quality - When loading to an analytics platform, data quality can be built into integration processes. For example, applying data quality transformations in an [Azure Data Factory](https://azure.microsoft.com/services/data-factory/) pipeline can be accomplished with hardcoded scripts.
- Data standardization and enrichment - [Azure Maps](https://azure.microsoft.com/services/azure-maps/) is available to provide data verification and standardization for address data. These can be used in Azure Functions and/or Azure Data Factory.  Standardization of other data may require development of hardcoded scripts.
- Duplicate data management - Azure Data Factory can be used to [deduplicate rows](/azure/data-factory/how-to-data-flow-dedupe-nulls-snippets) where sufficient identifiers are available for an exact match.  In this case, the logic to merge matched with appropriate survivorship would likely require custom hardcoded scripts.
- Data stewardship - [Power Apps](https://powerapps.microsoft.com/) can be used to quickly develop simple data stewardship solutions to manage data in Azure, along with appropriate user interfaces for review, workflow, alerts, and validations.

## Next steps

[Data quality](govern-data-quality.md)
