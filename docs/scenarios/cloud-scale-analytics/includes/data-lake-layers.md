---
author: mboswell
ms.author: mboswell
ms.date: 09/26/2024
ms.topic: include
ms.custom: e2e-data-management, think-tank
---

Data lake layers use different terminology depending on technology and vendor. This table provides guidance on how to apply terms for cloud-scale analytics:

| Cloud-scale analytics | Delta Lake | Other terms             | Description                                                                                                      |
|-------------------------------|------------|-------------------------|------------------------------------------------------------------------------------------------------------------|
| Raw                           | Bronze     | Landing and Conformance | Ingestion Tables                                                                                                 |
| Enriched                      | Silver     | Standardization Zone    | Refined Tables. Stored full entity, consumption-ready recordsets from systems of record.                        |
| Curated                       | Gold       | Product Zone            | Feature or aggregated tables. Primary zone for applications, teams, and users to consume data products.           |
| Development                     | --         | Development Zone        | Location for data engineers and scientists, comprising both an analytics sandbox and a product development zone. |
