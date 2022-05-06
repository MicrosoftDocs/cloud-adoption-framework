---
title: Data contracts
description: Data contracts in a data mesh
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 03/22/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Data contracts

It can be difficult to oversee dependencies and obtain insights in data usage in a federated architecture because responsibilities are distributed between [domains](./data-domains.md). Data contracts help you obtain data usage insights by providing information on who owns which [data products](./what-is-data-product.md). They can help you set standards and manage your data pipelines with confidence. Data contracts are essential for robust data management, providing information about:

- Which data products are being consumed

- Who is consuming them

- What purpose they are consumed for

Data product distribution and usage involves two dimensions: technical concerns and business concerns. Technical concerns include data pipeline handling and mutual data stability expectations. Business concerns include agreements on the purpose of data sharing, including usage, privacy, and purpose objectives (including limitations).

Different roles are involved in the two separate dimensions. You should generally rely on application owners or data engineers for technical concerns, and product owners or business representatives for business concerns.

## Data contracts

Data contracts are similar to service contracts or data delivery contracts.

In a larger or distributed architecture, it can be difficult to oversee changes. To simplify this oversight, implement versioning and manage compatibility whenever you have a data product that's popular and widely used. If your applications are coupled, that means there's a high degree of interdependence between the applications. Applications that access or consume data from other applications always suffer when coupling is in play. Any change to the data structure, for example, is likely to have a direct impact on other applications that access or consume that data. In situations where many applications are coupled with each other, you sometimes see a cascading effect, where just a small change to a single application causes the adjustment of many other applications. Because of the likelihood of unintended effects after even minor changes, many architects and software engineers avoid building coupled architectures.

A data contract guarantees interface compatibility and includes the terms of service and service level agreement (SLA). Terms of service outline how data can be used, such as restricting its use to only development, testing, or production. An SLA describes the required quality of data delivery and interface. Quality details an SLA might specify include:

- Uptime
- Error rates
- Availability
- Deprecation
- A roadmap
- Version numbers

The metadata that captures these details can be under source control, allowing for automatic triggering of validations and deployments. For more information on source control, see [Source control in Azure Data Factory](/azure/data-factory/source-control).

Data contracts provide insight into coupling and dependencies between domains and applications. A contract also allows for [contract testing](/azure/data-factory/continuous-integration-delivery#cicd-lifecycle), which ensures that all application and interface changes are validated against consumers' data requirements. You can tell when your data flows become vulnerable to upstream data source changes by detecting schema drift. For more information, see [Schema drift in mapping data flow](/azure/data-factory/concepts-data-flow-schema-drift).

Data contracts are often part of metadata-driven ingestion frameworks. You might store data contracts in metadata records within a centrally managed [metastore](../govern-metadata-standards.md), and from there, your data contracts can play an important role in data multiple areas of data ingestion, including pipeline execution, data product creation, validation of data types, schemas, interoperability standards, protocol versions, defaulting rules on missing data, and so on. 

Data contracts involve a large amount of technical metadata. To document your data pipelines and data products, you need to have a clear description of each data's source, any transformations you've applied to your data, and the way you ultimately deliver your data.

:::image type="content" source="../media/data-contracts.png" alt-text="Diagram showing data contracts." lightbox="../media/data-contracts.png":::

When using a distributed architecture, distribute your data pipeline framework across different domains. In this approach, domains conform to a common way of working, and since domains process data themselves, control and responsibility stay with your domains. Your framework and metadata, however, remain under central governance.

Start small when implementing a federated method. Begin with basics, such as metadata storage for schema validation, enterprise identifiers, and references to other datasets in your shared metadata repository. Add data [lineage](../govern-lineage.md) support to help you visualize data movement. Bootstrap your processes, and use libraries like [Great Expectations](https://greatexpectations.io/) to implement controls for technical data quality validation.

Make all your controls part of your continuous integration procedures. Capture all runtime information, including metrics and logging. Make that information part of your metadata foundation to gain insight into the stability of your data pipelines. This setup ensures a feedback loop between our domains and your central management cockpit.

As stabilize all data movement, capture what data attributes, such as tables and columns, are used by what data consumers, and use this to continue scaling. You can include this information in your centrally managed metastore. You need this information on data usage to detect breaking changes and to identify any ways your data producers or consumers are affected. If a data product dataset doesn't have any consumers, you can allow it to experience disruptive changes. Use source control, such as Git, to allow a handshake process between providers and consumers of your data.

## Data Sharing Agreement

Data sharing agreements are an extension of data contracts. The agreements cover data's intended usage, privacy, and purpose, including any limitations. Data sharing agreements are interface independent and offer you insights into which data is used for which purpose. They also function as input for your data security controls. You can use a data sharing agreement to outline which filters or security protections should be applied to your data.

Data sharing agreements also help you prevent miscommunication over data usage. Before data is shared, domains should discuss data sharing and data usage issues. Reaching a common understanding is important for regulating data and its usage and ensuring you can deliver value to your organization. After domains reach a collaborative understanding, ensure they document that understanding in a data sharing agreement. Your data sharing agreement can also address other areas like: 

- Functional data quality

- Historization

- Data life cycle management

- Further distribution of your data

Apply classifications and conditions like to your data, such as sensitivity labels or filtering conditions. This becomes a concern when securing data. In the diagram from the previous section, you witness a “data product sidecar”. Zhamak Dehghani refers to this as a component or layer for injecting policy execution, such as data access controls or output method of data consumption. It’s a security abstraction over your domain data for handling your security enforcement. It will generate this enforcement by using your data contracts. It can be an ACL or serverless view, which is dynamically created from your data contract repository after reaching a common understanding. Or duplicated dataset, which is selected and filtered for a specific consumer. Your end goal must be to derive these security views from your data contracts in a fully automated manner.

Finally, it is encouraged you to also make a relationship between your data contract attributes and documentation. Ensure semantic context is provided and a relationship is made to your glossary. This allows consumers to understand how the translation from business requirements to an actual implementation has been made. If a relationship to business terms is important to you, consider implementing policies. For example, a contract can only be established when all data product attributed are linked to business term entities. Same policies might also apply for contextual changes, such as relationship and definition adjustments.

## Getting started with using data contracts

How to get started with data contracts? How to make things practical? The recommendation is to start slow. It’s mostly an organizational challenge. Don’t introduce too many changes after each other. Data contracts are a cultural shift. Users need to become familiar and must understand the importance of data ownership. The transition is also about finding the sweet spot between too few and too many metadata attributes. About the transition:

1. First, create stability over your technical data pipelines. If they’re unstable and subject to unexpected and disruptive changes, none of your use cases will make it into production.

1. For your data sharing agreements, start simple and pragmatic by putting a process in place. Don’t overcomplicate things. You could, for example, start with a simple form or template that is designed in Microsoft Forms. You should draft it in clear, concise language that is easy to understand. Accept manual processes. Limit your initial metadata requirements. Your first phase is about cultural shift and collecting requirements. Iterate until your metadata requirements become stable.

1. After you put your first processes in place, try to replace your manual forms with a web-based application, database and/or message queue. During this stage, your central data governance team will still be overseeing. The level of granularity of data access is typically coarse-grained, so on folders or files. Try to utilize REST APIs for automatically provisioning data access policies or ACLs.

1. Your next stage is implementing a stronger workflow for handling approvals. Put your data owners or data stewards in the lead. Your central data governance team will be overseeing from the back seat. This team reviews all data contracts regularly. By this stage you should also have a data catalog, such as [Azure Purview](/azure/purview/), up and running showing all ready-for-consumption data products. Make improvements to your data security and enforcement capabilities. Allow for finer-grained selections and filters. Consider techniques like dynamic data masking to prevent data duplication.

1. At the end of your journey, everything will be self-service and fully automated. This includes automated security enforcement and machine learning for predicting data approvals. Secure views, for example, are automatically deployed after approval.

Data contracts are a relatively new approach to data mesh. They're important as they provide transparency over your dependencies and data usage. Start small and focus on technical stability and standardization first. Iterate by using a lessons-learned process. Data governance is essential, but too much will cause overhead. Slowly build up and automate.

## References

For more information about observability and data sharing agreements, see:

- [Cloud monitoring guide: Observability](../../../manage/monitor/observability.md)

## Summary

Another aspect that needs to be part of the data contract documentation is the terms of service and service-level agreement (SLA). A good SLA typically describes the quality of data delivery and interface. This part of the SLA might include uptime, error rates, and availability. It could also include deprecation, a roadmap, and version numbers.

## Next Steps

[Design considerations for self-serve data platforms](self-serve-data-platforms.md)
