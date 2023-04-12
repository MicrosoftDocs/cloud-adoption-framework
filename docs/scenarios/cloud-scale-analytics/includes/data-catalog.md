---
author: mboswell
ms.author: mboswell
ms.date: 03/15/2022
ms.topic: include
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

The data catalog registers and maintains the data information in a centralized place and makes it available for the organization. It ensures that enterprises avoid duplicate data products caused by redundant data ingestion by different project teams.

We recommend you provision a data catalog service to define the metadata of the data products stored across the data landing zones.

Cloud-scale analytics relies on [Microsoft Purview](/azure/purview/overview) to serve as:

- A system of registration
- A discovery for enterprise data sources
- A data classification engine
- A policy store
- An API for registering and reading data information
- A compliance dashboard hub

Because the data catalog is part of the data management landing zone, it can communicate with each data landing zone via its virtual network (VNet) peering and self-hosted integration runtimes. Discovery of data products in on-premises stores and other public clouds is achieved by more deployments of self-hosted integration runtimes.

> [!NOTE]
> Although this documentation focuses primarily on using Microsoft Purview for data catalog capabilities and data classification, enterprises might have invested in other products, such as Alation, Okera, or Collibra. If this is the case, work with your vendor to apply the principles described for a data management landing zone as nearby as possible. Be aware that some custom integration might be required.
