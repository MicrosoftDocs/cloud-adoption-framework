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

# What is Data Lifecycle Management?

Data Lifecycle Management is the practice of applying certain policies to effective data management. Data Lifecycle Management policy should consists of an overarching storage and data policies that drive management processes. Policies are dictated by business goals and drivers. Therefore, policies generally tie into a framework of overall IT governance and management and service level agreements (SLAs). Once you know the type of data and how it will be used, you already have an understanding of what its evolution and final destiny is likely to be. The challenge now before the teams, is to understand how their data evolves, determine how it grows, monitor how its usage change over time, and decide how long it should survive. Whilst adhering to all the rules and regulations that now apply to that data. Data Lifecycle Management is should address these issues, with a combination of processes, policies and software so that the appropriate technology can be used for each phase of the lifecycle of the data.

## Lifecycle of data

Data products could have different lifecycles. We recommend applying policies to regulate the data lifecycle. A typical pattern is that newly ingested data is used and accessed often. As the age since ingesting increases, the rate of data access decreases. Older data will see a drastic drop in usage. Your data products and entities in these products could have different lifecycles. Some data can stay unused after the initial ingestion or is rarely accessed once stored. Some data products could expire days or months after creation, while other data products are actively used and modified throughout their lifetimes. Most countries have regulations related to how long you're required to store data such as personal data and accounting data. For example, a country might require retention of primary documentation for five years, like incoming and outgoing invoices, cash book balances, bank vouchers, and salary slips. Retention of secondary documentation for three to five years, like letters, agreements, and notes.

## Managing lifecycle of data

In the data management and analytics scenario their are two ways to approach data lifecycle management.

- Using the inbuilt data lifecycle features of each Azure service containing persisted data such as [Azure data lake](/azure/storage/blobs/lifecycle-management-overview). This is a great start for moving data to cold and archive tiers but fails to adhere to deleting of data after X amount of time.

- Integrating data lifecycle as part of an onboarding process to give the application business owners the opportunity to define their data lifecycle policy. This process would involve a custom application which would capture key metrics into [metadata standards](govern-metadata-standards.md) per data product. Part of the custom process would handle moving data from hot to cold to archive and deleting of data after X amount of time. For more information, see [Automation Services](./govern-data-sharing-agreements.md).

## Next steps

[Data sharing agreements in data management and analytics](govern-data-sharing-agreements.md)
