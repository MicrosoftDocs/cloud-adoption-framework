---
title: Data governance overview
description: Understand the concepts of data governance in the cloud and the data governance maturity model.
author: mboswell
ms.author: mboswell
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data governance overview

The key to successful data governance is to break down structured data into data entities and data subject areas. You can then use a data governance solution to surround your specific data entities and data subject areas with people, processes, policies, and technology. The solution helps you govern your data entities' lifecycles. Establishing a common business vocabulary in a glossary within your data catalog also helps you govern your data.

Your data catalog technology is critical. You can't govern your data if you don't know where the data is or what it means. Data catalog software provides automatic data discovery, automatic profiling that determines data quality, and automatic sensitive data detection. Data catalog technology also helps you map disparate data to the common vocabulary data names and definitions in your catalog's business glossary to understand what the data means.

Data classification categorizes data assets by assigning them unique logical labels or classes based on business context. Examples of classification labels or classes include:

- Passport number.
- Driver's license number.
- Credit card number.
- SWIFT code.
- Individual's name.

You can define data classification schemes such as a [data confidentiality classification scheme](./govern-requirements.md#data-confidentiality-classification-scheme) in your data catalog. To define the scheme, you associate policies and rules in your catalog with different classification levels.

A [data lifecycle retention classification scheme](govern-requirements.md#data-lifecycle-retention-classification-scheme) provides different retention classifications for data lifecycle management. A custom microservice lifecycle application can use this scheme to maintain the data lifecycle within your environment.

Label or tag data attributes in your business glossary with confidentiality and retention classifications that specify their governance. Labeling an attribute in your glossary automatically defines how to govern data mapped to the attribute in underlying data stores. Your data catalog maps the physical data attributes in different data stores to the business glossary attributes.

You can integrate multiple technologies with your data catalog to access these attributes and enforce policies and rules across all data stores in your distributed data landscape. You can also apply the same classification labels to unstructured data.

Master data entities are important because their data is widely shared. Master data entities are often associated with documents. Customer and invoice, supplier and contract, and asset and operating manual are example master data entity and document pairings. By using this type of connection, you can tag related documents with master data values, such as a supplier name, and preserve relationships between structured and unstructured data.

You can create pipelines that create trusted data assets by using the common vocabulary data entities from your data catalog. You can then publish these assets in a data marketplace to share.

The key takeaway is that you can use available data governance methods to get your data under control. After your data is trusted, you can use the data to drive value. How well you organize and coordinate your data governance determines your level of success.

## Data governance maturity model

The data governance maturity model describes the maturity of your ability to cover all governance aspects across your data landscape. The following tables can help you assess your current position in the data governance maturity model.

### People

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No stakeholder executive sponsor | Stakeholder sponsor in place | Stakeholder sponsor in place | Stakeholder sponsor in place |
| No roles and responsibilities | Roles and responsibilities defined | Roles and responsibilities defined | Roles and responsibilities defined |
| No data governance control board | Data governance control board in place but no data | Data governance control board in place with data | Data governance control board in place with data |
| No data governance working groups | No data governance working groups | Some data governance working groups in place | All data governance working groups in place |
| No data owners accountable for data | No data owners accountable for data | Some data owners in place | All data owners in place |
| No data stewards appointed with responsibility for data quality | Some data stewards in place for data quality, but scope too broad, like whole department | Data stewards in place and assigned to data governance working groups for specific data | Data stewards in place assigned to data governance working groups for specific data |
| No one accountable for data privacy | No one accountable for data privacy | Chief privacy officer accountable for privacy, no tools | Chief privacy officer accountable for privacy with tools |
| No one accountable for access security | IT accountable for access security | IT security accountable for access security | IT security accountable for access security and responsible for privacy enforcement |
| No trusted data asset producer | Data publisher identified and accountable for producing trusted data | Data publisher identified and accountable for producing trusted data | Data publisher identified and accountable for producing trusted data |
| No subject-matter experts (SMEs) identified for data entities | Some SMEs identified, but not engaged | SMEs identified and in data governance working groups | SMEs identified and in data governance working groups |

### Process

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No common business vocabulary | Common business vocabulary begun in a glossary | Common business vocabulary established | Common business vocabulary complete and maintained |
| No way to know data location, quality or sensitivity | Data catalog auto data discovery, profiling, and sensitive data detection on some systems | Data catalog auto data discovery, profiling, and sensitive data detection on all structured data | Data catalog auto data discovery, profiling, and sensitive data detection on structured and unstructured data in all systems, with full auto-tagging |
| No process to govern authoring or maintenance of policies and rules | Governance of data access security, policy authoring, and maintenance on some systems | Governance of data access security, privacy, and retention policy authoring and maintenance | Governance of data access security, privacy, and retention policy authoring and maintenance |
| No way to enforce policies and rules | Piecemeal enforcement of data access security policies and rules across systems with no catalog integration | Enforcement of data access security and privacy policies and rules across systems with catalog integration | Enforcement of data access security, privacy, and retention policies and rules across all systems |
| No process to monitor data quality, data privacy, or data access security | Some ability to monitor data quality, some ability to monitor privacy, such as queries | Monitoring and stewardship of data quality and data privacy on core systems with database management system (DBMS) masking | Monitoring and stewardship of data quality and data privacy on all systems with dynamic masking |
| No availability of fully trusted data assets | Development started for a small set of trusted data assets using data fabric software | Several core trusted data assets created using data fabric | Continuous delivery of trusted data assets through enterprise data marketplace |
| No way to know whether a policy violation occurs or process if one occurs | Data access security violation detection in some systems | Data access security violation detection in all systems | Data access security violation detection in all systems |
| No vulnerability testing process | Limited vulnerability testing process | Vulnerability testing process for all systems | Vulnerability testing process for all systems |
| No common process for master data creation, maintenance, and sync | Master data management (MDM) with common master data create, read, update, and delete (CRUD) and sync processes for single entities | MDM with common master data CRUD and sync processes for some data entities | MDM with common master data CRUD and sync processes for all master data entities |

### Policies

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No data governance classification schemes on confidentiality and retention | Data governance classification scheme for confidentiality | Data governance classification scheme for both confidentiality and retention | Data governance classification scheme for both confidentiality and retention |
| No policies and rules to govern data quality | Policies and rules to govern data quality begun in common vocabulary in business glossary | Policies and rules to govern data quality defined in common vocabulary in catalog business glossary | Policies and rules to govern data quality defined in common vocabulary in catalog business glossary |
| No policies and rules to govern data access security | Some policies and rules to govern data access security created in different technologies | Policies and rules to govern data access security consolidated in the data catalog using a classification scheme | Policies and rules to govern data access security consolidated in the data catalog using a classification scheme and enforced everywhere |
| No policies and rules to govern data privacy | Some policies and rules to govern data privacy | Policies and rules to govern data privacy consolidated in the data catalog using a classification scheme | Policies and rules to govern data privacy consolidated in the data catalog using a classification scheme and enforced everywhere |
| No policies and rules to govern data retention | Some policies and rules to govern data retention | Policies and rules to govern data retention consolidated in the data catalog using a classification scheme | Policies and rules to govern data retention consolidated in the data catalog using classification schemes and enforced everywhere |
| No policies and rules to govern master data maintenance | Policies and rules to govern master data maintenance for a single master data entity | Policies and rules to govern master data maintenance for some master data entities | Policies and rules to govern master data maintenance for all master data entities |

### Technology

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No data catalog with auto data discovery, profiling, and sensitive data detection | Data catalog with auto data discovery, profiling, and sensitive data detection purchased | Data catalog with auto data discovery, profiling, and sensitive data detection purchased | Data catalog with auto data discovery, profiling, and sensitive data detection purchased |
| No data fabric software with multicloud edge and datacenter connectivity | Data fabric software with multicloud edge and datacenter connectivity and catalog integration purchased | Data fabric software with multicloud edge and datacenter connectivity and catalog integration purchased | Data fabric software with multicloud edge and datacenter connectivity and catalog integration purchased |
| No metadata lineage | Metadata lineage available in data catalog on trusted assets being developed by using fabric | Metadata lineage available in data catalog on trusted assets being developed by using fabric | Metadata lineage available in data catalog on trusted assets being developed by using fabric |
| No data stewardship tools | Data stewardship tools available as part of the data fabric software | Data stewardship tools available as part of the data fabric software | Data stewardship tools available as part of the data fabric software |
| No data access security tool | Data access security in multiple technologies | Data access security in multiple technologies | Data access security enforced in all systems |
| No data privacy enforcement software | No data privacy enforcement software | Data privacy enforcement software in some database management systems | Data privacy enforcement software in all data stores |
| No MDM system | Single entity MDM system | Multientity MDM system | Multientity MDM system |

## Data governance maturity summary

After you determine where you currently stand in the governance maturity model, meet with your key stakeholders to map out a strategy to increase your maturity. Start by defining your requirements, technology, data quality, metadata, data sharing, and master data strategy.

## Next steps

> [!div class="nextstepaction"]
> [Requirements for governing data](./govern-requirements.md)
