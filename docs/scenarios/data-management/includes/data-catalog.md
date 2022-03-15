---
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: include
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

We recommend you provision a catalog service to define the metadata of the data products stored across the data landing zones.

The catalog registers and maintains the data information in a centralized place and makes it available for the organization. It ensures that enterprises avoid duplicate data products caused by redundant data ingestion by different project teams.

Cloud-scale analytics relies on [Azure Purview](/azure/purview/overview) to serve as:

- System of registration
- Discovery for enterprise data sources
- Data classification engine
- Policy store
- API for registering and reading data information
- Compliance dashboard hub

Because the data catalog is part of the data management landing zone, it can communicate with each data landing zone via its virtual network (VNet) peering and self-hosted integration runtimes. Discovery of data products in on-premises stores and other public clouds is achieved by more deployments of self-hosted integration runtimes.

> [!NOTE]
> Although this documentation focuses primarily on using Azure Purview for data catalog capabilities and data classification, enterprises might have invested in other products, such as Alation, Okera, or Collibra. If this is the case, work with your vendor to apply the principles described for a data management landing zone as close as you can. Be aware that some custom integration might be required.
