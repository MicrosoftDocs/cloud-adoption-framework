---
# This basic template provides core metadata fields for Markdown articles on docs.microsoft.com.

# Mandatory fields.
title: Data Sources Mapping to Service
description: Enterprise Scale Analytics and AI Architecture represents the Data Sources Mapping to Services
author: mboswell
ms.author: mboswell # Microsoft employees only
ms.date: 02/10/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: ready
---

# Data Sources Mapping to Service

The tables below map out the Ingestion and Processing Services to the common sources which typically need to be Ingest or Egest from Azure.

| ID | Mechanism                   | Note                           |
|----|-----------------------------|--------------------------------|
| B  | Azure Databricks            | Custom code (jdbc, jar etc.)   |
| C  | 3rd party                   | Wandisco, Attunity, GoldenGate |
| D  | Other                       | i.e. native capability         |
| E  | Power Platform + Logic Apps | Power Automate connectors      |

Table 6: Ingestion Services

| Provider | Type | Hosted | Category | Notes | Full Load Ingest | Incr. Load Ingest | Real Time Ingest | Full Load Egress | Incr. Load Egress | Real Time Egress |
|--|--|--|--|--|--|--|--|--|--|--|
| Oracle | Tabular | IaaS | Database | GoldenGate to ADLS | A, B | A, B | C | A, B | A, B | C |
| SQL Server | Tabular | IaaS | Database | SLT+Attunity | A, B | A, B | C, D2 | A, B | A, B | C, D2 |
| MySQL | Tabular | IaaS | Database | SLT+Attunity | A, B | A, B | C, D2 | A, B | A, B | C, D2 |
| SAP BW | Tabular | IaaS | Database | SLT+Attunity | A, B, C, D | A, B, C, D | C | - | - | - |
| SAP HANA | Tabular | IaaS | Database | SLT+Attunity | A, B, C, D | A, B, C, D | C | A, B | A, B | - |
| Impala | Tabular | IaaS | Database | - | A, B | A, B | - | B | B | - |
| SharePoint | List | SaaS | Record store | - | A, E | A, E | E | A, E | A, E | E |
| REST | REST | Various | REST | Xml, json, csv | A, B, E | A, B, E | A, B, E | A, B, E | A, B, E | A, B, E |
| Outlook | Email | SaaS | REST | Xml, json, csv | E | E | E | E | E | E |

Table 7: Data Sources Mapping to Service

Subject to destination Azure Data Migration service can replicate from on-prem/3rd party DB (SQL Server, Postgres, MySQL, Oracle) to Azure based DB.
