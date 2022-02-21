---
title: Data lifecycle requirements
description: Understand data lifecycle for data governance.
author: mboswell
ms.author: mboswell
ms.date: 02/16/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---


# Data lifecycle

Data products could have different lifecycles. We recommend applying policies to regulate the data lifecycle. A typical pattern is that newly ingested data is used and accessed often. As the age since ingesting increases, the rate of data access decreases. Older data will see a drastic drop in usage. Your data products and entities in these products could have different lifecycles. Some data can stay unused after the initial ingestion or is rarely accessed once stored. Some data products could expire days or months after creation, while other data products are actively used and modified throughout their lifetimes. Most countries have regulations related to how long you're required to store data such as personal data and accounting data. For example, a country might require retention of primary documentation for five years, like incoming and outgoing invoices, cash book balances, bank vouchers, and salary slips. Retention of secondary documentation for three to five years, like letters, agreements, and notes.

In Azure, the data lifecycle is handled by each relevant service containing persisted data.

- For more information, see [Lifecycle management](./best-practices/data-lake-key-considerations.md#lifecycle-management).
