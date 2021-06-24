---
title: "Requirements for Governing Data in a Modern Enterprise"
description: Requirements for Governing Data in a Modern Enterprise
author: mboswell
ms.author: mboswell
ms.date: 06/23/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Requirements for Governing Data in a Modern Enterprise

The requirements for governing data include:

- Data item and data entity definition to create a common business vocabulary in a business glossary
- Data item and data entity identification / discovery
- Data governance classification to govern data access security, data privacy and data retention
- People - including data owners with governance accountability and data stewards responsible for protecting it and upholding its quality
- Data governance processes
- Policies and rules to define how specific data should be governed throughout its lifecycle
- Policy enforcement across data stores in the distributed data landscape
- Master data management to get data consistent across operational and analytical systems e.g. customer, product, supplier
- Metadata lineage
- Technology to make it possible to govern structured, multi-structured and unstructured data across data centre, multiple clouds and the edge

The other challenge is that data is being collected and stored in multiple places across the enterprise. This may include data collected and stored in different geographies and different legal jurisdictions. As a result, different legislation may apply to governing the same data in different jurisdictions. You therefore need to discover what data exists across the hybrid multi-cloud distributed data landscape (including geographic location) to be able to:

1. Understand what data attributes, data entities and data relationships exist across the distributed data landscape
1. Classify the data to know how to govern it
1. Define policies to specify how data should be governed for each type of governance classification
1. Enforce data quality, data access security, data privacy and lifecycle management policies across the distributed data landscape

## Data Governance Classification

In addition, there needs to be some way to classify data to understand its level of confidentiality and how long to retain it for. This requires:

- A data confidentiality classification scheme
- A data retention classification scheme

An example of each of these schemes is:

[!INCLUDE [data-confidentiality-classification-scheme](includes/data-confidentiality-classification-scheme.md)]

[!INCLUDE [data-retention-classification-scheme](includes/data-retention-classification-scheme.md)]

Automating the data confidentiality and data retention classification process using the classes defined in each scheme is needed to consistently label data across the distributed data landscape to enable it to be consistently and correctly governed. Rules and policies would then need to be defined for each class in the classification scheme to specify how to govern data according to its classification.

## Data Governance Roles and Responsibilities

Another requirement is the need for accountability. Without this, confusion lingers as to who is accountable for governing data. If there is no accountability, how do you answer the following questions?

- Who sets success metrics and monitors how well the data governance program is working?
- Who are the data owners?
- Who defines and maintains a business glossary?
- Who creates and maintains policies on access security?
- Who is protecting PII data privacy for compliance with GDPR and CCPA?
- Who is looking after the quality of product data across all brochures and partner websites?
- Who ensures customer data is consistent across all systems?
- Who is policing external subscription data usage Vs the license?
- Who is policing privileged users like DBAs and data scientists?

Is it a C-level executive? Is it a department head? Is it the head of governance, risk and compliance? What about the legal department? Or is it IT's responsibility? Roles and responsibilities are needed to avoid confusion and to set the foundation upon which a data culture can materialize.

## Data Governance Processes

In addition to roles and responsibilities, processes are needed. For example, to:

- Govern the definition and maintenance of a common business vocabulary
- Discover and identify what data you have, what it means and where it is
- Classify data to know how to govern it
- Govern the definition and maintenance of data access security policies
- Govern the definition and maintenance of data privacy policies
- Detect data quality problems and remediate them
- Apply policies to ensure action is taken for compliance
- Govern maintenance of master data

## Data Governance Policies and Rules

We also need to define policies and rules to govern:

- Data integrity rules
- Data ingestion policies and rules
- Data access security policies and rules
- Data privacy policies and rules
- Data quality policies and rules
- Data maintenance policies and rules
- Data retention policies and rules

These need to be associated with each class in the aforementioned data governance
classification schemes.

## Master Data Management

Another central requirement in governing data is master data management (Figure 3). Master data is the most widely shared data in any organization and includes core data entities such as Customer, Supplier, Materials, Employee, Asset. It also includes financial Chart of Accounts data that is found in different financial applications.
Because master data is so widely shared it is application agnostic. It is needed by both operational transaction processing applications and analytical systems. Keeping this data synchronized can resolve so many data errors and process errors. Therefore, maintaining it centrally via a common process and synchronizing every system that needs it is the ideal situation. In addition, governance is needed over who is allowed to maintain it and where that maintenance needs to happen.

:::image type="content" source="images/master-data-management.png" alt-text="master data management":::

Figure 3: master data management

The same applies to reference data such as code sets and financial markets data. In this case standardization and synchronization of code sets is known as reference data management which is also a requirement.

## Metadata Lineage

Finally, there is a requirement for metadata lineage (Figure 4). This is the need to provide an audit trail to know where data originated and how it has been transformed on route to a report or a data store. In addition, metadata is needed to trace who or what is maintaining data (e.g. master data) including when and where this occurs.

:::image type="content" source="images/data-lineage.png" alt-text="data lineage":::

Figure 4: data lineage

## Summary of what is needed for end-to-end data governance

To address these requirements, we need an end-to-end solution that is capable of governing data throughout its lifecycle across data stores in the edge, multiple clouds and the data centre.

:::image type="content" source="images/data-governance-framework.png" alt-text="data governance framework":::

Figure 5: data governance framework

The solution consists of several components:

- A data governance vision and strategy
- The data itself e.g. customer data, supplier data, orders data etc.
- The data lifecycle from creation to destruction within which data needs to be governed
- Data governance roles and responsibilities (people)
- Data governance processes and activities and how they apply to the data lifecycle
- Policies and rules to govern data at different points in the lifecycle
- Data governance technologies to help make this possible
