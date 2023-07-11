---
title: Data governance processes
description: Understand data governance processes
author: mboswell
ms.author: mboswell
ms.date: 02/21/2022
ms.topic: conceptual
s.custom: e2e-data-management, think-tank
---

# Data governance processes

There are four categories of data governance processes.

|Process category|  Processes|
|--|--|
|**Data discovery processes, to understand the data landscape** | A data and data entity discovery, mapping and cataloging process <br> A data profiling discovery process to determine the quality of data <br> A sensitive data discovery and governance classification process <br> A data maintenance discovery process for CRUD analysis, such as from log files, to understand usage and maintenance of data such as master data across the enterprise |
|**Data governance definition processes** | Create and maintain a common business vocabulary in a business glossary define data entities, including master data, data attributes names, data integrity rules and valid formats <br> Define reference data to standardize code sets across the enterprise <br> Define data governance classifications schemes to label data to determine how to govern it <br> Define data governance policies and rules to govern data entity and document lifecycles <br> Define success metrics and threshold |
|**Data governance policy and rule enforcement processes** | A process to automate application and enforcement of data governance policies and rules <br> A process to manually apply and enforce policies and rules <br> Event-driven, on-demand and timer-driven (batch) data governance processes published as services that can be invoked to govern: <br> Data ingestion - cataloging, classification, owner assignment, and storing <br> Data quality <br> Data access security <br> Data privacy <br> Data usage, for example, including sharing and to ensure licensed data is only used for approved purposes <br> Data maintenance, such as master data <br> Data retention <br> Master data and reference data synchronization |
| **Monitoring processes** | Monitor and audit data usage activity, data quality, data access security, data privacy, data maintenance, and data retention <br> Monitor policy rule violation detection and resolution |

The common business vocabulary should be defined in a business glossary within a data catalog.

Data governance working groups plan and develop defining data and improving specific data domains (for example, customer, or supplier); update the data governance control board on progress; and manage stewardship across the enterprise for a specific domain. Each working group should take responsibility to define a specific data entity or data subject area, such as multiple related entities. Multiple data entities in the vocabulary, along with the policies and rules, can then be worked on in parallel. For information, see [Data governance roles and responsibilities](../cloud-scale-analytics/organize-roles-teams.md#data-governance-roles-and-responsibilities)

:::image type="content" source="./images/defining-entities-in-a-common-business-vocabulary.png" alt-text="Diagram of defining entities in a common business vocabulary.":::
*Figure 1: Example data governance working group*

Integration of the catalog business glossary with other technologies is then needed to get consistent common data names into all technologies. Examples of other technologies to integrate with include:

- Extract, transform, load (ETL) tools
- Data modeling tools
- BI tools, database management systems
- Master data management
- Data virtualization tools
- Software development tools

A good practice to create a common business vocabulary is to create a data concept model. The model is a top-down approach that identifies data concepts that can be used as data entities in a common business vocabulary. It's then possible to assign a different data governance working group to each data concept (entity) or group of related data concepts (subject area). Different working groups are assigned to govern different data entities across the landscape.

When you build a common business vocabulary, you can use data catalog software to automatically discover what data exists across multiple data stores. It helps identify all the attributes associated with specific data entities. This is a bottom-up approach. By using a top-down approach of a data concept model to get you started, and a bottom-up automated data discovery approach to identify the attributes of a data entity, it's possible for multiple working groups to incrementally build up a common business vocabulary quickly.

Using a data catalog for automated data discovery enables the mapping of disparate data to a common vocabulary. The data catalog can help you understand where the data for each particular data entity in the business glossary is located across the enterprise.

## Policies and rules to govern data at different points in the lifecycle

Data governance policies describe a set of rules to control the integrity, quality, access security, privacy, and retention of data. There are different types of policy that include:

- Data integrity policies such as valid values, referential integrity.
- Data quality policies with data standardization, cleansing and matching rules.
- Data protection policies with access security and data privacy rules.
- Data retention policies to manage the lifecycle with retention, archive, and backup rules. Multiple versions of a policy might be needed to govern the same data across different legal jurisdictions.

The [data confidentiality classification scheme](./govern-requirements.md#data-confidentiality-classification-scheme) has five classification levels:

- Public
- Internal use only
- Confidential
- Sensitive personal data
- Restricted

Govern data by combining this classification scheme with policies and rules. Use each of the five levels to label data, such as sensitive personal data. By creating rules for sensitive personal data, and attaching these rules to a policy, you create a policy for sensitive personal data. You can attach the policy to the sensitive personal data label and then attach the sensitive personal data label to the data. In this way, all data labeled as sensitive personal data is subject to the same policies and rules. This process is known as **tag-based policy management**. It's flexible because an individual rule or a policy can be independently changed. All data labeled sensitive personal data is governed by the new rules. Equally, a sensitive personal data label can be detached from data and a confidential label used instead. In this case, the data instantly becomes governed by a new set of policies and rules associated with the confidential label.

Once you define policies and rules in a data catalog for each class in a data governance classification scheme, they can be passed to other technologies from a data catalog, via APIs, for them to enforce. Instead, a common data management platform that can connect to multiple data stores could potentially enforce them.

It should then be possible to monitor data quality, privacy, access security, usage, maintenance, and retention of specific data entities throughout their lifecycle.

## Next steps

- [Data Catalog](../cloud-scale-analytics/govern-data-catalog.md)
