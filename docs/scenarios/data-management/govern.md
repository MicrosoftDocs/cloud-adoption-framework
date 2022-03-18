---
title: Data governance overview
description: Understand the concept of data governance in the cloud and for Azure.
author: mboswell
ms.author: mboswell
ms.date: 03/18/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data governance overview

Breaking down structured data into data entities and data subject areas is the key to successful data governance. You can then use a data governance solution to surround your specific data entities and data subject areas with people, processes, policies, and technology. This solution helps your data entities' lifecycle governance. Establishing a common business vocabulary in a business glossary within your data catalog can also help you govern your data.

Your data catalog is critical technology. You can't govern your data if you don't know where it's or what it means. Data catalog software provides automatic data discovery, automatic profiling that determines data quality, and automatic sensitive data detection. It also helps you map disparate data to your common vocabulary data names and definitions in your catalog's business glossary to understand what the data means.

Data classification is a method of categorizing data assets by assigning them unique logical labels or classes. Classification is based on the data's business context. Some classification labels or classes you might use include:

- Passport number
- Driver's license number
- Credit card number
- SWIFT code
- Individual's name

Data classification schemes such as the examples shown in [data confidentiality classification scheme](./govern-requirements.md#data-confidentiality-classification-scheme). This schema must be defined in your data catalog. At this point, you can create policies and rules in your catalog associated with different levels of classification.

Create a [data lifecycle retention classification scheme](govern-requirements.md#data-lifecycle-retention-classification-scheme) to provide different levels of retention classification for your data lifecycle management. You can have a custom microservice lifecycle application use this scheme to maintain data's lifecycle within your environment.

Specify how to govern data attributes in your business glossary by labeling (or tagging) them with confidentiality and retention classification. Your data catalog already knows the mappings of physical data attributes in different data stores to business glossary attributes. Labeling an attribute in your glossary automatically determines how the data mapped to it in underlying data stores should be governed. Multiple technologies integrated with your data catalog can enforce policies and rules across all data stores in your distributed data landscape by accessing this metadata. You can also apply these same classification labels to unstructured data.

Master data entities are critical because their data is so widely shared. Master data entities are frequently associated with documents. Customer and invoice, supplier and contract, and asset and operating manual are all examples of a master data entity and document pairing. This type of connection allows you to tag related documents using master data values (such as a supplier name) and ensure that relationships between structured and unstructured data are preserved.

You can create pipelines that create trusted data assets by using the common vocabulary data entities you defined in your data catalog. You can then publish these assets in a data marketplace for all to share. 

The key takeaway here about data governance is that you can use available methods to get your data under control, and once your data is trusted, you can use it to drive value. How well you organize and collaborate to achieve data governance determines your level of success.

## Data governance maturity model

When looking at the challenge of data governance, you might wonder how mature your ability to cover all governance aspects across your data landscape is. The following tables are provided to help you assess where you currently are in the data governance maturity model.

## People

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
| No SMEs identified for data entities | Some SMEs identified, but not engaged | SMEs identified and in data governance working groups | SMEs identified and in data governance working groups |

## Process

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No common business vocabulary | Common business vocabulary begun in a glossary | Common business vocabulary established | Common business vocabulary complete |
| No way to know data location, quality or sensitivity | Data catalog auto data discovery, profiling and sensitive data detection on some systems | Data catalog auto data discovery, profiling and sensitive data detection on all structured data | Data catalog auto data discovery, profiling and sensitive data detection on structured and unstructured in all systems w/ full auto tagging |
| No process to govern authoring or maintenance of policies and rules | Governance of data access security, policy authoring, and maintenance on some systems | Governance of data access security, privacy, and retention policy authoring and maintenance | Governance of data access security, privacy, and retention policy authoring and maintenance |
| No way to enforce policies and rules | Piecemeal enforcement of data access security policies and rules across systems with no catalog integration | Enforcement of data access security and privacy policies and rules across systems with catalog integration | Enforcement of data access security, privacy, and retention policies and rules across all systems |
| No process to monitor data quality, data privacy, or data access security | Some ability to monitor data quality, some ability to monitor privacy (such as queries) | Monitoring and stewardship of data quality and data privacy on core systems with DBMS masking | Monitoring and stewardship of data quality and data privacy on all systems with dynamic masking |
| No availability of fully trusted data assets | Development started for a small set of trusted data assets using data fabric software | Several core trusted data assets created using data fabric | Continuous delivery of trusted data assets through enterprise data marketplace |
| No way to know whether a policy violation occurs or process to act if one does | Data access security violation detection in some systems | Data access security violation detection in all systems | Data access security violation detection in all systems |
| No vulnerability testing process | Limited vulnerability testing process | Vulnerability testing process for all systems | Vulnerability testing process for all systems |
| No common process for master data creation, maintenance, and sync | MDM with common master data CRUD and sync processes for single entity | MDM with common master data CRUD and sync processes for some data entities | MDM with common master data CRUD and sync processes for all master data entities |

## Policies

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No data governance classification schemes on confidentiality and retention | Data governance classification scheme for confidentiality | Data governance classification scheme for both confidentiality and retention | Data governance classification scheme for both confidentiality and retention |
| No policies and rules to govern data quality | Policies and rules to govern data quality begun in common vocabulary in business glossary | Policies and rules to govern data quality defined in common vocabulary in catalog biz glossary | Policies and rules to govern data quality defined in common vocabulary in catalog biz glossary |
| No policies and rules to govern data access security | Some policies and rules to govern data access security created in different technologies | Policies and rules to govern data access security and data privacy consolidated in the data catalog using classification scheme | Policies and rules to govern data access security, data privacy, and retention consolidated in the data catalog using classification schemes and enforced everywhere |
| No policies and rules to govern data privacy | Some policies and rules to govern data privacy | Policies and rules to govern data access security and data privacy consolidated in the data catalog using classification scheme | Policies and rules to govern data access security, data privacy, and retention consolidated in the data catalog using classification schemes and enforced everywhere |
| No policies and rules to govern data retention | No policies and rules to govern data retention | Some policies and rules to govern data retention | Policies and rules to govern data access security, data privacy, and retention consolidated in the data catalog using classification schemes and enforced everywhere |
| No policies and rules to govern master data maintenance | Policies and rules to govern master data maintenance for a single master data entity | Policies and rules to govern master data maintenance for some master data entities | Policies and rules to govern master data maintenance for all master data entities |

## Technology

| Ungoverned | Stage 1 | Stage 2 | Fully governed |
|--|--|--|--|
| No data catalog with auto data discovery, profiling and sensitive data detection | Data catalog with auto data discovery, profiling and sensitive data detection purchased | Data catalog with auto data discovery, profiling and sensitive data detection purchased | Data catalog with auto data discovery, profiling and sensitive data detection purchased |
| No data fabric software with multicloud edge and datacenter connectivity | Data fabric software with multicloud edge and datacenter connectivity and catalog integration purchased | Data fabric software with multicloud edge and datacenter connectivity and catalog integration purchased | Data fabric software with multicloud edge and datacenter connectivity and catalog integration purchased |
| No metadata lineage | Metadata lineage available in data catalog on trusted assets being developed using fabric | Metadata lineage available in data catalog on trusted assets being developed using fabric | Metadata lineage available in data catalog on trusted assets being developed using fabric |
| No data stewardship tools | Data stewardship tools available as part of the data fabric software | Data stewardship tools available as part of the data fabric software | Data stewardship tools available as part of the data fabric software |
| No data access security tool | Data access security in multiple technologies | Data access security in multiple technologies | Data access security enforced in all systems |
| No data privacy enforcement software | No data privacy enforcement software | Data privacy enforcement software in some database management systems | Data privacy enforcement software in all data stores |
| No master data management system | Single entity master data management system | Multientity master data management system | Multientity master data management system |

## Data governance maturity summary

Once you've worked out where you currently land in governance maturity model, meet with your key stakeholders to map out a strategy to increase your maturity. This can involve defining your requirements, technology, data quality, metadata, data sharing, and master data strategy.

## Next steps

- [Requirements for governing data](./govern-requirements.md)
