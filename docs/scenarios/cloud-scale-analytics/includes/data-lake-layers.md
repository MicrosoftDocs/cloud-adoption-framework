---
author: stephen-sumner
ms.author: pnp
ms.date: 09/26/2024
ms.topic: include
ms.custom: e2e-data-management, think-tank
---

Data lake layers use different terminology depending on technology and vendor. This table provides guidance on how to apply terms for cloud-scale analytics:

| Cloud-scale analytics | Delta Lake | Other terms             | Description                                                                                                      |
|-------------------------------|------------|-------------------------|------------------------------------------------------------------------------------------------------------------|
| Raw                           | Bronze     | Landing and conformance | Ingestion tables                                                                                                 |
| Enriched                      | Silver     | Standardization zone    | Refined tables. Store full entity, consumption-ready recordsets from systems of record.                        |
| Curated                       | Gold       | Product zone            | Feature or aggregated tables. Primary zone for applications, teams, and users to consume data products.           |
| Development                     | --         | Development zone        | Location for data engineers and scientists, which consists of an analytics sandbox and a product development zone. |
