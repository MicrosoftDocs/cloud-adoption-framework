---
title: Data contracts
description: Data contracts in a data mesh
author: PietheinStrengholt
ms.author: pstrengholt
ms.date: 11/27/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Data contracts

Responsibilities are distributed between [domains](./data-domains.md) in a federated architecture, which can make it difficult to oversee dependencies and gain data usage insights. Data contracts can help you gain data usage insights because they provide information about who owns each [data product](./what-is-data-product.md). Data contracts help you set standards and confidently manage your data pipelines. They are essential for robust data management, providing information on:

- Which data products are being consumed.
- Which users are consuming which data products.
- What purpose is leading users to consume specific data products.

Data product distribution and usage have two dimensions: technical concerns and business concerns. Technical concerns include data pipeline handling and mutual data stability expectations. Business concerns include data sharing purpose agreements, which define usage, privacy, and purpose objectives, including any limitations.

The two dimensions involve different roles. Generally, you should rely on application owners or data engineers for technical concerns and product owners or business representatives for business concerns.

## Data contracts principles

Data contracts are similar to service contracts or data delivery contracts.

In a larger or distributed architecture, it can be difficult to oversee changes. You can simplify your oversight by implementing versioning and managing compatibility whenever you have a data product that is popular and widely used.

If applications are coupled, it indicates a high degree of interdependence between the coupled applications. Applications that access or consume data from other applications always suffer when coupled. Any change to the data structure, for example, is likely to directly affect other applications that access or consume that data. In situations where you have many applications coupled together, it is common to encounter a cascading effect where a small change to a single application affects many other applications. Due to the increased likelihood of unintended effects after even minor changes, many architects and software engineers avoid building coupled architectures.

A data contract guarantees interface compatibility and includes terms of service and a service level agreement (SLA). Terms of service outline how data can be used, such as restricting its use to only development, testing, or production. SLAs describe the required quality of data delivery and interface. Quality details you might specify in an SLA include:

- Uptime
- Error rates
- Availability
- Deprecation
- A roadmap
- Version numbers

You can place the metadata that captures these details under source control, which allows for automatic triggering of validations and deployments. For more information on source control, see [Source control in Azure Data Factory](/azure/data-factory/source-control).

Data contracts provide insight into coupling and dependencies between domains and applications. A contract also allows for [contract testing](/azure/data-factory/continuous-integration-delivery#cicd-lifecycle), which ensures that all application and interface changes are validated against your consumers' data requirements. You can tell when your data flows become vulnerable to upstream data source changes by detecting schema drift. For more information, see [Schema drift in mapping data flow](/azure/data-factory/concepts-data-flow-schema-drift).

Data contracts are often part of metadata-driven ingestion frameworks. You can store data contracts in metadata records within a centrally managed [metastore](../govern-metadata-standards.md). From that central location, your data contracts play an important role in multiple areas of data ingestion, including:

- Pipeline execution
- Data product creation
- Data type validation
- Schemas
- Interoperability standards
- Protocol versions
- Defaulting rules on missing data

Data contracts involve large quantities of technical metadata. To document your data pipelines and data products, you must have a clear description of your data sources, all transformations your data has undergone, and how you ultimately deliver the data.

:::image type="content" source="../media/data-contracts.png" alt-text="Diagram showing data contracts." lightbox="../media/data-contracts.png":::

In a distributed architecture, you distribute a data pipeline framework across different domains, and the domains conform to a common way of working. Since the domains process data themselves, control and responsibility stay with them, while the framework and metadata remain under central governance.

When implementing a federated method, start small. Begin with basics, like metadata storage for schema validation, enterprise identifiers, and references to other datasets in your shared metadata repository. Add data [lineage](../govern-lineage.md) support to help you visualize data movement. Bootstrap your processes and implement controls for technical data quality validation.

All your controls should be part of your continuous integration procedures. Capture all runtime information, including metrics and logging, and make that information part of your metadata foundation for gaining data pipeline stability insights. This setup ensures that you have a feedback loop between your domains and your central management cockpit.

As you stabilize all data movement, capture which data attributes (like tables and columns) are used by which data consumers and use this information to continue scaling. You can include this information in your centrally managed metastore. Data usage information allows you to detect breaking changes and identify their effects on your data producers and consumers. If a data product dataset has no consumers, you can allow it to experience disruptive changes. Use source control (like Git) to allow a handshake process between providers and consumers of your data.

## Data sharing agreements

Data sharing agreements are an extension of data contracts. The agreements outline data usage, privacy, and purpose, including any limitations. Data sharing agreements are interface-independent and offer insights into what data is used for a particular purpose. They also function as input for data security controls. You can use a data sharing agreement to outline which filters or security protections must be applied to your data.

Data sharing agreements also help prevent miscommunication over data usage. Domain owners should discuss data sharing and data usage issues before any data is shared. Having a common understanding is critical for your ability to regulate data and its usage and ensure you can deliver value to your organization. After all domain owners reach a collaborative understanding, ensure that they document it in a data sharing agreement. In this agreement, you can also address areas like:

- Functional data quality
- Historization
- Data lifecycle management
- Further distribution of data

Apply classifications and conditions like sensitivity labels or filtering conditions to secure your data.

The previous section's diagram shows certain elements labeled *data product sidecar*. A data product sidecar is a component or layer for injecting policy execution, like data access controls or data consumption output methods. It's a security abstraction that uses data contracts to handle security enforcement over your domain data. You can create a data product sidecar from your data contract repository as an access control list (ACL) or serverless view, or you can create one using a duplicated dataset that you select and filter for a specific consumer. Either way, the goal is to derive security views from your data contracts in a fully automated manner.

Connect data contract attributes and your documentation. Ensure that you provide semantic context and a relationship to your glossary so that your consumers can understand how business requirements translate to an actual implementation. If a relationship with business terms is important to your organization, consider implementing policies such as only allowing data contracts to be established after all data product attributes are linked to business term entities. You might also apply this type of policy to contextual changes like relationship or definition adjustments.

## Use data contracts

Start slow when beginning to use data contracts. Don't introduce too many changes at once; data contracts require a cultural shift, and your users need time to become familiar with them and understand the importance of data ownership. You also need to find the sweet spot between too few and too many metadata attributes in your data contracts.

The following steps outline the process of implementing data contracts for your organization:

1. Ensure your technical data pipelines are stable. Use cases can't reach production if the pipelines they travel through experience unexpected disruptions.
2. Put simple and pragmatic processes in place as you start using sharing agreements. You can begin by designing a simple form or template in Microsoft Forms. Write in clear, concise language that readers can easily understand. The focus of this first phase is a cultural shift and collecting requirements. Make sure you don't overcomplicate things; accept manual processes, limit your initial metadata requirements, and iterate until those requirements are stable.
3. After you have your first processes firmly in place, begin replacing your manual forms with a web-based application, database, and/or message queue. Your central data governance team should still be responsible for oversight during this phase. Data access granularity at this point is typically coarse-grained, focusing on folders or files. Whenever possible, use REST APIs to automatically provision your data access policies or ACLs.
4. Put data owners or data stewards in charge of a strong workflow for approval management. Your central data governance role should now oversee approvals only from a backseat role and review all data contracts regularly. At this point, you should have a data catalog like [Microsoft Purview](/purview/what-is-data-catalog) up and running that shows all your ready-for-consumption data products. Improve your data and security enforcement capability by allowing for fine-grained selections and filtering, and consider using techniques like dynamic data masking to prevent your data from being duplicated.
5. In the final stage of your data contract implementation journey, everything should be self-service and fully automated. Automated machine learning should predict data approvals. Secure views, for example, are automatically deployed after approval.

Data contracts are a relatively new yet important addition to data mesh architecture, providing transparency for data usage and dependencies. Focus on technical stability and standardization as you first begin to use data contracts, then use a lessons-learned process as you iterate. Slowly build up and automate your data governance so you don't increase your organization's overhead.

As part of your data contract documentation, you also need terms of service and service-level agreements (SLAs). Use SLAs to outline quality requirements for your data delivery and interfaces, including uptime, error rates, and availability. SLAs can also include any deprecation, roadmap, and version number requirements you need to define.

## Next steps

- [Design considerations for self-serve data platforms](self-serve-data-platforms.md)