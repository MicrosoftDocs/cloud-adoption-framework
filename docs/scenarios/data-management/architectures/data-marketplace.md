---
title: Data Marketplace
description: Learn about data marketplace
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/11/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data marketplace

There is a growing trend in the industry to bring data closer to data analysts and scientists by using portals and data marketplaces that utilize the underlying [metadata](./metadata-standards.md) intensively. A data marketplace is an intuitive, secure, centralized, and standardized data shopping experience for all your data consumers. It is also meant to keep track over all your data products, which are typically stored across a range of data domains.

To democratize data via your data mesh architecture, you need to focus on four important areas:

1. A *self-service collaboration portal* allows data providers and data consumers to work together on what data can be made available. This portal should provide extensive search capabilities, allowing users to search on keywords, business terms, and natural languages. The collaboration side of data democratization is often linked to data catalogs, or fully managed metadata management services for easily searching and discovering metadata. A proven approach for a self-service collaboration portal is [Azure Purview](/azure/purview). It supports [data discovery](/azure/purview/how-to-browse-catalog), including glossaries and [classifications](/azure/purview/classification-insights), which enables your data consumers to easily find data. It also supports [data owner access policies](/azure/purview/how-to-data-owner-policy-authoring-generic) for providing data access in a self-service manner.

2. *Self-service provisioning*, which refers to a set of tools for automating the deployment and provisioning of common and reusable consumption patterns, such as business intelligence, data wrangling, and data exploration. Best practices for allowing your users to  set up and launch their own data services is to investigate in [DataOps](./data-mesh-dataops.md), [deployment and management services](/azure/azure-resource-manager/management/overview) and [development services](/azure/devops).

3. *Monitoring capabilities*, such as dashboards and report, for keeping sight of the overall health status of all interfaces, data flows, provisioned components, central tools, and so on. The recommendation for monitoring and insights is to adopt [Azure Monitor](/azure/azure-monitor/), which helps you maximize the availability and performance of your applications and services. For data observability, the recommended approach is to create an umbrella on top your self-service collaboration portal and other metadata services. For this you might consider designing your own [metadata lake](./metadata-standards.md) using services like [Azure Cosmos DB](/azure/cosmos-db/) and [Azure Event Hubs](/azure/event-hubs/).

4. *Intelligent services*, which enable you to automatically predict what users will be looking for and intelligently collect and prepare data. This required you to invest in [Cognitive Services](/azure/cognitive-services) and [Machine Learning](/azure/machine-learning).

:::image type="content" source="../images/metadata-standards.png" alt-text="Metadata Lake Architecture" lightbox="../images/metadata-standards.png":::

The marketplace itself is typically a thin orchestration layer with an appealing look and feel, offering unique user experiences. It utilizes the underlying metadata repositories, which can be a mixture of homegrown [metadata](./metadata-standards.md) stores and Azure services, like [Azure Purview](/azure/purview/). Depending on how smart you want to make it, you can extend it with additional analytical and provisioning capabilities.

Building a data marketplace is not only about tools, services and metadata. It’s also about structure, culture, and people. The cultural aspects require less rigid [governance](./data-mesh-governance.md). It requires you to give users trust, to train people, and to work on awareness. These activities should not be underestimated. Your users are valuable resources; they own or use specific parts of the data landscape. Making better use of your users increases the efficiency of data knowledge and data usage.