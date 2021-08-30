---
title: Data sharing agreements in data management and analytics in Azure
description: Learn how data sharing agreements ensure stable delivery of data and manage compliance and governance in Azure.
author: pietheinstrengholt
ms.author: pstrengholt
ms.date: 7/20/2021
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: overview
---

# Data sharing agreements in data management and analytics

The data management and analytics scenario recommends using Azure Active Directory (Azure AD) entitlement management to control access and sharing of data. Your organization might also require a sharing and contract repository. This repository should be in the data management landing zone.

The data usage phase is important to understanding how data is consumed or distributed in your organization. In this phase, ensure accountability and transparency by using data sharing agreements. A data sharing agreement is a formal contract that defines the shared data and how that data can be used.

A data-sharing agreement serves two purposes:

- Ensure stable data delivery
- Manage compliance and governance

## Ensure stable delivery

A data sharing agreement ensures stable delivery of data. The agreement works like a service contract. It provides assurances to both data providers and data consumers. The data provider promises to make the delivery and describes the data format. The contract guarantees interface compatibility and includes the terms of service and service-level agreement (SLA). The agreement describes how the data can be used. For example, data might be used only for development, testing, or production.

A good SLA typically describes the quality of data delivery and interface. This part of the SLA might include uptime, error rates, and availability. It could also include deprecation, a roadmap, and version numbers. The metadata that capture these details can be under source control. That approach allows automatic triggering validations and deployments. For more information, see [Source control in Azure Data Factory](/azure/data-factory/source-control).

Data delivery contracts provide insight into coupling and dependencies between domains and applications. A contract also allows for [contract testing](/azure/data-factory/continuous-integration-deployment#cicd-lifecycle). Testing ensures all application and interface changes are validated against the consumer's data requirements. You can detect schema drift to detect when data flows become vulnerable to upstream data source changes. For more information, see [Schema drift in mapping data flow](/en-us/azure/data-factory/concepts-data-flow-schema-drift).

When data products become popular and widely used, you need to implement versioning and manage compatibility and deployment. Without these disciplines, reusability can be low and interfaces can break. We recommend documenting contracts for all interfaces. Document message-format schemas, data schemas, transportation types, and their relationship to the applications.

To enable discoverability and reuse, we recommend that you make all contract discoverable. You could use source control. This approach allows domains to automate test routines in their continuous integration and deployment pipelines. Knowing what parts of the interfaces are consumed allows teams to test data to be delivered or exposed. Validating against the structure offers compatibility and stable consumption at large.

## Compliance and governance

Data sharing agreements capture usage aspects, such as intended usage, privacy and sensitivity, and purpose. This information is interface independent. It gives insights into what data is used for what purpose.

Data sharing agreements also prevent miscommunication on the usage of data. Before data is shared, domains should discuss data sharing and data usage issues. They should come to a collaborative understanding, documented in a data sharing agreement. Contexts between domains typically differ. You might want to apply both classifications and conditions to consistently apply sensitivity labels across the organization. For more information, see [Automatically label your data in Azure Purview](/azure/purview/create-sensitivity-label).

The data consuming side can also apply the process of capturing metadata in source control. You might require users to register and publish the purpose of their data consumption and agree not to distribute data further. This restriction is important not only from a regulatory perspective, but also because it gives the data providers valuable information. It also enables data security enforcement. For example, Azure Synapse Analytics can use metadata to apply dynamic data masking. This approach prevents unauthorized access to sensitive labeled data.

## Scalability

Data sharing agreements provide insights about the data supply chain. These agreements make service level contracts, controls, data quality rules, and data usage transparent to the organization. Contracts are typically stored in a central code repository or source control.

Publishing contracts centrally allows providers and consumers to resolve their data delivery and consumption issues themselves, without the support of a central team. This approach becomes essential once you start moving away from a siloed data-platform approach. It empowers autonomous teams.

## Next steps

[Secure data management and analytics](./secure.md)
