---
title: Scale cloud-scale analytics in Azure
description: Learn how to scale cloud-scale analytics in Azure by using data landing zones. Your scalable platform can have one or more landing zones, as required.
author: marvinbuss
ms.author: mabuss
ms.date: 11/12/2024
ms.topic: conceptual
ms.custom: e2e-data-management, think-tank
---

# Scale cloud-scale analytics in Azure

A scalable data platform is critical for accommodating the rapid growth of data. Vast amounts of data are generated every second around the world. The amount of available data is expected to continue growing exponentially over the next few years. As the rate of data generation increases, the speed of data movement also increases.

No matter how much data you have, your users demand fast query responses. They expect to wait minutes, not hours, for results. This article explains how you can scale your Azure cloud-scale analytics solution and continue to meet user demands for speed.

## Introduction

Many enterprises have large data platform monoliths. These monoliths are built around a single Azure Data Lake Gen2 account, and sometimes a single storage container. A single Azure subscription is often used for all data platform-related tasks. Subscription-level scaling is absent in most architectural platforms, which can hinder continued Azure adoption if users run into any of the [Azure subscription or service-level limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits). Even though some of the constraints are soft limits, hitting them can still have a significant negative effect on your data platform.

When you structure your data platform, consider the structure of your organization. Note the data ownership and functional responsibilities of your teams. If your organization gives teams large degrees of autonomy and distributed ownership, a data mesh architecture is your best option.

Avoid situations where different teams are responsible for various tasks of a solution—tasks such as ingestion, cleansing, aggregation, and serving. Depending on multiple teams can cause a dramatic loss of velocity. For example, if your data consumers on the serving layer need to onboard new data assets or implement functional changes for a particular data asset, they must go through a multi-step process. For this example, the steps are:

1. The data consumer submits a ticket to every team responsible for a data pipeline stage.
2. The teams must work together in sync because the layers are interconnected. The new services require changes to the data cleansing layer, which leads to changes in the data aggregation layer, which leads to changes in the serving layer. The changes can affect every pipeline stage.
3. It's difficult for the teams to see the potential effects of processing changes because they don't have an overview of the entire end-to-end lifecycle. They must work together to design a well-defined release plan that minimizes effects on existing consumers and pipelines. This dependency management increases management overhead.
4. As a rule, the teams aren't subject matter experts on the data asset that the data consumer requests. To understand new dataset features or parameter values, they have to consult an expert.
5. After all changes are implemented, the data consumer is notified that the new data asset is ready to use.

Each large organization has thousands of data consumers. A complicated process like the one described severely decreases velocity in large architectures since centralized teams become a bottleneck for business units. The result is less innovation and limited effectiveness. Potentially, business units can decide to leave the service and build their own data platform instead.

## Methods for scaling

:::image type="content" source="../images/high-level-design-multiple-landing-zones.png" alt-text="Diagram of data management landing zone and multiple data landing zones." lightbox="../images/high-level-design-multiple-landing-zones.png" border="false" :::

Cloud-scale analytics addresses scaling challenges by using two core concepts:

- Data landing zones for scaling
- Data products or data integrations for scaling, to make distributed and decentralized data ownership possible

You can deploy a single data landing zone or multiple ones. Data landing zones make it possible for you to discover and manage data by connecting to a data management landing zone. Each data management landing zone is within a single Azure subscription.

Subscriptions are Azure's units of management, billing, and scale. They play a critical role in your large-scale Azure adoption plan.

### Scaling with data landing zones

The central concepts of cloud-scale analytics are Microsoft Purview, Azure Databricks Unity Catalog if you're using Azure Databricks, a data management landing zone, and the data landing zone. You should place each in its own Azure subscription. Separating them lets you clearly separate duties, follow the least privilege principle, and partially address the subscription scale issues mentioned earlier. A minimal cloud-scale analytics setup includes a single data landing zone and a single data management landing zone.

However, a minimal setup isn't sufficient for large-scale data platform deployments. Companies build large-scale platforms and make investments to consistently and efficiently scale their data and analytics efforts over time. To overcome subscription-level limitations, cloud-scale analytics uses subscriptions as the unit of scaling, as discussed in [Azure landing zones](../../../ready/landing-zone/index.md). This technique makes it possible to increase the data platform footprint by adding more data landing zones to the architecture. Adopting this technique also addresses the problem of one Azure Data Lake Gen2 being used for a whole organization since each data landing zone includes three data lakes. Projects and activities from multiple domains can be distributed across more than one Azure subscription, thus providing greater scalability.

Decide how many data landing zones your organization requires before you implement a cloud-scale analytics architecture. Choosing the right solution establishes the foundation for an effective and efficient data platform.

The number of data landing zones required depends on many factors, especially:

- Organizational alignment, such as how many business units need their own data landing zone
- Operational considerations, such as how your organization aligns operational resources and resources that are specific to a business unit.

Using the right data landing zone model minimizes future efforts to move data products and data assets from one landing zone to another. It also helps you effectively and consistently scale big data and analytics efforts in the future.

Consider the following factors when you decide on the number of data landing zones to deploy.

| Factor | Description |
|--|--|
| Organizational structure and data ownership | Consider how your organization is structured and how data is owned in your organization. |
| Region and location | If you deploy in multiple regions, decide which regions should host the data zones. Be sure to honor all data residency requirements. |
| Quotas | Subscription quotas aren't capacity guarantees and are applied on a per-region basis. |
| Data sovereignty | Due to data sovereignty regulations, data must be stored in a specific region and follow region-specific policies. |
| Azure policies | Data landing zones must follow the requirements of various Azure policies. |
| Management boundary | Subscriptions provide a management boundary for governance and isolation that clearly separates concerns. |
| Networking | Each landing zone has a virtual network. Because a virtual network resides in a single region, each new region requires a new landing zone. The virtual networks must be peer virtual networks to enable cross-domain communication. |
| Limits | A subscription has limits. By having several subscriptions, you can mitigate the dangers of hitting these limits. |
| Cost allocation | Consider whether shared services like storage accounts that are paid centrally need to be split by business unit or domain. Using a separate subscription creates a boundary for cost allocation. You can achieve the same functionality by using tags. |
| Data classifications and highly confidential data | Security mechanisms can affect data product development and the usability of a data platform. Consider data classifications and decide whether highly confidential datasets require special treatment, like just-in-time access, customer-managed keys (CMK), fine-grained network controls, or more encryption. |
| Other legal or security implications | Consider whether there are any other legal or security requirements that require logical or physical separation of data. |

If you implement a data mesh architecture, consider the following factors as you decide how to distribute your data landing zones and data domains.

| Factor | Description |
|--|--|
| Data domains | Consider the data domains that your organization uses, and decide the data domains for your data platform. Consider the size of your individual data domains. For more information, see [What are data domains?](data-domains.md) |
| Latency | Domains that collaborate on large amounts of data can transfer a large amount of data across landing zones. Consider allocating your domains in the same landing zone or region. Separating them increases latency and can increase costs in cross-region domains. |
| Security | Some service deployments or configurations require elevated privileges in a subscription. Giving these privileges to a user in one domain implicitly gives that user the same privileges in other domains within the same subscription. |

You can find more considerations in the cloud adoption framework guidance for [subscriptions](../../../ready/landing-zone/design-area/resource-org-subscriptions.md).

Many organizations want efficient scaling of their enterprise data platform. Business units should be able to build their own data solutions and applications to meet their unique requirements. Providing this ability can be a challenge because many existing data platforms aren't built around the concepts of scalability and decentralized ownership. This shortcoming is clearly seen in the architecture, team structure, and ops model of these data platforms.

Data landing zones don't create data silos within your organization. The recommended network setup for cloud-scale analytics enables secure and in-place data sharing across landing zones, which in turn enables innovation across data domains and business units. To learn more, see [Network architecture considerations](../eslz-network-considerations-single-region.md).

The same is true for the identity layer. When you use a single Microsoft Entra tenant, you can grant identities access to data assets in multiple data landing zones. To learn more about the user and identity authorization process, see [Data access management](../../data-management/security-provisioning.md).

> [!NOTE]
> If you have multiple data landing zones, each zone can connect to data that's hosted in other zones. This allows groups to collaborate across your business.

Cloud-scale analytics uses a common architecture to advocate consistent governance. Your architecture defines baseline capabilities and policies. All data landing zones adhere to the same auditing and controls. Your teams can create data pipelines, ingest sources, and create data products like reports and dashboards. Teams can also do Spark/SQL analysis as needed. You can augment data landing zone capabilities by adding services to the capability in the policy. For example, a team can add a third-party graph engine to address a business requirement.

Cloud-scale analytics places a strong emphasis on central cataloging and classification to protect data and make it possible for various groups to discover data products.

> [!CAUTION]
> We recommend against querying data across regions. Instead, make sure that data is close to the compute that uses it, while respecting regional boundaries.

Cloud-scale analytics architecture and the concept of data landing zones make it possible for your organization to easily increase the size of your data platform over time. You can add more data landing zones in a phased approach. Your customers don't need to have multiple landing zones at first. When you adopt this architecture, prioritize a few data landing zones and the data products that they contain. Proper prioritization helps ensure the success of your cloud-scale analytics deployment.

### Scaling with data applications

Within each landing zone, your organization can scale by using data applications. Data applications are units or components of your data architecture that encapsulate functionality that provides read-optimized data products for consumption by other data applications. In Azure, data applications are environments in the form of resource groups that make it possible for cross-functional teams to implement data solutions and workloads. An associated team takes care of the end-to-end lifecycle of the data solution, which includes ingestion, cleansing, aggregation, and serving tasks.

Cloud-scale analytics addresses the data integration and responsibility issues that were discussed earlier. Instead of monolithic functional responsibilities for table ingestion and source system integration, the reference design provides a distributed architecture driven by data domains. Cross-functional teams take over the end-to-end functional responsibility and ownership for the data scope.

Instead of having a centralized technical stack, and a team that's responsible for all tasks of your data processing workflow, you can distribute end-to-end responsibility across multiple autonomous cross-functional data integration teams. Each team owns a domain or subdomain capability and is encouraged to serve datasets as required by data consumers.

These architectural differences lead to increased velocity on your data platform. Your data consumers no longer have to rely on a set of centralized teams or fight for their requested changes to be prioritized. As smaller teams take ownership of your end-to-end integration workflow, the feedback loop between data provider and data consumer is shorter. This approach results in faster prioritization, faster development cycles, and a more agile development process. Your teams no longer need to synchronize processes and release plans among themselves because the cross-functional data integration team has full awareness of the end-to-end technical stack and the implications of changes. It can use software engineering practices to run unit and integration tests to minimize the overall effect on consumers.

Ideally, the team that owns the data integration systems also owns the source systems. This team should consist of data engineers who work on the source systems, subject matter experts (SMEs) for the datasets, cloud engineers, and data product owners. Building this kind of cross-functional team reduces the amount of communication needed with outside teams and is essential while developing your complete stack from infrastructure to actual data pipelines.

The foundation of your data platform is datasets that are integrated from source systems. These datasets make it possible for your data product teams to innovate on business fact tables and to improve decision-making and business processes. Your data integration teams and data product teams should offer SLAs to consumers and ensure that all agreements are met. The offered SLAs can be related to data quality, timeliness, error rates, uptime, and other tasks.

## Summary

Using the scaling mechanisms of your cloud-scale analytics architecture allows your organization to expand its data estate within Azure over time while avoiding common technical limitations. Both of the scaling methods described in this article help you overcome different technical complexities and can be used in a simple and efficient way.

## Next steps
> [!div class="nextstepaction"]
> [Data standardization](data-standardization.md)