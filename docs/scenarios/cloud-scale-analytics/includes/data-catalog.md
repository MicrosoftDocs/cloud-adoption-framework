---
author: mboswell
ms.author: mboswell
ms.date: 09/26/2024
ms.topic: include
ms.custom: e2e-data-management, think-tank
---

The data catalog registers and maintains the data information in a centralized place and makes it available for the organization. It ensures that enterprises avoid duplicate data products caused by redundant data ingestion by different project teams.

We recommend you provision a data catalog service to define the metadata of the data products stored across the data landing zones.

Cloud-scale analytics relies on [Microsoft Purview](/azure/purview/overview) to serve as:

- A system of registration
- A discovery for enterprise data sources
- A data classification engine
- An API for registering and reading data information
- Provide health management reports
- Manage Data Integrity via data quality
- Provide secure, self-service access

Because the data catalog is tenant based service, it can communicate with each data landing zone by creating a Managed Virtual Network deployed to the region of your data landing zones. From, their you can deploy Azure Managed Virtual Network Integration Runtimes (IR) within Microsoft Purview Managed Virtual Networks in any available Microsoft Purview region. From there, the managed virtual network IR can use private endpoints to securely connect to and scan the supported data sources. For more information, see [Use Managed virtual network with your Microsoft Purview account](/purview/catalog-managed-vnet). Creating a Managed virtual network IR within Managed Virtual Network ensures that data integration process is isolated and secure.

> [!NOTE]
> Although this documentation focuses primarily on using Microsoft Purview for governance, enterprises might have invested in other products, such as Alation, Okera, or Collibra. These solutions are subscription based and we would recommend deploying thsese to the data management landing zone. Be aware that some custom integration might be required.
