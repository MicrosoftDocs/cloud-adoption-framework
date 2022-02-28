---
title: Data Mesh checklist
description: Learn the stages companies typically go through to deploy a data mesh
author: mboswell
ms.author: mboswell
ms.date: 03/03/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Getting Started Checklist

During your data journey with data management and analytics scenario, you'll find there are multiple stages in the adoption lifecycle. This section aims to give you a quick getting started checklist to adopt the scenario in stages.

- Stage 1 - First landing zone
- Stage 2 - Extra Data Domains
- Stage 3 – Improve consumption readiness
- Stage 4 – Critical governance components​

## Stage 1 - First landing zone

- Define first use case(s)​
- Deploy first data management landing zone​
- Deploy first data landing zone
- Define first (ingestion) pattern (for example, batch parquet)​
- Develop first data product (ingested raw, abstracted to product)​
- Determine 'just-enough' governance​
- Define metadata requirements (application information, schema metadata)
- Register first data consumer (manual process)

## Stage 2 - Extra Data Domains

- Refine target architecture​
- Deploy more data landing zones​
- Extend with second, third and fourth data products​
- Realize data product metadata repository (database or excel)​
- Implement first set of controls (data quality, schema validation)​
- Realize consuming pipeline (taking input as output)​
- Establish data ownership​

## Stage 3 – Improve consumption readiness

- Implement self-service registration, metadata ingestion​
- Offer other transformation patterns (transformation framework, ETL tools, etc.)​
- Enrich controls on provider side (glossary, lineage, linkage)​
- Implement consuming process: approvals, use case metadata, deploy secure views by hand​
- Establish data governance control board​

## Stage 4 – Critical governance components​

- Apply automation: automatic secure view provisioning​
- Deploy strong data governance, set up dispute body​
- Finalize data product guidelines​
- Define extra interoperability standard​
- Develop self-service data consumption process​
- Develop data query, self-service, catalog, lineage capabilities, etc.​- Develop more data marketplace capabilities.​

## Summary

The above stages will allow you to set up a minimal viable product at stage one, learn and iterate onto stage two. Throughout this staged approach, you're growing in maturity in creating a self-service, scalable and governed platform.

## Next steps

[Overview of reference architectures for data management and analytics in Azure](reference-architecture-overview.md)
