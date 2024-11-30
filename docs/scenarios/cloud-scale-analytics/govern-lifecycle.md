---
title: Data lifecycle management
description: Understand data lifecycle for data governance.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data lifecycle management

Data lifecycle management is the practice of using specific policies to effectively manage data for the entire time it exists within your system. These policies should consist of overarching storage and data policies that drive your data management processes. Since business goals and drivers dictate data lifecycle management policies, they generally tie into a framework of overall IT governance, management, and service level agreements (SLAs).

After you know what type of data you have and how it will be used, you already know its most likely evolution and destiny. You need to understand how your data evolves, determine how it grows, monitor changes in its usage over time, decide how long it should exist, and adhere to all rules and regulations that apply to that data.

Data lifecycle management addresses these needs using a combination of processes, policies, and software so that your teams can use appropriate technology for each phase of your data's lifecycle.

## Lifecycle of data

Data products can have different lifecycles. In a typical lifecycle pattern, newly ingested data gets used and accessed often. As its age increases, its rate of access often decreases, and older data sees a drastic drop in usage. Some data products might expire days or months after their creation, while other data products are actively used and modified across their entire lifetimes.

Data lifecycles can differ from this typical pattern, though. Some data remains unused after its initial ingestion or is rarely accessed after it's been stored. Most places have regulations that dictate how long you're required to store data, such as personal data and accounting data. A particular country/region might require you to retain primary documentation for five years for data such as incoming and outgoing invoices, cash book balances, bank vouchers, and salary slips. It also might require secondary documentation to be retained for three to five years, which includes things like letters, agreements, and notes.

## Managing data lifecycles

There are two ways to approach data lifecycle management in cloud-scale analytics:

- You can use the inbuilt data lifecycle features of each Azure service containing persisted data, such as [Azure Data Lake](/azure/storage/blobs/lifecycle-management-overview). This method is good for moving data to cold and archive tiers but fails to ensure data is deleted after a specified amount of time.

> [!IMPORTANT]
> The archive tier is not currently supported for zone-redundant storage accounts. For more information, see [data redundancy](/azure/storage/common/storage-redundancy).

- You can integrate data lifecycle in an onboarding process, which gives application business owners an opportunity to define their data lifecycle policy. This process involves a custom application to capture key metrics into [metadata standards](govern-metadata-standards.md) for each data product. Part of this method involves moving data from hot to cold to archive and ensures the deletion of data after a specified amount of time.

## Next steps

> [!div class="nextstepaction"]
> [Metadata standards](govern-metadata-standards.md)