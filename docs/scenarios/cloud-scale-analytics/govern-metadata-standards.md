---
title: Metadata standards
description: Learn about metadata standards
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 03/16/2022
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Metadata standards

Metadata Management plays a crucial role in data architecture. Metadata is data about other data. It describes data, providing a reference that helps you to find, secure and control data. Metadata also binds data together. It can be used to validate data's integrity and quality, route or replicate data to a new location, transform data, and know data meanings. Metadata is also essential in democratizing data through self-service portals.

A good metadata management strategy grows organically. It starts simple and small by first identifying the most important areas. A good metadata management strategy also is supported with services and clear processes. To get started, it's good to be aware of the different metadata categories:

- **Business metadata** describes all aspects used for governance, finding & understanding data. Some well-known examples include business terms and definitions and information on data ownership, usage, and origination.
- **Technical metadata** describes the structural aspects of data at design time. Some well-known examples include schema information, data format and protocol information, and encryption and decryption keys.
- **Operational metadata** describes processing aspects of data at run time. Some well-known examples include process information, execution time, process failure information, and job IDs.
- **Social metadata** describes the user perspective of the data from its consumers. Some well-known examples include use and user tracking information, search result data, filters and clicks, viewing time, profile hits, and comments.

In decentralized data architecture, metadata management is an organizational challenge that requires finding a balance between centrally managed metadata and federated managed metadata. It's important for you to [understand teams and functions for cloud-scale analytics in Azure](../data-management/organize-team-functions.md) as you plan your metadata management. Using a collaborative data management practice improves communication, integration, and data flow automation between your teams. You can address some of metadata management's complexity by striking the right balance between central governance and domain ownership.

As you are deciding what metadata to manage centrally or federate to your [data domains](./architectures/data-domains.md) and begin your implementation, ask yourself:

- What business metadata is critical?
- What technical metadata is required for interoperability?
- What processes and streams capture the data?
- Where are the models or schemas created and maintained?
- What information teams need to deliver centrally to allow the data governance department to do its work correctly?

Using your answers to these questions, map out the content life cycle for each of your metadata streams and determine all dependencies. You then have a metadata model that can connect business domains, processes, technology, and data.

Once you know what metadata you need, you must choose a place to store and process it. You can do this using Azure Purview.

## Use Azure Purview to manage your data estate at large

[Azure Purview](/azure/purview) is a unified data governance solution that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. It does metadata management at scale, because it's a fully automated service that intelligently performs data discovery, data scanning and access management. It also provides a holistic map of many insights about your data mesh architecture.

When implementing Azure Purview, don't introduce too much change and complexity quickly. Technical metadata is Azure Purview's foundation. You need to gather and organize your metadata before you can make sense of it.

Once you have your metadata, start with the basics:

- business terms
- lists of authoritative data sources
- lists of databases
- schema information
- data ownership
- data stewardship
- security

Then scale by slowly involving more domain owners and data stewards and by adding more classifications and sensitivity labels. These additions improve the search experience and allow for better data access management.

For your custom metadata attributes, like lists of domains and application metadata, consider creating extra [type definitions](/rest/api/purview/catalogdataplane/types/create-type-definitions) in Azure Purview.

For your domain-oriented architecture, align your Azure Purview Collections and Glossaries with your data domains. Azure Purview Collections organize assets and sources. You can use a Collection as a boundary for your assets and sources and align it with a particular domain. You can do the same thing with your Glossary. Create hierarchy structures within your Glossary and align them with your domains. Ask your domains to take ownership for creating relationships between your glossary terms and collection attributes. This creates data ownership transparency and improves your data semantics.

## Use Azure Cosmos DB to create organization's Knowledge Graph

There's a growing trend in the industry to bring data insights closer to data analysts and scientists using portals that use more metadata intensively. This trend is known as *data observability*. Data observability uses concepts like metadata lake, knowledge graphs, or metadata graphs to describe platforms where metadata is centralized. This is a good way for you to build a unified view of how data are used and sourced across your organization when using a distributed data mesh.

A data insight solution must describe how data is used and the relations between entities like source data and data products and between data products from one domain and dependent products from another domain. You can use a graph database or custom user interface to model these relations.

To build a unified view of your organization's data with custom user experience, look at Azure Cosmos DB. Azure Cosmos DB is a globally distributed, multi-model database service with NoSQL endpoints. It provides a graph database service via Azure Cosmos DB for Apache Gremlin to store massive graphs with billions of vertices and edges.

The end result of the Azure Cosmos DB architecture is an organization-wide graph that provides a unified view of all data in your organization using end-to-end context. The metadata lake isn't only about storing information. It also actively organizes your metadata as a graph by connecting it with other services and tools. This organized graph allows you cross-correlate many subject areas, including:

- domains
- data quality
- data usage
- business capabilities
- application functions
- technical architecture information
- operational events
- organizational metadata
- application ownership metadata
- location information
- application life cycle management information

## Next steps

- [Secure cloud-scale analytics in Azure](../data-management/secure.md)
