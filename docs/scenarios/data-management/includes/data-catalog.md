---
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: include
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

We recommend you have a catalog service provisioned to define the metadata of the data products stored across the data landing zones.

The catalog registers and maintains the data information in a centralized place and makes it available for the organization. It ensures that enterprises avoid duplicate data products caused by redundant data ingestion by different project teams.

Data management and analytics scenario relies on [Azure Purview](/azure/purview/overview) to serve as:

- System of registration
- Discovery for enterprise data sources
- Data classification engine
- Policy store
- API for registering and reading data information.
- Compliance dashboard hub

The data catalog can communicate with each data landing zone via its VNet peering and self-hosted integration runtimes since it's part of the data management landing zone. Discovery of data products in on-premises stores and other public clouds is achieved by more deployments of self-hosted integration runtimes.

> [!NOTE]
> Although this section of the documentation primarily focuses on using Azure Purview for data catalog capabilities combined with the data classification, labeling, and compliance policy enforcement capabilities of Azure Information Protection, we appreciate that many enterprises may have invested in other products such as Alation, Okera, and Collibra. If this is the case, work with your vendor to apply the principles described for a data management landing zone and get as close as you can. Be aware that some custom integration might be required.