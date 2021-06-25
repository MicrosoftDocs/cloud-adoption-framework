---
title: "Data Sharing Agreements"
description: Data Sharing Agreements
author: pstrengholt
ms.author: pietheinstrengholt
ms.date: 06/21/2020
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Data Sharing Agreements

Although Enterprise Scale Analytics and AI uses Azure AD Entitlement management to control access and sharing of data, the enterprise might require a sharing and contract repository. As this is an organizational function, this repository should reside in the Data Management Landing Zone.

The data usage phase is important to understanding how data is consumed or distributed within an organization to support the organization's objectives. In this phase, accountability and transparency must be ensured via data-sharing agreements. A data-sharing agreement is a formal contract that captures what data are being shared and how the data can be used. Such an agreement serves two purposes.

## Ensuring stable delivery

The first purpose of a data sharing agreement is to ensure stable delivery of data. The contract works like a service contract, which provides assurances to both data providers and data consumers. The data provider promises to make the delivery and describes the data format, such as schema. The contract guarantees interface compatibility and includes the terms of service and service level agreement (SLA). It describes how the data can be used, for example, only for development, testing, or production. A good SLA typically also describes the quality of data delivery and interface. This might include uptime, error rates, and availability, as well deprecation, a roadmap, and version numbers. The metadata capturing these details can be part of your ![source control](/azure/data-factory/source-control) to allow programmatically triggering validations and deployments.

The benefit of data delivery contracts is that they provide insight into the amount of coupling and the number of dependencies between domains and applications. It also allows for [!contract testing](/azure/data-factory/continuous-integration-deployment#cicd-lifecycle) to ensure all application and interface changes are validated against the consumer's data requirements. For example, you can detect schema drift to detect data flows become vulnerable to upstream data source changes. For more information see: (/en-us/azure/data-factory/concepts-data-flow-schema-drift)

Service contracts are one of the most important aspects of an enterprise-scale architecture. Once data products become popular and widely used, the need will quickly arise to implement versioning and manage compatibility and deployment. Without these disciplines in place, reusability can be low, and interfaces can break. On the most basic level it is recommended documenting contracts for all interfaces, including schemas (message formats and data) and transportation types, and their relationship to the applications.

To enable discoverability and reuse it is recommended to make all contract discoverable, for example via source control. This allows domains to automate test routines in their continuous integration and deployment pipelines. By knowing what parts of the interfaces are consumed (such as columns and objects), teams can test routines to validate against any data that will be delivered or exposed. Test validating against the structure (columns names and types of values) guarantees compatibility and stable consumption at large.

## Usage and restrictions

The second aspect of data sharing agreements is to capture the usage aspects, such as intended usage, privacy and sensitivity, and purpose (including limitations). This information is interface independent and gives insights into what data is used for what particular purpose.

Data sharing agreements also prevent miscommunication on the usage of data. Before data is shared, domains should talk in person to discuss data sharing and data usage issues and come to a collaborative understanding that will then be documented in a data sharing agreement. It is important to recognize that contexts between domains typically differ, so you might want to apply both ![classifications and conditions](/azure/purview/create-sensitivity-label) to consistently apply sensitivity labels across the organization.

The process of capturing metadata within source control can also be applied on the data consuming side. You might require users to register and publish the purpose of their data consumption for the various use cases and agree not to distribute data further. This, for example, is important not only from a regulatory perspective, but also because it gives the data providers valuable information. It additionally will enable data security enforcement. For example, Azure Synapse Analytics can use all metadata to apply dynamic data masking, preventing unauthorized access to sensitive labeled data.

## Compliance

Data sharing agreements are key because they provide insights about the data supply chain and make service level contracts, controls, data quality rules, and data usage transparent to the organization. These contracts are typically stored in a (central) code repository or source control. Publishing these contracts centrally allows providers and consumers to resolve their data delivery and consumption issues themselves, without the support of a central team. This becomes essential once we start moving away from a siloed data-platform approach and empower autonomous teams.
