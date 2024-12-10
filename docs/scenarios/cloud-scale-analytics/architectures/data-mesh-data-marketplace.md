---
title: Data marketplace
description: Learn about data marketplaces in data mesh.
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---
# Data marketplace

Data marketplaces have a strong relationship with [metadata](../govern-metadata-standards.md). A data marketplace offers data consumers an intuitive, secure, centralized, and standardized data shopping experience. It brings data closer to data analysts and scientists by utilizing the underlying metadata. It also tracks all your data products, which are often stored across a range of data domains.

To democratize data via your data mesh architecture, focus on several important areas:

- **Data Product Experience Plane:** Allows data providers and data consumers to work together on what data can be made available. Interfaces should provide extensive search capabilities that allow users to search using keywords, business terms, and natural language. Collaboration in data democratization is often linked to data catalogs or fully managed metadata management services that enable metadata search and discovery. [Microsoft Purview](/azure/purview) is a proven approach to having a self-service collaboration portal. It supports [data discovery](/azure/purview/how-to-browse-catalog), including glossaries and [classifications](/azure/purview/classification-insights). Data discovery enables your data consumers to easily find data. Microsoft Purview also supports [data owner access policies](/azure/purview/how-to-data-owner-policy-authoring-generic) so you can provide self-serve data access.

- **Data Infrastructure (Utility) Plane:** Helps you automate the deployment and provisioning of common and reusable consumption patterns. Consumption patterns can include storage accounts, databases, compute, identity management, and so on. Best practices for allowing your users to set up and launch their own data services can be found in [Organize data operations team members for cloud-scale analytics in Azure](../../data-management/organize.md), [Deployment and management services](/azure/azure-resource-manager/management/overview), and [Development services](/azure/devops).

- **Data Mesh Experience Plane:** Helps you keep sight of the health status of all interfaces, data pipelines, [data contracts](./data-contracts.md), provisioned components, central tools, and so on. [Azure Monitor](/azure/azure-monitor/) helps you maximize the availability and performance of your applications and services and achieve monitoring and insight. For data observability, create an umbrella on top of your self-service collaboration portal and other metadata services. Consider designing your own [metadata lake](../govern-metadata-standards.md) using services like [Azure Cosmos DB](/azure/cosmos-db/) and [Azure Event Hubs](/azure/event-hubs/).

:::image type="content" source="../media/data-marketplace.png" alt-text="Data Marketplace Architecture" lightbox="../media/data-marketplace.png":::

A data marketplace is typically a thin orchestration layer with an appealing look and feel, which offers unique user experiences. Data marketplaces utilize underlying metadata repositories, which can be a mixture of homegrown [metadata](../govern-metadata-standards.md) stores and services like [Microsoft Purview](/azure/purview/). You can extend your data marketplace with extra analytical capabilities like [Cognitive Services](/azure/cognitive-services) and [Machine Learning](/azure/machine-learning). For more information on how to adopt AI/ML in data mesh, see [Operationalize data mesh for AI/ML](operationalize-data-mesh-for-ai-ml.md).

Building a data marketplace involves structure, culture, and people. It requires you to trust users, train people, and work on awareness. Don't underestimate these activities. Your users are valuable resources; they own or use specific parts of the data landscape. Making better use of your users increases the efficiency of your data knowledge and usage.

In some cases, you might need an external data marketplace. External data marketplaces enable sharing of your data products with external partners. You can use [Azure Data Share](/azure/data-share) as a component.

## Next Steps

[Master Data Management in Data Mesh](data-mesh-master-data-management.md).