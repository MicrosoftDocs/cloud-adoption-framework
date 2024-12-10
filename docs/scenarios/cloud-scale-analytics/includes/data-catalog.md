---
author: mboswell
ms.author: mboswell
ms.date: 11/11/2024
ms.topic: include
ms.custom: e2e-data-management, think-tank
---

The data catalog registers and maintains the data information in a centralized place and makes it available for the organization. It ensures that enterprises avoid duplicate data products caused by redundant data ingestion by different project teams. We recommend that you create a data catalog service to define the metadata of the data products stored across the data landing zones. 

Cloud-scale analytics depends on [Microsoft Purview](/azure/purview/overview) to register enterprise data sources, classify them, ensure data quality, and offer secure, self-service access.

Microsoft Purview is a tenant based service and can communicate with each data landing zone by creating a Managed Virtual Network deployed to the region of your data landing zones. You can deploy Azure Managed Virtual Network Integration Runtimes (IR) within Microsoft Purview Managed Virtual Networks in any available Microsoft Purview region. From there, the managed virtual network IR can use private endpoints to securely connect to and scan the supported data sources. For more information, see [Use Managed virtual network with your Microsoft Purview account](/purview/catalog-managed-vnet). Creating a Managed virtual network IR within Managed Virtual Network ensures that data integration process is isolated and secure.

When using Azure Databricks, we recommend using [Azure Databricks Unity Catalog](/azure/databricks/data-governance/unity-catalog/azure-managed-identities) in addition to Microsoft Purview. Azure Databricks Unity Catalog provides centralized access control, auditing, lineage, and data discovery capabilities across Databricks workspaces. For best practices for setting up Unity Catalog, see [Unity Catalog best practices](/azure/databricks/data-governance/unity-catalog/best-practices).

> [!NOTE]
> Although this documentation focuses primarily on using Microsoft Purview for governance, enterprises might have invested in other products, such as Alation, Okera, or Collibra. These solutions are subscription based and we would recommend deploying them to the data management landing zone. Be aware that some custom integration might be required.
