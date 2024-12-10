---
title: Manage master data
description: Learn about managing master data in Azure, including how to create, store, and synchronize between systems, and governance.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Master data management

Master data describes the objects around a business process. Customer, product, and other reference data are all master data objects. Master data isn't frequently altered, and though it's used to describe transactions, it isn't transactional in nature.

Master data management (MDM) is central to any data governance program, making the creation of trusted master data critical. Create master data by defining master data entities in your data catalog's business glossary. You can register data sources in your data catalog and search multiple data stores across the distributed data landscape to discover where various master data is located.

You can map the physical data names of discovered master data to your common business vocabulary in Microsoft Purview. You can also clean, match, and integrate the data you discovered across the distributed data landscape and use it to create golden master data records stored in a central MDM system.

:::image type="content" source="./images/central-master-data-management.png" alt-text="Diagram that shows central master data management.":::

After master data has been created and centrally stored, it can be synchronized with all systems that use master data to ensure their consistency.

It's important to govern your master data maintenance. Identify where maintenance takes place, noting which tasks from which business processes are involved. You can use business process identification and create, read, update, or delete (CRUD) analysis to identify these tasks. After you identify the tasks that maintain master data, you can then govern the data. Working out this data governance is often a manual task, but process mining and database log file analysis can aid you in the process.

## Master data partner solutions

Microsoft has partnered with partners to provide native integrations for Microsoft Purview. Assess these products for your organization's master data requirements.

- [Microsoft Purview and Profisee integration for master data management](/purview/profisee-master-data-management-purview)
- [Microsoft Purview and CluedIn integration for master data management](/purview/cluedin-master-data-management-purview)
- [Master Data Management with Semarchy](/purview/semarchy-master-data-management-purview)
- [Reltio Integration for Microsoft Purview](/purview/data-governance-with-reltio-and-purview)

## Alternative solutions

Outside of a purpose-built MDM application, some of the technical capabilities needed to build an MDM solution can be found within the Azure ecosystem.

- **Data quality:** You can build data quality into your integration processes when loading to an analytics platform. For example, you might apply data quality transformations in an [Azure Data Factory](https://azure.microsoft.com/services/data-factory/) pipeline using hardcoded scripts.

- **Data standardization and enrichment:** [Azure Maps](https://azure.microsoft.com/services/azure-maps/) is available to provide data verification and standardization for address data, which can be used in Azure Functions and/or Azure Data Factory. The standardization of other data might require the development of hardcoded scripts.

- **Duplicate data management:** You can use Azure Data Factory to [deduplicate rows](/azure/data-factory/how-to-data-flow-dedupe-nulls-snippets) where sufficient identifiers are available for an exact match. Custom hardcoded scripts are likely required by the logic to merge matched data with appropriate survivorship.

- **Data stewardship:** [Power Apps](https://powerapps.microsoft.com/) can be used to quickly develop simple data stewardship solutions for managing data in Azure. These solutions contain appropriate user interfaces for review, workflow, alerts, and validations.

## Next steps

> [!div class="nextstepaction"]
> [Data quality](../cloud-scale-analytics/govern-data-quality.md)
