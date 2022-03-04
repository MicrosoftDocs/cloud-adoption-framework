---
title: Data marketplace
description: Learn about ata marketplace in Data Mesh
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---
# Data marketplace

Data marketplaces have a strong relationship with [Metadata](../govern-metadata-standards.md). A data marketplace is an intuitive, secure, centralized, and standardized data shopping experience for all your data consumers. It's an approach to bring data closer to data analysts and scientists by utilizing the underlying metadata intensively. It's also meant to keep track over all your data products, which are typically stored across a range of data domains.

To democratize data via your data mesh architecture, you need to focus on several important areas:

- A *Data Product Experience Plane* allows data providers and data consumers to work together on what data can be made available. The interfaces should provide extensive search capabilities, allowing users to search on keywords, business terms, and natural languages. The collaboration side of data democratization is often linked to data catalogs, or fully managed metadata management services for easily searching and discovering metadata. A proven approach for a self-service collaboration portal is [Azure Purview](/azure/purview). It supports [data discovery](/azure/purview/how-to-browse-catalog), including glossaries and [classifications](/azure/purview/classification-insights), which enables your data consumers to easily find data. It also supports [data owner access policies](/azure/purview/how-to-data-owner-policy-authoring-generic) for providing data access in a self-service manner.

- *Data Infrastructure (Utility) Plane*, which refers to a set of tools for automating the deployment and provisioning of common and reusable consumption patterns, such as storage accounts, databases, compute, identity management and so on. Best practices for allowing your users to set up and launch their own data services is to investigate in [organize data operations team members for data management and analytics in Azure](../organize.md), [deployment and management services](/azure/azure-resource-manager/management/overview) and [development services](/azure/devops).

- *Data Mesh Experience Plane*, such as dashboards and report, for keeping sight of the overall health status of all interfaces, data pipelines, [data contracts](./data-sharing-overview.md), provisioned components, central tools, and so on. The recommendation for monitoring and insights is to adopt [Azure Monitor](/azure/azure-monitor/), which helps you maximize the availability and performance of your applications and services. For data observability, the recommended approach is to create an umbrella on top your self-service collaboration portal and other metadata services. For this you might consider designing your own [metadata lake](../govern-metadata-standards.md) using services like [Azure Cosmos DB](/azure/cosmos-db/) and [Azure Event Hubs](/azure/event-hubs/).

:::image type="content" source="../images/data-marketplace.png" alt-text="Data Marketplace Architecture" lightbox="../images/data-marketplace.png":::

The *data marketplace* itself is typically a thin orchestration layer with an appealing look and feel, offering unique user experiences. It utilizes the underlying metadata repositories, which can be a mixture of homegrown [metadata](../govern-metadata-standards.md) stores and Azure services, like [Azure Purview](/azure/purview/). Depending on how smart you want to make it, you can extend it with more analytical capabilities, such as [Cognitive Services](/azure/cognitive-services) and [Machine Learning](/azure/machine-learning).

Building a data marketplace isn't only about tools, services and metadata. It's also about structure, culture, and people. The cultural aspects require less rigid [governance](./data-mesh-governance.md). It requires you to give users trust, to train people, and to work on awareness. These activities shouldn't be underestimated. Your users are valuable resources; they own or use specific parts of the data landscape. Making better use of your users increases the efficiency of data knowledge and data usage.

In some cases an external data marketplace is necessary. The purpose of the external data marketplace is to enable sharing of data products with external partners. [Azure Data Share](/azure/data-share) can be used as a component in an external data marketplace.

## Next steps

[Master Data Management in Data Mesh](data-mesh-master-data-management.md)
