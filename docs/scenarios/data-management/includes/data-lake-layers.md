---
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: include
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

Depending on technology and vendor, the layers inside a data lake use different terminology. This table gives guidance on how cloud-scale analytics applies them:

| Cloud-scale analytics | Delta Lake | Other terms             | Description                                                                                                      |
|-------------------------------|------------|-------------------------|------------------------------------------------------------------------------------------------------------------|
| Raw                           | Bronze     | Landing and Conformance | Ingestion Tables                                                                                                 |
| Enriched                      | Silver     | Standardization Zone    | Refined Tables - stored full entity, consumption-ready recordsets from systems of record.                        |
| Curated                       | Gold       | Product Zone            | Feature or aggregated tables. Primary zone to consume data products by applications, teams, and users.           |
| Development                     | --         | Development Zone        | Location for data engineers and scientists, comprising both an analytics sandbox and a product development zone. |
