---
author: stephen-sumner
ms.author: pnp
ms.date: 11/11/2024
ms.topic: include
ms.custom: e2e-data-management, think-tank
---

A data catalog registers and maintains data information in a centralized place so that it's available for your organization. It minimizes the chance of different project teams ingesting redundant data, which prevents duplicate data products. We recommend that you create a data catalog service to define the metadata of data products that you store across data landing zones. 

Cloud-scale analytics relies on [Microsoft Purview](/purview/data-governance-overview) to register enterprise data sources, classify them, ensure data quality, and provide highly secure, self-service access.

Microsoft Purview is a tenant-based service that can communicate with each data landing zone. It creates a managed virtual network and deploys it to your data landing zone region. You can deploy Azure managed virtual network integration runtimes (IR) within these managed virtual networks in any available Microsoft Purview region. The managed virtual network IR can then use private endpoints to securely connect to and scan the supported data sources. This approach helps isolate and secure the data integration process. For more information, see [Use managed virtual networks with your Microsoft Purview account](/purview/data-governance-private-endpoints-managed-virtual-network).

If you use Azure Databricks, we recommend using [Azure Databricks Unity Catalog](/azure/databricks/connect/unity-catalog/cloud-storage/azure-managed-identities) in addition to Microsoft Purview. Unity Catalog provides centralized access control, auditing, lineage, and data discovery capabilities across Databricks workspaces. For more information, see [Unity Catalog best practices](/azure/databricks/data-governance/unity-catalog/best-practices).

> [!NOTE]
> This article focuses on using Microsoft Purview for governance, but your enterprise might have investments in other products, such as Alation, Okera, or Collibra. These solutions are subscription-based. We recommend that you deploy them to the data management landing zone. They might require custom integration.
