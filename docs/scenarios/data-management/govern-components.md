---
title: "Components needed for data governance"
description: Components needed for data governance
author: mboswell
ms.author: mboswell
ms.date: 06/21/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Components needed for data governance

At the top of the solution is the data governance vision and strategy. This includes a vision statement, the stakeholders backing the data governance program and the objectives of the program. These objectives should be aligned with strategic business objectives to show contribution to common goals. The strategy also includes success metrics (KPIs) and targets to be reached to monitor the progress. There are two types of metrics to be considered. The first is risk management and compliance metrics designed to measure improvements in data quality, security, privacy and retention. The second type is value creation metrics. These help to monitor how data governance is contributing to improving business value through the creation and use of trusted data. Business value in this case could mean:

- Reducing risk (e.g. by protecting against a data breach)
- Reducing costs (e.g. by eliminating data errors in business processes that cause
unplanned costs to mount as people step in to fix them)
- Increasing revenue (e.g. by providing high quality integrated and trusted data that
improves accuracy of next best offer recommendations to drive up revenue).

The data governance strategy should also include business cases which are best articulated by describing the impact that ungoverned data is having on the business. Describing the business problems caused by ungoverned data helps to systematically identify candidate business cases. It also allows you to rank the business problems in order of severity and return on investment (ROI) if the problems were solved. Prioritizing problems where ungoverned data has the greatest business impact is an extremely effective way to getting stakeholder sponsorship. This is because it pinpoints the greatest opportunities to drive value.

The data governance strategy should then include the projects / initiatives that are needed to achieve the business objectives, meet the targets set and deliver the ROI identified in business cases. In addition, it should include the budget allocated to these projects, who is leading the data governance program and who is accountable for achieving them. It may also include some data principles. Two examples here are that data should be treated as an asset and that data is the property of the company and should be shared.

## Data and the Data Lifecycle that Needs to be Governed

With respect to data we mean data entities, documents, unstructured images, video and audio. Examples of data entities are customer, product, employee, supplier, order, invoice, payment and asset.

:::image type="content" source="images/data-lifecycle.png" alt-text="data lifecycle":::

Figure 1: data lifecycle

Data entity examples

- Customer
- Product
- Employee
- Supplier
- Order
- Invoice
- Payment
- Asset
- Risk

Documents examples

- Supplier contract
- Annual report
- Product brochure

The data governance solution should enable you to govern data throughout the lifecycle. That means governing data creation / ingestion protection, storage, use, maintenance, archiving and destruction.

## Data Governance Roles and Responsibilities Guidance (people)

With respect to people, there are a number of data governance roles and responsibilities. These are covered in [Data Governance Roles and Responsibilities](organize-persona-and-teams.md#data-governance-roles-and-responsibilities).

## Data Governance Processes

There are four categories of data governance processes shown below:

|Process Category|  Processes|
|--|--|
|**Data discovery processes (to understand the data landscape)** | A data and data entity discovery, mapping and cataloguing process </br> A data profiling discovery process to determine the quality of data </br> A sensitive data discovery and governance classification process </br>A data maintenance discovery process for CRUD3 analysis (e.g. from log files) to understand usage and maintenance of data (e.g. master data) across the enterprise|
|**Data governance definition processes** |  Create and maintain a common business vocabulary in a business glossary. This involves defining data entities (including master data), data attributes names, data integrity rules and valid formats </br> Define reference data to standardize code sets across the enterprise </br> Define data governance classifications schemes to label data to determine how to govern it </br> Define data governance policies and rules to govern data entity and document lifecycles </br> Define success metrics and threshold|
|**Data governance policy and rule enforcement processes** | A process to automate application / enforcement of data governance policies and rules </br> A process to manually apply and enforce policies and rules </br> Event-driven, on-demand and timer-driven (batch) data governance processes published as services that can be invoked to govern: </br> Data ingestion - cataloguing, classification, owner assignment, and storing </br>  Data quality </br>  Data access security </br>  Data privacy </br>  Data usage e.g. including sharing and to ensure licensed data is only used for approved purposes </br>  Data maintenance e.g. of master data </br>  Data retention </br>  Master data and reference data synchronization |
| Monitoring processes | Monitor and audit data usage activity, data quality, data access security, data privacy, data maintenance and data retention </br> Monitor policy rule violation detection and resolution|

CRUD = Create, Read, Update, Delete

The common business vocabulary should be defined in a business glossary within a data catalog. Following on from the discussion on data governance working groups, each working group should take responsibility for defining a specific data entity or data subject area (multiple related entities). Therefore, multiple data entities in the vocabulary, along with the policies and rules, can be worked on in parallel (Figure 2).

:::image type="content" source="images/defining-entities-in-a-common-business-vocabulary.png" alt-text="defining entities in a common business vocabulary":::

Figure 2: defining entities in a common business vocabulary

Integration of the catalog business glossary with other technologies such as ETL tools, data modeling tools, BI tools, DBMSs, master data management, data virtualization tools, software development tools etc.., is then needed to get consistent common data names into all technologies.

A good practice to quick start the creation of a common business vocabulary is to create a data concept model. This top down approach gets you started because it identifies data concepts that can be used as data entities in a common business vocabulary. It is then possible to assign a different data governance working group to each data concept (entity) or group of related data concepts (subject area). In this way different working groups are assigned to govern different data entities across the landscape. During the build of a common business vocabulary, it should be possible to use data catalog software to automatically discover what data is out there across multiple data stores to help identify all the attributes associated with specific data entities. This is a bottom-up approach. By using a top down approach of a data concept model to get you started and a bottom up automated data discovery approach to identify the attributes of a data entity, it should be possible for multiple working groups to incrementally build up a common business vocabulary reasonably quickly.

Using a data catalog for automated data discovery enables the mapping of disparate data to a common vocabulary to understand where the data for each particular data entity in the business glossary is actually located across the enterprise.

## Policies and Rules to Govern Data at Different Points in The Lifecycle

Data governance policies describe a set of rules to control the integrity, quality, access security, privacy and retention of data. There are different types of policy including:

- Data integrity policies e.g. valid values, referential integrity
- Data quality policies with data standardization, cleansing and matching rules
- Data protection policies with access security and data privacy rules
- Data retention policies to manage the lifecycle with retention, archive and backup rules Note that multiple versions of a policy may be needed to govern the same data across different legal jurisdictions.

Looking back to the [Data confidentiality classification scheme](govern-requirements.md#data-confidentiality-classification-scheme) , the data confidentiality classification scheme has five classification levels. These are Public, Internal Use Only, Confidential, Sensitive PII and Restricted.

The way to govern data is to combine this data governance classification scheme with policies and rules. So, for example, consider each of the five levels as a label that can be used to label data. Take for example 'Sensitive PII'. By creating rules for Sensitive PII data and attach these rules to a policy you create a policy for Sensitive PII data. You can then attach the policy to the Sensitive PII label and then attach the Sensitive PII label to the data. In this way all data labelled as Sensitive PII is subject to the same policies and rules. This is known as tag-based policy management. It is flexible because an individual rule or a policy can be independently changed, and all data labelled Sensitive PII would then be governed by the new rules. Equally, a Sensitive PII label can be detached from data and a Confidential label used instead. In this case the data instantly becomes governed by a new set of policies and rules associated with the Confidential label.

Once policies and rules are defined in a data catalog for each class in a data governance classification scheme, they can be passed to other technologies from a data catalog (via APIs) for them to enforce. Alternatively, a common data management platform that can connect to multiple data stores could potentially enforce them.

It should then be possible to monitor data quality, privacy, access security, usage, maintenance and retention of specific data entities through their lifecycle.

## Data Governance Technology

In summary, this construction set focuses on technologies needed for data governance are:

- A data catalog that includes:
  - A business glossary
  - Automated data discovery, profiling, tagging, cataloguing and mapping to a glossary
  - Automated sensitive data detection and governance classification
  - Interoperability with other catalogs, tools and applications to share metadata via APIs and open standards
- data lakes to ingest and process data
- Enterprise data software with built-in support for:
  - Data centre, multi-cloud and edge data connectivity
  - Data stewardship tooling
  - Data cleansing and integration
  - Metadata lineage
  - Data privacy masking
  - Universal data access security across multiple data stores in a distributed data landscape
- Data stores that support data encryption, dynamic data masking and integration with the data catalog
- AI assisted data governance
- Master and reference data management
