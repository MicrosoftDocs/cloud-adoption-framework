---
author: mboswell
ms.author: mboswell
ms.date: 11/11/2024
ms.topic: include
ms.custom: e2e-data-management, think-tank
---

A data catalog registers and maintains data information in a centralized place and makes it available for your organization. It minimizes the chance of different project teams ingesting redundant data, which prevents duplicate data products. We recommend that you create a data catalog service to define the metadata of data products that you store across data landing zones. 

Cloud-scale analytics relies on [Microsoft Purview](/azure/purview/overview) to register enterprise data sources, classify them, ensure data quality, and provide highly secure, self-service access.

Microsoft Purview is a tenant-based service that can communicate with each data landing zone. Mirosoft Purview creates a managed virtual network and deploys it to your data landing zone region. You can deploy Azure managed virtual network integration runtimes (IR) within Microsoft Purview managed virtual networks in any available Microsoft Purview region. The managed virtual network IR can then use private endpoints to securely connect to and scan the supported data sources. A managed virtual network IR within a managed virtual network helps isolate and secure the data integration process. For more information, see [Use managed virtual networks with your Microsoft Purview account](/purview/catalog-managed-vnet).

When you use Azure Databricks, we recommend using [Azure Databricks Unity Catalog](/azure/databricks/data-governance/unity-catalog/azure-managed-identities) in addition to Microsoft Purview. Azure Databricks Unity Catalog provides centralized access control, auditing, lineage, and data discovery capabilities across Databricks workspaces. For best practices for Unity Catalog setup, see [Unity Catalog best practices](/azure/databricks/data-governance/unity-catalog/best-practices).

> [!NOTE]
> This documentation focuses primarily on using Microsoft Purview for governance, but your enterprise might have investments in other products, such as Alation, Okera, or Collibra. We recommend that you deploy these subscription-based solutions to the data management landing zone. They might require custom integration.
