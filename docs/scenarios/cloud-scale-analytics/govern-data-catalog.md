---
title: Data catalog
description: Understand data catalog for data governance.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data catalog

[!INCLUDE [data-catalog](includes/data-catalog.md)]

## Data discovery

Data discovery reflects the state of all the data that the enterprise owns. This data is known as the data estate. During data discovery, the data estate is scanned and classified. The data scanning process connects directly to the data source according to a set schedule.

As you add a new data landing zone to the environment, the associated data lakes and polyglot persistence sources must be registered as sources for the data catalog crawlers to scan.

With automated discovery of your data estate to populate the catalog, you can:

- Crawl metadata from Azure and on-premises data sources
- Scan your data lakes, blobs, and other supported targets
- Extract schema from your data targets for XML, TSV, CSV, PSV, SSV, JSON, Parquet, Avro, and ORC file types
- Allow automated catalog updates through configurable scheduling of scans and scan rule sets

> [!IMPORTANT]
> When you add a new data landing zone to the environment, register the associated data lakes and polyglot storage through Azure DevOps as a source for the data catalog crawlers to scan, govern, and manage data integrity.

## Data classification

Microsoft Purview allows you to apply system or custom data classifications on file, table, or column assets.

Data classifications are like subject tags. Microsoft Purview marks and identifies the content of specific data types found within your data estate during scanning. You use sensitivity labels to identify the categories of classification types within your organizational data. You can also use sensitivity labels to group the policies you wish to apply to each category. Microsoft Purview makes use of the same sensitive information types as Microsoft 365, allowing you to extend your existing security policies and protections across your entire content and data estate.

Microsoft Purview can scan and automatically classify documents. For example, if you have a file named `multiple.docx` and it has a national ID number in its content, Microsoft Purview adds a classification such as `EU National Identification Number` in the asset detail page.

[Microsoft Defender for SQL](/azure/azure-sql/database/azure-defender-for-sql) is a feature available for Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics. It includes functionality for discovering and classifying sensitive data, surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. Microsoft Defender for SQL provides a single goto location for enabling and managing these capabilities.

## Next steps

> [!div class="nextstepaction"]
> [Data lineage](govern-lineage.md)