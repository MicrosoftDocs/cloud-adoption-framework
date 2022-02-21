---
title: Data Sharing Overview
description: Learn about Data Sharing Overview
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 02/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data Sharing Overview

In a decentralized architecture in which teams are responsible for their own data products, it's important to make formal sharing agreements between [data domains](./data-domains.md). A data contract is such a formal agreement between domains. It describes the data to be exchanged, its attributes, properties, its lifecycle, access controls and expected consumer usage patterns. Such contracts deliver better resilience to change. They avoid disruptive changes won't destabilize others. They also help to make your architecture secure and compliant.

Data contracts focus on different areas, which are:

- Documentation: Documentation is required for all data attributes. Documentation helps to describe the semantics, which ensures other teams to understand data and validate its accuracy. A good data contract contains all terms and definitions or provides relationships to a knowledge graph or catalog where teams can go to.

- Expressive: A good data contract is expressive and designed in a language to make data discoverable. Such a language also requires you to standardize on naming conventions, mandatory metadata fields, encoding requirements and metadata formats, such as JSON or YAML.

- Reliable and predictable: A data contract must allow schema validations, which are one of the most important aspects of a stable data architecture. A good data contract ensures that all individual attributes are described and provided with: data types, field length, nullable or non-nullable information, default values, primary key and foreign key relationship information, and so on.

- Versioning: Generally, only one or two versions of a given data product are deployed at any given point in time. Therefore you should version your data contracts so your users can see and predict changes.

- Enterprise identifiers: For data consistency in a distributed environment, you should consider introducing enterprise identifiers. These identifiers uniquely identify enterprise data, such as [master data management identifiers](./data-mesh-master-data-management.md), enterprise reference data or data that can be used for row-level filtering and access management. Team, for example, might want to encapsulate metadata inside their data for security purposes. Such metadata must be uniquely identified.

It's recommended to store all of your data contracts in a central [metadata](../govern-metadata-standards.md) repository. Such a contract repository is much more than a database. It's a control framework for your domain teams to discover data, validate and build on their data integrity. A well designed central contract repository also enables teams to analyze, see trends and violations. A good data contract repository also indirectly contributes to better data quality.

About the governance, it's the data product owner or data steward's job to ensure the contract integrity, including the contract lifecycle and modifications. Data product owners also should use a workflow to enable data sharing in a self-service manner. [Azure Purview](/azure/purview), a unified data governance solution, can help you with this. It supports data use governance via [access policy enforcement](/azure/purview/tutorial-data-owner-policies-storage) for Blob storage and Azure Data Lake Storage (ADLS) Gen2. 