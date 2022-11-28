---
title: Scale cloud-scale analytics in Azure
description: Learn how to scale cloud-scale analytics in Azure and decide whether to use a single or multiple data landing zones when designing a scalable platform.
author: marvinbuss
ms.author: mabuss
ms.date: 03/31/2022
ms.topic: conceptual
ms.service: cloud-adoption-framework
ms.subservice: scenario
ms.custom: e2e-data-management, think-tank
---

# Scale cloud-scale analytics in Azure

A scalable data platform is critical for accommodating the rapid growth of data. Vast amounts of data are generated every second around the world. The amount of available data is expected to continue growing exponentially over the next few years. As the rate of data generation increases, the speed of data movement also increases.

No matter how large your amount of data becomes, your users will continue to demand fast query responses. They expect to wait minutes, not hours, for results. This article explains how you can scale your Azure cloud-scale analytics solution to meet user demands for speed.

## Introduction

Today, many enterprises have large data platform monoliths. These monoliths are built around a single Azure Data Lake Gen2 account, and sometimes a single storage container. A single Azure subscription is often used for all data platform related tasks. Subscription level scaling is absent in most architectural platforms, which can hinder continued Azure adoption if users run into any of the [Azure subscription or service-level limitations](/azure/azure-resource-manager/management/azure-subscription-service-limits). Even though some of the constraints are soft limits, hitting them can still have a significant negative effect within your data platform.

When structuring your data platform, you must also consider your organization's structure. Take special note of the data ownership and functional responsibilities of your teams. If your organization gives teams large degrees of autonomy and distributed ownership, a data mesh architecture is your best option.

Avoid giving several specialized teams within a single data platform ownership of an orthogonal solution like ingestion, cleansing, aggregation, or serving. Having dependency on multiple teams can cause a dramatic loss of velocity. For example, if your data consumers on the serving layer need to onboard new data assets or implement functional changes for a particular data asset, they must go through a multi-step process. For this example, the steps are:

1. Your data consumer must submit a ticket to your teams that are responsible for each data pipeline stage.

2. All involved teams must work together in sync as new ingestion services are required. These new services lead to changes in the data cleansing layer, which lead to changes in the data aggregation layer, which in turn lead to changes in the serving layer. The requested changes can affect every pipeline stage. No team can see the potential effects of processing changes, because there's no overview of the entire end-to-end lifecycle.

3. All involved teams must design a well-defined release plan together so they don't affect existing consumers and pipelines. This dependency management increases management overhead.

4. The involved teams are most often not subject matter experts on the specific data asset from your data consumer's request. To understand new dataset features or parameter values, they have to consult an expert.

5. Once all changes have finally been implemented, you need to notify your data consumer that their requested data asset is ready to be consumed.

Each large organization has thousands of data consumers, not just one. A complicated process like the one just described severely decreases velocity in large architectures, since centralized teams become a bottleneck for business units. This ultimately results in slower innovations, limited effectiveness, and potentially even individual business units deciding leave the service and build their own data platform instead.

## Methods for scaling

:::image type="content" source="../media/high-level-design-multiple-landing-zones.png" alt-text="Diagram of data management landing zone and multiple data landing zones.":::

> [!NOTE]
> The following diagram does not contain all Azure services. The diagram has been simplified to highlight the core concepts of resource organization within the architecture.

Cloud-scale analytics addresses the scaling challenges mentioned in the [introduction](#introduction) by using two core concepts:

- Scaling with data landing zones
- Scaling with data products or data integrations (allows distributed and decentralized data ownership)

A data landing zone allows you to deploy single or multiple data landing zones. Data landing zones allow you to discover and manage data by connecting to a data management landing zone. Each data management landing zone is within a single Azure subscription.

Subscriptions are Azure's units of management, billing, and scale. They play a critical role as you design your large-scale Azure adoption plan.

### Scaling with data landing zones

The central concepts of cloud-scale analytics are the data management landing zone and the data landing zone. You should place each of these in a separate Azure subscription. Separating them lets you clearly separate duties, follow the least privilege principle, and partially address the subscription scale issues issue mentioned in this article's [introduction](#introduction). A minimal cloud-scale analytics setup includes a single data landing zone and a single data management landing zone.

However, a minimal setup isn't sufficient for large-scale data platform deployments. Companies build these large-scale platforms and make investments to consistently and efficiently scale their data and analytics efforts over time. To overcome subscription-level limitations and embrace the "subscription as scale unit" concept from [Azure landing zones](../../../ready/landing-zone/index.md), cloud-scale analytics allows organizations to increase their data platform footprint by adding more data landing zones to their architecture. This also addresses the problem of one Azure Data Lake Gen2 being used for a whole organization, since data landing zone comes with a set of three Data Lakes. Projects and activities from multiple domains can be distributed across more than one Azure description, which allows greater scalability.

Discuss and define how many data landing zones your organization requires before you implement a cloud-scale analytics architecture. This is one of your most important design decisions, because it lays the foundation for you to build an effective and efficient data platform.

The number of data landing zones you need can be determined from multiple factors, particularly:

- organizational alignment (such as how many business units need their own data landing zone)

- operational considerations (such as how your organization's approaches the alignment of operation resources with business unit specific resources)

Using the right data landing zone model prevents enterprises from future migration projects of data products and data assets from one landing zone to another. It also lets you effectively and consistently scale any big data and analytics efforts in the future.

Consider the following factors when deciding the number of data landing zones you need to deploy.

| Factor                                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                |
|---------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Organizational structure and data ownership       | Consider how your organization is structured and how data is owned across your organization.                                                                                                                                                                                                                                                                                                                               |
| Region and location                                   | For multi-region data landing zone deployments, consider in which Azure region your data platform should be deployed, whether the platform should be hosted in a single region or span across several, and whether there are any data residency requirements that you must take into account.                                                                                                                                  |
| Quotas                                            | Subscription quotas aren't capacity guarantees and are applied on a per-region basis.                                                                                                                                                                                                                                                                                                                                        |
| Data sovereignty                                  | Due to data sovereignty regulations, data must be stored in a specific region and follow region specific policies.                                                                                                                                                                                                                                                                                                          |
| Azure policies                                    | Data landing zones must follow the requirements for different Azure policies.                                                                                                                                                                                                                                                                                                                                                             |
| Management boundary                               | Subscriptions provide a management boundary for governance and isolation, which clearly separates concerns.                                                                                                                                                                                                                                                                                                                                |
| Networking                                        | Each landing zone is provisioned with a virtual network. Since VNets are regionally bound, each new region requires a new landing zone. You must be peer VNets to enable cross domain communication.                                                                                                                                                                                                                             |
| Limits                                            | The scope of a single subscription scope has some limits. Splitting one subscription into several can mitigate your chances of hitting these limits.                                                                                                                                                                                                                                                                                    |
| Cost allocation                                   | Consider whether shared services like storage accounts paid centrally should be split by business unit or domain. Using a separate subscription creates a boundary for cost allocation. You can achieve the same functionality by using tags.                                                                                                                                                    |
| Data classifications and highly confidential data | These extra security mechanisms affect data product development and the usability of a data platform. Consider what data classifications exist, whether any datasets are classified as highly confidential, and if those datasets require special treatment, like Just in Time Access, customer managed keys (CMK), fine-grained network controls, or more encryption. |
| Other legal or security implications              | Consider if there are any other legal or security requirements that might require the logical and/or physical separation of data.                                                                                                                                                                                                                                                                            |

If you're implementing a data mesh architecture, you should also consider the following factors as you decide how to distribute your data landing zones and data domains.

| Factor       | Description                                                                                                                                                                                                                                                                                      |
|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Data domains | Consider which data domains your organization encompasses and which data domains will land on your data platform. Consider the size of your individual data domains. For information, see [What are data domains?](data-domains.md)                                                          |
| Latency      | Domains that collaborate on large amounts of data can transfer a large amount of data across landing zones. Consider allocating your domains in the same landing zone or region. Separating them increases latency and can increase cost in cross region domains. |
| Security     | Some service deployments or configurations require elevated privileges in a subscription. Giving these privileges to a user in one domain implicitly gives that user the same privileges in other domains within the same subscription.                                                             |

You can find more considerations in the cloud adoption framework guidance for [subscriptions](../../../ready/landing-zone/design-area/resource-org-subscriptions.md).

Many organizations desire efficient scaling within their enterprise data platform. Business units should be able to build their own data solutions and applications to fulfill their specific requirements. Providing this ability can be a challenge, because many existing data platforms aren't built around the concepts of scalability and decentralized ownership. This is clearly seen in these data platforms' underlying architecture, team structure, and ops model.

Data landing zones don't create data silos within your organization. The recommended network setup for cloud-scale analytics enables secure and in-place data sharing across landing zones, which in turn enables innovation across data domains and business units. To learn more, see [Network architecture considerations](../eslz-network-considerations-single-region.md).

The same is true for the identity layer. When you use a single Azure AD tenant, you can grant identities access to data assets in multiple data landing zones. To learn more about the actual user and identity authorization process, see [Data access management](../../data-management/security-provisioning.md).

> [!NOTE]
> If you have multiple data landing zones, each zone can connect to data hosted in other zones. This allows groups to collaborate across your business.

Cloud-scale analytics uses a common architecture to advocate consistent governance. Your architecture defines baseline capabilities and policies. All data landing zones adhere to the same auditing and controls. Your teams can create data pipelines, ingest sources, and create data products like reports and dashboards. Teams can also do Spark/SQL analysis as needed. You can augment data landing zone capabilities by adding services to the capability in the policy. For example, one of your teams might add a third-party graph engine to address a niche business requirement.

Cloud-scale analytics places a strong emphasis on central cataloging and classification to protect data and allow various groups to discover data products.

> [!CAUTION]
> We recommend against querying data across regions. Instead, make sure data is close to the compute while respecting regional boundaries.

Cloud-scale analytics architecture and the concept of data landing zones allow your organization to naturally increase your data platform's size over time. You can add more data landing zones in a phased approach. Your customers don't need to have multi-data landing zone setup right from the start. When adopting this architecture, prioritize a few data landing zones and the data products they should contain. This ensures your adoption of cloud-scale analytics is successful.

### Scaling with data products or data integrations

Within each landing zone, your organization can scale using data applications. Data applications are units or components of your data architecture that encapsulate functionality for making read-optimized data products available for consumption by other data applications. In Azure, data applications are environments in the form of resource groups and allow cross-functional teams to implement data solutions and workloads in your platform. An associated team takes care of their data solution's end-to-end lifecycle, which includes ingestion, cleansing, aggregation, and serving tasks for a particular data-domain, subdomain, dataset or project.

Cloud-scale analytics addresses the data integration and responsibility issue mentioned in the [introduction](#introduction). Instead of monolithic functional responsibilities for table ingestion and source system integration, the reference design provides a distributed, data domains driven architecture. In it, cross-functional teams take over the end-to-end functional responsibility and ownership for the data scope.

Instead of having a centralized technical stack and a team responsible for each individual orthogonal solution of your data processing workflow, you can distribute end-to-end responsibility across multiple autonomous cross-functional data integration teams. Each data integration team owns a domain or subdomain capability and is encouraged to serve datasets for team, for any purpose or project they're working on.

These architectural differences lead to increased velocity within your data platform. Your data consumers don't have to rely on a set of centralized teams anymore, or fight for the prioritization of their requested changes. As smaller teams take ownership of your end-to-end integration workflow, the feedback loop between data provider and data consumer is much shorter. This allows faster prioritization, faster development cycles, and a more agile development process. Your teams no longer need to come up with synchronization processes and release plans between themselves, because your cross-functional data integration team has full visibility of your end-to-end technical stack and any implications that might arise from implemented changes. This team can use software engineering practices to run unit and integration tests, which minimizes the overall effect on consumers.

Ideally, the same team owns both data integration and source systems. This team should consist of data engineers who work on your source systems, subject matter experts (SMEs) for your datasets, cloud engineers, and data product owners. Building this kind of cross-functional team reduces the amount of communication needed with outside teams, and is essential while developing your complete stack from infrastructure to actual data pipelines.

The foundation of your data platform is datasets integrated from source systems. These datasets enable your data product teams to innovate on business fact tables and improve decision making and business processes. Both your data integration teams and data product teams should offer SLAs to consumers and ensure that all agreements are met. The offered SLAs can be related to data quality, timeliness, error rates, uptime and other tasks.

## Summary

By using the scaling mechanisms within your cloud-scale analytics architecture, your organization can grow your data estate within Azure over time while avoiding well-known technical limitations. Both scaling methods described in this article help you overcome different technical complexities, and can be used in a simple and efficient way.

## Next steps

- [What is a data mesh?](what-is-data-mesh.md)
