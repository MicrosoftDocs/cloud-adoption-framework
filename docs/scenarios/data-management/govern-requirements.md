---
title: Requirements for governing data in Azure in a modern enterprise
description: Learn about requirements for governing data in Azure in a modern enterprise.
author: mboswell
ms.author: mboswell
ms.date: 06/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Requirements for governing data in a modern enterprise

The requirements for governing data include:

- Data item and data entity definition to create a common business vocabulary in a business glossary
- Data item and data entity identification and discovery
- Data governance classification to govern data access security, data privacy, and data retention
- People, like data owners with governance accountability and data stewards responsible for data protection and quality
- Data governance processes
- Policies and rules to define how specific data should be governed throughout its lifecycle
- Policy enforcement across data stores in the distributed data landscape
- Master data management to make the data consistent. This might be across operational and analytical systems like customer, product, and supplier
- Metadata lineage
- Technology to make it possible to govern structured, multistructured, and unstructured data. The governance might span across the datacenter, multiple clouds, and the edge

The other challenge is that data is being collected and stored in multiple places across the enterprise. The data might include data collected and stored in different geographies and different legal jurisdictions. As a result, different legislation may apply to governing the same data in different jurisdictions. Discover what data exists across the hybrid multicloud distributed data landscape, including geographic location, to:

- Understand what data attributes, data entities, and data relationships exist across the distributed data landscape
- Classify the data to know how to govern it
- Define policies to specify how data should be governed for each type of governance classification
- Enforce data quality, data access security, data privacy, and lifecycle management policies across the distributed data landscape

## Data governance classification

There needs to be a way to classify data to understand its level of confidentiality and how long to keep it. The classification requires:

- A data confidentiality classification scheme
- A data retention classification scheme

An example of these schemes is:

[!INCLUDE [data-confidentiality-classification-scheme](./includes/data-confidentiality-classification-scheme.md)]

[!INCLUDE [data-retention-classification-scheme](./includes/data-retention-classification-scheme.md)]

Automate the data confidentiality and data retention classification process using the classes defined in each scheme is needed to consistently label data across the distributed data landscape. The automation will enable it to be consistently and correctly governed. Then, define rules and policies for each class in the classification scheme to specify how to govern data according to its classification.

## Data governance roles and responsibilities

Another requirement is the need for accountability. Without accountability, confusion lingers as to who is accountable for governing data. If there's no accountability, how do you answer the following questions?

- Who sets success metrics and monitors how well the data governance program is working?
- Who are the data owners?
- Who defines and maintains a business glossary?
- Who creates and maintains policies on access security?
- Who is protecting personal data privacy for compliance?
- Who is looking after the quality of product data across all brochures and partner websites?
- Who ensures customer data is consistent across all systems?
- Who is policing external subscription data usage versus the license?
- Who is policing privileged users like dbas and data scientists?

Is it a C-level executive? Is it a department head? Is it the head of governance, risk, and compliance? What about the legal department? Or is it IT's responsibility? Roles and responsibilities are needed to avoid confusion and to set the foundation upon which a data culture can materialize.

## Data governance processes

Processes are needed, along with roles and responsibilities to:

- Govern the definition and maintenance of a common business vocabulary
- Discover and identify what data you have, what it means. And where it's stored
- Classify data to know how to govern it
- Govern the definition and maintenance of data access security policies
- Govern the definition and maintenance of data privacy policies
- Detect data quality problems and remediate them
- Apply policies to ensure action is taken for compliance
- Govern maintenance of master data

## Data governance policies and rules

Define policies and rules to govern:

- Data integrity rules
- Data ingestion policies and rules
- Data access security policies and rules
- Data privacy policies and rules
- Data quality policies and rules
- Data maintenance policies and rules
- Data retention policies and rules

Associate these policies and rules with each class in the data governance classification schemes.

## Master data management

Another central requirement in governing data is master data management. Master data is the most widely shared data in any organization and includes core data entities. Core data entities include customer, supplier, materials, employee, and asset. It also includes financial chart of accounts data that is found in different financial applications. Because master data is so widely shared, its application agnostic. It's needed by both operational transaction processing applications and analytical systems. Keeping this data synchronized can resolve so many data errors and process errors. So, maintaining it centrally via a common process and synchronizing every system that needs it, is the ideal situation. Also, governance is needed over who is allowed to maintain it and where that maintenance needs to happen.

:::image type="content" source="./images/master-data-management.png" alt-text="Diagram of master data management.":::

The same applies to reference data such as code sets and financial markets data. In this case, standardization and synchronization of code sets is known as reference data management, which is also a requirement.

## Metadata lineage

Finally, there's a requirement for metadata lineage. You can use an audit trail to know where data originated and how it has been transformed on route to a report or a data store. You can use metadata to trace who or what is maintaining data, including when and where it occurs.

:::image type="content" source="./images/data-lineage.png" alt-text="Diagram of data lineage.":::

## Summary of what is needed for end-to-end data governance

You need an end-to-end solution that can govern data throughout its lifecycle across data stores in the edge, multiple clouds, and the datacenter.

:::image type="content" source="./images/data-governance-framework.png" alt-text="Diagram of data governance framework.":::

Your data governance solution should have several components:

- A data governance vision and strategy
- The data itself, such as customer data, supplier data, order data, and others
- The data lifecycle from creation to destruction within which data needs to be governed
- Data governance roles and responsibilities (people)
- Data governance processes and activities and how they apply to the data lifecycle
- Policies and rules to govern data at different points in the lifecycle
- Data governance technologies to help make data governance possible

## Next steps

[Components needed for data governance](./govern-components.md)
