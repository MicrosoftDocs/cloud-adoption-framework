---
title: metadata standards
description: Learn about metadata standards in Data Mesh
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/09/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Metadata Standards

Metadata Management has a crucial role in your Data Mesh architecture. Metadata is data about data. It describes other data, providing a reference that helps you to find, secure and control data. Metadata also binds data together. It can be used for validating the integrity and quality of the data, routing or replicating it to the new location, transforming the data, and knowing its meaning are all performed through metadata. Metadata is also essential in democratizing data through self-service portals.

A good metadata management strategy grows organically. It starts simple and small by first identifying the most important areas. A good metadata management strategy also is supported with services and clear processes. To get started, it's good to be aware of the different metadata categories:

- *Business metadata* is a category of metadata that describes all aspects used for governance, finding & understanding data. Some well-known examples are business terms, definitions, data ownership information, information about data usage and origination, and so on.
- *Technical metadata* is a category of metadata that describes the structural aspects of data at design time. Some well-known examples are schema information, information about data formats and protocols, encryption and decryption keys, and so on.
- *Operational metadata* is a category of metadata that describes processing aspects of data at run time. Some well-known examples are process information, execution time, information about whether a process failed, ID of the job, and so on.
- *Social metadata* is a category of metadata that describes the user perspective of the data by its consumers. Some well-known examples are use and user tracking information, data on search results, filters and clicks, viewing time, profile hits, comments, and so on.

When it comes to Data Mesh, metadata management is mostly an organizational challenge. It's about finding the right balance between centrally managed metadata and federated managed metadata. Metadata in this respect also has a strong relationship with [DataOps](./data-ops-for-mesh.md), which is an advanced and collaborative data management practice focused on improving the efficiency of communication, integration, and automation of data flows between teams across an organization. DataOps addresses some of the complexity associated with metadata management. It strikes a balance between central governance and domain ownership for metadata management.

Before you start implementing and deciding what metadata to manage centrally or federate to your domains, first ask yourself: What business metadata is critical? What technical metadata is required for interoperability? What processes and streams capture the data? Where are the models or schemas created and maintained? What information teams need to deliver centrally to allow the data governance department to do its work correctly? After you've analyzed your most important questions, you need to map out the content life cycle for each of the metadata streams and determine all dependencies. What you will end up with is a metadata model that can connect business domains, processes, technology, and data.

After you know what metadata you need, you need to find a place for storing and processing metadata. This brings you to Azure Purview.

## Recommendation: Use Azure Purview for managing your data estate at large

[Azure Purview](/azure/purview) is a unified data governance solution that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. It does metadata management at scale, because it's a fully automated service that intelligently performs data discovery, data scanning and access management. It also provides a holistic map for providing many insights of your data mesh architecture.

When implementing Azure Purview, it's recommend not introducing too much change and complexity quickly. The technical metadata is the foundation. You’ll need to gather and organize this before you can make sense of it. After this, start with the basics: business terms, lists of authoritative data sources and databases, schema information, data ownership and stewardship, and security. Slowly scale by involving more domain owners and data stewards. Also scale by adding more classifications and sensitivity labels. This improves the search experience and allows for better data access management.

For your domain-oriented architecture, it's recommended to align your Azure Purview Collections and Glossaries with your data domains. Collections in Azure Purview are used to organize assets and sources. You can use a Collection as a boundary for your assets and sources and align this with a particular domain. You can do the same for your glossary: create hierarchy structures within your glossary and align these with your domains. Ask your domains to take ownership for creating relationships between your glossary terms and collection attributes. This creates transparency over data ownership and improves your data semantics.

## Recommendation: Use Azure Cosmos DB for your company's Knowledge Graph

There's a growing trend in the industry to bring insights of your data closer to data analysts and scientists by using portals that use more metadata intensively. This trend is also known as “Data observability” and features concepts like Metadata Lake, Knowledge Graph or Metadata Graph to describe platforms where metadata is centralized.

:::image type="content" source="../images/metadata-standards.png" alt-text="Metadata Lake Architecture" lightbox="../images/metadata-standards.png":::

For building a unified view of data for your organization with custom user experience it's recommended to look at Azure Cosmos DB, which is a globally distributed, multi-model database service with NoSQL endpoints. It provides a graph database service via the Gremlin API to store massive graphs with billions of vertices and edges.

The end result of this architecture is a company-wide graph which provides a unified view of all data in your organization using end-to-end context. The metadata lake is not about only storing information. It actively organizes your metadata as a graph by connecting it to many other services and tools. This allows you cross-correlate subject areas such as: domains, data quality, data usage, business capabilities, application functions, informatiom from your technical architecture, operational events, organizational metadata, application ownership metadata, location information, application life cycle management information, and so on.



