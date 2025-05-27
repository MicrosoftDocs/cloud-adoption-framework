---
title: Metadata standards
description: Learn about metadata standards
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Metadata standards

Metadata Management plays a crucial role in data architecture. Metadata is data about other data. It describes data, providing a reference that helps you to find, secure, and control data. Metadata also binds data together. It can be used to validate data's integrity and quality, route or replicate data to a new location, transform data, and understand data meanings. Metadata is also essential in democratizing data through self-service portals.

There's a growing trend in the industry to bring data insights closer to data analysts and scientists using portals that use more metadata. This trend is known as *data observability*. Data observability uses concepts like metadata lake, knowledge graphs, or metadata graphs to describe platforms where metadata is centralized. It's a good way to build a unified view of how data is used and sourced across your organization when using a distributed data mesh.

A good metadata management strategy grows organically. It starts simple and small by first identifying the most important areas. A good metadata management strategy is also supported with services and clear processes. To get started, it is good to be aware of the different metadata categories:

- **Business metadata** describes all aspects used for governance, finding & understanding data. Some well-known examples include business terms and definitions and information on data ownership, usage, and origination.
- **Technical metadata** describes the structural aspects of data at design time. Some well-known examples include schema information, data format and protocol information, and encryption and decryption keys.
- **Operational metadata** describes processing aspects of data at run time. Some well-known examples include process information, execution time, process failure information, and job IDs.
- **Social metadata** describes the user perspective of the data from its consumers. Some well-known examples include use and user tracking information, search result data, filters and clicks, viewing time, profile hits, and comments.

In decentralized data architecture, metadata management is an organizational challenge that requires finding a balance between centrally managed metadata and federated managed metadata. It's important to understand teams and functions for cloud-scale analytics in Azure as you plan your metadata management. Using a collaborative data management practice can improve communication, integration, and data flow automation between your teams. You can address some of the metadata management complexity by striking the right balance between central governance and domain ownership.

As you're deciding what metadata to manage centrally or federate to your data domains and begin your implementation, ask yourself:

- What business metadata is critical?
- What technical metadata is required for interoperability?
- What processes and streams capture the data?
- Where are the models or schemas created and maintained?
- What information do teams need to deliver centrally to allow the data governance department to do its work correctly?

Using your answers to these questions, map out the content life cycle for each of your metadata streams, and determine all dependencies. You then have a metadata model that can connect business domains, processes, technology, and data.

After you know which metadata you need, you must choose a place to store and process it. You can use Microsoft Purview for this.

## Use Microsoft Purview to manage your data estate at large

[Microsoft Purview](/azure/purview) is a unified data governance solution that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. It manages metadata at scale because it is a fully automated service that intelligently performs data discovery, data scanning, data quality, and access management. It also provides a holistic map with many insights about your data mesh architecture.

Microsoft Purview is a comprehensive set of solutions that can help your organization govern, protect, and manage data, wherever it lives. Microsoft Purview solutions provide integrated coverage and help address the fragmentation of data across organizations, lack of visibility that hampers data protection and governance, and the blurring of traditional IT management roles.

Microsoft Purview combines data governance and compliance solutions and services together into a unified platform to help your organization:

- Gain visibility into data across your organization
- Safeguard and manage sensitive data across its lifecycle wherever it lives
- Govern data seamlessly in new, comprehensive ways
- Manage critical data risks and regulatory requirements

When implementing Microsoft Purview, avoid introducing too much change and complexity quickly. Technical metadata forms the foundation of Microsoft Purview. You need to gather and organize your metadata before making sense of it.

After you have your metadata, start with the basics:

- Business terms
- Lists of authoritative data sources
- Lists of databases
- Governance domains
- Schema information
- Data ownership
- Data stewardship
- Security
- Data quality

Then scale by slowly involving more domain owners and data stewards and by adding more classifications and sensitivity labels. These additions improve the search experience and enable better data access management.

Microsoft Purview offers a feature called Governance domains, which establish boundaries for unified governance, ownership, and discovery of data products and business concepts within your domain-oriented architecture. For more information, see [Governance Domains in Microsoft Purview](/purview/concept-governance-domain).

## Use Azure Cosmos DB to create a Knowledge Graph

A data insight solution must describe how data is used and the relationships between entities such as source data and data products, and between data products from one domain and dependent products from another domain. You can use a graph database or custom user interface to model these relations.

To build a unified view of your organization's data with a custom user experience, consider using Azure Cosmos DB. Azure Cosmos DB is a globally distributed, multi-model database service with NoSQL endpoints. It provides a graph database service via Azure Cosmos DB for Apache Gremlin, which can store massive graphs with billions of vertices and edges.

The end result of the Azure Cosmos DB architecture is an organization-wide graph that provides a unified view of all data in your organization with end-to-end context. The metadata lake is not only about storing information. It also actively organizes your metadata as a graph by connecting it to other services and tools. This organized graph allows you to cross-correlate many subject areas, including:

- Domains
- Data quality
- Data usage
- Business capabilities
- Application functions
- Technical architecture information
- Operational events
- Organizational metadata
- Application ownership metadata
- Location information
- Application life cycle management information

## Next steps

> [!div class="nextstepaction"]
> [Secure cloud-scale analytics in Azure](../data-management/secure.md)