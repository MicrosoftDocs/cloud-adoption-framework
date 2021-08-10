---
title: Components needed for data governance
description: Components needed for data governance
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Components needed for data governance

At the top of the solution, is the data governance vision and strategy. The strategy includes a vision statement, the stakeholders backing the data governance program, and goals of the program. These goals should be aligned with strategic business objectives to show contribution to common goals. The strategy also includes success metrics (KPIs) and targets to be reached to monitor the progress.

There are two types of metrics to be considered.

- **Risk management and compliance metrics:** Risk management and compliance metrics designed to measure improvements in data quality, security, privacy, and retention.

- **Value creation metrics:** Value creation metrics help to monitor how data governance contributes to improving business value through the creation and use of trusted data. Business value might mean:

- Reducing risk, such as protecting against a data breach
- Reducing costs, for example, by eliminating data errors in business processes that cause unplanned costs to mount as people step in to fix them
- Increasing revenue, such as providing high quality integrated and trusted data that improves accuracy of next best offer recommendations to drive up revenue

The data governance strategy should include business cases where you describe the impact that ungoverned data is having on the business. Describing the business problems caused by ungoverned data helps to systematically identify candidate business cases. It also allows you to rank the business problems in order of severity and return on investment (ROI) when you solve the problems. Prioritizing problems where ungoverned data has the greatest business impact, is an effective way to get stakeholder sponsorship. It's effective because the priorities pinpoint the greatest opportunities to drive value.

The data governance strategy should include the projects and initiatives needed to achieve the business objectives, meet targets, and deliver the ROI identified in business cases. It should include the budget given to these projects, who is leading the data governance program, and who is accountable for achieving them. It may also include some data principles. Two examples of data principles are:

- Data should be treated as an asset

- Data is the property of the company and should be shared

## Data and the data lifecycle that needs to be governed

Data means data entities, documents, unstructured images, video, and audio. Examples of data entities are customer, product, employee, supplier, order, invoice, payment, and asset.

:::image type="content" source="./images/data-lifecycle.png" alt-text="Diagram of the data lifecycle.":::

Examples of data entity include:

- Customer
- Product
- Employee
- Supplier
- Order
- Invoice
- Payment
- Asset
- Risk

Examples of documents include:

- Supplier contract
- Annual report
- Product brochure

The data governance solution should enable you to govern data throughout the lifecycle. That means governing data creation / ingestion protection, storage, use, maintenance, archiving, and destruction.

## Data governance roles and responsibilities guidance for people

There are many data governance roles and responsibilities for people. To learn more, see [Data governance roles and responsibilities](./organize-persona-and-teams.md#data-governance-roles-and-responsibilities).

## Data governance processes

There are four categories of data governance processes.

|Process category|  Processes|
|--|--|
|**Data discovery processes,to understand the data landscape** | A data and data entity discovery, mapping and cataloging process </br> A data profiling discovery process to determine the quality of data </br> A sensitive data discovery and governance classification process </br>A data maintenance discovery process for CRUD3 analysis, for example, from log files to understand usage and maintenance of data such as master data across the enterprise|
|**Data governance definition processes** | Create and maintain a common business vocabulary in a business glossary Define data entities, including master data, data attributes names, data integrity rules and valid formats </br> Define reference data to standardize code sets across the enterprise </br> Define data governance classifications schemes to label data to determine how to govern it </br> Define data governance policies and rules to govern data entity and document lifecycles </br> Define success metrics and threshold|
|**Data governance policy and rule enforcement processes** | A process to automate application / enforcement of data governance policies and rules </br> A process to manually apply and enforce policies and rules </br> Event-driven, on-demand and timer-driven (batch) data governance processes published as services that can be invoked to govern: </br> Data ingestion - cataloging, classification, owner assignment, and storing </br>  Data quality </br>  Data access security </br>  Data privacy </br>  Data usage, for example, including sharing and to ensure licensed data is only used for approved purposes </br>  Data maintenance, for example of master data </br>  Data retention </br>  Master data and reference data synchronization |
| **Monitoring processes** | Monitor and audit data usage activity, data quality, data access security, data privacy, data maintenance, and data retention </br> Monitor policy rule violation detection and resolution|

The common business vocabulary should be defined in a business glossary within a data catalog. Each working group should take responsibility to define a specific data entity or data subject area, such as multiple related entities. Multiple data entities in the vocabulary, along with the policies and rules, can then be worked on in parallel.

:::image type="content" source="./images/defining-entities-in-a-common-business-vocabulary.png" alt-text="Diagram of defining entities in a common business vocabulary.":::

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
- Data retention policies to manage the lifecycle with retention, archive, and backup rules. Multiple versions of a policy may be needed to govern the same data across different legal jurisdictions.

The [Data confidentiality classification scheme](./govern-requirements.md#data-confidentiality-classification-scheme) has five classification levels. The levels are public, internal use only, confidential, sensitive personal data, and restricted.

The way to govern data is to combine this data governance classification scheme with policies and rules. Consider each of the five levels as a label that can be used to label data, for example, sensitive personal data. By creating rules for sensitive personal data, and attaching these rules to a policy, you create a policy for sensitive personal data. You can attach the policy to the sensitive personal data label and then attach the sensitive personal data label to the data. In this way, all data labeled as sensitive personal data is subject to the same policies and rules. This process is known as **tag-based policy management**. It's flexible because an individual rule or a policy can be independently changed. All data labeled sensitive personal data is governed by the new rules. Equally, a sensitive personal data label can be detached from data and a confidential label used instead. In this case, the data instantly becomes governed by a new set of policies and rules associated with the confidential label.

Once you define policies and rules in a data catalog for each class in a data governance classification scheme, they can be passed to other technologies from a data catalog, via APIs, for them to enforce. Instead, a common data management platform that can connect to multiple data stores could potentially enforce them.

It should then be possible to monitor data quality, privacy, access security, usage, maintenance, and retention of specific data entities through their lifecycle.

## Data governance technology

In summary, this guidance focuses on technologies needed for data governance.

- A data catalog that includes:
  - A business glossary
  - Automated data discovery, profiling, tagging, cataloging, and mapping to a glossary
  - Automated sensitive data detection and governance classification
  - Interoperability with other catalogs, tools, and applications to share metadata via APIs and open standards
- Data lakes to ingest and process data
- Enterprise data software with built-in support for:
  - Datacenter, multicloud, and edge data connectivity
  - Data stewardship tooling
  - Data cleansing and integration
  - Metadata lineage
  - Data privacy masking
  - Universal data access security across multiple data stores in a distributed data landscape
- Data stores that support data encryption, dynamic data masking, and integration with the data catalog
- AI assisted data governance
- Master and reference data management

## Next steps

[Technology needed for end-to-end governance](./govern-technology.md)
