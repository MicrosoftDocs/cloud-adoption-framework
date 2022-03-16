---
title: Manage master data
description: Learn about managing master data in Azure, including how to create, store, and synchronize between systems, and governance.
author: mboswell
ms.author: mboswell
ms.date: 03/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Master data management

Master data is data that describes the objects around a business process. Customer, product and other reference data are all master data objects. Master data isn't frequently altered and isn't transactional in nature.

Master data management (MDM) is central to any data governance program, making the creation of trusted master data critical. You can create master data by defining master data entities in your data catalog's business glossary. Register data sources in your data catalog and search multiple data stores across the distributed data landscape to discover where various master data is located.

You can map the physical data names of discovered master data to your common business vocabulary in Azure Purview. You can also clean, match, and integrate the data you discovered across the distributed data landscape. You can then the data to create golden master data records stored in a central MDM system.

:::image type="content" source="./images/central-master-data-management.png" alt-text="Diagram that shows central master data management.":::

Once it's been created and centrally stored, master data can be synchronized with all systems that use it to ensure their consistency.

It's important to govern your master data maintenance. Identify where maintenance takes place, noting which tasks from which business processes are involved. You can use business process identification and create, read, update, or delete (CRUD) analysis to identify the tasks. Once you identify which tasks within a process maintain master data, you then can govern the data. Working out this data governance is often a manual task, but process mining and database log file analysis now aid you in the process.

## Master data partner solutions

Microsoft has partnered with Profisee and CluedIn to provide native integrations for Azure Purview. Assess these products for your organization's master data requirements.

- [Data governance with Profisee and Azure Purview](/azure/architecture/reference-architectures/data/profisee-master-data-management-purview)
- [Migrate master data services to Azure with CluedIn and Azure Purview](/azure/architecture/reference-architectures/data/migrate-master-data-services-with-cluedin)

Other vendors in this space are:

- [SAP master data governance](https://www.sap.com/products/master-data-governance.html)
- [Semarchy](https://www.semarchy.com/)

## Alternative solutions

Outside of a purpose-built MDMapplication, some of the technical capabilities needed to build an MDM solution can be found within the Azure ecosystem.

- **Data quality:** You can build data quality into your integration processes when loading to an analytics platform. For example, you can apply data quality transformations in an [Azure Data Factory](https://azure.microsoft.com/services/data-factory/) pipeline using hardcoded scripts.

- **Data standardization and enrichment:** [Azure Maps](https://azure.microsoft.com/services/azure-maps/) is available to provide data verification and standardization for address data, which can be used in Azure Functions and/or Azure Data Factory. The standardization of other data might require development of hardcoded scripts.

- **Duplicate data management:** You can use Azure Data Factory to [deduplicate rows](/azure/data-factory/how-to-data-flow-dedupe-nulls-snippets) where sufficient identifiers are available for an exact match. Custom hardcoded scripts are likely required by the logic to merge matched with appropriate survivorship.

- **Data stewardship:** [Power Apps](https://powerapps.microsoft.com/) can be used to quickly develop simple data stewardship solutions for managing data in Azure. The solutions contain appropriate user interfaces for review, workflow, alerts, and validations.

## Next steps

- [Data quality](govern-data-quality.md)
