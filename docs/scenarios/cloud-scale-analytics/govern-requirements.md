---
title: Requirements for governing data
description: Learn about requirements for governing data
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Requirements for governing data

Cloud-scale analytics recommends you consider the following requirements for governing data:

- Data entity definition to create a common business vocabulary in a business glossary. *Data entities in this context mean concepts like customer, supplier, materials, employee, and others.*
- Data entity identification and discovery.
- Data classification to govern data access security, data privacy, and data retention.
- People, such as data owners with governance accountability and data stewards responsible for data protection and quality.
- Data governance processes.
- Data lifecycle management to govern how long data should be kept.
- Policies and rules to define how specific data should be governed throughout its lifecycle.
- Policy enforcement across data stores in the distributed data landscape.
- Master data management to make the data consistent across operational and analytical systems like customer, product, and supplier.
- Metadata lineage to understand the transformation and relationship of data entities.
- Technology to make it possible to govern structured, multi-structured, and unstructured data. The governance might span across the datacenter, multiple clouds, and the edge.

One challenge is that data is being collected and stored in multiple places across the enterprise. The data might include data collected and stored in different geographies and different legal jurisdictions. As a result, different legislation might apply to governing the same data in different jurisdictions. Discover data distributed across multiple clouds and geographic locations to:

- Understand what data attributes, data entities, and data relationships exist across the distributed data landscape.
- Classify the data to know how to govern it.
- Define policies to specify how data should be governed for each type of data classification and lifecycle management.
- Enforce data quality, data access security, data privacy, and lifecycle management policies across the distributed data landscape.

## Data classification

Data classification is a way of categorizing data assets by assigning unique logical tags or classes to the data assets. Classification is based on the business context of the data.

There needs to be a way to classify data to understand its level of confidentiality and how long to keep it. The classification requires:

- A data confidentiality classification scheme.
- A data retention classification scheme.

### Data confidentiality classification scheme

[!INCLUDE [data-confidentiality-classification-scheme](./includes/data-confidentiality-classification-scheme.md)]

### Data lifecycle retention classification scheme

| Retention | Description |
|---|---|
| None | Data can be deleted at any time. |
| Temporary | Keep data for a short period of time. For example, keep Twitter data for a week. |
| Fixed period | Keep data for a set number of years, after which it can be deleted. For example, keep tax records for seven years to comply with government laws. |
| Permanent | Never delete data. For example, legal correspondence. |

Automating the data confidentiality and data lifecycle retention classification process using the classes defined in each scheme is needed to consistently label data across the distributed data landscape. The automation enables it to be consistently and correctly governed. Then, define rules and policies for each class in the classification scheme to specify how to govern data according to its classification.

## Data governance roles and responsibilities

Another requirement is the need for accountability. Otherwise confusion lingers as to who is accountable for governing data. If there's no accountability, how do you answer the following questions?

- Who sets success metrics and monitors how well the data governance program is working?
- Who are the data owners?
- Who defines and maintains a business glossary?
- Who creates and maintains policies on access security?
- Who is protecting personal data privacy for compliance?
- Who is looking after the quality of product data across all brochures and partner websites?
- Who ensures customer data is consistent across all systems?
- Who is policing external subscription data usage versus the license?
- Who is policing privileged users like database administrators and data scientists?
- Is it a C-level executive? Is it a department head? 
- Is it the head of governance, risk, and compliance? 
- What about the legal department? 
- Is it IT's responsibility?

Roles and responsibilities are needed to avoid confusion and to set the foundation upon which a data culture can materialize.

## Data governance processes

Processes are needed, along with roles and responsibilities, to:

- Govern the definition and maintenance of a common business vocabulary.
- Discover and identify what data you have, what it means, and where it's stored.
- Classify data to know how to govern it.
- Govern the definition and maintenance of data access security policies.
- Govern the definition and maintenance of data privacy policies.
- Detect data quality problems and remediate them.
- Apply policies to ensure action is taken for compliance.
- Govern the maintenance of master data.

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

Another requirement in governing data is master data management. Master data is the most widely shared data in any organization and includes core data entities. Core data entities include customer, supplier, materials, employee, and asset. It also includes financial chart of accounts data that is found in different financial applications. Because master data is so widely shared, it's application agnostic. It's needed by both operational transaction processing applications and analytical systems. Keeping this data synchronized can resolve many data errors and process errors. So, maintaining it centrally via a common process and synchronizing every system that needs it's the ideal situation. Also, governance is needed over who is allowed to maintain it and where that maintenance needs to happen.

The same applies to reference data such as code sets and financial markets data. In this case, standardization and synchronization of code sets are known as reference data management, which is also a requirement.

## Metadata lineage

Finally, there's a requirement for metadata lineage. You can use an audit trail to know where data originated and how it's transformed en route to a report or a data store. You can use metadata to trace who or what is maintaining data, including when and where it occurs.

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

> [!div class="nextstepaction"]
> [Data governance process](./govern-components.md)
